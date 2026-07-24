# Deblock4 - Concise Project Summary

**Version:** 1.0  
**Date:** 2026-07-24  
**Status:** User-facing companion only. The README specification and AI Charter remain controlling.

---

# 1. Purpose and scope

Deblock4 is a new Zig 0.16.0 VapourSynth API4 plugin for reducing visible compression-block artifacts, initially focused on PAL tape material recorded to MPEG-2 by consumer DVD recorders.

One Windows x64 DLL is planned to contain:

```text
Deblock4                  core filter; current work
Deblock4_qed              later masked/blended variant
Deblock4_qed_autoadjust   later automatic-strength variant
```

The current design covers `Deblock4` only.

The filter is stateless, one-frame-in/one-frame-out, and intended for `fmParallel`.

---

# 2. Public Deblock4 parameters

```text
deblock4.Deblock4(
    clip                        REQUIRED
    grid_mode                   REQUIRED, no default

    strength=25
    boundary_strength_offset=0
    side_activity_offset=0
    planes=all
    midpoint_threshold_scale=<quality-selected default>
    backend="auto"

    # custom mode only:
    luma_step_x
    luma_step_y
    chroma_step_x
    chroma_step_y
    luma_midpoint_enabled
)
```

| Parameter | Values / range | Meaning |
|---|---|---|
| `clip` | VapourSynth node | Input clip |
| `grid_mode` | see below | Required block-grid policy |
| `strength` | `0..60`, default `25` | Base deblocking table index |
| `boundary_strength_offset` | `-strength .. 60-strength` | Shifts `alpha` and `tc0`: boundary acceptance plus correction limit |
| `side_activity_offset` | `-strength .. 60-strength` | Shifts `beta`: per-side flatness/activity only |
| `planes` | valid plane indices, default all | Planes to process |
| `midpoint_threshold_scale` | `0.0..1.0`, conditional | Scales luma midpoint `alpha`/`beta`; `0` disables, `1` gives parity |
| `backend` | `auto`, `avx2`, `sse41`, `scalar` | Runtime backend |
| custom steps | positive validated integers | Explicit luma/chroma grid steps |
| `luma_midpoint_enabled` | `0` or `1` | Enables custom luma primary/midpoint classes |

Out-of-range values are errors; they are not silently clamped.

Legacy translation:

```text
quant    -> strength
aoffset  -> boundary_strength_offset
boffset  -> side_activity_offset
opt      -> backend
```

---

# 3. Grid choices users must make

`grid_mode` is required because a silently wrong grid can miss real block boundaries or probe unnecessary mid-block positions.

| `grid_mode` | Luma | Chroma | Use |
|---|---:|---:|---|
| `"h264"` | 4 x 4 | 4 x 4 | H.264/HolyWu-derived material |
| `"mpeg2_progressive"` | 8 x 8 | 8 x 8 | Progressive MPEG-2 4:2:0 or 4:2:2 |
| `"mpeg2_field_separated"` | 8 x 4 | 8 x 4 | Field-separated MPEG-2 4:2:0 |
| `"custom"` | explicit | explicit | Expert/proof use |
| `"auto"` | reserved | reserved | Initially rejected; future feature |

Steps are measured in each plane's own samples.

For field-separated MPEG-2 4:2:0 luma:

```text
primary rows:   y mod 8 == 0
midpoint rows:  y mod 8 == 4
```

The midpoint threshold scale controls how difficult it is for the additional midpoint rows to activate. Its release default will be selected by quality testing.

Normal starting settings:

```text
strength=25
boundary_strength_offset=0
side_activity_offset=0
backend="auto"
```

Use `backend="scalar"` mainly for diagnosis.

---

# 4. Main design decisions

## Canonical correctness

The scalar implementation is the executable specification:

```text
scalar == SSE4.1 == AVX2
```

Integer output must be byte-exact. Float output must be bit-exact across backends under strict mode and the same inherited MXCSR state.

## Schedule is output-defining

Two scalar schedules are tested before SIMD work:

```text
Schedule A: verified HolyWu-equivalent raster/interleaved order
Schedule B: whole-plane vertical pass, then whole-plane horizontal pass
```

Only the quality winner becomes production. Schedule C is deferred.

## Proper chroma

Deblock4 deliberately uses a proper chroma normal filter:

```text
luma:
    read p2 p1 p0 q0 q1 q2
    may change p1 p0 q0 q1

chroma:
    read p1 p0 q0 q1
    change p0 q0 only
```

This is gentler, cheaper, and more safely batchable than applying the luma filter to chroma.

## Boundaries and SIMD tails

```text
Incomplete algorithmic footprint:
    leave unchanged

Complete valid footprint that underfills a vector:
    still process with narrower SIMD or scalar cleanup
```

No whole-frame padding/resize/crop is used to satisfy block or vector multiples. No undocumented stride padding is read or written.

## Runtime architecture

```text
global once:
    detect immutable CPU/OS capabilities

per filter instance once:
    resolve auto/avx2/sse41/scalar
    store immutable entry points

per frame:
    no feature test or backend-choice branch
```

The one DLL contains generic/dispatch, scalar, SSE4.1, and AVX2 code.

Exact SIMD feature closures remain Stage 1 spike results; they are not guessed in advance.

## Float exceptional values

