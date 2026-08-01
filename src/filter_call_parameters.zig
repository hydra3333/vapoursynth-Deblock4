// Pure Stage 1C call-parameter records and self-contained validation.
//
// Clip-dependent validation is intentionally absent here. Instance creation
// later checks constant format/dimensions, plane upper bounds, custom-step
// upper bounds, and preset/format compatibility against the source clip.
const std = @import("std");
const common_instance = @import("common_instance_data_structure.zig");

pub const BackendRequest = common_instance.BackendRequest;

// CallValue models the type information obtained from a future VSMap reader
// without importing VapourSynth. This keeps wrong-type validation unit-testable
// in the DLL/selftest twin's pure module graph.
pub const CallValue = union(enum) {
    missing,
    integer: i64,
    float: f64,
    data: []const u8,
    integer_array: []const i64,
};

pub const PlaneRequest = struct {
    all: bool = true,
    count: u8 = 0,
    indices: [3]u32 = .{ 0, 0, 0 },
};

pub const CommonParameters = struct {
    strength: u8,
    boundary_strength_offset: i8,
    side_activity_offset: i8,
    planes: PlaneRequest,
    backend: BackendRequest,
};

pub const ClassicParameters = struct {
    common: CommonParameters,
};

pub const GridMode = enum {
    mpeg2_progressive,
    mpeg2_field_separated,
    custom,
};

pub const MidpointParameters = struct {
    midpoint_threshold_scale: ?f64,
};

pub const CustomGridParameters = struct {
    luma_step_x: u32,
    luma_step_y: u32,
    chroma_step_x: u32,
    chroma_step_y: u32,
    luma_midpoint_enabled: bool,
    midpoint_threshold_scale: ?f64,
};

pub const Deblock4GridParameters = union(GridMode) {
    mpeg2_progressive: void,
    mpeg2_field_separated: MidpointParameters,
    custom: CustomGridParameters,
};

pub const Deblock4Parameters = struct {
    common: CommonParameters,
    grid: Deblock4GridParameters,
};

pub const ClassicCall = struct {
    strength: CallValue = .missing,
    boundary_strength_offset: CallValue = .missing,
    side_activity_offset: CallValue = .missing,
    planes: CallValue = .missing,
    backend: CallValue = .missing,
};

pub const Deblock4Call = struct {
    grid_mode: CallValue = .missing,
    strength: CallValue = .missing,
    boundary_strength_offset: CallValue = .missing,
    side_activity_offset: CallValue = .missing,
    planes: CallValue = .missing,
    midpoint_threshold_scale: CallValue = .missing,
    backend: CallValue = .missing,
    luma_step_x: CallValue = .missing,
    luma_step_y: CallValue = .missing,
    chroma_step_x: CallValue = .missing,
    chroma_step_y: CallValue = .missing,
    luma_midpoint_enabled: CallValue = .missing,
};

pub const ValidationError = error{
    WrongType,
    StrengthOutOfRange,
    BoundaryStrengthOffsetOutOfRange,
    SideActivityOffsetOutOfRange,
    UnknownBackend,
    EmptyPlanes,
    TooManyPlanes,
    NegativePlaneIndex,
    PlaneIndexTooLarge,
    DuplicatePlaneIndex,
    MissingGridMode,
    UnknownGridMode,
    GridModeAutoUnavailable,
    CustomParameterMissing,
    CustomParameterWithPreset,
    CustomStepOutOfRange,
    InvalidLumaMidpointEnabled,
    MidpointScaleOutOfRange,
    MidpointScaleNotApplicable,
};

pub fn parseClassic(call: ClassicCall) ValidationError!ClassicParameters {
    return .{
        .common = try parseCommon(
            call.strength,
            call.boundary_strength_offset,
            call.side_activity_offset,
            call.planes,
            call.backend,
        ),
    };
}

