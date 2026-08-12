// Creation-time backend tier selection.
//
// This is the sole always-on creation-summary emission point. It consumes the
// immutable EFFECTIVE record, applies optional filter implementation data, and
// reports the tier auto would execute even when an explicit request is refused.
const std = @import("std");
const common_instance = @import("common_instance_data_structure.zig");
const cpu_capability_detection = @import("cpu_capability_detection.zig");
const print_helpers = @import("print_helper_functions.zig");

pub const SelectionError = error{
    InvalidForceDownValue,
    RequestedBackendUnavailable,
};

pub const CappedSelectionError = SelectionError || error{
    RequestedBackendNotImplemented,
};

pub fn selectForInstance(
    instance_name: []const u8,
    requested: common_instance.BackendRequest,
) SelectionError!common_instance.BackendSelection {
    const selection = selectForInstanceWithCeiling(
        instance_name,
        requested,
        null,
    ) catch |err| {
        return switch (err) {
            error.InvalidForceDownValue => error.InvalidForceDownValue,
            error.RequestedBackendUnavailable => error.RequestedBackendUnavailable,
            error.RequestedBackendNotImplemented => unreachable,
        };
    };
    return selection;
}

pub fn selectForInstanceWithCeiling(
    instance_name: []const u8,
    requested: common_instance.BackendRequest,
    implemented_tier_ceiling: ?common_instance.BackendTier,
) CappedSelectionError!common_instance.BackendSelection {
    const capabilities = cpu_capability_detection.initInstanceCapabilities() catch |err| {
        return mapInstanceInitError(err);
    };
    const effective_tier = fromDetectionTier(capabilities.effective.resolved_tier);
    const auto_tier = lowerTier(effective_tier, implemented_tier_ceiling);
    const summary_reason = finalSummaryReason(
        capabilities,
        effective_tier,
        implemented_tier_ceiling,
    );

    const selection = selectForEffectiveTier(
        requested,
        effective_tier,
        implemented_tier_ceiling,
    );

    print_helpers.emitInstanceSummary(
        instance_name,
        toDetectionRequest(requested),
        toDetectionTier(auto_tier),
        summary_reason,
    );

    return selection;
}

pub fn selectForEffectiveTier(
    requested: common_instance.BackendRequest,
    effective_tier: common_instance.BackendTier,
    implemented_tier_ceiling: ?common_instance.BackendTier,
) CappedSelectionError!common_instance.BackendSelection {
    const auto_tier = lowerTier(effective_tier, implemented_tier_ceiling);
    if (requested == .auto) {
        return .{
            .requested_backend = .auto,
            .selected_tier = auto_tier,
            .provenance = .automatic,
        };
    }

    const requested_tier = requestTier(requested);
    if (tierRank(requested_tier) > tierRank(effective_tier)) {
        return error.RequestedBackendUnavailable;
    }
    if (implemented_tier_ceiling) |ceiling| {
        if (tierRank(requested_tier) > tierRank(ceiling)) {
            return error.RequestedBackendNotImplemented;
        }
    }

    return .{
        .requested_backend = requested,
        .selected_tier = requested_tier,
        .provenance = .explicit,
    };
}

fn finalSummaryReason(
    capabilities: cpu_capability_detection.InstanceCapabilities,
    effective_tier: common_instance.BackendTier,
    implemented_tier_ceiling: ?common_instance.BackendTier,
) print_helpers.SummaryReason {
    if (implemented_tier_ceiling) |ceiling| {
        if (tierRank(ceiling) < tierRank(effective_tier)) {
            return .{ .intentionally_capped = .{
                .ceiling_name = common_instance.backendTierName(ceiling),
                .actual_name = print_helpers.tierName(
                    capabilities.effective.actual.resolved_tier,
                ),
            } };
        }
    }
    return capabilities.summary_reason;
}

