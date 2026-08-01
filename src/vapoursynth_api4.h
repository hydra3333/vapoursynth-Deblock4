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


/* Stage 1C Phase 2 creation and minimal-router VSAPI wrappers. */
int zig_vs_map_num_elements(const VSAPI *vsapi, const VSMap *map, const char *key);
int64_t zig_vs_map_get_int(const VSAPI *vsapi, const VSMap *map, const char *key, int index, int *error);
const int64_t *zig_vs_map_get_int_array(const VSAPI *vsapi, const VSMap *map, const char *key, int *error);
double zig_vs_map_get_float(const VSAPI *vsapi, const VSMap *map, const char *key, int index, int *error);
const char *zig_vs_map_get_data(const VSAPI *vsapi, const VSMap *map, const char *key, int index, int *error);
int zig_vs_map_get_data_size(const VSAPI *vsapi, const VSMap *map, const char *key, int index, int *error);
VSNode *zig_vs_map_get_node(const VSAPI *vsapi, const VSMap *map, const char *key, int index, int *error);
const VSVideoInfo *zig_vs_get_video_info(const VSAPI *vsapi, VSNode *node);
void zig_vs_map_set_error(const VSAPI *vsapi, VSMap *map, const char *message);
void zig_vs_create_video_filter_single_dependency(
    const VSAPI *vsapi,
    VSMap *out,
    const char *name,
    const VSVideoInfo *video_info,
    VSFilterGetFrame get_frame,
    VSFilterFree free_filter,
    VSNode *source,
    void *instance_data,
    VSCore *core
);
void zig_vs_free_node(const VSAPI *vsapi, VSNode *node);
void zig_vs_request_frame_filter(const VSAPI *vsapi, int n, VSNode *node, VSFrameContext *frame_context);
const VSFrame *zig_vs_get_frame_filter(const VSAPI *vsapi, int n, VSNode *node, VSFrameContext *frame_context);

/* Deblock4-specific validation of the helper bridge. */
int deblock4_vsh_bridge_self_test(void);

#endif
