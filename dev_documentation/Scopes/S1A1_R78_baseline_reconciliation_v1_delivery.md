# Deblock4 - Stage 1A.1 Delivery Manifest

**Delivery:** `S1A1_R78_baseline_reconciliation_v1.patch`
**Scope:** Stage 1A.1 - R78 baseline reconciliation
**Scope document:** `Deblock4_Scope_Stage_1A1_R78_Baseline_Reconciliation_v1_1.md`
**Repository:** `https://github.com/hydra3333/vapoursynth-Deblock4`
**Branch:** `main`
**Exact starting commit:** `81b04e8ce1522ddd443102b4b8e5bb9db57c7771`
**Encoding:** US-ASCII
**Line endings:** LF

---

# Adds or changes

- Reconciles the two direct VSHelper4 compatibility-wrapper names to the
  ratified `zig_vsh_` plus exact-original-name convention.
- Reconciles the Deblock4-native bridge self-test declaration to
  `deblock4_vsh_bridge_self_test`.
- Adds the two C-INT-04 wrapper comments required at the C compatibility
  boundary.
- Replaces stale R76 wording with the current R78 vendored-header baseline
  while preserving the explicit API 4.2 pin through `VS_USE_API_42`.
- Updates the Zig header probe to require the reconciled wrapper symbols.

# Defers or does not change

- No `build.zig` or `build.zig.zon` change.
- No third-party header change.
- No DLL-probe, build-probe, smoke-test, VS Code, or documentation change.
- No pixel, frame, copy, deblocking, backend-isolation, capability-detection,
  dispatch, feature-closure, SIMD, or quality work.
- The VSHelper4.h C-ABI bridge architecture is unchanged.

# Files

```text
src/vapoursynth_api4.h
    state       existing
    delivery    unified-diff patch
    reason      two small localised edits

src/vapoursynth_helper_bridge.c
    state       existing
    delivery    unified-diff patch
    reason      localised symbol reconciliation plus two required comments

src/vapoursynth_header_probe.zig
    state       existing
    delivery    unified-diff patch
    reason      two localised declaration-name checks
```

All other files are forbidden for this scope.

# Principal pre-application anchors

The patch is prepared against exact commit:

```text
81b04e8ce1522ddd443102b4b8e5bb9db57c7771
```

Confirm these anchors before application.

## `src/vapoursynth_api4.h`

```c
/*
 * Deblock4 targets VapourSynth API 4.2 as supplied with R76+.
 *
 * Pin the required API explicitly. VS_USE_LATEST_API is intentionally not
 * used because updating the copied headers must not silently change the API
 * contract compiled into the plugin.
 */
```

```c
/* Deblock4-specific validation of the helper bridge. */
int deblock4_vsh_bridgeSelfTest(void);
```

## `src/vapoursynth_helper_bridge.c`

```c
int deblock4_vsh_is_constant_video_format(const VSVideoInfo *vi) {
    return vsh_isConstantVideoFormat(vi);
}
```

```c
int deblock4_vsh_are_valid_dimensions(
    const VSVideoFormat *format,
    int width,
    int height
) {
    return vsh_areValidDimensions(format, width, height);
}
```

## `src/vapoursynth_header_probe.zig`

```zig
if (!@hasDecl(vs, "deblock4_vsh_is_constant_video_format"))
    @compileError("VSHelper4.h bridge lacks format helper");

if (!@hasDecl(vs, "deblock4_vsh_are_valid_dimensions"))
    @compileError("VSHelper4.h bridge lacks dimension helper");
```

A missing, changed, duplicated where uniqueness matters, or otherwise
unverifiable anchor means the patch is not applied or hand-edited. Report the
mismatch and request a replacement prepared against the actual source.

# Apply sequence

Run from the repository root:

```bat
git status --short
git branch --show-current
git rev-parse HEAD

git apply --check S1A1_R78_baseline_reconciliation_v1.patch
git apply --check --whitespace=error S1A1_R78_baseline_reconciliation_v1.patch
git apply S1A1_R78_baseline_reconciliation_v1.patch

git diff --check
git status --short
```

Required pre-application results:

```text
git status --short
    no output

git branch --show-current
    main

git rev-parse HEAD
    81b04e8ce1522ddd443102b4b8e5bb9db57c7771
```

Required post-application changed files only:

```text
 M src/vapoursynth_api4.h
 M src/vapoursynth_header_probe.zig
 M src/vapoursynth_helper_bridge.c
```

# Validation run by W3X

For each `MODE` in `Debug`, `ReleaseSafe`, and `ReleaseFast`, run in this order:

```bat
zig build -Doptimize=<MODE>
zig build run -Doptimize=<MODE>
zig build vs-header-run -Doptimize=<MODE>
zig build test -Doptimize=<MODE>
zig-out\bin\deblock4_dll_smoke_test.exe
```

After all three modes:

```bat
git diff --check
git status --short
```

Expected runtime evidence:

```text
Deblock4 Zig 0.16.0 build probe: PASS

Deblock4 VapourSynth headers probe: PASS
(API 4.2; core/constants translated; helpers compiled as C)

Deblock4 DLL smoke test: PASS (value 0x44423401)
```

The bridge self-test returns 7 internally; a non-7 result fails the header
probe. `zig build test` passes in all three modes.

W3X reports for every required command:

- exact command;
- build mode;
- process exit code;
- concise PASS, FAIL, or SKIP result;
- first failure and relevant surrounding output if not PASS;
- final `git status --short`.

# Sandbox validation performed by W3C

Validated against the supplied GitHub source archive corresponding to the
reported clean `main` baseline:

```text
git apply --check                         PASS
git apply --check --whitespace=error      PASS
git diff --check after application        PASS
US-ASCII patch and changed files          PASS
LF-only patch and changed files           PASS
changed-file boundary                     PASS (three permitted files only)
post-apply symbol reconciliation checks   PASS
host C syntax-only supplemental check     PASS
```

Zig 0.16.0 is not installed in the W3C validation environment, so the required
Zig builds and runtime probes remain for W3X. Sandbox inspection is not project
PASS.

Patch SHA-256, for transfer checking only:

```text
97219088c973b7783d5f7ff708a3d90c69cebdd76a99c0b7a1dabce3729c36f3
```

# Review notes

The principal enforcement points are:

- C-INT-04 at both project-authored compatibility-wrapper definitions;
- the explicit `VS_USE_API_42` pin and R78 wording in
  `src/vapoursynth_api4.h`;
- the compile-time `@hasDecl` checks in
  `src/vapoursynth_header_probe.zig`.

The delivery is ready for W3D review and, after approval, W3X application and
local validation.
