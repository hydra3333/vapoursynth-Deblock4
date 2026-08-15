# stage_5c_scalar_vector_diff.py - Deblock4 Stage 5C W3D differential harness
# W3D-owned (scope v1_2 sections 7/8; delivery manifest s4 join contract).
# Run under the portable VapourSynth python (tools\run_vs.cmd --python-script).
#
# RUN KINDS (DEBLOCK4_STAGE5C_RUN_KIND):
#   positive                            three-way v1/v2/v3 over the 5C corpus.
#       The v1-vs-v2 legs inside it ARE the retained 4C regression coverage;
#       DEBLOCK4_STAGE5C_REQUIRE_STAGE4C_REGRESSION=1 asserts they ran and is
#       recorded in the summary (separate inspection dirs preclude a
#       cross-run file check).
#   stage4c-regression                  v1-vs-v2 over the proven 4C corpus.
#   tail-mutant-expected-failure        positive semantics; caller expects 2.
#   stage4c-tail-mutant-expected-failure regression semantics; caller expects 2.
#
# EXIT CODES (contract with run_stage_5c_differential.cmd):
#   0 = ALL PASS   2 = DIFFERENCES DETECTED   3 = SELECTION/COVERAGE FAILURE
#   4 = ENVIRONMENT/CONTRACT FAILURE
#
# US-ASCII; CRLF.

import hashlib
import json
import os
import sys

MARK_PASS = "STAGE_5C_SCALAR_VECTOR_DIFFERENTIAL_ALL_PASS"
MARK_DIFF = "STAGE_5C_DIFFERENTIAL_DETECTED_DIFFERENCES"
MARK_SELECT = "STAGE_5C_SELECTION_COVERAGE_FAIL"
MARK_ENV = "STAGE_5C_ENVIRONMENT_FAIL"


def env_fail(message):
    print(MARK_ENV + " " + message)
    sys.exit(4)


def require_env(name):
    value = os.environ.get(name, "")
    if not value:
        env_fail("missing environment variable " + name)
    return value


PLUGIN_PATH = require_env("DEBLOCK4_PLUGIN_PATH")
INSPECT_DIR = require_env("DEBLOCK4_STAGE5C_INSPECTION_DIR")
EXPECTED_VERSION = require_env("DEBLOCK4_STAGE5C_EXPECTED_VERSION")
EXPECTED_V1 = require_env("DEBLOCK4_STAGE5C_EXPECTED_V1")
EXPECTED_V2 = require_env("DEBLOCK4_STAGE5C_EXPECTED_V2")
EXPECTED_V3 = require_env("DEBLOCK4_STAGE5C_EXPECTED_V3")
RUN_KIND = os.environ.get("DEBLOCK4_STAGE5C_RUN_KIND", "positive")
REQUIRE_4C = os.environ.get(
    "DEBLOCK4_STAGE5C_REQUIRE_STAGE4C_REGRESSION", "") == "1"

KNOWN_KINDS = ("positive", "stage4c-regression",
               "tail-mutant-expected-failure",
               "stage4c-tail-mutant-expected-failure")
if RUN_KIND not in KNOWN_KINDS:
    env_fail("unknown run kind " + RUN_KIND)
FOUR_C_STYLE = RUN_KIND in ("stage4c-regression",
                            "stage4c-tail-mutant-expected-failure")

if not os.path.isfile(PLUGIN_PATH):
    env_fail("plugin not found: " + PLUGIN_PATH)
os.makedirs(INSPECT_DIR, exist_ok=True)

with open(PLUGIN_PATH, "rb") as handle:
    DLL_SHA256 = hashlib.sha256(handle.read()).hexdigest()

# ---------------------------------------------------------------- policy ---
# Isolation transplanted in structure from the PROVEN 4C harness (green on
# this R79 install): stateful singleton policy; autoload disabled; manual
# plugin load only.
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

# ------------------------------------------------------------ generators ---
# Idioms inherited from the PROVEN 4C harness, including the hard-won 8-step
# "blocks" amplitude (23-step exceeded alpha and made cases inert: harness
# defect H-3) and stride-safe sample-wise logical byte extraction.


def lcg_value(state):
    return (state * 1664525 + 1013904223) & 0xFFFFFFFF


def fill_value(plane, y, x, bits, kind, seed):
    peak = (1 << bits) - 1
    if kind == "flat":
        return 1 << (bits - 1)
    if kind == "blocks":
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


