# Stage 1C Phase 3b v1.8 - Current W3X Repair/Resume Instructions

The v1.7 delivery ZIP was self-contained, but its resume helper was not: it required both `.vpy` harnesses to pre-exist and installed only five files. v1.8 corrects that defect.

Do not reset the repository. Extract `Deblock4_Stage_1C_Phase_3b_W3C_delivery_v1_8.zip` outside the repository, then run:

```bat
call "E:\SOFTWARE-Win11\MULTIMEDIA\vapoursynth-Deblock4\TEMP\Deblock4_Stage_1C_Phase_3b_W3C_delivery_v1_8\resume_phase3b_validation_after_applied_state.bat" "E:\SOFTWARE-Win11\MULTIMEDIA\vapoursynth-Deblock4\github\vapoursynth-Deblock4"
```

The helper installs and byte-verifies all fifteen repository files under `full_files`, including both `.vpy` harnesses, all four headers, `tools\run_vs.cmd`, the four audit scripts, the build files and the selftest.

For the retirement set it accepts either:

```text
all thirteen old scaffolding files present  -> check and apply the deletion patch
all thirteen old scaffolding files absent   -> treat deletion set as already applied
```

Any mixed retirement state fails closed for inspection.

It then removes only exact superseded recovery artifacts, runs `git -c core.whitespace=cr-at-eol diff --check`, and starts the complete proof matrix.

The authoritative success terminus is:

```text
STAGE 1C_v1 FULL PROOF MATRIX COMPLETED SUCCESSFULLY
B1 B2 G1 G2 E1 E2 E3 E4 E5 E6 V1 S1 S2 S3 N1 PASS
```

At the first explicit fail banner or nonzero outer exit code, stop and preserve the complete transcript under `zig-out\inspection_1C`.
