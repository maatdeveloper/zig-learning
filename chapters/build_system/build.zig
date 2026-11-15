const std = @import("std");
const builtin = @import("builtin");

pub fn build(b: *std.Build) void {
    //const target = b.standardTargetOptions(.{});
    //const optimize = b.standardOptimizeOption(.{});
    if (builtin.target.os.tag == .windows) {
        // do nothing
    }

    const use_zlib = b.option(
        bool,
        "use_zlib",
        "Should link to zlib",
    ) orelse false; 

    const exe = b.addExecutable(.{
        .name = "hello",
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/main.zig"),
            .target = b.graph.host,
            .optimize = .ReleaseSafe,
            .link_libc = true,
        }),
        .version = .{
            .major = 1,
            .minor = 1,
            .patch = 1,
        },
    });
    
    if (use_zlib) {
        exe.root_module.linkSystemLibrary("zlib", .{});
    }

    //exe.root_module.linkSystemLibrary("png", .{});
    b.installArtifact(exe);
    const run_arti_exe = b.addRunArtifact(exe); // executar apos a compilacao
    const run_step_exe = b.step("run", "Run the artifact");

    run_step_exe.dependOn(&run_arti_exe.step);

    const test_exe = b.addTest(.{
        .name = "unit_test",
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/main.zig"),
            .target = b.graph.host,
        }),
    });

    b.installArtifact(test_exe);
    const run_arti_test = b.addRunArtifact(test_exe);
    const run_step_test = b.step("tests", "Run unit tests");

    run_step_test.dependOn(&run_arti_test.step);
}
