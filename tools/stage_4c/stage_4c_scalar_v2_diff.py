# stage_4c_scalar_v2_diff.py - Deblock4 Stage 4C W3D differential harness
# W3D-owned (scope v1_2 sections 7/8; delivery join contract, manifest s4).
# Run under the portable VapourSynth python (tools\run_vs.cmd --python-script).
#
# EXIT CODES (contract with run_stage_4c_differential.cmd):
#   0 = ALL PASS (positive acceptance)
#   2 = DIFFERENCES DETECTED (scalar vs v2 mismatch - the tail-mutant run
#       kind EXPECTS this code)
#   3 = SELECTION/COVERAGE FAILURE (T4 assertions)
#   4 = ENVIRONMENT/CONTRACT FAILURE (env vars, load, policy, hardware)
#
# US-ASCII; CRLF.

import hashlib
import json
import os
import sys

MARK_PASS = "STAGE_4C_SCALAR_V2_DIFFERENTIAL_ALL_PASS"
MARK_DIFF = "STAGE_4C_DIFFERENTIAL_DETECTED_DIFFERENCES"
MARK_SELECT = "STAGE_4C_SELECTION_COVERAGE_FAIL"
MARK_ENV = "STAGE_4C_ENVIRONMENT_FAIL"


def env_fail(message):
    print(MARK_ENV + " " + message)
    sys.exit(4)


def require_env(name):
    value = os.environ.get(name, "")
    if not value:
        env_fail("missing environment variable " + name)
    return value


PLUGIN_PATH = require_env("DEBLOCK4_PLUGIN_PATH")
INSPECT_DIR = require_env("DEBLOCK4_STAGE4C_INSPECTION_DIR")
EXPECTED_VERSION = require_env("DEBLOCK4_STAGE4C_EXPECTED_VERSION")
EXPECTED_V1 = require_env("DEBLOCK4_STAGE4C_EXPECTED_V1")
EXPECTED_V2 = require_env("DEBLOCK4_STAGE4C_EXPECTED_V2")
RUN_KIND = os.environ.get("DEBLOCK4_STAGE4C_RUN_KIND", "positive")

if not os.path.isfile(PLUGIN_PATH):
    env_fail("plugin not found: " + PLUGIN_PATH)
os.makedirs(INSPECT_DIR, exist_ok=True)

with open(PLUGIN_PATH, "rb") as handle:
    DLL_SHA256 = hashlib.sha256(handle.read()).hexdigest()

# ---------------------------------------------------------------- policy ---
# Isolation pattern transplanted VERBATIM in structure from the PROVEN
# Stage 2C HolyWu differential (green on this R79 install): a stateful
# singleton policy whose registration creates the autoload-disabled
# environment; vs.core then resolves through it. No context manager.
import vapoursynth as vs


class _NoAutoloadPolicy:
    def __init__(self):
        self._api = None
        self._environment = None

    def on_policy_registered(self, api):
        self._api = api
        self._environment = api.create_environment(int(vs.DISABLE_AUTO_LOADING))

    def on_policy_cleared(self):
        if self._api is not None and self._environment is not None:
            self._api.destroy_environment(self._environment)
        self._environment = None
        self._api = None

    def get_current_environment(self):
        return self._environment

    def set_environment(self, environment):
        del environment
        return self._environment

    def is_alive(self, environment):
        return environment is self._environment


if vs.has_policy():
    env_fail("a VapourSynth policy is already registered (needs direct python)")
_isolation_policy = _NoAutoloadPolicy()
vs.register_policy(_isolation_policy)
core = vs.core
if (core.flags & int(vs.DISABLE_AUTO_LOADING)) == 0:
    env_fail("core was not created with autoload disabled")
if hasattr(core, "deblock4"):
    env_fail("deblock4 namespace present before manual load (autoload?)")
core.std.LoadPlugin(path=os.path.abspath(PLUGIN_PATH))
if not hasattr(core, "deblock4"):
    env_fail("manual plugin load did not expose namespace deblock4")

