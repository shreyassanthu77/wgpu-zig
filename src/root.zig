// GENERATED FILE, DO NOT EDIT
//! Copyright 2019-2023 WebGPU-Native developers
//!
//! SPDX-License-Identifier: BSD-3-Clause

/// The c export is will give you direct access to the webgpu header
pub const c = @import("c");

const std = @import("std");

pub const StringView = extern struct {
    data: [*c]const u8,
    length: usize,

    const empty = from("");

    const null_ = StringView{ .data = null, .length = 0 };

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
};

pub const ARRAY_LAYER_COUNT_UNDEFINED = std.math.maxInt(u32);

pub const COPY_STRIDE_UNDEFINED = std.math.maxInt(u32);

pub const DEPTH_SLICE_UNDEFINED = std.math.maxInt(u32);

pub const LIMIT_U32_UNDEFINED = std.math.maxInt(u32);

pub const LIMIT_U64_UNDEFINED = std.math.maxInt(u64);

pub const MIP_LEVEL_COUNT_UNDEFINED = std.math.maxInt(u32);

pub const QUERY_SET_INDEX_UNDEFINED = std.math.maxInt(u32);

pub const WHOLE_MAP_SIZE = std.math.maxInt(usize);

pub const WHOLE_SIZE = std.math.maxInt(u64);

pub const AdapterType = enum(u32) {
    discrete_gpu = 1,
    integrated_gpu = 2,
    cpu = 3,
    unknown = 4,
    _,
};

pub const AddressMode = enum(u32) {
    /// Indicates no value is passed for this argument. See @ref SentinelValues.
    undefined = 0,
    clamp_to_edge = 1,
    repeat = 2,
    mirror_repeat = 3,
    _,
};

pub const BackendType = enum(u32) {
    /// Indicates no value is passed for this argument. See @ref SentinelValues.
    undefined = 0,
    null = 1,
    web_gpu = 2,
    d_3_d_11 = 3,
    d_3_d_12 = 4,
    metal = 5,
    vulkan = 6,
    open_gl = 7,
    open_gles = 8,
    _,
};

pub const BlendFactor = enum(u32) {
    /// Indicates no value is passed for this argument. See @ref SentinelValues.
    undefined = 0,
    zero = 1,
    one = 2,
    src = 3,
    one_minus_src = 4,
    src_alpha = 5,
    one_minus_src_alpha = 6,
    dst = 7,
    one_minus_dst = 8,
    dst_alpha = 9,
    one_minus_dst_alpha = 10,
    src_alpha_saturated = 11,
    constant = 12,
    one_minus_constant = 13,
    src_1 = 14,
    one_minus_src_1 = 15,
    src_1_alpha = 16,
    one_minus_src_1_alpha = 17,
    _,
};

pub const BlendOperation = enum(u32) {
    /// Indicates no value is passed for this argument. See @ref SentinelValues.
    undefined = 0,
    add = 1,
    subtract = 2,
    reverse_subtract = 3,
    min = 4,
    max = 5,
    _,
};

pub const BufferBindingType = enum(u32) {
    /// Indicates that this @ref WGPUBufferBindingLayout member of
    /// its parent @ref WGPUBindGroupLayoutEntry is not used.
    /// (See also @ref SentinelValues.)
    binding_not_used = 0,
    /// Indicates no value is passed for this argument. See @ref SentinelValues.
    undefined = 1,
    uniform = 2,
    storage = 3,
    read_only_storage = 4,
    _,
};

pub const BufferMapState = enum(u32) {
    unmapped = 1,
    pending = 2,
    mapped = 3,
    _,
};

/// The callback mode controls how a callback for an asynchronous operation may be fired. See @ref Asynchronous-Operations for how these are used.
pub const CallbackMode = enum(u32) {
    /// Callbacks created with `WGPUCallbackMode_WaitAnyOnly`:
    /// - fire when the asynchronous operation's future is passed to a call to `::wgpuInstanceWaitAny`
    ///   AND the operation has already completed or it completes inside the call to `::wgpuInstanceWaitAny`.
    wait_any_only = 1,
    /// Callbacks created with `WGPUCallbackMode_AllowProcessEvents`:
    /// - fire for the same reasons as callbacks created with `WGPUCallbackMode_WaitAnyOnly`
    /// - fire inside a call to `::wgpuInstanceProcessEvents` if the asynchronous operation is complete.
    allow_process_events = 2,
    /// Callbacks created with `WGPUCallbackMode_AllowSpontaneous`:
    /// - fire for the same reasons as callbacks created with `WGPUCallbackMode_AllowProcessEvents`
    /// - **may** fire spontaneously on an arbitrary or application thread, when the WebGPU implementations discovers that the asynchronous operation is complete.
    ///
    ///   Implementations _should_ fire spontaneous callbacks as soon as possible.
    ///
    /// @note Because spontaneous callbacks may fire at an arbitrary time on an arbitrary thread, applications should take extra care when acquiring locks or mutating state inside the callback. It undefined behavior to re-entrantly call into the webgpu.h API if the callback fires while inside the callstack of another webgpu.h function that is not `wgpuInstanceWaitAny` or `wgpuInstanceProcessEvents`.
    allow_spontaneous = 3,
    _,
};

pub const CompareFunction = enum(u32) {
    /// Indicates no value is passed for this argument. See @ref SentinelValues.
    undefined = 0,
    never = 1,
    less = 2,
    equal = 3,
    less_equal = 4,
    greater = 5,
    not_equal = 6,
    greater_equal = 7,
    always = 8,
    _,
};

pub const CompilationInfoRequestStatus = enum(u32) {
    success = 1,
    instance_dropped = 2,
    @"error" = 3,
    unknown = 4,
    _,
};

pub const CompilationMessageType = enum(u32) {
    @"error" = 1,
    warning = 2,
    info = 3,
    _,
};

/// Describes how frames are composited with other contents on the screen when `::wgpuSurfacePresent` is called.
pub const CompositeAlphaMode = enum(u32) {
    /// Lets the WebGPU implementation choose the best mode (supported, and with the best performance) between @ref WGPUCompositeAlphaMode_Opaque or @ref WGPUCompositeAlphaMode_Inherit.
    auto = 0,
    /// The alpha component of the image is ignored and teated as if it is always 1.0.
    @"opaque" = 1,
    /// The alpha component is respected and non-alpha components are assumed to be already multiplied with the alpha component. For example, (0.5, 0, 0, 0.5) is semi-transparent bright red.
    premultiplied = 2,
    /// The alpha component is respected and non-alpha components are assumed to NOT be already multiplied with the alpha component. For example, (1.0, 0, 0, 0.5) is semi-transparent bright red.
    unpremultiplied = 3,
    /// The handling of the alpha component is unknown to WebGPU and should be handled by the application using system-specific APIs. This mode may be unavailable (for example on Wasm).
    inherit = 4,
    _,
};

pub const CreatePipelineAsyncStatus = enum(u32) {
    success = 1,
    instance_dropped = 2,
    validation_error = 3,
    internal_error = 4,
    unknown = 5,
    _,
};

pub const CullMode = enum(u32) {
    /// Indicates no value is passed for this argument. See @ref SentinelValues.
    undefined = 0,
    none = 1,
    front = 2,
    back = 3,
    _,
};

pub const DeviceLostReason = enum(u32) {
    unknown = 1,
    destroyed = 2,
    instance_dropped = 3,
    failed_creation = 4,
    _,
};

pub const ErrorFilter = enum(u32) {
    validation = 1,
    out_of_memory = 2,
    internal = 3,
    _,
};

pub const ErrorType = enum(u32) {
    no_error = 1,
    validation = 2,
    out_of_memory = 3,
    internal = 4,
    unknown = 5,
    _,
};

/// See @ref WGPURequestAdapterOptions::featureLevel.
pub const FeatureLevel = enum(u32) {
    /// "Compatibility" profile which can be supported on OpenGL ES 3.1.
    compatibility = 1,
    /// "Core" profile which can be supported on Vulkan/Metal/D3D12.
    core = 2,
    _,
};

pub const FeatureName = enum(u32) {
    undefined = 0,
    depth_clip_control = 1,
    depth_32_float_stencil_8 = 2,
    timestamp_query = 3,
    texture_compression_bc = 4,
    texture_compression_bc_sliced_3_d = 5,
    texture_compression_etc_2 = 6,
    texture_compression_astc = 7,
    texture_compression_astc_sliced_3_d = 8,
    indirect_first_instance = 9,
    shader_f_16 = 10,
    rg_11_b_10_ufloat_renderable = 11,
    bgra_8_unorm_storage = 12,
    float_32_filterable = 13,
    float_32_blendable = 14,
    clip_distances = 15,
    dual_source_blending = 16,
    _,
};

pub const FilterMode = enum(u32) {
    /// Indicates no value is passed for this argument. See @ref SentinelValues.
    undefined = 0,
    nearest = 1,
    linear = 2,
    _,
};

pub const FrontFace = enum(u32) {
    /// Indicates no value is passed for this argument. See @ref SentinelValues.
    undefined = 0,
    ccw = 1,
    cw = 2,
    _,
};

pub const IndexFormat = enum(u32) {
    /// Indicates no value is passed for this argument. See @ref SentinelValues.
    undefined = 0,
    uint_16 = 1,
    uint_32 = 2,
    _,
};

pub const LoadOp = enum(u32) {
    /// Indicates no value is passed for this argument. See @ref SentinelValues.
    undefined = 0,
    load = 1,
    clear = 2,
    _,
};

pub const MapAsyncStatus = enum(u32) {
    success = 1,
    instance_dropped = 2,
    @"error" = 3,
    aborted = 4,
    unknown = 5,
    _,
};

pub const MipmapFilterMode = enum(u32) {
    /// Indicates no value is passed for this argument. See @ref SentinelValues.
    undefined = 0,
    nearest = 1,
    linear = 2,
    _,
};

pub const OptionalBool = enum(u32) {
    false = 0,
    true = 1,
    undefined = 2,
    _,
};

pub const PopErrorScopeStatus = enum(u32) {
    /// The error scope stack was successfully popped and a result was reported.
    success = 1,
    instance_dropped = 2,
    /// The error scope stack could not be popped, because it was empty.
    empty_stack = 3,
    _,
};

pub const PowerPreference = enum(u32) {
    /// No preference. (See also @ref SentinelValues.)
    undefined = 0,
    low_power = 1,
    high_performance = 2,
    _,
};

/// Describes when and in which order frames are presented on the screen when `::wgpuSurfacePresent` is called.
pub const PresentMode = enum(u32) {
    /// Present mode is not specified. Use the default.
    undefined = 0,
    /// The presentation of the image to the user waits for the next vertical blanking period to update in a first-in, first-out manner.
    /// Tearing cannot be observed and frame-loop will be limited to the display's refresh rate.
    /// This is the only mode that's always available.
    fifo = 1,
    /// The presentation of the image to the user tries to wait for the next vertical blanking period but may decide to not wait if a frame is presented late.
    /// Tearing can sometimes be observed but late-frame don't produce a full-frame stutter in the presentation.
    /// This is still a first-in, first-out mechanism so a frame-loop will be limited to the display's refresh rate.
    fifo_relaxed = 2,
    /// The presentation of the image to the user is updated immediately without waiting for a vertical blank.
    /// Tearing can be observed but latency is minimized.
    immediate = 3,
    /// The presentation of the image to the user waits for the next vertical blanking period to update to the latest provided image.
    /// Tearing cannot be observed and a frame-loop is not limited to the display's refresh rate.
    mailbox = 4,
    _,
};

pub const PrimitiveTopology = enum(u32) {
    /// Indicates no value is passed for this argument. See @ref SentinelValues.
    undefined = 0,
    point_list = 1,
    line_list = 2,
    line_strip = 3,
    triangle_list = 4,
    triangle_strip = 5,
    _,
};

pub const QueryType = enum(u32) {
    occlusion = 1,
    timestamp = 2,
    _,
};

pub const QueueWorkDoneStatus = enum(u32) {
    success = 1,
    instance_dropped = 2,
    @"error" = 3,
    unknown = 4,
    _,
};

pub const RequestAdapterStatus = enum(u32) {
    success = 1,
    instance_dropped = 2,
    unavailable = 3,
    @"error" = 4,
    unknown = 5,
    _,
};

pub const RequestDeviceStatus = enum(u32) {
    success = 1,
    instance_dropped = 2,
    @"error" = 3,
    unknown = 4,
    _,
};

pub const SType = enum(u32) {
    shader_source_spirv = 1,
    shader_source_wgsl = 2,
    render_pass_max_draw_count = 3,
    surface_source_metal_layer = 4,
    surface_source_windows_hwnd = 5,
    surface_source_xlib_window = 6,
    surface_source_wayland_surface = 7,
    surface_source_android_native_window = 8,
    surface_source_xcb_window = 9,
    _,
};

pub const SamplerBindingType = enum(u32) {
    /// Indicates that this @ref WGPUSamplerBindingLayout member of
    /// its parent @ref WGPUBindGroupLayoutEntry is not used.
    /// (See also @ref SentinelValues.)
    binding_not_used = 0,
    /// Indicates no value is passed for this argument. See @ref SentinelValues.
    undefined = 1,
    filtering = 2,
    non_filtering = 3,
    comparison = 4,
    _,
};

/// Status code returned (synchronously) from many operations. Generally
/// indicates an invalid input like an unknown enum value or @ref OutStructChainError.
/// Read the function's documentation for specific error conditions.
pub const Status = enum(u32) {
    ///
    success = 1,
    ///
    @"error" = 2,
    _,
};

pub const StencilOperation = enum(u32) {
    /// Indicates no value is passed for this argument. See @ref SentinelValues.
    undefined = 0,
    keep = 1,
    zero = 2,
    replace = 3,
    invert = 4,
    increment_clamp = 5,
    decrement_clamp = 6,
    increment_wrap = 7,
    decrement_wrap = 8,
    _,
};

pub const StorageTextureAccess = enum(u32) {
    /// Indicates that this @ref WGPUStorageTextureBindingLayout member of
    /// its parent @ref WGPUBindGroupLayoutEntry is not used.
    /// (See also @ref SentinelValues.)
    binding_not_used = 0,
    /// Indicates no value is passed for this argument. See @ref SentinelValues.
    undefined = 1,
    write_only = 2,
    read_only = 3,
    read_write = 4,
    _,
};

pub const StoreOp = enum(u32) {
    /// Indicates no value is passed for this argument. See @ref SentinelValues.
    undefined = 0,
    store = 1,
    discard = 2,
    _,
};

/// The status enum for `::wgpuSurfaceGetCurrentTexture`.
pub const SurfaceGetCurrentTextureStatus = enum(u32) {
    /// Yay! Everything is good and we can render this frame.
    success_optimal = 1,
    /// Still OK - the surface can present the frame, but in a suboptimal way. The surface may need reconfiguration.
    success_suboptimal = 2,
    /// Some operation timed out while trying to acquire the frame.
    timeout = 3,
    /// The surface is too different to be used, compared to when it was originally created.
    outdated = 4,
    /// The connection to whatever owns the surface was lost.
    lost = 5,
    /// The system ran out of memory.
    out_of_memory = 6,
    /// The @ref WGPUDevice configured on the @ref WGPUSurface was lost.
    device_lost = 7,
    /// The surface is not configured, or there was an @ref OutStructChainError.
    @"error" = 8,
    _,
};

pub const TextureAspect = enum(u32) {
    /// Indicates no value is passed for this argument. See @ref SentinelValues.
    undefined = 0,
    all = 1,
    stencil_only = 2,
    depth_only = 3,
    _,
};

pub const TextureDimension = enum(u32) {
    /// Indicates no value is passed for this argument. See @ref SentinelValues.
    undefined = 0,
    @"1D" = 1,
    @"2D" = 2,
    @"3D" = 3,
    _,
};

