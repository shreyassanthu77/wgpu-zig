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
  | "nullable_float32"
  | "float64"
  | "float64_supertype"
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
  enum_prefix: number;
  doc?: string;
  typedefs: {
    name: Name;
    /**
     * Optional property, specifying the namespace where this typedef is defined
     */
    namespace?: string;
    doc?: string;
    type: PrimitiveType;
  }[];
  constants: {
    /**
     * Name of the constant variable/define
     */
    name: string;
    /**
     * Optional property, specifying the namespace where this constant is defined
     */
    namespace?: string;
    /**
     * An enum of predefined max constants or a 64-bit unsigned integer, or float NaN value.
     */
    value: number | ("usize_max" | "uint32_max" | "uint64_max" | "nan");
    doc?: string;
  }[];
  enums: {
    /**
     * Name of the enum
     */
    name: string;
    /**
     * Optional property, specifying the namespace where this enum is defined
     */
    namespace?: string;
    doc?: string;
    /**
     * Optional property, an indicator that this enum is an extension of an already present enum
     */
    extended?: boolean;
    entries?: (null | {
      /**
       * Name of the enum entry
       */
      name: string;
      /**
       * Optional property, specifying the namespace where this enum entry is defined
       */
      namespace?: string;
      doc?: string;
      /**
       * Optional property, a 16-bit unsigned integer
       */
      value?: number;
    })[];
  }[];
  bitflags: {
    /**
     * Name of the bitflag
     */
    name: string;
    /**
     * Optional property, specifying the namespace where this bitflag is defined
     */
    namespace?: string;
    doc?: string;
    /**
     * Optional property, an indicator that this bitflag is an extension of an already present bitflag
     */
    extended?: boolean;
    entries?: {
      /**
       * Name of the bitflag entry
       */
      name: string;
      /**
       * Optional property, specifying the namespace where this bitmask entry is defined
       */
      namespace?: string;
      doc?: string;
      /**
       * Optional property, a 64-bit unsigned integer
       */
      value?: number | ("usize_max" | "uint32_max" | "uint64_max" | "nan");
      /**
       * Optional property, an array listing the names of bitflag entries to be OR-ed
       */
      value_combination?: Name[];
    }[];
  }[];
  structs: {
    /**
     * Name of the structure
     */
    name: string;
    /**
     * Optional property, specifying the namespace where this struct is defined
     */
    namespace?: string;
    doc?: string;
    /**
     * Type of the structure
     */
    type: "extensible" | "extensible_callback_arg" | "extension" | "standalone";
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
  }[];
  callbacks: Callback[];
  functions: Function[];
  objects: {
    /**
     * Name of the object
     */
    name?: string;
    /**
     * Optional property, specifying the namespace where this object is defined
     */
    namespace?: string;
    doc?: string;
    /**
     * Optional property, an indicator that this object is an extension of an already present object
     */
    extended?: boolean;
    methods?: Function[];
  }[];
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
   * Whether the value is passed with ownership or without ownership
   */
  passed_with_ownership?: boolean;
  /**
   * Optional property, specifies if a parameter type is a pointer
   */
  pointer?: "immutable" | "mutable";
  /**
   * Optional property, to indicate if a parameter is optional
   */
  optional?: boolean;
  /**
   * Default value assigned to this parameter when using initializer macro. Special context-dependent values include constant names (`constant.*`), bitflag names (unprefixed), and `zero` for struct-zero-init (where zero-init is known to have the desired result).
   */
  default?: string | number | boolean;
}
export interface Callback {
  /**
   * Callback name
   */
  name: string;
  /**
   * Optional property, specifying the namespace where this callback is defined
   */
  namespace?: string;
  doc: string;
  /**
   * Callback style
   */
  style: "callback_mode" | "immediate";
  /**
   * Optional property, list of callback arguments
   */
  args?: FunctionParameterType[];
}
export interface Function {
  /**
   * Name of the function
   */
  name: string;
  /**
   * Optional property, specifying the namespace where this function is defined
   */
  namespace?: string;
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
     * Indicates if the return type is optional/nullable
     */
    optional?: boolean;
    /**
     * Whether the value is passed with ownership or without ownership
     */
    passed_with_ownership?: boolean;
    /**
     * Optional property, specifies if a method return type is a pointer
     */
    pointer?: "immutable" | "mutable";
  };
  /**
   * Optional property, callback type for async functon
   */
  callback?: string;
  /**
   * Optional property, list of function arguments
   */
  args?: FunctionParameterType[];
}
