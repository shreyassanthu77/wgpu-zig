const std = @import("std");

pub fn build(b: *std.Build) !void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const wgpu_dep = try getWgpu(b, target, optimize);
    const libwgpu_path = switch (target.result.os.tag) {
        .windows => "lib/wgpu_native.lib",
        else => "lib/libwgpu_native.a",
    };

    const gen_tool = b.addSystemCommand(&.{
        "deno",
        "--allow-read",
        "--allow-write",
    });
    gen_tool.addFileArg(b.path("scripts/gen.ts"));
    gen_tool.addFileArg(wgpu_dep.path("wgpu-native-meta/webgpu.yml"));

    const gen_step = b.step("gen", "Generate WGPU bindings");
    gen_step.dependOn(&gen_tool.step);

    const wgpu = b.addModule("wgpu", .{
        .target = target,
        .optimize = optimize,
        .root_source_file = b.path("src/root.zig"),
        .link_libcpp = true,
    });
    wgpu.addObjectFile(wgpu_dep.path(libwgpu_path));

    // const include_path = wgpu_dep.path("include/webgpu");
    //
    // const translate_step = b.addTranslateC(.{
    //     // wgpu.h imports webgpu.h, so we get the contents of both files, as well as a bunch of libc garbage.
    //     .root_source_file = include_path.path(b, "wgpu.h"),
    //
    //     .target = target,
    //     .optimize = optimize,
    // });
    //
    // translate_step.addIncludePath(include_path);
}

/// taken from https://github.com/bronter/wgpu_native_zig/blob/2012f51c16d29824ea15cc4db6e46fc5bb44e868/build.zig.zon
fn getWgpu(
    b: *std.Build,
    target: std.Build.ResolvedTarget,
    optimize: std.builtin.OptimizeMode,
) !*std.Build.Dependency {
    const target_res = target.result;
    const os_str = @tagName(target_res.os.tag);
    const arch_str = @tagName(target_res.cpu.arch);

    const mode_str = switch (optimize) {
        .Debug => "debug",
        else => "release",
    };
    const abi_str = switch (target_res.os.tag) {
        .ios => switch (target_res.abi) {
            .simulator => "_simulator",
            else => "",
        },
        .windows => switch (target_res.abi) {
            .msvc => "_msvc",
            else => "_gnu",
        },
        else => "",
    };
    const target_name_slices = [_][:0]const u8{ "wgpu_", os_str, "_", arch_str, abi_str, "_", mode_str };
    const maybe_target_name = std.mem.concatWithSentinel(b.allocator, u8, &target_name_slices, 0);
    const target_name = maybe_target_name catch |err| {
        std.debug.panic("Failed to format target name: {s}", .{@errorName(err)});
    };

    // Check if we have a dependency matching our selected target.
    for (b.available_deps) |dep| {
        const name, _ = dep;
        if (std.mem.eql(u8, name, target_name)) {
            break;
        }
    } else {
        std.debug.panic("Could not find dependency matching target {s}", .{target_name});
    }

    const wgpu_dep = b.lazyDependency(target_name, .{}) orelse return error.CouldNotFetchWgpuLibrary;
    return wgpu_dep;
}