pub const TextureFormat = enum(u32) {
    /// Indicates no value is passed for this argument. See @ref SentinelValues.
    undefined = 0,
    r_8_unorm = 1,
    r_8_snorm = 2,
    r_8_uint = 3,
    r_8_sint = 4,
    r_16_uint = 5,
    r_16_sint = 6,
    r_16_float = 7,
    rg_8_unorm = 8,
    rg_8_snorm = 9,
    rg_8_uint = 10,
    rg_8_sint = 11,
    r_32_float = 12,
    r_32_uint = 13,
    r_32_sint = 14,
    rg_16_uint = 15,
    rg_16_sint = 16,
    rg_16_float = 17,
    rgba_8_unorm = 18,
    rgba_8_unorm_srgb = 19,
    rgba_8_snorm = 20,
    rgba_8_uint = 21,
    rgba_8_sint = 22,
    bgra_8_unorm = 23,
    bgra_8_unorm_srgb = 24,
    rgb_10_a_2_uint = 25,
    rgb_10_a_2_unorm = 26,
    rg_11_b_10_ufloat = 27,
    rgb_9_e_5_ufloat = 28,
    rg_32_float = 29,
    rg_32_uint = 30,
    rg_32_sint = 31,
    rgba_16_uint = 32,
    rgba_16_sint = 33,
    rgba_16_float = 34,
    rgba_32_float = 35,
    rgba_32_uint = 36,
    rgba_32_sint = 37,
    stencil_8 = 38,
    depth_16_unorm = 39,
    depth_24_plus = 40,
    depth_24_plus_stencil_8 = 41,
    depth_32_float = 42,
    depth_32_float_stencil_8 = 43,
    bc_1_rgba_unorm = 44,
    bc_1_rgba_unorm_srgb = 45,
    bc_2_rgba_unorm = 46,
    bc_2_rgba_unorm_srgb = 47,
    bc_3_rgba_unorm = 48,
    bc_3_rgba_unorm_srgb = 49,
    bc_4_r_unorm = 50,
    bc_4_r_snorm = 51,
    bc_5_rg_unorm = 52,
    bc_5_rg_snorm = 53,
    bc_6_h_rgb_ufloat = 54,
    bc_6_h_rgb_float = 55,
    bc_7_rgba_unorm = 56,
    bc_7_rgba_unorm_srgb = 57,
    etc_2_rgb_8_unorm = 58,
    etc_2_rgb_8_unorm_srgb = 59,
    etc_2_rgb_8_a_1_unorm = 60,
    etc_2_rgb_8_a_1_unorm_srgb = 61,
    etc_2_rgba_8_unorm = 62,
    etc_2_rgba_8_unorm_srgb = 63,
    eac_r_11_unorm = 64,
    eac_r_11_snorm = 65,
    eac_rg_11_unorm = 66,
    eac_rg_11_snorm = 67,
    astc_4_x_4_unorm = 68,
    astc_4_x_4_unorm_srgb = 69,
    astc_5_x_4_unorm = 70,
    astc_5_x_4_unorm_srgb = 71,
    astc_5_x_5_unorm = 72,
    astc_5_x_5_unorm_srgb = 73,
    astc_6_x_5_unorm = 74,
    astc_6_x_5_unorm_srgb = 75,
    astc_6_x_6_unorm = 76,
    astc_6_x_6_unorm_srgb = 77,
    astc_8_x_5_unorm = 78,
    astc_8_x_5_unorm_srgb = 79,
    astc_8_x_6_unorm = 80,
    astc_8_x_6_unorm_srgb = 81,
    astc_8_x_8_unorm = 82,
    astc_8_x_8_unorm_srgb = 83,
    astc_10_x_5_unorm = 84,
    astc_10_x_5_unorm_srgb = 85,
    astc_10_x_6_unorm = 86,
    astc_10_x_6_unorm_srgb = 87,
    astc_10_x_8_unorm = 88,
    astc_10_x_8_unorm_srgb = 89,
    astc_10_x_10_unorm = 90,
    astc_10_x_10_unorm_srgb = 91,
    astc_12_x_10_unorm = 92,
    astc_12_x_10_unorm_srgb = 93,
    astc_12_x_12_unorm = 94,
    astc_12_x_12_unorm_srgb = 95,
    _,
};

pub const TextureSampleType = enum(u32) {
    /// Indicates that this @ref WGPUTextureBindingLayout member of
    /// its parent @ref WGPUBindGroupLayoutEntry is not used.
    /// (See also @ref SentinelValues.)
    binding_not_used = 0,
    /// Indicates no value is passed for this argument. See @ref SentinelValues.
    undefined = 1,
    float = 2,
    unfilterable_float = 3,
    depth = 4,
    sint = 5,
    uint = 6,
    _,
};

pub const TextureViewDimension = enum(u32) {
    /// Indicates no value is passed for this argument. See @ref SentinelValues.
    undefined = 0,
    @"1D" = 1,
    @"2D" = 2,
    @"2D_array" = 3,
    cube = 4,
    cube_array = 5,
    @"3D" = 6,
    _,
};

pub const VertexFormat = enum(u32) {
    uint_8 = 1,
    uint_8_x_2 = 2,
    uint_8_x_4 = 3,
    sint_8 = 4,
    sint_8_x_2 = 5,
    sint_8_x_4 = 6,
    unorm_8 = 7,
    unorm_8_x_2 = 8,
    unorm_8_x_4 = 9,
    snorm_8 = 10,
    snorm_8_x_2 = 11,
    snorm_8_x_4 = 12,
    uint_16 = 13,
    uint_16_x_2 = 14,
    uint_16_x_4 = 15,
    sint_16 = 16,
    sint_16_x_2 = 17,
    sint_16_x_4 = 18,
    unorm_16 = 19,
    unorm_16_x_2 = 20,
    unorm_16_x_4 = 21,
    snorm_16 = 22,
    snorm_16_x_2 = 23,
    snorm_16_x_4 = 24,
    float_16 = 25,
    float_16_x_2 = 26,
    float_16_x_4 = 27,
    float_32 = 28,
    float_32_x_2 = 29,
    float_32_x_3 = 30,
    float_32_x_4 = 31,
    uint_32 = 32,
    uint_32_x_2 = 33,
    uint_32_x_3 = 34,
    uint_32_x_4 = 35,
    sint_32 = 36,
    sint_32_x_2 = 37,
    sint_32_x_3 = 38,
    sint_32_x_4 = 39,
    unorm_10_10_10_2 = 40,
    unorm_8_x_4_b_g_r_a = 41,
    _,
};

pub const VertexStepMode = enum(u32) {
    /// This @ref WGPUVertexBufferLayout is a "hole" in the @ref WGPUVertexState `buffers` array.
    /// (See also @ref SentinelValues.)
    vertex_buffer_not_used = 0,
    /// Indicates no value is passed for this argument. See @ref SentinelValues.
    undefined = 1,
    vertex = 2,
    instance = 3,
    _,
};

/// Status returned from a call to ::wgpuInstanceWaitAny.
pub const WaitStatus = enum(u32) {
    /// At least one WGPUFuture completed successfully.
    success = 1,
    /// No WGPUFutures completed within the timeout.
    timed_out = 2,
    /// A @ref Timed-Wait was performed when WGPUInstanceFeatures::timedWaitAnyEnable is false.
    unsupported_timeout = 3,
    /// The number of futures waited on in a @ref Timed-Wait is greater than the supported WGPUInstanceFeatures::timedWaitAnyMaxCount.
    unsupported_count = 4,
    /// An invalid wait was performed with @ref Mixed-Sources.
    unsupported_mixed_sources = 5,
    _,
};

pub const WgslLanguageFeatureName = enum(u32) {
    readonly_and_readwrite_storage_textures = 1,
    packed_4_x_8_integer_dot_product = 2,
    unrestricted_pointer_parameters = 3,
    pointer_composite_access = 4,
    _,
};

pub const BufferUsage = enum(u64) {
    const _none: u64 = 0;
    const _map_read: u64 = 1;
    const _map_write: u64 = 2;
    const _copy_src: u64 = 4;
    const _copy_dst: u64 = 8;
    const _index: u64 = 16;
    const _vertex: u64 = 32;
    const _uniform: u64 = 64;
    const _storage: u64 = 128;
    const _indirect: u64 = 256;
    const _query_resolve: u64 = 512;
    none = _none,
    map_read = _map_read,
    map_write = _map_write,
    copy_src = _copy_src,
    copy_dst = _copy_dst,
    index = _index,
    vertex = _vertex,
    uniform = _uniform,
    storage = _storage,
    indirect = _indirect,
    query_resolve = _query_resolve,
    _,
};

pub const ColorWriteMask = enum(u64) {
    const _none: u64 = 0;
    const _red: u64 = 1;
    const _green: u64 = 2;
    const _blue: u64 = 4;
    const _alpha: u64 = 8;
    const _all: u64 = _red | _green | _blue | _alpha;
    none = _none,
    red = _red,
    green = _green,
    blue = _blue,
    alpha = _alpha,
    all = _all,
    _,
};

pub const MapMode = enum(u64) {
    const _none: u64 = 0;
    const _read: u64 = 1;
    const _write: u64 = 2;
    none = _none,
    read = _read,
    write = _write,
    _,
};

pub const ShaderStage = enum(u64) {
    const _none: u64 = 0;
    const _vertex: u64 = 1;
    const _fragment: u64 = 2;
    const _compute: u64 = 4;
    none = _none,
    vertex = _vertex,
    fragment = _fragment,
    compute = _compute,
    _,
};

pub const TextureUsage = enum(u64) {
    const _none: u64 = 0;
    const _copy_src: u64 = 1;
    const _copy_dst: u64 = 2;
    const _texture_binding: u64 = 4;
    const _storage_binding: u64 = 8;
    const _render_attachment: u64 = 16;
    none = _none,
    copy_src = _copy_src,
    copy_dst = _copy_dst,
    texture_binding = _texture_binding,
    storage_binding = _storage_binding,
    render_attachment = _render_attachment,
    _,
};

pub const Chained = extern struct {
    next: ?*const Chained,
    s_type: SType,
};

pub const AdapterInfo = extern struct {
    next_in_chain: ?*const Chained = null,
    vendor: StringView = std.mem.zeroes(StringView),
    architecture: StringView = std.mem.zeroes(StringView),
    device: StringView = std.mem.zeroes(StringView),
    description: StringView = std.mem.zeroes(StringView),
    backend_type: BackendType = std.mem.zeroes(BackendType),
    adapter_type: AdapterType = std.mem.zeroes(AdapterType),
    vendor_id: u32 = std.mem.zeroes(u32),
    device_id: u32 = std.mem.zeroes(u32),

    pub inline fn zero() AdapterInfo {
        return std.mem.zeroes(AdapterInfo);
    }
    extern fn wgpuAdapterInfoFreeMembers(self: AdapterInfo) callconv(.c) void;
    pub inline fn freeMembers(self: AdapterInfo) void {
        return wgpuAdapterInfoFreeMembers(self);
    }
};

pub const BindGroupDescriptor = extern struct {
    next_in_chain: ?*const Chained = null,
    label: StringView = .empty,
    layout: *BindGroupLayout,
    entries_count: usize = 0,
    entries: ?[*]const BindGroupEntry = null,

    pub inline fn zero() BindGroupDescriptor {
        return std.mem.zeroes(BindGroupDescriptor);
    }
};

pub const BindGroupEntry = extern struct {
    next_in_chain: ?*const Chained = null,
    binding: u32 = std.mem.zeroes(u32),
    buffer: ?*Buffer = null,
    offset: u64 = std.mem.zeroes(u64),
    size: u64 = std.mem.zeroes(u64),
    sampler: ?*Sampler = null,
    texture_view: ?*TextureView = null,

    pub inline fn zero() BindGroupEntry {
        return std.mem.zeroes(BindGroupEntry);
    }
};

pub const BindGroupLayoutDescriptor = extern struct {
    next_in_chain: ?*const Chained = null,
    label: StringView = .empty,
    entries_count: usize = 0,
    entries: ?[*]const BindGroupLayoutEntry = null,

    pub inline fn zero() BindGroupLayoutDescriptor {
        return std.mem.zeroes(BindGroupLayoutDescriptor);
    }
};

pub const BindGroupLayoutEntry = extern struct {
    next_in_chain: ?*const Chained = null,
    binding: u32 = std.mem.zeroes(u32),
    visibility: ShaderStage = std.mem.zeroes(ShaderStage),
    buffer: BufferBindingLayout = std.mem.zeroes(BufferBindingLayout),
    sampler: SamplerBindingLayout = std.mem.zeroes(SamplerBindingLayout),
    texture: TextureBindingLayout = std.mem.zeroes(TextureBindingLayout),
    storage_texture: StorageTextureBindingLayout = std.mem.zeroes(StorageTextureBindingLayout),

    pub inline fn zero() BindGroupLayoutEntry {
        return std.mem.zeroes(BindGroupLayoutEntry);
    }
};

pub const BlendComponent = extern struct {
    operation: BlendOperation = std.mem.zeroes(BlendOperation),
    src_factor: BlendFactor = std.mem.zeroes(BlendFactor),
    dst_factor: BlendFactor = std.mem.zeroes(BlendFactor),

    pub inline fn zero() BlendComponent {
        return std.mem.zeroes(BlendComponent);
    }
};

pub const BlendState = extern struct {
    color: BlendComponent = std.mem.zeroes(BlendComponent),
    alpha: BlendComponent = std.mem.zeroes(BlendComponent),

    pub inline fn zero() BlendState {
        return std.mem.zeroes(BlendState);
    }
};

pub const BufferBindingLayout = extern struct {
    next_in_chain: ?*const Chained = null,
    type: BufferBindingType = std.mem.zeroes(BufferBindingType),
    has_dynamic_offset: bool = std.mem.zeroes(bool),
    min_binding_size: u64 = std.mem.zeroes(u64),

    pub inline fn zero() BufferBindingLayout {
        return std.mem.zeroes(BufferBindingLayout);
    }
};

pub const BufferDescriptor = extern struct {
    next_in_chain: ?*const Chained = null,
    label: StringView = .empty,
    usage: BufferUsage = std.mem.zeroes(BufferUsage),
    size: u64 = std.mem.zeroes(u64),
    mapped_at_creation: bool = std.mem.zeroes(bool),

    pub inline fn zero() BufferDescriptor {
        return std.mem.zeroes(BufferDescriptor);
    }
};

pub const Color = extern struct {
    r: f64 = std.mem.zeroes(f64),
    g: f64 = std.mem.zeroes(f64),
    b: f64 = std.mem.zeroes(f64),
    a: f64 = std.mem.zeroes(f64),

    pub inline fn zero() Color {
        return std.mem.zeroes(Color);
    }
};

pub const ColorTargetState = extern struct {
    next_in_chain: ?*const Chained = null,
    format: TextureFormat = std.mem.zeroes(TextureFormat),
    blend: ?*const BlendState = null,
    write_mask: ColorWriteMask = std.mem.zeroes(ColorWriteMask),

    pub inline fn zero() ColorTargetState {
        return std.mem.zeroes(ColorTargetState);
    }
};

pub const CommandBufferDescriptor = extern struct {
    next_in_chain: ?*const Chained = null,
    label: StringView = .empty,

    pub inline fn zero() CommandBufferDescriptor {
        return std.mem.zeroes(CommandBufferDescriptor);
    }
};

pub const CommandEncoderDescriptor = extern struct {
    next_in_chain: ?*const Chained = null,
    label: StringView = .empty,

    pub inline fn zero() CommandEncoderDescriptor {
        return std.mem.zeroes(CommandEncoderDescriptor);
    }
};

pub const CompilationInfo = extern struct {
    next_in_chain: ?*const Chained = null,
    messages_count: usize = 0,
    messages: ?[*]const CompilationMessage = null,

    pub inline fn zero() CompilationInfo {
        return std.mem.zeroes(CompilationInfo);
    }
};

pub const CompilationMessage = extern struct {
    next_in_chain: ?*const Chained = null,
    message: StringView = std.mem.zeroes(StringView),
    type: CompilationMessageType = std.mem.zeroes(CompilationMessageType),
    line_num: u64 = std.mem.zeroes(u64),
    line_pos: u64 = std.mem.zeroes(u64),
    offset: u64 = std.mem.zeroes(u64),
    length: u64 = std.mem.zeroes(u64),

    pub inline fn zero() CompilationMessage {
        return std.mem.zeroes(CompilationMessage);
    }
};

pub const ComputePassDescriptor = extern struct {
    next_in_chain: ?*const Chained = null,
    label: StringView = .empty,
    timestamp_writes: ?*const ComputePassTimestampWrites = null,

    pub inline fn zero() ComputePassDescriptor {
        return std.mem.zeroes(ComputePassDescriptor);
    }
};

pub const ComputePassTimestampWrites = extern struct {
    query_set: *QuerySet,
    beginning_of_pass_write_index: u32 = std.mem.zeroes(u32),
    end_of_pass_write_index: u32 = std.mem.zeroes(u32),

    pub inline fn zero() ComputePassTimestampWrites {
        return std.mem.zeroes(ComputePassTimestampWrites);
    }
};

pub const ComputePipelineDescriptor = extern struct {
    next_in_chain: ?*const Chained = null,
    label: StringView = .empty,
    layout: ?*PipelineLayout = null,
    compute: ProgrammableStageDescriptor = std.mem.zeroes(ProgrammableStageDescriptor),

    pub inline fn zero() ComputePipelineDescriptor {
        return std.mem.zeroes(ComputePipelineDescriptor);
    }
};

pub const ConstantEntry = extern struct {
    next_in_chain: ?*const Chained = null,
    key: StringView = .empty,
    value: f64 = std.mem.zeroes(f64),

    pub inline fn zero() ConstantEntry {
        return std.mem.zeroes(ConstantEntry);
    }
};

