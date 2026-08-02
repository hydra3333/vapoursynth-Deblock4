// G10 debug-only verbose capability diagnostics.
//
// This file must be reached only through the source-visible C-3 conditional
// import under enable_verbose_detection. The inner gate is defence in depth.
const std = @import("std");
const deblock4_config = @import("deblock4_config.zig");
const print_helpers = @import("print_helper_functions.zig");

pub const tools = if (deblock4_config.debug.enable_verbose_detection) struct {
    pub const MARKER =
        "DEBLOCK4_VERBOSE_DETECTION_MARKER_DD00D001";
    pub const CODE_MARKER: u32 = 0xDD00_D001;

    pub fn deblock4_verbose_detection_marker_DD00D001() u32 {
        std.debug.print("{s}\n", .{MARKER});
        return CODE_MARKER;
    }

    comptime {
        // G10 layer-3 positive control: retain the probe whenever this gated
        // feature exists, without introducing a runtime call.
        _ = &deblock4_verbose_detection_marker_DD00D001;
    }

    pub fn dumpDetection(actual: anytype, effective: anytype) void {
        std.debug.print(
            "deblock4: verbose capability detection marker={s}\n",
            .{MARKER},
        );

        std.debug.print("deblock4: level=x86_64_v1\n", .{});
        printFeature("CMOV", actual.features.cmov);
        printFeature("CX8", actual.features.cx8);
        printFeature("FPU", actual.features.fpu);
        printFeature("FXSR", actual.features.fxsr);
        printFeature("MMX", actual.features.mmx);
        printFeature("OSFXSR", actual.features.osfxsr);
        printFeature("SCE", actual.features.sce);
        printFeature("SSE", actual.features.sse);
        printFeature("SSE2", actual.features.sse2);

        std.debug.print("deblock4: level=x86_64_v2 additions\n", .{});
        printFeature("CMPXCHG16B", actual.features.cmpxchg16b);
        printFeature("LAHF-SAHF", actual.features.lahf_sahf);
        printFeature("POPCNT", actual.features.popcnt);
        printFeature("SSE3", actual.features.sse3);
        printFeature("SSE4.1", actual.features.sse4_1);
        printFeature("SSE4.2", actual.features.sse4_2);
        printFeature("SSSE3", actual.features.ssse3);

        std.debug.print("deblock4: level=x86_64_v3 additions\n", .{});
        printFeature("AVX", actual.features.avx);
        printFeature("AVX2", actual.features.avx2);
        printFeature("BMI1", actual.features.bmi1);
        printFeature("BMI2", actual.features.bmi2);
        printFeature("F16C", actual.features.f16c);
        printFeature("FMA", actual.features.fma);
        printFeature("LZCNT", actual.features.lzcnt);
        printFeature("MOVBE", actual.features.movbe);
        printFeature("OSXSAVE", actual.features.osxsave);

        std.debug.print(
            "deblock4: set-B XCR0.YMM state={s} raw=0x{X:0>16}\n",
            .{ xcr0StateName(actual.xcr0_state), actual.xcr0_raw },
        );
        std.debug.print(
            "deblock4: actual-tier={s} effective-tier={s}",
            .{
                print_helpers.tierName(actual.resolved_tier),
                print_helpers.tierName(effective.resolved_tier),
            },
        );
        if (effective.force_down_ceiling) |ceiling| {
            std.debug.print(
                " force-down-ceiling={s}",
                .{print_helpers.tierName(ceiling)},
            );
        }
        std.debug.print("\n", .{});
    }

    fn printFeature(name: []const u8, state: anytype) void {
        std.debug.print(
            "deblock4:   {s}={s}\n",
            .{ name, featureStateName(state) },
        );
    }

    fn featureStateName(state: anytype) []const u8 {
        return switch (state) {
            .detected_present => "detected present",
            .detected_absent => "detected absent",
            .policy_assumed_present =>
                "OS baseline assumed (Windows x64 process policy)",
        };
    }

    fn xcr0StateName(state: anytype) []const u8 {
        return switch (state) {
            .not_queried_osxsave_absent =>
                "not queried because OSXSAVE is absent",
            .queried_xmm_ymm_present => "queried; XMM+YMM present",
            .queried_xmm_ymm_absent => "queried; XMM+YMM absent",
        };
    }
} else struct {};