fn lowerTier(
    effective_tier: common_instance.BackendTier,
    implemented_tier_ceiling: ?common_instance.BackendTier,
) common_instance.BackendTier {
    const ceiling = implemented_tier_ceiling orelse return effective_tier;
    return if (tierRank(ceiling) < tierRank(effective_tier))
        ceiling
    else
        effective_tier;
}

fn mapInstanceInitError(
    err: cpu_capability_detection.InstanceInitError,
) SelectionError {
    return switch (err) {
        error.InvalidForceDownValue => error.InvalidForceDownValue,
    };
}

fn toDetectionRequest(
    requested: common_instance.BackendRequest,
) cpu_capability_detection.RequestedBackend {
    return switch (requested) {
        .auto => .auto,
        .x86_64_v1_baseline => .x86_64_v1,
        .x86_64_v2_with_sse41 => .x86_64_v2,
        .x86_64_v3_with_avx2 => .x86_64_v3,
    };
}

fn toDetectionTier(
    tier: common_instance.BackendTier,
) cpu_capability_detection.ResolvedTier {
    return switch (tier) {
        .x86_64_v1_baseline => .x86_64_v1,
        .x86_64_v2_with_sse41 => .x86_64_v2,
        .x86_64_v3_with_avx2 => .x86_64_v3,
    };
}

fn fromDetectionTier(
    tier: cpu_capability_detection.ResolvedTier,
) common_instance.BackendTier {
    return switch (tier) {
        .x86_64_v1 => .x86_64_v1_baseline,
        .x86_64_v2 => .x86_64_v2_with_sse41,
        .x86_64_v3 => .x86_64_v3_with_avx2,
    };
}

fn requestTier(
    requested: common_instance.BackendRequest,
) common_instance.BackendTier {
    return switch (requested) {
        .auto => unreachable,
        .x86_64_v1_baseline => .x86_64_v1_baseline,
        .x86_64_v2_with_sse41 => .x86_64_v2_with_sse41,
        .x86_64_v3_with_avx2 => .x86_64_v3_with_avx2,
    };
}

fn tierRank(tier: common_instance.BackendTier) u8 {
    return switch (tier) {
        .x86_64_v1_baseline => 1,
        .x86_64_v2_with_sse41 => 2,
        .x86_64_v3_with_avx2 => 3,
    };
}

test "auto resolves to lower of EFFECTIVE and implementation ceiling" {
    const selection = try selectForEffectiveTier(
        .auto,
        .x86_64_v3_with_avx2,
        .x86_64_v1_baseline,
    );
    try std.testing.expectEqual(
        common_instance.BackendTier.x86_64_v1_baseline,
        selection.selected_tier,
    );
    try std.testing.expectEqual(
        common_instance.BackendSelectionProvenance.automatic,
        selection.provenance,
    );
}

test "supported explicit request is honoured without a ceiling" {
    const selection = try selectForEffectiveTier(
        .x86_64_v2_with_sse41,
        .x86_64_v3_with_avx2,
        null,
    );
    try std.testing.expectEqual(
        common_instance.BackendTier.x86_64_v2_with_sse41,
        selection.selected_tier,
    );
}

test "EFFECTIVE refusal precedes implementation availability" {
    try std.testing.expectError(
        error.RequestedBackendUnavailable,
        selectForEffectiveTier(
            .x86_64_v3_with_avx2,
            .x86_64_v2_with_sse41,
            .x86_64_v1_baseline,
        ),
    );
}

test "implemented-tier ceiling refuses an otherwise EFFECTIVE request" {
    try std.testing.expectError(
        error.RequestedBackendNotImplemented,
        selectForEffectiveTier(
            .x86_64_v2_with_sse41,
            .x86_64_v3_with_avx2,
            .x86_64_v1_baseline,
        ),
    );
}

test "invalid force-down is preserved as a selection error" {
    try std.testing.expectEqual(
        SelectionError.InvalidForceDownValue,
        mapInstanceInitError(error.InvalidForceDownValue),
    );
}