pub const DepthStencilState = extern struct {
    next_in_chain: ?*const Chained = null,
    format: TextureFormat = std.mem.zeroes(TextureFormat),
    depth_write_enabled: OptionalBool = std.mem.zeroes(OptionalBool),
    depth_compare: CompareFunction = std.mem.zeroes(CompareFunction),
    stencil_front: StencilFaceState = std.mem.zeroes(StencilFaceState),
    stencil_back: StencilFaceState = std.mem.zeroes(StencilFaceState),
    stencil_read_mask: u32 = std.mem.zeroes(u32),
    stencil_write_mask: u32 = std.mem.zeroes(u32),
    depth_bias: i32 = std.mem.zeroes(i32),
    depth_bias_slope_scale: f32 = std.mem.zeroes(f32),
    depth_bias_clamp: f32 = std.mem.zeroes(f32),

    pub inline fn zero() DepthStencilState {
        return std.mem.zeroes(DepthStencilState);
    }
};

pub const DeviceDescriptor = extern struct {
    next_in_chain: ?*const Chained = null,
    label: StringView = .empty,
    required_features_count: usize = 0,
    required_features: ?[*]const FeatureName = null,
    required_limits: ?*const Limits = null,
    default_queue: QueueDescriptor = std.mem.zeroes(QueueDescriptor),
    device_lost_callback_info: DeviceLostCallbackInfo = std.mem.zeroes(DeviceLostCallbackInfo),
    uncaptured_error_callback_info: UncapturedErrorCallbackInfo = std.mem.zeroes(UncapturedErrorCallbackInfo),

    pub inline fn zero() DeviceDescriptor {
        return std.mem.zeroes(DeviceDescriptor);
    }
};

pub const Extent3D = extern struct {
    width: u32 = std.mem.zeroes(u32),
    height: u32 = std.mem.zeroes(u32),
    depth_or_array_layers: u32 = std.mem.zeroes(u32),

    pub inline fn zero() Extent3D {
        return std.mem.zeroes(Extent3D);
    }
};

pub const FragmentState = extern struct {
    next_in_chain: ?*const Chained = null,
    module: *ShaderModule,
    entry_point: StringView = .null_,
    constants_count: usize = 0,
    constants: ?[*]const ConstantEntry = null,
    targets_count: usize = 0,
    targets: ?[*]const ColorTargetState = null,

    pub inline fn zero() FragmentState {
        return std.mem.zeroes(FragmentState);
    }
};

pub const Future = extern struct {
    id: u64 = std.mem.zeroes(u64),

    pub inline fn zero() Future {
        return std.mem.zeroes(Future);
    }
};

pub const FutureWaitInfo = extern struct {
    future: Future = std.mem.zeroes(Future),
    completed: bool = std.mem.zeroes(bool),

    pub inline fn zero() FutureWaitInfo {
        return std.mem.zeroes(FutureWaitInfo);
    }
};

pub const InstanceCapabilities = extern struct {
    next_in_chain: ?*const Chained = null,
    timed_wait_any_enable: bool = std.mem.zeroes(bool),
    timed_wait_any_max_count: usize = std.mem.zeroes(usize),

    pub inline fn zero() InstanceCapabilities {
        return std.mem.zeroes(InstanceCapabilities);
    }
};

pub const InstanceDescriptor = extern struct {
    next_in_chain: ?*const Chained = null,
    features: InstanceCapabilities = std.mem.zeroes(InstanceCapabilities),

    pub inline fn zero() InstanceDescriptor {
        return std.mem.zeroes(InstanceDescriptor);
    }
};

pub const Limits = extern struct {
    next_in_chain: ?*const Chained = null,
    max_texture_dimension_1_d: u32 = std.mem.zeroes(u32),
    max_texture_dimension_2_d: u32 = std.mem.zeroes(u32),
    max_texture_dimension_3_d: u32 = std.mem.zeroes(u32),
    max_texture_array_layers: u32 = std.mem.zeroes(u32),
    max_bind_groups: u32 = std.mem.zeroes(u32),
    max_bind_groups_plus_vertex_buffers: u32 = std.mem.zeroes(u32),
    max_bindings_per_bind_group: u32 = std.mem.zeroes(u32),
    max_dynamic_uniform_buffers_per_pipeline_layout: u32 = std.mem.zeroes(u32),
    max_dynamic_storage_buffers_per_pipeline_layout: u32 = std.mem.zeroes(u32),
    max_sampled_textures_per_shader_stage: u32 = std.mem.zeroes(u32),
    max_samplers_per_shader_stage: u32 = std.mem.zeroes(u32),
    max_storage_buffers_per_shader_stage: u32 = std.mem.zeroes(u32),
    max_storage_textures_per_shader_stage: u32 = std.mem.zeroes(u32),
    max_uniform_buffers_per_shader_stage: u32 = std.mem.zeroes(u32),
    max_uniform_buffer_binding_size: u64 = std.mem.zeroes(u64),
    max_storage_buffer_binding_size: u64 = std.mem.zeroes(u64),
    min_uniform_buffer_offset_alignment: u32 = std.mem.zeroes(u32),
    min_storage_buffer_offset_alignment: u32 = std.mem.zeroes(u32),
    max_vertex_buffers: u32 = std.mem.zeroes(u32),
    max_buffer_size: u64 = std.mem.zeroes(u64),
    max_vertex_attributes: u32 = std.mem.zeroes(u32),
    max_vertex_buffer_array_stride: u32 = std.mem.zeroes(u32),
    max_inter_stage_shader_variables: u32 = std.mem.zeroes(u32),
    max_color_attachments: u32 = std.mem.zeroes(u32),
    max_color_attachment_bytes_per_sample: u32 = std.mem.zeroes(u32),
    max_compute_workgroup_storage_size: u32 = std.mem.zeroes(u32),
    max_compute_invocations_per_workgroup: u32 = std.mem.zeroes(u32),
    max_compute_workgroup_size_x: u32 = std.mem.zeroes(u32),
    max_compute_workgroup_size_y: u32 = std.mem.zeroes(u32),
    max_compute_workgroup_size_z: u32 = std.mem.zeroes(u32),
    max_compute_workgroups_per_dimension: u32 = std.mem.zeroes(u32),

    pub inline fn zero() Limits {
        return std.mem.zeroes(Limits);
    }
};

pub const MultisampleState = extern struct {
    next_in_chain: ?*const Chained = null,
    count: u32 = std.mem.zeroes(u32),
    mask: u32 = std.mem.zeroes(u32),
    alpha_to_coverage_enabled: bool = std.mem.zeroes(bool),

    pub inline fn zero() MultisampleState {
        return std.mem.zeroes(MultisampleState);
    }
};

pub const Origin3D = extern struct {
    x: u32 = std.mem.zeroes(u32),
    y: u32 = std.mem.zeroes(u32),
    z: u32 = std.mem.zeroes(u32),

    pub inline fn zero() Origin3D {
        return std.mem.zeroes(Origin3D);
    }
};

pub const PipelineLayoutDescriptor = extern struct {
    next_in_chain: ?*const Chained = null,
    label: StringView = .empty,
    bind_group_layouts_count: usize = 0,
    bind_group_layouts: ?[*]const *BindGroupLayout = null,

    pub inline fn zero() PipelineLayoutDescriptor {
        return std.mem.zeroes(PipelineLayoutDescriptor);
    }
};

pub const PrimitiveState = extern struct {
    next_in_chain: ?*const Chained = null,
    topology: PrimitiveTopology = std.mem.zeroes(PrimitiveTopology),
    strip_index_format: IndexFormat = std.mem.zeroes(IndexFormat),
    front_face: FrontFace = std.mem.zeroes(FrontFace),
    cull_mode: CullMode = std.mem.zeroes(CullMode),
    unclipped_depth: bool = std.mem.zeroes(bool),

    pub inline fn zero() PrimitiveState {
        return std.mem.zeroes(PrimitiveState);
    }
};

pub const ProgrammableStageDescriptor = extern struct {
    next_in_chain: ?*const Chained = null,
    module: *ShaderModule,
    entry_point: StringView = .null_,
    constants_count: usize = 0,
    constants: ?[*]const ConstantEntry = null,

    pub inline fn zero() ProgrammableStageDescriptor {
        return std.mem.zeroes(ProgrammableStageDescriptor);
    }
};

pub const QuerySetDescriptor = extern struct {
    next_in_chain: ?*const Chained = null,
    label: StringView = .empty,
    type: QueryType = std.mem.zeroes(QueryType),
    count: u32 = std.mem.zeroes(u32),

    pub inline fn zero() QuerySetDescriptor {
        return std.mem.zeroes(QuerySetDescriptor);
    }
};

pub const QueueDescriptor = extern struct {
    next_in_chain: ?*const Chained = null,
    label: StringView = .empty,

    pub inline fn zero() QueueDescriptor {
        return std.mem.zeroes(QueueDescriptor);
    }
};

pub const RenderBundleDescriptor = extern struct {
    next_in_chain: ?*const Chained = null,
    label: StringView = .empty,

    pub inline fn zero() RenderBundleDescriptor {
        return std.mem.zeroes(RenderBundleDescriptor);
    }
};

pub const RenderBundleEncoderDescriptor = extern struct {
    next_in_chain: ?*const Chained = null,
    label: StringView = .empty,
    color_formats_count: usize = 0,
    color_formats: ?[*]const TextureFormat = null,
    depth_stencil_format: TextureFormat = std.mem.zeroes(TextureFormat),
    sample_count: u32 = std.mem.zeroes(u32),
    depth_read_only: bool = std.mem.zeroes(bool),
    stencil_read_only: bool = std.mem.zeroes(bool),

    pub inline fn zero() RenderBundleEncoderDescriptor {
        return std.mem.zeroes(RenderBundleEncoderDescriptor);
    }
};

pub const RenderPassColorAttachment = extern struct {
    next_in_chain: ?*const Chained = null,
    view: ?*TextureView = null,
    depth_slice: u32 = std.mem.zeroes(u32),
    resolve_target: ?*TextureView = null,
    load_op: LoadOp = std.mem.zeroes(LoadOp),
    store_op: StoreOp = std.mem.zeroes(StoreOp),
    clear_value: Color = std.mem.zeroes(Color),

    pub inline fn zero() RenderPassColorAttachment {
        return std.mem.zeroes(RenderPassColorAttachment);
    }
};

pub const RenderPassDepthStencilAttachment = extern struct {
    view: *TextureView,
    depth_load_op: LoadOp = std.mem.zeroes(LoadOp),
    depth_store_op: StoreOp = std.mem.zeroes(StoreOp),
    depth_clear_value: f32 = std.mem.zeroes(f32),
    depth_read_only: bool = std.mem.zeroes(bool),
    stencil_load_op: LoadOp = std.mem.zeroes(LoadOp),
    stencil_store_op: StoreOp = std.mem.zeroes(StoreOp),
    stencil_clear_value: u32 = std.mem.zeroes(u32),
    stencil_read_only: bool = std.mem.zeroes(bool),

    pub inline fn zero() RenderPassDepthStencilAttachment {
        return std.mem.zeroes(RenderPassDepthStencilAttachment);
    }
};

pub const RenderPassDescriptor = extern struct {
    next_in_chain: ?*const Chained = null,
    label: StringView = .empty,
    color_attachments_count: usize = 0,
    color_attachments: ?[*]const RenderPassColorAttachment = null,
    depth_stencil_attachment: ?*const RenderPassDepthStencilAttachment = null,
    occlusion_query_set: ?*QuerySet = null,
    timestamp_writes: ?*const RenderPassTimestampWrites = null,

    pub inline fn zero() RenderPassDescriptor {
        return std.mem.zeroes(RenderPassDescriptor);
    }
};

pub const RenderPassMaxDrawCount = extern struct {
    chain: Chained,
    max_draw_count: u64 = std.mem.zeroes(u64),

    pub inline fn zero() RenderPassMaxDrawCount {
        return std.mem.zeroes(RenderPassMaxDrawCount);
    }

    pub const RenderPassMaxDrawCountInitOptions = struct {
        label: []const u8 = "",
        max_draw_count: u64 = std.mem.zeroes(u64),
    };
    pub inline fn init(options: RenderPassMaxDrawCountInitOptions) *const RenderPassDescriptor {
        return &RenderPassDescriptor{
            .label = .from(options.label),
            .next_in_chain = @ptrCast(&RenderPassMaxDrawCount{
                .max_draw_count = options.max_draw_count,
                .chain = .{ .s_type = .render_pass_max_draw_count, .next = null },
            }),
        };
    }
};

pub const RenderPassTimestampWrites = extern struct {
    query_set: *QuerySet,
    beginning_of_pass_write_index: u32 = std.mem.zeroes(u32),
    end_of_pass_write_index: u32 = std.mem.zeroes(u32),

    pub inline fn zero() RenderPassTimestampWrites {
        return std.mem.zeroes(RenderPassTimestampWrites);
    }
};

pub const RenderPipelineDescriptor = extern struct {
    next_in_chain: ?*const Chained = null,
    label: StringView = .empty,
    layout: ?*PipelineLayout = null,
    vertex: VertexState = std.mem.zeroes(VertexState),
    primitive: PrimitiveState = std.mem.zeroes(PrimitiveState),
    depth_stencil: ?*const DepthStencilState = null,
    multisample: MultisampleState = std.mem.zeroes(MultisampleState),
    fragment: ?*const FragmentState = null,

    pub inline fn zero() RenderPipelineDescriptor {
        return std.mem.zeroes(RenderPipelineDescriptor);
    }
};

pub const RequestAdapterOptions = extern struct {
    next_in_chain: ?*const Chained = null,
    feature_level: FeatureLevel = std.mem.zeroes(FeatureLevel),
    power_preference: PowerPreference = std.mem.zeroes(PowerPreference),
    force_fallback_adapter: bool = std.mem.zeroes(bool),
    backend_type: BackendType = std.mem.zeroes(BackendType),
    compatible_surface: ?*Surface = null,

    pub inline fn zero() RequestAdapterOptions {
        return std.mem.zeroes(RequestAdapterOptions);
    }
};

pub const SamplerBindingLayout = extern struct {
    next_in_chain: ?*const Chained = null,
    type: SamplerBindingType = std.mem.zeroes(SamplerBindingType),

    pub inline fn zero() SamplerBindingLayout {
        return std.mem.zeroes(SamplerBindingLayout);
    }
};

pub const SamplerDescriptor = extern struct {
    next_in_chain: ?*const Chained = null,
    label: StringView = .empty,
    address_mode_u: AddressMode = std.mem.zeroes(AddressMode),
    address_mode_v: AddressMode = std.mem.zeroes(AddressMode),
    address_mode_w: AddressMode = std.mem.zeroes(AddressMode),
    mag_filter: FilterMode = std.mem.zeroes(FilterMode),
    min_filter: FilterMode = std.mem.zeroes(FilterMode),
    mipmap_filter: MipmapFilterMode = std.mem.zeroes(MipmapFilterMode),
    lod_min_clamp: f32 = std.mem.zeroes(f32),
    lod_max_clamp: f32 = std.mem.zeroes(f32),
    compare: CompareFunction = std.mem.zeroes(CompareFunction),
    max_anisotropy: u16 = std.mem.zeroes(u16),

    pub inline fn zero() SamplerDescriptor {
        return std.mem.zeroes(SamplerDescriptor);
    }
};

pub const ShaderModuleDescriptor = extern struct {
    next_in_chain: ?*const Chained = null,
    label: StringView = .empty,

    pub inline fn zero() ShaderModuleDescriptor {
        return std.mem.zeroes(ShaderModuleDescriptor);
    }
};

pub const ShaderSourceSpirv = extern struct {
    chain: Chained,
    code_size: u32 = std.mem.zeroes(u32),
    code: *const u32,

    pub inline fn zero() ShaderSourceSpirv {
        return std.mem.zeroes(ShaderSourceSpirv);
    }

    pub const ShaderSourceSpirvInitOptions = struct {
        label: []const u8 = "",
        code_size: u32 = std.mem.zeroes(u32),
        code: *const u32,
    };
    pub inline fn init(options: ShaderSourceSpirvInitOptions) *const ShaderModuleDescriptor {
        return &ShaderModuleDescriptor{
            .label = .from(options.label),
            .next_in_chain = @ptrCast(&ShaderSourceSpirv{
                .code_size = options.code_size,
                .code = options.code,
                .chain = .{ .s_type = .shader_source_spirv, .next = null },
            }),
        };
    }
};

pub const ShaderSourceWgsl = extern struct {
    chain: Chained,
    code: StringView = .empty,

    pub inline fn zero() ShaderSourceWgsl {
        return std.mem.zeroes(ShaderSourceWgsl);
    }

    pub const ShaderSourceWgslInitOptions = struct {
        label: []const u8 = "",
        code: []const u8 = "",
    };
    pub inline fn init(options: ShaderSourceWgslInitOptions) *const ShaderModuleDescriptor {
        return &ShaderModuleDescriptor{
            .label = .from(options.label),
            .next_in_chain = @ptrCast(&ShaderSourceWgsl{
                .code = .from(options.code),
                .chain = .{ .s_type = .shader_source_wgsl, .next = null },
            }),
        };
    }
};

