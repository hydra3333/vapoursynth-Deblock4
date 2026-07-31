// First-class Deblock4 capability self-test executable.
const std = @import("std");
const detection = @import("cpu_capability_detection.zig");

pub fn main() !void {
    const first = detection.detectActualOnce();
    const second = detection.detectActualOnce();
    if (first != second) return error.OncePointerMismatch;

    // The W3X development host is the required positive v3 detector case.
    try requireV3DevelopmentHost(first);

    const automatic = try detection.initInstanceCapabilities(
        "selftest",
        .auto,
    );
    const named = try detection.initInstanceCapabilities(
        "selftest-nonauto",
        .x86_64_v1,
    );

    if (automatic.resolved_tier != named.resolved_tier) {
        return error.RequestedBackendAlteredCapability;
    }

    std.debug.print(
        "deblock4_selftest: PASS actual={s} effective={s}\n",
        .{
            @tagName(first.resolved_tier),
            @tagName(automatic.resolved_tier),
        },
    );
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
