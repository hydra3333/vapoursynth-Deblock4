const std = @import("std");

pub fn build(b: *std.Build) void {
    // The native Windows target is sufficient for the initial scaffold.
    // Production target and SIMD closures remain Stage 1 spike results.
    const target = b.standardTargetOptions(.{});

    // Allow explicit Debug, ReleaseSafe, ReleaseFast, or ReleaseSmall builds.
    const optimize = b.standardOptimizeOption(.{});

    // ---------------------------------------------------------------------
    // VapourSynth API4 C-header translation.
    // ---------------------------------------------------------------------

    const vapoursynth_api4_translate = b.addTranslateC(.{
        .root_source_file = b.path("src/vapoursynth_api4.h"),
        .target = target,
        .optimize = optimize,
    });

    vapoursynth_api4_translate.addIncludePath(
        b.path("third_party/vapoursynth/include"),
    );

    const vapoursynth_api4_module =
        vapoursynth_api4_translate.createModule();

    const vs_translate_step = b.step(
        "vs-translate-check",
        "Translate the VapourSynth API4 core header",
    );
    vs_translate_step.dependOn(&vapoursynth_api4_translate.step);

    // ---------------------------------------------------------------------
    // Standalone Zig build probe.
    // ---------------------------------------------------------------------

    const build_probe = b.addExecutable(.{
        .name = "deblock4_build_probe",
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/build_probe.zig"),
            .target = target,
            .optimize = optimize,
        }),
    });

    b.installArtifact(build_probe);

    const check_step = b.step(
        "check",
        "Compile the standalone Deblock4 build probe",
    );
    check_step.dependOn(&build_probe.step);

    const run_build_probe = b.addRunArtifact(build_probe);
    run_build_probe.step.dependOn(b.getInstallStep());

    if (b.args) |args| {
        run_build_probe.addArgs(args);
    }

    const run_step = b.step(
        "run",
        "Build and run the standalone Deblock4 build probe",
    );
    run_step.dependOn(&run_build_probe.step);

    // ---------------------------------------------------------------------
    // Deblock4 dynamic-library probe.
    // ---------------------------------------------------------------------

    const dll = b.addLibrary(.{
        .name = "Deblock4",
        .linkage = .dynamic,
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/dll_probe.zig"),
            .target = target,
            .optimize = optimize,
        }),
    });

    b.installArtifact(dll);

    const dll_check_step = b.step(
        "dll-check",
        "Compile the Deblock4 dynamic-library probe",
    );
    dll_check_step.dependOn(&dll.step);

    const dll_smoke_test = b.addExecutable(.{
        .name = "deblock4_dll_smoke_test",
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/dll_smoke_test.zig"),
            .target = target,
            .optimize = optimize,
        }),
    });

    dll_smoke_test.root_module.linkLibrary(dll);
    b.installArtifact(dll_smoke_test);

    const dll_smoke_check_step = b.step(
        "dll-smoke-check",
        "Compile the executable that calls the Deblock4 DLL",
    );
    dll_smoke_check_step.dependOn(&dll_smoke_test.step);

    // ---------------------------------------------------------------------
    // VapourSynth translated-header probe.
    // ---------------------------------------------------------------------

    const vs_header_probe = b.addExecutable(.{
        .name = "deblock4_vs_header_probe",
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/vapoursynth_header_probe.zig"),
            .target = target,
            .optimize = optimize,
            .imports = &.{
                .{
                    .name = "vapoursynth_api4",
                    .module = vapoursynth_api4_module,
                },
            },
        }),
    });

    b.installArtifact(vs_header_probe);

    const vs_header_check_step = b.step(
        "vs-header-check",
        "Compile the VapourSynth API4 translated-header probe",
    );
    vs_header_check_step.dependOn(&vs_header_probe.step);

    const run_vs_header_probe = b.addRunArtifact(vs_header_probe);
    run_vs_header_probe.step.dependOn(b.getInstallStep());

    const vs_header_run_step = b.step(
        "vs-header-run",
        "Build and run the VapourSynth API4 header probe",
    );
    vs_header_run_step.dependOn(&run_vs_header_probe.step);

    // ---------------------------------------------------------------------
    // Zig unit tests.
    // ---------------------------------------------------------------------

    const build_probe_tests = b.addTest(.{
        .root_module = build_probe.root_module,
    });

    const run_build_probe_tests = b.addRunArtifact(build_probe_tests);

    const dll_probe_tests = b.addTest(.{
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/dll_probe.zig"),
            .target = target,
            .optimize = optimize,
        }),
    });

    const run_dll_probe_tests = b.addRunArtifact(dll_probe_tests);

    const vs_header_tests = b.addTest(.{
        .root_module = vs_header_probe.root_module,
    });

    const run_vs_header_tests = b.addRunArtifact(vs_header_tests);

    const test_step = b.step(
        "test",
        "Run all current Deblock4 scaffold tests",
    );
    test_step.dependOn(&run_build_probe_tests.step);
    test_step.dependOn(&run_dll_probe_tests.step);
    test_step.dependOn(&run_vs_header_tests.step);
}
