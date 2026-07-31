// Deblock4 baseline-safe CPU/OS capability detection and per-instance
// effective-capability construction.
//
// G1: actual capability is detected once process-wide and never modified.
// Effective capability is derived once per instance by intersection with an
// optional debug-only force-down ceiling. Dispatch will consume EFFECTIVE.
const std = @import("std");
const builtin = @import("builtin");
const deblock4_config = @import("deblock4_config.zig");
const print_helpers = @import("print_helper_functions.zig");

const diag_dbg = if (deblock4_config.debug.enable_verbose_detection)
    @import("print_diag_helper_functions.zig")
else
    struct {};

const force_down_dbg = if (deblock4_config.debug.enable_force_down)
    @import("force_down_debug.zig")
else
    struct {};

pub const ResolvedTier = enum {
    x86_64_v1,
    x86_64_v2,
    x86_64_v3,
};

pub const RequestedBackend = enum {
    auto,
    x86_64_v1,
    x86_64_v2,
    x86_64_v3,
};

pub const FeatureState = enum {
    detected_present,
    detected_absent,
    policy_assumed_present,
};

pub const Xcr0State = enum {
    not_queried_osxsave_absent,
    queried_xmm_ymm_present,
    queried_xmm_ymm_absent,
};

pub const FeatureStates = struct {
    cmov: FeatureState,
    cx8: FeatureState,
    fpu: FeatureState,
    fxsr: FeatureState,
    mmx: FeatureState,
    osfxsr: FeatureState,
    sce: FeatureState,
    sse: FeatureState,
    sse2: FeatureState,

    cmpxchg16b: FeatureState,
    lahf_sahf: FeatureState,
    popcnt: FeatureState,
    sse3: FeatureState,
    sse4_1: FeatureState,
    sse4_2: FeatureState,
    ssse3: FeatureState,

    avx: FeatureState,
    avx2: FeatureState,
    bmi1: FeatureState,
    bmi2: FeatureState,
    f16c: FeatureState,
    fma: FeatureState,
    lzcnt: FeatureState,
    movbe: FeatureState,
    osxsave: FeatureState,
};

pub const ActualCapabilities = struct {
    features: FeatureStates,
    xcr0_state: Xcr0State,
    xcr0_raw: u64,
    v1_satisfied: bool,
    v2_satisfied: bool,
    v3_satisfied: bool,
    resolved_tier: ResolvedTier,
};

pub const EffectiveFeatureFlags = struct {
    cmov: bool,
    cx8: bool,
    fpu: bool,
    fxsr: bool,
    mmx: bool,
    osfxsr: bool,
    sce: bool,
    sse: bool,
    sse2: bool,

    cmpxchg16b: bool,
    lahf_sahf: bool,
    popcnt: bool,
    sse3: bool,
    sse4_1: bool,
    sse4_2: bool,
    ssse3: bool,

    avx: bool,
    avx2: bool,
    bmi1: bool,
    bmi2: bool,
    f16c: bool,
    fma: bool,
    lzcnt: bool,
    movbe: bool,
    osxsave: bool,
};

pub const EffectiveCapabilities = struct {
    actual: *const ActualCapabilities,
    force_down_ceiling: ?ResolvedTier,
    features: EffectiveFeatureFlags,
    xcr0_xmm_ymm_enabled: bool,
    v1_satisfied: bool,
    v2_satisfied: bool,
    v3_satisfied: bool,
    resolved_tier: ResolvedTier,
    ceiling_at_or_above_actual: bool,
};

pub const InstanceInitError = error{InvalidForceDownValue};

const CpuidLeaf = struct {
    eax: u32,
    ebx: u32,
    ecx: u32,
    edx: u32,
};

const OnceState = enum(u8) {
    idle = 0,
    running = 1,
    complete = 2,
};

var actual_once_state: u8 = @intFromEnum(OnceState.idle);
var actual_storage: ActualCapabilities = undefined;

comptime {
    if (builtin.cpu.arch != .x86_64 or builtin.os.tag != .windows) {
        @compileError(
            "cpu_capability_detection requires Windows x86-64",
        );
    }
    verifyNamedModelMembership();
}