pub const StencilFaceState = extern struct {
    compare: CompareFunction = std.mem.zeroes(CompareFunction),
    fail_op: StencilOperation = std.mem.zeroes(StencilOperation),
    depth_fail_op: StencilOperation = std.mem.zeroes(StencilOperation),
    pass_op: StencilOperation = std.mem.zeroes(StencilOperation),

    pub inline fn zero() StencilFaceState {
        return std.mem.zeroes(StencilFaceState);
    }
};

pub const StorageTextureBindingLayout = extern struct {
    next_in_chain: ?*const Chained = null,
    access: StorageTextureAccess = std.mem.zeroes(StorageTextureAccess),
    format: TextureFormat = std.mem.zeroes(TextureFormat),
    view_dimension: TextureViewDimension = std.mem.zeroes(TextureViewDimension),

    pub inline fn zero() StorageTextureBindingLayout {
        return std.mem.zeroes(StorageTextureBindingLayout);
    }
};

pub const SupportedFeatures = extern struct {
    features_count: usize = 0,
    features: ?[*]const FeatureName = null,

    pub inline fn zero() SupportedFeatures {
        return std.mem.zeroes(SupportedFeatures);
    }
    extern fn wgpuSupportedFeaturesFreeMembers(self: SupportedFeatures) callconv(.c) void;
    pub inline fn freeMembers(self: SupportedFeatures) void {
        return wgpuSupportedFeaturesFreeMembers(self);
    }
};

pub const SupportedWgslLanguageFeatures = extern struct {
    features_count: usize = 0,
    features: ?[*]const WgslLanguageFeatureName = null,

    pub inline fn zero() SupportedWgslLanguageFeatures {
        return std.mem.zeroes(SupportedWgslLanguageFeatures);
    }
    extern fn wgpuSupportedWgslLanguageFeaturesFreeMembers(self: SupportedWgslLanguageFeatures) callconv(.c) void;
    pub inline fn freeMembers(self: SupportedWgslLanguageFeatures) void {
        return wgpuSupportedWgslLanguageFeaturesFreeMembers(self);
    }
};

pub const SurfaceCapabilities = extern struct {
    next_in_chain: ?*const Chained = null,
    usages: TextureUsage = std.mem.zeroes(TextureUsage),
    formats_count: usize = 0,
    formats: ?[*]const TextureFormat = null,
    present_modes_count: usize = 0,
    present_modes: ?[*]const PresentMode = null,
    alpha_modes_count: usize = 0,
    alpha_modes: ?[*]const CompositeAlphaMode = null,

    pub inline fn zero() SurfaceCapabilities {
        return std.mem.zeroes(SurfaceCapabilities);
    }
    extern fn wgpuSurfaceCapabilitiesFreeMembers(self: SurfaceCapabilities) callconv(.c) void;
    pub inline fn freeMembers(self: SurfaceCapabilities) void {
        return wgpuSurfaceCapabilitiesFreeMembers(self);
    }
};

pub const SurfaceConfiguration = extern struct {
    next_in_chain: ?*const Chained = null,
    device: *Device,
    format: TextureFormat = std.mem.zeroes(TextureFormat),
    usage: TextureUsage = std.mem.zeroes(TextureUsage),
    width: u32 = std.mem.zeroes(u32),
    height: u32 = std.mem.zeroes(u32),
    view_formats_count: usize = 0,
    view_formats: ?[*]const TextureFormat = null,
    alpha_mode: CompositeAlphaMode = std.mem.zeroes(CompositeAlphaMode),
    present_mode: PresentMode = std.mem.zeroes(PresentMode),

    pub inline fn zero() SurfaceConfiguration {
        return std.mem.zeroes(SurfaceConfiguration);
    }
};

pub const SurfaceDescriptor = extern struct {
    next_in_chain: ?*const Chained = null,
    label: StringView = .empty,

    pub inline fn zero() SurfaceDescriptor {
        return std.mem.zeroes(SurfaceDescriptor);
    }
};

pub const SurfaceSourceAndroidNativeWindow = extern struct {
    chain: Chained,
    window: *anyopaque,

    pub inline fn zero() SurfaceSourceAndroidNativeWindow {
        return std.mem.zeroes(SurfaceSourceAndroidNativeWindow);
    }

    pub const SurfaceSourceAndroidNativeWindowInitOptions = struct {
        label: []const u8 = "",
        window: *anyopaque,
    };
    pub inline fn init(options: SurfaceSourceAndroidNativeWindowInitOptions) *const SurfaceDescriptor {
        return &SurfaceDescriptor{
            .label = .from(options.label),
            .next_in_chain = @ptrCast(&SurfaceSourceAndroidNativeWindow{
                .window = options.window,
                .chain = .{ .s_type = .surface_source_android_native_window, .next = null },
            }),
        };
    }
};

pub const SurfaceSourceMetalLayer = extern struct {
    chain: Chained,
    layer: *anyopaque,

    pub inline fn zero() SurfaceSourceMetalLayer {
        return std.mem.zeroes(SurfaceSourceMetalLayer);
    }

    pub const SurfaceSourceMetalLayerInitOptions = struct {
        label: []const u8 = "",
        layer: *anyopaque,
    };
    pub inline fn init(options: SurfaceSourceMetalLayerInitOptions) *const SurfaceDescriptor {
        return &SurfaceDescriptor{
            .label = .from(options.label),
            .next_in_chain = @ptrCast(&SurfaceSourceMetalLayer{
                .layer = options.layer,
                .chain = .{ .s_type = .surface_source_metal_layer, .next = null },
            }),
        };
    }
};

pub const SurfaceSourceWaylandSurface = extern struct {
    chain: Chained,
    display: *anyopaque,
    surface: *anyopaque,

    pub inline fn zero() SurfaceSourceWaylandSurface {
        return std.mem.zeroes(SurfaceSourceWaylandSurface);
    }

    pub const SurfaceSourceWaylandSurfaceInitOptions = struct {
        label: []const u8 = "",
        display: *anyopaque,
        surface: *anyopaque,
    };
    pub inline fn init(options: SurfaceSourceWaylandSurfaceInitOptions) *const SurfaceDescriptor {
        return &SurfaceDescriptor{
            .label = .from(options.label),
            .next_in_chain = @ptrCast(&SurfaceSourceWaylandSurface{
                .display = options.display,
                .surface = options.surface,
                .chain = .{ .s_type = .surface_source_wayland_surface, .next = null },
            }),
        };
    }
};

pub const SurfaceSourceWindowsHwnd = extern struct {
    chain: Chained,
    hinstance: *anyopaque,
    hwnd: *anyopaque,

    pub inline fn zero() SurfaceSourceWindowsHwnd {
        return std.mem.zeroes(SurfaceSourceWindowsHwnd);
    }

    pub const SurfaceSourceWindowsHwndInitOptions = struct {
        label: []const u8 = "",
        hinstance: *anyopaque,
        hwnd: *anyopaque,
    };
    pub inline fn init(options: SurfaceSourceWindowsHwndInitOptions) *const SurfaceDescriptor {
        return &SurfaceDescriptor{
            .label = .from(options.label),
            .next_in_chain = @ptrCast(&SurfaceSourceWindowsHwnd{
                .hinstance = options.hinstance,
                .hwnd = options.hwnd,
                .chain = .{ .s_type = .surface_source_windows_hwnd, .next = null },
            }),
        };
    }
};

pub const SurfaceSourceXcbWindow = extern struct {
    chain: Chained,
    connection: *anyopaque,
    window: u32 = std.mem.zeroes(u32),

    pub inline fn zero() SurfaceSourceXcbWindow {
        return std.mem.zeroes(SurfaceSourceXcbWindow);
    }

    pub const SurfaceSourceXcbWindowInitOptions = struct {
        label: []const u8 = "",
        connection: *anyopaque,
        window: u32 = std.mem.zeroes(u32),
    };
    pub inline fn init(options: SurfaceSourceXcbWindowInitOptions) *const SurfaceDescriptor {
        return &SurfaceDescriptor{
            .label = .from(options.label),
            .next_in_chain = @ptrCast(&SurfaceSourceXcbWindow{
                .connection = options.connection,
                .window = options.window,
                .chain = .{ .s_type = .surface_source_xcb_window, .next = null },
            }),
        };
    }
};

pub const SurfaceSourceXlibWindow = extern struct {
    chain: Chained,
    display: *anyopaque,
    window: u64 = std.mem.zeroes(u64),

    pub inline fn zero() SurfaceSourceXlibWindow {
        return std.mem.zeroes(SurfaceSourceXlibWindow);
    }

    pub const SurfaceSourceXlibWindowInitOptions = struct {
        label: []const u8 = "",
        display: *anyopaque,
        window: u64 = std.mem.zeroes(u64),
    };
    pub inline fn init(options: SurfaceSourceXlibWindowInitOptions) *const SurfaceDescriptor {
        return &SurfaceDescriptor{
            .label = .from(options.label),
            .next_in_chain = @ptrCast(&SurfaceSourceXlibWindow{
                .display = options.display,
                .window = options.window,
                .chain = .{ .s_type = .surface_source_xlib_window, .next = null },
            }),
        };
    }
};

pub const SurfaceTexture = extern struct {
    next_in_chain: ?*const Chained = null,
    texture: *Texture,
    status: SurfaceGetCurrentTextureStatus = std.mem.zeroes(SurfaceGetCurrentTextureStatus),

    pub inline fn zero() SurfaceTexture {
        return std.mem.zeroes(SurfaceTexture);
    }
};

pub const TexelCopyBufferInfo = extern struct {
    layout: TexelCopyBufferLayout = std.mem.zeroes(TexelCopyBufferLayout),
    buffer: *Buffer,

    pub inline fn zero() TexelCopyBufferInfo {
        return std.mem.zeroes(TexelCopyBufferInfo);
    }
};

pub const TexelCopyBufferLayout = extern struct {
    offset: u64 = std.mem.zeroes(u64),
    bytes_per_row: u32 = std.mem.zeroes(u32),
    rows_per_image: u32 = std.mem.zeroes(u32),

    pub inline fn zero() TexelCopyBufferLayout {
        return std.mem.zeroes(TexelCopyBufferLayout);
    }
};

pub const TexelCopyTextureInfo = extern struct {
    texture: *Texture,
    mip_level: u32 = std.mem.zeroes(u32),
    origin: Origin3D = std.mem.zeroes(Origin3D),
    aspect: TextureAspect = std.mem.zeroes(TextureAspect),

    pub inline fn zero() TexelCopyTextureInfo {
        return std.mem.zeroes(TexelCopyTextureInfo);
    }
};

pub const TextureBindingLayout = extern struct {
    next_in_chain: ?*const Chained = null,
    sample_type: TextureSampleType = std.mem.zeroes(TextureSampleType),
    view_dimension: TextureViewDimension = std.mem.zeroes(TextureViewDimension),
    multisampled: bool = std.mem.zeroes(bool),

    pub inline fn zero() TextureBindingLayout {
        return std.mem.zeroes(TextureBindingLayout);
    }
};

pub const TextureDescriptor = extern struct {
    next_in_chain: ?*const Chained = null,
    label: StringView = .empty,
    usage: TextureUsage = std.mem.zeroes(TextureUsage),
    dimension: TextureDimension = std.mem.zeroes(TextureDimension),
    size: Extent3D = std.mem.zeroes(Extent3D),
    format: TextureFormat = std.mem.zeroes(TextureFormat),
    mip_level_count: u32 = std.mem.zeroes(u32),
    sample_count: u32 = std.mem.zeroes(u32),
    view_formats_count: usize = 0,
    view_formats: ?[*]const TextureFormat = null,

    pub inline fn zero() TextureDescriptor {
        return std.mem.zeroes(TextureDescriptor);
    }
};

pub const TextureViewDescriptor = extern struct {
    next_in_chain: ?*const Chained = null,
    label: StringView = .empty,
    format: TextureFormat = std.mem.zeroes(TextureFormat),
    dimension: TextureViewDimension = std.mem.zeroes(TextureViewDimension),
    base_mip_level: u32 = std.mem.zeroes(u32),
    mip_level_count: u32 = std.mem.zeroes(u32),
    base_array_layer: u32 = std.mem.zeroes(u32),
    array_layer_count: u32 = std.mem.zeroes(u32),
    aspect: TextureAspect = std.mem.zeroes(TextureAspect),
    usage: TextureUsage = std.mem.zeroes(TextureUsage),

    pub inline fn zero() TextureViewDescriptor {
        return std.mem.zeroes(TextureViewDescriptor);
    }
};

pub const VertexAttribute = extern struct {
    format: VertexFormat = std.mem.zeroes(VertexFormat),
    offset: u64 = std.mem.zeroes(u64),
    shader_location: u32 = std.mem.zeroes(u32),

    pub inline fn zero() VertexAttribute {
        return std.mem.zeroes(VertexAttribute);
    }
};

pub const VertexBufferLayout = extern struct {
    step_mode: VertexStepMode = std.mem.zeroes(VertexStepMode),
    array_stride: u64 = std.mem.zeroes(u64),
    attributes_count: usize = 0,
    attributes: ?[*]const VertexAttribute = null,

    pub inline fn zero() VertexBufferLayout {
        return std.mem.zeroes(VertexBufferLayout);
    }
};

pub const VertexState = extern struct {
    next_in_chain: ?*const Chained = null,
    module: *ShaderModule,
    entry_point: StringView = .null_,
    constants_count: usize = 0,
    constants: ?[*]const ConstantEntry = null,
    buffers_count: usize = 0,
    buffers: ?[*]const VertexBufferLayout = null,

    pub inline fn zero() VertexState {
        return std.mem.zeroes(VertexState);
    }
};

pub const BufferMapCallback = *const fn (status: MapAsyncStatus, message: StringView, userdata1: ?*anyopaque, userdata2: ?*anyopaque) callconv(.c) void;
pub const BufferMapCallbackInfo = extern struct {
    next_in_chain: ?*const Chained = null,
    mode: CallbackMode = .allow_process_events,
    callback: BufferMapCallback,
    userdata1: ?*anyopaque = null,
    userdata2: ?*anyopaque = null,

    pub const State = struct { status: MapAsyncStatus, message: StringView };
    pub fn default(status: MapAsyncStatus, message: StringView, userdata1: ?*anyopaque, userdata2: ?*anyopaque) callconv(.c) void {
        _ = userdata2;
        const state_ptr: *State = @ptrCast(@alignCast(userdata1.?));
        state_ptr.* = .{
            .status = status,
            .message = message,
        };
    }
};

pub const CompilationInfoCallback = *const fn (status: CompilationInfoRequestStatus, compilation_info: *const CompilationInfo, userdata1: ?*anyopaque, userdata2: ?*anyopaque) callconv(.c) void;
pub const CompilationInfoCallbackInfo = extern struct {
    next_in_chain: ?*const Chained = null,
    mode: CallbackMode = .allow_process_events,
    callback: CompilationInfoCallback,
    userdata1: ?*anyopaque = null,
    userdata2: ?*anyopaque = null,

    pub const State = struct { status: CompilationInfoRequestStatus, compilation_info: *const CompilationInfo };
    pub fn default(status: CompilationInfoRequestStatus, compilation_info: *const CompilationInfo, userdata1: ?*anyopaque, userdata2: ?*anyopaque) callconv(.c) void {
        _ = userdata2;
        const state_ptr: *State = @ptrCast(@alignCast(userdata1.?));
        state_ptr.* = .{
            .status = status,
            .compilation_info = compilation_info,
        };
    }
};

pub const CreateComputePipelineAsyncCallback = *const fn (status: CreatePipelineAsyncStatus, pipeline: *ComputePipeline, message: StringView, userdata1: ?*anyopaque, userdata2: ?*anyopaque) callconv(.c) void;
pub const CreateComputePipelineAsyncCallbackInfo = extern struct {
    next_in_chain: ?*const Chained = null,
    mode: CallbackMode = .allow_process_events,
    callback: CreateComputePipelineAsyncCallback,
    userdata1: ?*anyopaque = null,
    userdata2: ?*anyopaque = null,

    pub const State = struct { status: CreatePipelineAsyncStatus, pipeline: *ComputePipeline, message: StringView };
    pub fn default(status: CreatePipelineAsyncStatus, pipeline: *ComputePipeline, message: StringView, userdata1: ?*anyopaque, userdata2: ?*anyopaque) callconv(.c) void {
        _ = userdata2;
        const state_ptr: *State = @ptrCast(@alignCast(userdata1.?));
        state_ptr.* = .{
            .status = status,
            .pipeline = pipeline,
            .message = message,
        };
    }
};

