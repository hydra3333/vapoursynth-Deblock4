# Stage 1C Phase 3b v1.4 - Apply, Resume and Validate

This v1.4 package supersedes every earlier Phase 3b delivery (`v1.0`, `v1.1`, `v1.2` and `v1.3`). Use only v1.4.

The project source, deletion set, `.vpy` harnesses and proof obligations are unchanged from v1.0. v1.4 retains the permanent proof-runner corrections and also fixes the recovery helper:

1. the parent launches the `--worker` child without the broken outer `/C` quote wrapper;
2. every directory-change operation uses the quote-safe `%~dp0.` project root rather than the trailing-backslash path prefix;
3. the resume helper no longer requires an old `build_1C_v1.bat` to exist before installing the corrected production runner. It verifies the rest of the applied Phase 3b shape, then installs and byte-checks the runner.

The Visual Studio handoff remains the proven:

```text
-arch=amd64 -host_arch=amd64
```

## A. Fresh application from the accepted clean Phase 3a repository

Extract this delivery outside the repository. From any command prompt, run:

```bat
call "<EXTRACTED_V1_4_DELIVERY>\apply_phase3b_and_validate.bat" "<REPOSITORY_ROOT>"
```

The helper is fail-closed. It verifies branch `main` and a clean Phase 3a working tree, checks and applies the deletion-only patch, copies every complete repository file, runs `git -c core.whitespace=cr-at-eol diff --check`, and then runs `build_1C_v1.bat`.

Do not use this fresh-application command on a repository where Phase 3b has already been applied.

## B. W3X's current repository: Phase 3b already applied, validation stopped in the old runner

Do **not** reset the repository and do **not** rerun the apply helper.

Extract v1.4 outside the repository, then run:

```bat
call "<EXTRACTED_V1_4_DELIVERY>\resume_phase3b_validation_after_applied_state.bat" "<REPOSITORY_ROOT>"
```

The resume helper verifies the applied Phase 3b shape, installs or overwrites only the repository's `build_1C_v1.bat` with the v1.4 production runner, runs `git diff --check`, and starts the complete proof matrix.

Before committing, delete any temporary loose fix downloads accidentally placed in the repository root, including:

```text
build_1C_v1_PHASE3B_VSDEVCMD_FIX.bat
build_1C_v1_PHASE3B_VSDEVCMD_PROJECTDIR_FIX.bat
```

Those names are not repository deliverables.

## Expected success

The proof runner must exit zero and print:

```text
STAGE 1C_v1 FULL PROOF MATRIX COMPLETED SUCCESSFULLY
B1 B2 G1 G2 E1 E2 E3 E4 E5 E6 V1 S1 S2 S3 N1 PASS
```

Evidence is retained under `zig-out\inspection_1C`. W3D independently reviews the raw binaries, exports, disassembly, e2e output/properties, lifecycle traces, sweep and S1 evidence. The batch does not self-accept Stage 1C.

A `failed command: ... --listen=-` line is not by itself a failure. Use the child/outer exit codes, Zig summary assertions, the diagnostic index and the explicit success terminus.

## Commit hygiene after acceptance

Commit the eleven added/replaced repository paths and thirteen deletions only. Do not commit `zig-out`, `.zig-cache`, extracted delivery files, loose fix runners, or the deletion patch. The P4 table is a delivery-review artifact unless W3X separately directs its repository placement.
