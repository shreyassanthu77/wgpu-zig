// GENERATED FILE, DO NOT EDIT
//! Copyright 2019-2023 WebGPU-Native developers
//! 
//! SPDX-License-Identifier: BSD-3-Clause
//! **Important:** *This documentation is a Work In Progress.*
//! 
//! This is the home of WebGPU C API specification. We define here the standard
//! `webgpu.h` header that all implementations should provide.
//! 
//! For all details where behavior is not otherwise specified, `webgpu.h` has
//! the same behavior as the WebGPU specification for JavaScript on the Web.
//! The WebIDL-based Web specification is mapped into C as faithfully (and
//! bidirectionally) as practical/possible.
//! The working draft of WebGPU can be found at <https://www.w3.org/TR/webgpu/>.
//! 
//! The standard include directive for this header is `#include <webgpu/webgpu.h>`
//! (if it is provided in a system-wide or toolchain-wide include directory).
const std = @import("std");

pub const StringView = extern struct { 
    data: [*c]const u8,
    length: usize,
    
    pub fn into(self: StringView) []const u8 {
        if (self.length == 0) return "";
        return self.data[0..self.length];
    }
};

const ARRAY_LAYER_COUNT_UNDEFINED = std.math.maxInt(u32);

const COPY_STRIDE_UNDEFINED = std.math.maxInt(u32);

/// Value to be assigned to member depthClearValue of @ref WGPURenderPassDepthStencilAttachment
/// to mean that it is not defined.
const DEPTH_CLEAR_VALUE_UNDEFINED = std.math.nan(f32);

const DEPTH_SLICE_UNDEFINED = std.math.maxInt(u32);

const LIMIT_U32_UNDEFINED = std.math.maxInt(u32);

const LIMIT_U64_UNDEFINED = std.math.maxInt(u64);

const MIP_LEVEL_COUNT_UNDEFINED = std.math.maxInt(u32);

const QUERY_SET_INDEX_UNDEFINED = std.math.maxInt(u32);

const WHOLE_MAP_SIZE = std.math.maxInt(usize);

const WHOLE_SIZE = std.math.maxInt(u64);

pub const AdapterType = enum(u32) {
    discrete_gpu,
    integrated_gpu,
    cpu,
    unknown,
};

pub const AddressMode = enum(u32) {
    /// Indicates no value is passed for this argument. See @ref SentinelValues.
    undefined,
    clamp_to_edge,
    repeat,
    mirror_repeat,
};

pub const BackendType = enum(u32) {
    /// Indicates no value is passed for this argument. See @ref SentinelValues.
    undefined,
    null,
    web_gpu,
    d_3_d_11,
    d_3_d_12,
    metal,
    vulkan,
    open_gl,
    open_gles,
};

pub const BlendFactor = enum(u32) {
    /// Indicates no value is passed for this argument. See @ref SentinelValues.
    undefined,
    zero,
    one,
    src,
    one_minus_src,
    src_alpha,
    one_minus_src_alpha,
    dst,
    one_minus_dst,
    dst_alpha,
    one_minus_dst_alpha,
    src_alpha_saturated,
    constant,
    one_minus_constant,
    src_1,
    one_minus_src_1,
    src_1_alpha,
    one_minus_src_1_alpha,
};

pub const BlendOperation = enum(u32) {
    /// Indicates no value is passed for this argument. See @ref SentinelValues.
    undefined,
    add,
    subtract,
    reverse_subtract,
    min,
    max,
};

pub const BufferBindingType = enum(u32) {
    /// Indicates that this @ref WGPUBufferBindingLayout member of
    /// its parent @ref WGPUBindGroupLayoutEntry is not used.
    /// (See also @ref SentinelValues.)
    binding_not_used,
    /// `1`. Indicates no value is passed for this argument. See @ref SentinelValues.
    undefined,
    uniform,
    storage,
    read_only_storage,
};

pub const BufferMapState = enum(u32) {
    unmapped,
    pending,
    mapped,
};

/// The callback mode controls how a callback for an asynchronous operation may be fired. See @ref Asynchronous-Operations for how these are used.
pub const CallbackMode = enum(u32) {
    /// Callbacks created with `WGPUCallbackMode_WaitAnyOnly`:
    /// - fire when the asynchronous operation's future is passed to a call to @ref wgpuInstanceWaitAny
    ///   AND the operation has already completed or it completes inside the call to @ref wgpuInstanceWaitAny.
    wait_any_only,
    /// Callbacks created with `WGPUCallbackMode_AllowProcessEvents`:
    /// - fire for the same reasons as callbacks created with `WGPUCallbackMode_WaitAnyOnly`
    /// - fire inside a call to @ref wgpuInstanceProcessEvents if the asynchronous operation is complete.
    allow_process_events,
    /// Callbacks created with `WGPUCallbackMode_AllowSpontaneous`:
    /// - fire for the same reasons as callbacks created with `WGPUCallbackMode_AllowProcessEvents`
    /// - **may** fire spontaneously on an arbitrary or application thread, when the WebGPU implementations discovers that the asynchronous operation is complete.
    /// 
    ///   Implementations _should_ fire spontaneous callbacks as soon as possible.
    /// 
    /// @note Because spontaneous callbacks may fire at an arbitrary time on an arbitrary thread, applications should take extra care when acquiring locks or mutating state inside the callback. It undefined behavior to re-entrantly call into the webgpu.h API if the callback fires while inside the callstack of another webgpu.h function that is not `wgpuInstanceWaitAny` or `wgpuInstanceProcessEvents`.
    allow_spontaneous,
};

pub const CompareFunction = enum(u32) {
    /// Indicates no value is passed for this argument. See @ref SentinelValues.
    undefined,
    never,
    less,
    equal,
    less_equal,
    greater,
    not_equal,
    greater_equal,
    always,
};

pub const CompilationInfoRequestStatus = enum(u32) {
    success,
    /// See @ref CallbackStatuses.
    callback_cancelled,
};

pub const CompilationMessageType = enum(u32) {
    @"error",
    warning,
    info,
};

/// Describes how frames are composited with other contents on the screen when @ref wgpuSurfacePresent is called.
pub const CompositeAlphaMode = enum(u32) {
    /// Lets the WebGPU implementation choose the best mode (supported, and with the best performance) between @ref WGPUCompositeAlphaMode_Opaque or @ref WGPUCompositeAlphaMode_Inherit.
    auto,
    /// The alpha component of the image is ignored and teated as if it is always 1.0.
    @"opaque",
    /// The alpha component is respected and non-alpha components are assumed to be already multiplied with the alpha component. For example, (0.5, 0, 0, 0.5) is semi-transparent bright red.
    premultiplied,
    /// The alpha component is respected and non-alpha components are assumed to NOT be already multiplied with the alpha component. For example, (1.0, 0, 0, 0.5) is semi-transparent bright red.
    unpremultiplied,
    /// The handling of the alpha component is unknown to WebGPU and should be handled by the application using system-specific APIs. This mode may be unavailable (for example on Wasm).
    inherit,
};

pub const CreatePipelineAsyncStatus = enum(u32) {
    success,
    /// See @ref CallbackStatuses.
    callback_cancelled,
    validation_error,
    internal_error,
};

pub const CullMode = enum(u32) {
    /// Indicates no value is passed for this argument. See @ref SentinelValues.
    undefined,
    none,
    front,
    back,
};

pub const DeviceLostReason = enum(u32) {
    unknown,
    destroyed,
    /// See @ref CallbackStatuses.
    callback_cancelled,
    failed_creation,
};

pub const ErrorFilter = enum(u32) {
    validation,
    out_of_memory,
    internal,
};

pub const ErrorType = enum(u32) {
    no_error,
    validation,
    out_of_memory,
    internal,
    unknown,
};

/// See @ref WGPURequestAdapterOptions::featureLevel.
pub const FeatureLevel = enum(u32) {
    /// Indicates no value is passed for this argument. See @ref SentinelValues.
    undefined,
    /// "Compatibility" profile which can be supported on OpenGL ES 3.1 and D3D11.
    compatibility,
    /// "Core" profile which can be supported on Vulkan/Metal/D3D12 (at least).
    core,
};

pub const FeatureName = enum(u32) {
    undefined,
    depth_clip_control,
    depth_32_float_stencil_8,
    timestamp_query,
    texture_compression_bc,
    texture_compression_bc_sliced_3_d,
    texture_compression_etc_2,
    texture_compression_astc,
    texture_compression_astc_sliced_3_d,
    indirect_first_instance,
    shader_f_16,
    rg_11_b_10_ufloat_renderable,
    bgra_8_unorm_storage,
    float_32_filterable,
    float_32_blendable,
    clip_distances,
    dual_source_blending,
    subgroups,
};

pub const FilterMode = enum(u32) {
    /// Indicates no value is passed for this argument. See @ref SentinelValues.
    undefined,
    nearest,
    linear,
};

pub const FrontFace = enum(u32) {
    /// Indicates no value is passed for this argument. See @ref SentinelValues.
    undefined,
    ccw,
    cw,
};

pub const IndexFormat = enum(u32) {
    /// Indicates no value is passed for this argument. See @ref SentinelValues.
    undefined,
    uint_16,
    uint_32,
};

pub const LoadOp = enum(u32) {
    /// Indicates no value is passed for this argument. See @ref SentinelValues.
    undefined,
    load,
    clear,
};

pub const MapAsyncStatus = enum(u32) {
    success,
    /// See @ref CallbackStatuses.
    callback_cancelled,
    @"error",
    aborted,
};

pub const MipmapFilterMode = enum(u32) {
    /// Indicates no value is passed for this argument. See @ref SentinelValues.
    undefined,
    nearest,
    linear,
};

pub const OptionalBool = enum(u32) {
    false,
    true,
    undefined,
};

pub const PopErrorScopeStatus = enum(u32) {
    /// The error scope stack was successfully popped and a result was reported.
    success,
    /// See @ref CallbackStatuses.
    callback_cancelled,
    /// The error scope stack could not be popped, because it was empty.
    @"error",
};

pub const PowerPreference = enum(u32) {
    /// No preference. (See also @ref SentinelValues.)
    undefined,
    low_power,
    high_performance,
};

pub const PredefinedColorSpace = enum(u32) {
    srgb,
    display_p_3,
};

/// Describes when and in which order frames are presented on the screen when @ref wgpuSurfacePresent is called.
pub const PresentMode = enum(u32) {
    /// Present mode is not specified. Use the default.
    undefined,
    /// The presentation of the image to the user waits for the next vertical blanking period to update in a first-in, first-out manner.
    /// Tearing cannot be observed and frame-loop will be limited to the display's refresh rate.
    /// This is the only mode that's always available.
    fifo,
    /// The presentation of the image to the user tries to wait for the next vertical blanking period but may decide to not wait if a frame is presented late.
    /// Tearing can sometimes be observed but late-frame don't produce a full-frame stutter in the presentation.
    /// This is still a first-in, first-out mechanism so a frame-loop will be limited to the display's refresh rate.
    fifo_relaxed,
    /// The presentation of the image to the user is updated immediately without waiting for a vertical blank.
    /// Tearing can be observed but latency is minimized.
    immediate,
    /// The presentation of the image to the user waits for the next vertical blanking period to update to the latest provided image.
    /// Tearing cannot be observed and a frame-loop is not limited to the display's refresh rate.
    mailbox,
};

pub const PrimitiveTopology = enum(u32) {
    /// Indicates no value is passed for this argument. See @ref SentinelValues.
    undefined,
    point_list,
    line_list,
    line_strip,
    triangle_list,
    triangle_strip,
};

pub const QueryType = enum(u32) {
    occlusion,
    timestamp,
};

pub const QueueWorkDoneStatus = enum(u32) {
    success,
    /// See @ref CallbackStatuses.
    callback_cancelled,
    /// There was some deterministic error. (Note this is currently never used,
    /// but it will be relevant when it's possible to create a queue object.)
    @"error",
};

pub const RequestAdapterStatus = enum(u32) {
    success,
    /// See @ref CallbackStatuses.
    callback_cancelled,
    unavailable,
    @"error",
};

pub const RequestDeviceStatus = enum(u32) {
    success,
    /// See @ref CallbackStatuses.
    callback_cancelled,
    @"error",
};

pub const SType = enum(u32) {
    shader_source_spirv,
    shader_source_wgsl,
    render_pass_max_draw_count,
    surface_source_metal_layer,
    surface_source_windows_hwnd,
    surface_source_xlib_window,
    surface_source_wayland_surface,
    surface_source_android_native_window,
    surface_source_xcb_window,
    surface_color_management,
    request_adapter_web_xr_options,
};

pub const SamplerBindingType = enum(u32) {
    /// Indicates that this @ref WGPUSamplerBindingLayout member of
    /// its parent @ref WGPUBindGroupLayoutEntry is not used.
    /// (See also @ref SentinelValues.)
    binding_not_used,
    /// `1`. Indicates no value is passed for this argument. See @ref SentinelValues.
    undefined,
    filtering,
    non_filtering,
    comparison,
};

/// Status code returned (synchronously) from many operations. Generally
/// indicates an invalid input like an unknown enum value or @ref OutStructChainError.
/// Read the function's documentation for specific error conditions.
pub const Status = enum(u32) {
    /// 
    success,
    /// 
    @"error",
};

pub const StencilOperation = enum(u32) {
    /// Indicates no value is passed for this argument. See @ref SentinelValues.
    undefined,
    keep,
    zero,
    replace,
    invert,
    increment_clamp,
    decrement_clamp,
    increment_wrap,
    decrement_wrap,
};

