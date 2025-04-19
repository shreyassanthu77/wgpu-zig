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

## TODO

- [ ] Add examples
- [ ] Add Tests
- [ ] Add Documentation
- [ ] Fix Windows builds

## License

MIT License
