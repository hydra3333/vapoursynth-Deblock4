# Deblock4 `Zig` Rewrite of `VapourSynth-Deblock` and more

I am considering trying out `Zig` 0.17.0-dev using AIs to redevelop (with targets `sse4.1`, `avx2`, and a dispatcher)
updating to vapoursynth APIv4/fmparallel a single DEBLOCK4.DLL containing

- `Deblock4` - based on the up to date `Deblock` already sse4 at <https://github.com/HolyWu/VapourSynth-Deblock>
- `Deblock4_qed` - based on the vsjetpack script `Deblock_QED` (ignoring interlacing, assuming field separated) in <https://github.com/Jaded-Encoding-Thaumaturgy/vs-jetpack/blob/main/vsdenoise/deblock.py>
- `Deblock4_qed_autoadjust` based on `Deblock4_qed` but auto recognising how blocky a frame is and applying "good" deblocking for that frame; parameters may change, to be decided later

Development order: `Deblock4` first, bit by bit. `Deblock4_qed` next. `Deblock4_qed_autoadjust` is last on the list; not in initial scope.

All three filters are strictly 1-in/1-out. No frame reordering, no cross-frame cache/pin machinery (unlike CNR3). This simplifies the fmParallel story considerably: no frame-lifecycle/ownership complexity beyond the standard VapourSynth API4 per-frame contract.

---

# Draft Architecture Decisions (Draft Spec Basis)

## References

"Old" but recently updated `VapourSynth-Deblock` source: <https://github.com/HolyWu/VapourSynth-Deblock> which has a c++ module with sse4 optimizations (but not using `Zig` `@Vector`).
This will require analysis to derive and create the optimal (and safe) `Zig` `@Vector` implementation
able to be to build 16/32 lane variants, since it probably only uses sse4-friendly loops. This analysis is also
where the block/edge-grid-aware tail handling (see Decision 13a below) gets worked out against the actual old
C++ structure, not just a generic array-tail case.

`Deblock_qed` in <https://github.com/Jaded-Encoding-Thaumaturgy/vs-jetpack/blob/main/vsdenoise/deblock.py> but
we will ignore interlacing, assuming fields are separated.

Runtime SIMD dispatch prior art reviewed (see Decision 2 below):

- Ziggit write-up, "Dispatching SIMD functions at runtime" (desttinghim, Nov 2024):
  <https://ziggit.dev/t/dispatching-simd-functions-at-runtime/6817> - the core technique: compile
  the same source per CPU level via `-mcpu`, export each under a tagged symbol name, link all
  variants into one binary, resolve the right symbol via `@extern` at startup based on detected CPU.
- `oma` (ATTron), a packaged library version of the same technique: <https://github.com/ATTron/oma> -
  reviewed and NOT adopted as a dependency; per the author's own description it packages "none of
  the individual pieces here are new... All of the techniques this is using already exists" - i.e.
  it is exactly the desttinghim technique wrapped as a `zig fetch` dependency, plus AArch64/AVX-512
  tiers we do not need. We build the same technique in-house instead (see Decision 2/6).
- Long-standing Zig core proposal for compiler-native function multi-versioning, not implemented:
  <https://github.com/ziglang/zig/issues/1018>. Not usable now; noted for awareness only.
- zsmooth (adworacz), a Zig VapourSynth plugin, was checked as a comparison point and uses a
  *different* architecture: separate build artifacts per CPU level (`-Dcpu=x86_64_v3` etc.), relying
  on VapourSynth core's own loader-side selection of the best binary at plugin-load time, with AVX2
  as the assumed baseline (no SSE4-only fallback). This is a legitimate alternative design but is
  NOT what we are doing - we want one self-contained DLL with internal runtime dispatch, since it
  does not depend on which VapourSynth core version/packaging is doing the loader-side selection.

## 1. SIMD strategy: explicit SIMD with `Zig` `@Vector`

### Decision

Use `Zig` explicit vector types (`@Vector`) for all performance-critical Deblock4 pixel-processing kernels.

Do **not** rely on `LLVM` auto-vectorization of scalar loops.

