// Deblock4 shared always-on stderr presentation helpers.
//
// Production modules call these helpers rather than growing local printing
// routines. Debug-only details remain in their separately gated modules.
const std = @import("std");
const deblock4_config = @import("deblock4_config.zig");

pub const max_missing_requirements: usize = 10;

pub const SummaryReason = union(enum) {
    none,
    forced_down: struct {
        ceiling_name: []const u8,
        actual_name: []const u8,
    },
    hardware: struct {
        missing_names: [max_missing_requirements][]const u8,
        missing_count: usize,
        level_name: []const u8,
    },
};

pub fn tierName(tier: anytype) []const u8 {
    return switch (tier) {
        .x86_64_v1 => deblock4_config.tier.name_v1,
        .x86_64_v2 => deblock4_config.tier.name_v2,
        .x86_64_v3 => deblock4_config.tier.name_v3,
    };
}

pub fn requestedBackendName(requested: anytype) []const u8 {
    return switch (requested) {
        .auto => "auto",
        .x86_64_v1 => deblock4_config.tier.name_v1,
        .x86_64_v2 => deblock4_config.tier.name_v2,
        .x86_64_v3 => deblock4_config.tier.name_v3,
    };
}

pub fn emitInstanceSummary(
    instance_name: []const u8,
    requested: anytype,
    effective_tier: anytype,
    reason: SummaryReason,
) void {
    const prefix = deblock4_config.diag.summary_prefix;
    const version = deblock4_config.plugin.version_string;
    const requested_name = requestedBackendName(requested);
    const effective_name = tierName(effective_tier);

    switch (reason) {
        .none => std.debug.print(
            "{s}: {s} {s} backend={s} tier={s}\n",
            .{ prefix, version, instance_name, requested_name, effective_name },
        ),
        .forced_down => |forced| std.debug.print(
            "{s}: {s} {s} backend={s} tier={s} " ++
                "reason=forced-down({s}) actual={s}\n",
            .{
                prefix,
                version,
                instance_name,
                requested_name,
                effective_name,
                forced.ceiling_name,
                forced.actual_name,
            },
        ),
        .hardware => |hardware| {
            var missing_buffer: [256]u8 = undefined;
            const missing = joinNames(
                hardware.missing_names[0..hardware.missing_count],
                &missing_buffer,
            );
            std.debug.print(
                "{s}: {s} {s} backend={s} tier={s} " ++
                    "reason={s} absent, not {s}\n",
                .{
                    prefix,
                    version,
                    instance_name,
                    requested_name,
                    effective_name,
                    missing,
                    hardware.level_name,
                },
            );
        },
    }
}

fn joinNames(names: []const []const u8, buffer: []u8) []const u8 {
    var used: usize = 0;

    for (names, 0..) |name, index| {
        if (index != 0) appendBytes(buffer, &used, ",");
        appendBytes(buffer, &used, name);
    }

    return buffer[0..used];
}

fn appendBytes(buffer: []u8, used: *usize, bytes: []const u8) void {
    if (bytes.len > buffer.len - used.*) {
        @panic("Deblock4 summary reason exceeds fixed presentation buffer");
    }
    @memcpy(buffer[used.* .. used.* + bytes.len], bytes);
    used.* += bytes.len;
}