pub const CreateRenderPipelineAsyncCallback = *const fn (status: CreatePipelineAsyncStatus, pipeline: *RenderPipeline, message: StringView, userdata1: ?*anyopaque, userdata2: ?*anyopaque) callconv(.c) void;
pub const CreateRenderPipelineAsyncCallbackInfo = extern struct {
    next_in_chain: ?*const Chained = null,
    mode: CallbackMode = .allow_process_events,
    callback: CreateRenderPipelineAsyncCallback,
    userdata1: ?*anyopaque = null,
    userdata2: ?*anyopaque = null,

    pub const State = struct { status: CreatePipelineAsyncStatus, pipeline: *RenderPipeline, message: StringView };
    pub fn default(status: CreatePipelineAsyncStatus, pipeline: *RenderPipeline, message: StringView, userdata1: ?*anyopaque, userdata2: ?*anyopaque) callconv(.c) void {
        _ = userdata2;
        const state_ptr: *State = @ptrCast(@alignCast(userdata1.?));
        state_ptr.* = .{
            .status = status,
            .pipeline = pipeline,
            .message = message,
        };
    }
};

pub const DeviceLostCallback = *const fn (device: *Device, reason: DeviceLostReason, message: StringView, userdata1: ?*anyopaque, userdata2: ?*anyopaque) callconv(.c) void;
pub const DeviceLostCallbackInfo = extern struct {
    next_in_chain: ?*const Chained = null,
    mode: CallbackMode = .allow_process_events,
    callback: DeviceLostCallback,
    userdata1: ?*anyopaque = null,
    userdata2: ?*anyopaque = null,

    pub const State = struct { device: *Device, reason: DeviceLostReason, message: StringView };
    pub fn default(device: *Device, reason: DeviceLostReason, message: StringView, userdata1: ?*anyopaque, userdata2: ?*anyopaque) callconv(.c) void {
        _ = userdata2;
        const state_ptr: *State = @ptrCast(@alignCast(userdata1.?));
        state_ptr.* = .{
            .device = device,
            .reason = reason,
            .message = message,
        };
    }
};

pub const PopErrorScopeCallback = *const fn (status: PopErrorScopeStatus, typ: ErrorType, message: StringView, userdata1: ?*anyopaque, userdata2: ?*anyopaque) callconv(.c) void;
pub const PopErrorScopeCallbackInfo = extern struct {
    next_in_chain: ?*const Chained = null,
    mode: CallbackMode = .allow_process_events,
    callback: PopErrorScopeCallback,
    userdata1: ?*anyopaque = null,
    userdata2: ?*anyopaque = null,

    pub const State = struct { status: PopErrorScopeStatus, typ: ErrorType, message: StringView };
    pub fn default(status: PopErrorScopeStatus, typ: ErrorType, message: StringView, userdata1: ?*anyopaque, userdata2: ?*anyopaque) callconv(.c) void {
        _ = userdata2;
        const state_ptr: *State = @ptrCast(@alignCast(userdata1.?));
        state_ptr.* = .{
            .status = status,
            .typ = typ,
            .message = message,
        };
    }
};

pub const QueueWorkDoneCallback = *const fn (status: QueueWorkDoneStatus, userdata1: ?*anyopaque, userdata2: ?*anyopaque) callconv(.c) void;
pub const QueueWorkDoneCallbackInfo = extern struct {
    next_in_chain: ?*const Chained = null,
    mode: CallbackMode = .allow_process_events,
    callback: QueueWorkDoneCallback,
    userdata1: ?*anyopaque = null,
    userdata2: ?*anyopaque = null,

    pub const State = struct { status: QueueWorkDoneStatus };
    pub fn default(status: QueueWorkDoneStatus, userdata1: ?*anyopaque, userdata2: ?*anyopaque) callconv(.c) void {
        _ = userdata2;
        const state_ptr: *State = @ptrCast(@alignCast(userdata1.?));
        state_ptr.* = .{
            .status = status,
        };
    }
};

pub const RequestAdapterCallback = *const fn (status: RequestAdapterStatus, adapter: *Adapter, message: StringView, userdata1: ?*anyopaque, userdata2: ?*anyopaque) callconv(.c) void;
pub const RequestAdapterCallbackInfo = extern struct {
    next_in_chain: ?*const Chained = null,
    mode: CallbackMode = .allow_process_events,
    callback: RequestAdapterCallback,
    userdata1: ?*anyopaque = null,
    userdata2: ?*anyopaque = null,

    pub const State = struct { status: RequestAdapterStatus, adapter: *Adapter, message: StringView };
    pub fn default(status: RequestAdapterStatus, adapter: *Adapter, message: StringView, userdata1: ?*anyopaque, userdata2: ?*anyopaque) callconv(.c) void {
        _ = userdata2;
        const state_ptr: *State = @ptrCast(@alignCast(userdata1.?));
        state_ptr.* = .{
            .status = status,
            .adapter = adapter,
            .message = message,
        };
    }
};

pub const RequestDeviceCallback = *const fn (status: RequestDeviceStatus, device: *Device, message: StringView, userdata1: ?*anyopaque, userdata2: ?*anyopaque) callconv(.c) void;
pub const RequestDeviceCallbackInfo = extern struct {
    next_in_chain: ?*const Chained = null,
    mode: CallbackMode = .allow_process_events,
    callback: RequestDeviceCallback,
    userdata1: ?*anyopaque = null,
    userdata2: ?*anyopaque = null,

    pub const State = struct { status: RequestDeviceStatus, device: *Device, message: StringView };
    pub fn default(status: RequestDeviceStatus, device: *Device, message: StringView, userdata1: ?*anyopaque, userdata2: ?*anyopaque) callconv(.c) void {
        _ = userdata2;
        const state_ptr: *State = @ptrCast(@alignCast(userdata1.?));
        state_ptr.* = .{
            .status = status,
            .device = device,
            .message = message,
        };
    }
};

pub const UncapturedErrorCallback = *const fn (device: *Device, typ: ErrorType, message: StringView, userdata1: ?*anyopaque, userdata2: ?*anyopaque) callconv(.c) void;
pub const UncapturedErrorCallbackInfo = extern struct {
    next_in_chain: ?*const Chained = null,
    callback: UncapturedErrorCallback,
    userdata1: ?*anyopaque = null,
    userdata2: ?*anyopaque = null,

    pub const State = struct { device: *Device, typ: ErrorType, message: StringView };
    pub fn default(device: *Device, typ: ErrorType, message: StringView, userdata1: ?*anyopaque, userdata2: ?*anyopaque) callconv(.c) void {
        _ = userdata2;
        const state_ptr: *State = @ptrCast(@alignCast(userdata1.?));
        state_ptr.* = .{
            .device = device,
            .typ = typ,
            .message = message,
        };
    }
};

/// Create a WGPUInstance
extern fn wgpuCreateInstance(descriptor: ?*const InstanceDescriptor) callconv(.c) *Instance;
pub const createInstance = wgpuCreateInstance;
/// Query the supported instance capabilities.
extern fn wgpuGetInstanceCapabilities(capabilities: *InstanceCapabilities) callconv(.c) Status;
pub const getInstanceCapabilities = wgpuGetInstanceCapabilities;

pub const Adapter = opaque {
    extern fn wgpuAdapterGetLimits(self: *Adapter, limits: *Limits) callconv(.c) Status;
    pub inline fn getLimits(self: *Adapter, limits: *Limits) Status {
        return wgpuAdapterGetLimits(self, limits);
    }
    extern fn wgpuAdapterHasFeature(self: *Adapter, feature: FeatureName) callconv(.c) bool;
    pub inline fn hasFeature(self: *Adapter, feature: FeatureName) bool {
        return wgpuAdapterHasFeature(self, feature);
    }
    extern fn wgpuAdapterGetFeatures(self: *Adapter, features: *SupportedFeatures) callconv(.c) void;
    /// Get the list of @ref WGPUFeatureName values supported by the adapter.
    pub inline fn getFeatures(self: *Adapter, features: *SupportedFeatures) void {
        return wgpuAdapterGetFeatures(self, features);
    }
    extern fn wgpuAdapterGetInfo(self: *Adapter, info: *AdapterInfo) callconv(.c) Status;
    pub inline fn getInfo(self: *Adapter, info: *AdapterInfo) Status {
        return wgpuAdapterGetInfo(self, info);
    }
    extern fn wgpuAdapterRequestDevice(self: *Adapter, descriptor: ?*const DeviceDescriptor, callback: RequestDeviceCallbackInfo) callconv(.c) Future;
    pub inline fn requestDevice(self: *Adapter, descriptor: ?*const DeviceDescriptor, callback: RequestDeviceCallbackInfo) Future {
        return wgpuAdapterRequestDevice(self, descriptor, callback);
    }
    pub inline fn requestDeviceSync(self: *Adapter, descriptor: ?*const DeviceDescriptor) RequestDeviceCallbackInfo.State {
        var state: RequestDeviceCallbackInfo.State = undefined;
        const callback_info: RequestDeviceCallbackInfo = .{
            .callback = RequestDeviceCallbackInfo.default,
            .userdata1 = @ptrCast(&state),
        };
        _ = wgpuAdapterRequestDevice(self, descriptor, callback_info);
        return state;
    }
    extern fn wgpuAdapterAddRef(self: *Adapter) callconv(.c) void;
    pub inline fn addRef(self: *Adapter) void {
        return wgpuAdapterAddRef(self);
    }
    extern fn wgpuAdapterRelease(self: *Adapter) callconv(.c) void;
    pub inline fn release(self: *Adapter) void {
        return wgpuAdapterRelease(self);
    }
};

pub const BindGroup = opaque {
    extern fn wgpuBindGroupSetLabel(self: *BindGroup, label: StringView) callconv(.c) void;
    pub inline fn setLabel(self: *BindGroup, label: StringView) void {
        return wgpuBindGroupSetLabel(self, label);
    }
    extern fn wgpuBindGroupAddRef(self: *BindGroup) callconv(.c) void;
    pub inline fn addRef(self: *BindGroup) void {
        return wgpuBindGroupAddRef(self);
    }
    extern fn wgpuBindGroupRelease(self: *BindGroup) callconv(.c) void;
    pub inline fn release(self: *BindGroup) void {
        return wgpuBindGroupRelease(self);
    }
};

pub const BindGroupLayout = opaque {
    extern fn wgpuBindGroupLayoutSetLabel(self: *BindGroupLayout, label: StringView) callconv(.c) void;
    pub inline fn setLabel(self: *BindGroupLayout, label: StringView) void {
        return wgpuBindGroupLayoutSetLabel(self, label);
    }
    extern fn wgpuBindGroupLayoutAddRef(self: *BindGroupLayout) callconv(.c) void;
    pub inline fn addRef(self: *BindGroupLayout) void {
        return wgpuBindGroupLayoutAddRef(self);
    }
    extern fn wgpuBindGroupLayoutRelease(self: *BindGroupLayout) callconv(.c) void;
    pub inline fn release(self: *BindGroupLayout) void {
        return wgpuBindGroupLayoutRelease(self);
    }
};

pub const Buffer = opaque {
    extern fn wgpuBufferMapAsync(self: *Buffer, mode: MapMode, offset: usize, size: usize, callback: BufferMapCallbackInfo) callconv(.c) Future;
    pub inline fn mapAsync(self: *Buffer, mode: MapMode, offset: usize, size: usize, callback: BufferMapCallbackInfo) Future {
        return wgpuBufferMapAsync(self, mode, offset, size, callback);
    }
    pub inline fn mapAsyncSync(self: *Buffer, mode: MapMode, offset: usize, size: usize) BufferMapCallbackInfo.State {
        var state: BufferMapCallbackInfo.State = undefined;
        const callback_info: BufferMapCallbackInfo = .{
            .callback = BufferMapCallbackInfo.default,
            .userdata1 = @ptrCast(&state),
        };
        _ = wgpuBufferMapAsync(self, mode, offset, size, callback_info);
        return state;
    }
    extern fn wgpuBufferGetMappedRange(self: *Buffer, offset: usize, size: usize) callconv(.c) *anyopaque;
    pub inline fn getMappedRange(self: *Buffer, offset: usize, size: usize) *anyopaque {
        return wgpuBufferGetMappedRange(self, offset, size);
    }
    extern fn wgpuBufferGetConstMappedRange(self: *Buffer, offset: usize, size: usize) callconv(.c) *const anyopaque;
    pub inline fn getConstMappedRange(self: *Buffer, offset: usize, size: usize) *const anyopaque {
        return wgpuBufferGetConstMappedRange(self, offset, size);
    }
    extern fn wgpuBufferSetLabel(self: *Buffer, label: StringView) callconv(.c) void;
    pub inline fn setLabel(self: *Buffer, label: StringView) void {
        return wgpuBufferSetLabel(self, label);
    }
    extern fn wgpuBufferGetUsage(self: *Buffer) callconv(.c) BufferUsage;
    pub inline fn getUsage(self: *Buffer) BufferUsage {
        return wgpuBufferGetUsage(self);
    }
    extern fn wgpuBufferGetSize(self: *Buffer) callconv(.c) u64;
    pub inline fn getSize(self: *Buffer) u64 {
        return wgpuBufferGetSize(self);
    }
    extern fn wgpuBufferGetMapState(self: *Buffer) callconv(.c) BufferMapState;
    pub inline fn getMapState(self: *Buffer) BufferMapState {
        return wgpuBufferGetMapState(self);
    }
    extern fn wgpuBufferUnmap(self: *Buffer) callconv(.c) void;
    pub inline fn unmap(self: *Buffer) void {
        return wgpuBufferUnmap(self);
    }
    extern fn wgpuBufferDestroy(self: *Buffer) callconv(.c) void;
    pub inline fn destroy(self: *Buffer) void {
        return wgpuBufferDestroy(self);
    }
    extern fn wgpuBufferAddRef(self: *Buffer) callconv(.c) void;
    pub inline fn addRef(self: *Buffer) void {
        return wgpuBufferAddRef(self);
    }
    extern fn wgpuBufferRelease(self: *Buffer) callconv(.c) void;
    pub inline fn release(self: *Buffer) void {
        return wgpuBufferRelease(self);
    }
};

pub const CommandBuffer = opaque {
    extern fn wgpuCommandBufferSetLabel(self: *CommandBuffer, label: StringView) callconv(.c) void;
    pub inline fn setLabel(self: *CommandBuffer, label: StringView) void {
        return wgpuCommandBufferSetLabel(self, label);
    }
    extern fn wgpuCommandBufferAddRef(self: *CommandBuffer) callconv(.c) void;
    pub inline fn addRef(self: *CommandBuffer) void {
        return wgpuCommandBufferAddRef(self);
    }
    extern fn wgpuCommandBufferRelease(self: *CommandBuffer) callconv(.c) void;
    pub inline fn release(self: *CommandBuffer) void {
        return wgpuCommandBufferRelease(self);
    }
};