pub const StorageTextureAccess = enum(u32) {
    /// Indicates that this @ref WGPUStorageTextureBindingLayout member of
    /// its parent @ref WGPUBindGroupLayoutEntry is not used.
    /// (See also @ref SentinelValues.)
    binding_not_used,
    /// `1`. Indicates no value is passed for this argument. See @ref SentinelValues.
    undefined,
    write_only,
    read_only,
    read_write,
};

pub const StoreOp = enum(u32) {
    /// Indicates no value is passed for this argument. See @ref SentinelValues.
    undefined,
    store,
    discard,
};

/// The status enum for @ref wgpuSurfaceGetCurrentTexture.
pub const SurfaceGetCurrentTextureStatus = enum(u32) {
    /// Yay! Everything is good and we can render this frame.
    success_optimal,
    /// Still OK - the surface can present the frame, but in a suboptimal way. The surface may need reconfiguration.
    success_suboptimal,
    /// Some operation timed out while trying to acquire the frame.
    timeout,
    /// The surface is too different to be used, compared to when it was originally created.
    outdated,
    /// The connection to whatever owns the surface was lost, or generally needs to be fully reinitialized.
    lost,
    /// There was some deterministic error (for example, the surface is not configured, or there was an @ref OutStructChainError). Should produce @ref ImplementationDefinedLogging containing details.
    @"error",
};

pub const TextureAspect = enum(u32) {
    /// Indicates no value is passed for this argument. See @ref SentinelValues.
    undefined,
    all,
    stencil_only,
    depth_only,
};

pub const TextureDimension = enum(u32) {
    /// Indicates no value is passed for this argument. See @ref SentinelValues.
    undefined,
    @"1D",
    @"2D",
    @"3D",
};

pub const TextureFormat = enum(u32) {
    /// Indicates no value is passed for this argument. See @ref SentinelValues.
    undefined,
    r_8_unorm,
    r_8_snorm,
    r_8_uint,
    r_8_sint,
    r_16_uint,
    r_16_sint,
    r_16_float,
    rg_8_unorm,
    rg_8_snorm,
    rg_8_uint,
    rg_8_sint,
    r_32_float,
    r_32_uint,
    r_32_sint,
    rg_16_uint,
    rg_16_sint,
    rg_16_float,
    rgba_8_unorm,
    rgba_8_unorm_srgb,
    rgba_8_snorm,
    rgba_8_uint,
    rgba_8_sint,
    bgra_8_unorm,
    bgra_8_unorm_srgb,
    rgb_10_a_2_uint,
    rgb_10_a_2_unorm,
    rg_11_b_10_ufloat,
    rgb_9_e_5_ufloat,
    rg_32_float,
    rg_32_uint,
    rg_32_sint,
    rgba_16_uint,
    rgba_16_sint,
    rgba_16_float,
    rgba_32_float,
    rgba_32_uint,
    rgba_32_sint,
    stencil_8,
    depth_16_unorm,
    depth_24_plus,
    depth_24_plus_stencil_8,
    depth_32_float,
    depth_32_float_stencil_8,
    bc_1_rgba_unorm,
    bc_1_rgba_unorm_srgb,
    bc_2_rgba_unorm,
    bc_2_rgba_unorm_srgb,
    bc_3_rgba_unorm,
    bc_3_rgba_unorm_srgb,
    bc_4_r_unorm,
    bc_4_r_snorm,
    bc_5_rg_unorm,
    bc_5_rg_snorm,
    bc_6_h_rgb_ufloat,
    bc_6_h_rgb_float,
    bc_7_rgba_unorm,
    bc_7_rgba_unorm_srgb,
    etc_2_rgb_8_unorm,
    etc_2_rgb_8_unorm_srgb,
    etc_2_rgb_8_a_1_unorm,
    etc_2_rgb_8_a_1_unorm_srgb,
    etc_2_rgba_8_unorm,
    etc_2_rgba_8_unorm_srgb,
    eac_r_11_unorm,
    eac_r_11_snorm,
    eac_rg_11_unorm,
    eac_rg_11_snorm,
    astc_4_x_4_unorm,
    astc_4_x_4_unorm_srgb,
    astc_5_x_4_unorm,
    astc_5_x_4_unorm_srgb,
    astc_5_x_5_unorm,
    astc_5_x_5_unorm_srgb,
    astc_6_x_5_unorm,
    astc_6_x_5_unorm_srgb,
    astc_6_x_6_unorm,
    astc_6_x_6_unorm_srgb,
    astc_8_x_5_unorm,
    astc_8_x_5_unorm_srgb,
    astc_8_x_6_unorm,
    astc_8_x_6_unorm_srgb,
    astc_8_x_8_unorm,
    astc_8_x_8_unorm_srgb,
    astc_10_x_5_unorm,
    astc_10_x_5_unorm_srgb,
    astc_10_x_6_unorm,
    astc_10_x_6_unorm_srgb,
    astc_10_x_8_unorm,
    astc_10_x_8_unorm_srgb,
    astc_10_x_10_unorm,
    astc_10_x_10_unorm_srgb,
    astc_12_x_10_unorm,
    astc_12_x_10_unorm_srgb,
    astc_12_x_12_unorm,
    astc_12_x_12_unorm_srgb,
};

pub const TextureSampleType = enum(u32) {
    /// Indicates that this @ref WGPUTextureBindingLayout member of
    /// its parent @ref WGPUBindGroupLayoutEntry is not used.
    /// (See also @ref SentinelValues.)
    binding_not_used,
    /// `1`. Indicates no value is passed for this argument. See @ref SentinelValues.
    undefined,
    float,
    unfilterable_float,
    depth,
    sint,
    uint,
};

pub const TextureViewDimension = enum(u32) {
    /// Indicates no value is passed for this argument. See @ref SentinelValues.
    undefined,
    @"1D",
    @"2D",
    @"2D_array",
    cube,
    cube_array,
    @"3D",
};

pub const ToneMappingMode = enum(u32) {
    standard,
    extended,
};

pub const VertexFormat = enum(u32) {
    uint_8,
    uint_8_x_2,
    uint_8_x_4,
    sint_8,
    sint_8_x_2,
    sint_8_x_4,
    unorm_8,
    unorm_8_x_2,
    unorm_8_x_4,
    snorm_8,
    snorm_8_x_2,
    snorm_8_x_4,
    uint_16,
    uint_16_x_2,
    uint_16_x_4,
    sint_16,
    sint_16_x_2,
    sint_16_x_4,
    unorm_16,
    unorm_16_x_2,
    unorm_16_x_4,
    snorm_16,
    snorm_16_x_2,
    snorm_16_x_4,
    float_16,
    float_16_x_2,
    float_16_x_4,
    float_32,
    float_32_x_2,
    float_32_x_3,
    float_32_x_4,
    uint_32,
    uint_32_x_2,
    uint_32_x_3,
    uint_32_x_4,
    sint_32,
    sint_32_x_2,
    sint_32_x_3,
    sint_32_x_4,
    unorm_10_10_10_2,
    unorm_8_x_4_b_g_r_a,
};

pub const VertexStepMode = enum(u32) {
    /// Indicates no value is passed for this argument. See @ref SentinelValues.
    undefined,
    vertex,
    instance,
};

/// Status returned from a call to ::wgpuInstanceWaitAny.
pub const WaitStatus = enum(u32) {
    /// At least one WGPUFuture completed successfully.
    success,
    /// The wait operation succeeded, but no WGPUFutures completed within the timeout.
    timed_out,
    /// The call was invalid for some reason (see @ref Wait-Any).
    /// Should produce @ref ImplementationDefinedLogging containing details.
    @"error",
};

pub const WgslLanguageFeatureName = enum(u32) {
    readonly_and_readwrite_storage_textures,
    packed_4_x_8_integer_dot_product,
    unrestricted_pointer_parameters,
    pointer_composite_access,
};

pub const BufferUsage = enum(u64) {


    none = 0,
    map_read = 1,
    map_write = 2,
    copy_src = 3,
    copy_dst = 4,
    index = 5,
    vertex = 6,
    uniform = 7,
    storage = 8,
    indirect = 9,
    query_resolve = 10,
};

pub const ColorWriteMask = enum(u64) {
    const Red = 1;
    const Green = 2;
    const Blue = 3;
    const Alpha = 4;


    none = 0,
    red = Red,
    green = Green,
    blue = Blue,
    alpha = Alpha,
    all = Red | Green | Blue | Alpha,
};

pub const MapMode = enum(u64) {


    none = 0,
    read = 1,
    write = 2,
};

pub const ShaderStage = enum(u64) {


    none = 0,
    vertex = 1,
    fragment = 2,
    compute = 3,
};

pub const TextureUsage = enum(u64) {


    none = 0,
    copy_src = 1,
    copy_dst = 2,
    texture_binding = 3,
    storage_binding = 4,
    render_attachment = 5,
};

pub const Chained = extern struct {
	next: ?*Chained,
	s_type: SType,


};

pub const AdapterInfo = extern struct {
    next_in_chain: ?*Chained = null,
    vendor: StringView,
    architecture: StringView,
    device: StringView,
    description: StringView,
    backend_type: BackendType = .undefined,
    adapter_type: AdapterType,
    vendor_id: u32,
    device_id: u32,
    subgroup_min_size: u32,
    subgroup_max_size: u32,
    pub extern fn freeMembers(self: *AdapterInfo) callconv(.c) void;
};

pub const BindGroupDescriptor = extern struct {
    next_in_chain: ?*Chained = null,
    label: []const u8 = "",
    layout: *BindGroupLayout,
    entries_count: usize,
    entries: *const []BindGroupEntry,
};

pub const BindGroupEntry = extern struct {
    next_in_chain: ?*Chained = null,
    binding: u32,
    buffer: ?*Buffer = null,
    offset: u64,
    size: u64 = WHOLE_SIZE,
    sampler: ?*Sampler = null,
    texture_view: ?*TextureView = null,
};

pub const BindGroupLayoutDescriptor = extern struct {
    next_in_chain: ?*Chained = null,
    label: []const u8 = "",
    entries_count: usize,
    entries: *const []BindGroupLayoutEntry,
};

pub const BindGroupLayoutEntry = extern struct {
    next_in_chain: ?*Chained = null,
    binding: u32,
    visibility: ShaderStage = .none,
    buffer: BufferBindingLayout = .zero,
    sampler: SamplerBindingLayout = .zero,
    texture: TextureBindingLayout = .zero,
    storage_texture: StorageTextureBindingLayout = .zero,
};

pub const BlendComponent = extern struct {
    operation: BlendOperation = .undefined,
    src_factor: BlendFactor = .undefined,
    dst_factor: BlendFactor = .undefined,
};

pub const BlendState = extern struct {
    color: BlendComponent,
    alpha: BlendComponent,
};

pub const BufferBindingLayout = extern struct {
    next_in_chain: ?*Chained = null,
    type: BufferBindingType = .undefined,
    has_dynamic_offset: bool = false,
    min_binding_size: u64 = 0,
};

pub const BufferDescriptor = extern struct {
    next_in_chain: ?*Chained = null,
    label: []const u8 = "",
    usage: BufferUsage = .none,
    size: u64,
    mapped_at_creation: bool = false,
};

pub const Color = extern struct {
    r: f64,
    g: f64,
    b: f64,
    a: f64,
};

pub const ColorTargetState = extern struct {
    next_in_chain: ?*Chained = null,
    format: TextureFormat = .undefined,
    blend: ?*const BlendState = null,
    write_mask: ColorWriteMask = .all,
};

pub const CommandBufferDescriptor = extern struct {
    next_in_chain: ?*Chained = null,
    label: []const u8 = "",
};

pub const CommandEncoderDescriptor = extern struct {
    next_in_chain: ?*Chained = null,
    label: []const u8 = "",
};

pub const CompilationInfo = extern struct {
    next_in_chain: ?*Chained = null,
    messages_count: usize,
    messages: *const []CompilationMessage,
};

pub const CompilationMessage = extern struct {
    next_in_chain: ?*Chained = null,
    message: StringView,
    type: CompilationMessageType,
    line_num: u64,
    line_pos: u64,
    offset: u64,
    length: u64,
};

pub const ComputePassDescriptor = extern struct {
    next_in_chain: ?*Chained = null,
    label: []const u8 = "",
    timestamp_writes: ?*const PassTimestampWrites = null,
};

pub const ComputePipelineDescriptor = extern struct {
    next_in_chain: ?*Chained = null,
    label: []const u8 = "",
    layout: ?*PipelineLayout = null,
    compute: ComputeState,
};

pub const ComputeState = extern struct {
    next_in_chain: ?*Chained = null,
    module: *ShaderModule,
    entry_point: ??StringView = .null,
    constants_count: usize,
    constants: *const []ConstantEntry,
};

pub const ConstantEntry = extern struct {
    next_in_chain: ?*Chained = null,
    key: []const u8 = "",
    value: f64,
};

pub const DepthStencilState = extern struct {
    next_in_chain: ?*Chained = null,
    format: TextureFormat = .undefined,
    depth_write_enabled: OptionalBool,
    depth_compare: CompareFunction,
    stencil_front: StencilFaceState,
    stencil_back: StencilFaceState,
    stencil_read_mask: u32 = .@"0xFFFFFFFF",
    stencil_write_mask: u32 = .@"0xFFFFFFFF",
    depth_bias: i32 = 0,
    depth_bias_slope_scale: f32 = 0,
    depth_bias_clamp: f32 = 0,
};

pub const DeviceDescriptor = extern struct {
    next_in_chain: ?*Chained = null,
    label: []const u8 = "",
    required_features_count: usize,
    required_features: *const []FeatureName,
    required_limits: ?*const Limits = null,
    default_queue: QueueDescriptor,
    device_lost_callback_info: DeviceLostCallbackInfo,
    uncaptured_error_callback_info: UncapturedErrorCallbackInfo,
};