if True:
    # ------------------------------------------------------ generators ---
    # Idioms mirror the PROVEN Stage 2C obligations script exactly:
    # frame[plane] is an ndarray-like with .shape and [y, x] assignment;
    # logical bytes are extracted sample-wise (stride-safe), never via
    # bytes(frame[plane]).
    def lcg_value(state):
        return (state * 1664525 + 1013904223) & 0xFFFFFFFF

    def fill_value(plane, y, x, bits, kind, seed):
        peak = (1 << bits) - 1
        if kind == "flat":
            return 1 << (bits - 1)
        if kind == "blocks":
            # Gentle 8-step block pattern (the PROVEN 2C checkerboard
            # amplitude): adjacent-block difference 8 < alpha(strength 25)=13
            # activates every true block boundary with a nonzero delta, and
            # flat interiors keep |p1-p0| = 0 < beta. The previous 23-step
            # pattern exceeded alpha and rendered these cases inert
            # (run-2 VACUITY_FAIL, W3D harness defect H-3).
            band = ((x // 8) + (y // 8) * 3 + plane * 5 + seed % 3) % 2
            return (100 + band * 8) * peak // 255
        if kind == "blocks_noise":
            step = ((x // 8) * 23 + (y // 8) * 41 + plane * 11) % 144
            state = lcg_value((seed + x * 7919 + y * 104729 + plane) & 0xFFFFFFFF)
            jitter = (state >> 24) % 5
            return (24 + step + jitter) * peak // 255
        band = ((x // 8) + (y // 8) + plane) % 3
        return 0 if band == 0 else (peak if band == 1 else peak // 2)

    def make_source(width, height, fmt, frames, kind, seed):
        base = core.std.BlankClip(
            width=width, height=height, length=frames, format=fmt,
            fpsnum=25, fpsden=1,
        )

        def selector(n, f):
            out = f.copy()
            for plane in range(out.format.num_planes):
                array = out[plane]
                plane_h, plane_w = array.shape
                for y in range(plane_h):
                    for x in range(plane_w):
                        array[y, x] = fill_value(
                            plane, y, x, out.format.bits_per_sample,
                            kind, seed + n * 101,
                        )
            return out

        return core.std.ModifyFrame(clip=base, clips=base, selector=selector)

    def sample_bytes(value, bytes_per_sample):
        return int(value).to_bytes(bytes_per_sample, "little", signed=False)

    def logical_plane_bytes(frame, plane):
        array = frame[plane]
        height, width = array.shape
        bps = frame.format.bytes_per_sample
        out = bytearray()
        for y in range(height):
            for x in range(width):
                out += sample_bytes(array[y, x], bps)
        return bytes(out)

    # ----------------------------------------------------------- corpus ---
    # (name, width, height, format_name, bits, kind, frames, params, expect_changes)
    CASES = [
        ("C4C-01_gray8_711x480_r7", 711, 480, "GRAY8", 8, "blocks", 3, {}, True),
        ("C4C-02_gray8_719x479_r15_h3", 719, 479, "GRAY8", 8, "blocks_noise", 3, {}, True),
        ("C4C-03_gray8_353x289_r1_h1", 353, 289, "GRAY8", 8, "blocks", 3, {}, True),
        ("C4C-04_444p8_711x480", 711, 480, "YUV444P8", 8, "blocks_noise", 3, {}, True),
        ("C4C-05_420p8_718x478_r14_h2", 718, 478, "YUV420P8", 8, "blocks", 3, {}, True),
        ("C4C-06_420p8_354x290_r2", 354, 290, "YUV420P8", 8, "blocks_noise", 3, {}, True),
        ("C4C-07_422p8_718x479", 718, 479, "YUV422P8", 8, "blocks", 3, {}, True),
        ("C4C-08_gray16_719x479_r7u16", 719, 479, "GRAY16", 16, "blocks", 3, {}, True),
        ("C4C-09_444p16_711x480", 711, 480, "YUV444P16", 16, "blocks_noise", 3, {}, True),
        ("C4C-10_420p10_354x290", 354, 290, "YUV420P10", 10, "blocks", 3, {}, True),
        ("C4C-11_gray8_smallest_12x9", 12, 9, "GRAY8", 8, "blocks", 2, {}, True),
        ("C4C-12_gray8_flat_noop", 96, 64, "GRAY8", 8, "flat", 2, {}, False),
        ("C4C-13_gray8_extremes_clamp", 160, 96, "GRAY8", 8, "extremes", 2,
         {"strength": 60}, True),
        ("C4C-14_444p8_planes_luma_only", 240, 160, "YUV444P8", 8, "blocks", 2,
         {"planes": [0]}, True),
        ("C4C-15_420p8_planes_chroma_only", 240, 160, "YUV420P8", 8, "blocks", 2,
         {"planes": [1, 2]}, True),
        ("C4C-16_gray8_corner_offsets_low", 160, 96, "GRAY8", 8, "blocks", 2,
         {"strength": 25, "boundary_strength_offset": -25,
          "side_activity_offset": -25}, False),
        ("C4C-17_gray8_corner_offsets_high", 160, 96, "GRAY8", 8, "blocks", 2,
         {"strength": 25, "boundary_strength_offset": 35,
          "side_activity_offset": 35}, True),
        ("C4C-18_gray16_h_underfill_9x6", 9, 6, "GRAY16", 16, "blocks", 2, {}, False),
    ]

    # Region-targeted vacuity (harness v1.4, adopting the W3C strengthening
    # proposal of 2026-08-12): for every tail-named case, changed samples
    # must occur INSIDE the named tail region on the scalar leg, proving the
    # underfilled path performed real filtering end-to-end - not merely that
    # the frame changed somewhere. Strips are safely inclusive supersets of
    # the lane-remainder plus kernel span.
    FOCUS = {
        "C4C-01_gray8_711x480_r7": ("right", 24),
        "C4C-02_gray8_719x479_r15_h3": ("right_and_bottom", 24, 8),
        "C4C-03_gray8_353x289_r1_h1": ("right_and_bottom", 24, 8),
        "C4C-05_420p8_718x478_r14_h2": ("right_and_bottom", 24, 8),
        "C4C-07_422p8_718x479": ("right_and_bottom", 24, 8),
        "C4C-08_gray16_719x479_r7u16": ("right_and_bottom", 24, 8),
        "C4C-10_420p10_354x290": ("right", 24),
        "C4C-11_gray8_smallest_12x9": ("bottom", 6),
    }

    def changed_in_focus(f_src, f_leg, focus):
        if focus is None:
            return None
        count = 0
        for plane in range(f_leg.format.num_planes):
            src_arr = f_src[plane]
            leg_arr = f_leg[plane]
            height, width = leg_arr.shape
            mode = focus[0]
            x_lo = width - min(focus[1], width) if mode in ("right", "right_and_bottom") else 0
            y_lo = 0
            if mode == "bottom":
                y_lo = height - min(focus[1], height)
            elif mode == "right_and_bottom":
                y_lo = height - min(focus[2], height)
            # right strip (full height) plus bottom strip (full width) union
            for y in range(height):
                for x in range(width):
                    in_right = x >= x_lo and mode in ("right", "right_and_bottom")
                    in_bottom = y >= y_lo and mode in ("bottom", "right_and_bottom")
                    if not (in_right or in_bottom):
                        continue
                    if int(src_arr[y, x]) != int(leg_arr[y, x]):
                        count += 1
        return count

    def get_format(name):
        return getattr(vs, name)

    def props_of(clip):
        frame = clip.get_frame(0)
        return {
            "tier": bytes(frame.props["Deblock4Tier"]).decode("ascii")
            if isinstance(frame.props["Deblock4Tier"], (bytes, bytearray))
            else str(frame.props["Deblock4Tier"]),
            "version": bytes(frame.props["Deblock4Version"]).decode("ascii")
            if isinstance(frame.props["Deblock4Version"], (bytes, bytearray))
            else str(frame.props["Deblock4Version"]),
        }

    # ---------------------------------------------- T4 selection coverage ---
    selection_report = {}
    probe = make_source(96, 64, get_format("GRAY8"), 1, "blocks", 4243)
    try:
        auto_clip = core.deblock4.Classic(clip=probe)
        v1_clip = core.deblock4.Classic(clip=probe, backend=EXPECTED_V1)
        v2_clip = core.deblock4.Classic(clip=probe, backend=EXPECTED_V2)
    except vs.Error as error:
        print(MARK_ENV + " creation failed during selection coverage: " + str(error))
        sys.exit(4)
    auto_props = props_of(auto_clip)
    v1_props = props_of(v1_clip)
    v2_props = props_of(v2_clip)
    selection_report = {"auto": auto_props, "v1": v1_props, "v2": v2_props}
    selection_ok = (
        auto_props["tier"] == EXPECTED_V2
        and v1_props["tier"] == EXPECTED_V1
        and v2_props["tier"] == EXPECTED_V2
        and auto_props["version"] == EXPECTED_VERSION
        and v1_props["version"] == EXPECTED_VERSION
        and v2_props["version"] == EXPECTED_VERSION
    )
    if not selection_ok:
        print(MARK_SELECT + " " + json.dumps(selection_report))
        summary_path = os.path.join(INSPECT_DIR, "stage_4c_diff_summary.json")
        with open(summary_path, "w") as handle:
            json.dump({"run_kind": RUN_KIND, "dll_sha256": DLL_SHA256,
                       "selection": selection_report,
                       "verdict": "SELECTION_FAIL"}, handle, indent=2)
        sys.exit(3)

    # ----------------------------------------------------- differential ---
    case_reports = []
    first_difference = None
    total_diff_samples = 0

    for (name, width, height, fmt_name, bits, kind, frames, params,
         expect_changes) in CASES:
        fmt = get_format(fmt_name)
        source = make_source(width, height, fmt, frames, kind,
                             seed=(sum(ord(c) for c in name) * 2654435761) & 0xFFFF)
        leg_v1 = core.deblock4.Classic(clip=source, backend=EXPECTED_V1, **params)
        leg_v2 = core.deblock4.Classic(clip=source, backend=EXPECTED_V2, **params)
        case_diffs = 0
        case_changed_vs_source = 0
        focus = FOCUS.get(name)
        focus_changed = 0 if focus is not None else None
        for n in range(frames):
            f_src = source.get_frame(n)
            f_v1 = leg_v1.get_frame(n)
            f_v2 = leg_v2.get_frame(n)
            if focus is not None:
                focus_changed += changed_in_focus(f_src, f_v1, focus)
            for plane in range(f_v1.format.num_planes):
                a = logical_plane_bytes(f_v1, plane)
                b = logical_plane_bytes(f_v2, plane)
                s = logical_plane_bytes(f_src, plane)
                if a != s:
                    case_changed_vs_source += 1
                if a != b:
                    limit = min(len(a), len(b))
                    for index in range(limit):
                        if a[index] != b[index]:
                            case_diffs += 1
                            if first_difference is None:
                                first_difference = {
                                    "case": name, "frame": n, "plane": plane,
                                    "byte_index": index,
                                    "v1": a[index], "v2": b[index],
                                }
        total_diff_samples += case_diffs
        vacuity_ok = (case_changed_vs_source > 0) if expect_changes else True
        if expect_changes and focus is not None and (focus_changed or 0) == 0:
            vacuity_ok = False
        case_reports.append({
            "case": name, "dims": [width, height], "format": fmt_name,
            "frames": frames, "diff_bytes": case_diffs,
            "planes_changed_vs_source": case_changed_vs_source,
            "focus_changed_samples": focus_changed,
            "expect_changes": expect_changes, "non_vacuity_ok": vacuity_ok,
        })

    non_vacuity_all = all(entry["non_vacuity_ok"] for entry in case_reports)

    summary = {
        "run_kind": RUN_KIND,
        "dll_path": os.path.abspath(PLUGIN_PATH),
        "dll_sha256": DLL_SHA256,
        "expected_version": EXPECTED_VERSION,
        "selection": selection_report,
        "cases": case_reports,
        "total_diff_bytes": total_diff_samples,
        "first_difference": first_difference,
        "non_vacuity_all": non_vacuity_all,
        "verdict": ("ALL_PASS" if (total_diff_samples == 0 and non_vacuity_all)
                    else "DIFFERENCES" if total_diff_samples else "VACUITY_FAIL"),
    }
    summary_path = os.path.join(INSPECT_DIR, "stage_4c_diff_summary.json")
    with open(summary_path, "w") as handle:
        json.dump(summary, handle, indent=2)

    if total_diff_samples != 0:
        print(MARK_DIFF + " total_diff_bytes=" + str(total_diff_samples)
              + " first=" + json.dumps(first_difference))
        sys.exit(2)
    if not non_vacuity_all:
        print(MARK_SELECT + " non-vacuity failed (differential proved nothing)")
        sys.exit(3)
    print(MARK_PASS + " cases=" + str(len(CASES))
          + " dll_sha256=" + DLL_SHA256)
    sys.exit(0)