pub const CommandEncoder = opaque {
    extern fn wgpuCommandEncoderFinish(self: *CommandEncoder, descriptor: ?*const CommandBufferDescriptor) callconv(.c) *CommandBuffer;
    pub inline fn finish(self: *CommandEncoder, descriptor: ?*const CommandBufferDescriptor) *CommandBuffer {
        return wgpuCommandEncoderFinish(self, descriptor);
    }
    extern fn wgpuCommandEncoderBeginComputePass(self: *CommandEncoder, descriptor: ?*const ComputePassDescriptor) callconv(.c) *ComputePassEncoder;
    pub inline fn beginComputePass(self: *CommandEncoder, descriptor: ?*const ComputePassDescriptor) *ComputePassEncoder {
        return wgpuCommandEncoderBeginComputePass(self, descriptor);
    }
    extern fn wgpuCommandEncoderBeginRenderPass(self: *CommandEncoder, descriptor: *const RenderPassDescriptor) callconv(.c) *RenderPassEncoder;
    pub inline fn beginRenderPass(self: *CommandEncoder, descriptor: *const RenderPassDescriptor) *RenderPassEncoder {
        return wgpuCommandEncoderBeginRenderPass(self, descriptor);
    }
    extern fn wgpuCommandEncoderCopyBufferToBuffer(self: *CommandEncoder, source: *Buffer, source_offset: u64, destination: *Buffer, destination_offset: u64, size: u64) callconv(.c) void;
    pub inline fn copyBufferToBuffer(self: *CommandEncoder, source: *Buffer, source_offset: u64, destination: *Buffer, destination_offset: u64, size: u64) void {
        return wgpuCommandEncoderCopyBufferToBuffer(self, source, source_offset, destination, destination_offset, size);
    }
    extern fn wgpuCommandEncoderCopyBufferToTexture(self: *CommandEncoder, source: *const TexelCopyBufferInfo, destination: *const TexelCopyTextureInfo, copy_size: *const Extent3D) callconv(.c) void;
    pub inline fn copyBufferToTexture(self: *CommandEncoder, source: *const TexelCopyBufferInfo, destination: *const TexelCopyTextureInfo, copy_size: *const Extent3D) void {
        return wgpuCommandEncoderCopyBufferToTexture(self, source, destination, copy_size);
    }
    extern fn wgpuCommandEncoderCopyTextureToBuffer(self: *CommandEncoder, source: *const TexelCopyTextureInfo, destination: *const TexelCopyBufferInfo, copy_size: *const Extent3D) callconv(.c) void;
    pub inline fn copyTextureToBuffer(self: *CommandEncoder, source: *const TexelCopyTextureInfo, destination: *const TexelCopyBufferInfo, copy_size: *const Extent3D) void {
        return wgpuCommandEncoderCopyTextureToBuffer(self, source, destination, copy_size);
    }
    extern fn wgpuCommandEncoderCopyTextureToTexture(self: *CommandEncoder, source: *const TexelCopyTextureInfo, destination: *const TexelCopyTextureInfo, copy_size: *const Extent3D) callconv(.c) void;
    pub inline fn copyTextureToTexture(self: *CommandEncoder, source: *const TexelCopyTextureInfo, destination: *const TexelCopyTextureInfo, copy_size: *const Extent3D) void {
        return wgpuCommandEncoderCopyTextureToTexture(self, source, destination, copy_size);
    }
    extern fn wgpuCommandEncoderClearBuffer(self: *CommandEncoder, buffer: *Buffer, offset: u64, size: u64) callconv(.c) void;
    pub inline fn clearBuffer(self: *CommandEncoder, buffer: *Buffer, offset: u64, size: u64) void {
        return wgpuCommandEncoderClearBuffer(self, buffer, offset, size);
    }
    extern fn wgpuCommandEncoderInsertDebugMarker(self: *CommandEncoder, marker_label: StringView) callconv(.c) void;
    pub inline fn insertDebugMarker(self: *CommandEncoder, marker_label: StringView) void {
        return wgpuCommandEncoderInsertDebugMarker(self, marker_label);
    }
    extern fn wgpuCommandEncoderPopDebugGroup(self: *CommandEncoder) callconv(.c) void;
    pub inline fn popDebugGroup(self: *CommandEncoder) void {
        return wgpuCommandEncoderPopDebugGroup(self);
    }
    extern fn wgpuCommandEncoderPushDebugGroup(self: *CommandEncoder, group_label: StringView) callconv(.c) void;
    pub inline fn pushDebugGroup(self: *CommandEncoder, group_label: StringView) void {
        return wgpuCommandEncoderPushDebugGroup(self, group_label);
    }
    extern fn wgpuCommandEncoderResolveQuerySet(self: *CommandEncoder, query_set: *QuerySet, first_query: u32, query_count: u32, destination: *Buffer, destination_offset: u64) callconv(.c) void;
    pub inline fn resolveQuerySet(self: *CommandEncoder, query_set: *QuerySet, first_query: u32, query_count: u32, destination: *Buffer, destination_offset: u64) void {
        return wgpuCommandEncoderResolveQuerySet(self, query_set, first_query, query_count, destination, destination_offset);
    }
    extern fn wgpuCommandEncoderWriteTimestamp(self: *CommandEncoder, query_set: *QuerySet, query_index: u32) callconv(.c) void;
    pub inline fn writeTimestamp(self: *CommandEncoder, query_set: *QuerySet, query_index: u32) void {
        return wgpuCommandEncoderWriteTimestamp(self, query_set, query_index);
    }
    extern fn wgpuCommandEncoderSetLabel(self: *CommandEncoder, label: StringView) callconv(.c) void;
    pub inline fn setLabel(self: *CommandEncoder, label: StringView) void {
        return wgpuCommandEncoderSetLabel(self, label);
    }
    extern fn wgpuCommandEncoderAddRef(self: *CommandEncoder) callconv(.c) void;
    pub inline fn addRef(self: *CommandEncoder) void {
        return wgpuCommandEncoderAddRef(self);
    }
    extern fn wgpuCommandEncoderRelease(self: *CommandEncoder) callconv(.c) void;
    pub inline fn release(self: *CommandEncoder) void {
        return wgpuCommandEncoderRelease(self);
    }
};

pub const ComputePassEncoder = opaque {
    extern fn wgpuComputePassEncoderInsertDebugMarker(self: *ComputePassEncoder, marker_label: StringView) callconv(.c) void;
    pub inline fn insertDebugMarker(self: *ComputePassEncoder, marker_label: StringView) void {
        return wgpuComputePassEncoderInsertDebugMarker(self, marker_label);
    }
    extern fn wgpuComputePassEncoderPopDebugGroup(self: *ComputePassEncoder) callconv(.c) void;
    pub inline fn popDebugGroup(self: *ComputePassEncoder) void {
        return wgpuComputePassEncoderPopDebugGroup(self);
    }
    extern fn wgpuComputePassEncoderPushDebugGroup(self: *ComputePassEncoder, group_label: StringView) callconv(.c) void;
    pub inline fn pushDebugGroup(self: *ComputePassEncoder, group_label: StringView) void {
        return wgpuComputePassEncoderPushDebugGroup(self, group_label);
    }
    extern fn wgpuComputePassEncoderSetPipeline(self: *ComputePassEncoder, pipeline: *ComputePipeline) callconv(.c) void;
    pub inline fn setPipeline(self: *ComputePassEncoder, pipeline: *ComputePipeline) void {
        return wgpuComputePassEncoderSetPipeline(self, pipeline);
    }
    extern fn wgpuComputePassEncoderSetBindGroup(self: *ComputePassEncoder, group_index: u32, group: ?*BindGroup, dynamic_offsets_count: usize, dynamic_offsets: ?[*]const u32) callconv(.c) void;
    pub inline fn setBindGroup(self: *ComputePassEncoder, group_index: u32, group: ?*BindGroup, dynamic_offsets: []const u32) void {
        return wgpuComputePassEncoderSetBindGroup(self, group_index, group, dynamic_offsets.len, dynamic_offsets.ptr);
    }
    extern fn wgpuComputePassEncoderDispatchWorkgroups(self: *ComputePassEncoder, workgroup_count_x: u32, workgroup_count_y: u32, workgroup_count_z: u32) callconv(.c) void;
    pub inline fn dispatchWorkgroups(self: *ComputePassEncoder, workgroup_count_x: u32, workgroup_count_y: u32, workgroup_count_z: u32) void {
        return wgpuComputePassEncoderDispatchWorkgroups(self, workgroup_count_x, workgroup_count_y, workgroup_count_z);
    }
    extern fn wgpuComputePassEncoderDispatchWorkgroupsIndirect(self: *ComputePassEncoder, indirect_buffer: *Buffer, indirect_offset: u64) callconv(.c) void;
    pub inline fn dispatchWorkgroupsIndirect(self: *ComputePassEncoder, indirect_buffer: *Buffer, indirect_offset: u64) void {
        return wgpuComputePassEncoderDispatchWorkgroupsIndirect(self, indirect_buffer, indirect_offset);
    }
    extern fn wgpuComputePassEncoderEnd(self: *ComputePassEncoder) callconv(.c) void;
    pub inline fn end(self: *ComputePassEncoder) void {
        return wgpuComputePassEncoderEnd(self);
    }
    extern fn wgpuComputePassEncoderSetLabel(self: *ComputePassEncoder, label: StringView) callconv(.c) void;
    pub inline fn setLabel(self: *ComputePassEncoder, label: StringView) void {
        return wgpuComputePassEncoderSetLabel(self, label);
    }
    extern fn wgpuComputePassEncoderAddRef(self: *ComputePassEncoder) callconv(.c) void;
    pub inline fn addRef(self: *ComputePassEncoder) void {
        return wgpuComputePassEncoderAddRef(self);
    }
    extern fn wgpuComputePassEncoderRelease(self: *ComputePassEncoder) callconv(.c) void;
    pub inline fn release(self: *ComputePassEncoder) void {
        return wgpuComputePassEncoderRelease(self);
    }
};

pub const ComputePipeline = opaque {
    extern fn wgpuComputePipelineGetBindGroupLayout(self: *ComputePipeline, group_index: u32) callconv(.c) *BindGroupLayout;
    pub inline fn getBindGroupLayout(self: *ComputePipeline, group_index: u32) *BindGroupLayout {
        return wgpuComputePipelineGetBindGroupLayout(self, group_index);
    }
    extern fn wgpuComputePipelineSetLabel(self: *ComputePipeline, label: StringView) callconv(.c) void;
    pub inline fn setLabel(self: *ComputePipeline, label: StringView) void {
        return wgpuComputePipelineSetLabel(self, label);
    }
    extern fn wgpuComputePipelineAddRef(self: *ComputePipeline) callconv(.c) void;
    pub inline fn addRef(self: *ComputePipeline) void {
        return wgpuComputePipelineAddRef(self);
    }
    extern fn wgpuComputePipelineRelease(self: *ComputePipeline) callconv(.c) void;
    pub inline fn release(self: *ComputePipeline) void {
        return wgpuComputePipelineRelease(self);
    }
};

pub const Device = opaque {
    extern fn wgpuDeviceCreateBindGroup(self: *Device, descriptor: *const BindGroupDescriptor) callconv(.c) *BindGroup;
    pub inline fn createBindGroup(self: *Device, descriptor: *const BindGroupDescriptor) *BindGroup {
        return wgpuDeviceCreateBindGroup(self, descriptor);
    }
    extern fn wgpuDeviceCreateBindGroupLayout(self: *Device, descriptor: *const BindGroupLayoutDescriptor) callconv(.c) *BindGroupLayout;
    pub inline fn createBindGroupLayout(self: *Device, descriptor: *const BindGroupLayoutDescriptor) *BindGroupLayout {
        return wgpuDeviceCreateBindGroupLayout(self, descriptor);
    }
    extern fn wgpuDeviceCreateBuffer(self: *Device, descriptor: *const BufferDescriptor) callconv(.c) *Buffer;
    pub inline fn createBuffer(self: *Device, descriptor: *const BufferDescriptor) *Buffer {
        return wgpuDeviceCreateBuffer(self, descriptor);
    }
    extern fn wgpuDeviceCreateCommandEncoder(self: *Device, descriptor: ?*const CommandEncoderDescriptor) callconv(.c) *CommandEncoder;
    pub inline fn createCommandEncoder(self: *Device, descriptor: ?*const CommandEncoderDescriptor) *CommandEncoder {
        return wgpuDeviceCreateCommandEncoder(self, descriptor);
    }
    extern fn wgpuDeviceCreateComputePipeline(self: *Device, descriptor: *const ComputePipelineDescriptor) callconv(.c) *ComputePipeline;
    pub inline fn createComputePipeline(self: *Device, descriptor: *const ComputePipelineDescriptor) *ComputePipeline {
        return wgpuDeviceCreateComputePipeline(self, descriptor);
    }
    extern fn wgpuDeviceCreateComputePipelineAsync(self: *Device, descriptor: *const ComputePipelineDescriptor, callback: CreateComputePipelineAsyncCallbackInfo) callconv(.c) Future;
    pub inline fn createComputePipelineAsync(self: *Device, descriptor: *const ComputePipelineDescriptor, callback: CreateComputePipelineAsyncCallbackInfo) Future {
        return wgpuDeviceCreateComputePipelineAsync(self, descriptor, callback);
    }
    pub inline fn createComputePipelineAsyncSync(self: *Device, descriptor: *const ComputePipelineDescriptor) CreateComputePipelineAsyncCallbackInfo.State {
        var state: CreateComputePipelineAsyncCallbackInfo.State = undefined;
        const callback_info: CreateComputePipelineAsyncCallbackInfo = .{
            .callback = CreateComputePipelineAsyncCallbackInfo.default,
            .userdata1 = @ptrCast(&state),
        };
        _ = wgpuDeviceCreateComputePipelineAsync(self, descriptor, callback_info);
        return state;
    }
    extern fn wgpuDeviceCreatePipelineLayout(self: *Device, descriptor: *const PipelineLayoutDescriptor) callconv(.c) *PipelineLayout;
    pub inline fn createPipelineLayout(self: *Device, descriptor: *const PipelineLayoutDescriptor) *PipelineLayout {
        return wgpuDeviceCreatePipelineLayout(self, descriptor);
    }
    extern fn wgpuDeviceCreateQuerySet(self: *Device, descriptor: *const QuerySetDescriptor) callconv(.c) *QuerySet;
    pub inline fn createQuerySet(self: *Device, descriptor: *const QuerySetDescriptor) *QuerySet {
        return wgpuDeviceCreateQuerySet(self, descriptor);
    }
    extern fn wgpuDeviceCreateRenderPipelineAsync(self: *Device, descriptor: *const RenderPipelineDescriptor, callback: CreateRenderPipelineAsyncCallbackInfo) callconv(.c) Future;
    pub inline fn createRenderPipelineAsync(self: *Device, descriptor: *const RenderPipelineDescriptor, callback: CreateRenderPipelineAsyncCallbackInfo) Future {
        return wgpuDeviceCreateRenderPipelineAsync(self, descriptor, callback);
    }
    pub inline fn createRenderPipelineAsyncSync(self: *Device, descriptor: *const RenderPipelineDescriptor) CreateRenderPipelineAsyncCallbackInfo.State {
        var state: CreateRenderPipelineAsyncCallbackInfo.State = undefined;
        const callback_info: CreateRenderPipelineAsyncCallbackInfo = .{
            .callback = CreateRenderPipelineAsyncCallbackInfo.default,
            .userdata1 = @ptrCast(&state),
        };
        _ = wgpuDeviceCreateRenderPipelineAsync(self, descriptor, callback_info);
        return state;
    }
    extern fn wgpuDeviceCreateRenderBundleEncoder(self: *Device, descriptor: *const RenderBundleEncoderDescriptor) callconv(.c) *RenderBundleEncoder;
    pub inline fn createRenderBundleEncoder(self: *Device, descriptor: *const RenderBundleEncoderDescriptor) *RenderBundleEncoder {
        return wgpuDeviceCreateRenderBundleEncoder(self, descriptor);
    }
    extern fn wgpuDeviceCreateRenderPipeline(self: *Device, descriptor: *const RenderPipelineDescriptor) callconv(.c) *RenderPipeline;
    pub inline fn createRenderPipeline(self: *Device, descriptor: *const RenderPipelineDescriptor) *RenderPipeline {
        return wgpuDeviceCreateRenderPipeline(self, descriptor);
    }
    extern fn wgpuDeviceCreateSampler(self: *Device, descriptor: ?*const SamplerDescriptor) callconv(.c) *Sampler;
    pub inline fn createSampler(self: *Device, descriptor: ?*const SamplerDescriptor) *Sampler {
        return wgpuDeviceCreateSampler(self, descriptor);
    }
    extern fn wgpuDeviceCreateShaderModule(self: *Device, descriptor: *const ShaderModuleDescriptor) callconv(.c) *ShaderModule;
    pub inline fn createShaderModule(self: *Device, descriptor: *const ShaderModuleDescriptor) *ShaderModule {
        return wgpuDeviceCreateShaderModule(self, descriptor);
    }
    extern fn wgpuDeviceCreateTexture(self: *Device, descriptor: *const TextureDescriptor) callconv(.c) *Texture;
    pub inline fn createTexture(self: *Device, descriptor: *const TextureDescriptor) *Texture {
        return wgpuDeviceCreateTexture(self, descriptor);
    }
    extern fn wgpuDeviceDestroy(self: *Device) callconv(.c) void;
    pub inline fn destroy(self: *Device) void {
        return wgpuDeviceDestroy(self);
    }
    extern fn wgpuDeviceGetLostFuture(self: *Device) callconv(.c) Future;
    ///
    pub inline fn getLostFuture(self: *Device) Future {
        return wgpuDeviceGetLostFuture(self);
    }
    extern fn wgpuDeviceGetLimits(self: *Device, limits: *Limits) callconv(.c) Status;
    pub inline fn getLimits(self: *Device, limits: *Limits) Status {
        return wgpuDeviceGetLimits(self, limits);
    }
    extern fn wgpuDeviceHasFeature(self: *Device, feature: FeatureName) callconv(.c) bool;
    pub inline fn hasFeature(self: *Device, feature: FeatureName) bool {
        return wgpuDeviceHasFeature(self, feature);
    }
    extern fn wgpuDeviceGetFeatures(self: *Device, features: *SupportedFeatures) callconv(.c) void;
    /// Get the list of @ref WGPUFeatureName values supported by the device.
    pub inline fn getFeatures(self: *Device, features: *SupportedFeatures) void {
        return wgpuDeviceGetFeatures(self, features);
    }
    extern fn wgpuDeviceGetAdapterInfo(self: *Device) callconv(.c) AdapterInfo;
    pub inline fn getAdapterInfo(self: *Device) AdapterInfo {
        return wgpuDeviceGetAdapterInfo(self);
    }
    extern fn wgpuDeviceGetQueue(self: *Device) callconv(.c) *Queue;
    pub inline fn getQueue(self: *Device) *Queue {
        return wgpuDeviceGetQueue(self);
    }
    extern fn wgpuDevicePushErrorScope(self: *Device, filter: ErrorFilter) callconv(.c) void;
    pub inline fn pushErrorScope(self: *Device, filter: ErrorFilter) void {
        return wgpuDevicePushErrorScope(self, filter);
    }
    extern fn wgpuDevicePopErrorScope(self: *Device, callback: PopErrorScopeCallbackInfo) callconv(.c) Future;
    pub inline fn popErrorScope(self: *Device, callback: PopErrorScopeCallbackInfo) Future {
        return wgpuDevicePopErrorScope(self, callback);
    }
    pub inline fn popErrorScopeSync(self: *Device) PopErrorScopeCallbackInfo.State {
        var state: PopErrorScopeCallbackInfo.State = undefined;
        const callback_info: PopErrorScopeCallbackInfo = .{
            .callback = PopErrorScopeCallbackInfo.default,
            .userdata1 = @ptrCast(&state),
        };
        _ = wgpuDevicePopErrorScope(self, callback_info);
        return state;
    }
    extern fn wgpuDeviceSetLabel(self: *Device, label: StringView) callconv(.c) void;
    pub inline fn setLabel(self: *Device, label: StringView) void {
        return wgpuDeviceSetLabel(self, label);
    }
    extern fn wgpuDeviceAddRef(self: *Device) callconv(.c) void;
    pub inline fn addRef(self: *Device) void {
        return wgpuDeviceAddRef(self);
    }
    extern fn wgpuDeviceRelease(self: *Device) callconv(.c) void;
    pub inline fn release(self: *Device) void {
        return wgpuDeviceRelease(self);
    }
};

