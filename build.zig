const std = @import("std");

pub fn build(b: *std.Build) void {
    // Stage 1C fixes every production and inspection unit to the complete
    // x86_64_v1 psABI baseline. No command-line target or CPU override exists.
    const baseline_target = b.resolveTargetQuery(.{
        .cpu_arch = .x86_64,
        .cpu_model = .{ .explicit = &std.Target.x86.cpu.x86_64 },
        .os_tag = .windows,
        .abi = .msvc,
    });
    const optimize = b.standardOptimizeOption(.{});

    // G10 debug-only modules are source-visible opt-ins and are structurally
    // barred from every non-Debug optimisation mode.
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
    const enable_trace_lifecycle = b.option(
        bool,
        "enable_trace_lifecycle",
        "Include the Debug-only plugin lifecycle trace",
    ) orelse false;

    if ((enable_force_down or
        enable_verbose_detection or
        enable_trace_lifecycle) and optimize != .Debug)
    {
        @panic(
            "Deblock4 debug-only options require -Doptimize=Debug",
        );
    }

    const runtime_options = b.addOptions();
    runtime_options.addOption(bool, "enable_force_down", enable_force_down);
    runtime_options.addOption(
        bool,
        "enable_verbose_detection",
        enable_verbose_detection,
    );
    runtime_options.addOption(
        bool,
        "enable_trace_lifecycle",
        enable_trace_lifecycle,
    );

    // VapourSynth API4 is translated once and shared by every VS-facing root.
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

    // Real Stage 1C plugin DLL. The root is registration-only; all runtime
    // behaviour remains in the settled purpose-grouped modules.
    const dll_module = b.createModule(.{
        .root_source_file = b.path("src/deblock4_plugin.zig"),
        .target = baseline_target,
        .optimize = optimize,
        .link_libc = true,
    });
    dll_module.addOptions("deblock4_build_options", runtime_options);
    dll_module.addImport("vapoursynth_api4", vapoursynth_api4_module);
    dll_module.addIncludePath(b.path("third_party/vapoursynth/include"));
    dll_module.addIncludePath(b.path("src"));
    dll_module.addCSourceFile(.{
        .file = b.path("src/vapoursynth_helper_bridge.c"),
        .flags = &.{"-std=c11"},
    });

    const dll = b.addLibrary(.{
        .name = "Deblock4",
        .linkage = .dynamic,
        .root_module = dll_module,
    });
    b.installArtifact(dll);

    const dll_check_step = b.step(
        "dll-check",
        "Compile the real Stage 1C Deblock4 plugin DLL",
    );
    dll_check_step.dependOn(&dll.step);

    // First-class runtime-capability and Stage 1C pure-contract self-test.
    const selftest_module = b.createModule(.{
        .root_source_file = b.path("src/deblock4_selftest.zig"),
        .target = baseline_target,
        .optimize = optimize,
    });
    selftest_module.addOptions("deblock4_build_options", runtime_options);

    const selftest = b.addExecutable(.{
        .name = "deblock4_selftest",
        .root_module = selftest_module,
    });
    b.installArtifact(selftest);

    const selftest_step = b.step(
        "selftest",
        "Compile the first-class Deblock4 self-test",
    );
    selftest_step.dependOn(&selftest.step);

    const run_selftest = b.addRunArtifact(selftest);
    const selftest_run_step = b.step(
        "selftest-run",
        "Build and run the first-class Deblock4 self-test",
    );
    selftest_run_step.dependOn(&run_selftest.step);

    // Retained baseline-v1 detection inspection object. This is independent
    // of the retired backend probes and remains the G3/7.4 safety regression.
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
        "Build the baseline-v1 CPU detection inspection object",
    );
    detection_object_step.dependOn(&install_detection_object.step);

    // Stable baseline-v1 frame-path objects support the structural/symbolic
    // proof that no callback or activation module performs tier selection.
    const classic_router_object_module = b.createModule(.{
        .root_source_file = b.path("src/classic_callback_router.zig"),
        .target = baseline_target,
        .optimize = optimize,
    });
    classic_router_object_module.addOptions(
        "deblock4_build_options",
        runtime_options,
    );
    classic_router_object_module.addImport(
        "vapoursynth_api4",
        vapoursynth_api4_module,
    );
    const classic_router_object = b.addObject(.{
        .name = "classic_callback_router",
        .root_module = classic_router_object_module,
    });

    const deblock4_router_object_module = b.createModule(.{
        .root_source_file = b.path("src/deblock4_callback_router.zig"),
        .target = baseline_target,
        .optimize = optimize,
    });
    deblock4_router_object_module.addOptions(
        "deblock4_build_options",
        runtime_options,
    );
    deblock4_router_object_module.addImport(
        "vapoursynth_api4",
        vapoursynth_api4_module,
    );
    const deblock4_router_object = b.addObject(.{
        .name = "deblock4_callback_router",
        .root_module = deblock4_router_object_module,
    });

    const classic_initial_object_module = b.createModule(.{
        .root_source_file = b.path("src/classic_ar_initial.zig"),
        .target = baseline_target,
        .optimize = optimize,
    });
    classic_initial_object_module.addImport(
        "vapoursynth_api4",
        vapoursynth_api4_module,
    );
    const classic_initial_object = b.addObject(.{
        .name = "classic_ar_initial",
        .root_module = classic_initial_object_module,
    });

    const deblock4_initial_object_module = b.createModule(.{
        .root_source_file = b.path("src/deblock4_ar_initial.zig"),
        .target = baseline_target,
        .optimize = optimize,
    });
    deblock4_initial_object_module.addImport(
        "vapoursynth_api4",
        vapoursynth_api4_module,
    );
    const deblock4_initial_object = b.addObject(.{
        .name = "deblock4_ar_initial",
        .root_module = deblock4_initial_object_module,
    });

    const classic_ready_object_module = b.createModule(.{
        .root_source_file = b.path("src/classic_ar_all_frames_ready.zig"),
        .target = baseline_target,
        .optimize = optimize,
    });
    classic_ready_object_module.addImport(
        "vapoursynth_api4",
        vapoursynth_api4_module,
    );
    const classic_ready_object = b.addObject(.{
        .name = "classic_ar_all_frames_ready",
        .root_module = classic_ready_object_module,
    });

    const deblock4_ready_object_module = b.createModule(.{
        .root_source_file = b.path("src/deblock4_ar_all_frames_ready.zig"),
        .target = baseline_target,
        .optimize = optimize,
    });
    deblock4_ready_object_module.addImport(
        "vapoursynth_api4",
        vapoursynth_api4_module,
    );
    const deblock4_ready_object = b.addObject(.{
        .name = "deblock4_ar_all_frames_ready",
        .root_module = deblock4_ready_object_module,
    });

    const frame_path_object_step = b.step(
        "frame-path-objects",
        "Build stable Stage 1C callback and activation inspection objects",
    );
    const frame_path_objects = .{
        .{ classic_router_object, "classic_callback_router.obj" },
        .{ deblock4_router_object, "deblock4_callback_router.obj" },
        .{ classic_initial_object, "classic_ar_initial.obj" },
        .{ deblock4_initial_object, "deblock4_ar_initial.obj" },
        .{ classic_ready_object, "classic_ar_all_frames_ready.obj" },
        .{ deblock4_ready_object, "deblock4_ar_all_frames_ready.obj" },
    };
    inline for (frame_path_objects) |entry| {
        const install_object = b.addInstallFile(
            entry[0].getEmittedBin(),
            b.fmt("frame-path-objects/{s}", .{entry[1]}),
        );
        frame_path_object_step.dependOn(&install_object.step);
    }

    // Pure-module tests remain independent of VapourSynth.
    const version_tests = b.addTest(.{
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/deblock4_version.zig"),
            .target = baseline_target,
            .optimize = optimize,
        }),
    });
    const run_version_tests = b.addRunArtifact(version_tests);

    const common_instance_tests = b.addTest(.{
        .root_module = b.createModule(.{
            .root_source_file = b.path(
                "src/common_instance_data_structure.zig",
            ),
            .target = baseline_target,
            .optimize = optimize,
        }),
    });
    const run_common_instance_tests = b.addRunArtifact(common_instance_tests);

    const parameter_tests = b.addTest(.{
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/filter_call_parameters.zig"),
            .target = baseline_target,
            .optimize = optimize,
        }),
    });
    const run_parameter_tests = b.addRunArtifact(parameter_tests);

    const tier_selection_test_module = b.createModule(.{
        .root_source_file = b.path("src/backend_tier_selection.zig"),
        .target = baseline_target,
        .optimize = optimize,
    });
    tier_selection_test_module.addOptions(
        "deblock4_build_options",
        runtime_options,
    );
    const tier_selection_tests = b.addTest(.{
        .root_module = tier_selection_test_module,
    });
    const run_tier_selection_tests = b.addRunArtifact(tier_selection_tests);

    // Clip-dependent validation tests live in the two creation modules and
    // compile against the real translated API and bridge.
    const classic_creation_test_module = b.createModule(.{
        .root_source_file = b.path("src/classic_instance_creation.zig"),
        .target = baseline_target,
        .optimize = optimize,
        .link_libc = true,
    });
    classic_creation_test_module.addOptions(
        "deblock4_build_options",
        runtime_options,
    );
    classic_creation_test_module.addImport(
        "vapoursynth_api4",
        vapoursynth_api4_module,
    );
    classic_creation_test_module.addIncludePath(
        b.path("third_party/vapoursynth/include"),
    );
    classic_creation_test_module.addIncludePath(b.path("src"));
    classic_creation_test_module.addCSourceFile(.{
        .file = b.path("src/vapoursynth_helper_bridge.c"),
        .flags = &.{"-std=c11"},
    });
    const classic_creation_tests = b.addTest(.{
        .root_module = classic_creation_test_module,
    });
    const run_classic_creation_tests =
        b.addRunArtifact(classic_creation_tests);

    const deblock4_creation_test_module = b.createModule(.{
        .root_source_file = b.path("src/deblock4_instance_creation.zig"),
        .target = baseline_target,
        .optimize = optimize,
        .link_libc = true,
    });
    deblock4_creation_test_module.addOptions(
        "deblock4_build_options",
        runtime_options,
    );
    deblock4_creation_test_module.addImport(
        "vapoursynth_api4",
        vapoursynth_api4_module,
    );
    deblock4_creation_test_module.addIncludePath(
        b.path("third_party/vapoursynth/include"),
    );
    deblock4_creation_test_module.addIncludePath(b.path("src"));
    deblock4_creation_test_module.addCSourceFile(.{
        .file = b.path("src/vapoursynth_helper_bridge.c"),
        .flags = &.{"-std=c11"},
    });
    const deblock4_creation_tests = b.addTest(.{
        .root_module = deblock4_creation_test_module,
    });
    const run_deblock4_creation_tests =
        b.addRunArtifact(deblock4_creation_tests);

    const test_step = b.step(
        "test",
        "Run the complete Stage 1C unit-test suite",
    );
    test_step.dependOn(&run_version_tests.step);
    test_step.dependOn(&run_common_instance_tests.step);
    test_step.dependOn(&run_parameter_tests.step);
    test_step.dependOn(&run_tier_selection_tests.step);
    test_step.dependOn(&run_classic_creation_tests.step);
    test_step.dependOn(&run_deblock4_creation_tests.step);
}
