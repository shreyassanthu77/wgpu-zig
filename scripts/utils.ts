import { toPascalCase, toSnakeCase } from "jsr:@std/text";
import { ParameterType, PrimitiveType } from "./schema.ts";

export function docString(doc?: string, indent?: number): string;
export function docString(doc?: string, global?: boolean): string;
export function docString(
  doc?: string,
  globalOrIndent: number | boolean = false,
): string {
  if (doc?.startsWith("TODO")) return "";
  let global = false;
  let indent = 0;

  if (typeof globalOrIndent === "number") {
    indent = globalOrIndent;
  } else if (globalOrIndent === true) {
    global = true;
  }

  const comment_prefix = global ? "//! " : "/// ";
  const indent_str = indent ? "    ".repeat(indent) : "";
  const prefix = indent_str + comment_prefix;

  return prefix + (doc?.trim().replaceAll("\n", `\n${prefix}`) ?? "");
}

export function indent(str: string, indent: number): string {
  const indent_str = "    ".repeat(indent);
  return indent_str + str.trim().replaceAll("\n", `\n${indent_str}`);
}

export function asEnumTag(name: string): string {
  switch (name) {
    case "error":
      return '@"error"';
    case "type":
      return "typ";
    case "opaque":
      return '@"opaque"';
    default: {
      const first = name.charCodeAt(0);
      // check if the first character is a digit
      if (first >= 48 && first <= 57) {
        return `@"${name}"`;
      }
      return toSnakeCase(name);
    }
  }
}

export function typeName(
  type: string,
  pointer_type?: ParameterType["pointer"],
  optional: boolean = false,
  default_value?: string | number | boolean | null,
): [string, boolean] {
  let isPointer = pointer_type !== undefined;
  let constPointer = pointer_type === "immutable";

  switch (type as PrimitiveType) {
    case "c_void":
      if (isPointer) {
        type = "anyopaque";
      } else {
        type = "void";
      }
      break;
    case "bool":
      type = "bool";
      break;
    case "uint64":
      type = "u64";
      break;
    case "uint32":
      type = "u32";
      break;
    case "uint16":
      type = "u16";
      break;
    case "int32":
      type = "i32";
      break;
    case "int16":
      type = "i16";
      break;
    case "float32":
      type = "f32";
      break;
    case "float64":
      type = "f64";
      break;
    // case "float64_supertype":
    //   type = "f64";
    //   break;
    // case "nullable_float32":
    //   optional = true;
    //   type = "f32";
    //   if (default_value !== null) default_value = "null";
    //   break;
    case "string_with_default_empty":
      type = "StringView";
      if (default_value !== null) default_value = ".empty";
      break;
    case "nullable_string":
      type = "StringView";
      optional = true;
      if (default_value !== null) default_value = "null";
      break;
    case "out_string":
      type = "StringView";
      break;
  }

  let isArray = false;
  if (type.startsWith("enum.")) {
    type = toPascalCase(type.slice(5));
  } else if (type.startsWith("struct.")) {
    type = toPascalCase(type.slice(7));
  } else if (type.startsWith("array<")) {
    type = type.slice(6, -1);
    type = `[*]${constPointer ? "const" : ""} ${typeName(type, undefined, false, null)[0]}`;
    optional = true;
    isPointer = false;
    constPointer = false;
    isArray = true;
  } else if (type.startsWith("object.")) {
    type = toPascalCase(type.slice(6));
    isPointer = true;
    constPointer = false;
  } else if (type.startsWith("bitflag.")) {
    type = toPascalCase(type.slice(7));
  } else if (type.startsWith("callback.")) {
    type = toPascalCase(type.slice(8)) + "CallbackInfo";
  }

  if (isPointer) {
    if (constPointer) {
      type = `*const ${type}`;
    } else {
      type = `*${type}`;
    }
  }

  if (optional) {
    type = `?${type}`;
  }

  if (default_value !== null && default_value !== undefined) {
    if (typeof default_value === "string") {
      if (default_value == '""') {
        type = `${type} = ""`;
      } else if (default_value.startsWith("constant.")) {
        const constant = default_value.slice(9);
        type = `${type} = ${constant.toUpperCase()}`;
      } else if (default_value === "undefined") {
        type = `${type} = ${default_value}`;
      } else {
        type = `${type} = .${asEnumTag(default_value)}`;
      }
    } else {
      type = `${type} = ${default_value}`;
    }
  } else if (default_value === undefined) {
    if (optional) {
      type = `${type} = null`;
    } else if (type !== "*anyopaque") {
      type = `${type} = std.mem.zeroes(${type})`;
    }
  }

  return [type, isArray];
}

export function assert(cond: unknown, msg: string): asserts cond {
  if (!cond) {
    console.error(msg);
    Deno.exit(1);
  }
}

export async function zigFmt(input: string): Promise<string> {
  const cmd = new Deno.Command("zig", {
    args: ["fmt", "--stdin"],
    stdin: "piped",
    stdout: "piped",
    stderr: "piped",
  });
  const child = cmd.spawn();
  const writer = child.stdin.getWriter();
  await writer.write(new TextEncoder().encode(input));
  await writer.close();
  const { stdout, stderr, success, code } = await child.output();
  if (!success) {
    console.error(new TextDecoder().decode(stderr));
    Deno.exit(code);
  }
  return new TextDecoder().decode(stdout);
}
