# Deblock4 - Post-5C Maintenance M1 - W3C Delivery Manifest v1.0

**Scope:** `Deblock4_Scope_PostM1_v2_Commentary_Reconciliation_v1_2.md`
**Base:** committed Stage 5C tree, identity `0.1.0-dev+5C`
**Delivery:** comments-only M1 reconciliation
**Encoding:** US-ASCII; CRLF

## 1. Adds or changes

This delivery changes comments only in the two scope-authorised files:

- `src/classic_backend_v2_sse41.zig`
  - replaces only the original six-line header comment block with the ratified
    v2-specific M1-C1..C9 maintainer guide;
  - no executable statement, declaration, import, identifier, or code-body
    blank line changes.

- `src/classic_backend_v3_avx2.zig`
  - makes only the authorised K33 completion to the existing tail comment:
    names `filterHorizontalLanes(T, 1, ...)` / V1 and distinguishes it from
    the defensive scalar-column branch;
  - no other v3 comment or code is changed.

No repository file is added or removed.

## 2. Does not change

- Classic mathematics, scalar oracle, schedule, thresholds, vector body.
- v2 or v3 entry widths or target models.
- dispatch, selection, object/export linkage, build wiring, tests, batches,
  harnesses, version identity, or any identifier.
- Stage 5C source/test/proof machinery.
- The separately registered identifier-cleanup scope.

K30 identifier audit result by construction: no identifier added, removed, or
renamed.

## 3. Delivery files

Apply to repository:

- `apply_to_tree/src/classic_backend_v2_sse41.zig` -> REPLACE
  `src/classic_backend_v2_sse41.zig`
- `apply_to_tree/src/classic_backend_v3_avx2.zig` -> REPLACE
  `src/classic_backend_v3_avx2.zig`

Backout copies:

- `restore_to_base/src/classic_backend_v2_sse41.zig`
- `restore_to_base/src/classic_backend_v3_avx2.zig`

The restore copies are the exact pre-M1 bytes used to prepare this delivery.

## 4. W3X manual apply sequence

Run from the repository root in the Visual Studio 2026 x64 Developer Command
Prompt. Extract this delivery so the directory below exists, or change `M1`
to the actual extracted location.

```cmd
set "M1=C:\TEMP\Deblock4_PostM1_W3C_delivery_v1_0"
```

### 4.1 Confirm the repository is exactly the delivery's pre-M1 base

```cmd
fc /b "src\classic_backend_v2_sse41.zig" "%M1%\restore_to_base\src\classic_backend_v2_sse41.zig"
fc /b "src\classic_backend_v3_avx2.zig" "%M1%\restore_to_base\src\classic_backend_v3_avx2.zig"
```

Both commands must report no differences. If either differs, STOP and do not
copy anything.

### 4.2 Preserve the committed +5C source and binary baseline BEFORE applying M1

```cmd
if not exist "zig-out\inspection_M1" mkdir "zig-out\inspection_M1"
if not exist "zig-out\inspection_M1\base_source" mkdir "zig-out\inspection_M1\base_source"
if not exist "zig-out\inspection_M1\base_binary" mkdir "zig-out\inspection_M1\base_binary"
copy /b "src\classic_backend_v2_sse41.zig" "zig-out\inspection_M1\base_source\classic_backend_v2_sse41.zig"
copy /b "src\classic_backend_v3_avx2.zig" "zig-out\inspection_M1\base_source\classic_backend_v3_avx2.zig"
```

Build the committed Stage 5C ReleaseFast v2 inspection object and production
DLL into a dedicated prefix/cache:

```cmd
zig build classic-v2-object --prefix "zig-out\M1_base" --cache-dir ".zig-cache\M1_base" -Doptimize=ReleaseFast -Denable_force_down=false -Denable_verbose_detection=false -Denable_trace_lifecycle=false --error-style verbose
zig build --prefix "zig-out\M1_base" --cache-dir ".zig-cache\M1_base" -Doptimize=ReleaseFast -Denable_force_down=false -Denable_verbose_detection=false -Denable_trace_lifecycle=false --error-style verbose
```

Retain immutable comparison copies before touching source:

```cmd
copy /b "zig-out\M1_base\backend-objects\classic_backend_v2_sse41.obj" "zig-out\inspection_M1\base_binary\classic_backend_v2_sse41.obj"
copy /b "zig-out\M1_base\bin\Deblock4.dll" "zig-out\inspection_M1\base_binary\Deblock4.dll"
```

If either build or copy fails, STOP before applying M1.

### 4.3 Apply the two complete comment-only replacement files

```cmd
copy /y "%M1%\apply_to_tree\src\classic_backend_v2_sse41.zig" "src\classic_backend_v2_sse41.zig"
copy /y "%M1%\apply_to_tree\src\classic_backend_v3_avx2.zig" "src\classic_backend_v3_avx2.zig"
```

### 4.4 Confirm the repository now exactly matches the delivered M1 bytes