# ----------------------------------------------------------------- corpus ---
# 5C set: forces u8 N=32 remainder classes 1/15/16/17/31 and u16 N=16 classes
# 1/9/15 on LUMA/GRAY, the same u8 classes ON CHROMA PLANES of legal
# even-width 4:2:0/4:2:2 frames (adopted R4 widths), heights leaving 1/2/3
# rows in the final vertical band (h%4 = 1/2/3), plane subsets, corner
# offsets, a flat no-op and a clamp case.
# (name, width, height, format, bits, kind, frames, params, expect_changes)
CASES_5C = [
    ("C5C-01_gray8_705x480_r1", 705, 480, "GRAY8", 8, "blocks", 2, {}, True),
    ("C5C-02_gray8_719x479_r15_h3", 719, 479, "GRAY8", 8, "blocks_noise", 2, {}, True),
    ("C5C-03_gray8_720x576_r16_pal", 720, 576, "GRAY8", 8, "blocks", 2, {}, True),
    ("C5C-04_gray8_721x481_r17_h1", 721, 481, "GRAY8", 8, "blocks", 2, {}, True),
    ("C5C-05_gray8_735x479_r31_h3", 735, 479, "GRAY8", 8, "blocks_noise", 2, {}, True),
    ("C5C-06_420p8_706x478_cr1_h2", 706, 478, "YUV420P8", 8, "blocks", 2, {}, True),
    ("C5C-07_420p8_736x478_cr16_h2", 736, 478, "YUV420P8", 8, "blocks_noise", 2, {}, True),
    ("C5C-08_420p8_766x480_cr31", 766, 480, "YUV420P8", 8, "blocks", 2, {}, True),
    ("C5C-09_422p8_738x479_cr17_h3", 738, 479, "YUV422P8", 8, "blocks", 2, {}, True),
    ("C5C-10_gray16_713x481_r9_h1", 713, 481, "GRAY16", 16, "blocks", 2, {}, True),
    ("C5C-11_gray16_719x479_r15_h3", 719, 479, "GRAY16", 16, "blocks_noise", 2, {}, True),
    ("C5C-12_444p16_705x480_r1", 705, 480, "YUV444P16", 16, "blocks", 2, {}, True),
    ("C5C-13_420p10_722x478_cr9_h2", 722, 478, "YUV420P10", 10, "blocks", 2, {}, True),
    ("C5C-14_444p8_planes_luma_only", 240, 160, "YUV444P8", 8, "blocks", 2,
     {"planes": [0]}, True),
    ("C5C-15_420p8_planes_chroma_only", 240, 160, "YUV420P8", 8, "blocks", 2,
     {"planes": [1, 2]}, True),
    ("C5C-16_gray8_flat_noop", 96, 64, "GRAY8", 8, "flat", 2, {}, False),
    ("C5C-17_gray8_extremes_clamp", 160, 96, "GRAY8", 8, "extremes", 2,
     {"strength": 60}, True),
]

# Focus strips (region-targeted non-vacuity, the retained 4C strengthening):
# right strip 40 covers remainder<=31 plus the 6-tap kernel span; bottom 8
# covers the final vertical band plus span.
FOCUS_5C = {
    "C5C-01_gray8_705x480_r1": ("right", 40),
    "C5C-02_gray8_719x479_r15_h3": ("right_and_bottom", 40, 8),
    "C5C-03_gray8_720x576_r16_pal": ("right", 40),
    "C5C-04_gray8_721x481_r17_h1": ("right_and_bottom", 40, 8),
    "C5C-05_gray8_735x479_r31_h3": ("right_and_bottom", 40, 8),
    "C5C-06_420p8_706x478_cr1_h2": ("right_and_bottom", 40, 8),
    "C5C-07_420p8_736x478_cr16_h2": ("right_and_bottom", 40, 8),
    "C5C-08_420p8_766x480_cr31": ("right", 40),
    "C5C-09_422p8_738x479_cr17_h3": ("right_and_bottom", 40, 8),
    "C5C-10_gray16_713x481_r9_h1": ("right_and_bottom", 40, 8),
    "C5C-11_gray16_719x479_r15_h3": ("right_and_bottom", 40, 8),
    "C5C-12_444p16_705x480_r1": ("right", 40),
    "C5C-13_420p10_722x478_cr9_h2": ("right", 40),
}