pub const Instance = opaque {
    extern fn wgpuInstanceCreateSurface(self: *Instance, descriptor: *const SurfaceDescriptor) callconv(.c) *Surface;
    /// Creates a @ref WGPUSurface, see @ref Surface-Creation for more details.
    pub inline fn createSurface(self: *Instance, descriptor: *const SurfaceDescriptor) *Surface {
        return wgpuInstanceCreateSurface(self, descriptor);
    }
    extern fn wgpuInstanceGetWgslLanguageFeatures(self: *Instance, features: *SupportedWgslLanguageFeatures) callconv(.c) Status;
    /// Get the list of @ref WGPUWGSLLanguageFeatureName values supported by the instance.
    pub inline fn getWgslLanguageFeatures(self: *Instance, features: *SupportedWgslLanguageFeatures) Status {
        return wgpuInstanceGetWgslLanguageFeatures(self, features);
    }
    extern fn wgpuInstanceHasWgslLanguageFeature(self: *Instance, feature: WgslLanguageFeatureName) callconv(.c) bool;
    pub inline fn hasWgslLanguageFeature(self: *Instance, feature: WgslLanguageFeatureName) bool {
        return wgpuInstanceHasWgslLanguageFeature(self, feature);
    }
    extern fn wgpuInstanceProcessEvents(self: *Instance) callconv(.c) void;
    /// Processes asynchronous events on this `WGPUInstance`, calling any callbacks for asynchronous operations created with `::WGPUCallbackMode_AllowProcessEvents`.
    ///
    /// See @ref Process-Events for more information.
    pub inline fn processEvents(self: *Instance) void {
        return wgpuInstanceProcessEvents(self);
    }
    extern fn wgpuInstanceRequestAdapter(self: *Instance, options: ?*const RequestAdapterOptions, callback: RequestAdapterCallbackInfo) callconv(.c) Future;
    pub inline fn requestAdapter(self: *Instance, options: ?*const RequestAdapterOptions, callback: RequestAdapterCallbackInfo) Future {
        return wgpuInstanceRequestAdapter(self, options, callback);
    }
    pub inline fn requestAdapterSync(self: *Instance, options: ?*const RequestAdapterOptions) RequestAdapterCallbackInfo.State {
        var state: RequestAdapterCallbackInfo.State = undefined;
        const callback_info: RequestAdapterCallbackInfo = .{
            .callback = RequestAdapterCallbackInfo.default,
            .userdata1 = @ptrCast(&state),
        };
        _ = wgpuInstanceRequestAdapter(self, options, callback_info);
        return state;
    }
    extern fn wgpuInstanceWaitAny(self: *Instance, future_count: usize, futures: ?*FutureWaitInfo, timeout_ns: u64) callconv(.c) WaitStatus;
    /// Wait for at least one WGPUFuture in `futures` to complete, and call callbacks of the respective completed asynchronous operations.
    ///
    /// See @ref Wait-Any for more information.
    pub inline fn waitAny(self: *Instance, future_count: usize, futures: ?*FutureWaitInfo, timeout_ns: u64) WaitStatus {
        return wgpuInstanceWaitAny(self, future_count, futures, timeout_ns);
    }
    extern fn wgpuInstanceAddRef(self: *Instance) callconv(.c) void;
    pub inline fn addRef(self: *Instance) void {
        return wgpuInstanceAddRef(self);
    }
    extern fn wgpuInstanceRelease(self: *Instance) callconv(.c) void;
    pub inline fn release(self: *Instance) void {
        return wgpuInstanceRelease(self);
    }
};

pub const PipelineLayout = opaque {
    extern fn wgpuPipelineLayoutSetLabel(self: *PipelineLayout, label: StringView) callconv(.c) void;
    pub inline fn setLabel(self: *PipelineLayout, label: StringView) void {
        return wgpuPipelineLayoutSetLabel(self, label);
    }
    extern fn wgpuPipelineLayoutAddRef(self: *PipelineLayout) callconv(.c) void;
    pub inline fn addRef(self: *PipelineLayout) void {
        return wgpuPipelineLayoutAddRef(self);
    }
    extern fn wgpuPipelineLayoutRelease(self: *PipelineLayout) callconv(.c) void;
    pub inline fn release(self: *PipelineLayout) void {
        return wgpuPipelineLayoutRelease(self);
    }
};

pub const QuerySet = opaque {
    extern fn wgpuQuerySetSetLabel(self: *QuerySet, label: StringView) callconv(.c) void;
    pub inline fn setLabel(self: *QuerySet, label: StringView) void {
        return wgpuQuerySetSetLabel(self, label);
    }
    extern fn wgpuQuerySetGetType(self: *QuerySet) callconv(.c) QueryType;
    pub inline fn getType(self: *QuerySet) QueryType {
        return wgpuQuerySetGetType(self);
    }
    extern fn wgpuQuerySetGetCount(self: *QuerySet) callconv(.c) u32;
    pub inline fn getCount(self: *QuerySet) u32 {
        return wgpuQuerySetGetCount(self);
    }
    extern fn wgpuQuerySetDestroy(self: *QuerySet) callconv(.c) void;
    pub inline fn destroy(self: *QuerySet) void {
        return wgpuQuerySetDestroy(self);
    }
    extern fn wgpuQuerySetAddRef(self: *QuerySet) callconv(.c) void;
    pub inline fn addRef(self: *QuerySet) void {
        return wgpuQuerySetAddRef(self);
    }
    extern fn wgpuQuerySetRelease(self: *QuerySet) callconv(.c) void;
    pub inline fn release(self: *QuerySet) void {
        return wgpuQuerySetRelease(self);
    }
};

pub const Queue = opaque {
    extern fn wgpuQueueSubmit(self: *Queue, commands_count: usize, commands: ?[*]const *CommandBuffer) callconv(.c) void;
    pub inline fn submit(self: *Queue, commands: []const *CommandBuffer) void {
        return wgpuQueueSubmit(self, commands.len, commands.ptr);
    }
    extern fn wgpuQueueOnSubmittedWorkDone(self: *Queue, callback: QueueWorkDoneCallbackInfo) callconv(.c) Future;
    pub inline fn onSubmittedWorkDone(self: *Queue, callback: QueueWorkDoneCallbackInfo) Future {
        return wgpuQueueOnSubmittedWorkDone(self, callback);
    }
    pub inline fn onSubmittedWorkDoneSync(self: *Queue) QueueWorkDoneCallbackInfo.State {
        var state: QueueWorkDoneCallbackInfo.State = undefined;
        const callback_info: QueueWorkDoneCallbackInfo = .{
            .callback = QueueWorkDoneCallbackInfo.default,
            .userdata1 = @ptrCast(&state),
        };
        _ = wgpuQueueOnSubmittedWorkDone(self, callback_info);
        return state;
    }
    extern fn wgpuQueueWriteBuffer(self: *Queue, buffer: *Buffer, buffer_offset: u64, data: *const anyopaque, size: usize) callconv(.c) void;
    /// Produces a @ref DeviceError both content-timeline (`size` alignment) and device-timeline
    /// errors defined by the WebGPU specification.
    pub inline fn writeBuffer(self: *Queue, buffer: *Buffer, buffer_offset: u64, data: *const anyopaque, size: usize) void {
        return wgpuQueueWriteBuffer(self, buffer, buffer_offset, data, size);
    }
    extern fn wgpuQueueWriteTexture(self: *Queue, destination: *const TexelCopyTextureInfo, data: *const anyopaque, data_size: usize, data_layout: *const TexelCopyBufferLayout, write_size: *const Extent3D) callconv(.c) void;
    pub inline fn writeTexture(self: *Queue, destination: *const TexelCopyTextureInfo, data: *const anyopaque, data_size: usize, data_layout: *const TexelCopyBufferLayout, write_size: *const Extent3D) void {
        return wgpuQueueWriteTexture(self, destination, data, data_size, data_layout, write_size);
    }
    extern fn wgpuQueueSetLabel(self: *Queue, label: StringView) callconv(.c) void;
    pub inline fn setLabel(self: *Queue, label: StringView) void {
        return wgpuQueueSetLabel(self, label);
    }
    extern fn wgpuQueueAddRef(self: *Queue) callconv(.c) void;
    pub inline fn addRef(self: *Queue) void {
        return wgpuQueueAddRef(self);
    }
    extern fn wgpuQueueRelease(self: *Queue) callconv(.c) void;
    pub inline fn release(self: *Queue) void {
        return wgpuQueueRelease(self);
    }
};

pub const RenderBundle = opaque {
    extern fn wgpuRenderBundleSetLabel(self: *RenderBundle, label: StringView) callconv(.c) void;
    pub inline fn setLabel(self: *RenderBundle, label: StringView) void {
        return wgpuRenderBundleSetLabel(self, label);
    }
    extern fn wgpuRenderBundleAddRef(self: *RenderBundle) callconv(.c) void;
    pub inline fn addRef(self: *RenderBundle) void {
        return wgpuRenderBundleAddRef(self);
    }
    extern fn wgpuRenderBundleRelease(self: *RenderBundle) callconv(.c) void;
    pub inline fn release(self: *RenderBundle) void {
        return wgpuRenderBundleRelease(self);
    }
};

pub const RenderBundleEncoder = opaque {
    extern fn wgpuRenderBundleEncoderSetPipeline(self: *RenderBundleEncoder, pipeline: *RenderPipeline) callconv(.c) void;
    pub inline fn setPipeline(self: *RenderBundleEncoder, pipeline: *RenderPipeline) void {
        return wgpuRenderBundleEncoderSetPipeline(self, pipeline);
    }
    extern fn wgpuRenderBundleEncoderSetBindGroup(self: *RenderBundleEncoder, group_index: u32, group: ?*BindGroup, dynamic_offsets_count: usize, dynamic_offsets: ?[*]const u32) callconv(.c) void;
    pub inline fn setBindGroup(self: *RenderBundleEncoder, group_index: u32, group: ?*BindGroup, dynamic_offsets: []const u32) void {
        return wgpuRenderBundleEncoderSetBindGroup(self, group_index, group, dynamic_offsets.len, dynamic_offsets.ptr);
    }
    extern fn wgpuRenderBundleEncoderDraw(self: *RenderBundleEncoder, vertex_count: u32, instance_count: u32, first_vertex: u32, first_instance: u32) callconv(.c) void;
    pub inline fn draw(self: *RenderBundleEncoder, vertex_count: u32, instance_count: u32, first_vertex: u32, first_instance: u32) void {
        return wgpuRenderBundleEncoderDraw(self, vertex_count, instance_count, first_vertex, first_instance);
    }
    extern fn wgpuRenderBundleEncoderDrawIndexed(self: *RenderBundleEncoder, index_count: u32, instance_count: u32, first_index: u32, base_vertex: i32, first_instance: u32) callconv(.c) void;
    pub inline fn drawIndexed(self: *RenderBundleEncoder, index_count: u32, instance_count: u32, first_index: u32, base_vertex: i32, first_instance: u32) void {
        return wgpuRenderBundleEncoderDrawIndexed(self, index_count, instance_count, first_index, base_vertex, first_instance);
    }
    extern fn wgpuRenderBundleEncoderDrawIndirect(self: *RenderBundleEncoder, indirect_buffer: *Buffer, indirect_offset: u64) callconv(.c) void;
    pub inline fn drawIndirect(self: *RenderBundleEncoder, indirect_buffer: *Buffer, indirect_offset: u64) void {
        return wgpuRenderBundleEncoderDrawIndirect(self, indirect_buffer, indirect_offset);
    }
    extern fn wgpuRenderBundleEncoderDrawIndexedIndirect(self: *RenderBundleEncoder, indirect_buffer: *Buffer, indirect_offset: u64) callconv(.c) void;
    pub inline fn drawIndexedIndirect(self: *RenderBundleEncoder, indirect_buffer: *Buffer, indirect_offset: u64) void {
        return wgpuRenderBundleEncoderDrawIndexedIndirect(self, indirect_buffer, indirect_offset);
    }
    extern fn wgpuRenderBundleEncoderInsertDebugMarker(self: *RenderBundleEncoder, marker_label: StringView) callconv(.c) void;
    pub inline fn insertDebugMarker(self: *RenderBundleEncoder, marker_label: StringView) void {
        return wgpuRenderBundleEncoderInsertDebugMarker(self, marker_label);
    }
    extern fn wgpuRenderBundleEncoderPopDebugGroup(self: *RenderBundleEncoder) callconv(.c) void;
    pub inline fn popDebugGroup(self: *RenderBundleEncoder) void {
        return wgpuRenderBundleEncoderPopDebugGroup(self);
    }
    extern fn wgpuRenderBundleEncoderPushDebugGroup(self: *RenderBundleEncoder, group_label: StringView) callconv(.c) void;
    pub inline fn pushDebugGroup(self: *RenderBundleEncoder, group_label: StringView) void {
        return wgpuRenderBundleEncoderPushDebugGroup(self, group_label);
    }
    extern fn wgpuRenderBundleEncoderSetVertexBuffer(self: *RenderBundleEncoder, slot: u32, buffer: ?*Buffer, offset: u64, size: u64) callconv(.c) void;
    pub inline fn setVertexBuffer(self: *RenderBundleEncoder, slot: u32, buffer: ?*Buffer, offset: u64, size: u64) void {
        return wgpuRenderBundleEncoderSetVertexBuffer(self, slot, buffer, offset, size);
    }
    extern fn wgpuRenderBundleEncoderSetIndexBuffer(self: *RenderBundleEncoder, buffer: *Buffer, format: IndexFormat, offset: u64, size: u64) callconv(.c) void;
    pub inline fn setIndexBuffer(self: *RenderBundleEncoder, buffer: *Buffer, format: IndexFormat, offset: u64, size: u64) void {
        return wgpuRenderBundleEncoderSetIndexBuffer(self, buffer, format, offset, size);
    }
    extern fn wgpuRenderBundleEncoderFinish(self: *RenderBundleEncoder, descriptor: ?*const RenderBundleDescriptor) callconv(.c) *RenderBundle;
    pub inline fn finish(self: *RenderBundleEncoder, descriptor: ?*const RenderBundleDescriptor) *RenderBundle {
        return wgpuRenderBundleEncoderFinish(self, descriptor);
    }
    extern fn wgpuRenderBundleEncoderSetLabel(self: *RenderBundleEncoder, label: StringView) callconv(.c) void;
    pub inline fn setLabel(self: *RenderBundleEncoder, label: StringView) void {
        return wgpuRenderBundleEncoderSetLabel(self, label);
    }
    extern fn wgpuRenderBundleEncoderAddRef(self: *RenderBundleEncoder) callconv(.c) void;
    pub inline fn addRef(self: *RenderBundleEncoder) void {
        return wgpuRenderBundleEncoderAddRef(self);
    }
    extern fn wgpuRenderBundleEncoderRelease(self: *RenderBundleEncoder) callconv(.c) void;
    pub inline fn release(self: *RenderBundleEncoder) void {
        return wgpuRenderBundleEncoderRelease(self);
    }
};

