#include "vapoursynth_api4.h"
#include "VSHelper4.h"

/*
 * C-INT-04: project-authored Zig-facing compatibility wrapper for
 * vsh_isConstantVideoFormat. The zig_ prefix marks a compatibility wrapper;
 * it does not imply compiler-generated code.
 */
int zig_vsh_isConstantVideoFormat(const VSVideoInfo *vi) {
    return vsh_isConstantVideoFormat(vi);
}

/*
 * C-INT-04: project-authored Zig-facing compatibility wrapper for
 * vsh_areValidDimensions. The zig_ prefix marks a compatibility wrapper;
 * it does not imply compiler-generated code.
 */
int zig_vsh_areValidDimensions(
    const VSVideoFormat *format,
    int width,
    int height
) {
    return vsh_areValidDimensions(format, width, height);
}


int zig_vs_map_num_elements(const VSAPI *vsapi, const VSMap *map, const char *key) {
    return vsapi->mapNumElements(map, key);
}
int64_t zig_vs_map_get_int(const VSAPI *vsapi, const VSMap *map, const char *key, int index, int *error) {
    return vsapi->mapGetInt(map, key, index, error);
}
const int64_t *zig_vs_map_get_int_array(const VSAPI *vsapi, const VSMap *map, const char *key, int *error) {
    return vsapi->mapGetIntArray(map, key, error);
}
double zig_vs_map_get_float(const VSAPI *vsapi, const VSMap *map, const char *key, int index, int *error) {
    return vsapi->mapGetFloat(map, key, index, error);
}
const char *zig_vs_map_get_data(const VSAPI *vsapi, const VSMap *map, const char *key, int index, int *error) {
    return vsapi->mapGetData(map, key, index, error);
}
int zig_vs_map_get_data_size(const VSAPI *vsapi, const VSMap *map, const char *key, int index, int *error) {
    return vsapi->mapGetDataSize(map, key, index, error);
}
VSNode *zig_vs_map_get_node(const VSAPI *vsapi, const VSMap *map, const char *key, int index, int *error) {
    return vsapi->mapGetNode(map, key, index, error);
}
const VSVideoInfo *zig_vs_get_video_info(const VSAPI *vsapi, VSNode *node) {
    return vsapi->getVideoInfo(node);
}
void zig_vs_map_set_error(const VSAPI *vsapi, VSMap *map, const char *message) {
    vsapi->mapSetError(map, message);
}
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
) {
    const VSFilterDependency dependency = { source, rpStrictSpatial };
    vsapi->createVideoFilter(
        out, name, video_info, get_frame, free_filter, fmParallel,
        &dependency, 1, instance_data, core
    );
}
void zig_vs_free_node(const VSAPI *vsapi, VSNode *node) {
    vsapi->freeNode(node);
}
void zig_vs_request_frame_filter(const VSAPI *vsapi, int n, VSNode *node, VSFrameContext *frame_context) {
    vsapi->requestFrameFilter(n, node, frame_context);
}
const VSFrame *zig_vs_get_frame_filter(const VSAPI *vsapi, int n, VSNode *node, VSFrameContext *frame_context) {
    return vsapi->getFrameFilter(n, node, frame_context);
}


VSFrame *zig_vs_copy_frame(const VSAPI *vsapi, const VSFrame *frame, VSCore *core) {
    return vsapi->copyFrame(frame, core);
}
void zig_vs_free_frame(const VSAPI *vsapi, const VSFrame *frame) {
    vsapi->freeFrame(frame);
}
VSMap *zig_vs_get_frame_properties_rw(const VSAPI *vsapi, VSFrame *frame) {
    return vsapi->getFramePropertiesRW(frame);
}
int zig_vs_map_set_data_utf8_replace(
    const VSAPI *vsapi,
    VSMap *map,
    const char *key,
    const char *value,
    int size
) {
    return vsapi->mapSetData(map, key, value, size, dtUtf8, maReplace);
}
int zig_vs_map_set_int_replace(
    const VSAPI *vsapi,
    VSMap *map,
    const char *key,
    int64_t value
) {
    return vsapi->mapSetInt(map, key, value, maReplace);
}
int zig_vs_map_set_float_replace(
    const VSAPI *vsapi,
    VSMap *map,
    const char *key,
    double value
) {
    return vsapi->mapSetFloat(map, key, value, maReplace);
}
void zig_vs_set_filter_error(
    const VSAPI *vsapi,
    const char *message,
    VSFrameContext *frame_context
) {
    vsapi->setFilterError(message, frame_context);
}
int zig_vsp_config_plugin(
    const VSPLUGINAPI *vspapi,
    const char *identifier,
    const char *plugin_namespace,
    const char *name,
    int plugin_version,
    VSPlugin *plugin
) {
    return vspapi->configPlugin(
        identifier,
        plugin_namespace,
        name,
        plugin_version,
        VAPOURSYNTH_API_VERSION,
        0,
        plugin
    );
}
int zig_vsp_register_function(
    const VSPLUGINAPI *vspapi,
    const char *name,
    const char *arguments,
    const char *return_type,
    VSPublicFunction function,
    VSPlugin *plugin
) {
    return vspapi->registerFunction(
        name,
        arguments,
        return_type,
        function,
        0,
        plugin
    );
}

int deblock4_vsh_bridge_self_test(void) {
    VSVideoInfo video_info = { 0 };
    VSVideoFormat format = { 0 };
    int result = 0;

    video_info.width = 16;
    video_info.height = 16;
    video_info.format.colorFamily = cfGray;

    format.subSamplingW = 1;
    format.subSamplingH = 1;

    if (zig_vsh_isConstantVideoFormat(&video_info))
        result |= 1;

    if (zig_vsh_areValidDimensions(&format, 16, 16))
        result |= 2;

    if (!zig_vsh_areValidDimensions(&format, 15, 16))
        result |= 4;

    return result;
}
