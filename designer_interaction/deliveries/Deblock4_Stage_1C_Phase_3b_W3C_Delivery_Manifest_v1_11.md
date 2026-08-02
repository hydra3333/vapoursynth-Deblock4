# Deblock4 Stage 1C Phase 3b - W3C Delivery Manifest

**Version:** 1.11
**Date:** 2026-08-02
**Author:** W3C
**Status:** Three-file validation-only corrective delivery candidate for W3D review and W3X validation/acceptance.
**Repository:** `hydra3333/vapoursynth-Deblock4`
**Branch:** `main`
**Encoding:** US-ASCII and CRLF.

## 1. Triggering W3X evidence

The v1.10 run passed all static audits, the initial whitespace gate, the ReleaseSafe production DLL and selftest build, all 40 unit tests, the executable selftest, both filters' valid automatic and selected-tier R78 cases, and the Deblock4 midpoint-present and midpoint-absent cases. It stopped only when the Classic harness expected `strength=1.5` to be rejected as a wrong type, but VapourSynth had already coerced that value to integer `1` before the plugin creation callback.

The v1.10 transcript remains valid partial Phase 3b evidence. The v1.11 resume helper preserves the existing local full transcript under `zig-out/inspection_1C_v1_10_partial_evidence/` when available before the new run removes `zig-out/inspection_1C`.

## 2. W3D ruling and Toolchain finding F6

W3D verified and accepted the diagnosis recorded as Toolchain finding F6:

- numeric arguments are coerced to the registered VapourSynth parameter type before the plugin sees them;
- plugin-level wrong-type rejection for an `int:opt` parameter is therefore unreachable;
- production code remains unchanged;
- the standing gate must not replace the case with a test of VapourSynth's own version-dependent boundary error;
- Deblock4's own validation remains proven by its range cases.

The separately ratified Stage 1C.1 release-visible invocation-echo mitigation is explicitly out of scope. W3X will release that rider only after Stage 1C is accepted and committed. v1.11 begins no Stage 1C.1 work.

## 3. Exact repository changes

v1.11 changes exactly three validation files:

- `build_1C_v1.bat`
- `tests/stage_1c_classic_passthrough.vpy`
- `tests/stage_1c_deblock4_passthrough.vpy`

Changes:

1. remove `error_wrong_type` from both runner validation-case lists;
2. remove the unreachable `error_wrong_type` branch from both `.vpy` harnesses;
3. add the approved F6 comment beside the retained strength range case in each harness.

No production source, build manifest, audit script, vendored header, `tools/run_vs.cmd`, or other W3X-owned file is supplied, copied, deleted, reformatted or normalised.

## 4. Base and use

This is a corrective delta for the currently applied Phase 3b v1.10 repository state. It is not a fresh Phase 3a application package.

Run:

```bat
call "<EXTRACTED_V1_11_DELIVERY>\resume_phase3b_validation_after_applied_state.bat" "<REPOSITORY_ROOT>"
```

The helper byte-verifies the three copied validation files, confirms the retired case is absent and both F6 comments are present, runs `git diff --check`, and reruns the complete permanent `build_1C_v1.bat` proof matrix.

## 5. Authoritative success terminus

```text
STAGE 1C_v1 FULL PROOF MATRIX COMPLETED SUCCESSFULLY
B1 B2 G1 G2 E1 E2 E3 E4 E5 E6 V1 S1 S2 S3 N1 PASS
```

W3C performed static validation only. W3X's Windows/VS2026/Zig/VapourSynth run remains authoritative; W3D review, W3C concurrence and W3X acceptance remain required.
