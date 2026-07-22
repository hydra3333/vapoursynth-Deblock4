# Deblock4 `Zig` Rewrite of `VapourSynth-Deblock` and more 

I am considering trying out `Zig` 0.17.0 using AIs to redevelop (with targets `sse4.1`, `avx2`, and a dispatcher)
updating to vapoursynth APIv4/fmparallel a single DEBLOCK4.DLL containing    
- `Deblock4` - based on the up to date `Deblock` already sse4 at https://github.com/HolyWu/VapourSynth-Deblock    
- `Deblock4_qed` - based on the vsjetpack script `Deblock_QED` (ignoring interlacing, assuming field separated) in https://github.com/Jaded-Encoding-Thaumaturgy/vs-jetpack/blob/main/vsdenoise/deblock.py    
- `Deblock4_qed_autoadjust` based on `Deblock4_qed` but auto recognising how blocky a frame is and applying "good" deblockling for that frame; parameters may change, to be decided later 

---

# Draft Architecture Decisions (Draft Spec Basis)

## References

"Old" but recently updated `VapourSynth-Deblock` source: https://github.com/HolyWu/VapourSynth-Deblock
which has a c++ module with sse4 optimizations (but not using `Zig` `@Vector`).
This will require analysys to derive and create the optiomal (and safe) `Zig` `@Vector` implementation
able to be to build 16/32 lane variants, since it probably only uses sse4-friendly loops.

`Deblock_qed` in https://github.com/Jaded-Encoding-Thaumaturgy/vs-jetpack/blob/main/vsdenoise/deblock.py but
we will ignore interlacing, assuming fields are separated.

## 1. SIMD strategy: explicit SIMD with `Zig` `@Vector`

### Decision

Use `Zig` explicit vector types (`@Vector`) for all performance-critical Deblock4 pixel-processing kernels.

Do **not** rely on `LLVM` auto-vectorization of scalar loops.

### Why

* Deblock4 is a predictable, highly regular image-processing algorithm.
* Explicit SIMD gives control over:

  * vector width,
  * memory access pattern,
  * edge/tail handling,
  * generated code inspection.
* The existing Deblock4 `SSE4.1` implementation is already SIMD-oriented, so the migration path is naturally "explicit SIMD → `Zig` vectors", not "scalar C++ → compiler magic".
* `Zig` `@Vector` expresses SIMD intent directly in the intermediate representation.
* The `LLVM` loop vectorizer status therefore becomes much less relevant.

### Why not

Do not write:

```Zig
for (...) {
    scalar_pixel_operation();
}
```

and expect `Zig`/`LLVM` to automatically produce `AVX2` since `Zig` currently has `LLVM` auto vectorization
turned off for other compatibility reasons.

Reasons:

* `Zig` 0.16/0.17-era builds should not be assumed to auto-vectorize ordinary loops.
* Compiler heuristics can change between versions.
* Small source changes can alter auto-vectorizer decisions.
* For a video filter, predictable SIMD is preferred over heuristic SIMD.
* `Zig` currently has `LLVM` auto vectorization turned off for other compatibility reasons.

---

## 2. Runtime CPU dispatch

### Decision

Build one plugin binary containing multiple SIMD implementations.

At startup/runtime:

1. Detect CPU capabilities.
2. Select the best implementation.
3. Store function pointers to the chosen implementation.

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

* Allows one VapourSynth plugin to support:

  * older `SSE4.1` machines,
  * modern `AVX2` machines.
* Avoids requiring `AVX2` merely to load the DLL.
* Gives deterministic behaviour.

### Why not

Do not compile the whole plugin as:

```
x86_64_v3
```

because:

* x86_64_v3 assumes `AVX2`-class hardware.
* The compiler may legally emit AVX2/FMA/BMI instructions anywhere.
* The plugin loader, registration code, or unrelated code could contain unsupported instructions before dispatch occurs.

---

## 3. CPU-specific module separation

### Decision

Separate SIMD implementations into independent `Zig` modules.

Final structure:

```
src/

    main.Zig`
    dispatch.Zig`
    cpu_detect.Zig`
    deblock_common.Zig`
    deblock_sse41.Zig`
    deblock_avx2.Zig`
```

---

## 4. Module responsibilities

### `main.Zig`

#### Purpose

VapourSynth plugin interface.

Contains:

