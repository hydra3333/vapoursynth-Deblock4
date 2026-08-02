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

def _check_deblock4(
    filtered,
    expected_grid,
    expected_steps,
    expected_midpoint,
):
    frame, in_hash, out_hash, tier, version = _check_common(
        filtered,
        "Deblock4",
    )
    props = frame.props
    actual_grid = _data(props["Deblock4GridMode"])
    actual_steps = (
        int(props["Deblock4LumaStepX"]),
        int(props["Deblock4LumaStepY"]),
        int(props["Deblock4ChromaStepX"]),
        int(props["Deblock4ChromaStepY"]),
    )
    if actual_grid != expected_grid:
        raise RuntimeError(
            "Deblock4GridMode mismatch: %s != %s"
            % (actual_grid, expected_grid)
        )
    if actual_steps != expected_steps:
        raise RuntimeError(
            "Deblock4 step mismatch: %r != %r"
            % (actual_steps, expected_steps)
        )
    midpoint_present = "Deblock4MidpointScale" in props
    if expected_midpoint is None:
        if midpoint_present:
            raise RuntimeError("Deblock4MidpointScale unexpectedly present")
    else:
        if not midpoint_present:
            raise RuntimeError("Deblock4MidpointScale unexpectedly absent")
        actual_midpoint = float(props["Deblock4MidpointScale"])
        if abs(actual_midpoint - expected_midpoint) > 1.0e-12:
            raise RuntimeError(
                "Deblock4MidpointScale mismatch: %r != %r"
                % (actual_midpoint, expected_midpoint)
            )
    return in_hash, out_hash, tier, version

if CASE == "valid_auto":
    filtered = core.deblock4.Deblock4(
        clip=source,
        grid_mode="mpeg2_progressive",
        backend="auto",
    )
    in_hash, out_hash, tier, version = _check_deblock4(
        filtered,
        "mpeg2_progressive",
        (8, 8, 8, 8),
        None,
    )
    print(
        "STAGE_1C_DEBLOCK4_PASS case=%s input_sha256=%s "
        "output_sha256=%s tier=%s version=%s grid=mpeg2_progressive "
        "steps=8x8/8x8 midpoint=absent"
        % (CASE, in_hash, out_hash, tier, version)
    )
    filtered.set_output()
elif CASE == "valid_full":
    filtered = core.deblock4.Deblock4(
        clip=source,
        grid_mode="custom",
        strength=30,
        boundary_strength_offset=-5,
        side_activity_offset=4,
        planes=[2, 0, 1],
        midpoint_threshold_scale=0.5,
        backend="x86_64_v2_with_sse41",
        luma_step_x=8,
        luma_step_y=6,
        chroma_step_x=4,
        chroma_step_y=3,
        luma_midpoint_enabled=1,
    )
    in_hash, out_hash, tier, version = _check_deblock4(
        filtered,
        "custom",
        (8, 6, 4, 3),
        0.5,
    )
    print(
        "STAGE_1C_DEBLOCK4_PASS case=%s input_sha256=%s "
        "output_sha256=%s tier=%s version=%s grid=custom "
        "steps=8x6/4x3 midpoint=0.5"
        % (CASE, in_hash, out_hash, tier, version)
    )
    filtered.set_output()
elif CASE == "midpoint_present":
    filtered = core.deblock4.Deblock4(
        clip=source,
        grid_mode="mpeg2_field_separated",
        midpoint_threshold_scale=0.25,
        backend="auto",
    )
    in_hash, out_hash, tier, version = _check_deblock4(
        filtered,
        "mpeg2_field_separated",
        (8, 4, 8, 4),
        0.25,
    )
    print(
        "STAGE_1C_DEBLOCK4_PASS case=%s input_sha256=%s "
        "output_sha256=%s tier=%s version=%s grid=field "
        "midpoint=0.25"
        % (CASE, in_hash, out_hash, tier, version)
    )
    filtered.set_output()
elif CASE == "midpoint_absent":
    filtered = core.deblock4.Deblock4(
        clip=source,
        grid_mode="mpeg2_progressive",
        backend="auto",
    )
    in_hash, out_hash, tier, version = _check_deblock4(
        filtered,
        "mpeg2_progressive",
        (8, 8, 8, 8),
        None,
    )
    print(
        "STAGE_1C_DEBLOCK4_PASS case=%s input_sha256=%s "
        "output_sha256=%s tier=%s version=%s midpoint=absent"
        % (CASE, in_hash, out_hash, tier, version)
    )
    filtered.set_output()
# float->int:opt is coerced by VapourSynth before the plugin;
# plugin-level wrong-type rejection is unreachable (Toolchain finding F6);
# Deblock4's own validation is proven by the range cases.
elif CASE == "error_strength":
    _expect_error(
        lambda: core.deblock4.Deblock4(
            clip=source,
            grid_mode="mpeg2_progressive",
            strength=61,
        ),
        "Deblock4: strength must be between 0 and 60",
    )
elif CASE == "error_duplicate_planes":
    _expect_error(
        lambda: core.deblock4.Deblock4(
            clip=source,
            grid_mode="mpeg2_progressive",
            planes=[0, 0],
        ),
        "Deblock4: planes must not contain duplicates",
    )
# Unlike F6 coercion, Python planes=[] is rejected before the plugin;
# Deblock4's empty-planes check remains valid low-level-API defence. It is
# unreachable via vspipe, not dead code, and is proven by Zig test
# "plane arrays reject empty and duplicate and ignore order".
elif CASE == "error_step_low":
    _expect_error(
        lambda: core.deblock4.Deblock4(
            clip=source,
            grid_mode="custom",
            luma_step_x=0,
            luma_step_y=8,
            chroma_step_x=4,
            chroma_step_y=4,
            luma_midpoint_enabled=0,
        ),
        "Deblock4: custom grid steps must be at least 1",
    )
elif CASE == "error_step_high":
    _expect_error(
        lambda: core.deblock4.Deblock4(
            clip=source,
            grid_mode="custom",
            luma_step_x=33,
            luma_step_y=8,
            chroma_step_x=4,
            chroma_step_y=4,
            luma_midpoint_enabled=0,
        ),
        "Deblock4: a custom grid step exceeds its relevant plane dimension",
    )
elif CASE == "error_unknown_backend":
    _expect_error(
        lambda: core.deblock4.Deblock4(
            clip=source,
            grid_mode="mpeg2_progressive",
            backend="unknown",
        ),
        "Deblock4: backend is not a recognised token",
    )
elif CASE == "error_above_effective":
    _expect_error(
        lambda: core.deblock4.Deblock4(
            clip=source,
            grid_mode="mpeg2_progressive",
            backend="x86_64_v2_with_sse41",
        ),
        "Deblock4: requested backend is above the EFFECTIVE CPU tier",
    )
elif CASE == "error_invalid_force_down":
    _expect_error(
        lambda: core.deblock4.Deblock4(
            clip=source,
            grid_mode="mpeg2_progressive",
            backend="auto",
        ),
        "Deblock4: DEBLOCK4_FORCE_DOWN has an invalid value",
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
        lambda: core.deblock4.Deblock4(
            clip=variable,
            grid_mode="mpeg2_progressive",
        ),
        "Deblock4: input clip must have constant format and dimensions",
    )
else:
    raise RuntimeError("unknown Deblock4 test case: %s" % CASE)
