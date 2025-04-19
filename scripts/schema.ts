export type Name = string;
export type PrimitiveType =
  | "c_void"
  | "bool"
  | "nullable_string"
  | "string_with_default_empty"
  | "out_string"
  | "uint16"
  | "uint32"
  | "uint64"
  | "usize"
  | "int16"
  | "int32"
  | "float32"
  | "float64"
  | "array<bool>"
  | "array<string>"
  | "array<uint16>"
  | "array<uint32>"
  | "array<uint64>"
  | "array<usize>"
  | "array<int16>"
  | "array<int32>"
  | "array<float32>"
  | "array<float64>";
export type ComplexType = string;
export type CallbackType = string;
export type FunctionParameterType = ParameterType & {
  doc?: string;
  [k: string]: unknown;
};

export interface Schema {
  /**
   * The license string to include at the top of the generated header
   */
  copyright: string;
  /**
   * The name/namespace of the specification
   */
  name: string;
  /**
   * The dedicated enum prefix for the implementation specific header to avoid collisions
   */
  enum_prefix: string;
  typedefs: {
    name: Name;
    doc: string;
    type: PrimitiveType;
    [k: string]: unknown;
  }[];
  constants: {
    /**
     * Name of the constant variable/define
     */
    name: string;
    /**
     * An enum of predefined max constants or a 64-bit unsigned integer
     */
    value: number | ("usize_max" | "uint32_max" | "uint64_max");
    doc: string;
    [k: string]: unknown;
  }[];
  enums: {
    /**
     * Name of the enum
     */
    name: string;
    doc: string;
    /**
     * Optional property, an indicator that this enum is an extension of an already present enum
     */
    extended?: boolean;
    entries?: (null | {
      /**
       * Name of the enum entry
       */
      name: string;
      doc: string;
      /**
       * Optional property, a 16-bit unsigned integer
       */
      value?: number;
      [k: string]: unknown;
    })[];
    [k: string]: unknown;
  }[];
  bitflags: {
    /**
     * Name of the bitflag
     */
    name: string;
    doc: string;
    /**
     * Optional property, an indicator that this bitflag is an extension of an already present bitflag
     */
    extended?: boolean;
    entries?: {
      /**
       * Name of the bitflag entry
       */
      name: string;
      doc: string;
      /**
       * Optional property, a 64-bit unsigned integer
       */
      value?: number | ("usize_max" | "uint32_max" | "uint64_max");
      /**
       * Optional property, an array listing the names of bitflag entries to be OR-ed
       */
      value_combination?: Name[];
      [k: string]: unknown;
    }[];
    [k: string]: unknown;
  }[];
  structs: {
    /**
     * Name of the structure
     */
    name: string;
    doc: string;
    /**
     * Type of the structure
     */
    type:
      | "base_in"
      | "base_out"
      | "base_in_or_out"
      | "extension_in"
      | "extension_out"
      | "extension_in_or_out"
      | "standalone";
    /**
     * Optional property, list of names of the structs that this extension structure extends
     */
    extends?: string[];
    /**
     * Optional property, to indicate if a free members function be emitted for the struct
     */
    free_members?: boolean;
    /**
     * Optional property, list of struct members
     */
    members?: ParameterType[];
    [k: string]: unknown;
  }[];
  callbacks: Callback[];
  functions: Function[];
  objects: {
    /**
     * Name of the object
     */
    name?: string;
    doc?: string;
    /**
     * Optional property, an indicator that this object is an extension of an already present object
     */
    extended?: boolean;
    /**
     * Optional property, specifying the external namespace where this object is defined
     */
    namespace?: string;
    methods?: Function[];
    [k: string]: unknown;
  }[];
  [k: string]: unknown;
}
export interface ParameterType {
  /**
   * Parameter name
   */
  name: string;
  doc: string;
  /**
   * Parameter type
   */
  type: PrimitiveType | ComplexType | CallbackType;
  /**
   * Ownership of the value
   */
  ownership?: "with" | "without";
  /**
   * Optional property, specifies if a parameter type is a pointer
   */
  pointer?: "immutable" | "mutable";
  /**
   * Optional property, to indicate if a parameter is optional
   */
  optional?: boolean;
  /**
   * Optional property, specifying the external namespace where this type is defined
   */
  namespace?: string;
  [k: string]: unknown;
}
export interface Callback {
  /**
   * Callback name
   */
  name: string;
  doc: string;
  /**
   * Callback style
   */
  style: "callback_mode" | "immediate";
  /**
   * Optional property, list of callback arguments
   */
  args?: FunctionParameterType[];
  [k: string]: unknown;
}
export interface Function {
  /**
   * Name of the function
   */
  name: string;
  doc: string;
  /**
   * Optional property, return type of the function
   */
  returns?: {
    doc: string;
    /**
     * Return type of the function
     */
    type: PrimitiveType | ComplexType | CallbackType;
    /**
     * Whether the value is passed with ownership or without ownership
     */
    passed_with_ownership?: boolean;
    /**
     * Optional property, specifies if a method return type is a pointer
     */
    pointer?: "immutable" | "mutable";
    [k: string]: unknown;
  };
  /**
   * Optional property, callback type for async functon
   */
  callback?: string;
  /**
   * Optional property, list of function arguments
   */
  args?: FunctionParameterType[];
  [k: string]: unknown;
}