const standalone_mode_root = if (builtin.output_mode == .Obj) struct {
    // Object-mode compilation needs one permanent semantic root so the full
    // detector is emitted for linkage or instruction inspection. Object-mode
    // export grants emission/linkage only; it is not a DLL PE export doorway.
    pub export fn deblock4_cpu_capability_detection_entry_C001() u32 {
        return @intFromEnum(detectActualOnce().resolved_tier);
    }
} else struct {};

comptime {
    if (builtin.output_mode == .Obj) {
        _ = &standalone_mode_root.deblock4_cpu_capability_detection_entry_C001;
    }
}

pub fn detectActualOnce() *const ActualCapabilities {
    while (true) {
        const state = @atomicLoad(u8, &actual_once_state, .acquire);
        switch (@as(OnceState, @enumFromInt(state))) {
            .complete => return &actual_storage,
            .idle => {
                if (@cmpxchgStrong(
                    u8,
                    &actual_once_state,
                    @intFromEnum(OnceState.idle),
                    @intFromEnum(OnceState.running),
                    .acq_rel,
                    .acquire,
                ) == null) {
                    actual_storage = detectActual();
                    @atomicStore(
                        u8,
                        &actual_once_state,
                        @intFromEnum(OnceState.complete),
                        .release,
                    );
                    return &actual_storage;
                }
            },
            .running => {
                // Detection is short; retry the acquire load until published.
            },
        }
    }
}

pub fn initInstanceCapabilities(
    instance_name: []const u8,
    requested: RequestedBackend,
) InstanceInitError!EffectiveCapabilities {
    const actual = detectActualOnce();
    var ceiling: ?ResolvedTier = null;

    if (deblock4_config.debug.enable_force_down) {
        const debug_ceiling = force_down_dbg.tools.readCeiling() catch {
            return error.InvalidForceDownValue;
        };
        if (debug_ceiling) |value| {
            ceiling = switch (value) {
                .x86_64_v1 => .x86_64_v1,
                .x86_64_v2 => .x86_64_v2,
            };
        }
    }

    const effective = applyCeiling(actual, ceiling);

    if (deblock4_config.debug.enable_force_down) {
        if (ceiling) |active_ceiling| {
            const debug_ceiling = switch (active_ceiling) {
                .x86_64_v1 => force_down_dbg.tools.Ceiling.x86_64_v1,
                .x86_64_v2 => force_down_dbg.tools.Ceiling.x86_64_v2,
                .x86_64_v3 => unreachable,
            };
            force_down_dbg.tools.announce(
                actual.resolved_tier,
                effective.resolved_tier,
                debug_ceiling,
            );
        }
    }

    print_helpers.emitInstanceSummary(
        instance_name,
        requested,
        effective.resolved_tier,
        summaryReason(actual, effective),
    );

    if (deblock4_config.debug.enable_verbose_detection) {
        diag_dbg.tools.dumpDetection(actual, effective);
    }

    return effective;
}

