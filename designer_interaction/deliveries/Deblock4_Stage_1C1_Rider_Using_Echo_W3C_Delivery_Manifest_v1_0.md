# Deblock4 - Stage 1C.1 Rider Using Echo W3C Delivery Manifest

**Version:** 1.0  
**Date:** 2026-08-02  
**Author:** W3C  
**Scope:** `Deblock4_Scope_Stage_1C1_Rider_Using_Echo_v1_1.md`  
**Repository / branch:** `vapoursynth-Deblock4` / `main`  
**Encoding:** US-ASCII; CRLF.

## 1. Objective

Implement the ratified Stage 1C.1 effective-invocation echo: build one immutable
resolved call string at successful instance creation, emit it once as the
release-visible `deblock4: using ...` line, and attach the identical bytes to
every output frame as `Deblock4Using`.

## 2. Exact base

Prepared against the accepted Stage 1C source state after Phase 3b delivery
v1.13 was validated, committed, and pushed. The exact attached-source
reconstruction used by W3C is:

```text
src(43).zip production tree
+ accepted Deblock4_Stage_1C_Phase_3b_W3C_delivery_v1_13.zip three-file correction
+ byte-identical v1.12 build_1C_v1.bat and two Stage 1C .vpy harnesses
```

No repository commit id was supplied. The apply helper therefore fails closed
on these exact accepted-base SHA-256 values:

- `build.zig`: `616bcae1a330b3b076754fedf570c78bb40f921c0f9f7775978115b547a3201f`
- `build_1C_v1.bat`: `6220356fbe842e1b86372779fb6a4c455b63f24b1920502fe5961abc753b8332`
- `src/classic_frame_properties.zig`: `5a03db0f7ef82244a80c77c29d2912036538a9a1f8b880b7bc490658d044e5ad`
- `src/classic_instance_creation.zig`: `cee6d3ab37dd27be2959ea278ea93184e04deb0309f40a6634760b46a2649af5`
- `src/classic_instance_data.zig`: `382a4c87b85bbc71acbeb7bb7f1741c777ecfc7b56caf0a8cf8bf6e4b602f56e`
- `src/deblock4_frame_properties.zig`: `a72ed0189839a0b46a8c200325cd43a2da73d0ce3c7247e45760e22233e81999`
- `src/deblock4_instance_creation.zig`: `733919e0c8778ec4456983bfced80d5feb5bebb1d49a20bd514d0c1a3608db70`
- `src/deblock4_instance_data.zig`: `6b33ce7c83bdb790ced16ec560686af26e7cd7c4429d9ef58b18a11c84a15897`
- `src/print_helper_functions.zig`: `a30ab4a0912c0a7891662bdfed5d0b424c8641b91a1cf76cfad787d4ee84a77d`
- `tests/stage_1c_classic_passthrough.vpy`: `7b3aed83b0ca65b8b77a0a021c0be3abfb7091725b800a7fdb96c1ea7733a33a`
- `tests/stage_1c_deblock4_passthrough.vpy`: `3bdbf2934035659587dc2a6c85b45c2d5077ca5883263e19bb074fff17b6a5fb`

## 3. Adds or changes

- Adds a pure fixed-capacity `effective_invocation_text` value and formatter.
- Expands default planes to the validated source plane count and preserves
  canonical explicit plane ordering.
- Stores one completed value by copy in each immutable instance.
- Emits `deblock4: using {stored bytes}` after validation, tier selection and
  allocation, immediately before `createVideoFilter`.
- Writes `Deblock4Using` from the same stored bytes on every output frame.
- Adds an explicit pure test target covering all binding rider literals,
  default-plane expansion and the fixed-capacity bound.
- Adds the adopted Classic `valid_coercion` runtime case.
- Adds only the authorised runner checks: one using line per successful case
  and no using line in every captured failed-creation transcript.

## 4. Defers or does not change

