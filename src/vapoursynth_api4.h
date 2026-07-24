#ifndef DEBLOCK4_VAPOURSYNTH_API4_H
#define DEBLOCK4_VAPOURSYNTH_API4_H

/*
 * Deblock4 targets VapourSynth API 4.2 as supplied with R76+.
 *
 * Pin the required API explicitly. VS_USE_LATEST_API is intentionally not
 * used because updating the copied headers must not silently change the API
 * contract compiled into the plugin.
 */
#define VS_USE_API_42

#include "VapourSynth4.h"
#include "VSConstants4.h"

/*
 * VSHelper4.h is compiled as C in vapoursynth_helper_bridge.c rather than
 * translated into Zig. These functions provide the stable C-ABI boundary
 * through which Zig uses the required helpers.
 */
int deblock4_vsh_is_constant_video_format(const VSVideoInfo *vi);

int deblock4_vsh_are_valid_dimensions(
    const VSVideoFormat *format,
    int width,
    int height
);

int deblock4_vsh_bridge_self_test(void);

#endif