pub const Extent3D = extern struct {
    width: u32,
    height: u32 = 1,
    depth_or_array_layers: u32 = 1,
};

pub const FragmentState = extern struct {
    next_in_chain: ?*Chained = null,
    module: *ShaderModule,
    entry_point: ??StringView = .null,
    constants_count: usize,
    constants: *const []ConstantEntry,
    targets_count: usize,
    targets: *const []ColorTargetState,
};

pub const Future = extern struct {
    id: u64,
};

pub const FutureWaitInfo = extern struct {
    future: Future,
    completed: bool,
};

pub const InstanceCapabilities = extern struct {
    next_in_chain: ?*Chained = null,
    timed_wait_any_enable: bool,
    timed_wait_any_max_count: usize,
};

pub const InstanceDescriptor = extern struct {
    next_in_chain: ?*Chained = null,
    capabilities: InstanceCapabilities,
};

pub const Limits = extern struct {
    next_in_chain: ?*Chained = null,
    max_texture_dimension_1_d: u32 = LIMIT_U32_UNDEFINED,
    max_texture_dimension_2_d: u32 = LIMIT_U32_UNDEFINED,
    max_texture_dimension_3_d: u32 = LIMIT_U32_UNDEFINED,
    max_texture_array_layers: u32 = LIMIT_U32_UNDEFINED,
    max_bind_groups: u32 = LIMIT_U32_UNDEFINED,
    max_bind_groups_plus_vertex_buffers: u32 = LIMIT_U32_UNDEFINED,
    max_bindings_per_bind_group: u32 = LIMIT_U32_UNDEFINED,
    max_dynamic_uniform_buffers_per_pipeline_layout: u32 = LIMIT_U32_UNDEFINED,
    max_dynamic_storage_buffers_per_pipeline_layout: u32 = LIMIT_U32_UNDEFINED,
    max_sampled_textures_per_shader_stage: u32 = LIMIT_U32_UNDEFINED,
    max_samplers_per_shader_stage: u32 = LIMIT_U32_UNDEFINED,
    max_storage_buffers_per_shader_stage: u32 = LIMIT_U32_UNDEFINED,
    max_storage_textures_per_shader_stage: u32 = LIMIT_U32_UNDEFINED,
    max_uniform_buffers_per_shader_stage: u32 = LIMIT_U32_UNDEFINED,
    max_uniform_buffer_binding_size: u64 = LIMIT_U64_UNDEFINED,
    max_storage_buffer_binding_size: u64 = LIMIT_U64_UNDEFINED,
    min_uniform_buffer_offset_alignment: u32 = LIMIT_U32_UNDEFINED,
    min_storage_buffer_offset_alignment: u32 = LIMIT_U32_UNDEFINED,
    max_vertex_buffers: u32 = LIMIT_U32_UNDEFINED,
    max_buffer_size: u64 = LIMIT_U64_UNDEFINED,
    max_vertex_attributes: u32 = LIMIT_U32_UNDEFINED,
    max_vertex_buffer_array_stride: u32 = LIMIT_U32_UNDEFINED,
    max_inter_stage_shader_variables: u32 = LIMIT_U32_UNDEFINED,
    max_color_attachments: u32 = LIMIT_U32_UNDEFINED,
    max_color_attachment_bytes_per_sample: u32 = LIMIT_U32_UNDEFINED,
    max_compute_workgroup_storage_size: u32 = LIMIT_U32_UNDEFINED,
    max_compute_invocations_per_workgroup: u32 = LIMIT_U32_UNDEFINED,
    max_compute_workgroup_size_x: u32 = LIMIT_U32_UNDEFINED,
    max_compute_workgroup_size_y: u32 = LIMIT_U32_UNDEFINED,
    max_compute_workgroup_size_z: u32 = LIMIT_U32_UNDEFINED,
    max_compute_workgroups_per_dimension: u32 = LIMIT_U32_UNDEFINED,
};

pub const MultisampleState = extern struct {
    next_in_chain: ?*Chained = null,
    count: u32 = 1,
    mask: u32 = .@"0xFFFFFFFF",
    alpha_to_coverage_enabled: bool = false,
};

pub const Origin3D = extern struct {
    x: u32 = 0,
    y: u32 = 0,
    z: u32 = 0,
};

pub const PassTimestampWrites = extern struct {
    next_in_chain: ?*Chained = null,
    query_set: *QuerySet,
    beginning_of_pass_write_index: u32 = QUERY_SET_INDEX_UNDEFINED,
    end_of_pass_write_index: u32 = QUERY_SET_INDEX_UNDEFINED,
};

pub const PipelineLayoutDescriptor = extern struct {
    next_in_chain: ?*Chained = null,
    label: []const u8 = "",
    bind_group_layouts_count: usize,
    bind_group_layouts: *const []*BindGroupLayout,
};

pub const PrimitiveState = extern struct {
    next_in_chain: ?*Chained = null,
    topology: PrimitiveTopology = .undefined,
    strip_index_format: IndexFormat,
    front_face: FrontFace = .undefined,
    cull_mode: CullMode = .undefined,
    unclipped_depth: bool = false,
};

pub const QuerySetDescriptor = extern struct {
    next_in_chain: ?*Chained = null,
    label: []const u8 = "",
    type: QueryType,
    count: u32,
};

pub const QueueDescriptor = extern struct {
    next_in_chain: ?*Chained = null,
    label: []const u8 = "",
};

pub const RenderBundleDescriptor = extern struct {
    next_in_chain: ?*Chained = null,
    label: []const u8 = "",
};

pub const RenderBundleEncoderDescriptor = extern struct {
    next_in_chain: ?*Chained = null,
    label: []const u8 = "",
    color_formats_count: usize,
    color_formats: *const []TextureFormat,
    depth_stencil_format: TextureFormat = .undefined,
    sample_count: u32 = 1,
    depth_read_only: bool = false,
    stencil_read_only: bool = false,
};

pub const RenderPassColorAttachment = extern struct {
    next_in_chain: ?*Chained = null,
    view: ?*TextureView = null,
    depth_slice: u32 = DEPTH_SLICE_UNDEFINED,
    resolve_target: ?*TextureView = null,
    load_op: LoadOp,
    store_op: StoreOp,
    clear_value: Color,
};

pub const RenderPassDepthStencilAttachment = extern struct {
    next_in_chain: ?*Chained = null,
    view: *TextureView,
    depth_load_op: LoadOp = .undefined,
    depth_store_op: StoreOp = .undefined,
    depth_clear_value: ?f32 = .null,
    depth_read_only: bool = false,
    stencil_load_op: LoadOp = .undefined,
    stencil_store_op: StoreOp = .undefined,
    stencil_clear_value: u32,
    stencil_read_only: bool = false,
};

pub const RenderPassDescriptor = extern struct {
    next_in_chain: ?*Chained = null,
    label: []const u8 = "",
    color_attachments_count: usize,
    color_attachments: *const []RenderPassColorAttachment,
    depth_stencil_attachment: ?*const RenderPassDepthStencilAttachment = null,
    occlusion_query_set: ?*QuerySet = null,
    timestamp_writes: ?*const PassTimestampWrites = null,
};

pub const RenderPassMaxDrawCount = extern struct {
    chain: Chained,
    max_draw_count: u64 = 50000000,
 
    pub const RenderPassMaxDrawCountInitOptions = struct {
        max_draw_count: u64 = 50000000,
    };
    pub inline fn init(options: RenderPassMaxDrawCountInitOptions) *const RenderPassDescriptor {
        return @ptrCast(&RenderPassMaxDrawCount{
            .max_draw_count = options.max_draw_count,
            .chain = .{ .s_type = .render_pass_max_draw_count },
        });
    }
};

pub const RenderPipelineDescriptor = extern struct {
    next_in_chain: ?*Chained = null,
    label: []const u8 = "",
    layout: ?*PipelineLayout = null,
    vertex: VertexState,
    primitive: PrimitiveState,
    depth_stencil: ?*const DepthStencilState = null,
    multisample: MultisampleState,
    fragment: ?*const FragmentState = null,
};

pub const RequestAdapterOptions = extern struct {
    next_in_chain: ?*Chained = null,
    feature_level: FeatureLevel = .undefined,
    power_preference: PowerPreference = .undefined,
    force_fallback_adapter: bool = false,
    backend_type: BackendType = .undefined,
    compatible_surface: ?*Surface = null,
};

pub const RequestAdapterWebXrOptions = extern struct {
    chain: Chained,
    xr_compatible: bool = false,
 
    pub const RequestAdapterWebXrOptionsInitOptions = struct {
        xr_compatible: bool = false,
    };
    pub inline fn init(options: RequestAdapterWebXrOptionsInitOptions) *const RequestAdapterOptions {
        return @ptrCast(&RequestAdapterWebXrOptions{
            .xr_compatible = options.xr_compatible,
            .chain = .{ .s_type = .request_adapter_web_xr_options },
        });
    }
};

pub const SamplerBindingLayout = extern struct {
    next_in_chain: ?*Chained = null,
    type: SamplerBindingType = .undefined,
};

pub const SamplerDescriptor = extern struct {
    next_in_chain: ?*Chained = null,
    label: []const u8 = "",
    address_mode_u: AddressMode = .undefined,
    address_mode_v: AddressMode = .undefined,
    address_mode_w: AddressMode = .undefined,
    mag_filter: FilterMode = .undefined,
    min_filter: FilterMode = .undefined,
    mipmap_filter: MipmapFilterMode = .undefined,
    lod_min_clamp: f32 = 0,
    lod_max_clamp: f32 = 32,
    compare: CompareFunction = .undefined,
    max_anisotropy: u16 = 1,
};

pub const ShaderModuleDescriptor = extern struct {
    next_in_chain: ?*Chained = null,
    label: []const u8 = "",
};

pub const ShaderSourceSpirv = extern struct {
    chain: Chained,
    code_size: u32 = 0,
    code: *const u32,
 
    pub const ShaderSourceSpirvInitOptions = struct {
        code_size: u32 = 0,
        code: *const u32,
    };
    pub inline fn init(options: ShaderSourceSpirvInitOptions) *const ShaderModuleDescriptor {
        return @ptrCast(&ShaderSourceSpirv{
            .code_size = options.code_size,
            .code = options.code,
            .chain = .{ .s_type = .shader_source_spirv },
        });
    }
};

pub const ShaderSourceWgsl = extern struct {
    chain: Chained,
    code: []const u8 = "",
 
    pub const ShaderSourceWgslInitOptions = struct {
        code: []const u8 = "",
    };
    pub inline fn init(options: ShaderSourceWgslInitOptions) *const ShaderModuleDescriptor {
        return @ptrCast(&ShaderSourceWgsl{
            .code = options.code,
            .chain = .{ .s_type = .shader_source_wgsl },
        });
    }
};

pub const StencilFaceState = extern struct {
    compare: CompareFunction = .undefined,
    fail_op: StencilOperation = .undefined,
    depth_fail_op: StencilOperation = .undefined,
    pass_op: StencilOperation = .undefined,
};

pub const StorageTextureBindingLayout = extern struct {
    next_in_chain: ?*Chained = null,
    access: StorageTextureAccess = .undefined,
    format: TextureFormat = .undefined,
    view_dimension: TextureViewDimension = .undefined,
};

pub const SupportedFeatures = extern struct {
    features_count: usize,
    features: *const []FeatureName,
    pub extern fn freeMembers(self: *SupportedFeatures) callconv(.c) void;
};

pub const SupportedWgslLanguageFeatures = extern struct {
    features_count: usize,
    features: *const []WgslLanguageFeatureName,
    pub extern fn freeMembers(self: *SupportedWgslLanguageFeatures) callconv(.c) void;
};

pub const SurfaceCapabilities = extern struct {
    next_in_chain: ?*Chained = null,
    usages: TextureUsage,
    formats_count: usize,
    formats: *const []TextureFormat,
    present_modes_count: usize,
    present_modes: *const []PresentMode,
    alpha_modes_count: usize,
    alpha_modes: *const []CompositeAlphaMode,
    pub extern fn freeMembers(self: *SurfaceCapabilities) callconv(.c) void;
};

pub const SurfaceColorManagement = extern struct {
    chain: Chained,
    color_space: PredefinedColorSpace,
    tone_mapping_mode: ToneMappingMode,
};

pub const SurfaceConfiguration = extern struct {
    next_in_chain: ?*Chained = null,
    device: *Device,
    format: TextureFormat = .undefined,
    usage: TextureUsage = .render_attachment,
    width: u32,
    height: u32,
    view_formats_count: usize,
    view_formats: *const []TextureFormat,
    alpha_mode: CompositeAlphaMode = .auto,
    present_mode: PresentMode = .undefined,
};

pub const SurfaceDescriptor = extern struct {
    next_in_chain: ?*Chained = null,
    label: []const u8 = "",
};

pub const SurfaceSourceAndroidNativeWindow = extern struct {
    chain: Chained,
    window: *anyopaque,
 
    pub const SurfaceSourceAndroidNativeWindowInitOptions = struct {
        window: *anyopaque,
    };
    pub inline fn init(options: SurfaceSourceAndroidNativeWindowInitOptions) *const SurfaceDescriptor {
        return @ptrCast(&SurfaceSourceAndroidNativeWindow{
            .window = options.window,
            .chain = .{ .s_type = .surface_source_android_native_window },
        });
    }
};

pub const SurfaceSourceMetalLayer = extern struct {
    chain: Chained,
    layer: *anyopaque,
 
    pub const SurfaceSourceMetalLayerInitOptions = struct {
        layer: *anyopaque,
    };
    pub inline fn init(options: SurfaceSourceMetalLayerInitOptions) *const SurfaceDescriptor {
        return @ptrCast(&SurfaceSourceMetalLayer{
            .layer = options.layer,
            .chain = .{ .s_type = .surface_source_metal_layer },
        });
    }
};

