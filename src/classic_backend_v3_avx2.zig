// Classic x86-64-v3 (AVX2-class) object entry points.
//
// MAINTAINER GUIDE - WIDTH, TAIL, MEMORY, AND DISPATCH INVARIANTS
//
// This is intentionally a thin sibling of classic_backend_v2_sse41.zig. It
// does not contain a second Classic algorithm. Both target-specific units call
// the same frozen width-generic body in classic_vector_backend.zig; this unit
// changes only the named CPU target and the compile-time storage-lane count.
//
// N IS A SAMPLE-LANE COUNT, NOT A BYTE COUNT:
//
//   Classic v2 / 128-bit storage batches:
//       u8  N=16 -> 16 lanes * 1 byte  = 16 bytes = 128 bits
//       u16 N=8  ->  8 lanes * 2 bytes = 16 bytes = 128 bits
//
//   Classic v3 / 256-bit storage batches:
//       u8  N=32 -> 32 lanes * 1 byte  = 32 bytes = 256 bits
//       u16 N=16 -> 16 lanes * 2 bytes = 32 bytes = 256 bits
//
// Therefore u8 N=16 and u16 N=16 are NOT the same physical storage width:
// the first is 128 bits and the second is 256 bits. The canonical arithmetic
// widens samples to i32 internally, so a logical @Vector(32, i32) is wider
// than one YMM register and may lower to multiple machine instructions. The
// generated-code audit, not source-vector spelling, proves the emitted tier.
//
// Only HORIZONTAL batching scales with N. The vertical Schedule-A path is an
// algorithmically fixed four-row lane pack and deliberately stays at four
// lanes. Do not widen or otherwise "AVX2-ise" that vertical dependency chain.
//
// TAILS HAVE TWO DIFFERENT MEANINGS. C1 means the algorithmic six-sample edge
// footprint is incomplete; such an edge is ineligible and remains untouched.
// C2 means the footprint is valid but fewer than N horizontal samples remain;
// those samples MUST still be processed. The frozen body handles C2 by exact
// descending same-body decomposition (32,16,8,4,2,1 for u8 here, and
// 16,8,4,2,1 for u16), terminating in the one-lane vector V1 path.
//
// NEVER replace that cleanup with a full 256-bit read plus a partial/masked
// store. Near the right edge such a read can cross the valid row, consume
// stride slack that is NOT pixel storage, or overrun the final backing row.
// AVX2 VPMASKMOV-class integer masked I/O is dword/qword-granular; it is not a
// byte/word tail mechanism for u8/u16. Every read and write must cover exactly
// the proven live lane span and no more.
//
// This compilation unit is also a safety boundary. It is built as its own
// exact named x86-64-v3 object. Its `export fn` roots force object emission and
// linker visibility only; they must NOT become public Deblock4.dll PE exports.
// The baseline frame path reaches these symbols through matching externs only
// after the already-proven whole-level runtime selection has established the
// complete v3 contract, including OSXSAVE and XGETBV/XCR0 XMM+YMM state. A
// bare "CPU has AVX2" test is not an execution licence.
const std = @import("std");
const builtin = @import("builtin");
const vector_backend = @import("classic_vector_backend.zig");

fn verifyNamedV3Target() void {
    if (builtin.cpu.arch != .x86_64 or builtin.os.tag != .windows) {
        @compileError("Classic v3 backend requires Windows x86-64");
    }

    var expected = std.Target.x86.cpu.x86_64_v3.features;
    expected.populateDependencies(&std.Target.x86.all_features);
    inline for (@typeInfo(std.Target.x86.Feature).@"enum".fields) |field| {
        const feature: std.Target.x86.Feature = @enumFromInt(field.value);
        const actual_has = std.Target.x86.featureSetHas(builtin.cpu.features, feature);
        const expected_has = std.Target.x86.featureSetHas(expected, feature);
        if (actual_has != expected_has) {
            @compileError(std.fmt.comptimePrint(
                "Classic v3 named-model feature drift: {s}",
                .{@tagName(feature)},
            ));
        }
    }
}

comptime {
    verifyNamedV3Target();
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
    vector_backend.processPlane(u8, 32, .{
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
    vector_backend.processPlane(u16, 16, .{
        .base = base,
        .width = width,
        .height = height,
        .stride_bytes = stride_bytes,
    }, .{ .alpha = alpha, .beta = beta, .c0 = c0, .c1 = c1, .peak = peak });
}

const object_exports = if (builtin.output_mode == .Obj) struct {
    pub export fn deblock4_classic_v3_process_u8(
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

    pub export fn deblock4_classic_v3_process_u16(
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
        _ = &object_exports.deblock4_classic_v3_process_u8;
        _ = &object_exports.deblock4_classic_v3_process_u16;
    }
}