pub fn applyCeiling(
    actual: *const ActualCapabilities,
    ceiling: ?ResolvedTier,
) EffectiveCapabilities {
    const ceiling_tier = ceiling orelse .x86_64_v3;
    const v2_allowed = tierAtLeast(ceiling_tier, .x86_64_v2);
    const v3_allowed = tierAtLeast(ceiling_tier, .x86_64_v3);

    // Force-down is structural intersection. Every effective feature is an
    // actual-present feature AND an allowed-level bit; no path can set a bit
    // that the actual record lacks.
    const effective_features = EffectiveFeatureFlags{
        .cmov = isPresent(actual.features.cmov),
        .cx8 = isPresent(actual.features.cx8),
        .fpu = isPresent(actual.features.fpu),
        .fxsr = isPresent(actual.features.fxsr),
        .mmx = isPresent(actual.features.mmx),
        .osfxsr = isPresent(actual.features.osfxsr),
        .sce = isPresent(actual.features.sce),
        .sse = isPresent(actual.features.sse),
        .sse2 = isPresent(actual.features.sse2),

        .cmpxchg16b = v2_allowed and isPresent(actual.features.cmpxchg16b),
        .lahf_sahf = v2_allowed and isPresent(actual.features.lahf_sahf),
        .popcnt = v2_allowed and isPresent(actual.features.popcnt),
        .sse3 = v2_allowed and isPresent(actual.features.sse3),
        .sse4_1 = v2_allowed and isPresent(actual.features.sse4_1),
        .sse4_2 = v2_allowed and isPresent(actual.features.sse4_2),
        .ssse3 = v2_allowed and isPresent(actual.features.ssse3),

        .avx = v3_allowed and isPresent(actual.features.avx),
        .avx2 = v3_allowed and isPresent(actual.features.avx2),
        .bmi1 = v3_allowed and isPresent(actual.features.bmi1),
        .bmi2 = v3_allowed and isPresent(actual.features.bmi2),
        .f16c = v3_allowed and isPresent(actual.features.f16c),
        .fma = v3_allowed and isPresent(actual.features.fma),
        .lzcnt = v3_allowed and isPresent(actual.features.lzcnt),
        .movbe = v3_allowed and isPresent(actual.features.movbe),
        .osxsave = v3_allowed and isPresent(actual.features.osxsave),
    };
    const effective_xcr0 = v3_allowed and
        actual.xcr0_state == .queried_xmm_ymm_present;

    const effective_v2 = actual.v2_satisfied and v2_allowed;
    const effective_v3 = actual.v3_satisfied and v3_allowed;
    const effective_tier: ResolvedTier = if (effective_v3)
        .x86_64_v3
    else if (effective_v2)
        .x86_64_v2
    else
        .x86_64_v1;

    return .{
        .actual = actual,
        .force_down_ceiling = ceiling,
        .features = effective_features,
        .xcr0_xmm_ymm_enabled = effective_xcr0,
        .v1_satisfied = true,
        .v2_satisfied = effective_v2,
        .v3_satisfied = effective_v3,
        .resolved_tier = effective_tier,
        .ceiling_at_or_above_actual = if (ceiling) |value|
            tierAtLeast(value, actual.resolved_tier)
        else
            false,
    };
}

fn detectActual() ActualCapabilities {
    const max_basic = cpuid(0, 0).eax;
    const leaf_1 = cpuid(1, 0);
    const max_extended = cpuid(0x8000_0000, 0).eax;
    const leaf_7 = if (max_basic >= 7)
        cpuid(7, 0)
    else
        CpuidLeaf{ .eax = 0, .ebx = 0, .ecx = 0, .edx = 0 };
    const leaf_extended_1 = if (max_extended >= 0x8000_0001)
        cpuid(0x8000_0001, 0)
    else
        CpuidLeaf{ .eax = 0, .ebx = 0, .ecx = 0, .edx = 0 };

    const features = FeatureStates{
        .cmov = bitState(leaf_1.edx, 15),
        .cx8 = bitState(leaf_1.edx, 8),
        .fpu = bitState(leaf_1.edx, 0),
        .fxsr = bitState(leaf_1.edx, 24),
        .mmx = bitState(leaf_1.edx, 23),
        .osfxsr = .policy_assumed_present,
        .sce = .policy_assumed_present,
        .sse = bitState(leaf_1.edx, 25),
        .sse2 = bitState(leaf_1.edx, 26),

        .cmpxchg16b = bitState(leaf_1.ecx, 13),
        .lahf_sahf = if (max_extended >= 0x8000_0001)
            bitState(leaf_extended_1.ecx, 0)
        else
            .detected_absent,
        .popcnt = bitState(leaf_1.ecx, 23),
        .sse3 = bitState(leaf_1.ecx, 0),
        .sse4_1 = bitState(leaf_1.ecx, 19),
        .sse4_2 = bitState(leaf_1.ecx, 20),
        .ssse3 = bitState(leaf_1.ecx, 9),

        .avx = bitState(leaf_1.ecx, 28),
        .avx2 = if (max_basic >= 7)
            bitState(leaf_7.ebx, 5)
        else
            .detected_absent,
        .bmi1 = if (max_basic >= 7)
            bitState(leaf_7.ebx, 3)
        else
            .detected_absent,
        .bmi2 = if (max_basic >= 7)
            bitState(leaf_7.ebx, 8)
        else
            .detected_absent,
        .f16c = bitState(leaf_1.ecx, 29),
        .fma = bitState(leaf_1.ecx, 12),
        .lzcnt = if (max_extended >= 0x8000_0001)
            bitState(leaf_extended_1.ecx, 5)
        else
            .detected_absent,
        .movbe = bitState(leaf_1.ecx, 22),
        .osxsave = bitState(leaf_1.ecx, 27),
    };

    var xcr0_raw: u64 = 0;
    var xcr0_state: Xcr0State = .not_queried_osxsave_absent;
    if (isPresent(features.osxsave)) {
        xcr0_raw = xgetbv(0);
        xcr0_state = if ((xcr0_raw & 0x6) == 0x6)
            .queried_xmm_ymm_present
        else
            .queried_xmm_ymm_absent;
    }

    // The Windows x64 process policy makes v1 the unconditional floor.
    const v1_satisfied = true;
    const v2_satisfied = v1_satisfied and
        isPresent(features.cmpxchg16b) and
        isPresent(features.lahf_sahf) and
        isPresent(features.popcnt) and
        isPresent(features.sse3) and
        isPresent(features.sse4_1) and
        isPresent(features.sse4_2) and
        isPresent(features.ssse3);
    const v3_satisfied = v2_satisfied and
        isPresent(features.avx) and
        isPresent(features.avx2) and
        isPresent(features.bmi1) and
        isPresent(features.bmi2) and
        isPresent(features.f16c) and
        isPresent(features.fma) and
        isPresent(features.lzcnt) and
        isPresent(features.movbe) and
        isPresent(features.osxsave) and
        xcr0_state == .queried_xmm_ymm_present;

    return .{
        .features = features,
        .xcr0_state = xcr0_state,
        .xcr0_raw = xcr0_raw,
        .v1_satisfied = v1_satisfied,
        .v2_satisfied = v2_satisfied,
        .v3_satisfied = v3_satisfied,
        .resolved_tier = if (v3_satisfied)
            .x86_64_v3
        else if (v2_satisfied)
            .x86_64_v2
        else
            .x86_64_v1,
    };
}

