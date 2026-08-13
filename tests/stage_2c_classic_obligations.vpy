import hashlib
import os
import struct
import vapoursynth as vs

core = vs.core
PLUGIN_PATH = os.environ.get("DEBLOCK4_PLUGIN_PATH", "")
CASE = os.environ.get("DEBLOCK4_TEST_CASE", "o4_gray8")
EXPECTED_VERSION = os.environ.get("DEBLOCK4_EXPECTED_VERSION", "0.1.0-dev+2C")
# Stage 4C amendment (W3D, 2026-08-12): the expected tier is now supplied
# per case by the invoking batch (build_4C_v1.bat passes it as case arg 3
# into DEBLOCK4_EXPECTED_TIER). The default preserves Stage 2C standalone
# behaviour byte-for-byte: build_2C_v1.bat sets no tier variable and every
# 2C case therefore still expects the scalar baseline, unchanged.
EXPECTED_TIER = os.environ.get("DEBLOCK4_EXPECTED_TIER", "x86_64_v1_baseline")

if not PLUGIN_PATH:
    raise RuntimeError("DEBLOCK4_PLUGIN_PATH is required")
core.std.LoadPlugin(path=PLUGIN_PATH)


def _data(value):
    return value.decode("utf-8") if isinstance(value, bytes) else str(value)


def _plane_shape(frame, plane):
    array = frame[plane]
    return int(array.shape[1]), int(array.shape[0])


def _sample_bytes(value, bytes_per_sample):
    return int(value).to_bytes(bytes_per_sample, "little", signed=False)


def _logical_plane_bytes(frame, plane):
    array = frame[plane]
    height, width = array.shape
    bps = frame.format.bytes_per_sample
    out = bytearray()
    for y in range(height):
        for x in range(width):
            out += _sample_bytes(array[y, x], bps)
    return bytes(out)


def _frame_plane_bytes(frame):
    return tuple(_logical_plane_bytes(frame, p) for p in range(frame.format.num_planes))


def _frame_hash(frame):
    digest = hashlib.sha256()
    for payload in _frame_plane_bytes(frame):
        digest.update(payload)
    return digest.hexdigest()


def _make_filled_clip(width, height, fmt, fill, length=2):
    base = core.std.BlankClip(
        width=width,
        height=height,
        length=length,
        format=fmt,
        fpsnum=25,
        fpsden=1,
    )

    def selector(n, f):
        del n
        out = f.copy()
        for plane in range(out.format.num_planes):
            array = out[plane]
            plane_h, plane_w = array.shape
            for y in range(plane_h):
                for x in range(plane_w):
                    array[y, x] = fill(plane, y, x, out.format.bits_per_sample)
        return out

    return core.std.ModifyFrame(clip=base, clips=base, selector=selector)


def _matrix_clip(matrix, fmt):
    height = len(matrix)
    width = len(matrix[0])
    return _make_filled_clip(
        width,
        height,
        fmt,
        lambda plane, y, x, bits: matrix[y][x],
    )