# 4C regression set: the PROVEN 4C corpus and focus strips, verbatim.
CASES_4C = [
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
FOCUS_4C = {
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


def prop_text(value):
    if isinstance(value, (bytes, bytearray)):
        return bytes(value).decode("ascii")
    return str(value)


def props_of(clip):
    frame = clip.get_frame(0)
    return {
        "tier": prop_text(frame.props["Deblock4Tier"]),
        "version": prop_text(frame.props["Deblock4Version"]),
    }


# ------------------------------------------------- selection coverage (T4) ---
probe = make_source(96, 64, get_format("GRAY8"), 1, "blocks", 4243)
try:
    auto_props = props_of(core.deblock4.Classic(clip=probe))
    v1_props = props_of(core.deblock4.Classic(clip=probe, backend=EXPECTED_V1))
    v2_props = props_of(core.deblock4.Classic(clip=probe, backend=EXPECTED_V2))
    v3_props = props_of(core.deblock4.Classic(clip=probe, backend=EXPECTED_V3))
except vs.Error as error:
    print(MARK_ENV + " creation failed during selection coverage: " + str(error))
    sys.exit(4)
selection_report = {"auto": auto_props, "v1": v1_props,
                    "v2": v2_props, "v3": v3_props}
selection_ok = (
    auto_props["tier"] == EXPECTED_V3
    and v1_props["tier"] == EXPECTED_V1
    and v2_props["tier"] == EXPECTED_V2
    and v3_props["tier"] == EXPECTED_V3
    and all(entry["version"] == EXPECTED_VERSION
            for entry in selection_report.values())
)
summary_name = ("stage_5c_diff_summary_" + RUN_KIND.replace("-", "_") + ".json")
summary_path = os.path.join(INSPECT_DIR, summary_name)
if not selection_ok:
    print(MARK_SELECT + " " + json.dumps(selection_report))
    with open(summary_path, "w") as handle:
        json.dump({"run_kind": RUN_KIND, "dll_sha256": DLL_SHA256,
                   "selection": selection_report,
                   "verdict": "SELECTION_FAIL"}, handle, indent=2)
    sys.exit(3)

# -------------------------------------------------------- differential legs ---
CASES = CASES_4C if FOUR_C_STYLE else CASES_5C
FOCUS = FOCUS_4C if FOUR_C_STYLE else FOCUS_5C
# Legs beyond scalar: regression kinds prove v2 only; 5C kinds prove v2 AND
# v3 (three-way; the v2 leg is the retained 4C regression coverage inside
# the positive run - see REQUIRE_4C note in the header).
LEG_BACKENDS = [EXPECTED_V2] if FOUR_C_STYLE else [EXPECTED_V2, EXPECTED_V3]

case_reports = []
first_difference = None
total_diff_samples = 0

for (name, width, height, fmt_name, bits, kind, frames, params,
     expect_changes) in CASES:
    fmt = get_format(fmt_name)
    source = make_source(width, height, fmt, frames, kind,
                         seed=(sum(ord(c) for c in name) * 2654435761) & 0xFFFF)
    leg_ref = core.deblock4.Classic(clip=source, backend=EXPECTED_V1, **params)
    legs = [(backend, core.deblock4.Classic(clip=source, backend=backend,
                                            **params))
            for backend in LEG_BACKENDS]
    case_diffs = 0
    case_changed_vs_source = 0
    focus = FOCUS.get(name)
    focus_changed = 0 if focus is not None else None
    for n in range(frames):
        f_src = source.get_frame(n)
        f_ref = leg_ref.get_frame(n)
        if focus is not None:
            focus_changed += changed_in_focus(f_src, f_ref, focus)
        ref_planes = []
        for plane in range(f_ref.format.num_planes):
            ref_bytes = logical_plane_bytes(f_ref, plane)
            ref_planes.append(ref_bytes)
            if ref_bytes != logical_plane_bytes(f_src, plane):
                case_changed_vs_source += 1
        for backend, leg in legs:
            f_leg = leg.get_frame(n)
            for plane in range(f_leg.format.num_planes):
                leg_bytes = logical_plane_bytes(f_leg, plane)
                if leg_bytes != ref_planes[plane]:
                    limit = min(len(leg_bytes), len(ref_planes[plane]))
                    for index in range(limit):
                        if leg_bytes[index] != ref_planes[plane][index]:
                            case_diffs += 1
                            if first_difference is None:
                                first_difference = {
                                    "case": name, "frame": n, "plane": plane,
                                    "byte_index": index, "backend": backend,
                                    "v1": ref_planes[plane][index],
                                    "vec": leg_bytes[index],
                                }
    total_diff_samples += case_diffs
    vacuity_ok = (case_changed_vs_source > 0) if expect_changes else True
    if expect_changes and focus is not None and (focus_changed or 0) == 0:
        vacuity_ok = False
    case_reports.append({
        "case": name, "dims": [width, height], "format": fmt_name,
        "frames": frames, "legs": LEG_BACKENDS, "diff_bytes": case_diffs,
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
    "legs_beyond_scalar": LEG_BACKENDS,
    "stage4c_regression_included": (not FOUR_C_STYLE) and REQUIRE_4C
    and EXPECTED_V2 in LEG_BACKENDS,
    "selection": selection_report,
    "cases": case_reports,
    "total_diff_bytes": total_diff_samples,
    "first_difference": first_difference,
    "non_vacuity_all": non_vacuity_all,
    "verdict": ("ALL_PASS" if (total_diff_samples == 0 and non_vacuity_all)
                else "DIFFERENCES" if total_diff_samples else "VACUITY_FAIL"),
}
with open(summary_path, "w") as handle:
    json.dump(summary, handle, indent=2)

if total_diff_samples != 0:
    print(MARK_DIFF + " total_diff_bytes=" + str(total_diff_samples)
          + " first=" + json.dumps(first_difference))
    sys.exit(2)
if not non_vacuity_all:
    print(MARK_SELECT + " non-vacuity failed (differential proved nothing)")
    sys.exit(3)
print(MARK_PASS + " kind=" + RUN_KIND + " cases=" + str(len(CASES))
      + " legs=" + ",".join(LEG_BACKENDS) + " dll_sha256=" + DLL_SHA256)
sys.exit(0)
