const dll_probe = @import("dll_probe");
const backend_generic = @import("backend_probe_generic");
const backend_scalar = @import("backend_probe_scalar");

const MarkerFn = *const fn () callconv(.c) u32;

// G6: object-mode export fn supplies gated emission and linker visibility,
// while these baseline @extern references create the DLL retention edges.
// The pointers are internal and are never called before the Stage 1B.3 guard.
var sse41_marker_anchor: MarkerFn = @extern(MarkerFn, .{
    .name = "deblock4_backend_probe_sse41_marker",
});

var avx2_marker_anchor: MarkerFn = @extern(MarkerFn, .{
    .name = "deblock4_backend_probe_avx2_marker",
});

comptime {
    // Discover the unchanged DLL probe and the safe backend modules. Their
    // export declarations must remain part of the DLL's PE export surface.
    _ = dll_probe.dll_probe_value;
    _ = backend_generic.marker_value;
    _ = backend_scalar.marker_value;

    // Force storage of both internal pointer variables. Taking their addresses
    // creates no call path to either gated marker.
    _ = &sse41_marker_anchor;
    _ = &avx2_marker_anchor;
}