pub const SurfaceSourceWaylandSurface = extern struct {
    chain: Chained,
    display: *anyopaque,
    surface: *anyopaque,
 
    pub const SurfaceSourceWaylandSurfaceInitOptions = struct {
        display: *anyopaque,
        surface: *anyopaque,
    };
    pub inline fn init(options: SurfaceSourceWaylandSurfaceInitOptions) *const SurfaceDescriptor {
        return @ptrCast(&SurfaceSourceWaylandSurface{
            .display = options.display,
            .surface = options.surface,
            .chain = .{ .s_type = .surface_source_wayland_surface },
        });
    }
};

pub const SurfaceSourceWindowsHwnd = extern struct {
    chain: Chained,
    hinstance: *anyopaque,
    hwnd: *anyopaque,
 
    pub const SurfaceSourceWindowsHwndInitOptions = struct {
        hinstance: *anyopaque,
        hwnd: *anyopaque,
    };
    pub inline fn init(options: SurfaceSourceWindowsHwndInitOptions) *const SurfaceDescriptor {
        return @ptrCast(&SurfaceSourceWindowsHwnd{
            .hinstance = options.hinstance,
            .hwnd = options.hwnd,
            .chain = .{ .s_type = .surface_source_windows_hwnd },
        });
    }
};

pub const SurfaceSourceXcbWindow = extern struct {
    chain: Chained,
    connection: *anyopaque,
    window: u32,
 
    pub const SurfaceSourceXcbWindowInitOptions = struct {
        connection: *anyopaque,
        window: u32,
    };
    pub inline fn init(options: SurfaceSourceXcbWindowInitOptions) *const SurfaceDescriptor {
        return @ptrCast(&SurfaceSourceXcbWindow{
            .connection = options.connection,
            .window = options.window,
            .chain = .{ .s_type = .surface_source_xcb_window },
        });
    }
};

pub const SurfaceSourceXlibWindow = extern struct {
    chain: Chained,
    display: *anyopaque,
    window: u64,
 
    pub const SurfaceSourceXlibWindowInitOptions = struct {
        display: *anyopaque,
        window: u64,
    };
    pub inline fn init(options: SurfaceSourceXlibWindowInitOptions) *const SurfaceDescriptor {
        return @ptrCast(&SurfaceSourceXlibWindow{
            .display = options.display,
            .window = options.window,
            .chain = .{ .s_type = .surface_source_xlib_window },
        });
    }
};

pub const SurfaceTexture = extern struct {
    next_in_chain: ?*Chained = null,
    texture: *Texture,
    status: SurfaceGetCurrentTextureStatus,
};

pub const TexelCopyBufferInfo = extern struct {
    layout: TexelCopyBufferLayout,
    buffer: *Buffer,
};

pub const TexelCopyBufferLayout = extern struct {
    offset: u64 = 0,
    bytes_per_row: u32 = COPY_STRIDE_UNDEFINED,
    rows_per_image: u32 = COPY_STRIDE_UNDEFINED,
};

pub const TexelCopyTextureInfo = extern struct {
    texture: *Texture,
    mip_level: u32 = 0,
    origin: Origin3D,
    aspect: TextureAspect = .undefined,
};

pub const TextureBindingLayout = extern struct {
    next_in_chain: ?*Chained = null,
    sample_type: TextureSampleType = .undefined,
    view_dimension: TextureViewDimension = .undefined,
    multisampled: bool = false,
};

pub const TextureDescriptor = extern struct {
    next_in_chain: ?*Chained = null,
    label: []const u8 = "",
    usage: TextureUsage = .none,
    dimension: TextureDimension = .undefined,
    size: Extent3D,
    format: TextureFormat = .undefined,
    mip_level_count: u32 = 1,
    sample_count: u32 = 1,
    view_formats_count: usize,
    view_formats: *const []TextureFormat,
};

pub const TextureViewDescriptor = extern struct {
    next_in_chain: ?*Chained = null,
    label: []const u8 = "",
    format: TextureFormat = .undefined,
    dimension: TextureViewDimension = .undefined,
    base_mip_level: u32 = 0,
    mip_level_count: u32 = MIP_LEVEL_COUNT_UNDEFINED,
    base_array_layer: u32 = 0,
    array_layer_count: u32 = ARRAY_LAYER_COUNT_UNDEFINED,
    aspect: TextureAspect = .undefined,
    usage: TextureUsage = .none,
};

pub const VertexAttribute = extern struct {
    next_in_chain: ?*Chained = null,
    format: VertexFormat,
    offset: u64,
    shader_location: u32,
};

pub const VertexBufferLayout = extern struct {
    next_in_chain: ?*Chained = null,
    step_mode: VertexStepMode = .undefined,
    array_stride: u64,
    attributes_count: usize,
    attributes: *const []VertexAttribute,
};

pub const VertexState = extern struct {
    next_in_chain: ?*Chained = null,
    module: *ShaderModule,
    entry_point: ??StringView = .null,
    constants_count: usize,
    constants: *const []ConstantEntry,
    buffers_count: usize,
    buffers: *const []VertexBufferLayout,
};

pub const BufferMapCallback = *const fn (status: MapAsyncStatus, message: StringView, userdata1: ?*anyopaque, userdata2: ?*anyopaque) callconv(.c) void;
pub const BufferMapCallbackInfo = extern struct {
    next_in_chain: ?*Chained = null,
    mode: CallbackMode = .allow_process_events,
    callback: BufferMapCallback,
    userdata1: ?*anyopaque = null,
    userdata2: ?*anyopaque = null,
};

pub const CompilationInfoCallback = *const fn (status: CompilationInfoRequestStatus, compilation_info: *const CompilationInfo, userdata1: ?*anyopaque, userdata2: ?*anyopaque) callconv(.c) void;
pub const CompilationInfoCallbackInfo = extern struct {
    next_in_chain: ?*Chained = null,
    mode: CallbackMode = .allow_process_events,
    callback: CompilationInfoCallback,
    userdata1: ?*anyopaque = null,
    userdata2: ?*anyopaque = null,
};

pub const CreateComputePipelineAsyncCallback = *const fn (status: CreatePipelineAsyncStatus, pipeline: *ComputePipeline, message: StringView, userdata1: ?*anyopaque, userdata2: ?*anyopaque) callconv(.c) void;
pub const CreateComputePipelineAsyncCallbackInfo = extern struct {
    next_in_chain: ?*Chained = null,
    mode: CallbackMode = .allow_process_events,
    callback: CreateComputePipelineAsyncCallback,
    userdata1: ?*anyopaque = null,
    userdata2: ?*anyopaque = null,
};

pub const CreateRenderPipelineAsyncCallback = *const fn (status: CreatePipelineAsyncStatus, pipeline: *RenderPipeline, message: StringView, userdata1: ?*anyopaque, userdata2: ?*anyopaque) callconv(.c) void;
pub const CreateRenderPipelineAsyncCallbackInfo = extern struct {
    next_in_chain: ?*Chained = null,
    mode: CallbackMode = .allow_process_events,
    callback: CreateRenderPipelineAsyncCallback,
    userdata1: ?*anyopaque = null,
    userdata2: ?*anyopaque = null,
};

pub const DeviceLostCallback = *const fn (device: *Device, reason: DeviceLostReason, message: StringView, userdata1: ?*anyopaque, userdata2: ?*anyopaque) callconv(.c) void;
pub const DeviceLostCallbackInfo = extern struct {
    next_in_chain: ?*Chained = null,
    mode: CallbackMode = .allow_process_events,
    callback: DeviceLostCallback,
    userdata1: ?*anyopaque = null,
    userdata2: ?*anyopaque = null,
};

pub const PopErrorScopeCallback = *const fn (status: PopErrorScopeStatus, type: ErrorType, message: StringView, userdata1: ?*anyopaque, userdata2: ?*anyopaque) callconv(.c) void;
pub const PopErrorScopeCallbackInfo = extern struct {
    next_in_chain: ?*Chained = null,
    mode: CallbackMode = .allow_process_events,
    callback: PopErrorScopeCallback,
    userdata1: ?*anyopaque = null,
    userdata2: ?*anyopaque = null,
};

pub const QueueWorkDoneCallback = *const fn (status: QueueWorkDoneStatus, userdata1: ?*anyopaque, userdata2: ?*anyopaque) callconv(.c) void;
pub const QueueWorkDoneCallbackInfo = extern struct {
    next_in_chain: ?*Chained = null,
    mode: CallbackMode = .allow_process_events,
    callback: QueueWorkDoneCallback,
    userdata1: ?*anyopaque = null,
    userdata2: ?*anyopaque = null,
};

pub const RequestAdapterCallback = *const fn (status: RequestAdapterStatus, adapter: *Adapter, message: StringView, userdata1: ?*anyopaque, userdata2: ?*anyopaque) callconv(.c) void;
pub const RequestAdapterCallbackInfo = extern struct {
    next_in_chain: ?*Chained = null,
    mode: CallbackMode = .allow_process_events,
    callback: RequestAdapterCallback,
    userdata1: ?*anyopaque = null,
    userdata2: ?*anyopaque = null,
};

pub const RequestDeviceCallback = *const fn (status: RequestDeviceStatus, device: *Device, message: StringView, userdata1: ?*anyopaque, userdata2: ?*anyopaque) callconv(.c) void;
pub const RequestDeviceCallbackInfo = extern struct {
    next_in_chain: ?*Chained = null,
    mode: CallbackMode = .allow_process_events,
    callback: RequestDeviceCallback,
    userdata1: ?*anyopaque = null,
    userdata2: ?*anyopaque = null,
};

pub const UncapturedErrorCallback = *const fn (device: *Device, type: ErrorType, message: StringView, userdata1: ?*anyopaque, userdata2: ?*anyopaque) callconv(.c) void;
pub const UncapturedErrorCallbackInfo = extern struct {
    next_in_chain: ?*Chained = null,
    callback: UncapturedErrorCallback,
    userdata1: ?*anyopaque = null,
    userdata2: ?*anyopaque = null,
};

/// Create a WGPUInstance
extern fn wgpuCreateInstance(descriptor: ?*const InstanceDescriptor) callconv(.c) *Instance;
pub const createInstance = wgpuCreateInstance;
/// Query the supported instance capabilities.
extern fn wgpuGetInstanceCapabilities(capabilities: *InstanceCapabilities) callconv(.c) Status;
pub const getInstanceCapabilities = wgpuGetInstanceCapabilities;


pub const Adapter = opaque {
    extern fn wgpuAdapterGetLimits(self: *Adapter, limits: *Limits) callconv(.c) Status;
    pub inline fn getLimits(self: *Adapter, limits: *Limits) Status { return wgpuAdapterGetLimits(self, limits); }
    extern fn wgpuAdapterHasFeature(self: *Adapter, feature: FeatureName) callconv(.c) bool;
    pub inline fn hasFeature(self: *Adapter, feature: FeatureName) bool { return wgpuAdapterHasFeature(self, feature); }
    extern fn wgpuAdapterGetFeatures(self: *Adapter, features: *SupportedFeatures) callconv(.c) void;
    /// Get the list of @ref WGPUFeatureName values supported by the adapter.
    pub inline fn getFeatures(self: *Adapter, features: *SupportedFeatures) void { return wgpuAdapterGetFeatures(self, features); }
    extern fn wgpuAdapterGetInfo(self: *Adapter, info: *AdapterInfo) callconv(.c) Status;
    pub inline fn getInfo(self: *Adapter, info: *AdapterInfo) Status { return wgpuAdapterGetInfo(self, info); }
    extern fn wgpuAdapterRequestDevice(self: *Adapter, descriptor: ?*const DeviceDescriptor, callback: RequestDeviceCallbackInfo) callconv(.c) void;
    pub inline fn requestDevice(self: *Adapter, descriptor: ?*const DeviceDescriptor, callback: RequestDeviceCallbackInfo) void { return wgpuAdapterRequestDevice(self, descriptor, callback); }
    extern fn wgpuAdapterAddRef(self: *Adapter) callconv(.c) void;
    pub inline fn addRef(self: *Adapter) void { return wgpuAdapterAddRef(self); }
    extern fn wgpuAdapterRelease(self: *Adapter) callconv(.c) void;
    pub inline fn release(self: *Adapter) void { return wgpuAdapterRelease(self); }
};

pub const BindGroup = opaque {
    extern fn wgpuBindGroupSetLabel(self: *BindGroup, label: []const u8) callconv(.c) void;
    pub inline fn setLabel(self: *BindGroup, label: []const u8) void { return wgpuBindGroupSetLabel(self, label); }
    extern fn wgpuBindGroupAddRef(self: *BindGroup) callconv(.c) void;
    pub inline fn addRef(self: *BindGroup) void { return wgpuBindGroupAddRef(self); }
    extern fn wgpuBindGroupRelease(self: *BindGroup) callconv(.c) void;
    pub inline fn release(self: *BindGroup) void { return wgpuBindGroupRelease(self); }
};

pub const BindGroupLayout = opaque {
    extern fn wgpuBindGroupLayoutSetLabel(self: *BindGroupLayout, label: []const u8) callconv(.c) void;
    pub inline fn setLabel(self: *BindGroupLayout, label: []const u8) void { return wgpuBindGroupLayoutSetLabel(self, label); }
    extern fn wgpuBindGroupLayoutAddRef(self: *BindGroupLayout) callconv(.c) void;
    pub inline fn addRef(self: *BindGroupLayout) void { return wgpuBindGroupLayoutAddRef(self); }
    extern fn wgpuBindGroupLayoutRelease(self: *BindGroupLayout) callconv(.c) void;
    pub inline fn release(self: *BindGroupLayout) void { return wgpuBindGroupLayoutRelease(self); }
};

