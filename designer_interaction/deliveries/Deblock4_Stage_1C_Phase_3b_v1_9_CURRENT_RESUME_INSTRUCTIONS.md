# Stage 1C Phase 3b v1.9 - Current W3X Resume Instructions

v1.9 implements the W3D section 2.3b ruling for S3. It changes exactly:

```text
tools\audit_stage_1c_s3_eol.ps1
```

It does not copy, delete or normalise any other repository file. The five currently identified W3X-owned files are not overwritten.

Extract the v1.9 ZIP outside the repository, then run:

```bat
call "E:\SOFTWARE-Win11\MULTIMEDIA\vapoursynth-Deblock4\TEMP\Deblock4_Stage_1C_Phase_3b_W3C_delivery_v1_9\resume_phase3b_validation_after_applied_state.bat" "E:\SOFTWARE-Win11\MULTIMEDIA\vapoursynth-Deblock4\github\vapoursynth-Deblock4"
```

The helper:

1. verifies branch `main` and the existing v1.8 Phase 3b validation surface;
2. copies and byte-verifies only the corrected S3 script;
3. runs `git -c core.whitespace=cr-at-eol diff --check`;
4. reruns the complete permanent Stage 1C proof matrix;
5. prints final repository status.

The bounded S3 domain is the three root build files plus all text files under `src/`, `tests/`, `tools/` and `third_party/`. Historical documentation, archives, editor metadata and W3X-owned root files are outside this gate. W3X-owned files inside `tools/` or `third_party/` are audited read-only and are not rewritten.

The authoritative success terminus is:

```text
STAGE 1C_v1 FULL PROOF MATRIX COMPLETED SUCCESSFULLY
B1 B2 G1 G2 E1 E2 E3 E4 E5 E6 V1 S1 S2 S3 N1 PASS
```
