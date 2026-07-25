#ifndef DEBLOCK4_VAPOURSYNTH_API4_H
#define DEBLOCK4_VAPOURSYNTH_API4_H

/*
 * Deblock4 pins VapourSynth API 4.2 via VS_USE_API_42. The vendored
 * headers are currently VapourSynth R78. The pinned API contract is
 * deliberate and independent of the vendored header release; updating the
 * headers must not silently change the compiled API contract.
 */
#define VS_USE_API_42

#include "VapourSynth4.h"
#include "VSConstants4.h"

/*
 * VSHelper4.h is compiled as C in vapoursynth_helper_bridge.c rather than
 * translated into Zig. These Zig-facing compatibility wrappers provide a
 * stable C-ABI boundary while preserving each original vsh_ helper name
 * after the zig_ prefix so its VapourSynth correspondence remains visible.
 */
int zig_vsh_isConstantVideoFormat(const VSVideoInfo *vi);

int zig_vsh_areValidDimensions(
    const VSVideoFormat *format,
    int width,
    int height
);

/* Deblock4-specific validation of the helper bridge. */
int deblock4_vsh_bridge_self_test(void);

#endif
