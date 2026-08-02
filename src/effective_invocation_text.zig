// Immutable resolved-invocation text shared by stderr and frame properties.
//
// The value is built once from validated parameters at instance creation and
// then copied by value into immutable instance data. Both public surfaces use
// the same stored bytes, so they cannot drift.
const std = @import("std");
const common_instance = @import("common_instance_data_structure.zig");
const parameters_module = @import("filter_call_parameters.zig");

pub const capacity: usize = 512;

pub const Value = struct {
    bytes: [capacity]u8 = undefined,
    len: u16 = 0,

    pub fn slice(self: *const Value) []const u8 {
        return self.bytes[0..@intCast(self.len)];
    }
};

pub fn buildClassic(
    parameters: parameters_module.ClassicParameters,
    source_plane_count: u8,
) Value {
    var result = Value{};
    appendLiteral(&result, "Classic(strength=");
    appendFormat(&result, "{d}", .{parameters.common.strength});
    appendLiteral(&result, ", boundary_strength_offset=");
    appendFormat(
        &result,
        "{d}",
        .{parameters.common.boundary_strength_offset},
    );
    appendLiteral(&result, ", side_activity_offset=");
    appendFormat(
        &result,
        "{d}",
        .{parameters.common.side_activity_offset},
    );
    appendLiteral(&result, ", planes=");
    appendPlanes(&result, parameters.common.planes, source_plane_count);
    appendLiteral(&result, ", backend=");
    appendLiteral(
        &result,
        common_instance.backendRequestName(parameters.common.backend),
    );
    appendLiteral(&result, ")");
    return result;
}

pub fn buildDeblock4(
    parameters: parameters_module.Deblock4Parameters,
    source_plane_count: u8,
) Value {
    var result = Value{};
    appendLiteral(&result, "Deblock4(grid_mode=");
    appendLiteral(&result, gridModeName(parameters.grid));
    appendLiteral(&result, ", strength=");
    appendFormat(&result, "{d}", .{parameters.common.strength});
    appendLiteral(&result, ", boundary_strength_offset=");
    appendFormat(
        &result,
        "{d}",
        .{parameters.common.boundary_strength_offset},
    );
    appendLiteral(&result, ", side_activity_offset=");
    appendFormat(
        &result,
        "{d}",
        .{parameters.common.side_activity_offset},
    );
    appendLiteral(&result, ", planes=");
    appendPlanes(&result, parameters.common.planes, source_plane_count);
    appendLiteral(&result, ", midpoint_threshold_scale=");
    appendOptionalFloat(&result, midpointScale(parameters.grid));
    appendLiteral(&result, ", backend=");
    appendLiteral(
        &result,
        common_instance.backendRequestName(parameters.common.backend),
    );
    appendLiteral(&result, ", luma_step_x=");
    appendCustomInteger(&result, parameters.grid, .luma_step_x);
    appendLiteral(&result, ", luma_step_y=");
    appendCustomInteger(&result, parameters.grid, .luma_step_y);
    appendLiteral(&result, ", chroma_step_x=");
    appendCustomInteger(&result, parameters.grid, .chroma_step_x);
    appendLiteral(&result, ", chroma_step_y=");
    appendCustomInteger(&result, parameters.grid, .chroma_step_y);
    appendLiteral(&result, ", luma_midpoint_enabled=");
    switch (parameters.grid) {
        .custom => |grid| appendFormat(
            &result,
            "{d}",
            .{@intFromBool(grid.luma_midpoint_enabled)},
        ),
        else => appendLiteral(&result, "absent"),
    }
    appendLiteral(&result, ")");
    return result;
}

const CustomIntegerMember = enum {
    luma_step_x,
    luma_step_y,
    chroma_step_x,
    chroma_step_y,
};

