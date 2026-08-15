# stage_5c_benchmark.py - Deblock4 Stage 5C W3D NON-GATING benchmark runner
# W3D-owned (S5C-3 / 5C-RAT-4; delivery manifest s4 join contract).
# Run under the portable VapourSynth python (tools\run_vs.cmd --python-script).
#
# METHOD (ratified): time.perf_counter() around the exact vspipe process; ONE
# discarded warm-up run then THREE recorded runs per backend v1/v2/v3;
# identical clip, frames, parameters, sink and environment; every raw
# duration printed and written to JSON. Because vspipe must run with the
# VapourSynth root as CWD, each timed interval includes a small constant of
# process start overhead - identical across backends, so it cannot bias the
# v1/v2/v3 comparison. NO SPEED THRESHOLD EXISTS: exit 0 means the numbers
# were RECORDED (all vspipe runs returned 0 and props were verified inside
# the script); it is never a performance judgement.
#
# EXIT CODES: 0 = recorded; 4 = environment/contract failure (including any
# vspipe run failing, since then the record is incomplete).
#
# v1.1 (2026-08-15): W3D fix - the v1.0 file was generated with a mangled
# LoadPlugin/expected_version pair (nested triple-quote defect in the
# generator); the emitted .vpy was syntactically invalid and every vspipe
# leg failed at evaluation. The .vpy builder now embeds values via repr().
# No timing-method change; S5C-3 semantics unchanged.
# US-ASCII; CRLF.

import json
import os
import subprocess
import sys
import time

MARK_OK = "STAGE_5C_BENCHMARK_RECORDED"
MARK_ENV = "STAGE_5C_BENCHMARK_ENVIRONMENT_FAIL"


def env_fail(message):
    print(MARK_ENV + " " + message)
    sys.exit(4)


def require_env(name):
    value = os.environ.get(name, "")
    if not value:
        env_fail("missing environment variable " + name)
    return value


PLUGIN_PATH = os.path.abspath(require_env("DEBLOCK4_PLUGIN_PATH"))
BENCH_DIR = os.path.abspath(require_env("DEBLOCK4_STAGE5C_BENCHMARK_DIR"))
EXPECTED_VERSION = require_env("DEBLOCK4_STAGE5C_EXPECTED_VERSION")
BACKENDS = [
    require_env("DEBLOCK4_STAGE5C_EXPECTED_V1"),
    require_env("DEBLOCK4_STAGE5C_EXPECTED_V2"),
    require_env("DEBLOCK4_STAGE5C_EXPECTED_V3"),
]

if not os.path.isfile(PLUGIN_PATH):
    env_fail("plugin not found: " + PLUGIN_PATH)
os.makedirs(BENCH_DIR, exist_ok=True)

# vspipe location per tools\run_vs.cmd convention: this script runs under the
# portable python, whose executable lives in the VapourSynth root.
VSROOT = os.path.dirname(os.path.abspath(sys.executable))
VSPIPE = os.path.join(VSROOT, "Lib", "site-packages", "vapoursynth",
                      "vspipe.exe")
if not os.path.isfile(VSPIPE):
    env_fail("vspipe not found at portable location: " + VSPIPE)