- Existing version-summary bytes and assertions.
- Parameter registration, extraction, validation and exact creation errors.
- ACTUAL/EFFECTIVE detection, tier selection and backend dispatch.
- Callback-router structure and C5 frame ordering.
- Frame pixels and all Stage 2C/2D algorithm work.
- G10 imports, markers, gates and export checks.
- Existing error-case set other than the adopted using-line absence assertion.
- Documentation generation and the deferred Toolchain Findings update.

## 5. Files and delivery forms

| Path | State | Delivery form |
|---|---|---|
| `build.zig` | existing | unified diff `Deblock4_Stage_1C1_Rider_Using_Echo_existing_files_v1.patch` |
| `build_1C_v1.bat` | existing | unified diff `Deblock4_Stage_1C1_Rider_Using_Echo_existing_files_v1.patch` |
| `src/classic_frame_properties.zig` | existing | unified diff `Deblock4_Stage_1C1_Rider_Using_Echo_existing_files_v1.patch` |
| `src/classic_instance_creation.zig` | existing | unified diff `Deblock4_Stage_1C1_Rider_Using_Echo_existing_files_v1.patch` |
| `src/classic_instance_data.zig` | existing | unified diff `Deblock4_Stage_1C1_Rider_Using_Echo_existing_files_v1.patch` |
| `src/deblock4_frame_properties.zig` | existing | unified diff `Deblock4_Stage_1C1_Rider_Using_Echo_existing_files_v1.patch` |
| `src/deblock4_instance_creation.zig` | existing | unified diff `Deblock4_Stage_1C1_Rider_Using_Echo_existing_files_v1.patch` |
| `src/deblock4_instance_data.zig` | existing | unified diff `Deblock4_Stage_1C1_Rider_Using_Echo_existing_files_v1.patch` |
| `src/print_helper_functions.zig` | existing | unified diff `Deblock4_Stage_1C1_Rider_Using_Echo_existing_files_v1.patch` |
| `tests/stage_1c_classic_passthrough.vpy` | existing | unified diff `Deblock4_Stage_1C1_Rider_Using_Echo_existing_files_v1.patch` |
| `tests/stage_1c_deblock4_passthrough.vpy` | existing | unified diff `Deblock4_Stage_1C1_Rider_Using_Echo_existing_files_v1.patch` |
| `src/effective_invocation_text.zig` | new | complete file under `new_files/src/` |

No file is supplied simultaneously as both a patch and replacement.

## 6. Principal invariant points

1. `Value` owns a `[512]u8` buffer plus explicit length; there is no secondary
   allocation or free-path change.
2. The formatter consumes validated post-coercion/post-defaulting parameters.
3. Both public surfaces consume `instance.using_text.slice()`; line/property
   identity is structural, not duplicated formatting.
4. Emission occurs only after instance allocation and immediately before the
   existing wrapper call. Earlier error returns cannot emit a using line.
5. The existing one-line summary implementation is byte-untouched.
6. Preset-grid raw custom members are `absent`; custom members retain their
   resolved values; backend remains the request token.

## 7. Apply and validation

Extract the delivery directory under W3X's TEMP directory and run from any
command prompt:

```bat
call "FULL_PATH\Deblock4_Stage_1C1_Rider_Using_Echo_W3C_delivery_v1_0\apply_and_validate_stage_1c1_using_echo_v1_0.bat" "E:\SOFTWARE-Win11\MULTIMEDIA\vapoursynth-Deblock4\github\vapoursynth-Deblock4"
```

The helper:

1. verifies branch `main`, exact accepted-base hashes and absence of the new file;
2. runs both required `git apply --check` gates;
3. applies the existing-file patch and installs the complete new file;
4. verifies every final file hash and key rider anchors;
5. runs `git diff --check`;
6. runs the unchanged standing `build_1C_v1.bat` full matrix;
7. copies the matrix transcript and summary into
   `W3X_validation_artifacts` when present;
8. reports final `git status --short`.

## 8. Expected authoritative results