### Why

- Deblock4 is a predictable, highly regular image-processing algorithm.
- Explicit SIMD gives control over:
  * vector width,
  * memory access pattern,
  * edge/tail handling,
  * generated code inspection.
- The existing Deblock4 `SSE4.1` implementation is already SIMD-oriented, so the migration path is naturally "explicit SIMD -> `Zig` vectors", not "scalar C++ -> compiler magic".
- `Zig` `@Vector` expresses SIMD intent directly in the intermediate representation.
- The `LLVM` loop vectorizer status therefore becomes much less relevant.

### Why not

Do not write:

```
for (...) {
    scalar_pixel_operation();
}
```

and expect `Zig`/`LLVM` to automatically produce `AVX2` since `Zig` currently has `LLVM` auto vectorization
turned off for other compatibility reasons.

Reasons:

- `Zig` 0.16/0.17-era builds should not be assumed to auto-vectorize ordinary loops.
- Compiler heuristics can change between versions.
- Small source changes can alter auto-vectorizer decisions.
- For a video filter, predictable SIMD is preferred over heuristic SIMD.
- `Zig` currently has `LLVM` auto vectorization turned off for other compatibility reasons.

---

## 2. Runtime CPU dispatch

### Decision

Build one plugin binary containing multiple SIMD implementations, compiled in-house (no external
dispatch-library dependency - see References above for `oma` review).

At startup:

1. Detect CPU capabilities using `std.Target.Query` / `std.zig.system.resolveTargetQuery` against
   `std.Target.x86.Feature` flags (e.g. `.sse4_1`, `.avx2`) via `featureSetHasAll` - this reuses the
   same machinery Zig's own compiler uses for `-Dcpu=native`, rather than hand-rolling CPUID parsing
   from scratch (see Decision 6).
2. Select the best implementation.
3. Store function pointers to the chosen implementation.

Mechanism (per-CPU-level compiled object, linked into one binary, symbol resolved at startup) follows
the desttinghim Ziggit technique referenced above: build the shared kernel source once per CPU level
via `-mcpu`, each variant exports its entry points under a level-tagged symbol name, all variants link
into the single final DLL, and a small dispatch struct resolves the correct `@extern` symbol once at
plugin load, storing it as an immutable function pointer thereafter (safe to call from any fmParallel
worker thread without synchronisation, since selection happens once before any frame processing starts).

Selection order:

```
AVX2/x86_64_v3
        |
        v
SSE4.1
        |
        v
unsupported CPU
```

### Why

- Allows one VapourSynth plugin to support:
  * older `SSE4.1` machines,
  * modern `AVX2` machines.
- Avoids requiring `AVX2` merely to load the DLL.
- Gives deterministic behaviour.
- Self-contained: does not depend on VapourSynth core version or packaging doing loader-side binary
  selection (contrast with the zsmooth approach, References above).

### Why not

Do not compile the whole plugin as:

```
x86_64_v3
```

because:

- x86_64_v3 assumes `AVX2`-class hardware.
- The compiler may legally emit AVX2/FMA/BMI instructions anywhere.
- The plugin loader, registration code, or unrelated code could contain unsupported instructions before dispatch occurs.

Do not adopt `oma` or another external dispatch-dispatch dependency: the technique itself is simple
and already documented (see References); pulling in a dependency for it adds a maintenance/supply-chain
surface for no capability we don't already have in-house, and `oma` additionally targets tiers
(AArch64 NEON/SVE/SVE2, AVX-512/x86_64_v4) that are out of scope here.

---

## 3. CPU-specific module separation

### Decision

Separate SIMD implementations into independent `Zig` modules.

Final structure:

```
src/
    main.zig
    dispatch.zig
    cpu_detect.zig
    deblock_common.zig
    deblock_sse41.zig
    deblock_avx2.zig
```

---

## 4. Module responsibilities

### `main.zig`

#### Purpose

VapourSynth plugin interface.

Contains:

- plugin registration,
- filter creation,
- VapourSynth callbacks,
- normal application logic.

#### Target

```
generic x86-64
```

#### Why

