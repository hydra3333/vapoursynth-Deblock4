const std = @import("std");

pub fn build(b: *std.Build) void {
    // Stage 1B.2 fixes baseline units to the complete x86_64_v1 psABI level.
    // No command-line CPU or target option can replace this target.
    const baseline_target = b.resolveTargetQuery(.{
        .cpu_arch = .x86_64,
        .cpu_model = .{ .explicit = &std.Target.x86.cpu.x86_64 },
        .os_tag = .windows,
        .abi = .msvc,
    });

    // The separately compiled backend objects use the complete named psABI
    // levels. x86_64_v3 includes FMA; strict float semantics prevent implicit
    // result-changing contraction rather than removing FMA from the target.
    const sse41_probe_target = b.resolveTargetQuery(.{
        .cpu_arch = .x86_64,
        .cpu_model = .{ .explicit = &std.Target.x86.cpu.x86_64_v2 },
        .os_tag = .windows,
        .abi = .msvc,
    });

    const avx2_probe_target = b.resolveTargetQuery(.{
        .cpu_arch = .x86_64,
        .cpu_model = .{ .explicit = &std.Target.x86.cpu.x86_64_v3 },
        .os_tag = .windows,
        .abi = .msvc,
    });

    // Allow explicit Debug, ReleaseSafe, ReleaseFast, or ReleaseSmall builds.
    const optimize = b.standardOptimizeOption(.{});

    // G10 debug-only modules are explicit opt-ins and are structurally barred
    // from every non-Debug optimisation mode.
    const enable_force_down = b.option(
        bool,
        "enable_force_down",
        "Include the Debug-only capability force-down seam",
    ) orelse false;
    const enable_verbose_detection = b.option(
        bool,
        "enable_verbose_detection",
        "Include Debug-only verbose capability diagnostics",
    ) orelse false;

    if ((enable_force_down or enable_verbose_detection) and
        optimize != .Debug)
    {
        @panic(
            "Deblock4 debug-only capability options require -Doptimize=Debug",
        );
    }

    const runtime_options = b.addOptions();
    runtime_options.addOption(bool, "enable_force_down", enable_force_down);
    runtime_options.addOption(
        bool,
        "enable_verbose_detection",
        enable_verbose_detection,
    );
    // ---------------------------------------------------------------------
    // VapourSynth API4 C-header translation.
    // ---------------------------------------------------------------------

    const vapoursynth_api4_translate = b.addTranslateC(.{
        .root_source_file = b.path("src/vapoursynth_api4.h"),
        .target = baseline_target,
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
            .target = baseline_target,
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
    // Separately targeted backend probe objects.
    // ---------------------------------------------------------------------

    const backend_probe_generic_module = b.createModule(.{
        .root_source_file = b.path("src/backend_probe_generic.zig"),
        .target = baseline_target,
        .optimize = optimize,
    });

    const backend_probe_generic = b.addObject(.{
        .name = "deblock4_backend_probe_generic",
        .root_module = backend_probe_generic_module,
    });

    const backend_probe_scalar_module = b.createModule(.{
        .root_source_file = b.path("src/backend_probe_scalar.zig"),
        .target = baseline_target,
        .optimize = optimize,
    });

    const backend_probe_scalar = b.addObject(.{
        .name = "deblock4_backend_probe_scalar",
        .root_module = backend_probe_scalar_module,
    });

    const backend_probe_sse41_module = b.createModule(.{
        .root_source_file = b.path("src/backend_probe_sse41.zig"),
        .target = sse41_probe_target,
        .optimize = optimize,
    });

    const backend_probe_sse41 = b.addObject(.{
        .name = "deblock4_backend_probe_sse41",
        .root_module = backend_probe_sse41_module,
    });

    const backend_probe_avx2_module = b.createModule(.{
        .root_source_file = b.path("src/backend_probe_avx2.zig"),
        .target = avx2_probe_target,
        .optimize = optimize,
    });

    const backend_probe_avx2 = b.addObject(.{
        .name = "deblock4_backend_probe_avx2",
        .root_module = backend_probe_avx2_module,
    });

    // Stable object copies are required for ReleaseFast dumpbin /SYMBOLS
    // inspection. Do not inspect Zig cache paths.
    const install_backend_probe_generic = b.addInstallFile(
        backend_probe_generic.getEmittedBin(),
        "backend-objects/deblock4_backend_probe_generic.obj",
    );
    const install_backend_probe_scalar = b.addInstallFile(
        backend_probe_scalar.getEmittedBin(),
        "backend-objects/deblock4_backend_probe_scalar.obj",
    );
    const install_backend_probe_sse41 = b.addInstallFile(
        backend_probe_sse41.getEmittedBin(),
        "backend-objects/deblock4_backend_probe_sse41.obj",
    );
    const install_backend_probe_avx2 = b.addInstallFile(
        backend_probe_avx2.getEmittedBin(),
        "backend-objects/deblock4_backend_probe_avx2.obj",
    );

    b.getInstallStep().dependOn(&install_backend_probe_generic.step);
    b.getInstallStep().dependOn(&install_backend_probe_scalar.step);
    b.getInstallStep().dependOn(&install_backend_probe_sse41.step);
    b.getInstallStep().dependOn(&install_backend_probe_avx2.step);

    // ---------------------------------------------------------------------
    // Deblock4 dynamic-library probe.
    // ---------------------------------------------------------------------

    const dll_probe_module = b.createModule(.{
        .root_source_file = b.path("src/dll_probe.zig"),
        .target = baseline_target,
        .optimize = optimize,
    });
    dll_probe_module.addOptions(
        "deblock4_build_options",
        runtime_options,
    );

    // The retained baseline root imports only baseline modules. Generic and
    // scalar exports are therefore part of the DLL compilation graph. Gated
    // modules stay outside that graph and are referenced across the linker
    // seam by @extern declarations in backend_retention_anchor.zig.
    const dll_root_module = b.createModule(.{
        .root_source_file = b.path("src/backend_retention_anchor.zig"),
        .target = baseline_target,
        .optimize = optimize,
    });
    dll_root_module.addImport("dll_probe", dll_probe_module);
    dll_root_module.addImport(
        "backend_probe_generic",
        backend_probe_generic_module,
    );
    dll_root_module.addImport(
        "backend_probe_scalar",
        backend_probe_scalar_module,
    );

    const dll = b.addLibrary(.{
        .name = "Deblock4",
        .linkage = .dynamic,
        .root_module = dll_root_module,
    });

    // Generic and scalar are compiled through the DLL root graph and must not
    // also be linked as separate objects. Their standalone object artifacts
    // remain inspection outputs only. Gated objects cross the target boundary
    // only at the linker seam.
    dll.root_module.addObject(backend_probe_sse41);
    dll.root_module.addObject(backend_probe_avx2);

    b.installArtifact(dll);

    const dll_check_step = b.step(
        "dll-check",
        "Compile the Deblock4 dynamic-library probe",
    );
    dll_check_step.dependOn(&dll.step);

    // ---------------------------------------------------------------------
    // First-class runtime-capability self-test and inspection object.
    // ---------------------------------------------------------------------

    const selftest_module = b.createModule(.{
        .root_source_file = b.path("src/deblock4_selftest.zig"),
        .target = baseline_target,
        .optimize = optimize,
    });
    selftest_module.addOptions(
        "deblock4_build_options",
        runtime_options,
    );

    const selftest = b.addExecutable(.{
        .name = "deblock4_selftest",
        .root_module = selftest_module,
    });
    b.installArtifact(selftest);

    const selftest_step = b.step(
        "selftest",
        "Compile the first-class Deblock4 capability self-test",
    );
    selftest_step.dependOn(&selftest.step);

    const run_selftest = b.addRunArtifact(selftest);
    const selftest_run_step = b.step(
        "selftest-run",
        "Build and run the Deblock4 capability self-test",
    );
    selftest_run_step.dependOn(&run_selftest.step);

    const detection_object_module = b.createModule(.{
        .root_source_file = b.path("src/cpu_capability_detection.zig"),
        .target = baseline_target,
        .optimize = optimize,
    });
    detection_object_module.addOptions(
        "deblock4_build_options",
        runtime_options,
    );

    const detection_object = b.addObject(.{
        .name = "cpu_capability_detection",
        .root_module = detection_object_module,
    });
    const install_detection_object = b.addInstallFile(
        detection_object.getEmittedBin(),
        "detection-objects/cpu_capability_detection.obj",
    );
    const detection_object_step = b.step(
        "detection-object",
        "Build the baseline-v1 CPU capability detection inspection object",
    );
    detection_object_step.dependOn(&install_detection_object.step);

    const dll_smoke_test = b.addExecutable(.{
        .name = "deblock4_dll_smoke_test",
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/dll_smoke_test.zig"),
            .target = baseline_target,
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
    // Backend-isolation smoke test: generic and scalar only.
    // ---------------------------------------------------------------------

    const backend_isolation_smoke_test = b.addExecutable(.{
        .name = "deblock4_backend_isolation_smoke_test",
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/backend_isolation_smoke_test.zig"),
            .target = baseline_target,
            .optimize = optimize,
        }),
    });

    backend_isolation_smoke_test.root_module.linkLibrary(dll);
    b.installArtifact(backend_isolation_smoke_test);

    const backend_isolation_check_step = b.step(
        "backend-isolation-check",
        "Compile the four-object DLL and safe backend smoke test",
    );
    backend_isolation_check_step.dependOn(&backend_isolation_smoke_test.step);

    const run_backend_isolation_smoke_test =
        b.addRunArtifact(backend_isolation_smoke_test);
    run_backend_isolation_smoke_test.step.dependOn(b.getInstallStep());

    const backend_isolation_run_step = b.step(
        "backend-isolation-run",
        "Run the generic/scalar backend-isolation smoke test",
    );
    backend_isolation_run_step.dependOn(
        &run_backend_isolation_smoke_test.step,
    );

    // ---------------------------------------------------------------------
    // VapourSynth translated-header probe.
    // ---------------------------------------------------------------------

    const vs_header_probe = b.addExecutable(.{
        .name = "deblock4_vs_header_probe",
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/vapoursynth_header_probe.zig"),
            .target = baseline_target,
            .optimize = optimize,
            .link_libc = true,
            .imports = &.{
                .{
                    .name = "vapoursynth_api4",
                    .module = vapoursynth_api4_module,
                },
            },
        }),
    });

    // VSHelper4.h is header-only C helper code. Compile it through a stable
    // bridge rather than translating its Windows CRT dependencies into Zig.
    vs_header_probe.root_module.addIncludePath(
        b.path("third_party/vapoursynth/include"),
    );

    vs_header_probe.root_module.addCSourceFile(.{
        .file = b.path("src/vapoursynth_helper_bridge.c"),
        .flags = &.{"-std=c11"},
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

    const dll_probe_test_module = b.createModule(.{
        .root_source_file = b.path("src/dll_probe.zig"),
        .target = baseline_target,
        .optimize = optimize,
    });
    dll_probe_test_module.addOptions(
        "deblock4_build_options",
        runtime_options,
    );
    const dll_probe_tests = b.addTest(.{
        .root_module = dll_probe_test_module,
    });

    const run_dll_probe_tests = b.addRunArtifact(dll_probe_tests);

    const capability_test_module = b.createModule(.{
        .root_source_file = b.path("src/cpu_capability_detection.zig"),
        .target = baseline_target,
        .optimize = optimize,
    });
    capability_test_module.addOptions(
        "deblock4_build_options",
        runtime_options,
    );
    const capability_tests = b.addTest(.{
        .root_module = capability_test_module,
    });
    const run_capability_tests = b.addRunArtifact(capability_tests);

    const backend_probe_generic_tests = b.addTest(.{
        .root_module = backend_probe_generic.root_module,
    });

    const run_backend_probe_generic_tests =
        b.addRunArtifact(backend_probe_generic_tests);

    const backend_probe_scalar_tests = b.addTest(.{
        .root_module = backend_probe_scalar.root_module,
    });

    const run_backend_probe_scalar_tests =
        b.addRunArtifact(backend_probe_scalar_tests);

    const vs_header_tests = b.addTest(.{
        .root_module = vs_header_probe.root_module,
    });

    const run_vs_header_tests = b.addRunArtifact(vs_header_tests);

    const test_step = b.step(
        "test",
        "Run all current Deblock4 tests",
    );
    test_step.dependOn(&run_build_probe_tests.step);
    test_step.dependOn(&run_dll_probe_tests.step);
    test_step.dependOn(&run_capability_tests.step);
    test_step.dependOn(&run_backend_probe_generic_tests.step);
    test_step.dependOn(&run_backend_probe_scalar_tests.step);
    test_step.dependOn(&run_vs_header_tests.step);
}