def _cb_value(y, x, bits, lo=100, hi=108):
    scale = 1 << (bits - 8)
    return (lo if (((y // 8) + (x // 8)) & 1) == 0 else hi) * scale


def _cb_clip(width, height, fmt, lo=100, hi=108):
    return _make_filled_clip(
        width,
        height,
        fmt,
        lambda plane, y, x, bits: _cb_value(y, x, bits, lo, hi),
    )


def _classic(source, strength=25, aoff=0, boff=0, planes=None, backend="x86_64_v1_baseline"):
    kwargs = dict(
        clip=source,
        strength=strength,
        boundary_strength_offset=aoff,
        side_activity_offset=boff,
        backend=backend,
    )
    if planes is not None:
        kwargs["planes"] = planes
    return core.deblock4.Classic(**kwargs)


def _using(source, strength, aoff, boff, planes, backend):
    if planes is None:
        selected = list(range(source.format.num_planes))
    else:
        selected = sorted(planes)
    plane_text = "[" + ",".join(str(v) for v in selected) + "]"
    return (
        "Classic(strength=%d, boundary_strength_offset=%d, "
        "side_activity_offset=%d, planes=%s, backend=%s)"
        % (strength, aoff, boff, plane_text, backend)
    )


def _check_props(frame, source, strength=25, aoff=0, boff=0, planes=None, backend="x86_64_v1_baseline"):
    expected = {
        "Deblock4Filter": "Classic",
        "Deblock4Tier": EXPECTED_TIER,
        "Deblock4Version": EXPECTED_VERSION,
        "Deblock4Using": _using(source, strength, aoff, boff, planes, backend),
    }
    for key, expected_value in expected.items():
        actual = _data(frame.props[key])
        if actual != expected_value:
            raise RuntimeError("%s mismatch: %r != %r" % (key, actual, expected_value))
    return expected


def _expect_matrix(frame, expected, plane=0):
    array = frame[plane]
    if tuple(array.shape) != (len(expected), len(expected[0])):
        raise RuntimeError("matrix shape mismatch: %r" % (array.shape,))
    for y, row in enumerate(expected):
        for x, value in enumerate(row):
            actual = int(array[y, x])
            if actual != value:
                raise RuntimeError("matrix mismatch x=%d y=%d: %d != %d" % (x, y, actual, value))


def _expect_error(thunk, exact_row):
    try:
        thunk()
    except Exception as exc:
        actual = str(exc)
        if exact_row not in actual:
            raise RuntimeError("wrong error: missing %r in %r" % (exact_row, actual)) from exc
        print("STAGE_2C_EXPECTED_ERROR_PASS case=%s row=%s" % (CASE, exact_row))
        core.std.BlankClip(width=8, height=8, length=1, format=vs.GRAY8).set_output()
        return
    raise RuntimeError("case %s unexpectedly succeeded" % CASE)


def _changed_count(source_frame, output_frame, plane):
    src = source_frame[plane]
    out = output_frame[plane]
    height, width = src.shape
    return sum(1 for y in range(height) for x in range(width) if int(src[y, x]) != int(out[y, x]))


def _assert_source_immutable(source, before):
    after = source.get_frame(0)
    if _frame_plane_bytes(after) != before:
        raise RuntimeError("source frame was modified")


def _run_matrix_case(source, expected, label, strength=25, aoff=0, boff=0):
    source_before = _frame_plane_bytes(source.get_frame(0))
    filtered = _classic(source, strength, aoff, boff)
    output = filtered.get_frame(0)
    _expect_matrix(output, expected)
    _check_props(output, source, strength, aoff, boff)
    _assert_source_immutable(source, source_before)
    print("STAGE_2C_OBLIGATION_PASS case=%s hash=%s" % (label, _frame_hash(output)))
    filtered.set_output()


def _run_routing_case(source, selected, label, strength=25, aoff=0, boff=0):
    source_frame = source.get_frame(0)
    source_before = _frame_plane_bytes(source_frame)
    filtered = _classic(source, strength, aoff, boff, selected)
    output = filtered.get_frame(0)
    _check_props(output, source, strength, aoff, boff, selected)
    selected_set = set(range(source.format.num_planes)) if selected is None else set(selected)
    for plane in range(source.format.num_planes):
        changes = _changed_count(source_frame, output, plane)
        if plane in selected_set:
            if changes == 0:
                raise RuntimeError("selected plane %d was vacuous" % plane)
        elif _logical_plane_bytes(source_frame, plane) != _logical_plane_bytes(output, plane):
            raise RuntimeError("unselected plane %d changed" % plane)
    _assert_source_immutable(source, source_before)
    print("STAGE_2C_ROUTING_PASS case=%s hash=%s" % (label, _frame_hash(output)))
    filtered.set_output()


def _run_chroma_o4_case():
    source = _make_filled_clip(
        16,
        16,
        vs.YUV420P8,
        lambda plane, y, x, bits: O4_INPUT[y][x] if plane == 1 else 96 + plane,
    )
    source_frame = source.get_frame(0)
    source_before = _frame_plane_bytes(source_frame)
    filtered = _classic(source, planes=[1])
    output = filtered.get_frame(0)
    _expect_matrix(output, O4_EXPECTED, plane=1)
    _check_props(output, source, planes=[1])
    for plane in (0, 2):
        if _logical_plane_bytes(source_frame, plane) != _logical_plane_bytes(output, plane):
            raise RuntimeError("O-5a unselected plane %d changed" % plane)
    _assert_source_immutable(source, source_before)
    print("STAGE_2C_CHROMA_O4_PASS hash=%s" % _frame_hash(output))
    filtered.set_output()


def _boundary_discontinuity(frame):
    array = frame[0]
    height, width = array.shape
    values = []
    for x in range(8, width, 8):
        for y in range(height):
            values.append(abs(int(array[y, x]) - int(array[y, x - 1])))
    for y in range(8, height, 8):
        for x in range(width):
            values.append(abs(int(array[y, x]) - int(array[y - 1, x])))
    return sum(values) / len(values)


def _sanity_metrics(source_frame, output_frame):
    src = source_frame[0]
    out = output_frame[0]
    height, width = src.shape
    changes = [abs(int(out[y, x]) - int(src[y, x])) for y in range(height) for x in range(width)]
    return {
        "source_boundary": _boundary_discontinuity(source_frame),
        "output_boundary": _boundary_discontinuity(output_frame),
        "max_change": max(changes),
        "mean_change": sum(changes) / len(changes),
        "minimum": min(int(out[y, x]) for y in range(height) for x in range(width)),
        "maximum": max(int(out[y, x]) for y in range(height) for x in range(width)),
    }


def _sanity_gate(source_frame, output_frame):
    metrics = _sanity_metrics(source_frame, output_frame)
    if metrics["source_boundary"] != 8.0:
        return False, metrics
    if metrics["output_boundary"] > metrics["source_boundary"] * 0.60:
        return False, metrics
    if not (0 <= metrics["minimum"] <= metrics["maximum"] <= 255):
        return False, metrics
    if metrics["max_change"] > 12:
        return False, metrics
    if metrics["mean_change"] > 3.0:
        return False, metrics
    return True, metrics


O4_INPUT = [
    [100,100,100,100,110,110,110,110],
    [100,100,100,100,110,110,110,110],
    [100,100,100,100,110,110,110,110],
    [100,100,100,100,110,110,110,110],
    [112,112,112,112,112,112,112,112],
    [112,112,112,112,112,112,112,112],
    [112,112,112,112,112,112,112,112],
    [112,112,112,112,112,112,112,112],
]
O4_EXPECTED = [
    [100,100,101,103,107,109,110,110],
    [100,100,101,103,107,109,110,110],
    [101,101,102,104,108,110,110,110],
    [103,103,104,106,109,110,111,111],
    [109,109,109,109,110,110,111,111],
    [111,111,111,111,111,111,111,111],
    [112,112,112,112,112,112,112,112],
    [112,112,112,112,112,112,112,112],
]
O5D_EXPECTED = [
    [25600,25600,25856,26368,27392,27904,28160,28160],
    [25600,25600,25856,26368,27392,27904,28160,28160],
    [25856,25856,26112,26624,27648,28096,28288,28288],
    [26368,26368,26624,27136,27872,28192,28352,28352],
    [27904,27904,27976,27988,28108,28264,28480,28480],
    [28416,28416,28416,28408,28424,28480,28544,28544],
    [28672,28672,28672,28672,28672,28672,28672,28672],
    [28672,28672,28672,28672,28672,28672,28672,28672],
]
O7_10 = [
    [100,100,101,103,107,109,110,110,110,110],
    [100,100,101,103,107,109,110,110,110,110],
    [101,101,102,104,108,110,110,110,110,110],
    [103,103,104,106,109,110,111,111,111,111],
    [109,109,109,109,110,110,111,111,111,111],
    [111,111,111,111,111,111,111,111,111,111],
] + [[112] * 10 for _ in range(4)]
O7_12_ROW = [100,100,101,103,107,109,111,113,117,119,120,120]
O7_11 = [
    [100,100,101,103,107,109,111,113,117,119,120],
    [100,100,101,103,107,109,111,113,117,119,120],
    [101,101,102,104,108,110,111,113,116,118,119],
    [103,103,104,106,109,110,111,113,115,116,117],
    [109,109,109,109,110,111,112,113,113,114,115],
    [111,111,111,111,111,111,112,112,113,113,113],
    [112,112,112,112,112,112,112,112,112,112,112],
]

if CASE == "valid_auto":
    source = _cb_clip(64,64,vs.YUV420P8)
    source_before = _frame_plane_bytes(source.get_frame(0))
    filtered = _classic(source, backend="auto")
    out = filtered.get_frame(0)
    _check_props(out, source, backend="auto")
    if any(_changed_count(source.get_frame(0), out, p) == 0 for p in range(3)):
        raise RuntimeError("valid_auto did not process every plane")
    _assert_source_immutable(source, source_before)
    print("STAGE_2C_CLASSIC_PASS case=valid_auto hash=%s" % _frame_hash(out))
    filtered.set_output()
elif CASE == "valid_full":
    source = _cb_clip(64,64,vs.YUV420P8)
    source_before = _frame_plane_bytes(source.get_frame(0))
    filtered = _classic(source, strength=30, aoff=-5, boff=4, planes=[2,0,1])
    out = filtered.get_frame(0)
    _check_props(out, source, 30, -5, 4, [2,0,1])
    if any(_changed_count(source.get_frame(0), out, p) == 0 for p in range(3)):
        raise RuntimeError("valid_full did not process every plane")
    _assert_source_immutable(source, source_before)
    print("STAGE_2C_CLASSIC_PASS case=valid_full hash=%s" % _frame_hash(out))
    filtered.set_output()
elif CASE == "valid_coercion":
    source = _cb_clip(64,64,vs.YUV420P8)
    source_before = _frame_plane_bytes(source.get_frame(0))
    filtered = core.deblock4.Classic(clip=source, strength=1.5, backend="auto")
    out = filtered.get_frame(0)
    _check_props(out, source, 1, 0, 0, None, "auto")
    _assert_source_immutable(source, source_before)
    print("STAGE_2C_CLASSIC_PASS case=valid_coercion resolved_strength=1 hash=%s" % _frame_hash(out))
    filtered.set_output()
elif CASE == "error_strength":
    source = _cb_clip(64,64,vs.GRAY8)
    _expect_error(lambda: core.deblock4.Classic(clip=source, strength=61), "Classic: strength must be between 0 and 60")
elif CASE == "error_duplicate_planes":
    source = _cb_clip(64,64,vs.YUV420P8)
    _expect_error(lambda: core.deblock4.Classic(clip=source, planes=[0,0]), "Classic: planes must not contain duplicates")
elif CASE == "error_boundary_offset":
    source = _cb_clip(64,64,vs.GRAY8)
    _expect_error(
        lambda: core.deblock4.Classic(clip=source, strength=25, boundary_strength_offset=40),
        "Classic: boundary_strength_offset is out of range for strength",
    )
elif CASE == "error_side_offset":
    source = _cb_clip(64,64,vs.GRAY8)
    _expect_error(
        lambda: core.deblock4.Classic(clip=source, strength=25, side_activity_offset=-30),
        "Classic: side_activity_offset is out of range for strength",
    )
elif CASE == "error_unknown_backend":
    source = _cb_clip(64,64,vs.GRAY8)
    _expect_error(lambda: core.deblock4.Classic(clip=source, backend="unknown"), "Classic: backend is not a recognised token")
elif CASE == "error_variable_format":
    a = core.std.BlankClip(width=64,height=64,length=1,format=vs.GRAY8)
    b = core.std.BlankClip(width=64,height=64,length=1,format=vs.GRAY10)
    variable = core.std.Splice([a,b], mismatch=True)
    _expect_error(lambda: core.deblock4.Classic(clip=variable), "Classic: input clip must have constant format and dimensions")
elif CASE == "error_invalid_force_down":
    source = _cb_clip(64,64,vs.GRAY8)
    _expect_error(lambda: _classic(source, backend="auto"), "Classic: DEBLOCK4_FORCE_DOWN has an invalid value")
elif CASE == "error_above_effective":
    source = _cb_clip(64,64,vs.GRAY8)
    _expect_error(lambda: _classic(source, backend="x86_64_v3_with_avx2"), "Classic: requested backend is above the EFFECTIVE CPU tier")
elif CASE == "o4_gray8":
    _run_matrix_case(_matrix_clip(O4_INPUT, vs.GRAY8), O4_EXPECTED, CASE)
elif CASE == "o5d_gray16":
    source = _matrix_clip([[v * 256 for v in row] for row in O4_INPUT], vs.GRAY16)
    _run_matrix_case(source, O5D_EXPECTED, CASE)
elif CASE == "o7_10x10":
    source = _make_filled_clip(10, 10, vs.GRAY8, lambda p,y,x,b: (100 if x < 4 else 110) if y < 4 else 112)
    _run_matrix_case(source, O7_10, CASE)
elif CASE == "o7_12x6":
    source = _make_filled_clip(12, 6, vs.GRAY8, lambda p,y,x,b: 100 if x < 4 else 110 if x < 8 else 120)
    _run_matrix_case(source, [O7_12_ROW[:] for _ in range(6)], CASE)
elif CASE == "o7_6x6":
    matrix = [[(y * 6 + x) * 7 % 256 for x in range(6)] for y in range(6)]
    _run_matrix_case(_matrix_clip(matrix, vs.GRAY8), matrix, CASE)
elif CASE == "o7_11x7":
    source = _make_filled_clip(11, 7, vs.GRAY8, lambda p,y,x,b: (100 if x < 4 else 110 if x < 8 else 120) if y < 4 else 112)
    _run_matrix_case(source, O7_11, CASE)
elif CASE == "strength_zero":
    source = _cb_clip(64, 64, vs.YUV420P8)
    source_before = _frame_plane_bytes(source.get_frame(0))
    filtered = _classic(source, strength=0)
    out = filtered.get_frame(0)
    _check_props(out, source, strength=0)
    if source_before != _frame_plane_bytes(out):
        raise RuntimeError("strength zero changed plane bytes")
    _assert_source_immutable(source, source_before)
    print("STAGE_2C_STRENGTH_ZERO_PASS hash=%s" % _frame_hash(out))
    filtered.set_output()
elif CASE == "o5a_yuv420_chroma_o4":
    _run_chroma_o4_case()
elif CASE == "o8_yuv420_subset":
    _run_routing_case(_cb_clip(64,64,vs.YUV420P8), [1], CASE)
elif CASE == "o8_yuv420p10_subset":
    _run_routing_case(_cb_clip(64,64,vs.YUV420P10), [1], CASE)
elif CASE == "o8_yuv444p16_subset":
    _run_routing_case(_cb_clip(64,64,vs.YUV444P16), [2], CASE)
elif CASE == "o8_yuv422_v":
    _run_routing_case(_cb_clip(64,64,vs.YUV422P8), [2], CASE)
elif CASE == "o8_yuv444_all":
    _run_routing_case(_cb_clip(64,64,vs.YUV444P8), None, CASE)
elif CASE == "o8_rgb_subset":
    _run_routing_case(_cb_clip(64,64,vs.RGB24), [1], CASE)
elif CASE == "o8_gray10":
    _run_routing_case(_cb_clip(64,64,vs.GRAY10), None, CASE)
elif CASE == "o8_gray16":
    _run_routing_case(_cb_clip(64,64,vs.GRAY16), None, CASE)
elif CASE == "sanity":
    source = _cb_clip(64,64,vs.GRAY8)
    source_before = _frame_plane_bytes(source.get_frame(0))
    filtered = _classic(source)
    src0 = source.get_frame(0)
    out0 = filtered.get_frame(0)
    out1 = filtered.get_frame(1)
    _check_props(out0, source)
    _check_props(out1, source)
    passed, metrics = _sanity_gate(src0, out0)
    if not passed:
        raise RuntimeError("sanity gate failed: %r" % metrics)
    if _frame_plane_bytes(out0) != _frame_plane_bytes(out1):
        raise RuntimeError("two identical source frames produced different plane bytes")
    for key in ("Deblock4Filter", "Deblock4Tier", "Deblock4Version", "Deblock4Using"):
        if _data(out0.props[key]) != _data(out1.props[key]):
            raise RuntimeError("audit property differs between runs: %s" % key)
    arr_src = src0[0]
    arr_out = out0[0]
    for y in list(range(2)) + list(range(62,64)):
        for x in list(range(2)) + list(range(62,64)):
            if int(arr_src[y,x]) != int(arr_out[y,x]):
                raise RuntimeError("2x2 corner changed")
    _assert_source_immutable(source, source_before)
    print("STAGE_2C_SANITY_PASS metrics=%r hash=%s" % (metrics, _frame_hash(out0)))
    filtered.set_output()
elif CASE == "sanity_negative_control":
    source = _cb_clip(64,64,vs.GRAY8)
    src = source.get_frame(0)
    corrupt_clip = _make_filled_clip(64,64,vs.GRAY8, lambda p,y,x,b: _cb_value(y,x,b) if ((x < 2 or x >= 62) and (y < 2 or y >= 62)) else 104)
    corrupt = corrupt_clip.get_frame(0)
    passed, metrics = _sanity_gate(src, corrupt)
    if passed:
        raise RuntimeError("sanity negative control was accepted: %r" % metrics)
    if metrics["mean_change"] <= 3.0:
        raise RuntimeError("negative control did not exercise G6: %r" % metrics)
    print("STAGE_2C_SANITY_NEGATIVE_CONTROL_PASS metrics=%r" % metrics)
    corrupt_clip.set_output()
elif CASE == "n01a":
    source = core.std.BlankClip(width=64,height=64,length=1,format=vs.YUV444PH)
    _expect_error(lambda: _classic(source), "Classic: float input is not supported")
elif CASE == "n01b":
    source = core.std.BlankClip(width=64,height=64,length=1,format=vs.YUV444PS)
    _expect_error(lambda: _classic(source), "Classic: float input is not supported")
elif CASE in ("n01c1", "n01c2"):
    bits = 17 if CASE == "n01c1" else 32
    fmt = core.query_video_format(vs.GRAY, vs.INTEGER, bits, 0, 0)
    source = core.std.BlankClip(width=64,height=64,length=1,format=fmt.id)
    _expect_error(lambda: _classic(source), "Classic: integer input must be between 8 and 16 bits")
elif CASE == "n02a":
    source = _cb_clip(64,64,vs.GRAY8)
    _expect_error(lambda: _classic(source, backend="x86_64_v2_with_sse41"), "Classic: requested backend is not available in this build")
elif CASE == "n02b":
    source = _cb_clip(64,64,vs.GRAY8)
    _expect_error(lambda: _classic(source, backend="x86_64_v3_with_avx2"), "Classic: requested backend is not available in this build")
elif CASE == "n03":
    source = _cb_clip(64,64,vs.GRAY8)
    _expect_error(lambda: _classic(source, backend="x86_64_v3_with_avx2"), "Classic: requested backend is above the EFFECTIVE CPU tier")
elif CASE == "n04":
    source = _cb_clip(64,64,vs.GRAY8)
    source_before = _frame_plane_bytes(source.get_frame(0))
    filtered = _classic(source, backend="auto")
    out = filtered.get_frame(0)
    _check_props(out, source, backend="auto")
    if _changed_count(source.get_frame(0), out, 0) == 0:
        raise RuntimeError("N04 was vacuous")
    _assert_source_immutable(source, source_before)
    print("STAGE_2C_N04_PASS tier=%s hash=%s" % (_data(out.props["Deblock4Tier"]), _frame_hash(out)))
    filtered.set_output()
else:
    raise RuntimeError("unknown Stage 2C obligation case: %s" % CASE)