pub fn parseDeblock4(
    call: Deblock4Call,
) ValidationError!Deblock4Parameters {
    const common = try parseCommon(
        call.strength,
        call.boundary_strength_offset,
        call.side_activity_offset,
        call.planes,
        call.backend,
    );
    const mode = try parseGridMode(call.grid_mode);
    const midpoint_scale = try parseMidpointScale(
        call.midpoint_threshold_scale,
    );

    const has_custom_parameter = isSupplied(call.luma_step_x) or
        isSupplied(call.luma_step_y) or
        isSupplied(call.chroma_step_x) or
        isSupplied(call.chroma_step_y) or
        isSupplied(call.luma_midpoint_enabled);

    const grid: Deblock4GridParameters = switch (mode) {
        .mpeg2_progressive => blk: {
            if (has_custom_parameter) {
                return error.CustomParameterWithPreset;
            }
            if (midpoint_scale != null) {
                return error.MidpointScaleNotApplicable;
            }
            break :blk .{ .mpeg2_progressive = {} };
        },
        .mpeg2_field_separated => blk: {
            if (has_custom_parameter) {
                return error.CustomParameterWithPreset;
            }
            break :blk .{
                .mpeg2_field_separated = .{
                    .midpoint_threshold_scale = midpoint_scale,
                },
            };
        },
        .custom => blk: {
            const midpoint_enabled = try parseMidpointEnabled(
                call.luma_midpoint_enabled,
            );
            if (midpoint_scale != null and !midpoint_enabled) {
                return error.MidpointScaleNotApplicable;
            }
            break :blk .{
                .custom = .{
                    .luma_step_x = try parseCustomStep(call.luma_step_x),
                    .luma_step_y = try parseCustomStep(call.luma_step_y),
                    .chroma_step_x = try parseCustomStep(
                        call.chroma_step_x,
                    ),
                    .chroma_step_y = try parseCustomStep(
                        call.chroma_step_y,
                    ),
                    .luma_midpoint_enabled = midpoint_enabled,
                    .midpoint_threshold_scale = midpoint_scale,
                },
            };
        },
    };

    return .{
        .common = common,
        .grid = grid,
    };
}

pub fn parseBackendValue(
    value: CallValue,
) ValidationError!BackendRequest {
    const text = switch (value) {
        .missing => "auto",
        .data => |actual| actual,
        else => return error.WrongType,
    };

    if (std.mem.eql(u8, text, "auto")) return .auto;
    if (std.mem.eql(u8, text, "x86_64_v1_baseline")) {
        return .x86_64_v1_baseline;
    }
    if (std.mem.eql(u8, text, "x86_64_v2_with_sse41")) {
        return .x86_64_v2_with_sse41;
    }
    if (std.mem.eql(u8, text, "x86_64_v3_with_avx2")) {
        return .x86_64_v3_with_avx2;
    }
    return error.UnknownBackend;
}

pub fn parsePlaneRequest(
    value: CallValue,
) ValidationError!PlaneRequest {
    const supplied = switch (value) {
        .missing => return .{},
        .integer_array => |actual| actual,
        else => return error.WrongType,
    };

    if (supplied.len == 0) return error.EmptyPlanes;
    if (supplied.len > 3) return error.TooManyPlanes;

    var result = PlaneRequest{
        .all = false,
        .count = @intCast(supplied.len),
    };
    for (supplied, 0..) |plane, index| {
        if (plane < 0) return error.NegativePlaneIndex;
        if (plane > std.math.maxInt(u32)) {
            return error.PlaneIndexTooLarge;
        }
        result.indices[index] = @intCast(plane);
    }

    // Canonical ascending order makes the accepted int[] order-independent.
    var index: usize = 1;
    while (index < supplied.len) : (index += 1) {
        var cursor = index;
        while (cursor > 0 and
            result.indices[cursor] < result.indices[cursor - 1])
        {
            const temporary = result.indices[cursor - 1];
            result.indices[cursor - 1] = result.indices[cursor];
            result.indices[cursor] = temporary;
            cursor -= 1;
        }
    }

    for (1..supplied.len) |duplicate_index| {
        if (result.indices[duplicate_index - 1] ==
            result.indices[duplicate_index])
        {
            return error.DuplicatePlaneIndex;
        }
    }

    return result;
}