fn summaryReason(
    actual: *const ActualCapabilities,
    effective: EffectiveCapabilities,
) print_helpers.SummaryReason {
    if (effective.force_down_ceiling) |ceiling| {
        return .{ .forced_down = .{
            .ceiling_name = print_helpers.tierName(ceiling),
            .actual_name = print_helpers.tierName(actual.resolved_tier),
        } };
    }

    var missing_storage =
        [_][]const u8{""} ** print_helpers.max_missing_requirements;
    var missing_count: usize = 0;
    const level_name: []const u8 = switch (actual.resolved_tier) {
        .x86_64_v3 => return .none,
        .x86_64_v2 => v3_missing: {
            appendMissing(&missing_storage, &missing_count, "AVX", actual.features.avx);
            appendMissing(&missing_storage, &missing_count, "AVX2", actual.features.avx2);
            appendMissing(&missing_storage, &missing_count, "BMI1", actual.features.bmi1);
            appendMissing(&missing_storage, &missing_count, "BMI2", actual.features.bmi2);
            appendMissing(&missing_storage, &missing_count, "F16C", actual.features.f16c);
            appendMissing(&missing_storage, &missing_count, "FMA", actual.features.fma);
            appendMissing(&missing_storage, &missing_count, "LZCNT", actual.features.lzcnt);
            appendMissing(&missing_storage, &missing_count, "MOVBE", actual.features.movbe);
            appendMissing(&missing_storage, &missing_count, "OSXSAVE", actual.features.osxsave);
            if (actual.xcr0_state != .queried_xmm_ymm_present) {
                if (missing_count >= missing_storage.len) {
                    @panic("Deblock4 missing-requirement list exceeds fixed capacity");
                }
                missing_storage[missing_count] = "XCR0.YMM";
                missing_count += 1;
            }
            break :v3_missing "x86_64_v3";
        },
        .x86_64_v1 => v2_missing: {
            appendMissing(&missing_storage, &missing_count, "CMPXCHG16B", actual.features.cmpxchg16b);
            appendMissing(&missing_storage, &missing_count, "LAHF-SAHF", actual.features.lahf_sahf);
            appendMissing(&missing_storage, &missing_count, "POPCNT", actual.features.popcnt);
            appendMissing(&missing_storage, &missing_count, "SSE3", actual.features.sse3);
            appendMissing(&missing_storage, &missing_count, "SSE4.1", actual.features.sse4_1);
            appendMissing(&missing_storage, &missing_count, "SSE4.2", actual.features.sse4_2);
            appendMissing(&missing_storage, &missing_count, "SSSE3", actual.features.ssse3);
            break :v2_missing "x86_64_v2";
        },
    };

    // resolved_tier below the next level guarantees at least one missing
    // requirement. The fixed array is returned by value; no stack-backed slice
    // escapes this function.
    return .{ .hardware = .{
        .missing_names = missing_storage,
        .missing_count = missing_count,
        .level_name = level_name,
    } };
}