fn appendCustomInteger(
    result: *Value,
    grid_parameters: parameters_module.Deblock4GridParameters,
    member: CustomIntegerMember,
) void {
    switch (grid_parameters) {
        .custom => |grid| {
            const value = switch (member) {
                .luma_step_x => grid.luma_step_x,
                .luma_step_y => grid.luma_step_y,
                .chroma_step_x => grid.chroma_step_x,
                .chroma_step_y => grid.chroma_step_y,
            };
            appendFormat(result, "{d}", .{value});
        },
        else => appendLiteral(result, "absent"),
    }
}

fn gridModeName(
    grid_parameters: parameters_module.Deblock4GridParameters,
) []const u8 {
    return switch (grid_parameters) {
        .mpeg2_progressive => "mpeg2_progressive",
        .mpeg2_field_separated => "mpeg2_field_separated",
        .custom => "custom",
    };
}

fn midpointScale(
    grid_parameters: parameters_module.Deblock4GridParameters,
) ?f64 {
    return switch (grid_parameters) {
        .mpeg2_progressive => null,
        .mpeg2_field_separated => |grid| grid.midpoint_threshold_scale,
        .custom => |grid| grid.midpoint_threshold_scale,
    };
}

fn appendOptionalFloat(result: *Value, value: ?f64) void {
    if (value) |actual| {
        appendFormat(result, "{d}", .{actual});
    } else {
        appendLiteral(result, "absent");
    }
}

fn appendPlanes(
    result: *Value,
    planes: parameters_module.PlaneRequest,
    source_plane_count: u8,
) void {
    appendLiteral(result, "[");
    const count: usize = if (planes.all)
        @intCast(source_plane_count)
    else
        @intCast(planes.count);
    for (0..count) |index| {
        if (index != 0) appendLiteral(result, ",");
        const plane: u32 = if (planes.all)
            @intCast(index)
        else
            planes.indices[index];
        appendFormat(result, "{d}", .{plane});
    }
    appendLiteral(result, "]");
}

fn appendLiteral(result: *Value, bytes: []const u8) void {
    const start: usize = @intCast(result.len);
    if (bytes.len > capacity - start) {
        @panic("Deblock4 using text exceeds fixed capacity");
    }
    @memcpy(result.bytes[start .. start + bytes.len], bytes);
    result.len = @intCast(start + bytes.len);
}

fn appendFormat(
    result: *Value,
    comptime format: []const u8,
    arguments: anytype,
) void {
    const start: usize = @intCast(result.len);
    const written = std.fmt.bufPrint(
        result.bytes[start..],
        format,
        arguments,
    ) catch @panic("Deblock4 using text exceeds fixed capacity");
    result.len = @intCast(start + written.len);
}

fn expectText(expected: []const u8, actual: Value) !void {
    try std.testing.expectEqualStrings(expected, actual.slice());
}

test "Classic using text matches rider literals and canonical planes" {
    const default_parameters = try parameters_module.parseClassic(.{});
    try expectText(
        "Classic(strength=25, boundary_strength_offset=0, " ++
            "side_activity_offset=0, planes=[0,1,2], backend=auto)",
        buildClassic(default_parameters, 3),
    );

    const unsorted = [_]i64{ 2, 0, 1 };
    const full_parameters = try parameters_module.parseClassic(.{
        .strength = .{ .integer = 30 },
        .boundary_strength_offset = .{ .integer = -5 },
        .side_activity_offset = .{ .integer = 4 },
        .planes = .{ .integer_array = unsorted[0..] },
        .backend = .{ .data = "x86_64_v2_with_sse41" },
    });
    try expectText(
        "Classic(strength=30, boundary_strength_offset=-5, " ++
            "side_activity_offset=4, planes=[0,1,2], " ++
            "backend=x86_64_v2_with_sse41)",
        buildClassic(full_parameters, 3),
    );

    const coerced_parameters = try parameters_module.parseClassic(.{
        .strength = .{ .integer = 1 },
    });
    try expectText(
        "Classic(strength=1, boundary_strength_offset=0, " ++
            "side_activity_offset=0, planes=[0,1,2], backend=auto)",
        buildClassic(coerced_parameters, 3),
    );
}

