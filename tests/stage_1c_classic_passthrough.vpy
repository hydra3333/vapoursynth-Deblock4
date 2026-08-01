import hashlib
import os
import vapoursynth as vs

core = vs.core
PLUGIN_PATH = os.environ.get("DEBLOCK4_PLUGIN_PATH", "")
CASE = os.environ.get("DEBLOCK4_TEST_CASE", "valid_auto")
EXPECTED_TIER = os.environ.get(
    "DEBLOCK4_EXPECTED_TIER",
    "x86_64_v3_with_avx2",
)
EXPECTED_VERSION = os.environ.get("DEBLOCK4_EXPECTED_VERSION", "")

if not PLUGIN_PATH:
    raise RuntimeError("DEBLOCK4_PLUGIN_PATH is required")
if not EXPECTED_VERSION:
    raise RuntimeError("DEBLOCK4_EXPECTED_VERSION is required")

core.std.LoadPlugin(path=PLUGIN_PATH)
source = core.std.BlankClip(
    width=32,
    height=24,
    length=2,
    format=vs.YUV420P8,
    color=[16, 128, 128],
    fpsnum=25,
    fpsden=1,
)

def _data(value):
    if isinstance(value, bytes):
        return value.decode("utf-8")
    return str(value)

def _frame_hash(frame):
    digest = hashlib.sha256()
    for plane in range(frame.format.num_planes):
        digest.update(bytes(frame[plane]))
    return digest.hexdigest()

def _expect_error(thunk, expected):
    expected_parts = (expected,) if isinstance(expected, str) else expected
    try:
        thunk()
    except Exception as exc:
        actual = str(exc)
        missing = [part for part in expected_parts if part not in actual]
        if missing:
            raise RuntimeError(
                "wrong error for case %s: missing %r in %r"
                % (CASE, missing, actual)
            ) from exc
        print(
            "STAGE_1C_EXPECTED_ERROR_PASS case=%s message=%s"
            % (CASE, actual)
        )
        source.set_output()
        return
    raise RuntimeError("case %s unexpectedly succeeded" % CASE)

def _check_common(filtered, expected_filter):
    source_frame = source.get_frame(0)
    output_frame = filtered.get_frame(0)
    input_hash = _frame_hash(source_frame)
    output_hash = _frame_hash(output_frame)
    if input_hash != output_hash:
        raise RuntimeError(
            "pass-through checksum mismatch: %s != %s"
            % (input_hash, output_hash)
        )
    props = output_frame.props
    actual_filter = _data(props["Deblock4Filter"])
    actual_tier = _data(props["Deblock4Tier"])
    actual_version = _data(props["Deblock4Version"])
    if actual_filter != expected_filter:
        raise RuntimeError(
            "Deblock4Filter mismatch: %s != %s"
            % (actual_filter, expected_filter)
        )
    if actual_tier != EXPECTED_TIER:
        raise RuntimeError(
            "Deblock4Tier mismatch: %s != %s"
            % (actual_tier, EXPECTED_TIER)
        )
    if actual_version != EXPECTED_VERSION:
        raise RuntimeError(
            "Deblock4Version mismatch: %s != %s"
            % (actual_version, EXPECTED_VERSION)
        )
    return output_frame, input_hash, output_hash, actual_tier, actual_version

if CASE == "valid_auto":
    filtered = core.deblock4.Classic(clip=source, backend="auto")
    frame, in_hash, out_hash, tier, version = _check_common(
        filtered,
        "Classic",
    )
    print(
        "STAGE_1C_CLASSIC_PASS case=%s input_sha256=%s "
        "output_sha256=%s tier=%s version=%s"
        % (CASE, in_hash, out_hash, tier, version)
    )
    filtered.set_output()
elif CASE == "valid_full":
    filtered = core.deblock4.Classic(
        clip=source,
        strength=30,
        boundary_strength_offset=-5,
        side_activity_offset=4,
        planes=[2, 0, 1],
        backend="x86_64_v2_with_sse41",
    )
    frame, in_hash, out_hash, tier, version = _check_common(
        filtered,
        "Classic",
    )
    print(
        "STAGE_1C_CLASSIC_PASS case=%s input_sha256=%s "
        "output_sha256=%s tier=%s version=%s"
        % (CASE, in_hash, out_hash, tier, version)
    )
    filtered.set_output()
elif CASE == "error_strength":
    _expect_error(
        lambda: core.deblock4.Classic(clip=source, strength=61),
        "Classic: strength must be between 0 and 60",
    )
elif CASE == "error_wrong_type":
    _expect_error(
        lambda: core.deblock4.Classic(clip=source, strength=1.5),
        ("Classic", "strength", "int"),
    )
elif CASE == "error_duplicate_planes":
    _expect_error(
        lambda: core.deblock4.Classic(clip=source, planes=[0, 0]),
        "Classic: planes must not contain duplicates",
    )
elif CASE == "error_empty_planes":
    _expect_error(
        lambda: core.deblock4.Classic(clip=source, planes=[]),
        "Classic: planes must not be empty",
    )
elif CASE == "error_unknown_backend":
    _expect_error(
        lambda: core.deblock4.Classic(clip=source, backend="unknown"),
        "Classic: backend is not a recognised token",
    )
elif CASE == "error_above_effective":
    _expect_error(
        lambda: core.deblock4.Classic(
            clip=source,
            backend="x86_64_v2_with_sse41",
        ),
        "Classic: requested backend is above the EFFECTIVE CPU tier",
    )
elif CASE == "error_invalid_force_down":
    _expect_error(
        lambda: core.deblock4.Classic(clip=source, backend="auto"),
        "Classic: DEBLOCK4_FORCE_DOWN has an invalid value",
    )
elif CASE == "error_variable_format":
    alternate = core.std.BlankClip(
        width=32,
        height=24,
        length=2,
        format=vs.YUV444P8,
        color=[16, 128, 128],
    )
    variable = core.std.Splice([source, alternate], mismatch=True)
    _expect_error(
        lambda: core.deblock4.Classic(clip=variable),
        "Classic: input clip must have constant format and dimensions",
    )
else:
    raise RuntimeError("unknown Classic test case: %s" % CASE)