* plugin registration,
* filter creation,
* VapourSynth callbacks,
* normal application logic.

#### Target

```
generic x86-64
```

#### Why

* Must load on all supported CPUs.
* Must not contain `AVX2`-only instructions.

#### Why not

Not compiled as x86_64_v3 because it is before CPU dispatch.

---

## 5. `dispatch.Zig`

### Purpose

Runtime selection layer.

Example concept:

```Zig
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

### Target

```
generic x86-64
```

### Why

* Dispatch itself must run before feature selection.
* It cannot require the feature it is detecting.

### Why not

No SIMD-specific optimisation here.

---

## 6. `cpu_detect.Zig`

### Purpose

CPU feature detection.

Checks:

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

## 7. `deblock_common.Zig`

### Purpose

Shared Deblock algorithm implementation.

Contains:

* common filtering logic,
* vector operations,
* shared constants,
* shared helper functions.

Concept:

```Zig
fn deblock_kernel(comptime lanes: usize)
```

Examples:

```Zig
deblock_kernel(16);
```

creates SSE-sized operations.

```Zig
deblock_kernel(32);
```

creates `AVX2`-sized operations.

### Why

* Avoids maintaining two separate algorithms.
* Keeps `SSE4.1` and `AVX2` behaviour identical.
* Lets the compiler specialise at compile time.

### Why not

Do not duplicate:

```
deblock_sse41.cpp
deblock_avx2.cpp
```

style code.

Reasons:

* bug fixes must be applied twice,
* behaviour can diverge,
* difficult validation.

---

## 8. `deblock_sse41.Zig`

### Purpose

`SSE4.1` implementation wrapper.

Example:

```Zig
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

(actual build syntax to be confirmed when creating `build.Zig`).


### Why

* Provides fallback for non-`AVX2` CPUs.
* Matches existing Deblock4 `SSE4.1` capability.

### Why not

Do not compile this as baseline generic x86-64.

Reason:

* We want guaranteed `SSE4.1` instructions available.
* Allows better code generation.

---

## 9. `deblock_avx2.Zig`

### Purpose

`AVX2` implementation wrapper.

Example:

```Zig
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

or equivalent `Zig` CPU target.


### Why

x86_64_v3 includes the `AVX2`-era instruction baseline:

* AVX
* AVX2
* BMI1
* BMI2
* F16C
* FMA
* LZCNT
* MOVBE
* related features

Advantages:

* lets `LLVM` optimise with a richer CPU model,
* matches modern desktop CPUs,
* includes Ryzen Zen 2 / 3900X class CPUs.

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

* clearer than raw intrinsics,
* easier to make 16/32 lane variants,
* easier shared code,
* compiler handles register allocation.

### Why not start with intrinsics

Manual intrinsics:

* increase code complexity,
* tie implementation closely to Intel naming,
* make SSE/AVX2 sharing harder.

Possible future use:

* difficult shuffles,
* unusual packing,
* special instructions where `@Vector` produces inferior code.

---

## 11. Function visibility

### Decision

Use `Zig`'s default-private model.

Only intended entry points are `pub`.

Example:

```Zig
fn internal_helper()
{
}

pub fn run_avx2()
{
    internal_helper();
}
```

---

### Why

* prevents accidental API exposure,
* keeps SIMD modules isolated,
* makes ownership of interfaces obvious.

---

## 12. `LLVM`/vectorizer position

### Decision

The project does not depend on `LLVM` Loop Vectorization.


### Why

The SIMD path is:

```
`Zig` @Vector
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

* future `LLVM` versions,
* `Zig` versions,
* optimisation flags

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
new `Zig` SSE4.1
vs
new `Zig` AVX2
```

on identical inputs.

### Dispatch

Test:

* forced `SSE4.1` path,
* forced `AVX2` path,
* unsupported CPU path.

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

---

## 14. Final agreed architecture

```
                         VapourSynth
                              |
                              v
                         main.Zig`
                              |
                              v
                        dispatch.Zig`
                              |
              +---------------+---------------+
              |                               |
              v                               v

      deblock_sse41.Zig`              deblock_avx2.Zig`

      target SSE4.1                  target x86_64_v3

      @Vector(16,...)                @Vector(32,...)

              |                               |
              +---------------+---------------+
                              |
                              v

                    deblock_common.Zig`
```

This is the current draft design baseline for a Deblock4 `Zig` implementation.

