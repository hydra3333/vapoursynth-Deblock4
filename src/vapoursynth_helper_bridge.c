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
