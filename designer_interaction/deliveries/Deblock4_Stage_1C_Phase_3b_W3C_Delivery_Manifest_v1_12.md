# Deblock4 Stage 1C Phase 3b - W3C Delivery Manifest

**Version:** 1.12
**Date:** 2026-08-02
**Author:** W3C
**Status:** Consolidated three-file validation-only corrective delivery candidate for W3D review and W3X validation/acceptance.
**Repository:** `hydra3333/vapoursynth-Deblock4`
**Branch:** `main`
**Encoding:** US-ASCII and CRLF.
**Governance:** Issued under C-DELIV-01 through C-DELIV-08. Production and W3X-owned files are excluded.

## 1. Triggering W3X evidence

The v1.11 run passed all static audits, ReleaseSafe build, all 40 unit tests, the executable selftest, all valid Classic and Deblock4 pass-through cases, both midpoint cases, Classic `error_strength`, and Classic `error_duplicate_planes`. It stopped only at Classic `error_empty_planes` because VapourSynth rejected `planes=[]` before the plugin creation callback and emitted a framework-owned message.

The v1.11 transcript remains valid partial Phase 3b evidence through `error_duplicate_planes`. The v1.12 resume helper preserves the existing local full transcript under `zig-out/inspection_1C_v1_11_partial_evidence/` when available before the new run removes `zig-out/inspection_1C`.

## 2. W3D ruling

W3D ruled:

- retire `error_empty_planes` from both `.vpy` harnesses and both runner case lists;
- do not assert VapourSynth's framework-owned, version-dependent boundary message;
- keep Deblock4 production empty-array validation byte-unchanged because the low-level C API can deliver a zero-element property;
- identify in both harnesses that the plugin check is low-level-API defence, unreachable via vspipe but not dead code;
- name the existing unit/synthetic proof;
- sweep every remaining error case once and report its vspipe reachability before delivery;
- make no production or W3X-owned-file change.

## 3. Exact repository changes

v1.12 changes exactly three validation files:

- `build_1C_v1.bat`
- `tests/stage_1c_classic_passthrough.vpy`
- `tests/stage_1c_deblock4_passthrough.vpy`

Changes:

1. remove `error_empty_planes` from both runner validation-case lists;
2. remove the unreachable `error_empty_planes` branch from both `.vpy` harnesses;
3. add the approved class-distinguishing comment in both harnesses, naming Zig test `plane arrays reject empty and duplicate and ignore order`.

No production source, build manifest, audit script, vendored header, `tools/run_vs.cmd`, or other W3X-owned file is supplied, copied, deleted, reformatted or normalised. Stage 1C.1 remains out of scope.

## 4. Consolidated E/error-case reachability sweep

The sweep covered every error case still named by either harness or the permanent runner, plus the two retired boundary cases.

| Case | Surface | Reachability result | Plugin-owned validation path / disposition |
|---|---|---|---|
| `error_strength` | Classic + Deblock4 | Reachable. Classic dynamically passed in v1.11; Deblock4 has the same registered `int` and shared parser path. | `int` survives the binding; `parseCommon` emits `StrengthOutOfRange`. Retain. |
| `error_duplicate_planes` | Classic + Deblock4 | Reachable. Classic dynamically passed in v1.11; Deblock4 has the same registered non-empty `int[]` and shared parser path. | Non-empty array survives; `parsePlaneRequest` emits `DuplicatePlaneIndex`. Retain. |
| `error_empty_planes` | Classic + Deblock4 | Not reachable via vspipe. | VapourSynth rejects the empty array before the callback. Retire the harness case only. Production `EmptyPlanes` defence remains and is proven by Zig test `plane arrays reject empty and duplicate and ignore order`. |
| `error_unknown_backend` | Classic + Deblock4 | Reachable. | `backend:data:opt` preserves the token; `readOptionalData` then `parseBackendValue` emits `UnknownBackend`. Retain. |
| `error_variable_format` | Classic + Deblock4 | Reachable. | `clip:vnode` accepts the variable-format node; each creation callback calls `vsh_isConstantVideoFormat` and emits the filter-owned constant-format error. Retain. |
| `error_step_low` | Deblock4 | Reachable. | Registered integer values survive; `parseCustomStep` emits `CustomStepOutOfRange` for zero. Retain. |
| `error_step_high` | Deblock4 | Reachable. | Registered integer value 33 survives and parses; `validateClipParameters` compares it with the 32-pixel luma width and emits `CustomStepExceedsPlaneDimension`. Retain. |
| `error_above_effective` | Classic + Deblock4 debug matrix | Reachable. | Backend data survives; `selectForInstance` / `selectForEffectiveTier` emits `RequestedBackendUnavailable` under the forced lower EFFECTIVE tier. Retain. |
| `error_invalid_force_down` | Classic + Deblock4 debug matrix | Reachable. | The normal `auto` token survives; force-down environment parsing inside instance selection emits `InvalidForceDownValue`. Retain. |
| `error_wrong_type` | Classic + Deblock4 | Not observable at plugin boundary (F6). | VapourSynth coerces `float` to registered `int` before the callback. Already retired in v1.11; production unchanged. |

No additional case failed the reachability criterion. v1.12 therefore retires only `error_empty_planes`.

The cases not yet reached dynamically in the v1.11 transcript were verified by registration-signature and creation-path source trace. W3X's v1.12 matrix run supplies the authoritative dynamic proof.

## 5. Base and use

This is a corrective delta for the currently applied Phase 3b v1.11 repository state. It is not a fresh Phase 3a application package.

Run:

```bat
call "<EXTRACTED_V1_12_DELIVERY>\resume_phase3b_validation_after_applied_state.bat" "<REPOSITORY_ROOT>"
```

The helper byte-verifies the three copied validation files, confirms the retired case is absent and both low-level-defence comments are present, runs `git diff --check`, and reruns the complete permanent `build_1C_v1.bat` proof matrix.

## 6. Authoritative success terminus

```text
STAGE 1C_v1 FULL PROOF MATRIX COMPLETED SUCCESSFULLY
B1 B2 G1 G2 E1 E2 E3 E4 E5 E6 V1 S1 S2 S3 N1 PASS
```

W3C performed static validation and source-trace reachability review only. W3X's Windows/VS2026/Zig/VapourSynth run remains authoritative; W3D review, W3C concurrence and W3X acceptance remain required.