# Fixed workload: 720x576 YUV420P8 (the ratified PAL u8 case: luma remainder
# 16, chroma 360 divides exactly), strength 25, 240 frames. The pattern is
# painted ONCE (frame 0) with the proven 8-step block amplitude, then looped,
# so generation cost is negligible and identical for every leg.
FRAMES = 240
BENCH_VPY = os.path.join(BENCH_DIR, "stage_5c_bench_clip.vpy")
# W3D fix v1.1: plugin path and version are embedded via repr(), so the
# template contains no nested quoting (the v1.0 generator mangled here).
VPY_TEXT = "\r\n".join([
    "import os",
    "import vapoursynth as vs",
    "core = vs.core",
    "core.std.LoadPlugin(path=" + repr(PLUGIN_PATH) + ")",
    "backend = os.environ['DEBLOCK4_STAGE5C_BENCH_BACKEND']",
    "expected_version = " + repr(EXPECTED_VERSION),
    "base = core.std.BlankClip(width=720, height=576, length=1,",
    "                          format=vs.YUV420P8, fpsnum=25, fpsden=1)",
    "def paint(n, f):",
    "    out = f.copy()",
    "    for plane in range(out.format.num_planes):",
    "        array = out[plane]",
    "        plane_h, plane_w = array.shape",
    "        for y in range(plane_h):",
    "            for x in range(plane_w):",
    "                band = ((x // 8) + (y // 8) * 3 + plane * 5) % 2",
    "                array[y, x] = 100 + band * 8",
    "    return out",
    "painted = core.std.ModifyFrame(clip=base, clips=base, selector=paint)",
    "clip = core.std.Loop(painted, times=" + str(FRAMES) + ")",
    "out = core.deblock4.Classic(clip=clip, backend=backend, strength=25)",
    "frame0 = out.get_frame(0)",
    "def prop_text(v):",
    "    return bytes(v).decode('ascii') if isinstance(v, (bytes, bytearray)) else str(v)",
    "if prop_text(frame0.props['Deblock4Tier']) != backend:",
    "    raise RuntimeError('benchmark leg tier mismatch: '",
    "                       + prop_text(frame0.props['Deblock4Tier']))",
    "if prop_text(frame0.props['Deblock4Version']) != expected_version:",
    "    raise RuntimeError('benchmark leg version mismatch')",
    "out.set_output()",
    "",
])
with open(BENCH_VPY, "w", newline="") as handle:
    handle.write(VPY_TEXT)


def one_run(backend):
    env = dict(os.environ)
    env["DEBLOCK4_STAGE5C_BENCH_BACKEND"] = backend
    with open(os.devnull, "wb") as sink:
        begin = time.perf_counter()
        completed = subprocess.run(
            [VSPIPE, "-c", "y4m", BENCH_VPY, "-"],
            cwd=VSROOT, env=env, stdout=sink,
            stderr=subprocess.PIPE,
        )
        elapsed = time.perf_counter() - begin
    return elapsed, completed.returncode, completed.stderr.decode(
        "ascii", errors="replace")


records = []
for backend in BACKENDS:
    warm_elapsed, warm_rc, warm_err = one_run(backend)
    print("BENCH backend=" + backend + " warmup_seconds="
          + ("%.6f" % warm_elapsed) + " rc=" + str(warm_rc)
          + " (discarded)")
    if warm_rc != 0:
        print(warm_err.strip()[-500:])
        env_fail("warm-up vspipe run failed for backend " + backend)
    runs = []
    for index in range(3):
        elapsed, rc, err = one_run(backend)
        print("BENCH backend=" + backend + " run=" + str(index + 1)
              + " seconds=" + ("%.6f" % elapsed) + " rc=" + str(rc))
        if rc != 0:
            print(err.strip()[-500:])
            env_fail("recorded vspipe run failed for backend " + backend)
        runs.append(elapsed)
    records.append({"backend": backend,
                    "warmup_seconds_discarded": warm_elapsed,
                    "recorded_seconds": runs})

summary = {
    "method": "perf_counter around the exact vspipe process; 1 discarded "
              "warm-up + 3 recorded runs per backend; identical clip, "
              "frames, parameters, sink, environment; wrapper overhead "
              "constant across backends; NON-GATING (S5C-3)",
    "clip": "synthetic 720x576 YUV420P8 blocks(8-step), strength=25, "
            + str(FRAMES) + " frames (painted once, looped)",
    "plugin": PLUGIN_PATH,
    "expected_version": EXPECTED_VERSION,
    "vspipe": VSPIPE,
    "records": records,
    "thresholds": None,
}
with open(os.path.join(BENCH_DIR, "stage_5c_benchmark_record.json"), "w")         as handle:
    json.dump(summary, handle, indent=2)

print(MARK_OK + " backends=" + ",".join(BACKENDS)
      + " runs_per_backend=3 (+1 warmup discarded)")
sys.exit(0)
