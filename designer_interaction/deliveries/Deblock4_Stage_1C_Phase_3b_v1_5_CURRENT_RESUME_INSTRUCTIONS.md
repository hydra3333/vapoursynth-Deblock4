# Deblock4 Stage 1C Phase 3b v1.5 - Current W3X Resume Instructions

`Deblock4_Stage_1C_Phase_3b_W3C_delivery_v1_5.zip` supersedes Phase 3b deliveries v1.0 through v1.4.

The current repository already has the Phase 3b source and deletion set applied. Do not reset it and do not call the fresh-apply helper.

Extract v1.5 outside the repository, then run:

```bat
call "E:\SOFTWARE-Win11\MULTIMEDIA\vapoursynth-Deblock4\TEMP\Deblock4_Stage_1C_Phase_3b_W3C_delivery_v1_5\resume_phase3b_validation_after_applied_state.bat" "E:\SOFTWARE-Win11\MULTIMEDIA\vapoursynth-Deblock4\github\vapoursynth-Deblock4"
```

The helper verifies the applied Phase 3b shape, installs the v1.5 `build_1C_v1.bat` byte-for-byte, runs `git diff --check`, and starts the complete proof matrix.

The v1.5 runner prints the post-Visual-Studio project/cache/build/inspection paths, then explicit cleanup and static-audit boundaries. Stop only at an actual nonzero step or a `STAGE 1C_v1 VALIDATION COMMAND SET FAIL` banner.

Authoritative success terminus:

```text
STAGE 1C_v1 FULL PROOF MATRIX COMPLETED SUCCESSFULLY
B1 B2 G1 G2 E1 E2 E3 E4 E5 E6 V1 S1 S2 S3 N1 PASS
```

After success:

```bat
git -c core.whitespace=cr-at-eol diff --check
git status --short
```

Do not commit `.zig-cache`, `zig-out`, delivery ZIPs, delivery patches, or temporary `build_1C_v1_PHASE3B_*` files.