pub const Buffer = opaque {
    extern fn wgpuBufferMapAsync(self: *Buffer, mode: MapMode, offset: usize, size: usize, callback: BufferMapCallbackInfo) callconv(.c) void;
    pub inline fn mapAsync(self: *Buffer, mode: MapMode, offset: usize, size: usize, callback: BufferMapCallbackInfo) void { return wgpuBufferMapAsync(self, mode, offset, size, callback); }
    extern fn wgpuBufferGetMappedRange(self: *Buffer, offset: usize, size: usize) callconv(.c) *anyopaque;
    /// Returns a mutable pointer to beginning of the mapped range.
    /// See @ref MappedRangeBehavior for error conditions and guarantees.
    /// This function is safe to call inside spontaneous callbacks (see @ref CallbackReentrancy).
    /// 
    /// In Wasm, if `memcpy`ing into this range, prefer using @ref wgpuBufferWriteMappedRange
    /// instead for better performance.
    pub inline fn getMappedRange(self: *Buffer, offset: usize, size: usize) *anyopaque { return wgpuBufferGetMappedRange(self, offset, size); }
    extern fn wgpuBufferGetConstMappedRange(self: *Buffer, offset: usize, size: usize) callconv(.c) *const anyopaque;
    /// Returns a const pointer to beginning of the mapped range.
    /// It must not be written; writing to this range causes undefined behavior.
    /// See @ref MappedRangeBehavior for error conditions and guarantees.
    /// This function is safe to call inside spontaneous callbacks (see @ref CallbackReentrancy).
    /// 
    /// In Wasm, if `memcpy`ing from this range, prefer using @ref wgpuBufferReadMappedRange
    /// instead for better performance.
    pub inline fn getConstMappedRange(self: *Buffer, offset: usize, size: usize) *const anyopaque { return wgpuBufferGetConstMappedRange(self, offset, size); }
    extern fn wgpuBufferReadMappedRange(self: *Buffer, offset: usize, data: *anyopaque, size: usize) callconv(.c) Status;
    /// Copies a range of data from the buffer mapping into the provided destination pointer.
    /// See @ref MappedRangeBehavior for error conditions and guarantees.
    /// This function is safe to call inside spontaneous callbacks (see @ref CallbackReentrancy).
    /// 
    /// In Wasm, this is more efficient than copying from a mapped range into a `malloc`'d range.
    pub inline fn readMappedRange(self: *Buffer, offset: usize, data: *anyopaque, size: usize) Status { return wgpuBufferReadMappedRange(self, offset, data, size); }
    extern fn wgpuBufferWriteMappedRange(self: *Buffer, offset: usize, data: *const anyopaque, size: usize) callconv(.c) Status;
    /// Copies a range of data from the provided source pointer into the buffer mapping.
    /// See @ref MappedRangeBehavior for error conditions and guarantees.
    /// This function is safe to call inside spontaneous callbacks (see @ref CallbackReentrancy).
    /// 
    /// In Wasm, this is more efficient than copying from a `malloc`'d range into a mapped range.
    pub inline fn writeMappedRange(self: *Buffer, offset: usize, data: *const anyopaque, size: usize) Status { return wgpuBufferWriteMappedRange(self, offset, data, size); }
    extern fn wgpuBufferSetLabel(self: *Buffer, label: []const u8) callconv(.c) void;
    pub inline fn setLabel(self: *Buffer, label: []const u8) void { return wgpuBufferSetLabel(self, label); }
    extern fn wgpuBufferGetUsage(self: *Buffer) callconv(.c) BufferUsage;
    pub inline fn getUsage(self: *Buffer) BufferUsage { return wgpuBufferGetUsage(self); }
    extern fn wgpuBufferGetSize(self: *Buffer) callconv(.c) u64;
    pub inline fn getSize(self: *Buffer) u64 { return wgpuBufferGetSize(self); }
    extern fn wgpuBufferGetMapState(self: *Buffer) callconv(.c) BufferMapState;
    pub inline fn getMapState(self: *Buffer) BufferMapState { return wgpuBufferGetMapState(self); }
    extern fn wgpuBufferUnmap(self: *Buffer) callconv(.c) void;
    pub inline fn unmap(self: *Buffer) void { return wgpuBufferUnmap(self); }
    extern fn wgpuBufferDestroy(self: *Buffer) callconv(.c) void;
    pub inline fn destroy(self: *Buffer) void { return wgpuBufferDestroy(self); }
    extern fn wgpuBufferAddRef(self: *Buffer) callconv(.c) void;
    pub inline fn addRef(self: *Buffer) void { return wgpuBufferAddRef(self); }
    extern fn wgpuBufferRelease(self: *Buffer) callconv(.c) void;
    pub inline fn release(self: *Buffer) void { return wgpuBufferRelease(self); }
};

pub const CommandBuffer = opaque {
    extern fn wgpuCommandBufferSetLabel(self: *CommandBuffer, label: []const u8) callconv(.c) void;
    pub inline fn setLabel(self: *CommandBuffer, label: []const u8) void { return wgpuCommandBufferSetLabel(self, label); }
    extern fn wgpuCommandBufferAddRef(self: *CommandBuffer) callconv(.c) void;
    pub inline fn addRef(self: *CommandBuffer) void { return wgpuCommandBufferAddRef(self); }
    extern fn wgpuCommandBufferRelease(self: *CommandBuffer) callconv(.c) void;
    pub inline fn release(self: *CommandBuffer) void { return wgpuCommandBufferRelease(self); }
};

pub const CommandEncoder = opaque {
    extern fn wgpuCommandEncoderFinish(self: *CommandEncoder, descriptor: ?*const CommandBufferDescriptor) callconv(.c) *CommandBuffer;
    pub inline fn finish(self: *CommandEncoder, descriptor: ?*const CommandBufferDescriptor) *CommandBuffer { return wgpuCommandEncoderFinish(self, descriptor); }
    extern fn wgpuCommandEncoderBeginComputePass(self: *CommandEncoder, descriptor: ?*const ComputePassDescriptor) callconv(.c) *ComputePassEncoder;
    pub inline fn beginComputePass(self: *CommandEncoder, descriptor: ?*const ComputePassDescriptor) *ComputePassEncoder { return wgpuCommandEncoderBeginComputePass(self, descriptor); }
    extern fn wgpuCommandEncoderBeginRenderPass(self: *CommandEncoder, descriptor: *const RenderPassDescriptor) callconv(.c) *RenderPassEncoder;
    pub inline fn beginRenderPass(self: *CommandEncoder, descriptor: *const RenderPassDescriptor) *RenderPassEncoder { return wgpuCommandEncoderBeginRenderPass(self, descriptor); }
    extern fn wgpuCommandEncoderCopyBufferToBuffer(self: *CommandEncoder, source: *Buffer, sourceOffset: u64, destination: *Buffer, destinationOffset: u64, size: u64) callconv(.c) void;
    pub inline fn copyBufferToBuffer(self: *CommandEncoder, source: *Buffer, sourceOffset: u64, destination: *Buffer, destinationOffset: u64, size: u64) void { return wgpuCommandEncoderCopyBufferToBuffer(self, source, sourceOffset, destination, destinationOffset, size); }
    extern fn wgpuCommandEncoderCopyBufferToTexture(self: *CommandEncoder, source: *const TexelCopyBufferInfo, destination: *const TexelCopyTextureInfo, copySize: *const Extent3D) callconv(.c) void;
    pub inline fn copyBufferToTexture(self: *CommandEncoder, source: *const TexelCopyBufferInfo, destination: *const TexelCopyTextureInfo, copySize: *const Extent3D) void { return wgpuCommandEncoderCopyBufferToTexture(self, source, destination, copySize); }
    extern fn wgpuCommandEncoderCopyTextureToBuffer(self: *CommandEncoder, source: *const TexelCopyTextureInfo, destination: *const TexelCopyBufferInfo, copySize: *const Extent3D) callconv(.c) void;
    pub inline fn copyTextureToBuffer(self: *CommandEncoder, source: *const TexelCopyTextureInfo, destination: *const TexelCopyBufferInfo, copySize: *const Extent3D) void { return wgpuCommandEncoderCopyTextureToBuffer(self, source, destination, copySize); }
    extern fn wgpuCommandEncoderCopyTextureToTexture(self: *CommandEncoder, source: *const TexelCopyTextureInfo, destination: *const TexelCopyTextureInfo, copySize: *const Extent3D) callconv(.c) void;
    pub inline fn copyTextureToTexture(self: *CommandEncoder, source: *const TexelCopyTextureInfo, destination: *const TexelCopyTextureInfo, copySize: *const Extent3D) void { return wgpuCommandEncoderCopyTextureToTexture(self, source, destination, copySize); }
    extern fn wgpuCommandEncoderClearBuffer(self: *CommandEncoder, buffer: *Buffer, offset: u64, size: u64) callconv(.c) void;
    pub inline fn clearBuffer(self: *CommandEncoder, buffer: *Buffer, offset: u64, size: u64) void { return wgpuCommandEncoderClearBuffer(self, buffer, offset, size); }
    extern fn wgpuCommandEncoderInsertDebugMarker(self: *CommandEncoder, markerLabel: []const u8) callconv(.c) void;
    pub inline fn insertDebugMarker(self: *CommandEncoder, markerLabel: []const u8) void { return wgpuCommandEncoderInsertDebugMarker(self, markerLabel); }
    extern fn wgpuCommandEncoderPopDebugGroup(self: *CommandEncoder) callconv(.c) void;
    pub inline fn popDebugGroup(self: *CommandEncoder) void { return wgpuCommandEncoderPopDebugGroup(self); }
    extern fn wgpuCommandEncoderPushDebugGroup(self: *CommandEncoder, groupLabel: []const u8) callconv(.c) void;
    pub inline fn pushDebugGroup(self: *CommandEncoder, groupLabel: []const u8) void { return wgpuCommandEncoderPushDebugGroup(self, groupLabel); }
    extern fn wgpuCommandEncoderResolveQuerySet(self: *CommandEncoder, querySet: *QuerySet, firstQuery: u32, queryCount: u32, destination: *Buffer, destinationOffset: u64) callconv(.c) void;
    pub inline fn resolveQuerySet(self: *CommandEncoder, querySet: *QuerySet, firstQuery: u32, queryCount: u32, destination: *Buffer, destinationOffset: u64) void { return wgpuCommandEncoderResolveQuerySet(self, querySet, firstQuery, queryCount, destination, destinationOffset); }
    extern fn wgpuCommandEncoderWriteTimestamp(self: *CommandEncoder, querySet: *QuerySet, queryIndex: u32) callconv(.c) void;
    pub inline fn writeTimestamp(self: *CommandEncoder, querySet: *QuerySet, queryIndex: u32) void { return wgpuCommandEncoderWriteTimestamp(self, querySet, queryIndex); }
    extern fn wgpuCommandEncoderSetLabel(self: *CommandEncoder, label: []const u8) callconv(.c) void;
    pub inline fn setLabel(self: *CommandEncoder, label: []const u8) void { return wgpuCommandEncoderSetLabel(self, label); }
    extern fn wgpuCommandEncoderAddRef(self: *CommandEncoder) callconv(.c) void;
    pub inline fn addRef(self: *CommandEncoder) void { return wgpuCommandEncoderAddRef(self); }
    extern fn wgpuCommandEncoderRelease(self: *CommandEncoder) callconv(.c) void;
    pub inline fn release(self: *CommandEncoder) void { return wgpuCommandEncoderRelease(self); }
};

pub const ComputePassEncoder = opaque {
    extern fn wgpuComputePassEncoderInsertDebugMarker(self: *ComputePassEncoder, markerLabel: []const u8) callconv(.c) void;
    pub inline fn insertDebugMarker(self: *ComputePassEncoder, markerLabel: []const u8) void { return wgpuComputePassEncoderInsertDebugMarker(self, markerLabel); }
    extern fn wgpuComputePassEncoderPopDebugGroup(self: *ComputePassEncoder) callconv(.c) void;
    pub inline fn popDebugGroup(self: *ComputePassEncoder) void { return wgpuComputePassEncoderPopDebugGroup(self); }
    extern fn wgpuComputePassEncoderPushDebugGroup(self: *ComputePassEncoder, groupLabel: []const u8) callconv(.c) void;
    pub inline fn pushDebugGroup(self: *ComputePassEncoder, groupLabel: []const u8) void { return wgpuComputePassEncoderPushDebugGroup(self, groupLabel); }
    extern fn wgpuComputePassEncoderSetPipeline(self: *ComputePassEncoder, pipeline: *ComputePipeline) callconv(.c) void;
    pub inline fn setPipeline(self: *ComputePassEncoder, pipeline: *ComputePipeline) void { return wgpuComputePassEncoderSetPipeline(self, pipeline); }
    extern fn wgpuComputePassEncoderSetBindGroup(self: *ComputePassEncoder, groupIndex: u32, group: ?*BindGroup, dynamicOffsets: *const []u32) callconv(.c) void;
    pub inline fn setBindGroup(self: *ComputePassEncoder, groupIndex: u32, group: ?*BindGroup, dynamicOffsets: *const []u32) void { return wgpuComputePassEncoderSetBindGroup(self, groupIndex, group, dynamicOffsets); }
    extern fn wgpuComputePassEncoderDispatchWorkgroups(self: *ComputePassEncoder, workgroupCountX: u32, workgroupCountY: u32, workgroupCountZ: u32) callconv(.c) void;
    pub inline fn dispatchWorkgroups(self: *ComputePassEncoder, workgroupCountX: u32, workgroupCountY: u32, workgroupCountZ: u32) void { return wgpuComputePassEncoderDispatchWorkgroups(self, workgroupCountX, workgroupCountY, workgroupCountZ); }
    extern fn wgpuComputePassEncoderDispatchWorkgroupsIndirect(self: *ComputePassEncoder, indirectBuffer: *Buffer, indirectOffset: u64) callconv(.c) void;
    pub inline fn dispatchWorkgroupsIndirect(self: *ComputePassEncoder, indirectBuffer: *Buffer, indirectOffset: u64) void { return wgpuComputePassEncoderDispatchWorkgroupsIndirect(self, indirectBuffer, indirectOffset); }
    extern fn wgpuComputePassEncoderEnd(self: *ComputePassEncoder) callconv(.c) void;
    pub inline fn end(self: *ComputePassEncoder) void { return wgpuComputePassEncoderEnd(self); }
    extern fn wgpuComputePassEncoderSetLabel(self: *ComputePassEncoder, label: []const u8) callconv(.c) void;
    pub inline fn setLabel(self: *ComputePassEncoder, label: []const u8) void { return wgpuComputePassEncoderSetLabel(self, label); }
    extern fn wgpuComputePassEncoderAddRef(self: *ComputePassEncoder) callconv(.c) void;
    pub inline fn addRef(self: *ComputePassEncoder) void { return wgpuComputePassEncoderAddRef(self); }
    extern fn wgpuComputePassEncoderRelease(self: *ComputePassEncoder) callconv(.c) void;
    pub inline fn release(self: *ComputePassEncoder) void { return wgpuComputePassEncoderRelease(self); }
};