fn appendMissing(
    storage: *[print_helpers.max_missing_requirements][]const u8,
    count: *usize,
    name: []const u8,
    state: FeatureState,
) void {
    if (isPresent(state)) return;
    if (count.* >= storage.len) {
        @panic("Deblock4 missing-requirement list exceeds fixed capacity");
    }
    storage[count.*] = name;
    count.* += 1;
}

fn bitState(value: u32, bit: u5) FeatureState {
    return if ((value & (@as(u32, 1) << bit)) != 0)
        .detected_present
    else
        .detected_absent;
}

fn isPresent(state: FeatureState) bool {
    return switch (state) {
        .detected_present, .policy_assumed_present => true,
        .detected_absent => false,
    };
}

fn tierAtLeast(value: ResolvedTier, floor: ResolvedTier) bool {
    return @intFromEnum(value) >= @intFromEnum(floor);
}

// Raw explicit CPUID shape used by Zig's own x86 system detection code.
// Declaring EBX as an output lets the compiler preserve callee-saved RBX
// correctly under the Win64 ABI; no hidden standard-library wrapper is used.
noinline fn cpuid(leaf_id: u32, subid: u32) CpuidLeaf {
    var eax: u32 = undefined;
    var ebx: u32 = undefined;
    var ecx: u32 = undefined;
    var edx: u32 = undefined;

    asm volatile ("cpuid"
        : [_] "={eax}" (eax),
          [_] "={ebx}" (ebx),
          [_] "={ecx}" (ecx),
          [_] "={edx}" (edx),
        : [_] "{eax}" (leaf_id),
          [_] "{ecx}" (subid),
    );

    return .{ .eax = eax, .ebx = ebx, .ecx = ecx, .edx = edx };
}

// Called only after CPUID.01H:ECX.OSXSAVE has been confirmed present.
noinline fn xgetbv(index: u32) u64 {
    var eax: u32 = undefined;
    var edx: u32 = undefined;

    asm volatile ("xgetbv"
        : [_] "={eax}" (eax),
          [_] "={edx}" (edx),
        : [_] "{ecx}" (index),
    );

    return (@as(u64, edx) << 32) | @as(u64, eax);
}

const ModelFeatureClass = enum {
    v1_member,
    v2_member,
    v3_member,
    excluded,
};

fn classifyModelFeature(
    feature: std.Target.x86.Feature,
) ?ModelFeatureClass {
    return switch (feature) {
        // Direct names plus x87 <-> FPU.
        .cmov, .cx8, .fxsr, .mmx, .sse, .sse2, .x87 => .v1_member,

        // cx16 <-> CMPXCHG16B; sahf <-> LAHF-SAHF.
        .cx16, .popcnt, .sahf, .sse3, .sse4_1, .sse4_2, .ssse3 =>
            .v2_member,

        // bmi <-> BMI1.
        .avx, .avx2, .bmi, .bmi2, .f16c, .fma, .lzcnt, .movbe =>
            .v3_member,

        // Architecture precondition, not a psABI level-table member.
        .@"64bit" => .excluded,

        // Zig's crc32 feature is implied by SSE4.2, not a separate psABI row.
        .crc32 => .excluded,

        // Zig's xsave codegen feature is not the psABI OSXSAVE membership row.
        .xsave => .excluded,

        // Compiler tuning/code-generation properties, not ISA membership.
        .allow_light_256_bit,
        .false_deps_lzcnt_tzcnt,
        .false_deps_popcnt,
        .fast_15bytenop,
        .fast_scalar_fsqrt,
        .fast_shld_rotate,
        .fast_variable_crosslane_shuffle,
        .fast_variable_perlane_shuffle,
        .idivq_to_divl,
        .macrofusion,
        .nopl,
        .slow_3ops_lea,
        .slow_incdec,
        .slow_unaligned_mem_32,
        .vzeroupper,
        => .excluded,

        else => null,
    };
}