fn parseCommon(
    strength_value: CallValue,
    boundary_value: CallValue,
    side_value: CallValue,
    planes_value: CallValue,
    backend_value: CallValue,
) ValidationError!CommonParameters {
    const strength_integer = try readOptionalInteger(strength_value, 25);
    if (strength_integer < 0 or strength_integer > 60) {
        return error.StrengthOutOfRange;
    }
    const strength: u8 = @intCast(strength_integer);

    const boundary_integer = try readOptionalInteger(boundary_value, 0);
    if (boundary_integer < -strength_integer or
        boundary_integer > 60 - strength_integer)
    {
        return error.BoundaryStrengthOffsetOutOfRange;
    }

    const side_integer = try readOptionalInteger(side_value, 0);
    if (side_integer < -strength_integer or
        side_integer > 60 - strength_integer)
    {
        return error.SideActivityOffsetOutOfRange;
    }

    return .{
        .strength = strength,
        .boundary_strength_offset = @intCast(boundary_integer),
        .side_activity_offset = @intCast(side_integer),
        .planes = try parsePlaneRequest(planes_value),
        .backend = try parseBackendValue(backend_value),
    };
}

fn parseGridMode(value: CallValue) ValidationError!GridMode {
    const text = switch (value) {
        .missing => return error.MissingGridMode,
        .data => |actual| actual,
        else => return error.WrongType,
    };

    if (std.mem.eql(u8, text, "mpeg2_progressive")) {
        return .mpeg2_progressive;
    }
    if (std.mem.eql(u8, text, "mpeg2_field_separated")) {
        return .mpeg2_field_separated;
    }
    if (std.mem.eql(u8, text, "custom")) return .custom;
    if (std.mem.eql(u8, text, "auto")) {
        return error.GridModeAutoUnavailable;
    }
    return error.UnknownGridMode;
}

fn parseCustomStep(value: CallValue) ValidationError!u32 {
    const actual = switch (value) {
        .missing => return error.CustomParameterMissing,
        .integer => |integer| integer,
        else => return error.WrongType,
    };
    if (actual < 1 or actual > std.math.maxInt(u32)) {
        return error.CustomStepOutOfRange;
    }
    return @intCast(actual);
}

fn parseMidpointEnabled(value: CallValue) ValidationError!bool {
    const actual = switch (value) {
        .missing => return error.CustomParameterMissing,
        .integer => |integer| integer,
        else => return error.WrongType,
    };
    return switch (actual) {
        0 => false,
        1 => true,
        else => error.InvalidLumaMidpointEnabled,
    };
}

fn parseMidpointScale(value: CallValue) ValidationError!?f64 {
    const actual = switch (value) {
        .missing => return null,
        .float => |float_value| float_value,
        else => return error.WrongType,
    };
    if (!std.math.isFinite(actual) or actual < 0.0 or actual > 1.0) {
        return error.MidpointScaleOutOfRange;
    }
    return actual;
}

fn readOptionalInteger(
    value: CallValue,
    default_value: i64,
) ValidationError!i64 {
    return switch (value) {
        .missing => default_value,
        .integer => |actual| actual,
        else => error.WrongType,
    };
}

fn isSupplied(value: CallValue) bool {
    return switch (value) {
        .missing => false,
        else => true,
    };
}

test "Classic valid call applies settled defaults" {
    const parameters = try parseClassic(.{});

    try std.testing.expectEqual(@as(u8, 25), parameters.common.strength);
    try std.testing.expectEqual(
        @as(i8, 0),
        parameters.common.boundary_strength_offset,
    );
    try std.testing.expectEqual(
        @as(i8, 0),
        parameters.common.side_activity_offset,
    );
    try std.testing.expect(parameters.common.planes.all);
    try std.testing.expectEqual(
        BackendRequest.auto,
        parameters.common.backend,
    );
}