- Must load on all supported CPUs.
- Must not contain `AVX2`-only instructions.

#### Why not

Not compiled as x86_64_v3 because it is before CPU dispatch.

---

## 5. `dispatch.zig`

### Purpose

Runtime selection layer.

Example concept:

```
if (cpu.has_avx2) {
    kernel = deblock_avx2;
}
else if (cpu.has_sse41) {
    kernel = deblock_sse41;
}
else {
    unsupported();
}
```

Selection runs once at plugin load; the resulting function pointer(s) are immutable thereafter and
safe to call concurrently from fmParallel worker threads with no locking (see Decision 2).

### Target

```
generic x86-64
```

### Why

- Dispatch itself must run before feature selection.
- It cannot require the feature it is detecting.

### Why not

No SIMD-specific optimisation here.

---

## 6. `cpu_detect.zig`

### Purpose

CPU feature detection.

Preferred implementation basis: `std.Target.Query.fromTarget(builtin.target)` with `cpu_model = .native`,
resolved via `std.zig.system.resolveTargetQuery()` to obtain the actual runtime CPU's
`std.Target.Cpu.Feature.Set`, checked against `std.Target.x86.Feature` flags (`.sse4_1`, `.avx2`, etc.)
using `featureSetHasAll`. This is the same detection machinery Zig's own compiler uses internally for
`-Dcpu=native`, reused here rather than a bespoke CPUID implementation.

Raw CPUID reference (fallback / cross-check only, if the std.Target route proves insufficient for any
edge case):

### `SSE4.1`

CPUID:

```
leaf 1
ECX bit 19
```

### `AVX2`

CPUID:

```
leaf 7 subleaf 0
EBX bit 5
```

Also verify:

```
OSXSAVE
XGETBV YMM state enabled
```

because AVX requires operating-system support for saving vector registers.

### Target

```
generic x86-64
```

---

## 7. `deblock_common.zig`

### Purpose

Shared Deblock algorithm implementation.

Contains:

- common filtering logic,
- vector operations,
- shared constants,
- shared helper functions.

Concept:

```
fn deblock_kernel(comptime lanes: usize)
```

Examples:

```
deblock_kernel(16);
```

creates SSE-sized operations.

```
deblock_kernel(32);
```

creates `AVX2`-sized operations.

### Why

- Avoids maintaining two separate algorithms.
- Keeps `SSE4.1` and `AVX2` behaviour identical.
- Lets the compiler specialise at compile time.

### Why not

Do not duplicate:

```
deblock_sse41.cpp
deblock_avx2.cpp
```

style code.

Reasons:

- bug fixes must be applied twice,
- behaviour can diverge,
- difficult validation.

---

## 8. `deblock_sse41.zig`

### Purpose

`SSE4.1` implementation wrapper.

Example:

```
pub fn run_sse41(...)
{
    deblock_kernel(16);
}
```

### Compiler target

Conceptually:

```
-march=sse4.1
```

or `Zig` equivalent:

```
-Dcpu=sse4.1
```

(actual build syntax to be confirmed when creating `build.zig`).

### Why

- Provides fallback for non-`AVX2` CPUs.
- Matches existing Deblock4 `SSE4.1` capability.

### Why not

Do not compile this as baseline generic x86-64.

Reason:

- We want guaranteed `SSE4.1` instructions available.
- Allows better code generation.

---

## 9. `deblock_avx2.zig`

### Purpose

`AVX2` implementation wrapper.

Example:

```
pub fn run_avx2(...)
{
    deblock_kernel(32);
}
```

### Compiler target

Preferred:

```
x86_64_v3
```

or equivalent `Zig` CPU target. Confirmed build syntax (per zsmooth precedent, adjust for `Windows`):

```
zig build -Doptimize=ReleaseFast -Dtarget=x86_64-windows -Dcpu=x86_64_v3
```

### Why

x86_64_v3 includes the `AVX2`-era instruction baseline:

- AVX
- AVX2
- BMI1
- BMI2
- F16C
- FMA
- LZCNT
- MOVBE
- related features

Advantages:

- lets `LLVM` optimise with a richer CPU model,
- matches modern desktop CPUs,
- includes Ryzen Zen 2 / 3900X class CPUs.

### Why not

Do not make the entire plugin x86_64_v3.

Only this module is allowed to assume those instructions.

---

## 10. Intrinsics policy

### Decision

Start with `Zig` `@Vector`.

Use explicit x86 intrinsics only when required.

### Why

Advantages of `@Vector`:

- clearer than raw intrinsics,
- easier to make 16/32 lane variants,
- easier shared code,
- compiler handles register allocation.

### Why not start with intrinsics

Manual intrinsics:

- increase code complexity,
- tie implementation closely to Intel naming,
- make SSE/AVX2 sharing harder.

Possible future use:

- difficult shuffles,
- unusual packing,
- special instructions where `@Vector` produces inferior code.

---

## 11. Function visibility

### Decision

Use `Zig`'s default-private model.

Only intended entry points are `pub`.

Example:

```
fn internal_helper()
{
}

pub fn run_avx2()
{
    internal_helper();
}
```

### Why

- prevents accidental API exposure,
- keeps SIMD modules isolated,
- makes ownership of interfaces obvious.

---

## 12. `LLVM`/vectorizer position

### Decision

The project does not depend on `LLVM` Loop Vectorization.

### Why

The SIMD path is:

```
Zig @Vector
        |
        v
LLVM vector IR
        |
        v
x86 backend
        |
        v
SSE4.1 / AVX2 instructions
```

not:

```
scalar loop
        |
        v
LLVM discovers SIMD
```

### Why not

Do not assume:

- future `LLVM` versions,
- `Zig` versions,
- optimisation flags

will always make scalar code fast.

Explicit SIMD is the stable design choice.

---

## 13. Validation requirements

Required tests:

### Correctness

Compare:

```
old Deblock4
vs
new Zig SSE4.1
vs
new Zig AVX2
```

on identical inputs.

### Dispatch

Test:

- forced `SSE4.1` path,
- forced `AVX2` path,
- unsupported CPU path.

### Assembly inspection

Verify:

SSE module:

```
XMM/SSE4.1 instructions
```

`AVX2` module:

```
YMM/AVX2 instructions
```

and no accidental `AVX2` in baseline modules.

## 13a. Edge/tail handling (adopted scheme)

### Decision

Use the standard, widely-adopted SIMD tail pattern: a vectorized main loop over the largest multiple
of the lane width, followed by a scalar loop over the remainder. This is confirmed as the universal
accepted approach across SIMD implementations generally (not something specific to deblocking), so no
novel scheme is required at the SSE4.1/AVX2 level - masked/compress-store tricks only start to matter
at AVX-512 and are out of scope here.

The Deblock4-specific work is applying this to the algorithm's 2D block-grid structure rather than a
flat array: the vector width must align with the deblock filter's own block/edge geometry, so the tail
case in practice is "rows/columns not evenly divisible by lane width" rather than a simple last-N-elements
remainder. Working out that mapping is part of the old-C++ analysis referenced above (References,
Decision 1), not a generic problem needing further research.

### Why

- Matches universally accepted practice; no reason to deviate.
- Keeps kernel code simple: one hot loop, one short cleanup loop.
- Avoids AVX-512-only masked-store techniques we don't need at this instruction-set tier.

### Why not

Do not attempt masked/compress-store style branchless tail handling (as used in some AVX-512 code) -
unnecessary complexity for SSE4.1/AVX2, and not supported cleanly by those instruction sets anyway.

---

## 14. Final agreed architecture

```
                   VapourSynth
                        |
                        v
                    main.zig
                        |
                        v
                  dispatch.zig
                        |
        +---------------+---------------+
        |                               |
        v                               v

  deblock_sse41.zig              deblock_avx2.zig

  target SSE4.1                  target x86_64_v3

  @Vector(16,...)                @Vector(32,...)

        |                               |
        +---------------+---------------+
                        |
                        v

              deblock_common.zig
```

This is the current draft design baseline for a Deblock4 `Zig` implementation.
