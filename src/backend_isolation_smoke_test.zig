const std = @import("std");

const expected_generic_value: u32 = 0x4442_3410;
const expected_scalar_value: u32 = 0x4442_3411;

// Only safe baseline markers are declared or called here. The gated marker
// names deliberately do not appear in this executable's source.
extern fn deblock4_backend_probe_generic_marker() callconv(.c) u32;
extern fn deblock4_backend_probe_scalar_marker() callconv(.c) u32;

pub fn main() !void {
    const generic_actual = deblock4_backend_probe_generic_marker();
    const scalar_actual = deblock4_backend_probe_scalar_marker();

    if (generic_actual != expected_generic_value) {
        std.debug.print(
            "Deblock4 backend isolation: FAIL generic " ++
                "(expected 0x{x}, received 0x{x})\n",
            .{ expected_generic_value, generic_actual },
        );
        return error.UnexpectedGenericMarkerValue;
    }

    if (scalar_actual != expected_scalar_value) {
        std.debug.print(
            "Deblock4 backend isolation: FAIL scalar " ++
                "(expected 0x{x}, received 0x{x})\n",
            .{ expected_scalar_value, scalar_actual },
        );
        return error.UnexpectedScalarMarkerValue;
    }

    std.debug.print(
        "Deblock4 backend isolation: PASS " ++
            "(generic 0x{x}, scalar 0x{x}; gated markers not called)\n",
        .{ generic_actual, scalar_actual },
    );
}
