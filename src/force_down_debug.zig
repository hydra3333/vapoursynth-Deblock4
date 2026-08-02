// G10 debug-only force-down seam.
//
// This file must be reached only through the source-visible C-3 conditional
// import under enable_force_down. The inner gate is defence in depth and
// never licenses an unconditional import.
const std = @import("std");
const deblock4_config = @import("deblock4_config.zig");
const print_helpers = @import("print_helper_functions.zig");

pub const tools = if (deblock4_config.debug.enable_force_down) struct {
    pub const MARKER =
        "DEBLOCK4_FORCE_DOWN_DEBUG_MARKER_FD00D001";
    pub const CODE_MARKER: u32 = 0xFD00_D001;

    const ENV_NAME = [_:0]u16{
        'D', 'E', 'B', 'L', 'O', 'C', 'K', '4', '_',
        'F', 'O', 'R', 'C', 'E', '_', 'D', 'O', 'W', 'N',
    };
    const FORCE_V1 = [_]u16{ 'v', '1' };
    const FORCE_V2 = [_]u16{ 'v', '2' };
    const ERROR_SUCCESS: u32 = 0;
    const ERROR_ENVVAR_NOT_FOUND: u32 = 203;

    const Kernel32 = struct {
        extern "kernel32" fn GetEnvironmentVariableW(
            name: [*:0]const u16,
            buffer: [*]u16,
            size: u32,
        ) callconv(.winapi) u32;

        extern "kernel32" fn GetLastError() callconv(.winapi) u32;
        extern "kernel32" fn SetLastError(code: u32) callconv(.winapi) void;
    };

    pub const Ceiling = enum {
        x86_64_v1,
        x86_64_v2,
    };

    pub const ReadError = error{InvalidForceDownValue};

    pub fn deblock4_force_down_marker_FD00D001() u32 {
        std.debug.print("{s}\n", .{MARKER});
        return CODE_MARKER;
    }

    comptime {
        // G10 layer-3 positive control: retain the probe whenever this gated
        // feature exists, without introducing a runtime call.
        _ = &deblock4_force_down_marker_FD00D001;
    }

    pub fn readCeiling() ReadError!?Ceiling {
        var buffer: [8]u16 = undefined;
        Kernel32.SetLastError(ERROR_SUCCESS);
        const count = Kernel32.GetEnvironmentVariableW(
            ENV_NAME[0..].ptr,
            buffer[0..].ptr,
            @intCast(buffer.len),
        );

        if (count == 0) {
            const last_error = Kernel32.GetLastError();
            if (last_error == ERROR_ENVVAR_NOT_FOUND) return null;
            if (last_error == ERROR_SUCCESS) {
                emitInvalidValue("value is empty");
                return error.InvalidForceDownValue;
            }
            @panic("DEBLOCK4_FORCE_DOWN acquisition failed unexpectedly");
        }

        if (count >= @as(u32, @intCast(buffer.len))) {
            emitInvalidValue("value is overlong");
            return error.InvalidForceDownValue;
        }

        const count_usize: usize = @intCast(count);
        const value = buffer[0..count_usize];
        if (std.mem.eql(u16, value, FORCE_V1[0..])) {
            return .x86_64_v1;
        }
        if (std.mem.eql(u16, value, FORCE_V2[0..])) {
            return .x86_64_v2;
        }

        emitInvalidValue("expected exactly lower-case v1 or v2");
        return error.InvalidForceDownValue;
    }

    pub fn announce(
        actual_tier: anytype,
        effective_tier: anytype,
        ceiling: Ceiling,
    ) void {
        const ceiling_name = switch (ceiling) {
            .x86_64_v1 => deblock4_config.tier.name_v1,
            .x86_64_v2 => deblock4_config.tier.name_v2,
        };
        std.debug.print(
            "{s}: FORCE-DOWN ACTIVE ceiling={s} actual={s} effective={s} " ++
                "marker={s}\n",
            .{
                deblock4_config.diag.summary_prefix,
                ceiling_name,
                print_helpers.tierName(actual_tier),
                print_helpers.tierName(effective_tier),
                MARKER,
            },
        );
    }

    fn emitInvalidValue(detail: []const u8) void {
        std.debug.print(
            "{s}: invalid DEBLOCK4_FORCE_DOWN value: {s}; " ++
                "construction refused; marker={s}\n",
            .{ deblock4_config.diag.summary_prefix, detail, MARKER },
        );
    }
} else struct {};
