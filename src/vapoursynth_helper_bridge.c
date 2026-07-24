#include "vapoursynth_api4.h"
#include "VSHelper4.h"

int deblock4_vsh_is_constant_video_format(const VSVideoInfo *vi) {
    return vsh_isConstantVideoFormat(vi);
}

int deblock4_vsh_are_valid_dimensions(
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

    if (deblock4_vsh_is_constant_video_format(&video_info))
        result |= 1;

    if (deblock4_vsh_are_valid_dimensions(&format, 16, 16))
        result |= 2;

    if (!deblock4_vsh_are_valid_dimensions(&format, 15, 16))
        result |= 4;

    return result;
}
