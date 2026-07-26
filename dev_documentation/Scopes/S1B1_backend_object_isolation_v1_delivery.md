# Deblock4 Stage 1B.1 delivery manifest

**Delivery:** `S1B1_backend_object_isolation_v1`
**Active scope:** `Deblock4_Scope_Stage_1B1_Backend_Object_Isolation_v1_2.md`
**Repository:** `https://github.com/hydra3333/vapoursynth-Deblock4`
**Branch:** `main`
**Required starting commit:** `8b6779c4d39d96622825e0454e1cc23974de4a9a`
**Encoding:** US-ASCII; LF line endings

## 1. Delivery form

The controlling scope requires a mixed delivery:

| Repository file | State | Delivery form |
|---|---|---|
| `build.zig` | existing | anchor-verifiable unified-diff patch |
| `src/backend_probe_generic.zig` | new | complete whole file |
| `src/backend_probe_scalar.zig` | new | complete whole file |
| `src/backend_probe_sse41.zig` | new | complete whole file |
| `src/backend_probe_avx2.zig` | new | complete whole file |
| `src/backend_isolation_smoke_test.zig` | new | complete whole file |

The retained phase patch is:

```text
S1B1_backend_object_isolation_v1.patch
```

It changes `build.zig` only. The five new source files are supplied under `src/` as complete files.

## 2. What this delivery adds

- Rejects `-Dtarget` and `-Dcpu` overrides instead of allowing a native-host baseline.
- Defines explicit provisional `x86_64-windows-msvc` target contracts:
  - baseline: no SSE4.1, AVX, AVX2, or FMA;
  - SSE4.1 probe: SSE4.1 present; AVX, AVX2, and FMA absent;
  - AVX2 probe: AVX and AVX2 present; FMA absent.
- Moves the existing DLL root, existing probes/tests, generic probe, scalar probe, and both smoke tests to the fixed baseline target.
- Builds four separate backend object files with `b.addObject` and links them into the existing `Deblock4.dll`.
- Exports only the safe generic and scalar identity markers for the baseline smoke test.
- Suppresses PE export metadata for the SSE4.1 and AVX2 marker functions.
- Retains the two target-specific marker functions with `dll.forceUndefinedSymbol()` and no call, pointer-table, registration, startup, or static-initialisation path.
- Installs stable object copies for DUMPBIN inspection:

```text
zig-out\obj\backend_probe_generic.obj
zig-out\obj\backend_probe_scalar.obj
zig-out\obj\backend_probe_sse41.obj
zig-out\obj\backend_probe_avx2.obj
```

- Adds the baseline-only smoke executable:

```text
zig-out\bin\deblock4_backend_isolation_smoke_test.exe
```

Expected successful output:

```text
Deblock4 backend isolation smoke test: PASS (generic 0x44424701, scalar 0x44425301)
```

## 3. Structural G5 proof embodied by the source

Target-specific definitions:

```text
deblock4_backend_probe_sse41_marker
deblock4_backend_probe_avx2_marker
```

The only repository references to those names are:

1. their definitions in their own target-specific source files; and
2. the string names passed to `dll.forceUndefinedSymbol()` in `build.zig`.

There is no source-level call, import, external declaration, pointer table, startup hook, registration path, test call, or static initialiser referencing either target-specific marker.

`src/backend_isolation_smoke_test.zig` declares and calls only:

```text
deblock4_backend_probe_generic_marker
deblock4_backend_probe_scalar_marker
```

The Windows acceptance gate remains mandatory: W3X must use DUMPBIN to prove the target-specific marker functions are present in the installed objects and absent from the DLL export table.

## 4. Explicitly deferred

This delivery does not add or prove:

- pixel or deblocking code;
- VapourSynth frame processing;
- CPU/OS capability detection;
- guarded execution or final dispatch;
- final feature closures;
- vector widths or lane layouts;
- emitted SSE4.1/AVX2 instruction forms;
- FMA exclusion by assembly inspection.

Those remain Stage 1B.2 or Stage 1B.3 obligations.

## 5. Static validation completed by W3C

