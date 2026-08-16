// Classic x86-64-v2 (SSE4.1-class) object entry points.
//
// MAINTAINER GUIDE - WIDTH, TAIL, MEMORY, AND DISPATCH INVARIANTS
//
// This is one of two thin target-specific Classic siblings. It does not
// contain a second Classic algorithm. Both target-specific units call the
// same frozen width-generic body in classic_vector_backend.zig; this unit
// fixes only the exact named CPU target and the compile-time storage-lane
// count.
//
// N IS A SAMPLE-LANE COUNT, NOT A BYTE COUNT:
//
//   Classic v2 / 128-bit storage batches:
//       u8  N=16 -> 16 lanes * 1 byte  = 16 bytes = 128 bits
//       u16 N=8  ->  8 lanes * 2 bytes = 16 bytes = 128 bits
//
// Do not infer physical width from N alone. For example, u8 N=16 is a
// 128-bit storage batch, while u16 N=16 is a 256-bit storage batch in the
// v3 sibling. The canonical arithmetic widens samples to i32 internally, so
// a logical vector may exceed one XMM register and lower to several machine
// instructions. Generated-code inspection, not source-vector spelling, proves
// the emitted instruction tier.
//
// Only HORIZONTAL batching scales with N. The vertical Schedule-A path is an
// algorithmically fixed four-row lane pack and deliberately stays at four
// lanes at every tier. Do not widen that vertical dependency chain.
//
// TAILS HAVE TWO DIFFERENT MEANINGS. C1 means the algorithmic six-sample edge
// footprint is incomplete; such an edge is ineligible and remains untouched.
// C2 means the footprint is valid but fewer than N horizontal samples remain;
// those samples MUST still be processed. The frozen body handles C2 by exact
// descending same-body decomposition: 16,8,4,2,1 for u8 at this tier and
// 8,4,2,1 for u16. The live terminal is the one-lane vector application
// filterHorizontalLanes(T, 1, ...) - V1 - not the defensive scalar-column
// function; that N==1 scalar branch is unreachable from ratified entry widths.
//
// NEVER replace that cleanup with a full-width read plus a partial or masked
// store. Near the right edge such a read can cross the valid row, consume
// stride slack that is NOT pixel storage, or overrun the final backing row.
// This prohibition is tier-independent. SSE2 MASKMOVDQU can conditionally
// store selected bytes, but there is no matching safe masked byte/word load, so
// it cannot legalise an over-wide right-edge read or replace exact-span
// descending decomposition. Every read and write must cover exactly the proven
// live lane span and no more.
//
// This compilation unit is also a safety boundary. It is built as its own
// exact named x86-64-v2 object. Its `export fn` roots force object emission and
// linker visibility only; they must NOT become public Deblock4.dll PE exports.
// The baseline frame path reaches these symbols through matching externs only
// after the already-proven whole-level runtime selection has established the
// complete v2 contract. A bare "CPU has SSE4.1" test is not an execution
// licence.
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