fn verifyNamedModelMembership() void {
    // G3: compare against the dependency-populated named-model sets that Zig
    // actually uses for compilation, not the models' raw explicit lists.
    var model_v1 = std.Target.x86.cpu.x86_64.features;
    var model_v2 = std.Target.x86.cpu.x86_64_v2.features;
    var model_v3 = std.Target.x86.cpu.x86_64_v3.features;
    model_v1.populateDependencies(&std.Target.x86.all_features);
    model_v2.populateDependencies(&std.Target.x86.all_features);
    model_v3.populateDependencies(&std.Target.x86.all_features);

    inline for (@typeInfo(std.Target.x86.Feature).@"enum".fields) |field| {
        const feature: std.Target.x86.Feature = @enumFromInt(field.value);
        const in_v1 = std.Target.x86.featureSetHas(model_v1, feature);
        const in_v2 = std.Target.x86.featureSetHas(model_v2, feature);
        const in_v3 = std.Target.x86.featureSetHas(model_v3, feature);
        if (!in_v1 and !in_v2 and !in_v3) continue;

        const class = classifyModelFeature(feature) orelse
            @compileError(std.fmt.comptimePrint(
                "unclassified Zig x86 model feature: {s}",
                .{@tagName(feature)},
            ));

        switch (class) {
            .v1_member => if (!(in_v1 and in_v2 and in_v3)) {
                @compileError(std.fmt.comptimePrint(
                    "x86_64_v1 membership drift for feature {s}",
                    .{@tagName(feature)},
                ));
            },
            .v2_member => if (in_v1 or !in_v2 or !in_v3) {
                @compileError(std.fmt.comptimePrint(
                    "x86_64_v2 membership drift for feature {s}",
                    .{@tagName(feature)},
                ));
            },
            .v3_member => if (in_v1 or in_v2 or !in_v3) {
                @compileError(std.fmt.comptimePrint(
                    "x86_64_v3 membership drift for feature {s}",
                    .{@tagName(feature)},
                ));
            },
            .excluded => {},
        }
    }

    verifyCapturedModelSet("x86_64", model_v1, &.{
        .@"64bit", .cmov, .cx8, .fxsr, .idivq_to_divl, .macrofusion,
        .mmx, .nopl, .slow_3ops_lea, .slow_incdec, .sse, .sse2,
        .vzeroupper, .x87,
    });
    verifyCapturedModelSet("x86_64_v2", model_v2, &.{
        .@"64bit", .cmov, .crc32, .cx16, .cx8, .false_deps_popcnt,
        .fast_15bytenop, .fast_scalar_fsqrt, .fast_shld_rotate, .fxsr,
        .idivq_to_divl, .macrofusion, .mmx, .nopl, .popcnt, .sahf,
        .slow_3ops_lea, .slow_unaligned_mem_32, .sse, .sse2, .sse3,
        .sse4_1, .sse4_2, .ssse3, .vzeroupper, .x87,
    });
    verifyCapturedModelSet("x86_64_v3", model_v3, &.{
        .@"64bit", .allow_light_256_bit, .avx, .avx2, .bmi, .bmi2,
        .cmov, .crc32, .cx16, .cx8, .f16c,
        .false_deps_lzcnt_tzcnt, .false_deps_popcnt,
        .fast_15bytenop, .fast_scalar_fsqrt, .fast_shld_rotate,
        .fast_variable_crosslane_shuffle, .fast_variable_perlane_shuffle,
        .fma, .fxsr, .idivq_to_divl, .lzcnt, .macrofusion, .mmx, .movbe,
        .nopl, .popcnt, .sahf, .slow_3ops_lea, .sse, .sse2, .sse3,
        .sse4_1, .sse4_2, .ssse3, .vzeroupper, .x87, .xsave,
    });
}

fn verifyCapturedModelSet(
    comptime model_name: []const u8,
    actual: anytype,
    comptime expected_features: []const std.Target.x86.Feature,
) void {
    const expected = std.Target.x86.featureSet(expected_features);
    inline for (@typeInfo(std.Target.x86.Feature).@"enum".fields) |field| {
        const feature: std.Target.x86.Feature = @enumFromInt(field.value);
        const actual_has = std.Target.x86.featureSetHas(actual, feature);
        const expected_has = std.Target.x86.featureSetHas(expected, feature);
        if (actual_has != expected_has) {
            @compileError(std.fmt.comptimePrint(
                "Zig 0.16 named-model capture drift: {s} feature {s}",
                .{ model_name, @tagName(feature) },
            ));
        }
    }
}

