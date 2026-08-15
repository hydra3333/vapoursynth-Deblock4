// First-class Deblock4 capability and pure-contract self-test.
const std = @import("std");
const detection = @import("cpu_capability_detection.zig");
const config = @import("deblock4_config.zig");
const parameters = @import("filter_call_parameters.zig");
const tier_selection = @import("backend_tier_selection.zig");
const common_instance = @import("common_instance_data_structure.zig");
const version = @import("deblock4_version.zig");

const lifecycle_dbg = if (config.debug.enable_trace_lifecycle)
    @import("lifecycle_trace_debug.zig")
else
    struct {};

pub fn main() !void {
    std.debug.print(
        "deblock4_selftest: version={s}\n",
        .{version.identity_string},
    );

    if (config.debug.enable_trace_lifecycle) {
        _ = lifecycle_dbg.tools
            .deblock4_lifecycle_trace_marker_1C71FE01();
    }

    const first = detection.detectActualOnce();
    const second = detection.detectActualOnce();
    if (first != second) return error.OncePointerMismatch;

    // The W3X development host is the required positive v3 detector case.
    try requireV3DevelopmentHost(first);

    const capabilities = try detection.initInstanceCapabilities();
    const automatic = try tier_selection.selectForInstance("selftest", .auto);
    const named = try tier_selection.selectForInstance(
        "selftest-nonauto",
        .x86_64_v1_baseline,
    );
    const detected_tier = switch (capabilities.effective.resolved_tier) {
        .x86_64_v1 => common_instance.BackendTier.x86_64_v1_baseline,
        .x86_64_v2 => common_instance.BackendTier.x86_64_v2_with_sse41,
        .x86_64_v3 => common_instance.BackendTier.x86_64_v3_with_avx2,
    };
    if (automatic.selected_tier != detected_tier or
        named.selected_tier != .x86_64_v1_baseline)
    {
        return error.RequestedBackendAlteredCapability;
    }

    try runStage1CPureContracts();

    std.debug.print(
        "deblock4_selftest: PASS actual={s} effective={s} stage_1c=PASS\n",
        .{
            @tagName(first.resolved_tier),
            @tagName(capabilities.effective.resolved_tier),
        },
    );
}