test "default planes expand to the source plane count" {
    const parameters = try parameters_module.parseClassic(.{});
    try expectText(
        "Classic(strength=25, boundary_strength_offset=0, " ++
            "side_activity_offset=0, planes=[0], backend=auto)",
        buildClassic(parameters, 1),
    );
}

test "Deblock4 using text matches rider literals" {
    const automatic = try parameters_module.parseDeblock4(.{
        .grid_mode = .{ .data = "mpeg2_progressive" },
    });
    try expectText(
        "Deblock4(grid_mode=mpeg2_progressive, strength=25, " ++
            "boundary_strength_offset=0, side_activity_offset=0, " ++
            "planes=[0,1,2], midpoint_threshold_scale=absent, " ++
            "backend=auto, luma_step_x=absent, luma_step_y=absent, " ++
            "chroma_step_x=absent, chroma_step_y=absent, " ++
            "luma_midpoint_enabled=absent)",
        buildDeblock4(automatic, 3),
    );

    const unsorted = [_]i64{ 2, 0, 1 };
    const full = try parameters_module.parseDeblock4(.{
        .grid_mode = .{ .data = "custom" },
        .strength = .{ .integer = 30 },
        .boundary_strength_offset = .{ .integer = -5 },
        .side_activity_offset = .{ .integer = 4 },
        .planes = .{ .integer_array = unsorted[0..] },
        .midpoint_threshold_scale = .{ .float = 0.5 },
        .backend = .{ .data = "x86_64_v2_with_sse41" },
        .luma_step_x = .{ .integer = 8 },
        .luma_step_y = .{ .integer = 6 },
        .chroma_step_x = .{ .integer = 4 },
        .chroma_step_y = .{ .integer = 3 },
        .luma_midpoint_enabled = .{ .integer = 1 },
    });
    try expectText(
        "Deblock4(grid_mode=custom, strength=30, " ++
            "boundary_strength_offset=-5, side_activity_offset=4, " ++
            "planes=[0,1,2], midpoint_threshold_scale=0.5, " ++
            "backend=x86_64_v2_with_sse41, luma_step_x=8, " ++
            "luma_step_y=6, chroma_step_x=4, chroma_step_y=3, " ++
            "luma_midpoint_enabled=1)",
        buildDeblock4(full, 3),
    );

    const field = try parameters_module.parseDeblock4(.{
        .grid_mode = .{ .data = "mpeg2_field_separated" },
        .midpoint_threshold_scale = .{ .float = 0.25 },
    });
    try expectText(
        "Deblock4(grid_mode=mpeg2_field_separated, strength=25, " ++
            "boundary_strength_offset=0, side_activity_offset=0, " ++
            "planes=[0,1,2], midpoint_threshold_scale=0.25, " ++
            "backend=auto, luma_step_x=absent, luma_step_y=absent, " ++
            "chroma_step_x=absent, chroma_step_y=absent, " ++
            "luma_midpoint_enabled=absent)",
        buildDeblock4(field, 3),
    );
}

test "maximum custom values fit the fixed capacity" {
    const maximum = parameters_module.Deblock4Parameters{
        .common = .{
            .strength = 60,
            .boundary_strength_offset = -60,
            .side_activity_offset = -60,
            .planes = .{},
            .backend = .x86_64_v3_with_avx2,
        },
        .grid = .{ .custom = .{
            .luma_step_x = std.math.maxInt(u32),
            .luma_step_y = std.math.maxInt(u32),
            .chroma_step_x = std.math.maxInt(u32),
            .chroma_step_y = std.math.maxInt(u32),
            .luma_midpoint_enabled = true,
            .midpoint_threshold_scale = 0.12345678901234568,
        } },
    };
    const value = buildDeblock4(maximum, 3);
    try std.testing.expect(value.slice().len < capacity);
}
