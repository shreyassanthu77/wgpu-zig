import { fromFileUrl } from "jsr:@std/path";
import { parse } from "jsr:@std/yaml";
import { toCamelCase, toPascalCase, toSnakeCase } from "jsr:@std/text";
import type { Schema } from "./schema.ts";
import {
  asEnumTag,
  assert,
  docString,
  indent,
  typeName,
  zigFmt,
} from "./utils.ts";

async function main(webgpuYamlPath: string, format: boolean) {
  const webgpuYaml = await Deno.readTextFile(
    webgpuYamlPath,
    // fromFileUrl(import.meta.resolve("./webgpu.yaml")),
  );

  const schema = parse(webgpuYaml) as Schema;

  const output = [
    "// GENERATED FILE, DO NOT EDIT",
    docString(schema.copyright, true),
    " ",
    docString(
      `The c export is will give you direct access to the webgpu header`,
    ),
    'pub const c = @import("c");\n',
    'const std = @import("std");\n',
    `pub const StringView = extern struct { 
    data: [*c]const u8,
    length: usize,

		const empty = from("");

		const null_ = StringView{ .data = null_, .length = 0 };
    
    pub fn into(self: StringView) []const u8 {
        if (self.length == 0) return "";
        return self.data[0..self.length];
    }

		pub fn from(str: []const u8) StringView {
			return .{
				.data = str.ptr,
				.length = str.len,
			};
		}
};\n`,
  ];

  function add(str: string) {
    if (str === "") return;
    output.push(str);
  }

  for (const constant of schema.constants) {
    assert(
      constant.namespace === undefined,
      "TODO: implement namespaced constants",
    );

    const name = constant.name.toUpperCase();
    let value: string;

    switch (constant.value) {
      case "uint64_max":
        value = "std.math.maxInt(u64)";
        break;
      case "uint32_max":
        value = "std.math.maxInt(u32)";
        break;
      case "usize_max":
        value = "std.math.maxInt(usize)";
        break;
      default:
        value = constant.value.toString();
    }

    add(docString(constant.doc));
    add(`const ${name} = ${value};\n`);
  }

  assert(schema.typedefs.length === 0, "TODO: implement typedefs");

  let stype: (typeof schema.enums)[0];
  for (const enum_ of schema.enums) {
    if (!enum_.entries) continue;
    assert(
      enum_.namespace === undefined,
      "TODO: implement namespaced constants",
    );
    assert(!enum_.extended, "TODO: implement extended enums");

    if (enum_.name === "s_type") stype = enum_;

    const name = toPascalCase(enum_.name);
    if (enum_.doc) add(docString(enum_.doc));
    add(`pub const ${name} = enum(u32) {`);
    let i = 0;
    for (const entry of enum_.entries) {
      if (!entry) {
        i += 1;
        continue;
      }
      add(docString(entry.doc, 1));
      const name = asEnumTag(entry.name);
      if (!entry.value) {
        add(indent(`${name} = ${i},`, 1));
      } else {
        add(indent(`${name} = ${entry.value},`, 1));
      }
      i += 1;
    }
    add(indent(`_,`, 1));
    add(`};\n`);
  }

  for (const bitflag of schema.bitflags) {
    if (!bitflag.entries) continue;
    assert(
      bitflag.namespace === undefined,
      "TODO: implement namespaced bitflags",
    );
    assert(!bitflag.extended, "TODO: implement extended bitflags");

    const bitflag_name = toPascalCase(bitflag.name);
    if (bitflag.doc) add(docString(bitflag.doc));

    add(`pub const ${bitflag_name} = enum(u64) {`);
    const entryMap = new Map<
      string,
      {
        value: string;
        used: boolean;
      }
    >();
    let i = 0;
    for (const entry of bitflag.entries) {
      if (entry.value) {
        let value: string;
        switch (entry.value) {
          case "uint32_max":
            value = "std.math.maxInt(u32)";
            break;
          case "uint64_max":
            value = "std.math.maxInt(u64)";
            break;
          case "usize_max":
            value = "std.math.maxInt(usize)";
            break;
          default:
            value = entry.value.toString();
        }

        entryMap.set(entry.name, { value, used: false });
      }
      if (!entry.value && !entry.value_combination) {
        entryMap.set(entry.name, { value: (i++).toString(), used: false });
      }
    }

    for (const entry of bitflag.entries) {
      if (entry.value_combination) {
        for (const sub of entry.value_combination!) {
          const v = entryMap.get(sub)!;
          v.used = true;
        }
      }
    }

    for (const [key, { value, used }] of entryMap) {
      if (!used) continue;
      const name = toPascalCase(key);
      add(indent(`const ${name} = ${value};\n`, 1));
    }
    add("\n");

    for (const entry of bitflag.entries) {
      const name = asEnumTag(entry.name);
      const v = entryMap.get(entry.name)!;

      add(docString(entry.doc, 1));
      if (v) {
        let value: string;
        if (v.used) {
          value = toPascalCase(entry.name);
        } else {
          value = v.value;
        }
        add(indent(`${name} = ${value},`, 1));
      } else if (entry.value_combination) {
        const value = entry
          .value_combination!.map((v) => toPascalCase(v))
          .join(` | `);
        add(indent(`${name} = ${value},`, 1));
      }
    }

    add(indent(`_,`, 1));
    add(`};\n`);
  }

  add(`pub const Chained = extern struct {
	next: ?*const Chained,
	s_type: SType,

`);
  add(`};\n`);

  assert(stype! !== undefined, "TODO: implement stype");
  const sTypeMap = new Map<string, string>();
  for (const entry of stype.entries!) {
    if (!entry) continue;
    sTypeMap.set(toPascalCase(entry.name), entry.name);
  }

  for (const struct of schema.structs) {
    assert(struct.members !== undefined, "Structs must have members");
    assert(
      struct.namespace === undefined,
      "TODO: implement namespaced structs",
    );
    const name = toPascalCase(struct.name);
    if (!struct.members) continue;
    add(`pub const ${name} = extern struct {`);
    if (
      struct.type === "base_in" ||
      struct.type === "base_out" ||
      struct.type === "base_in_or_out"
    ) {
      add(indent(`next_in_chain: ?*const Chained = null,`, 1));
    } else if (
      struct.type === "extension_in" ||
      struct.type === "extension_out" ||
      struct.type === "extension_in_or_out"
    ) {
      add(indent(`chain: Chained,`, 1));
    }
    for (const member of struct.members) {
      const name = toSnakeCase(member.name);
      const [type, isArray] = typeName(
        member.type,
        member.pointer,
        member.optional,
      );
      if (isArray) {
        add(indent(`${name}_count: usize = 0,`, 1));
      }
      add(indent(`${name}: ${type},`, 1));
    }

    add(" ");
    add(
      indent(
        `pub inline fn zero() ${name} { return std.mem.zeroes(${name}); }`,
        1,
      ),
    );

    if (struct.free_members) {
      const externName = toCamelCase("wgpu_" + name + "_free_members");
      add(
        indent(`extern fn ${externName}(self: ${name}) callconv(.c) void;`, 1),
      );
      add(
        indent(
          `pub inline fn freeMembers(self: ${name}) void { return ${externName}(self); }`,
          1,
        ),
      );
    }

    const parent = toPascalCase(struct.extends?.[0] ?? "");
    if (
      (struct.type === "extension_in" ||
        struct.type === "extension_out" ||
        struct.type === "extension_in_or_out") &&
      parent &&
      sTypeMap.has(name)
    ) {
      const sType = asEnumTag(sTypeMap.get(name)!);
      add(` `);

      const optionsName = toPascalCase(name + "_init_options");
      const initBody: string[] = [];

      add(indent(`pub const ${optionsName} = struct {`, 1));
      add(indent(`label: []const u8 = "",`, 2));
      for (const member of struct.members) {
        const name = toSnakeCase(member.name);
        const [type, isArray] = typeName(
          member.type,
          member.pointer,
          member.optional,
        );
        assert(!isArray, "TODO: implement array init");
        if (type.startsWith("StringView")) {
          const defaultValue =
            type.split("=")?.[1].trim() === ".empty" ? '""' : "undefined";
          add(indent(`${name}: []const u8 = ${defaultValue},`, 2));
          initBody.push(`.${name} = .from(options.${name})`);
        } else {
          add(indent(`${name}: ${type},`, 2));
          initBody.push(`.${name} = options.${name}`);
        }
      }
      initBody.push(`.chain = .{ .s_type = .${sType}, .next = null }`);
      add(indent(`};`, 1));

      add(
        indent(
          `pub inline fn init(options: ${optionsName}) *const ${parent} {
		return &${parent}{
			.label = .from(options.label),
			.next_in_chain = @ptrCast(&${name}{
        ${initBody.join(",\n        ")},
    	}),
		};
}`,
          1,
        ),
      );
    }

    add(`};\n`);
  }

  for (const callback of schema.callbacks) {
    assert(
      callback.namespace === undefined,
      "TODO: implement namespaced callbacks",
    );
    const name = toPascalCase(callback.name) + "Callback";
    add(docString(callback.doc, 1));
    const args = callback.args?.map((arg) => {
      const name = asEnumTag(arg.name);
      const [type, _] = typeName(arg.type, arg.pointer, arg.optional, null);
      return `${name}: ${type}`;
    });
    add(
      `pub const ${name} = *const fn (${args?.join(", ")}, userdata1: ?*anyopaque, userdata2: ?*anyopaque) callconv(.c) void;`,
    );
    add(`pub const ${name}Info = extern struct {`);
    add(indent(`next_in_chain: ?*const Chained = null,`, 1));
    if (callback.style === "callback_mode") {
      add(indent(`mode: CallbackMode = .allow_process_events,`, 1));
    }
    add(indent(`callback: ${name},`, 1));
    add(indent(`userdata1: ?*anyopaque = null,`, 1));
    add(indent(`userdata2: ?*anyopaque = null,`, 1));

    add(" ");
    add(indent(`pub const State = struct {`, 1));
    add(indent(args!.join(",\n"), 2));
    add(indent(`};`, 1));
    add(
      indent(
        `pub fn default(${args!.join(", ")}, userdata1: ?*anyopaque, userdata2: ?*anyopaque) callconv(.c) void {
	_ = userdata2;
	const state_ptr: *State = @ptrCast(@alignCast(userdata1.?));
	state_ptr.* = .{`,
        1,
      ),
    );
    for (const arg of callback.args!) {
      const name = asEnumTag(arg.name);
      add(indent(`.${name} = ${name},`, 3));
    }
    add(indent(`};`, 2));
    add(indent(`}`, 1));
    add(`};\n`);
  }

  for (const func of schema.functions) {
    assert(func.namespace === undefined, "TODO: implement namespaced objects");
    assert(!!func.name, "TODO: implement unnamed objects");
    const name = toCamelCase(func.name);
    const externName = toCamelCase("wgpu_" + func.name);
    if (func.args === undefined) func.args = [];
    const args = func.args
      ?.map((arg) => {
        const name = toCamelCase(arg.name);
        const [type, _] = typeName(arg.type, arg.pointer, arg.optional, null);
        return `${name}: ${type}`;
      })
      .join(", ");

    const returnType = func.returns?.type
      ? typeName(func.returns?.type, func.returns?.pointer, undefined, null)[0]
      : "void";
    add(docString(func.doc));
    add(`extern fn ${externName}(${args}) callconv(.c) ${returnType};`);
    add(`pub const ${name} = ${externName};`);
  }
  add("\n");

  for (const object of schema.objects) {
    assert(
      object.namespace === undefined,
      "TODO: implement namespaced objects",
    );
    assert(!object.extended, "TODO: implement extended objects");
    assert(!!object.name, "TODO: implement unnamed objects");
    const obj_name = toPascalCase(object.name);
    add(`pub const ${obj_name} = opaque {`);
    if (object.methods) {
      if (!object.extended) {
        object.methods.push(
          { name: "add_ref", doc: "TODO", namespace: object.namespace },
          { name: "release", doc: "TODO", namespace: object.namespace },
        );
      }
      const fn_prefix = `wgpu_${obj_name}_`;
      for (const method of object.methods) {
        const name = toCamelCase(method.name);
        const externName = toCamelCase(fn_prefix + method.name);
        const argNames: string[] = [];
        const args =
          method.args?.map((arg) => {
            const name = toCamelCase(arg.name);
            const [type, _] = typeName(
              arg.type,
              arg.pointer,
              arg.optional,
              null,
            );
            argNames.push(name);
            return `${name}: ${type}`;
          }) ?? [];
        if (method.callback) {
          const [type, _] = typeName(
            method.callback,
            undefined,
            undefined,
            null,
          );
          argNames.push("callback");
          args.push(`callback: ${type}`);
        }

        const returnType = method.returns?.type
          ? typeName(
              method.returns?.type,
              method.returns?.pointer,
              undefined,
              null,
            )[0]
          : method.callback
            ? "Future"
            : "void";

        add(
          indent(
            `extern fn ${externName}(self: *${obj_name}${args.length > 0 ? ", " : ""}${args.join(", ")}) callconv(.c) ${returnType};`,
            1,
          ),
        );

        add(docString(method.doc, 1));
        add(
          indent(
            `pub inline fn ${name}(self: *${obj_name}${args.length > 0 ? ", " : ""}${args.join(", ")}) ${returnType} { return ${externName}(self${args.length > 0 ? ", " : ""}${argNames.join(", ")}); }`,
            1,
          ),
        );

        if (method.callback) {
          const syncName = toCamelCase(name + "_sync");
          const syncArgs = args.slice(0, args.length - 1);
          const syncArgNames = argNames.slice(0, argNames.length - 1);
          syncArgNames.push("callback_info");
          const [type, _] = typeName(
            method.callback,
            undefined,
            undefined,
            null,
          );
          add(
            indent(
              `pub inline fn ${syncName}(self: *${obj_name}${syncArgs.length > 0 ? ", " : ""}${syncArgs.join(", ")}) ${type}.State { 
	var state: ${type}.State = undefined;
	const callback_info: ${type} = .{
		.callback = ${type}.default,
		.userdata1 = @ptrCast(&state),
	};
	${returnType !== "void" ? "_ = " : ""}${externName}(self${syncArgNames.length > 0 ? ", " : ""}${syncArgNames.join(", ")}); 
	return state;
}`,
              1,
            ),
          );
        }
      }
    }
    add(`};\n`);
  }

  if (format) {
    const formatted = await zigFmt(output.join("\n"));
    await Deno.writeTextFile(
      fromFileUrl(import.meta.resolve("../src/root.zig")),
      formatted,
    );
  } else {
    await Deno.writeTextFile(
      fromFileUrl(import.meta.resolve("../src/root.zig")),
      output.join("\n"),
    );
  }
}

if (import.meta.main) {
  const args = Deno.args;
  if (args.length < 1) {
    console.log(args);
    console.error(
      "Usage: deno --allow-read --allow-write gen.ts <webgpu.yaml>",
    );
    Deno.exit(1);
  }

  const webgpuYamlPath = args[0];
  const format =
    args.length >= 2 && args.slice(1).some((arg) => arg === "--format");

  await main(webgpuYamlPath, format);
}