fn runStage1CPureContracts() !void {
    const auto = try tier_selection.selectForEffectiveTier(
        .auto,
        .x86_64_v3_with_avx2,
        null,
    );
    if (auto.selected_tier != .x86_64_v3_with_avx2 or
        auto.provenance != .automatic)
    {
        return error.Stage1CAutoSelectionFailed;
    }

    const explicit_ok = try tier_selection.selectForEffectiveTier(
        .x86_64_v2_with_sse41,
        .x86_64_v3_with_avx2,
        null,
    );
    if (explicit_ok.selected_tier != .x86_64_v2_with_sse41 or
        explicit_ok.provenance != .explicit)
    {
        return error.Stage1CExplicitSelectionFailed;
    }

    if (tier_selection.selectForEffectiveTier(
        .x86_64_v3_with_avx2,
        .x86_64_v2_with_sse41,
        null,
    )) |_| {
        return error.Stage1CAboveEffectiveWasAccepted;
    } else |err| {
        if (err != error.RequestedBackendUnavailable) return err;
    }

    const classic_auto = try tier_selection.selectForEffectiveTier(
        .auto,
        .x86_64_v3_with_avx2,
        config.implementation.classic_tier_ceiling,
    );
    if (classic_auto.selected_tier != .x86_64_v3_with_avx2 or
        classic_auto.provenance != .automatic)
    {
        return error.ClassicAutoDidNotSelectImplementedV3;
    }
    const classic_v2 = try tier_selection.selectForEffectiveTier(
        .x86_64_v2_with_sse41,
        .x86_64_v3_with_avx2,
        config.implementation.classic_tier_ceiling,
    );
    if (classic_v2.selected_tier != .x86_64_v2_with_sse41 or
        classic_v2.provenance != .explicit)
    {
        return error.ClassicV2WasNotImplemented;
    }
    const classic_v3 = try tier_selection.selectForEffectiveTier(
        .x86_64_v3_with_avx2,
        .x86_64_v3_with_avx2,
        config.implementation.classic_tier_ceiling,
    );
    if (classic_v3.selected_tier != .x86_64_v3_with_avx2 or
        classic_v3.provenance != .explicit)
    {
        return error.ClassicV3WasNotImplemented;
    }

    if (parameters.parseBackendValue(.{ .data = "unknown" })) |_| {
        return error.Stage1CUnknownBackendWasAccepted;
    } else |err| {
        if (err != error.UnknownBackend) return err;
    }

    const classic = try parameters.parseClassic(.{
        .strength = .{ .integer = 25 },
        .planes = .{ .integer_array = &.{ 2, 0, 1 } },
        .backend = .{ .data = "x86_64_v2_with_sse41" },
    });
    if (classic.common.strength != 25 or
        classic.common.backend != .x86_64_v2_with_sse41 or
        classic.common.planes.all or classic.common.planes.count != 3 or
        !std.mem.eql(
            u32,
            &classic.common.planes.indices,
            &[_]u32{ 0, 1, 2 },
        ))
    {
        return error.Stage1CClassicValidationFailed;
    }

    const deblock4 = try parameters.parseDeblock4(.{
        .grid_mode = .{ .data = "custom" },
        .strength = .{ .integer = 30 },
        .luma_step_x = .{ .integer = 8 },
        .luma_step_y = .{ .integer = 8 },
        .chroma_step_x = .{ .integer = 4 },
        .chroma_step_y = .{ .integer = 4 },
        .luma_midpoint_enabled = .{ .integer = 1 },
        .midpoint_threshold_scale = .{ .float = 0.5 },
    });
    if (deblock4.common.strength != 30) {
        return error.Stage1CDeblock4ValidationFailed;
    }
    switch (deblock4.grid) {
        .custom => |grid| {
            if (grid.luma_step_x != 8 or grid.luma_step_y != 8 or
                grid.chroma_step_x != 4 or grid.chroma_step_y != 4 or
                !grid.luma_midpoint_enabled or
                grid.midpoint_threshold_scale == null or
                grid.midpoint_threshold_scale.? != 0.5)
            {
                return error.Stage1CDeblock4ValidationFailed;
            }
        },
        else => return error.Stage1CDeblock4ValidationFailed,
    }

    if (parameters.parseClassic(.{
        .strength = .{ .integer = 61 },
    })) |_| {
        return error.Stage1CInvalidCallWasAccepted;
    } else |err| {
        if (err != error.StrengthOutOfRange) return err;
    }

    if (parameters.parseClassic(.{
        .planes = .{ .integer_array = &.{ 0, 0 } },
    })) |_| {
        return error.Stage1CInvalidCallWasAccepted;
    } else |err| {
        if (err != error.DuplicatePlaneIndex) return err;
    }

    if (parameters.parseClassic(.{
        .planes = .{ .integer_array = &.{} },
    })) |_| {
        return error.Stage1CInvalidCallWasAccepted;
    } else |err| {
        if (err != error.EmptyPlanes) return err;
    }

    if (parameters.parseDeblock4(.{
        .grid_mode = .{ .data = "custom" },
        .luma_step_x = .{ .integer = 0 },
        .luma_step_y = .{ .integer = 8 },
        .chroma_step_x = .{ .integer = 4 },
        .chroma_step_y = .{ .integer = 4 },
        .luma_midpoint_enabled = .{ .integer = 0 },
    })) |_| {
        return error.Stage1CInvalidCallWasAccepted;
    } else |err| {
        if (err != error.CustomStepOutOfRange) return err;
    }
}

fn requireV3DevelopmentHost(
    actual: *const detection.ActualCapabilities,
) !void {
    if (actual.resolved_tier != .x86_64_v3) {
        return error.ExpectedV3DevelopmentHost;
    }
    if (actual.xcr0_state != .queried_xmm_ymm_present) {
        return error.ExpectedXcr0XmmYmmState;
    }

    inline for (@typeInfo(detection.FeatureStates).@"struct".fields) |field| {
        const state = @field(actual.features, field.name);
        switch (state) {
            .detected_present, .policy_assumed_present => {},
            .detected_absent => return error.ExpectedAllV3FeaturesPresent,
        }
    }
}