pub const ComputePipeline = opaque {
    extern fn wgpuComputePipelineGetBindGroupLayout(self: *ComputePipeline, groupIndex: u32) callconv(.c) *BindGroupLayout;
    pub inline fn getBindGroupLayout(self: *ComputePipeline, groupIndex: u32) *BindGroupLayout { return wgpuComputePipelineGetBindGroupLayout(self, groupIndex); }
    extern fn wgpuComputePipelineSetLabel(self: *ComputePipeline, label: []const u8) callconv(.c) void;
    pub inline fn setLabel(self: *ComputePipeline, label: []const u8) void { return wgpuComputePipelineSetLabel(self, label); }
    extern fn wgpuComputePipelineAddRef(self: *ComputePipeline) callconv(.c) void;
    pub inline fn addRef(self: *ComputePipeline) void { return wgpuComputePipelineAddRef(self); }
    extern fn wgpuComputePipelineRelease(self: *ComputePipeline) callconv(.c) void;
    pub inline fn release(self: *ComputePipeline) void { return wgpuComputePipelineRelease(self); }
};

pub const Device = opaque {
    extern fn wgpuDeviceCreateBindGroup(self: *Device, descriptor: *const BindGroupDescriptor) callconv(.c) *BindGroup;
    pub inline fn createBindGroup(self: *Device, descriptor: *const BindGroupDescriptor) *BindGroup { return wgpuDeviceCreateBindGroup(self, descriptor); }
    extern fn wgpuDeviceCreateBindGroupLayout(self: *Device, descriptor: *const BindGroupLayoutDescriptor) callconv(.c) *BindGroupLayout;
    pub inline fn createBindGroupLayout(self: *Device, descriptor: *const BindGroupLayoutDescriptor) *BindGroupLayout { return wgpuDeviceCreateBindGroupLayout(self, descriptor); }
    extern fn wgpuDeviceCreateBuffer(self: *Device, descriptor: *const BufferDescriptor) callconv(.c) ?*Buffer;
    pub inline fn createBuffer(self: *Device, descriptor: *const BufferDescriptor) ?*Buffer { return wgpuDeviceCreateBuffer(self, descriptor); }
    extern fn wgpuDeviceCreateCommandEncoder(self: *Device, descriptor: ?*const CommandEncoderDescriptor) callconv(.c) *CommandEncoder;
    pub inline fn createCommandEncoder(self: *Device, descriptor: ?*const CommandEncoderDescriptor) *CommandEncoder { return wgpuDeviceCreateCommandEncoder(self, descriptor); }
    extern fn wgpuDeviceCreateComputePipeline(self: *Device, descriptor: *const ComputePipelineDescriptor) callconv(.c) *ComputePipeline;
    pub inline fn createComputePipeline(self: *Device, descriptor: *const ComputePipelineDescriptor) *ComputePipeline { return wgpuDeviceCreateComputePipeline(self, descriptor); }
    extern fn wgpuDeviceCreateComputePipelineAsync(self: *Device, descriptor: *const ComputePipelineDescriptor, callback: CreateComputePipelineAsyncCallbackInfo) callconv(.c) void;
    pub inline fn createComputePipelineAsync(self: *Device, descriptor: *const ComputePipelineDescriptor, callback: CreateComputePipelineAsyncCallbackInfo) void { return wgpuDeviceCreateComputePipelineAsync(self, descriptor, callback); }
    extern fn wgpuDeviceCreatePipelineLayout(self: *Device, descriptor: *const PipelineLayoutDescriptor) callconv(.c) *PipelineLayout;
    pub inline fn createPipelineLayout(self: *Device, descriptor: *const PipelineLayoutDescriptor) *PipelineLayout { return wgpuDeviceCreatePipelineLayout(self, descriptor); }
    extern fn wgpuDeviceCreateQuerySet(self: *Device, descriptor: *const QuerySetDescriptor) callconv(.c) *QuerySet;
    pub inline fn createQuerySet(self: *Device, descriptor: *const QuerySetDescriptor) *QuerySet { return wgpuDeviceCreateQuerySet(self, descriptor); }
    extern fn wgpuDeviceCreateRenderPipelineAsync(self: *Device, descriptor: *const RenderPipelineDescriptor, callback: CreateRenderPipelineAsyncCallbackInfo) callconv(.c) void;
    pub inline fn createRenderPipelineAsync(self: *Device, descriptor: *const RenderPipelineDescriptor, callback: CreateRenderPipelineAsyncCallbackInfo) void { return wgpuDeviceCreateRenderPipelineAsync(self, descriptor, callback); }
    extern fn wgpuDeviceCreateRenderBundleEncoder(self: *Device, descriptor: *const RenderBundleEncoderDescriptor) callconv(.c) *RenderBundleEncoder;
    pub inline fn createRenderBundleEncoder(self: *Device, descriptor: *const RenderBundleEncoderDescriptor) *RenderBundleEncoder { return wgpuDeviceCreateRenderBundleEncoder(self, descriptor); }
    extern fn wgpuDeviceCreateRenderPipeline(self: *Device, descriptor: *const RenderPipelineDescriptor) callconv(.c) *RenderPipeline;
    pub inline fn createRenderPipeline(self: *Device, descriptor: *const RenderPipelineDescriptor) *RenderPipeline { return wgpuDeviceCreateRenderPipeline(self, descriptor); }
    extern fn wgpuDeviceCreateSampler(self: *Device, descriptor: ?*const SamplerDescriptor) callconv(.c) *Sampler;
    pub inline fn createSampler(self: *Device, descriptor: ?*const SamplerDescriptor) *Sampler { return wgpuDeviceCreateSampler(self, descriptor); }
    extern fn wgpuDeviceCreateShaderModule(self: *Device, descriptor: *const ShaderModuleDescriptor) callconv(.c) *ShaderModule;
    pub inline fn createShaderModule(self: *Device, descriptor: *const ShaderModuleDescriptor) *ShaderModule { return wgpuDeviceCreateShaderModule(self, descriptor); }
    extern fn wgpuDeviceCreateTexture(self: *Device, descriptor: *const TextureDescriptor) callconv(.c) *Texture;
    pub inline fn createTexture(self: *Device, descriptor: *const TextureDescriptor) *Texture { return wgpuDeviceCreateTexture(self, descriptor); }
    extern fn wgpuDeviceDestroy(self: *Device) callconv(.c) void;
    pub inline fn destroy(self: *Device) void { return wgpuDeviceDestroy(self); }
    extern fn wgpuDeviceGetLostFuture(self: *Device) callconv(.c) Future;
    /// 
    pub inline fn getLostFuture(self: *Device) Future { return wgpuDeviceGetLostFuture(self); }
    extern fn wgpuDeviceGetLimits(self: *Device, limits: *Limits) callconv(.c) Status;
    pub inline fn getLimits(self: *Device, limits: *Limits) Status { return wgpuDeviceGetLimits(self, limits); }
    extern fn wgpuDeviceHasFeature(self: *Device, feature: FeatureName) callconv(.c) bool;
    pub inline fn hasFeature(self: *Device, feature: FeatureName) bool { return wgpuDeviceHasFeature(self, feature); }
    extern fn wgpuDeviceGetFeatures(self: *Device, features: *SupportedFeatures) callconv(.c) void;
    /// Get the list of @ref WGPUFeatureName values supported by the device.
    pub inline fn getFeatures(self: *Device, features: *SupportedFeatures) void { return wgpuDeviceGetFeatures(self, features); }
    extern fn wgpuDeviceGetAdapterInfo(self: *Device, adapterInfo: *AdapterInfo) callconv(.c) Status;
    pub inline fn getAdapterInfo(self: *Device, adapterInfo: *AdapterInfo) Status { return wgpuDeviceGetAdapterInfo(self, adapterInfo); }
    extern fn wgpuDeviceGetQueue(self: *Device) callconv(.c) *Queue;
    pub inline fn getQueue(self: *Device) *Queue { return wgpuDeviceGetQueue(self); }
    extern fn wgpuDevicePushErrorScope(self: *Device, filter: ErrorFilter) callconv(.c) void;
    /// Pushes an error scope to the current thread's error scope stack.
    /// See @ref ErrorScopes.
    pub inline fn pushErrorScope(self: *Device, filter: ErrorFilter) void { return wgpuDevicePushErrorScope(self, filter); }
    extern fn wgpuDevicePopErrorScope(self: *Device, callback: PopErrorScopeCallbackInfo) callconv(.c) void;
    /// Pops an error scope to the current thread's error scope stack,
    /// asynchronously returning the result. See @ref ErrorScopes.
    pub inline fn popErrorScope(self: *Device, callback: PopErrorScopeCallbackInfo) void { return wgpuDevicePopErrorScope(self, callback); }
    extern fn wgpuDeviceSetLabel(self: *Device, label: []const u8) callconv(.c) void;
    pub inline fn setLabel(self: *Device, label: []const u8) void { return wgpuDeviceSetLabel(self, label); }
    extern fn wgpuDeviceAddRef(self: *Device) callconv(.c) void;
    pub inline fn addRef(self: *Device) void { return wgpuDeviceAddRef(self); }
    extern fn wgpuDeviceRelease(self: *Device) callconv(.c) void;
    pub inline fn release(self: *Device) void { return wgpuDeviceRelease(self); }
};

pub const Instance = opaque {
    extern fn wgpuInstanceCreateSurface(self: *Instance, descriptor: *const SurfaceDescriptor) callconv(.c) *Surface;
    /// Creates a @ref WGPUSurface, see @ref Surface-Creation for more details.
    pub inline fn createSurface(self: *Instance, descriptor: *const SurfaceDescriptor) *Surface { return wgpuInstanceCreateSurface(self, descriptor); }
    extern fn wgpuInstanceGetWgslLanguageFeatures(self: *Instance, features: *SupportedWgslLanguageFeatures) callconv(.c) Status;
    /// Get the list of @ref WGPUWGSLLanguageFeatureName values supported by the instance.
    pub inline fn getWgslLanguageFeatures(self: *Instance, features: *SupportedWgslLanguageFeatures) Status { return wgpuInstanceGetWgslLanguageFeatures(self, features); }
    extern fn wgpuInstanceHasWgslLanguageFeature(self: *Instance, feature: WgslLanguageFeatureName) callconv(.c) bool;
    pub inline fn hasWgslLanguageFeature(self: *Instance, feature: WgslLanguageFeatureName) bool { return wgpuInstanceHasWgslLanguageFeature(self, feature); }
    extern fn wgpuInstanceProcessEvents(self: *Instance) callconv(.c) void;
    /// Processes asynchronous events on this `WGPUInstance`, calling any callbacks for asynchronous operations created with @ref WGPUCallbackMode_AllowProcessEvents.
    /// 
    /// See @ref Process-Events for more information.
    pub inline fn processEvents(self: *Instance) void { return wgpuInstanceProcessEvents(self); }
    extern fn wgpuInstanceRequestAdapter(self: *Instance, options: ?*const RequestAdapterOptions, callback: RequestAdapterCallbackInfo) callconv(.c) void;
    pub inline fn requestAdapter(self: *Instance, options: ?*const RequestAdapterOptions, callback: RequestAdapterCallbackInfo) void { return wgpuInstanceRequestAdapter(self, options, callback); }
    extern fn wgpuInstanceWaitAny(self: *Instance, futureCount: usize, futures: ?*FutureWaitInfo, timeoutNs: u64) callconv(.c) WaitStatus;
    /// Wait for at least one WGPUFuture in `futures` to complete, and call callbacks of the respective completed asynchronous operations.
    /// 
    /// See @ref Wait-Any for more information.
    pub inline fn waitAny(self: *Instance, futureCount: usize, futures: ?*FutureWaitInfo, timeoutNs: u64) WaitStatus { return wgpuInstanceWaitAny(self, futureCount, futures, timeoutNs); }
    extern fn wgpuInstanceAddRef(self: *Instance) callconv(.c) void;
    pub inline fn addRef(self: *Instance) void { return wgpuInstanceAddRef(self); }
    extern fn wgpuInstanceRelease(self: *Instance) callconv(.c) void;
    pub inline fn release(self: *Instance) void { return wgpuInstanceRelease(self); }
};

