const std = @import("std");
const wgpu = @import("wgpu");

pub const std_options: std.Options = .{
    .log_level = .info,
};

pub fn main() !void {
    const instance = wgpu.createInstance(null);
    // defer instance.release();

    var adapter_null: ?*wgpu.Adapter = null;
    instance.requestAdapter(null, .{
        .callback = struct {
            fn callback(s: wgpu.RequestAdapterStatus, a: ?*wgpu.Adapter, _: wgpu.StringView, ud1: ?*anyopaque, _: ?*anyopaque) callconv(.c) void {
                std.log.info("RequestAdapterCallback: {}", .{s});
                const adapter_ptr: *?*wgpu.Adapter = @ptrCast(@alignCast(ud1));
                adapter_ptr.* = a;
            }
        }.callback,
        .mode = .allow_spontaneous,
        .userdata1 = @ptrCast(&adapter_null),
    });
    const adapter = adapter_null orelse return error.NoAdapter;
    defer adapter.release();

    var info: wgpu.AdapterInfo = undefined;
    const status = adapter.getInfo(&info);
    if (status != .success) {
        std.log.info("GetInfo failed: {}", .{status});
        return error.GetInfoFailed;
    }
    std.log.info("Adapter name: {s}", .{info.device.into()});
}
