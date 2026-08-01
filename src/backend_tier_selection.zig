// Creation-time backend tier selection.
//
// This module consumes the immutable EFFECTIVE capability record exactly once
// per filter instance. Frame-path modules must not import it.
const std = @import("std");
const common_instance = @import("common_instance_data_structure.zig");
const cpu_capability_detection = @import("cpu_capability_detection.zig");

pub const SelectionError = error{
    InvalidForceDownValue,
    RequestedBackendUnavailable,
};

pub fn selectForInstance(
    instance_name: []const u8,
    requested: common_instance.BackendRequest,
) SelectionError!common_instance.BackendSelection {
    const effective = cpu_capability_detection.initInstanceCapabilities(
        instance_name,
        toDetectionRequest(requested),
    ) catch |err| return mapInstanceInitError(err);

    return selectForEffectiveTier(
        requested,
        fromDetectionTier(effective.resolved_tier),
    );
}

pub fn selectForEffectiveTier(
    requested: common_instance.BackendRequest,
    effective_tier: common_instance.BackendTier,
) SelectionError!common_instance.BackendSelection {
    if (requested == .auto) {
        return .{
            .requested_backend = .auto,
            .selected_tier = effective_tier,
            .provenance = .automatic,
        };
    }

    const requested_tier = requestTier(requested);
    if (tierRank(requested_tier) > tierRank(effective_tier)) {
        return error.RequestedBackendUnavailable;
    }

    return .{
        .requested_backend = requested,
        .selected_tier = requested_tier,
        .provenance = .explicit,
    };
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

test "auto selects the highest EFFECTIVE tier" {
    const selection = try selectForEffectiveTier(
        .auto,
        .x86_64_v3_with_avx2,
    );
    try std.testing.expectEqual(
        common_instance.BackendTier.x86_64_v3_with_avx2,
        selection.selected_tier,
    );
    try std.testing.expectEqual(
        common_instance.BackendSelectionProvenance.automatic,
        selection.provenance,
    );
}

test "supported explicit request is honoured" {
    const selection = try selectForEffectiveTier(
        .x86_64_v2_with_sse41,
        .x86_64_v3_with_avx2,
    );
    try std.testing.expectEqual(
        common_instance.BackendTier.x86_64_v2_with_sse41,
        selection.selected_tier,
    );
    try std.testing.expectEqual(
        common_instance.BackendSelectionProvenance.explicit,
        selection.provenance,
    );
}

test "explicit request above EFFECTIVE is refused" {
    try std.testing.expectError(
        error.RequestedBackendUnavailable,
        selectForEffectiveTier(
            .x86_64_v3_with_avx2,
            .x86_64_v2_with_sse41,
        ),
    );
}

test "invalid force-down is preserved as a selection error" {
    try std.testing.expectEqual(
        SelectionError.InvalidForceDownValue,
        mapInstanceInitError(error.InvalidForceDownValue),
    );
}
