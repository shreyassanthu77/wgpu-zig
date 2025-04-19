# WGPU Zig

WebGPU bindings for Zig programming language.

## Features

- Complete Zig bindings for WebGPU native
- Cross-platform support (Windows, macOS, Linux, Android, iOS)
- Automatic platform-specific library linking
- Chain initialization utility for fluent API style
- Generated from the official WebGPU headers

## Installation

Add this dependency to your `build.zig.zon`:

```zig
.dependencies = .{
    .wgpu_zig = .{
        .url = "https://github.com/shreyassanthu77/wgpu-zig/archive/main.tar.gz",
        .hash = "...", // Add the appropriate hash here
    },
},
```

In your `build.zig`, add:

```zig
const wgpu_zig = b.dependency("wgpu_zig", .{});
exe.root_module.addImport("wgpu", wgpu_zig.module("wgpu"));
```

## Example

```zig
const std = @import("std");
const wgpu = @import("wgpu");

pub fn main() !void {
    const instance = wgpu.createInstance(null);
    defer instance.release();
    
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
```

## License

MIT License