pub const PipelineLayout = opaque {
    extern fn wgpuPipelineLayoutSetLabel(self: *PipelineLayout, label: []const u8) callconv(.c) void;
    pub inline fn setLabel(self: *PipelineLayout, label: []const u8) void { return wgpuPipelineLayoutSetLabel(self, label); }
    extern fn wgpuPipelineLayoutAddRef(self: *PipelineLayout) callconv(.c) void;
    pub inline fn addRef(self: *PipelineLayout) void { return wgpuPipelineLayoutAddRef(self); }
    extern fn wgpuPipelineLayoutRelease(self: *PipelineLayout) callconv(.c) void;
    pub inline fn release(self: *PipelineLayout) void { return wgpuPipelineLayoutRelease(self); }
};

pub const QuerySet = opaque {
    extern fn wgpuQuerySetSetLabel(self: *QuerySet, label: []const u8) callconv(.c) void;
    pub inline fn setLabel(self: *QuerySet, label: []const u8) void { return wgpuQuerySetSetLabel(self, label); }
    extern fn wgpuQuerySetGetType(self: *QuerySet) callconv(.c) QueryType;
    pub inline fn getType(self: *QuerySet) QueryType { return wgpuQuerySetGetType(self); }
    extern fn wgpuQuerySetGetCount(self: *QuerySet) callconv(.c) u32;
    pub inline fn getCount(self: *QuerySet) u32 { return wgpuQuerySetGetCount(self); }
    extern fn wgpuQuerySetDestroy(self: *QuerySet) callconv(.c) void;
    pub inline fn destroy(self: *QuerySet) void { return wgpuQuerySetDestroy(self); }
    extern fn wgpuQuerySetAddRef(self: *QuerySet) callconv(.c) void;
    pub inline fn addRef(self: *QuerySet) void { return wgpuQuerySetAddRef(self); }
    extern fn wgpuQuerySetRelease(self: *QuerySet) callconv(.c) void;
    pub inline fn release(self: *QuerySet) void { return wgpuQuerySetRelease(self); }
};

pub const Queue = opaque {
    extern fn wgpuQueueSubmit(self: *Queue, commands: *const []*CommandBuffer) callconv(.c) void;
    pub inline fn submit(self: *Queue, commands: *const []*CommandBuffer) void { return wgpuQueueSubmit(self, commands); }
    extern fn wgpuQueueOnSubmittedWorkDone(self: *Queue, callback: QueueWorkDoneCallbackInfo) callconv(.c) void;
    pub inline fn onSubmittedWorkDone(self: *Queue, callback: QueueWorkDoneCallbackInfo) void { return wgpuQueueOnSubmittedWorkDone(self, callback); }
    extern fn wgpuQueueWriteBuffer(self: *Queue, buffer: *Buffer, bufferOffset: u64, data: *const anyopaque, size: usize) callconv(.c) void;
    /// Produces a @ref DeviceError both content-timeline (`size` alignment) and device-timeline
    /// errors defined by the WebGPU specification.
    pub inline fn writeBuffer(self: *Queue, buffer: *Buffer, bufferOffset: u64, data: *const anyopaque, size: usize) void { return wgpuQueueWriteBuffer(self, buffer, bufferOffset, data, size); }
    extern fn wgpuQueueWriteTexture(self: *Queue, destination: *const TexelCopyTextureInfo, data: *const anyopaque, dataSize: usize, dataLayout: *const TexelCopyBufferLayout, writeSize: *const Extent3D) callconv(.c) void;
    pub inline fn writeTexture(self: *Queue, destination: *const TexelCopyTextureInfo, data: *const anyopaque, dataSize: usize, dataLayout: *const TexelCopyBufferLayout, writeSize: *const Extent3D) void { return wgpuQueueWriteTexture(self, destination, data, dataSize, dataLayout, writeSize); }
    extern fn wgpuQueueSetLabel(self: *Queue, label: []const u8) callconv(.c) void;
    pub inline fn setLabel(self: *Queue, label: []const u8) void { return wgpuQueueSetLabel(self, label); }
    extern fn wgpuQueueAddRef(self: *Queue) callconv(.c) void;
    pub inline fn addRef(self: *Queue) void { return wgpuQueueAddRef(self); }
    extern fn wgpuQueueRelease(self: *Queue) callconv(.c) void;
    pub inline fn release(self: *Queue) void { return wgpuQueueRelease(self); }
};

pub const RenderBundle = opaque {
    extern fn wgpuRenderBundleSetLabel(self: *RenderBundle, label: []const u8) callconv(.c) void;
    pub inline fn setLabel(self: *RenderBundle, label: []const u8) void { return wgpuRenderBundleSetLabel(self, label); }
    extern fn wgpuRenderBundleAddRef(self: *RenderBundle) callconv(.c) void;
    pub inline fn addRef(self: *RenderBundle) void { return wgpuRenderBundleAddRef(self); }
    extern fn wgpuRenderBundleRelease(self: *RenderBundle) callconv(.c) void;
    pub inline fn release(self: *RenderBundle) void { return wgpuRenderBundleRelease(self); }
};

pub const RenderBundleEncoder = opaque {
    extern fn wgpuRenderBundleEncoderSetPipeline(self: *RenderBundleEncoder, pipeline: *RenderPipeline) callconv(.c) void;
    pub inline fn setPipeline(self: *RenderBundleEncoder, pipeline: *RenderPipeline) void { return wgpuRenderBundleEncoderSetPipeline(self, pipeline); }
    extern fn wgpuRenderBundleEncoderSetBindGroup(self: *RenderBundleEncoder, groupIndex: u32, group: ?*BindGroup, dynamicOffsets: *const []u32) callconv(.c) void;
    pub inline fn setBindGroup(self: *RenderBundleEncoder, groupIndex: u32, group: ?*BindGroup, dynamicOffsets: *const []u32) void { return wgpuRenderBundleEncoderSetBindGroup(self, groupIndex, group, dynamicOffsets); }
    extern fn wgpuRenderBundleEncoderDraw(self: *RenderBundleEncoder, vertexCount: u32, instanceCount: u32, firstVertex: u32, firstInstance: u32) callconv(.c) void;
    pub inline fn draw(self: *RenderBundleEncoder, vertexCount: u32, instanceCount: u32, firstVertex: u32, firstInstance: u32) void { return wgpuRenderBundleEncoderDraw(self, vertexCount, instanceCount, firstVertex, firstInstance); }
    extern fn wgpuRenderBundleEncoderDrawIndexed(self: *RenderBundleEncoder, indexCount: u32, instanceCount: u32, firstIndex: u32, baseVertex: i32, firstInstance: u32) callconv(.c) void;
    pub inline fn drawIndexed(self: *RenderBundleEncoder, indexCount: u32, instanceCount: u32, firstIndex: u32, baseVertex: i32, firstInstance: u32) void { return wgpuRenderBundleEncoderDrawIndexed(self, indexCount, instanceCount, firstIndex, baseVertex, firstInstance); }
    extern fn wgpuRenderBundleEncoderDrawIndirect(self: *RenderBundleEncoder, indirectBuffer: *Buffer, indirectOffset: u64) callconv(.c) void;
    pub inline fn drawIndirect(self: *RenderBundleEncoder, indirectBuffer: *Buffer, indirectOffset: u64) void { return wgpuRenderBundleEncoderDrawIndirect(self, indirectBuffer, indirectOffset); }
    extern fn wgpuRenderBundleEncoderDrawIndexedIndirect(self: *RenderBundleEncoder, indirectBuffer: *Buffer, indirectOffset: u64) callconv(.c) void;
    pub inline fn drawIndexedIndirect(self: *RenderBundleEncoder, indirectBuffer: *Buffer, indirectOffset: u64) void { return wgpuRenderBundleEncoderDrawIndexedIndirect(self, indirectBuffer, indirectOffset); }
    extern fn wgpuRenderBundleEncoderInsertDebugMarker(self: *RenderBundleEncoder, markerLabel: []const u8) callconv(.c) void;
    pub inline fn insertDebugMarker(self: *RenderBundleEncoder, markerLabel: []const u8) void { return wgpuRenderBundleEncoderInsertDebugMarker(self, markerLabel); }
    extern fn wgpuRenderBundleEncoderPopDebugGroup(self: *RenderBundleEncoder) callconv(.c) void;
    pub inline fn popDebugGroup(self: *RenderBundleEncoder) void { return wgpuRenderBundleEncoderPopDebugGroup(self); }
    extern fn wgpuRenderBundleEncoderPushDebugGroup(self: *RenderBundleEncoder, groupLabel: []const u8) callconv(.c) void;
    pub inline fn pushDebugGroup(self: *RenderBundleEncoder, groupLabel: []const u8) void { return wgpuRenderBundleEncoderPushDebugGroup(self, groupLabel); }
    extern fn wgpuRenderBundleEncoderSetVertexBuffer(self: *RenderBundleEncoder, slot: u32, buffer: ?*Buffer, offset: u64, size: u64) callconv(.c) void;
    pub inline fn setVertexBuffer(self: *RenderBundleEncoder, slot: u32, buffer: ?*Buffer, offset: u64, size: u64) void { return wgpuRenderBundleEncoderSetVertexBuffer(self, slot, buffer, offset, size); }
    extern fn wgpuRenderBundleEncoderSetIndexBuffer(self: *RenderBundleEncoder, buffer: *Buffer, format: IndexFormat, offset: u64, size: u64) callconv(.c) void;
    pub inline fn setIndexBuffer(self: *RenderBundleEncoder, buffer: *Buffer, format: IndexFormat, offset: u64, size: u64) void { return wgpuRenderBundleEncoderSetIndexBuffer(self, buffer, format, offset, size); }
    extern fn wgpuRenderBundleEncoderFinish(self: *RenderBundleEncoder, descriptor: ?*const RenderBundleDescriptor) callconv(.c) *RenderBundle;
    pub inline fn finish(self: *RenderBundleEncoder, descriptor: ?*const RenderBundleDescriptor) *RenderBundle { return wgpuRenderBundleEncoderFinish(self, descriptor); }
    extern fn wgpuRenderBundleEncoderSetLabel(self: *RenderBundleEncoder, label: []const u8) callconv(.c) void;
    pub inline fn setLabel(self: *RenderBundleEncoder, label: []const u8) void { return wgpuRenderBundleEncoderSetLabel(self, label); }
    extern fn wgpuRenderBundleEncoderAddRef(self: *RenderBundleEncoder) callconv(.c) void;
    pub inline fn addRef(self: *RenderBundleEncoder) void { return wgpuRenderBundleEncoderAddRef(self); }
    extern fn wgpuRenderBundleEncoderRelease(self: *RenderBundleEncoder) callconv(.c) void;
    pub inline fn release(self: *RenderBundleEncoder) void { return wgpuRenderBundleEncoderRelease(self); }
};

