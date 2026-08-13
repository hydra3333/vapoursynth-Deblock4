// Classic x86-64-v2 object entry points.
//
// This compilation unit is the sole 4C target-specific home. Its exported
// object symbols provide emission/linkage only; they are not public DLL PE
// exports. The baseline frame path reaches them through matching externs only
// after creation-time whole-level selection has proven v2 execution safe.
const std = @import("std");
const builtin = @import("builtin");
const vector_backend = @import("classic_vector_backend.zig");

fn verifyNamedV2Target() void {
    if (builtin.cpu.arch != .x86_64 or builtin.os.tag != .windows) {
        @compileError("Classic v2 backend requires Windows x86-64");
    }

    var expected = std.Target.x86.cpu.x86_64_v2.features;
    expected.populateDependencies(&std.Target.x86.all_features);
    inline for (@typeInfo(std.Target.x86.Feature).@"enum".fields) |field| {
        const feature: std.Target.x86.Feature = @enumFromInt(field.value);
        const actual_has = std.Target.x86.featureSetHas(builtin.cpu.features, feature);
        const expected_has = std.Target.x86.featureSetHas(expected, feature);
        if (actual_has != expected_has) {
            @compileError(std.fmt.comptimePrint(
                "Classic v2 named-model feature drift: {s}",
                .{@tagName(feature)},
            ));
        }
    }
}

comptime {
    verifyNamedV2Target();
}

fn processU8(
    base: [*]u8,
    width: usize,
    height: usize,
    stride_bytes: usize,
    alpha: i32,
    beta: i32,
    c0: i32,
    c1: i32,
    peak: i32,
) void {
    vector_backend.processPlane(u8, 16, .{
        .base = base,
        .width = width,
        .height = height,
        .stride_bytes = stride_bytes,
    }, .{ .alpha = alpha, .beta = beta, .c0 = c0, .c1 = c1, .peak = peak });
}

fn processU16(
    base: [*]u8,
    width: usize,
    height: usize,
    stride_bytes: usize,
    alpha: i32,
    beta: i32,
    c0: i32,
    c1: i32,
    peak: i32,
) void {
    vector_backend.processPlane(u16, 8, .{
        .base = base,
        .width = width,
        .height = height,
        .stride_bytes = stride_bytes,
    }, .{ .alpha = alpha, .beta = beta, .c0 = c0, .c1 = c1, .peak = peak });
}

const object_exports = if (builtin.output_mode == .Obj) struct {
    pub export fn deblock4_classic_v2_process_u8(
        base: [*]u8,
        width: usize,
        height: usize,
        stride_bytes: usize,
        alpha: i32,
        beta: i32,
        c0: i32,
        c1: i32,
        peak: i32,
    ) callconv(.c) void {
        processU8(base, width, height, stride_bytes, alpha, beta, c0, c1, peak);
    }

    pub export fn deblock4_classic_v2_process_u16(
        base: [*]u8,
        width: usize,
        height: usize,
        stride_bytes: usize,
        alpha: i32,
        beta: i32,
        c0: i32,
        c1: i32,
        peak: i32,
    ) callconv(.c) void {
        processU16(base, width, height, stride_bytes, alpha, beta, c0, c1, peak);
    }
} else struct {};

comptime {
    if (builtin.output_mode == .Obj) {
        _ = &object_exports.deblock4_classic_v2_process_u8;
        _ = &object_exports.deblock4_classic_v2_process_u16;
    }
}