- Debug, ReleaseSafe and ReleaseFast production builds: PASS.
- Complete unit-test suite: all reported steps/tests PASS. The new explicit
  pure target is expected to increase the aggregate test count; no exact count
  is used as an acceptance shortcut.
- Classic `valid_auto`, `valid_full`, and new `valid_coercion`: PASS.
- All four Deblock4 valid cases: PASS.
- Every valid case: exact `Deblock4Using` property equality and exactly one
  `deblock4: using ` line.
- Every captured error case: exact existing error and no using line.
- Existing version-summary assertions: unchanged PASS.
- All fifteen standing gates:

```text
B1 B2 G1 G2 E1 E2 E3 E4 E5 E6 V1 S1 S2 S3 N1 PASS
STAGE 1C_v1 FULL PROOF MATRIX COMPLETED SUCCESSFULLY
OUTER_BATCH_EXIT_CODE=0
```

Only W3X's Windows run establishes project PASS.

## 9. W3C static validation

Completed in the available sandbox:

- exact v1.1 literal comparison for all seven binding valid cases: PASS;
- Python syntax compilation for both `.vpy` harnesses: PASS;
- expected changed-file set only: PASS;
- US-ASCII and CRLF on all delivered repository text: PASS;
- patch `git apply --check`: PASS;
- patch `git apply --check --whitespace=error` with `cr-at-eol`: PASS;
- integrated `git diff --check`: PASS;
- byte comparison of reconstructed application against W3C working result: PASS;
- package SHA-256 and ZIP integrity: performed during packaging.

Not claimed by W3C: Zig compile/test execution, VapourSynth runtime, stderr
counting, frame-property observation, dumpbin evidence, or the fifteen-gate
matrix. Those remain W3X-authoritative.

## 10. Final integrated SHA-256 values

- `build.zig`: `d25e1920ff3664bcf3156e353fd3da1c51ea141bfa8391f957143ceee13978ca`
- `build_1C_v1.bat`: `d37ec0e0755574d7f5f023ad4656cf637b34108854c23d24a3e9e47e8f90ee39`
- `src/classic_frame_properties.zig`: `d6ca49b3a74f1488d96412ade8f6dbc5526004c62f564bd0bbbbf2b929a207e5`
- `src/classic_instance_creation.zig`: `8baf6922bee9aa151d36d41b4bd5d595dac226133a6861baa06a8e84f84307ca`
- `src/classic_instance_data.zig`: `aface41404d2b7ea7a0b767f09b10069bcc80f17fc3ccb52d7614423da0d93fd`
- `src/deblock4_frame_properties.zig`: `e27c1d019fb21a9de756dcc9b391b6b2992007b3f1d37af5cb48909a5bdfd114`
- `src/deblock4_instance_creation.zig`: `d4aa6e0c4c9295a7955d90e4ce0ad1e1a83f5758efad231f5bf64c8672f925fb`
- `src/deblock4_instance_data.zig`: `8db168f00708ccdf04ce12f757a94202ed27219f84a24016f3f2f793e07de34c`
- `src/print_helper_functions.zig`: `2db78f6c6d91c419da7e16e6928e385978e481ec4efced3ee64e8e0203ae57c9`
- `tests/stage_1c_classic_passthrough.vpy`: `4559a62fc0f20f9affc43835f783cdc604ab65b2653f5278b57fdb18f5d33ddd`
- `tests/stage_1c_deblock4_passthrough.vpy`: `aca4b20f1a7d3b68052994d748915c54168282ccdf8e4781470eaea6d8900c7e`
- `src/effective_invocation_text.zig`: `4cb12f1e0386c7d1039ac1ac23d152592f98b2d17d880c3d1ffa07743aee7bde`

## 11. Review note

The source uses `std.fmt.bufPrint` only for bounded scalar formatting into the
owned fixed buffer; no I/O interface or allocation is introduced there. The
same stored bytes are printed and attached as the property.