test "strength and independent offsets reject out-of-range values" {
    try std.testing.expectError(
        error.StrengthOutOfRange,
        parseClassic(.{ .strength = .{ .integer = 61 } }),
    );
    try std.testing.expectError(
        error.BoundaryStrengthOffsetOutOfRange,
        parseClassic(.{
            .strength = .{ .integer = 25 },
            .boundary_strength_offset = .{ .integer = 36 },
        }),
    );
    try std.testing.expectError(
        error.SideActivityOffsetOutOfRange,
        parseClassic(.{
            .strength = .{ .integer = 25 },
            .side_activity_offset = .{ .integer = -26 },
        }),
    );
}

test "wrong parameter types are rejected in the pure layer" {
    try std.testing.expectError(
        error.WrongType,
        parseClassic(.{ .strength = .{ .data = "25" } }),
    );
    try std.testing.expectError(
        error.WrongType,
        parseClassic(.{ .backend = .{ .integer = 0 } }),
    );
    try std.testing.expectError(
        error.WrongType,
        parseDeblock4(.{
            .grid_mode = .{ .data = "mpeg2_field_separated" },
            .midpoint_threshold_scale = .{ .integer = 1 },
        }),
    );
}

test "plane arrays reject empty and duplicate and ignore order" {
    const empty = [_]i64{};
    const duplicate = [_]i64{ 0, 0 };
    const unsorted = [_]i64{ 2, 0, 1 };

    try std.testing.expectError(
        error.EmptyPlanes,
        parseClassic(.{
            .planes = .{ .integer_array = empty[0..] },
        }),
    );
    try std.testing.expectError(
        error.DuplicatePlaneIndex,
        parseClassic(.{
            .planes = .{ .integer_array = duplicate[0..] },
        }),
    );

    const parsed = try parseClassic(.{
        .planes = .{ .integer_array = unsorted[0..] },
    });
    try std.testing.expect(!parsed.common.planes.all);
    try std.testing.expectEqual(
        @as([3]u32, .{ 0, 1, 2 }),
        parsed.common.planes.indices,
    );
}

test "Deblock4 custom steps reject values below one" {
    try std.testing.expectError(
        error.CustomStepOutOfRange,
        parseDeblock4(.{
            .grid_mode = .{ .data = "custom" },
            .luma_step_x = .{ .integer = 0 },
            .luma_step_y = .{ .integer = 4 },
            .chroma_step_x = .{ .integer = 4 },
            .chroma_step_y = .{ .integer = 4 },
            .luma_midpoint_enabled = .{ .integer = 0 },
        }),
    );
}

test "backend tokens are recognised exactly" {
    try std.testing.expectEqual(
        BackendRequest.x86_64_v1_baseline,
        try parseBackendValue(.{
            .data = "x86_64_v1_baseline",
        }),
    );
    try std.testing.expectEqual(
        BackendRequest.x86_64_v2_with_sse41,
        try parseBackendValue(.{
            .data = "x86_64_v2_with_sse41",
        }),
    );
    try std.testing.expectEqual(
        BackendRequest.x86_64_v3_with_avx2,
        try parseBackendValue(.{
            .data = "x86_64_v3_with_avx2",
        }),
    );
    try std.testing.expectError(
        error.UnknownBackend,
        parseBackendValue(.{ .data = "native" }),
    );
}

test "midpoint scale has no default and is conditional" {
    const field = try parseDeblock4(.{
        .grid_mode = .{ .data = "mpeg2_field_separated" },
    });
    try std.testing.expect(
        field.grid.mpeg2_field_separated.midpoint_threshold_scale == null,
    );

    try std.testing.expectError(
        error.MidpointScaleNotApplicable,
        parseDeblock4(.{
            .grid_mode = .{ .data = "mpeg2_progressive" },
            .midpoint_threshold_scale = .{ .float = 0.5 },
        }),
    );
}