NaN/infinity checks are per edge position, never per SIMD batch. A non-finite footprint leaves only that position unchanged.

## Audit properties

Output frames record the resolved grid and actual backend:

```text
Deblock4GridMode
Deblock4LumaStepX
Deblock4LumaStepY
Deblock4ChromaStepX
Deblock4ChromaStepY
Deblock4MidpointScale   when applicable
Deblock4Backend
```

---

# 5. Initial limitations

- Only core `Deblock4` is current work.
- `Deblock4_qed` and automatic adjustment are later.
- `grid_mode="auto"` is reserved but initially unavailable.
- No named interlaced separated-field MPEG-2 4:2:2 preset initially.
  - YUV422 format support and custom steps remain available.
  - Progressive MPEG-2 4:2:2 is supported by the progressive preset.
- No initial MJPEG or DV presets.
- No initial spatial grid-origin offset; run before cropping when coded-grid alignment matters.
- Schedule C is deferred.
- Deblock4 is a post-decoding spatial filter, not a complete codec loop-filter implementation.
- AVX2 speed benefit is measured, not assumed.
- Exact Zig build syntax, CPU detector, feature closures, and frame-property mechanics remain implementation spikes.

---

# 6. Development stages

The six stages are planning buckets and may contain a small number of bounded, independently testable subscopes.

## Stage 1 - Zig/build/dispatch scaffold

- Zig 0.16.0 project and VS Code/ZLS setup
- generic, scalar, SSE4.1, and AVX2 object experiments
- one-DLL link
- CPU/OS capability detection
- per-instance backend resolution
- assembly inspection to fix exact feature closures

## Stage 2 - Canonical scalar core and proof harness

- formulas, threshold tables, range proofs
- named luma/chroma footprints and derived bounds
- integer and float scalar kernels
- proper chroma
- scalar Schedules A and B
- parameter validation and grid presets
- independent identity/safety harness foundations

## Stage 3 - Scalar quality decisions

Measurement selects:

- Schedule A or B
- default midpoint threshold scale
- proper-chroma quality acceptance
- whether midpoint thresholds need extra strictness on noisy VHS

## Stage 4 - SSE4.1

- SSE4.1 kernels
- scalar/SSE identity
- safety, format, dimension, tail, and assembly gates

## Stage 5 - AVX2

- AVX2 kernels
- scalar/SSE/AVX identity
- assembly and AVX/SSE-transition inspection
- full-filter benchmarks

## Stage 6 - VapourSynth integration and release readiness

- API4 and `fmParallel`
- public API and errors
- audit frame properties
- complete validation matrix
- packaging and documentation

---

# 7. Required tests

## Correctness

```text
ReleaseSafe scalar oracle
    ==
production scalar
    ==
SSE4.1
    ==
AVX2
```

The production scalar must be checked against the ReleaseSafe oracle at least once per release.

## Arithmetic and geometry

- complete range proofs for every arithmetic tier
- exhaustive small dimensions, including 1 through 65
- dimensions around block/vector boundaries
- per-plane and per-axis bounds
- incomplete footprints versus valid SIMD tails
- custom and named grids

## Memory safety

- minimal row storage
- arbitrary strides and alignments
- canaries/guard pages where available
- no assumed right or bottom padding

## Float

- NaN payloads, infinities, signed zero, subnormals
- per-position masking inside SIMD batches
- recorded MXCSR state

## Quality

- synthetic edges, intersections, diagonals, text, texture, grain/noise
- blocky MPEG-2 and low-bitrate H.264
- luma- and chroma-dominant material
- field-separated restoration material
- clean-source/re-encode comparisons where possible
- repeated filtering, directional bias, detail loss and blur checks
- metrics as supporting evidence; visual inspection remains decisive

## Assembly and performance

- no forbidden instructions in generic/SSE objects
- intended XMM/YMM code
- no accidental AVX-512 or FMA
- no unsafe loads or scalarised hot paths
- full-filter benchmarks, not only microkernels

---

# 8. Remaining open items

Measurement:

```text
Schedule A/B winner
default midpoint_threshold_scale
proper-chroma quality
AVX2 benefit and generated-code quality
```

Bounded implementation spikes:

```text
Zig 0.16.0 object/link syntax
exact feature closures
CPUID/XGETBV
VapourSynth frame-property writes
```

Deferred:

```text
interlaced separated-field MPEG-2 4:2:2 preset
MJPEG field-organisation research
automatic grid selection
automatic strength analysis
Deblock4_qed
Deblock4_qed_autoadjust
```

The core design and public API round is otherwise closed.

---

# 9. Practical starting point

For a typical field-separated MPEG-2 4:2:0 restoration clip:

```text
grid_mode="mpeg2_field_separated"
strength=25
boundary_strength_offset=0
side_activity_offset=0
backend="auto"
```

For progressive MPEG-2:

```text
grid_mode="mpeg2_progressive"
```

For H.264/HolyWu-style geometry:

```text
grid_mode="h264"
```

Development priority:

```text
scalar specification
-> measured schedule choice
-> SSE4.1 identity
-> AVX2 identity and performance
-> VapourSynth integration and release validation
```

Deblock4 should require substantially fewer stages and less proof machinery than CNR3 because it is stateless and has no cross-frame ownership, recovery, or ordering system.
