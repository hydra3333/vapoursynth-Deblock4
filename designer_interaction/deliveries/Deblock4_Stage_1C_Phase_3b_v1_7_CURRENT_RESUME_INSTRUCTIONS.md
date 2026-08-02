# Stage 1C Phase 3b v1.7 - Current W3X Resume Instructions

Your repository already contains the Phase 3b source/deletion state. Do not reset it and do not run the fresh apply helper.

Extract `Deblock4_Stage_1C_Phase_3b_W3C_delivery_v1_7.zip` outside the repository, then run:

```bat
call "E:\SOFTWARE-Win11\MULTIMEDIA\vapoursynth-Deblock4\TEMP\Deblock4_Stage_1C_Phase_3b_W3C_delivery_v1_7\resume_phase3b_validation_after_applied_state.bat" "E:\SOFTWARE-Win11\MULTIMEDIA\vapoursynth-Deblock4\github\vapoursynth-Deblock4"
```

The resume helper installs and byte-verifies only:

```text
build_1C_v1.bat
tools\audit_stage_1c_s1_structure.ps1
tools\audit_stage_1c_g10_imports.ps1
tools\audit_stage_1c_s2_sweep.ps1
tools\audit_stage_1c_s3_eol.ps1
```

It removes `tools\stage_1c_proof_helpers.ps1` if an earlier v1.6 attempt installed it, runs `git -c core.whitespace=cr-at-eol diff --check`, and starts the full matrix. It does not reapply the Phase 3b deletion patch.

The authoritative success terminus is:

```text
STAGE 1C_v1 FULL PROOF MATRIX COMPLETED SUCCESSFULLY
B1 B2 G1 G2 E1 E2 E3 E4 E5 E6 V1 S1 S2 S3 N1 PASS
```

At the first explicit fail banner or nonzero outer exit code, stop and preserve the complete transcript under `zig-out\inspection_1C`.
