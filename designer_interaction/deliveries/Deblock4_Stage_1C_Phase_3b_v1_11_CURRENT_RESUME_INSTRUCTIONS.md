# W3X Current-State Resume - Phase 3b v1.11

## Current repository assumption

Phase 3b v1.10 is already applied. The previous run proved all gates through the Deblock4 midpoint cases and failed only because the retired `error_wrong_type` harness case expected plugin-level rejection after VapourSynth had already coerced `strength=1.5` to integer `1`.

Do not reset the repository and do not rerun any earlier Phase 3b apply or repair helper.

## Command

```bat
call "E:\SOFTWARE-Win11\MULTIMEDIA\vapoursynth-Deblock4\TEMP\Deblock4_Stage_1C_Phase_3b_W3C_delivery_v1_11\resume_phase3b_validation_after_applied_state.bat" "E:\SOFTWARE-Win11\MULTIMEDIA\vapoursynth-Deblock4\github\vapoursynth-Deblock4"
```

## Files changed by the helper

Exactly three:

```text
build_1C_v1.bat
tests\stage_1c_classic_passthrough.vpy
tests\stage_1c_deblock4_passthrough.vpy
```

No production code or W3X-owned file is copied or normalised. Stage 1C.1 work is not included.

Before the new proof run, the helper preserves the existing local v1.10 full transcript under:

```text
zig-out\inspection_1C_v1_10_partial_evidence
```

when that transcript is still present and has not already been preserved. The transcript already supplied to W3C/W3D remains valid partial evidence regardless.

## Required final success text

```text
STAGE 1C_v1 FULL PROOF MATRIX COMPLETED SUCCESSFULLY
B1 B2 G1 G2 E1 E2 E3 E4 E5 E6 V1 S1 S2 S3 N1 PASS
```

Preserve the complete v1.11 transcript and `zig-out\inspection_1C` for review.
