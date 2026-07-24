const std = @import("std");

const expected_dll_probe_value: u32 = 0x4442_3401;

// Resolved from Deblock4.dll through its generated Windows import library.
extern fn deblock4_build_probe_value() callconv(.c) u32;

pub fn main() !void {
    const actual = deblock4_build_probe_value();

    if (actual != expected_dll_probe_value) {
        std.debug.print(
            "Deblock4 DLL smoke test: FAIL " ++
                "(expected 0x{x}, received 0x{x})\n",
            .{ expected_dll_probe_value, actual },
        );

        return error.UnexpectedDllProbeValue;
    }

    std.debug.print(
        "Deblock4 DLL smoke test: PASS " ++
            "(value 0x{x})\n",
        .{actual},
    );
}