fn fabricatedActual(tier: ResolvedTier) ActualCapabilities {
    const has_v2 = tierAtLeast(tier, .x86_64_v2);
    const has_v3 = tierAtLeast(tier, .x86_64_v3);
    const present: FeatureState = .detected_present;
    const absent: FeatureState = .detected_absent;

    return .{
        .features = .{
            .cmov = present,
            .cx8 = present,
            .fpu = present,
            .fxsr = present,
            .mmx = present,
            .osfxsr = .policy_assumed_present,
            .sce = .policy_assumed_present,
            .sse = present,
            .sse2 = present,

            .cmpxchg16b = if (has_v2) present else absent,
            .lahf_sahf = if (has_v2) present else absent,
            .popcnt = if (has_v2) present else absent,
            .sse3 = if (has_v2) present else absent,
            .sse4_1 = if (has_v2) present else absent,
            .sse4_2 = if (has_v2) present else absent,
            .ssse3 = if (has_v2) present else absent,

            .avx = if (has_v3) present else absent,
            .avx2 = if (has_v3) present else absent,
            .bmi1 = if (has_v3) present else absent,
            .bmi2 = if (has_v3) present else absent,
            .f16c = if (has_v3) present else absent,
            .fma = if (has_v3) present else absent,
            .lzcnt = if (has_v3) present else absent,
            .movbe = if (has_v3) present else absent,
            .osxsave = if (has_v3) present else absent,
        },
        .xcr0_state = if (has_v3)
            .queried_xmm_ymm_present
        else
            .not_queried_osxsave_absent,
        .xcr0_raw = if (has_v3) 0x6 else 0,
        .v1_satisfied = true,
        .v2_satisfied = has_v2,
        .v3_satisfied = has_v3,
        .resolved_tier = tier,
    };
}

test "force-down ceiling intersection is exhaustive and never raises" {
    const tiers = [_]ResolvedTier{
        .x86_64_v1,
        .x86_64_v2,
        .x86_64_v3,
    };

    for (tiers) |actual_tier| {
        const actual = fabricatedActual(actual_tier);
        for (tiers) |ceiling| {
            const effective = applyCeiling(&actual, ceiling);
            const expected: ResolvedTier = if (
                @intFromEnum(actual_tier) <= @intFromEnum(ceiling)
            ) actual_tier else ceiling;

            try std.testing.expectEqual(expected, effective.resolved_tier);
            try std.testing.expect(
                @intFromEnum(effective.resolved_tier) <=
                    @intFromEnum(actual_tier),
            );
            try std.testing.expectEqual(
                @intFromEnum(ceiling) >= @intFromEnum(actual_tier),
                effective.ceiling_at_or_above_actual,
            );

            inline for (@typeInfo(EffectiveFeatureFlags).@"struct".fields) |field| {
                const effective_present = @field(effective.features, field.name);
                const actual_present = isPresent(@field(actual.features, field.name));
                try std.testing.expect(!effective_present or actual_present);
            }
            try std.testing.expect(
                !effective.xcr0_xmm_ymm_enabled or
                    actual.xcr0_state == .queried_xmm_ymm_present,
            );
        }
    }
}

test "at-or-above actual ceiling remains loud and cannot raise" {
    const actual = fabricatedActual(.x86_64_v1);
    const effective = applyCeiling(&actual, .x86_64_v2);

    try std.testing.expectEqual(
        ResolvedTier.x86_64_v1,
        effective.resolved_tier,
    );
    try std.testing.expect(effective.ceiling_at_or_above_actual);

    const reason = summaryReason(&actual, effective);
    switch (reason) {
        .forced_down => |forced| {
            try std.testing.expectEqualStrings(
                deblock4_config.tier.name_v2,
                forced.ceiling_name,
            );
            try std.testing.expectEqualStrings(
                deblock4_config.tier.name_v1,
                forced.actual_name,
            );
        },
        else => return error.ExpectedForcedDownSummaryReason,
    }
}