```cmd
fc /b "src\classic_backend_v2_sse41.zig" "%M1%\apply_to_tree\src\classic_backend_v2_sse41.zig"
fc /b "src\classic_backend_v3_avx2.zig" "%M1%\apply_to_tree\src\classic_backend_v3_avx2.zig"
```

Both commands must report no differences.

## 5. Manual backout

If W3X needs to return to the exact committed Stage 5C source bytes before
M1 acceptance:

```cmd
copy /y "C:\TEMP\Deblock4_PostM1_W3C_delivery_v1_0\restore_to_base\src\classic_backend_v2_sse41.zig" "src\classic_backend_v2_sse41.zig"
copy /y "C:\TEMP\Deblock4_PostM1_W3C_delivery_v1_0\restore_to_base\src\classic_backend_v3_avx2.zig" "src\classic_backend_v3_avx2.zig"
```

## 6. Ratified validation after apply

W3X owns execution. W3C makes no execution or PASS claim.

### 6.1 Build the M1 candidate in a separate prefix/cache

```cmd
zig build classic-v2-object --prefix "zig-out\M1_candidate" --cache-dir ".zig-cache\M1_candidate" -Doptimize=ReleaseFast -Denable_force_down=false -Denable_verbose_detection=false -Denable_trace_lifecycle=false --error-style verbose
zig build --prefix "zig-out\M1_candidate" --cache-dir ".zig-cache\M1_candidate" -Doptimize=ReleaseFast -Denable_force_down=false -Denable_verbose_detection=false -Denable_trace_lifecycle=false --error-style verbose
```

### 6.2 M1-T1 primary byte-inertness comparisons

```cmd
fc /b "zig-out\inspection_M1\base_binary\classic_backend_v2_sse41.obj" "zig-out\M1_candidate\backend-objects\classic_backend_v2_sse41.obj"
fc /b "zig-out\inspection_M1\base_binary\Deblock4.dll" "zig-out\M1_candidate\bin\Deblock4.dll"
```

The v2 object is the absolute byte-identity gate. The DLL is expected to be
byte-identical too; if toolchain metadata unexpectedly defeats whole-file DLL
identity, record that fact rather than weakening the object gate.

### 6.3 M1-T3 source-shape evidence

```cmd
fc /n "zig-out\inspection_M1\base_source\classic_backend_v2_sse41.zig" "src\classic_backend_v2_sse41.zig" > "zig-out\inspection_M1\v2_source_diff.txt"
fc /n "zig-out\inspection_M1\base_source\classic_backend_v3_avx2.zig" "src\classic_backend_v3_avx2.zig" > "zig-out\inspection_M1\v3_source_diff.txt"
findstr /v /b /c:"//" "zig-out\inspection_M1\base_source\classic_backend_v2_sse41.zig" > "zig-out\inspection_M1\base_v2_noncomment.txt"
findstr /v /b /c:"//" "src\classic_backend_v2_sse41.zig" > "zig-out\inspection_M1\m1_v2_noncomment.txt"
fc /b "zig-out\inspection_M1\base_v2_noncomment.txt" "zig-out\inspection_M1\m1_v2_noncomment.txt"
findstr /v /b /c:"//" "zig-out\inspection_M1\base_source\classic_backend_v3_avx2.zig" > "zig-out\inspection_M1\base_v3_noncomment.txt"
findstr /v /b /c:"//" "src\classic_backend_v3_avx2.zig" > "zig-out\inspection_M1\m1_v3_noncomment.txt"
fc /b "zig-out\inspection_M1\base_v3_noncomment.txt" "zig-out\inspection_M1\m1_v3_noncomment.txt"
```

The two non-comment `fc /b` comparisons must report no differences. Retain the
`fc /n` transcripts as the human-readable comment-only evidence.

### 6.4 M1-T2 retained matrix

Run the already-accepted Stage 5C matrix with the same W3D differential and
benchmark runner paths used for the Stage 5C acceptance run:

```cmd
build_5C_v1.bat
```

Expected acceptance evidence remains the ratified Stage 5C surface with
`OUTER_BATCH_EXIT_CODE=0`; the benchmark runs and records but is non-gating.

### 6.5 M1-T4 encoding

The standing Stage 5C S3 audit re-checks US-ASCII / CRLF. No new M1 test or
harness is added.

## 7. W3C static delivery observations

Without running Zig, VapourSynth, the Stage 5C matrix, or the benchmark, W3C
checked the prepared delivery mechanically:

- only the two authorised repository paths appear under `apply_to_tree/`;
- both replacement files are US-ASCII with CRLF;
- removing column-zero `//` comment lines from base and candidate yields
  byte-identical projections for BOTH files;
- from `const std = @import("std");` to end-of-file, the v2 base and candidate
  are byte-identical;
- from `const std = @import("std");` to end-of-file, the v3 base and candidate
  are byte-identical;
- no identifier was added, removed, or renamed in executable source.

These are static preparation observations only, not project validation/PASS.