pub const RenderPassEncoder = opaque {
    extern fn wgpuRenderPassEncoderSetPipeline(self: *RenderPassEncoder, pipeline: *RenderPipeline) callconv(.c) void;
    pub inline fn setPipeline(self: *RenderPassEncoder, pipeline: *RenderPipeline) void {
        return wgpuRenderPassEncoderSetPipeline(self, pipeline);
    }
    extern fn wgpuRenderPassEncoderSetBindGroup(self: *RenderPassEncoder, group_index: u32, group: ?*BindGroup, dynamic_offsets_count: usize, dynamic_offsets: ?[*]const u32) callconv(.c) void;
    pub inline fn setBindGroup(self: *RenderPassEncoder, group_index: u32, group: ?*BindGroup, dynamic_offsets: []const u32) void {
        return wgpuRenderPassEncoderSetBindGroup(self, group_index, group, dynamic_offsets.len, dynamic_offsets.ptr);
    }
    extern fn wgpuRenderPassEncoderDraw(self: *RenderPassEncoder, vertex_count: u32, instance_count: u32, first_vertex: u32, first_instance: u32) callconv(.c) void;
    pub inline fn draw(self: *RenderPassEncoder, vertex_count: u32, instance_count: u32, first_vertex: u32, first_instance: u32) void {
        return wgpuRenderPassEncoderDraw(self, vertex_count, instance_count, first_vertex, first_instance);
    }
    extern fn wgpuRenderPassEncoderDrawIndexed(self: *RenderPassEncoder, index_count: u32, instance_count: u32, first_index: u32, base_vertex: i32, first_instance: u32) callconv(.c) void;
    pub inline fn drawIndexed(self: *RenderPassEncoder, index_count: u32, instance_count: u32, first_index: u32, base_vertex: i32, first_instance: u32) void {
        return wgpuRenderPassEncoderDrawIndexed(self, index_count, instance_count, first_index, base_vertex, first_instance);
    }
    extern fn wgpuRenderPassEncoderDrawIndirect(self: *RenderPassEncoder, indirect_buffer: *Buffer, indirect_offset: u64) callconv(.c) void;
    pub inline fn drawIndirect(self: *RenderPassEncoder, indirect_buffer: *Buffer, indirect_offset: u64) void {
        return wgpuRenderPassEncoderDrawIndirect(self, indirect_buffer, indirect_offset);
    }
    extern fn wgpuRenderPassEncoderDrawIndexedIndirect(self: *RenderPassEncoder, indirect_buffer: *Buffer, indirect_offset: u64) callconv(.c) void;
    pub inline fn drawIndexedIndirect(self: *RenderPassEncoder, indirect_buffer: *Buffer, indirect_offset: u64) void {
        return wgpuRenderPassEncoderDrawIndexedIndirect(self, indirect_buffer, indirect_offset);
    }
    extern fn wgpuRenderPassEncoderExecuteBundles(self: *RenderPassEncoder, bundles_count: usize, bundles: ?[*]const *RenderBundle) callconv(.c) void;
    pub inline fn executeBundles(self: *RenderPassEncoder, bundles: []const *RenderBundle) void {
        return wgpuRenderPassEncoderExecuteBundles(self, bundles.len, bundles.ptr);
    }
    extern fn wgpuRenderPassEncoderInsertDebugMarker(self: *RenderPassEncoder, marker_label: StringView) callconv(.c) void;
    pub inline fn insertDebugMarker(self: *RenderPassEncoder, marker_label: StringView) void {
        return wgpuRenderPassEncoderInsertDebugMarker(self, marker_label);
    }
    extern fn wgpuRenderPassEncoderPopDebugGroup(self: *RenderPassEncoder) callconv(.c) void;
    pub inline fn popDebugGroup(self: *RenderPassEncoder) void {
        return wgpuRenderPassEncoderPopDebugGroup(self);
    }
    extern fn wgpuRenderPassEncoderPushDebugGroup(self: *RenderPassEncoder, group_label: StringView) callconv(.c) void;
    pub inline fn pushDebugGroup(self: *RenderPassEncoder, group_label: StringView) void {
        return wgpuRenderPassEncoderPushDebugGroup(self, group_label);
    }
    extern fn wgpuRenderPassEncoderSetStencilReference(self: *RenderPassEncoder, reference: u32) callconv(.c) void;
    pub inline fn setStencilReference(self: *RenderPassEncoder, reference: u32) void {
        return wgpuRenderPassEncoderSetStencilReference(self, reference);
    }
    extern fn wgpuRenderPassEncoderSetBlendConstant(self: *RenderPassEncoder, color: *const Color) callconv(.c) void;
    pub inline fn setBlendConstant(self: *RenderPassEncoder, color: *const Color) void {
        return wgpuRenderPassEncoderSetBlendConstant(self, color);
    }
    extern fn wgpuRenderPassEncoderSetViewport(self: *RenderPassEncoder, x: f32, y: f32, width: f32, height: f32, min_depth: f32, max_depth: f32) callconv(.c) void;
    pub inline fn setViewport(self: *RenderPassEncoder, x: f32, y: f32, width: f32, height: f32, min_depth: f32, max_depth: f32) void {
        return wgpuRenderPassEncoderSetViewport(self, x, y, width, height, min_depth, max_depth);
    }
    extern fn wgpuRenderPassEncoderSetScissorRect(self: *RenderPassEncoder, x: u32, y: u32, width: u32, height: u32) callconv(.c) void;
    pub inline fn setScissorRect(self: *RenderPassEncoder, x: u32, y: u32, width: u32, height: u32) void {
        return wgpuRenderPassEncoderSetScissorRect(self, x, y, width, height);
    }
    extern fn wgpuRenderPassEncoderSetVertexBuffer(self: *RenderPassEncoder, slot: u32, buffer: ?*Buffer, offset: u64, size: u64) callconv(.c) void;
    pub inline fn setVertexBuffer(self: *RenderPassEncoder, slot: u32, buffer: ?*Buffer, offset: u64, size: u64) void {
        return wgpuRenderPassEncoderSetVertexBuffer(self, slot, buffer, offset, size);
    }
    extern fn wgpuRenderPassEncoderSetIndexBuffer(self: *RenderPassEncoder, buffer: *Buffer, format: IndexFormat, offset: u64, size: u64) callconv(.c) void;
    pub inline fn setIndexBuffer(self: *RenderPassEncoder, buffer: *Buffer, format: IndexFormat, offset: u64, size: u64) void {
        return wgpuRenderPassEncoderSetIndexBuffer(self, buffer, format, offset, size);
    }
    extern fn wgpuRenderPassEncoderBeginOcclusionQuery(self: *RenderPassEncoder, query_index: u32) callconv(.c) void;
    pub inline fn beginOcclusionQuery(self: *RenderPassEncoder, query_index: u32) void {
        return wgpuRenderPassEncoderBeginOcclusionQuery(self, query_index);
    }
    extern fn wgpuRenderPassEncoderEndOcclusionQuery(self: *RenderPassEncoder) callconv(.c) void;
    pub inline fn endOcclusionQuery(self: *RenderPassEncoder) void {
        return wgpuRenderPassEncoderEndOcclusionQuery(self);
    }
    extern fn wgpuRenderPassEncoderEnd(self: *RenderPassEncoder) callconv(.c) void;
    pub inline fn end(self: *RenderPassEncoder) void {
        return wgpuRenderPassEncoderEnd(self);
    }
    extern fn wgpuRenderPassEncoderSetLabel(self: *RenderPassEncoder, label: StringView) callconv(.c) void;
    pub inline fn setLabel(self: *RenderPassEncoder, label: StringView) void {
        return wgpuRenderPassEncoderSetLabel(self, label);
    }
    extern fn wgpuRenderPassEncoderAddRef(self: *RenderPassEncoder) callconv(.c) void;
    pub inline fn addRef(self: *RenderPassEncoder) void {
        return wgpuRenderPassEncoderAddRef(self);
    }
    extern fn wgpuRenderPassEncoderRelease(self: *RenderPassEncoder) callconv(.c) void;
    pub inline fn release(self: *RenderPassEncoder) void {
        return wgpuRenderPassEncoderRelease(self);
    }
};

pub const RenderPipeline = opaque {
    extern fn wgpuRenderPipelineGetBindGroupLayout(self: *RenderPipeline, group_index: u32) callconv(.c) *BindGroupLayout;
    pub inline fn getBindGroupLayout(self: *RenderPipeline, group_index: u32) *BindGroupLayout {
        return wgpuRenderPipelineGetBindGroupLayout(self, group_index);
    }
    extern fn wgpuRenderPipelineSetLabel(self: *RenderPipeline, label: StringView) callconv(.c) void;
    pub inline fn setLabel(self: *RenderPipeline, label: StringView) void {
        return wgpuRenderPipelineSetLabel(self, label);
    }
    extern fn wgpuRenderPipelineAddRef(self: *RenderPipeline) callconv(.c) void;
    pub inline fn addRef(self: *RenderPipeline) void {
        return wgpuRenderPipelineAddRef(self);
    }
    extern fn wgpuRenderPipelineRelease(self: *RenderPipeline) callconv(.c) void;
    pub inline fn release(self: *RenderPipeline) void {
        return wgpuRenderPipelineRelease(self);
    }
};

pub const Sampler = opaque {
    extern fn wgpuSamplerSetLabel(self: *Sampler, label: StringView) callconv(.c) void;
    pub inline fn setLabel(self: *Sampler, label: StringView) void {
        return wgpuSamplerSetLabel(self, label);
    }
    extern fn wgpuSamplerAddRef(self: *Sampler) callconv(.c) void;
    pub inline fn addRef(self: *Sampler) void {
        return wgpuSamplerAddRef(self);
    }
    extern fn wgpuSamplerRelease(self: *Sampler) callconv(.c) void;
    pub inline fn release(self: *Sampler) void {
        return wgpuSamplerRelease(self);
    }
};

pub const ShaderModule = opaque {
    extern fn wgpuShaderModuleGetCompilationInfo(self: *ShaderModule, callback: CompilationInfoCallbackInfo) callconv(.c) Future;
    pub inline fn getCompilationInfo(self: *ShaderModule, callback: CompilationInfoCallbackInfo) Future {
        return wgpuShaderModuleGetCompilationInfo(self, callback);
    }
    pub inline fn getCompilationInfoSync(self: *ShaderModule) CompilationInfoCallbackInfo.State {
        var state: CompilationInfoCallbackInfo.State = undefined;
        const callback_info: CompilationInfoCallbackInfo = .{
            .callback = CompilationInfoCallbackInfo.default,
            .userdata1 = @ptrCast(&state),
        };
        _ = wgpuShaderModuleGetCompilationInfo(self, callback_info);
        return state;
    }
    extern fn wgpuShaderModuleSetLabel(self: *ShaderModule, label: StringView) callconv(.c) void;
    pub inline fn setLabel(self: *ShaderModule, label: StringView) void {
        return wgpuShaderModuleSetLabel(self, label);
    }
    extern fn wgpuShaderModuleAddRef(self: *ShaderModule) callconv(.c) void;
    pub inline fn addRef(self: *ShaderModule) void {
        return wgpuShaderModuleAddRef(self);
    }
    extern fn wgpuShaderModuleRelease(self: *ShaderModule) callconv(.c) void;
    pub inline fn release(self: *ShaderModule) void {
        return wgpuShaderModuleRelease(self);
    }
};

pub const Surface = opaque {
    extern fn wgpuSurfaceConfigure(self: *Surface, config: *const SurfaceConfiguration) callconv(.c) void;
    /// Configures parameters for rendering to `surface`.
    /// Produces a @ref DeviceError for all content-timeline errors defined by the WebGPU specification.
    ///
    /// See @ref Surface-Configuration for more details.
    pub inline fn configure(self: *Surface, config: *const SurfaceConfiguration) void {
        return wgpuSurfaceConfigure(self, config);
    }
    extern fn wgpuSurfaceGetCapabilities(self: *Surface, adapter: *Adapter, capabilities: *SurfaceCapabilities) callconv(.c) Status;
    /// Provides information on how `adapter` is able to use `surface`.
    /// See @ref Surface-Capabilities for more details.
    pub inline fn getCapabilities(self: *Surface, adapter: *Adapter, capabilities: *SurfaceCapabilities) Status {
        return wgpuSurfaceGetCapabilities(self, adapter, capabilities);
    }
    extern fn wgpuSurfaceGetCurrentTexture(self: *Surface, surface_texture: *SurfaceTexture) callconv(.c) void;
    /// Returns the @ref WGPUTexture to render to `surface` this frame along with metadata on the frame.
    /// Returns `NULL` and @ref WGPUSurfaceGetCurrentTextureStatus_Error if the surface is not configured.
    ///
    /// See @ref Surface-Presenting for more details.
    pub inline fn getCurrentTexture(self: *Surface, surface_texture: *SurfaceTexture) void {
        return wgpuSurfaceGetCurrentTexture(self, surface_texture);
    }
    extern fn wgpuSurfacePresent(self: *Surface) callconv(.c) Status;
    /// Shows `surface`'s current texture to the user.
    /// See @ref Surface-Presenting for more details.
    pub inline fn present(self: *Surface) Status {
        return wgpuSurfacePresent(self);
    }
    extern fn wgpuSurfaceUnconfigure(self: *Surface) callconv(.c) void;
    /// Removes the configuration for `surface`.
    /// See @ref Surface-Configuration for more details.
    pub inline fn unconfigure(self: *Surface) void {
        return wgpuSurfaceUnconfigure(self);
    }
    extern fn wgpuSurfaceSetLabel(self: *Surface, label: StringView) callconv(.c) void;
    /// Modifies the label used to refer to `surface`.
    pub inline fn setLabel(self: *Surface, label: StringView) void {
        return wgpuSurfaceSetLabel(self, label);
    }
    extern fn wgpuSurfaceAddRef(self: *Surface) callconv(.c) void;
    pub inline fn addRef(self: *Surface) void {
        return wgpuSurfaceAddRef(self);
    }
    extern fn wgpuSurfaceRelease(self: *Surface) callconv(.c) void;
    pub inline fn release(self: *Surface) void {
        return wgpuSurfaceRelease(self);
    }
};

pub const Texture = opaque {
    extern fn wgpuTextureCreateView(self: *Texture, descriptor: ?*const TextureViewDescriptor) callconv(.c) *TextureView;
    pub inline fn createView(self: *Texture, descriptor: ?*const TextureViewDescriptor) *TextureView {
        return wgpuTextureCreateView(self, descriptor);
    }
    extern fn wgpuTextureSetLabel(self: *Texture, label: StringView) callconv(.c) void;
    pub inline fn setLabel(self: *Texture, label: StringView) void {
        return wgpuTextureSetLabel(self, label);
    }
    extern fn wgpuTextureGetWidth(self: *Texture) callconv(.c) u32;
    pub inline fn getWidth(self: *Texture) u32 {
        return wgpuTextureGetWidth(self);
    }
    extern fn wgpuTextureGetHeight(self: *Texture) callconv(.c) u32;
    pub inline fn getHeight(self: *Texture) u32 {
        return wgpuTextureGetHeight(self);
    }
    extern fn wgpuTextureGetDepthOrArrayLayers(self: *Texture) callconv(.c) u32;
    pub inline fn getDepthOrArrayLayers(self: *Texture) u32 {
        return wgpuTextureGetDepthOrArrayLayers(self);
    }
    extern fn wgpuTextureGetMipLevelCount(self: *Texture) callconv(.c) u32;
    pub inline fn getMipLevelCount(self: *Texture) u32 {
        return wgpuTextureGetMipLevelCount(self);
    }
    extern fn wgpuTextureGetSampleCount(self: *Texture) callconv(.c) u32;
    pub inline fn getSampleCount(self: *Texture) u32 {
        return wgpuTextureGetSampleCount(self);
    }
    extern fn wgpuTextureGetDimension(self: *Texture) callconv(.c) TextureDimension;
    pub inline fn getDimension(self: *Texture) TextureDimension {
        return wgpuTextureGetDimension(self);
    }
    extern fn wgpuTextureGetFormat(self: *Texture) callconv(.c) TextureFormat;
    pub inline fn getFormat(self: *Texture) TextureFormat {
        return wgpuTextureGetFormat(self);
    }
    extern fn wgpuTextureGetUsage(self: *Texture) callconv(.c) TextureUsage;
    pub inline fn getUsage(self: *Texture) TextureUsage {
        return wgpuTextureGetUsage(self);
    }
    extern fn wgpuTextureDestroy(self: *Texture) callconv(.c) void;
    pub inline fn destroy(self: *Texture) void {
        return wgpuTextureDestroy(self);
    }
    extern fn wgpuTextureAddRef(self: *Texture) callconv(.c) void;
    pub inline fn addRef(self: *Texture) void {
        return wgpuTextureAddRef(self);
    }
    extern fn wgpuTextureRelease(self: *Texture) callconv(.c) void;
    pub inline fn release(self: *Texture) void {
        return wgpuTextureRelease(self);
    }
};

pub const TextureView = opaque {
    extern fn wgpuTextureViewSetLabel(self: *TextureView, label: StringView) callconv(.c) void;
    pub inline fn setLabel(self: *TextureView, label: StringView) void {
        return wgpuTextureViewSetLabel(self, label);
    }
    extern fn wgpuTextureViewAddRef(self: *TextureView) callconv(.c) void;
    pub inline fn addRef(self: *TextureView) void {
        return wgpuTextureViewAddRef(self);
    }
    extern fn wgpuTextureViewRelease(self: *TextureView) callconv(.c) void;
    pub inline fn release(self: *TextureView) void {
        return wgpuTextureViewRelease(self);
    }
};