Against the supplied post-Stage-1A.1 source snapshot:

```text
git apply --check                                      PASS
git apply --check --whitespace=error                   PASS
git diff --check after patch + whole-file placement    PASS
changed-file boundary                                  PASS
US-ASCII                                                PASS
LF-only line endings                                    PASS
final newline                                           PASS
no trailing spaces/tabs                                 PASS
no target-marker reference outside build/definitions   PASS
smoke test declares generic/scalar markers only         PASS
```

The static review also confirmed:

```text
backend_probe_sse41.dll_export_fns = false
backend_probe_avx2.dll_export_fns = false
dll.forceUndefinedSymbol(sse41_marker_symbol)
dll.forceUndefinedSymbol(avx2_marker_symbol)
```

## 6. Validation limitation

No Zig executable is installed in W3C's container. Therefore W3C does **not** claim that this delivery has compiled, linked, run, produced the expected PE exports, or passed DUMPBIN inspection.

The Zig 0.16.0 build API and source were checked for the proposed mechanisms, but only W3X's native Windows Zig 0.16.0 build and DUMPBIN results can establish PASS.

## 7. W3D cold-review sequence

The patch and whole files should be reviewed against an actual clean checkout at the required commit. Do not hand-edit a failed patch.

```bat
CD /D "E:\SOFTWARE-Win11\MULTIMEDIA\vapoursynth-Deblock4\github\vapoursynth-Deblock4"

git status --short
git branch --show-current
git rev-parse HEAD

git apply --check "<DELIVERY_DIR>\S1B1_backend_object_isolation_v1.patch"
git apply --check --whitespace=error "<DELIVERY_DIR>\S1B1_backend_object_isolation_v1.patch"
git apply "<DELIVERY_DIR>\S1B1_backend_object_isolation_v1.patch"

COPY /Y "<DELIVERY_DIR>\src\backend_probe_generic.zig" "src\backend_probe_generic.zig"
COPY /Y "<DELIVERY_DIR>\src\backend_probe_scalar.zig" "src\backend_probe_scalar.zig"
COPY /Y "<DELIVERY_DIR>\src\backend_probe_sse41.zig" "src\backend_probe_sse41.zig"
COPY /Y "<DELIVERY_DIR>\src\backend_probe_avx2.zig" "src\backend_probe_avx2.zig"
COPY /Y "<DELIVERY_DIR>\src\backend_isolation_smoke_test.zig" "src\backend_isolation_smoke_test.zig"

git diff --check
git status --short
```

Expected implementation-file status:

```text
 M build.zig
?? src/backend_isolation_smoke_test.zig
?? src/backend_probe_avx2.zig
?? src/backend_probe_generic.zig
?? src/backend_probe_scalar.zig
?? src/backend_probe_sse41.zig
```

The retained phase patch and `build_1B1.bat` form the two additional permitted non-source artifact buckets.

## 8. Post-acceptance batch step

Per scope section 7, W3C has deliberately not issued the final `build_1B1.bat` body changes with this delivery. After W3D accepts the implementation, W3C will provide W3X the exact per-mode backend-smoke commands, negative override checks, ReleaseFast DUMPBIN commands, output capture/checks, and expected results.

## 9. SHA-256

```text
db1b97fc4ca28372e19e3a4a608425fcbc4f94fd19dcf7ea32140f822d852f89  S1B1_backend_object_isolation_v1.patch
7caeb580f1318607563779cdbe6ef281a76808092d1550a57120b28b45a3f3ed  src/backend_isolation_smoke_test.zig
6c8730f2883f0047a0a16bd81da1b28a79b02f235a05a0c5cbe9df4eb9b9eb45  src/backend_probe_avx2.zig
e6ae4af87a93feb114d153a6fa8499166144672eb6b48f19c4ce3960a449dae5  src/backend_probe_generic.zig
493e176401d3458b313d1e0a27c49c6d55e351a8986803f2f8ff5a0fdace6c26  src/backend_probe_scalar.zig
5606e1d3182b590e2a5f26b68ff9d14dff946b3076f87cb388f60d737b990034  src/backend_probe_sse41.zig
```