pub const RenderPassEncoder = opaque {
    extern fn wgpuRenderPassEncoderSetPipeline(self: *RenderPassEncoder, pipeline: *RenderPipeline) callconv(.c) void;
    pub inline fn setPipeline(self: *RenderPassEncoder, pipeline: *RenderPipeline) void { return wgpuRenderPassEncoderSetPipeline(self, pipeline); }
    extern fn wgpuRenderPassEncoderSetBindGroup(self: *RenderPassEncoder, groupIndex: u32, group: ?*BindGroup, dynamicOffsets: *const []u32) callconv(.c) void;
    pub inline fn setBindGroup(self: *RenderPassEncoder, groupIndex: u32, group: ?*BindGroup, dynamicOffsets: *const []u32) void { return wgpuRenderPassEncoderSetBindGroup(self, groupIndex, group, dynamicOffsets); }
    extern fn wgpuRenderPassEncoderDraw(self: *RenderPassEncoder, vertexCount: u32, instanceCount: u32, firstVertex: u32, firstInstance: u32) callconv(.c) void;
    pub inline fn draw(self: *RenderPassEncoder, vertexCount: u32, instanceCount: u32, firstVertex: u32, firstInstance: u32) void { return wgpuRenderPassEncoderDraw(self, vertexCount, instanceCount, firstVertex, firstInstance); }
    extern fn wgpuRenderPassEncoderDrawIndexed(self: *RenderPassEncoder, indexCount: u32, instanceCount: u32, firstIndex: u32, baseVertex: i32, firstInstance: u32) callconv(.c) void;
    pub inline fn drawIndexed(self: *RenderPassEncoder, indexCount: u32, instanceCount: u32, firstIndex: u32, baseVertex: i32, firstInstance: u32) void { return wgpuRenderPassEncoderDrawIndexed(self, indexCount, instanceCount, firstIndex, baseVertex, firstInstance); }
    extern fn wgpuRenderPassEncoderDrawIndirect(self: *RenderPassEncoder, indirectBuffer: *Buffer, indirectOffset: u64) callconv(.c) void;
    pub inline fn drawIndirect(self: *RenderPassEncoder, indirectBuffer: *Buffer, indirectOffset: u64) void { return wgpuRenderPassEncoderDrawIndirect(self, indirectBuffer, indirectOffset); }
    extern fn wgpuRenderPassEncoderDrawIndexedIndirect(self: *RenderPassEncoder, indirectBuffer: *Buffer, indirectOffset: u64) callconv(.c) void;
    pub inline fn drawIndexedIndirect(self: *RenderPassEncoder, indirectBuffer: *Buffer, indirectOffset: u64) void { return wgpuRenderPassEncoderDrawIndexedIndirect(self, indirectBuffer, indirectOffset); }
    extern fn wgpuRenderPassEncoderExecuteBundles(self: *RenderPassEncoder, bundles: *const []*RenderBundle) callconv(.c) void;
    pub inline fn executeBundles(self: *RenderPassEncoder, bundles: *const []*RenderBundle) void { return wgpuRenderPassEncoderExecuteBundles(self, bundles); }
    extern fn wgpuRenderPassEncoderInsertDebugMarker(self: *RenderPassEncoder, markerLabel: []const u8) callconv(.c) void;
    pub inline fn insertDebugMarker(self: *RenderPassEncoder, markerLabel: []const u8) void { return wgpuRenderPassEncoderInsertDebugMarker(self, markerLabel); }
    extern fn wgpuRenderPassEncoderPopDebugGroup(self: *RenderPassEncoder) callconv(.c) void;
    pub inline fn popDebugGroup(self: *RenderPassEncoder) void { return wgpuRenderPassEncoderPopDebugGroup(self); }
    extern fn wgpuRenderPassEncoderPushDebugGroup(self: *RenderPassEncoder, groupLabel: []const u8) callconv(.c) void;
    pub inline fn pushDebugGroup(self: *RenderPassEncoder, groupLabel: []const u8) void { return wgpuRenderPassEncoderPushDebugGroup(self, groupLabel); }
    extern fn wgpuRenderPassEncoderSetStencilReference(self: *RenderPassEncoder, reference: u32) callconv(.c) void;
    pub inline fn setStencilReference(self: *RenderPassEncoder, reference: u32) void { return wgpuRenderPassEncoderSetStencilReference(self, reference); }
    extern fn wgpuRenderPassEncoderSetBlendConstant(self: *RenderPassEncoder, color: *const Color) callconv(.c) void;
    pub inline fn setBlendConstant(self: *RenderPassEncoder, color: *const Color) void { return wgpuRenderPassEncoderSetBlendConstant(self, color); }
    extern fn wgpuRenderPassEncoderSetViewport(self: *RenderPassEncoder, x: f32, y: f32, width: f32, height: f32, minDepth: f32, maxDepth: f32) callconv(.c) void;
    pub inline fn setViewport(self: *RenderPassEncoder, x: f32, y: f32, width: f32, height: f32, minDepth: f32, maxDepth: f32) void { return wgpuRenderPassEncoderSetViewport(self, x, y, width, height, minDepth, maxDepth); }
    extern fn wgpuRenderPassEncoderSetScissorRect(self: *RenderPassEncoder, x: u32, y: u32, width: u32, height: u32) callconv(.c) void;
    pub inline fn setScissorRect(self: *RenderPassEncoder, x: u32, y: u32, width: u32, height: u32) void { return wgpuRenderPassEncoderSetScissorRect(self, x, y, width, height); }
    extern fn wgpuRenderPassEncoderSetVertexBuffer(self: *RenderPassEncoder, slot: u32, buffer: ?*Buffer, offset: u64, size: u64) callconv(.c) void;
    pub inline fn setVertexBuffer(self: *RenderPassEncoder, slot: u32, buffer: ?*Buffer, offset: u64, size: u64) void { return wgpuRenderPassEncoderSetVertexBuffer(self, slot, buffer, offset, size); }
    extern fn wgpuRenderPassEncoderSetIndexBuffer(self: *RenderPassEncoder, buffer: *Buffer, format: IndexFormat, offset: u64, size: u64) callconv(.c) void;
    pub inline fn setIndexBuffer(self: *RenderPassEncoder, buffer: *Buffer, format: IndexFormat, offset: u64, size: u64) void { return wgpuRenderPassEncoderSetIndexBuffer(self, buffer, format, offset, size); }
    extern fn wgpuRenderPassEncoderBeginOcclusionQuery(self: *RenderPassEncoder, queryIndex: u32) callconv(.c) void;
    pub inline fn beginOcclusionQuery(self: *RenderPassEncoder, queryIndex: u32) void { return wgpuRenderPassEncoderBeginOcclusionQuery(self, queryIndex); }
    extern fn wgpuRenderPassEncoderEndOcclusionQuery(self: *RenderPassEncoder) callconv(.c) void;
    pub inline fn endOcclusionQuery(self: *RenderPassEncoder) void { return wgpuRenderPassEncoderEndOcclusionQuery(self); }
    extern fn wgpuRenderPassEncoderEnd(self: *RenderPassEncoder) callconv(.c) void;
    pub inline fn end(self: *RenderPassEncoder) void { return wgpuRenderPassEncoderEnd(self); }
    extern fn wgpuRenderPassEncoderSetLabel(self: *RenderPassEncoder, label: []const u8) callconv(.c) void;
    pub inline fn setLabel(self: *RenderPassEncoder, label: []const u8) void { return wgpuRenderPassEncoderSetLabel(self, label); }
    extern fn wgpuRenderPassEncoderAddRef(self: *RenderPassEncoder) callconv(.c) void;
    pub inline fn addRef(self: *RenderPassEncoder) void { return wgpuRenderPassEncoderAddRef(self); }
    extern fn wgpuRenderPassEncoderRelease(self: *RenderPassEncoder) callconv(.c) void;
    pub inline fn release(self: *RenderPassEncoder) void { return wgpuRenderPassEncoderRelease(self); }
};

pub const RenderPipeline = opaque {
    extern fn wgpuRenderPipelineGetBindGroupLayout(self: *RenderPipeline, groupIndex: u32) callconv(.c) *BindGroupLayout;
    pub inline fn getBindGroupLayout(self: *RenderPipeline, groupIndex: u32) *BindGroupLayout { return wgpuRenderPipelineGetBindGroupLayout(self, groupIndex); }
    extern fn wgpuRenderPipelineSetLabel(self: *RenderPipeline, label: []const u8) callconv(.c) void;
    pub inline fn setLabel(self: *RenderPipeline, label: []const u8) void { return wgpuRenderPipelineSetLabel(self, label); }
    extern fn wgpuRenderPipelineAddRef(self: *RenderPipeline) callconv(.c) void;
    pub inline fn addRef(self: *RenderPipeline) void { return wgpuRenderPipelineAddRef(self); }
    extern fn wgpuRenderPipelineRelease(self: *RenderPipeline) callconv(.c) void;
    pub inline fn release(self: *RenderPipeline) void { return wgpuRenderPipelineRelease(self); }
};

pub const Sampler = opaque {
    extern fn wgpuSamplerSetLabel(self: *Sampler, label: []const u8) callconv(.c) void;
    pub inline fn setLabel(self: *Sampler, label: []const u8) void { return wgpuSamplerSetLabel(self, label); }
    extern fn wgpuSamplerAddRef(self: *Sampler) callconv(.c) void;
    pub inline fn addRef(self: *Sampler) void { return wgpuSamplerAddRef(self); }
    extern fn wgpuSamplerRelease(self: *Sampler) callconv(.c) void;
    pub inline fn release(self: *Sampler) void { return wgpuSamplerRelease(self); }
};

pub const ShaderModule = opaque {
    extern fn wgpuShaderModuleGetCompilationInfo(self: *ShaderModule, callback: CompilationInfoCallbackInfo) callconv(.c) void;
    pub inline fn getCompilationInfo(self: *ShaderModule, callback: CompilationInfoCallbackInfo) void { return wgpuShaderModuleGetCompilationInfo(self, callback); }
    extern fn wgpuShaderModuleSetLabel(self: *ShaderModule, label: []const u8) callconv(.c) void;
    pub inline fn setLabel(self: *ShaderModule, label: []const u8) void { return wgpuShaderModuleSetLabel(self, label); }
    extern fn wgpuShaderModuleAddRef(self: *ShaderModule) callconv(.c) void;
    pub inline fn addRef(self: *ShaderModule) void { return wgpuShaderModuleAddRef(self); }
    extern fn wgpuShaderModuleRelease(self: *ShaderModule) callconv(.c) void;
    pub inline fn release(self: *ShaderModule) void { return wgpuShaderModuleRelease(self); }
};

pub const Surface = opaque {
    extern fn wgpuSurfaceConfigure(self: *Surface, config: *const SurfaceConfiguration) callconv(.c) void;
    /// Configures parameters for rendering to `surface`.
    /// Produces a @ref DeviceError for all content-timeline errors defined by the WebGPU specification.
    /// 
    /// See @ref Surface-Configuration for more details.
    pub inline fn configure(self: *Surface, config: *const SurfaceConfiguration) void { return wgpuSurfaceConfigure(self, config); }
    extern fn wgpuSurfaceGetCapabilities(self: *Surface, adapter: *Adapter, capabilities: *SurfaceCapabilities) callconv(.c) Status;
    /// Provides information on how `adapter` is able to use `surface`.
    /// See @ref Surface-Capabilities for more details.
    pub inline fn getCapabilities(self: *Surface, adapter: *Adapter, capabilities: *SurfaceCapabilities) Status { return wgpuSurfaceGetCapabilities(self, adapter, capabilities); }
    extern fn wgpuSurfaceGetCurrentTexture(self: *Surface, surfaceTexture: *SurfaceTexture) callconv(.c) void;
    /// Returns the @ref WGPUTexture to render to `surface` this frame along with metadata on the frame.
    /// Returns `NULL` and @ref WGPUSurfaceGetCurrentTextureStatus_Error if the surface is not configured.
    /// 
    /// See @ref Surface-Presenting for more details.
    pub inline fn getCurrentTexture(self: *Surface, surfaceTexture: *SurfaceTexture) void { return wgpuSurfaceGetCurrentTexture(self, surfaceTexture); }
    extern fn wgpuSurfacePresent(self: *Surface) callconv(.c) Status;
    /// Shows `surface`'s current texture to the user.
    /// See @ref Surface-Presenting for more details.
    pub inline fn present(self: *Surface) Status { return wgpuSurfacePresent(self); }
    extern fn wgpuSurfaceUnconfigure(self: *Surface) callconv(.c) void;
    /// Removes the configuration for `surface`.
    /// See @ref Surface-Configuration for more details.
    pub inline fn unconfigure(self: *Surface) void { return wgpuSurfaceUnconfigure(self); }
    extern fn wgpuSurfaceSetLabel(self: *Surface, label: []const u8) callconv(.c) void;
    /// Modifies the label used to refer to `surface`.
    pub inline fn setLabel(self: *Surface, label: []const u8) void { return wgpuSurfaceSetLabel(self, label); }
    extern fn wgpuSurfaceAddRef(self: *Surface) callconv(.c) void;
    pub inline fn addRef(self: *Surface) void { return wgpuSurfaceAddRef(self); }
    extern fn wgpuSurfaceRelease(self: *Surface) callconv(.c) void;
    pub inline fn release(self: *Surface) void { return wgpuSurfaceRelease(self); }
};

pub const Texture = opaque {
    extern fn wgpuTextureCreateView(self: *Texture, descriptor: ?*const TextureViewDescriptor) callconv(.c) *TextureView;
    pub inline fn createView(self: *Texture, descriptor: ?*const TextureViewDescriptor) *TextureView { return wgpuTextureCreateView(self, descriptor); }
    extern fn wgpuTextureSetLabel(self: *Texture, label: []const u8) callconv(.c) void;
    pub inline fn setLabel(self: *Texture, label: []const u8) void { return wgpuTextureSetLabel(self, label); }
    extern fn wgpuTextureGetWidth(self: *Texture) callconv(.c) u32;
    pub inline fn getWidth(self: *Texture) u32 { return wgpuTextureGetWidth(self); }
    extern fn wgpuTextureGetHeight(self: *Texture) callconv(.c) u32;
    pub inline fn getHeight(self: *Texture) u32 { return wgpuTextureGetHeight(self); }
    extern fn wgpuTextureGetDepthOrArrayLayers(self: *Texture) callconv(.c) u32;
    pub inline fn getDepthOrArrayLayers(self: *Texture) u32 { return wgpuTextureGetDepthOrArrayLayers(self); }
    extern fn wgpuTextureGetMipLevelCount(self: *Texture) callconv(.c) u32;
    pub inline fn getMipLevelCount(self: *Texture) u32 { return wgpuTextureGetMipLevelCount(self); }
    extern fn wgpuTextureGetSampleCount(self: *Texture) callconv(.c) u32;
    pub inline fn getSampleCount(self: *Texture) u32 { return wgpuTextureGetSampleCount(self); }
    extern fn wgpuTextureGetDimension(self: *Texture) callconv(.c) TextureDimension;
    pub inline fn getDimension(self: *Texture) TextureDimension { return wgpuTextureGetDimension(self); }
    extern fn wgpuTextureGetFormat(self: *Texture) callconv(.c) TextureFormat;
    pub inline fn getFormat(self: *Texture) TextureFormat { return wgpuTextureGetFormat(self); }
    extern fn wgpuTextureGetUsage(self: *Texture) callconv(.c) TextureUsage;
    pub inline fn getUsage(self: *Texture) TextureUsage { return wgpuTextureGetUsage(self); }
    extern fn wgpuTextureDestroy(self: *Texture) callconv(.c) void;
    pub inline fn destroy(self: *Texture) void { return wgpuTextureDestroy(self); }
    extern fn wgpuTextureAddRef(self: *Texture) callconv(.c) void;
    pub inline fn addRef(self: *Texture) void { return wgpuTextureAddRef(self); }
    extern fn wgpuTextureRelease(self: *Texture) callconv(.c) void;
    pub inline fn release(self: *Texture) void { return wgpuTextureRelease(self); }
};

pub const TextureView = opaque {
    extern fn wgpuTextureViewSetLabel(self: *TextureView, label: []const u8) callconv(.c) void;
    pub inline fn setLabel(self: *TextureView, label: []const u8) void { return wgpuTextureViewSetLabel(self, label); }
    extern fn wgpuTextureViewAddRef(self: *TextureView) callconv(.c) void;
    pub inline fn addRef(self: *TextureView) void { return wgpuTextureViewAddRef(self); }
    extern fn wgpuTextureViewRelease(self: *TextureView) callconv(.c) void;
    pub inline fn release(self: *TextureView) void { return wgpuTextureViewRelease(self); }
};
