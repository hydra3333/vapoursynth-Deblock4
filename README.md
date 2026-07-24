<h1 align="center">
Deblock4

![Platform](https://img.shields.io/badge/platform-Windows%2010%20%7C%2011-lightgrey)
![License](https://img.shields.io/badge/license-GPL--2.0--or--later-blue)
![Language](https://img.shields.io/badge/Zig-0.16.0-F7A41D?logo=zig&logoColor=white)
![Status](https://img.shields.io/badge/status-Under%20Development-orange) 
</h1>    

<!--
Common Statuses
![Status: Active](https://img.shields.io/badge/status-active-brightgreen)
![Status: Active](https://img.shields.io/badge/status-active-brightgreen)
![Status: Beta](https://img.shields.io/badge/status-beta-blue)
![Status: Experimental](https://img.shields.io/badge/status-experimental-orange)
![Status: Deprecated](https://img.shields.io/badge/status-deprecated-red)
![Status: Inactive](https://img.shields.io/badge/status-inactive-lightgrey)
![Status](https://img.shields.io/badge/status-Under%20Development-orange) 
![Status: Released](https://img.shields.io/badge/status-Released-brightgreen)

![Language](https://img.shields.io/badge/language-C%2B%2B-00599C?logo=c%2B%2B&logoColor=white)

Common status labels
active, maintained, stable
alpha, beta, experimental
deprecated, legacy, archived, inactive

Typical named colors
Greens: brightgreen, green, yellowgreen
Yellows/Oranges: yellow, orange
Reds: red, crimson, firebrick
Blues/Purples: blue, navy, blueviolet
Neutrals: lightgrey, grey/gray, black

Semantic: 
success (brightgreen), informational (blue), critical (red), inactive (lightgrey), important (orange) 

How to craft your own
https://img.shields.io/badge/<LABEL>-<MESSAGE>-<COLOR>
Replace <LABEL>, <MESSAGE>, and <COLOR> with whatever text and named color you like. (Spaces become %20)
-->


# Deblock4 `Zig` Rewrite of `VapourSynth-Deblock` and more

I am using the pinned stable `Zig` 0.16.0 release, with matching ZLS support, to redevelop (with targets `sse4.1`, `avx2`, and a dispatcher)
updating to vapoursynth APIv4/fmparallel a single DEBLOCK4.DLL containing

- `Deblock4` - based on the up to date `Deblock` already sse4 at <https://github.com/HolyWu/VapourSynth-Deblock>
- `Deblock4_qed` - based on the vsjetpack script `Deblock_QED` (ignoring interlacing, assuming field separated) in <https://github.com/Jaded-Encoding-Thaumaturgy/vs-jetpack/blob/main/vsdenoise/deblock.py>
- `Deblock4_qed_autoadjust` based on `Deblock4_qed` but auto recognising how blocky a frame is and applying "good" deblocking for that frame; parameters may change, to be decided later

Development order: `Deblock4` first, bit by bit. `Deblock4_qed` next. `Deblock4_qed_autoadjust` is last on the list; not in initial scope.

All three filters are strictly 1-in/1-out. No frame reordering, no cross-frame cache/pin machinery. This simplifies the fmParallel story considerably: no frame-lifecycle/ownership complexity beyond the standard VapourSynth API4 per-frame contract.

---

# License

This project is distributed under the GNU GENERAL PUBLIC LICENSE Version 2 or later (GPL-2.0-or-later).

---

# Architecture Decisions and Detailed Specification

**Design specification revision:** 1.0  
**Date:** 2026-07-24  
**Status:** accepted design-specification baseline; this is not a claim that the plugin binary is released.  
**Toolchain:** Zig 0.16.0 pinned; exact object-link and runtime-detection syntax remains subject to compile/run proof.  
**Schedule status:** Schedule A versus Schedule B quality gate remains open; Schedule C is deferred.  
**MPEG-2 grid status:** field-separated MPEG-2 4:2:0 geometry is resolved; luma uses a step-4 candidate set with primary/midpoint classes, while chroma uses fixed per-plane steps. The midpoint threshold-scale default remains a quality-tuning question.  
**Assessment status:** the coder/designer design round is closed. Public parameter names, ranges, float exceptional-value behaviour, backend values, and audit frame properties are settled. Remaining work is measurement or bounded implementation spikes.

## 0. Purpose of this appendix

This document consolidates the accepted Deblock4 design into the controlling technical specification baseline.

It is intended to remove several ambiguities in the current README:

- `@Vector(16, ...)` and `@Vector(32, ...)` currently confuse vector **bytes** with vector **elements**.
- Algorithmic frame-boundary handling is currently mixed together with SIMD batch-tail handling.
- HolyWu is currently treated as the only correctness oracle, even though Deblock4 may deliberately adopt an equal-or-better algorithmic schedule.
- Horizontal-edge and vertical-edge processing are described as if their memory movement were interchangeable.
- The current CPU-detection and per-module compilation wording is more definite than the Zig 0.16.0 implementation evidence presently supports.
- The current validation section does not yet define an independent scalar oracle.
- The current draft does not fully state which operations may be batched without changing results.

This specification defines:

1. the project objective;
2. settled requirements;
3. open and provisional decisions;
4. a candidate canonical processing schedule;
5. the corrected frame-boundary rule;
6. the corrected SIMD-tail rule;
7. format-specific arithmetic policy;
8. Zig `@Vector` width and lane derivation;
9. horizontal and vertical implementation structure;
10. proposed Zig module boundaries;
11. one-DLL compilation and runtime dispatch;
12. correctness, quality, safety, assembly, and performance validation;
13. the recorded source-level findings, accepted amendments, and remaining bounded questions.

---

# 1. Executive summary

## 1.1 Primary objective

Deblock4 shall define **one canonical deblocking algorithm** and implement it through:

- a scalar reference backend;
- an SSE4.1 backend;
- an AVX2 backend.

The required relationship is:

```text
canonical scalar output
        ==
SSE4.1 output
        ==
AVX2 output
```

For integer formats, `==` means byte-exact output.

For 32-bit floating-point formats, byte-exact output is the target. Strict floating-point operation ordering shall be retained. Any exception for IEEE special values must be explicitly decided and documented; it must not arise accidentally from compiler optimisation.

## 1.2 Relationship to HolyWu

HolyWu's current VapourSynth-Deblock implementation is:

- the initial algorithmic baseline;
- the initial subjective-quality baseline;
- the initial regression comparison;
- useful prior art for formulas, thresholds, edge geometry, and an SSE4.1 implementation.

HolyWu is **not an absolute bit-exact specification** for Deblock4.

Deblock4 may deliberately produce a different result when:

- the new result is demonstrably equal or better in quality;
- the difference follows a documented canonical algorithm;
- scalar, SSE4.1, and AVX2 all produce the same new result;
- the change is validated rather than being an incidental SIMD side effect.

The distinction is:

```text
Deliberate canonical Deblock4 difference from HolyWu:
    potentially acceptable after quality validation.

Accidental difference between scalar, SSE4.1, and AVX2:
    never acceptable.
```

## 1.3 Working recommendation

The current working recommendation is:

- no spatial edge-grid offset in the initial release;
- no whole-frame padding or `resize.Point`/crop wrapper merely to satisfy a block multiple;
- process every candidate edge whose complete filter-class footprint lies within the actual plane;
- leave only incomplete-footprint frame-edge regions unchanged;
- process every otherwise valid edge even when it does not fill one SSE4.1 or AVX2 vector;
- use a vector main body plus a smaller-vector or scalar **SIMD tail** along each valid edge;
- evaluate Schedule A versus Schedule B in scalar form and close that quality gate **before any SSE4.1 implementation begins**;
- retain Schedule C as deferred;
- use a backend `vector_bytes` concept, not a universal `lanes = 16/32` concept;
- compile generic, SSE4.1-targeted, and AVX2-targeted objects separately and link them into one DLL;
- use format-specific arithmetic:
  - 8-12-bit integer: candidate `i16` intermediates, subject to a complete proof of every branch and intermediate;
  - 13-16-bit integer: `i32` intermediates;
  - 32-bit float: strict `f32`;
- use separate canonical luma and chroma normal-filter formulas:
  - luma reads `e-3..e+2` and may modify `p1`, `p0`, `q0`, and `q1`;
  - proper chroma reads `e-2..e+1` and modifies only `p0` and `q0`;
- treat proper chroma as settled-by-design but not yet validated-by-measurement;
- use `@Vector` for shared SIMD arithmetic where it generates good code;
- allow backend-, orientation-, and plane-class-specific load, transpose, shuffle, pack, and store implementations;
- require a user-visible `grid_mode` selection with no silent default;
- reserve `grid_mode="auto"` now, but reject it until automatic grid selection is implemented;
- for field-separated MPEG-2 4:2:0:
  - luma candidates use `edge_step_x = 8` and `edge_step_y = 4` in luma coordinates;
  - luma rows `y mod 8 == 0` are primary and `y mod 8 == 4` are midpoint candidates;
  - midpoint candidates reuse the canonical activation test with an empirically selected `midpoint_threshold_scale`;
  - chroma uses `edge_step_x = 8` and `edge_step_y = 4` in chroma coordinates, with no luma-style midpoint ambiguity;
- include a progressive MPEG-2 preset for both 4:2:0 and 4:2:2;
- defer only the automatic/named interlaced separated-field MPEG-2 4:2:2 preset; generic YUV422 and explicit custom steps remain supported;
- keep thresholds as explicit kernel inputs, not values fetched from filter-instance state, so a future automatic-strength driver can reuse the proven kernels;
- retain direct per-plane-class step control for proof modes, expert use, and formats not covered by a named preset;
- expose the scalar reference backend in production for diagnosis as well as SSE4.1 and AVX2;
- write always-on non-reserved frame properties recording the resolved grid policy and actual backend;
- apply float non-finite rejection per edge position, never per SIMD batch.

# 2. Decision-status table

| Topic | Current status | Position |
|---|---|---|
| One canonical algorithm | Settled | Required |
| Scalar reference oracle | Settled | First-class deliverable, written before SIMD |
| Scalar/SSE4.1/AVX2 identity | Settled | Mandatory |
| HolyWu bit-exactness | Settled | Desired baseline similarity, not absolute requirement |
| Whole-frame pad/resize/crop | Settled | Rejected for Deblock4 core |
| Algorithmic boundary rule | Settled | Process only complete-footprint candidate edges |
| Valid SIMD tail | Settled | Must still be processed |
| Use of stride padding beyond logical width | Settled | Do not rely on it |
| Backend abstraction | Settled | `vector_bytes`, not flat lane count |
| Format-specific arithmetic | Settled in principle | 8-12 bit -> candidate `i16`; 13-16 bit -> `i32`; float -> strict `f32` |
| H/V data movement | Settled | May be backend-specific |
| Candidate schedule | Provisional quality gate | Whole-plane vertical pass, then horizontal pass |
| Schedule A/B implementation order | Settled | Both scalar first; gate closes before SSE4.1 work |
| Schedule C (macroblock-local H.264 order) | Settled | Deferred; see section 5.6 |
| HolyWu exact schedule | Verified in source review | Raster-interleaved, H before V per 4x4 position; see sections 3.5 and 17 |
| Luma footprint | Verified | Read `e-3..e+2`; write `e-2..e+1` |
| Proper chroma footprint | Settled-by-design | Read `e-2..e+1`; write `e-1..e`; `p0/q0` only |
| Proper chroma validation | Open measurement gate | Chroma-dominant corpus; HolyWu-compat path is development-only |
| Edge-position indexing convention | Settled | `e` = first sample on the q side; see section 3.4 |
| Minimum processable plane extent | Settled | Derived from `edge_step` and plane-class radii; see section 6.5 |
| Per-plane-class edge steps | Settled | Expressed in each plane's own sample coordinates; never inferred by subsampling ratio |
| Public parameter naming | Settled | Meaning-based names plus a documentation-only legacy translation table; see section 3.14 |
| Required grid selection | Settled | No silent default; `auto` token reserved but rejected until implemented |
| Field-separated MPEG-2 4:2:0 luma grid | Settled geometry | `x=8`, `y=4`; primary/midpoint position classes |
| Luma midpoint threshold scale | Open quality tuning | Scale midpoint `alpha`/`beta`; default selected by harness |
| Midpoint fixed-point conversion | Settled | One-time `i64` creation-path computation; kernel receives immutable threshold sets |
| Midpoint data source | Settled | Current destination state at that point in canonical schedule |
| Field-separated MPEG-2 4:2:0 chroma grid | Confirmed structurally | `x=8`, `y=4` in chroma coordinates; no luma `dct_type` ambiguity |
| Progressive MPEG-2 4:2:0/4:2:2 preset | Settled scope | Include; luma and chroma steps are 8x8 in their own coordinates |
| Interlaced separated-field MPEG-2 4:2:2 preset | Deferred | Generic/custom YUV422 remains fully supported |
| BestSource metadata | Resolved | Decoded pixels and frame-level properties only; no per-macroblock `dct_type` map |
| MPEG-2 decoder deblocking | Resolved | H.262 has no normative in-loop deblock; compression blocking remains in decoded pixels |
| Recorder-brand default | Rejected | No defensible LG/JVC/brand-level DCT-mode rule |
| Float exceptional-value policy | Settled | Per-edge-position finite check; leave that position unchanged on NaN/Inf; preserve unchanged bit patterns |
| Public strength/offset ranges | Settled | `strength=0..60`; each offset must keep its independent resolved index within `0..60` |
| Production backends | Settled | `auto`, `avx2`, `sse41`, and always-available `scalar` |
| Audit frame properties | Settled | Always-on resolved-grid/backend properties; see section 13.5 |
| Zig 0.16 runtime CPU detection | Open implementation spike | Small explicit CPUID/XGETBV unit is expected |
| SSE4.1/AVX2 build syntax | Open implementation spike | Separate target-specific objects linked into one DLL |
| Future automatic-strength extensibility | Settled guards only | Shared kernels, separate driver; analyser is canonical and uses per-call pre-pass scratch |
| AVX2 speed benefit | Open benchmark | Never assume 2x merely from register width |

# 3. Normative terminology

The following terms should be used consistently in the README and implementation.

## 3.1 Plane

One VapourSynth image plane processed independently, for example:

- Y, U, or V;
- R, G, or B;
- Gray.

Every plane has its own:

- logical width;
- logical height;
- bytes per sample;
- stride;
- read pointer;
- write pointer.

Chroma subsampling means U and V dimensions may differ from Y dimensions. Bounds must therefore be derived per plane, not from luma dimensions reused blindly.

## 3.2 Block-grid edge

A candidate vertical or horizontal boundary at a position defined by the Deblock4 block grid.

The exact grid origin and step must be extracted from the actual algorithm and made explicit. They must not be inferred from SIMD width.

A spatial grid offset is assumed to be zero under the current design.

This is separate from HolyWu's legacy `aoffset` and `boffset` quant/threshold modifiers. Deblock4 proposes clearer public names in section 3.14; neither legacy value is a spatial offset.

## 3.3 Edge orientation

A **vertical edge** is a vertical line. Filtering it reads and possibly modifies pixels to its left and right.

A **horizontal edge** is a horizontal line. Filtering it reads and possibly modifies pixels above and below.

This naming should be stated because codebases sometimes name kernels by memory traversal rather than geometric edge orientation.

## 3.4 Filter footprint

The complete set of real pixels required to decide and perform filtering at one edge position.

Conceptually:

```text
pN ... p2 p1 p0 | q0 q1 q2 ... qN
```

The exact radii are selected by **filter class**, not globally. A candidate edge is algorithmically eligible only when the complete footprint for its filter class is within the logical plane dimensions.

### Normative indexing convention

This specification fixes one convention, and **all radii, formulas, bounds, and code use it without exception**:

```text
Let e = the edge position
      = the index of the FIRST sample on the q side of the boundary.

The boundary line lies between index e-1 and index e.
```

### Luma/full normal-filter footprint

```text
    p2 p1 p0 | q0 q1 q2
     |  |  |    |  |  |
   e-3 e-2 e-1  e  e+1 e+2

read  footprint: e-3 .. e+2
write footprint: e-2 .. e+1
modified samples: p1, p0, q0, q1
```

Named radii:

```text
luma_read_radius_before  = 3
luma_read_radius_after   = 2
luma_write_radius_before = 2
luma_write_radius_after  = 1
```

### Proper chroma normal-filter footprint

```text
       p1 p0 | q0 q1
        |  |    |  |
      e-2 e-1  e  e+1

read  footprint: e-2 .. e+1
write footprint: e-1 .. e
modified samples: p0, q0 only
```

Named radii:

```text
chroma_read_radius_before  = 2
chroma_read_radius_after   = 1
chroma_write_radius_before = 1
chroma_write_radius_after  = 0
```

`bounds.zig` shall receive or select a footprint descriptor containing these radii. It must never restate them as ad hoc literals.

The proper chroma footprint is a deliberate Deblock4 improvement over HolyWu, which applies its luma normal-filter kernel to chroma. The production design uses the proper chroma kernel; a HolyWu-compat chroma path may exist only as a development/test comparison switch until the chroma quality gate is complete.

## 3.5 Base edge segment

The smallest along-edge group of independent positions that the canonical algorithm treats as one logical unit.

HolyWu's C and SSE4.1 implementations both use four positions per logical segment; this has been verified in source review (see the verified-facts subsection below) and must not be mistaken for a permanent SIMD width restriction.

Several adjacent disjoint base segments along the **same edge** may be concatenated into a wider SIMD batch when they:

- use the same algorithm and parameters;
- do not read or write overlapping pixels;
- have no order dependency between them.


### Verified HolyWu geometry and traversal facts

The current HolyWu C and SSE4.1 implementations have been reported and independently assessed as follows; the implementation phase must pin the exact source tag/commit and preserve file/function/line evidence:

- candidate vertical and horizontal edge positions advance in steps of 4;
- each kernel call processes a base segment of 4 positions along the edge;
- the read footprint is `e-3 .. e+2` and the write footprint is `e-2 .. e+1`, stated in the `e`-relative convention of section 3.4, the four potentially modified samples being `p1`, `p0`, `q0`, `q1`;
- HolyWu traversal is raster-interleaved, with horizontal filtering before vertical filtering at each interior 4x4 position, plus a vertical-only first band and horizontal-only first column;
- adjacent edge columns/rows overlap and are order-dependent;
- consecutive base segments along the same edge are disjoint and may be concatenated into wider SIMD batches.

These facts explain both the need for an explicit canonical schedule and where AVX2 can safely gain width.

## 3.6 SIMD batch

A group of independent edge positions processed simultaneously by one backend.

A SIMD batch is an implementation unit. It is not an algorithmic block boundary and must not change which edges are filtered.

## 3.7 Vector bytes

The intended native SIMD register width for a backend:

```text
SSE4.1 backend: 16 bytes / 128 bits / XMM
AVX2 backend:   32 bytes / 256 bits / YMM
```

## 3.8 Vector lanes

The number of elements in one vector type:

```text
lanes = vector_bytes / sizeof(element_type)
```

Therefore the lane count changes with the arithmetic type.

## 3.9 Intentionally blank

This subsection number is intentionally unused.

It is a renumbering artifact from revision 0.2, when the former 3.9 became 3.10 and the former 3.10 became 3.12 to make room for the new 3.11. A section-title comparison against the revision 0.1 proposal confirms that **no content was omitted** in that renumbering; every subsection present in 0.1 is present here under its shifted number.

The number is retained as blank rather than closed up so that cross-references written against revision 0.2 do not silently shift meaning.

## 3.10 Algorithmic boundary tail

A candidate block-grid edge near a frame boundary whose complete filter footprint does not exist within the logical plane.

This edge is not processed under the proposed boundary policy. The destination remains equal to the source in that region.


## 3.11 Coded transform size versus processing edge-grid pitch

These are different concepts and must never be conflated.

**Coded transform size** describes how a codec represented residual data, for example MPEG-2's 8x8 transform blocks.

**Processing edge-grid pitch** describes the spacing between candidate deblocking edges in the pixels presented to Deblock4.

All edge steps are expressed in the coordinate system of the plane being processed. A chroma step of 8 means eight chroma samples, not eight luma samples.

The internal implementation policies carry per-plane-class values conceptually equivalent to:

```text
luma_edge_step_x
luma_edge_step_y
chroma_edge_step_x
chroma_edge_step_y
```

The public custom-grid names are the shorter `luma_step_x`, `luma_step_y`, `chroma_step_x`, and `chroma_step_y` defined in section 3.14.

A named `grid_mode` is a preset that expands to these primitive values and, where applicable, a midpoint policy. The primitives remain directly controllable through `grid_mode="custom"` for proof modes, expert use, and cases not covered by a named preset.

The grid selection is required—there is no silent default. The token `grid_mode="auto"` is reserved for a future release but is rejected until automatic selection is implemented.

Initial named modes are:

```text
"h264"
"mpeg2_progressive"
"mpeg2_field_separated"
"custom"
"auto"  # reserved; currently rejected
```

For field-separated MPEG-2 4:2:0:

```text
luma_edge_step_x   = 8
luma_edge_step_y   = 4
chroma_edge_step_x = 8
chroma_edge_step_y = 4
```

The luma step-4 vertical candidate grid contains two position classes:

```text
primary  : y mod 8 == 0
midpoint : y mod 8 == 4
```

The midpoint class is necessary because frame-DCT-coded MPEG-2 areas project to a four-field-row pitch after field separation. Field-DCT-coded areas have real boundaries only at the primary positions. The step-4 set is therefore the smallest single candidate set that contains every real luma boundary in mixed material.

The user must not be required to know per-macroblock MPEG-2 `dct_type`; ordinary source filters do not expose it.

Grid origin is zero in the initial implementation. Deblock4 should normally be applied before spatial cropping when coded-grid alignment matters.

## 3.12 SIMD batch tail

Valid, fully in-bounds edge positions that remain after the largest full SSE4.1 or AVX2 batch.

These positions **must still be processed** using:

- a smaller vector;
- one or more base segments;
- or the scalar segment implementation.

Failure to fill a vector is never, by itself, a reason to skip valid filtering.

---

## 3.13 Luma midpoint position class and threshold scale

This subsection applies to the luma plane of field-separated MPEG-2 4:2:0 frame-picture material.

The midpoint is not processed by a second detector. It uses the same canonical activation test as a primary candidate, but with scaled `alpha` and `beta` thresholds:

```text
primary:
    thresholds = thresholds_primary

midpoint:
    thresholds = thresholds_midpoint
```

The public working name is `midpoint_threshold_scale`, with range `0.0 .. 1.0` inclusive:

```text
1.0 -> midpoint alpha/beta equal the primary values; plain step-4 behaviour
0.0 -> midpoint alpha/beta are zero; midpoint activation is impossible
```

Smaller values make midpoint activation harder because the canonical comparisons use `< alpha` and `< beta`.

The mapping is:

```text
S = round_half_up(midpoint_threshold_scale * 65536)

scale_threshold(t, S) =
    (i64(t) * i64(S) + 32768) >> 16
```

Mandatory implementation rules:

1. `S` and all products are evaluated in `i64`.
2. The conversion occurs **once at filter creation**, never in a pixel kernel.
3. Two immutable threshold sets are created:

```text
thresholds_primary:
    alpha = alpha
    beta  = beta
    tc0   = tc0
    one_sample_scale = one_sample_scale

thresholds_midpoint:
    alpha = scale_threshold(alpha, S)
    beta  = scale_threshold(beta, S)
    tc0   = tc0
    one_sample_scale = one_sample_scale
```

4. Only activation thresholds `alpha` and `beta` are scaled. `tc0` and the one-sample addition are not scaled. A midpoint that passes the stricter evidence test is filtered at normal correction strength.
5. The kernel receives or selects one immutable threshold set; it performs no midpoint multiply, conversion, or floating-point operation.
6. The midpoint activation test reads the **current destination state at that point in the canonical schedule**, exactly like every normal edge decision. It must not read the pristine source through a second hot-loop memory stream.

The denominator is intentionally finer than the threshold tables can meaningfully resolve. User documentation shall explain that changes much smaller than approximately `1/256` are unlikely to change 8-bit threshold outcomes, even though the accepted API is a float.

This position-class policy is luma-only for the initial MPEG-2 4:2:0 separated-field preset. The 4:2:0 chroma grid is fixed and has no corresponding midpoint ambiguity.

## 3.14 Public API and meaning-based parameter names

The legacy HolyWu names are familiar to existing users but are not self-explanatory. Deblock4 is a new plugin and is not required to preserve those names as its production API.

The production API uses the following meaning-based names:

```text
deblock4.Deblock4(
    clip                        : vnode         REQUIRED
    grid_mode                   : data          REQUIRED, no default

    strength                    : int           optional, default 25, range 0..60
    boundary_strength_offset    : int           optional, default 0
    side_activity_offset        : int           optional, default 0
    planes                      : int[]         optional, default all
    midpoint_threshold_scale    : float         optional, conditional, range 0.0..1.0
    backend                     : data          optional, default "auto"

    # accepted only when grid_mode = "custom":
    luma_step_x                 : int
    luma_step_y                 : int
    chroma_step_x               : int
    chroma_step_y               : int
    luma_midpoint_enabled       : int           0 or 1
)
```

### Meaning and ranges of the strength controls

The canonical threshold-table domain is `0..60` inclusive.

- `strength`: base deblocking strength index. Range `0..60`; default `25`. It supplies the base index for both threshold axes.
- `boundary_strength_offset`: offsets the index used for `alpha` and `tc0`. Raising it makes the filter accept a wider range of cross-boundary discontinuities as block artifacts and permits a larger correction. It is the meaning-based replacement for HolyWu `aoffset`.
- `side_activity_offset`: offsets the index used for `beta` only. Raising it allows filtering where samples on each side of the boundary vary more. It does not change the correction limit. It is the meaning-based replacement for HolyWu `boffset`.
- `midpoint_threshold_scale`: multiplies only midpoint `alpha`/`beta` activation thresholds. It does not reduce correction strength after activation.
- `backend`: readable backend selector rather than a numeric optimisation code.

The two resolved table indices are independent:

```text
boundary_strength_index = strength + boundary_strength_offset
side_activity_index     = strength + side_activity_offset
```

Each must remain within `0..60`. Therefore, for the supplied `strength`, each offset independently has the legal range:

```text
-strength .. 60-strength
```

Out-of-range values are errors and are never silently clamped. An error message shall state the actual permitted range, for example:

```text
side_activity_offset must be between -25 and 35 for strength=25
```

There is no additional combined restriction because the two resolved indices do not interact.

Threshold-table domain facts inherited from the canonical tables:

```text
alpha[index] == 0 for index 0..15; first nonzero alpha[16] = 4
beta[index]  == 0 for index 0..15; first nonzero beta[16]  = 2
tc0[index]   == 0 for index 0..20; first nonzero tc0[21]   = 1
```

Consequences:

- if either resolved index is `<= 15`, its activation threshold is zero and filtering cannot activate;
- effective filtering therefore begins at resolved index `16` on both axes;
- `boundary_strength_index` values `16..20` have nonzero `alpha` but zero base `tc0`; this does **not** imply no correction, because side-dependent one-sample additions may still permit a nonzero delta.

### Legacy-to-Deblock4 translation table

| HolyWu/current name | Deblock4 name | Drives | Meaning |
|---|---|---|---|
| `quant` | `strength` | both base indices | Base deblocking strength index |
| `aoffset` | `boundary_strength_offset` | `alpha` + `tc0` | Cross-boundary acceptance and correction-limit offset |
| `boffset` | `side_activity_offset` | `beta` | Per-side flatness/activity offset only |
| `opt` | `backend` | runtime dispatch | Readable backend selection |
| `grid` (design draft) | `grid_mode` | grid policy | Required named grid/policy selection |
| `midpoint_strictness` (design draft) | `midpoint_threshold_scale` | midpoint `alpha`/`beta` | 0 disables midpoint activation; 1 gives parity |
| `luma_midpoint` (design draft) | `luma_midpoint_enabled` | custom luma policy | Enables primary/midpoint classification for a custom luma grid |

The production API should accept the new names only. The translation table is for migration and conceptual comparison, not a requirement to support duplicate aliases. Supporting both name sets would create avoidable precedence and conflict rules.

### Accepted `grid_mode` values

| Value | Luma steps | Chroma steps | Midpoint class | Status |
|---|---:|---:|---|---|
| `"h264"` | 4x4 | 4x4 | none | Initial |
| `"mpeg2_progressive"` | 8x8 | 8x8 | none | Initial; valid for 4:2:0 and 4:2:2 |
| `"mpeg2_field_separated"` | 8x4 | 8x4 | luma only | Initial; 4:2:0 only, error on 4:2:2 |
| `"custom"` | explicit | explicit | from `luma_midpoint_enabled` | Initial expert/proof path |
| `"auto"` | reserved | reserved | reserved | Token reserved; reject until implemented |

Every step is measured in the relevant plane's own sample coordinates.

Custom primitives are accepted only with `grid_mode="custom"`. Supplying a primitive with a named preset is an error. All four step values are required in custom mode so the script is fully self-documenting.

`midpoint_threshold_scale` is accepted only when the resolved policy has a luma midpoint class. Supplying it otherwise is an error. Its accepted range is `0.0 .. 1.0` inclusive; values outside the range are rejected rather than clamped.

Production `backend` values are:

```text
"auto"    # highest available supported backend
"avx2"    # error if unavailable
"sse41"   # error if unavailable
"scalar"  # always available canonical reference; substantially slower
```

Forcing an unsupported hardware backend is an error. The scalar backend is production-visible because it is the most useful diagnostic for separating an algorithm problem from a backend-identity failure.

The filter writes the always-on audit frame properties specified in section 13.5.

# 4. Canonical-algorithm requirements

## 4.1 The scalar implementation is executable specification

The scalar implementation shall be written first.

It shall define:

- edge-grid positions;
- edge eligibility;
- vertical/horizontal processing order;
- threshold calculations;
- integer widening;
- signed arithmetic;
- rounding;
- shifts;
- clipping;
- sample-domain scaling;
- float operation order;
- selected-plane behaviour;
- unchanged-border behaviour.

SIMD code is correct only when it matches the scalar implementation.

Comments in the scalar implementation must preserve arithmetic and ordering invariants clearly enough that a future maintainer cannot silently change the algorithm while "optimising" it.

## 4.2 Do not use HolyWu as the only oracle

Validation must be divided into two independent questions.

### Algorithm/backend correctness

```text
scalar == SSE4.1 == AVX2
```

This is mandatory.

### Quality/regression comparison

```text
HolyWu versus canonical Deblock4
```

Differences may be acceptable, but must be:

- measurable;
- visually examined;
- explained by an intentional schedule or arithmetic decision;
- not caused by a backend discrepancy.

## 4.3 SIMD width must not define output

Given identical input and parameters, the output must not depend on:

- whether the CPU has AVX2;
- whether the CPU only has SSE4.1;
- where a vector batch ends;
- source/destination row alignment;
- stride;
- thread scheduling;
- number of VapourSynth worker threads.

---

## 4.4 Future automatic-strength extensibility guards

No automatic-strength analyser is implemented in the initial Deblock4 work. The initial design shall nevertheless preserve the following low-cost extension points.

### Thresholds are explicit kernel inputs

The scalar and SIMD segment kernels receive a threshold set directly:

```text
filter_segment(samples..., thresholds)
```

They shall not fetch thresholds from the filter instance:

```text
filter_segment(samples..., instance)
```

This keeps fixed-strength and future per-block-strength filtering on the same proven mathematics. A future driver changes which threshold set it supplies; it does not require rewriting the scalar, SSE4.1, and AVX2 kernels.

### Future derived thresholds remain inside the proved domain

Any future automatic-strength analyser must clamp derived values to the parameter domain assumed by the arithmetic range proof, or the complete range proof must be re-derived for the wider domain.

### An analyser is part of the canonical algorithm

If an analyser can affect output, its scalar and vector forms are subject to the same identity requirement:

```text
scalar == SSE4.1 == AVX2
```

It belongs under `spec.zig`/canonical validation, not in an unproved convenience helper.

### Strength maps use an unmodified-source pre-pass

A future per-block strength map is different from the midpoint activation test:

```text
midpoint activation:
    fused into filtering;
    reads current canonical destination state

future strength map:
    computed in a pre-pass over the unmodified input plane;
    completed before any filtering begins
```

The map is per-call scratch, never per-instance mutable state, because one filter instance may serve concurrent `fmParallel` calls.

### Shared kernel, separate driver

The fixed-strength driver and a future automatic-strength driver may be separate implementations:

```text
fixed driver:
    filter using immutable threshold sets

automatic driver:
    analyse unmodified plane
    build per-call strength map
    filter using selected threshold sets
```

The mathematical kernels remain shared. Driver-layer duplication is explicitly acceptable when it makes ownership, ordering, and proof clearer.

# 5. Candidate processing schedules and quality gate

## 5.1 Why schedule matters

Deblocking is not necessarily a set of independent operations.

An edge filter may modify pixels that a later edge filter reads. Therefore:

```text
filter(A), then filter(B)
```

can produce different pixels from:

```text
filter(B), then filter(A)
```

This can alter:

- threshold decisions;
- filter activation;
- clipping magnitude;
- final pixel values;
- directional appearance near edge intersections.

A processing schedule is therefore part of the algorithm, not merely loop organisation.

## 5.2 Schedule A: verified HolyWu-equivalent schedule

Before comparison, the current HolyWu source must be inspected directly and its real schedule documented with function and loop references.

Claude's source review identifies a raster-interleaved schedule with horizontal filtering before vertical filtering at each interior 4x4 position. The implementation phase must pin the exact HolyWu tag/commit and preserve file/function/line references before this becomes the permanent source citation.

The scalar Schedule A prototype shall reproduce:

- the same candidate edge positions;
- the same edge traversal order;
- the same vertical/horizontal interleaving;
- the same in-place dependency sequence;
- the same formulas and parameter scaling.

The purpose is to isolate schedule differences, not to reproduce HolyWu's SSE implementation details.

## 5.3 Schedule B: candidate canonical Deblock4 two-pass schedule

The current candidate schedule is:

```text
For each selected plane:

    Pass 1: vertical edges
        edge columns processed from left to right
        independent positions along each edge processed in batches

    Pass 2: horizontal edges
        edge rows processed from top to bottom
        independent positions along each edge processed in batches
```

This is best described as **codec-informed**, not as literal H.264 compliance.

Codec standards commonly define vertical-before-horizontal processing and explicitly preserve edge order because pixels may be filtered more than once. However, many codecs define that order within macroblocks or coding units, not necessarily as one whole-plane vertical pass followed by one whole-plane horizontal pass.

Deblock4 is a post-processing filter and may define its own schedule, provided it is:

- deterministic;
- quality-validated;
- backend-independent;
- precisely documented.

## 5.4 Dependency rules under Schedule B

### Vertical pass

Adjacent vertical block-grid edges may have overlapping horizontal footprints.

Therefore:

- process vertical edge columns in canonical left-to-right order;
- do not process dependent neighbouring edge columns simultaneously merely to fill AVX2;
- vectorise along the edge direction, normally down the plane;
- within one edge, batch only disjoint along-edge segments.

### Horizontal pass

Adjacent horizontal luma block-grid edges may have overlapping vertical footprints.

Therefore for luma:

- process horizontal edge rows in canonical top-to-bottom order;
- do not process dependent neighbouring edge rows simultaneously merely to fill AVX2;
- vectorise along the edge direction, normally across the plane;
- within one edge, batch only disjoint along-edge segments.

### Proper chroma same-orientation independence

For the proper chroma normal filter, an edge at `e` writes only `e-1..e`. The next edge at `e + edge_step` reads `e + edge_step - 2 .. e + edge_step + 1`. For every supported `edge_step >= 3`, these ranges do not overlap.

Consequently, within one orientation:

- adjacent vertical chroma edges are independent;
- adjacent horizontal chroma edges are independent;
- a chroma backend may batch across edge positions as well as along one edge.

This relaxation does **not** remove the cross-orientation dependency. A vertical chroma pass can modify pixels later read by the horizontal chroma pass. The selected canonical pass order therefore still applies between orientations.

## 5.5 Required scalar A/B assessment

Schedule B shall not become final merely because it is easier to vectorise.

Build two scalar implementations using identical:

- formulas;
- thresholds;
- sample-domain conversions;
- clipping;
- boundary policy.

Only the schedule may differ.

### Synthetic tests

Include at least:

- isolated vertical block steps;
- isolated horizontal block steps;
- vertical/horizontal crossings;
- diagonal lines through block intersections;
- checkerboards;
- one-pixel and two-pixel lines;
- text and subtitles;
- flat gradients;
- high-frequency texture;
- film grain/noise;
- maximum contrast;
- values immediately below, at, and above every threshold.

### Real material

Include:

- visibly blocky MPEG-2;
- low-bitrate H.264/AVC;
- luma-dominant blocking;
- chroma-dominant blocking;
- animation;
- live action;
- flat backgrounds;
- detailed foliage/hair;
- diagonal structures;
- interlaced material only after field separation, consistent with project scope;
- 720x288 luma and 360x144 chroma production field dimensions;
- edge-grid candidates 4x4, 8x8, and 8x4 where applicable;
- repeated application for two through five passes;
- directional-bias comparison using Gray or 4:4:4 transpose-controlled material.

### Clean-reference test

Where possible:

1. start from a clean source;
2. encode it deliberately at low quality;
3. decode the result;
4. apply Schedule A and Schedule B;
5. compare both filtered results against the clean source.

### Quality observations

Measure or inspect:

- discontinuity reduction at known block boundaries;
- detail retention away from block boundaries;
- haloing;
- directional smearing;
- staircasing;
- diagonal damage;
- text damage;
- grain destruction;
- maximum per-sample change;
- mean absolute change;
- PSNR and SSIM against a clean reference;
- optional perceptual metrics, used as supporting evidence only;
- visual crops around vertical/horizontal intersections.

### Acceptance rule

Adopt Schedule B only when:

- it shows no systematic new artifact;
- it is visually equal or better on representative material;
- it does not obtain a better blockiness score merely by excessive blurring;
- any difference from HolyWu is deliberate and explainable;
- the scalar implementation is stable enough to become the canonical oracle.

If Schedule B is not clearly equal or better, retain the verified HolyWu-equivalent schedule and optimise within its dependency constraints.

---


## 5.6 Schedule C is not in the initial implementation plan

A macroblock-local H.264-style schedule—vertical edges of one macroblock followed by its horizontal edges, with macroblocks traversed in raster order—is a legitimate third schedule.

It is deliberately deferred because:

- MPEG-2 has no in-loop deblocking order to reproduce;
- it offers no demonstrated quality hypothesis for this post-processing filter;
- it reintroduces cross-macroblock dependencies that restrict wide batching;
- it would create a third quality-test arm before Schedules A and B have answered the real design question.

Schedule C may be reconsidered only if the Schedule A/B comparison reveals a quality issue that it could plausibly resolve.


# 6. Corrected frame-boundary policy

## 6.1 Normative rule

For each plane, process every candidate block-grid edge whose **complete algorithmic footprint** lies inside the plane.

Do not process a candidate edge when any required source pixel would lie:

- before column 0;
- at or after plane width;
- before row 0;
- at or after plane height.

Leave such unsupported extreme-edge regions unchanged from the source.

## 6.2 Bounds must be derived from the algorithm

Do not encode boundary logic as a modulus guess or a hard-coded minimum extent.

For a selected filter class, derive eligibility from its footprint descriptor:

```text
eligible(e, footprint, extent)
    <=> e - footprint.read_radius_before >= 0
    AND e + footprint.read_radius_after  <= extent - 1
```

The candidate edge positions are multiples of `edge_step` along the relevant axis, filtered by that eligibility test.

```text
first_candidate(edge_step, read_radius_before)
    = edge_step * ceil(read_radius_before / edge_step)
```

Worked luma values:

```text
read_radius_before = 3
read_radius_after  = 2

edge_step = 4 -> first_candidate = 4
edge_step = 8 -> first_candidate = 8
```

Worked proper-chroma values:

```text
read_radius_before = 2
read_radius_after  = 1

edge_step = 4 -> first_candidate = 4
edge_step = 8 -> first_candidate = 8
```

Every value is derived separately:

- per axis;
- per plane;
- per plane/filter class;
- from that plane's own sample-coordinate edge step.

`bounds.zig` must consume the named footprint and grid policy. A change to a formula or filter class must not leave stale literals in the bound calculations.

## 6.3 No whole-frame padding or crop

Deblock4 shall not invoke a whole-frame `resize.Point`, custom full-frame padding pass, or crop merely to make dimensions divisible by a block or vector width.

Reasons:

- it introduces extra full-frame memory traffic;
- it invents samples outside the original plane;
- it complicates graph construction and frame ownership;
- it is unnecessary when safe loop bounds can be calculated once;
- it may consume a meaningful share of any AVX2 gain;
- it hides the real algorithmic boundary rule.

## 6.4 No reliance on VapourSynth row padding

VapourSynth exposes:

- logical plane width;
- logical plane height;
- stride;
- read/write pointers.

Stride tells the implementation how far to move between rows. It must not be treated as a guarantee that a particular number of bytes after logical width are safe image padding for arbitrary vector over-read or writes.

The implementation shall therefore:

- never require undocumented right-edge padding;
- never read a full vector beyond the logical row merely because stride is larger;
- never write mirrored or replicated data into allocator-owned row padding as part of the algorithm;
- never assume extra bottom rows exist.

## 6.5 Small planes

When a plane/orientation is too small to contain any complete footprint:

- produce an empty candidate set for that orientation;
- do not attempt partial filtering;
- do not invent pixels;
- continue to process the other orientation if it qualifies;
- pass the plane through unchanged if neither orientation qualifies.

### The minimum extent is derived from step and footprint

```text
min_extent(edge_step, footprint)
    = first_candidate(edge_step, footprint.read_radius_before)
      + footprint.read_radius_after
      + 1
```

Worked luma values:

```text
edge_step = 4 -> min_extent = 4 + 2 + 1 = 7
edge_step = 8 -> min_extent = 8 + 2 + 1 = 11
```

Worked proper-chroma values:

```text
edge_step = 4 -> min_extent = 4 + 1 + 1 = 6
edge_step = 8 -> min_extent = 8 + 1 + 1 = 10
```

The implementation must not contain a universal literal such as `7`; it is valid only for one luma/step combination.

# 7. Corrected SIMD-tail policy

## 7.1 Normative rule

All algorithmically valid edge positions must be filtered, regardless of whether their count fills the native SIMD width.

The processing shape is:

```text
valid positions along one edge
    |
    +-- full native vector batches
    |
    +-- remaining valid positions:
            smaller vector, base segment, or scalar cleanup
```

## 7.2 Never confuse the two tail classes

```text
Incomplete algorithmic footprint:
    leave unchanged.

Complete footprint but incomplete AVX2/SSE batch:
    process it.
```

This distinction is essential for backend identity.

Otherwise the AVX2 backend could skip different pixels from the SSE4.1 backend, which would make output CPU-dependent.

## 7.3 Preferred cleanup hierarchy

The exact fastest cleanup path should be benchmarked, but correctness should permit:

### AVX2 backend

1. full 256-bit batches;
2. optional 128-bit cleanup batch when profitable;
3. scalar/base-segment cleanup for the final valid remainder.

### SSE4.1 backend

1. full 128-bit batches;
2. scalar/base-segment cleanup for the final valid remainder.

The cleanup path must use the same canonical formulas, rounding, clipping, and current in-place image state.

## 7.4 AVX2 masked load/store warning

AVX2 masked integer loads/stores are not a universal byte-tail solution. Available instructions operate at particular element granularities and may complicate byte-oriented deblocking.

Do not adopt masked tails merely because they sound branchless.

A short scalar or smaller-vector cleanup outside the hot full-vector loop is usually easier to prove and may be faster.

## 7.5 No per-element boundary branch in the hot loop

Boundary and batch limits should be calculated before entering the full-vector loop.

The hot kernel should receive only valid work.

This means Option 2 does not require a branch for every vector element. It requires correct loop bounds and a separate cleanup path.

---

# 8. Supported formats and arithmetic policy

## 8.1 Intended coverage

At minimum, retain the current HolyWu-advertised coverage:

- integer samples with 8-16 meaningful bits;
- 32-bit floating-point samples;
- independently selectable planes.

The design should accommodate planar:

- Gray;
- YUV with supported subsampling;
- RGB.

Every plane is processed using its actual dimensions.

## 8.2 Storage type is not arithmetic type

VapourSynth integer formats above 8-bit commonly use 16-bit storage. The meaningful bit depth and storage width must not be confused.

Likewise, loading `u8` does not mean the complete filter arithmetic should remain `u8`.

## 8.3 Proposed arithmetic families

| Input family | Load/storage representation | Proposed arithmetic representation | Status |
|---|---|---|---|
| 8-bit integer | `u8` | `i16` for signed intermediates | Candidate; complete range proof required |
| 9-12-bit integer | `u16` storage | candidate `i16` for signed intermediates | Candidate; complete range proof required |
| 13-16-bit integer | `u16` storage | `i32` for signed intermediates | Recommended |
| 32-bit float | `f32` | strict `f32` | Recommended |

## 8.4 Complete range proof required for every `i16` integer path

Bounding one familiar delta expression is not enough.

Before adopting `i16` for any bit depth, prove every intermediate for every branch, including:

- all subtractions;
- shifted differences;
- threshold calculations;
- average calculations;
- normal-filter branches;
- parameter scaling;
- additions before right shift;
- signed rounding biases;
- clipping deltas;
- any products;
- any conversion from public strength/offset parameters;
- worst-case values when input samples are 0 and maximum.

The proof must state:

- mathematical minimum and maximum;
- actual Zig type;
- whether overflow is impossible;
- exact shift semantics;
- exact division/rounding semantics;
- the assumed legal domain of every public and derived threshold parameter.

Zig integer overflow in ordinary arithmetic is not an acceptable implementation technique. Do not rely on ReleaseFast wraparound.

Any future automatically derived threshold must be clamped to the domain assumed by this proof, or the complete proof must be re-derived and all scalar/SIMD tests repeated for the wider domain.

## 8.5 Higher-bit-depth scaling

For 13-16-bit integer formats:

- use native bit depth;
- scale thresholds exactly as specified by the canonical algorithm;
- use `i32` intermediates unless a stronger proof supports narrower types;
- clip final output to the valid sample domain for the format;
- do not reduce to 8-bit internally merely for SIMD convenience.

## 8.6 Floating-point policy

Use strict floating-point mode.

Do not enable optimized/fast-math in the canonical float kernels because it may permit:

- reassociation;
- reciprocal substitution;
- loss of signed-zero distinctions;
- FMA contraction;
- other result-changing transformations.

An AVX2 object must not acquire FMA merely because AVX2 is enabled. Strict mode and the minimal target-feature closure shall reinforce one another.

Exceptional-value policy:

1. The finite-value check is evaluated **per edge position**, over exactly that position's complete read footprint:
   - six samples for luma/full normal filtering;
   - four samples for proper chroma filtering.
2. If any sample in that footprint is NaN or positive/negative infinity, that edge position is left unmodified.
3. The decision is independent for every edge position. SIMD backends implement it with per-lane masking and must never reject an entire backend batch because one lane is non-finite.
4. Samples left unchanged preserve their original bit patterns, including NaN payloads, infinities, and signed zero.
5. If finite arithmetic produces numerical zero, the canonical scalar expression and strict operation order define its sign; every backend must match that bit pattern.

Strict floating-point mode fixes operation ordering and prevents reassociation/contraction. IEEE-754 compares `-0.0` and `+0.0` as equal, so activation comparisons require no backend-specific signed-zero rule.

Deblock4 does not set or modify MXCSR. Flush-to-zero and denormals-are-zero state is inherited from the host process. The algorithm and tests shall not depend on subnormal preservation; backend identity is required under the same inherited MXCSR state. Nominal-range float video values are far above the affected magnitudes.

Samples outside the nominal video range but still finite are processed under the same canonical formulas unless a later format policy states otherwise.

## 8.7 Integer and float kernels may differ internally

"One canonical algorithm" does not require one identical source expression for every sample family.

It requires equivalent documented decisions in each numeric domain.

Separate specialised kernels are acceptable where needed for:

- integer threshold scaling;
- signed intermediate width;
- float comparison behaviour;
- packing and clipping.

---

## 8.8 Proper chroma normal filter

Deblock4's production chroma path shall use a proper H.264-derived chroma normal filter rather than HolyWu's luma-on-chroma behaviour. This is settled-by-design; it remains explicitly unvalidated-by-measurement until the chroma quality gate passes.

For integer paths, after the normal activation conditions pass:

```text
abs(p0 - q0) < alpha
abs(p1 - p0) < beta
abs(q1 - q0) < beta
```

define:

```text
tc = tc0 + one_sample_scale

delta = clip3(
    -tc,
     tc,
    (((q0 - p0) << 2) + p1 - q1 + rounding_bias) >> 3
)

p0' = clip_to_sample_domain(p0 + delta)
q0' = clip_to_sample_domain(q0 - delta)
```

Only `p0` and `q0` are written. `p1` and `q1` are read for the decision/delta but are never modified; `p2` and `q2` are not read.

`one_sample_scale` is one unit in the bit-depth-scaled arithmetic domain. At 8-bit it is 1. Higher-bit-depth and float forms must be defined by the scalar specification and included in the complete range/identity proof.

The production API shall not offer "filter chroma using the luma formula" as a normal quality option. A development-only HolyWu-compat switch is permitted solely for:

- A/B validation;
- regression localisation;
- documenting the deliberate chroma divergence.

That switch must not become an accidental permanent public contract.

---

# 9. Correct Zig `@Vector` model

## 9.1 `@Vector` counts elements, not bytes

The controlling conceptual backend property is:

```zig
const BackendConfig = struct {
    vector_bytes: comptime_int,
};
```

Conceptual instances:

```zig
const sse41 = BackendConfig{ .vector_bytes = 16 };
const avx2  = BackendConfig{ .vector_bytes = 32 };
```

Then:

```zig
fn Vec(comptime cfg: BackendConfig, comptime T: type) type {
    comptime {
        if (cfg.vector_bytes % @sizeOf(T) != 0)
            @compileError("vector width is not divisible by element size");
    }

    return @Vector(cfg.vector_bytes / @sizeOf(T), T);
}
```

This is illustrative, not frozen Zig 0.16 syntax.

## 9.2 Derived native-width vector types

| Element type | SSE4.1 / 16 bytes | AVX2 / 32 bytes |
|---|---:|---:|
| `u8` | `@Vector(16, u8)` | `@Vector(32, u8)` |
| `i16` | `@Vector(8, i16)` | `@Vector(16, i16)` |
| `u16` | `@Vector(8, u16)` | `@Vector(16, u16)` |
| `i32` | `@Vector(4, i32)` | `@Vector(8, i32)` |
| `f32` | `@Vector(4, f32)` | `@Vector(8, f32)` |

The current README's flat:

```text
SSE4.1 = @Vector(16, ...)
AVX2   = @Vector(32, ...)
```

is correct only when the omitted element type is one byte wide.

## 9.3 Load width and arithmetic width may differ

An 8-bit path may:

1. load 16 or 32 `u8` samples;
2. widen them into two or more `i16` vectors;
3. calculate in `i16`;
4. clip;
5. narrow and store.

Therefore no single lane count describes the entire kernel.

The specification should distinguish:

- input load lanes;
- arithmetic lanes;
- output store lanes;
- logical base segments per batch.

## 9.4 Avoid over-wide vectors

Zig documentation states that vectors longer than the native SIMD width may be lowered into multiple instructions, and unsupported operations may scalarise.

Therefore:

- keep principal arithmetic vector types at the intended backend width;
- do not use `@Vector(16, i32)` and assume it is "AVX2";
- inspect generated assembly;
- treat compiler lowering as evidence, not assumption.

## 9.5 Safe vector load/store representation

Zig documents that arrays have defined byte layout while vector memory layout is not a basis for arbitrary pointer casting.

Do not build the memory interface around `@ptrCast` from pixel pointers to vector pointers.

Prefer a defined array/slice-to-vector conversion pattern, conceptually:

```zig
const values: [N]T = ptr[offset..][0..N].*;
const vector: @Vector(N, T) = values;
```

and the reverse for stores, subject to actual Zig 0.16 syntax and assembly verification.

This also makes bounds explicit.

## 9.6 Shared math, specialised movement

Use `@Vector` for operations such as:

- signed differences;
- absolute differences;
- comparisons;
- boolean masks;
- threshold selection;
- shifts;
- clipping/select operations.

Allow specialised code for:

- widening and narrowing;
- transpose;
- cross-vector shuffle;
- lane packing;
- awkward vertical loads;
- final stores.

Use `@shuffle`, `@select`, and other Zig vector operations first. Use target-specific intrinsics or carefully isolated inline assembly only when measured code generation is materially inferior.

---

# 10. Horizontal and vertical SIMD structure

## 10.1 Shared mathematical interface

The mathematical kernel should operate on already-arranged vectors representing the required footprint, conceptually:

```text
p2, p1, p0, q0, q1, q2, ...
```

It should return:

```text
updated p-side and q-side values
```

The same mathematical decision rules should serve horizontal and vertical edges.

## 10.2 Vertical-edge adapter

For a vertical edge:

- the before/after footprint lies across columns;
- independent positions lie down rows;
- loading several rows may require gather-like scalar loads, transpose, or a tiled transpose;
- the AVX2 implementation may process more independent rows per batch than SSE4.1;
- the luma edge column order remains canonical left-to-right;
- proper chroma edges of the same orientation may also be batched across independent edge columns.

A wider AVX2 luma adapter must not batch neighbouring dependent edge columns merely to fill YMM registers. A proper chroma adapter may do so only under the independence proof in section 5.4.

## 10.3 Horizontal-edge adapter

For a horizontal edge:

- the before/after footprint lies across rows;
- independent positions lie across columns;
- each required row is contiguous;
- wide loading and batching across x is generally more direct;
- the luma edge row order remains canonical top-to-bottom;
- proper chroma edges of the same orientation may also be batched across independent edge rows.

## 10.4 Transpose size is an implementation decision

A 4x4, 8x4, 8x8, 16x8, or other transpose shape must not be selected by analogy alone.

Choose it based on:

- base segment length;
- arithmetic type;
- backend vector width;
- required source columns/rows;
- overlap;
- generated assembly;
- measured performance.

## 10.5 In-place state must match scalar order

The destination is processed in the canonical schedule.

Each vector batch must read the same current pixel state that the scalar implementation would read at that point.

It is not valid to preload a large tile, process several dependent edges from the stale tile, and then store everything later if the scalar schedule would have allowed earlier stores to affect later reads.

Temporary registers and scratch tiles are permitted only when they preserve canonical dependencies.

---

# 11. Proposed source/module architecture

The current README module list is a useful start but should be expanded so that the scalar oracle, bounds, format dispatch, and backend-specific movement have explicit homes.

A proposed layout is:

```text
src/
    main.zig
    vapoursynth_api.zig
    filter_create.zig
    frame_process.zig

    cpu_detect.zig
    dispatch.zig
    backend_api.zig

    deblock/
        spec.zig
        grid_policy.zig
        bounds.zig
        scalar.zig
        common_math.zig
        vector_types.zig
        sse41.zig
        avx2.zig

    # deferred future work, not built initially:
    auto_strength_driver.zig

tests/
    scalar_vectors.zig
    backend_equivalence.zig
    boundary_safety.zig
    schedule_ab.zig
    dispatch_tests.zig
    assembly_checks/
    corpus/
```

Names may change, but responsibilities should remain distinct.

## 11.1 `main.zig`

Responsibilities:

- plugin entry point;
- plugin registration;
- public function registration;
- no AVX2-only instructions;
- no heavy pixel logic.

Target:

```text
portable project baseline for supported x86-64 Windows systems
```

## 11.2 `vapoursynth_api.zig`

Responsibilities:

- C API declarations/import;
- narrow wrappers around VapourSynth API4 calls;
- frame pointer/format extraction;
- no algorithm decisions.

## 11.3 `filter_create.zig`

Responsibilities:

- parse and validate the meaning-based public parameters in section 3.14;
- validate constant format;
- determine selected planes;
- expand `grid_mode` into explicit per-plane policies;
- compute base thresholds in a wide generic creation path;
- compute `thresholds_primary` and, where applicable, `thresholds_midpoint` once in `i64`;
- derive immutable per-instance configuration;
- choose format-family kernel entry points;
- no whole-frame padding/crop graph insertion;
- no mutable cross-frame state.

## 11.4 `frame_process.zig`

Responsibilities:

- request one source frame;
- create a destination semantically identical to the source;
- reuse or copy unselected planes appropriately;
- call the selected backend for selected planes;
- return one output frame;
- preserve fmParallel-safe, 1-in/1-out behaviour.

## 11.5 `deblock/spec.zig`

This is the algorithm contract in code.

Responsibilities:

- edge steps and grid origin;
- exact per-plane/filter-class footprint radii;
- luma and proper-chroma formulas;
- `ThresholdSet` definitions and legal domains;
- threshold-table construction;
- rounding rules;
- clipping rules;
- schedule enumeration;
- supported bit depths/sample families;
- any future automatic-strength analyser that can affect output;
- comments preserving ordering and arithmetic invariants.

The segment mathematics shall consume explicit `ThresholdSet` values. It shall not fetch thresholds from filter-instance state.

No target-specific SIMD instructions.

## 11.6 `deblock/grid_policy.zig`

Responsibilities:

- validate the required `grid_mode`;
- reject the reserved but unimplemented `grid_mode="auto"` with a specific error;
- expand named presets into per-plane-class primitive steps;
- enforce the custom-versus-preset precedence rules in section 3.14;
- classify MPEG-2 luma primary versus midpoint positions;
- select `thresholds_primary` or `thresholds_midpoint` by position class;
- expose immutable per-instance plane policies;
- keep source-container and recorder-brand guesses out of the hot path.

Threshold scaling itself is performed once by the generic creation path in `i64`. `grid_policy.zig` does not multiply thresholds in the pixel loop.

It does not perform pixel filtering or bounds checks.

## 11.7 `deblock/bounds.zig`

Responsibilities:

- derive eligible vertical edge columns per plane and filter class;
- derive eligible horizontal edge rows per plane and filter class;
- consume per-plane-class footprint radii and edge steps;
- derive along-edge valid extent;
- derive full-vector batch count;
- derive valid SIMD tail;
- guarantee no out-of-bounds read/write;
- remain independent of backend output semantics.

It should expose plans/iterators that make the distinction between:

- skipped incomplete-footprint edges;
- valid full batches;
- valid tail positions.

## 11.8 `deblock/scalar.zig`

Responsibilities:

- canonical executable reference;
- scalar vertical-edge segment;
- scalar horizontal-edge segment;
- canonical schedule traversal;
- scalar tail used by SIMD backends where appropriate;
- diagnostic/reference build support.

This implementation must prioritise clarity and proof over speed.

## 11.9 `deblock/common_math.zig`

Responsibilities:

- shared generic formulas where Zig permits scalar/vector genericity cleanly;
- masks;
- deltas;
- threshold decisions;
- clipping;
- no source-pointer traversal;
- no hidden schedule.

It may be instantiated separately into scalar, SSE4.1, and AVX2 objects.

Avoid making genericity itself a requirement when it obscures arithmetic proof. Separate format-family helpers are acceptable.

## 11.10 `deblock/vector_types.zig`

Responsibilities:

- backend `vector_bytes` configuration;
- derived vector type helpers;
- compile-time width assertions;
- shared widening/narrowing helpers where appropriate;
- no runtime CPU detection.

## 11.11 `deblock/sse41.zig`

Responsibilities:

- SSE4.1-targeted entry points;
- 16-byte vectors;
- horizontal adapters;
- vertical adapters/transposes;
- SSE-tail to scalar/base-segment cleanup;
- no AVX/AVX2 instructions.

## 11.12 `deblock/avx2.zig`

Responsibilities:

- AVX2-targeted entry points;
- 32-byte vectors;
- horizontal adapters;
- vertical adapters/transposes;
- optional 128-bit cleanup or scalar/base-segment cleanup;
- preserve canonical order;
- strict float rules;
- correct transition back to non-AVX code.

## 11.13 `backend_api.zig`

Define a stable non-vector ABI between generic dispatch code and CPU-specific objects.

Conceptually:

```text
KernelVTable
    process_u8_plane
    process_u16_plane
    process_f32_plane
```

The object boundary should pass:

- pointers;
- strides;
- plane dimensions;
- bit depth;
- immutable grid/plane policy;
- an explicit immutable `ThresholdSet` or threshold-set pointer.

Kernels shall not receive a general filter-instance pointer merely to fetch thresholds.

Do not expose Zig vector types in the cross-object ABI.

A C-compatible ABI or equally stable explicit ABI should be used at the object boundary, subject to Zig 0.16 syntax.

## 11.14 `cpu_detect.zig`

Responsibilities:

- detect actual CPU features;
- detect operating-system AVX/YMM state support;
- return a small backend capability enum;
- no image processing.

Do not freeze an unstable Zig compiler-internal API into the specification prematurely.

## 11.15 `dispatch.zig`

Responsibilities:

- select the best fully supported backend once;
- build an immutable function table;
- allow forced backend selection for tests;
- reject forced AVX2 on unsupported CPU/OS combinations;
- no per-pixel feature branches.

For each filter instance, it may additionally preselect the format-family function pointer so normal frame processing does not repeatedly branch on CPU and sample type.

---

# 12. Compilation and one-DLL runtime dispatch

## 12.1 Required binary shape

One `DEBLOCK4.DLL` shall contain:

- generic plugin/API/dispatch code;
- scalar reference or scalar fallback/test code;
- SSE4.1 code;
- AVX2 code.

The generic DLL entry and registration path must execute safely on the minimum supported CPU before dispatch.

## 12.2 Compile CPU-specific objects separately

The conceptual build is:

```text
generic objects
    target: supported x86-64 baseline

SSE4.1 object(s)
    target: baseline + required SSE4.1 feature closure

AVX2 object(s)
    target: explicit required AVX2 feature closure
            OR x86_64_v3, if and only if dispatch checks all v3 requirements

link all objects into one DLL
```

The same shared source may be instantiated separately into SSE4.1 and AVX2 objects. Source sharing does not mean one generic machine-code object.

## 12.3 Important `x86_64_v3` dispatch rule

`x86_64_v3` is broader than "AVX2 exists".

It includes a feature set such as AVX2, FMA, BMI1, BMI2, and others.

Therefore:

- if the AVX2 object is compiled for `x86_64_v3`, dispatch must verify the complete required v3 feature set and OS vector-state support;
- checking only the AVX2 CPUID bit is insufficient;
- the preferred initial direction is a tested minimal explicit feature closure, expected to be the required SSE/v2 support plus AVX and AVX2, with dispatch checking the same closure;
- FMA shall not be enabled merely because AVX2 is enabled; strict float mode remains mandatory.

The README should not say:

```text
compile x86_64_v3
dispatch when has_avx2
```

without reconciling this mismatch.

## 12.4 AVX operating-system state

AVX/AVX2 dispatch must account for:

- CPU XSAVE support;
- CPU OSXSAVE support;
- CPU AVX support;
- CPU AVX2 support;
- XGETBV state showing XMM and YMM state enabled.

The exact detection implementation may use:

- a proven Zig standard-library facility available in the selected Zig revision;
- or a small explicit CPUID/XGETBV implementation.

Build-time target resolution must not be confused with runtime detection of the end user's CPU.

The current Zig 0.16.0 standard-library API is moving. A dedicated Zig 0.16.0 compile/run spike must confirm the chosen mechanism. The expected landing point is a small explicit CPUID/XGETBV unit unless a stable public Zig runtime-detection API proves simpler and equally auditable.

## 12.5 Immutable dispatch

Selection should happen:

- during plugin initialisation, where practical;
- or via a correctly synchronised one-time initialiser.

After selection, function pointers are immutable and safe for concurrent fmParallel frame processing.

## 12.6 Backend override for testing

Provide a test/debug selection mechanism:

```text
auto
scalar/reference
force_sse41
force_avx2
```

Rules:

- forced unsupported backend fails clearly;
- `auto` chooses the highest fully supported backend;
- production API exposure of scalar forcing is optional;
- test harness access is mandatory.

## 12.7 AVX/SSE transition

Inspect generated AVX2 functions for correct AVX-to-SSE transition behaviour, including compiler-emitted `vzeroupper` where required.

Do not assume this without assembly inspection.

---

# 13. VapourSynth processing contract

## 13.1 Stateless 1-in/1-out operation

Deblock4 remains:

- one input frame;
- one output frame;
- no frame reordering;
- no cross-frame cache;
- no recursive frame dependency;
- suitable for fmParallel when implementation state is immutable or per-call.

## 13.2 Destination initial state

Before filtering, the output must be semantically identical to the input for all pixels and frame properties that should be preserved.

This ensures:

- unselected planes remain unchanged;
- incomplete-footprint border regions remain unchanged;
- skipped small planes remain unchanged;
- valid filtered regions can be modified in place in the destination.

The exact VapourSynth API method may be selected for efficiency, but semantics are controlling.

## 13.3 Plane iteration

For every selected plane:

1. obtain actual plane width and height;
2. obtain actual stride and bytes per sample;
3. select the correct format family and plane/filter class;
4. obtain the immutable per-plane grid policy expanded at filter creation;
5. derive per-plane eligible edges and batch plans from that policy and footprint;
6. execute the canonical schedule;
7. never infer chroma steps or bounds from luma subsampling ratios.

## 13.4 No hidden padding contract

Only logical pixels are part of the algorithm.

Stride is row spacing, not an invitation to process allocator padding.


## 13.5 Always-on audit frame properties

Every output frame shall record the resolved processing policy using plugin-specific property names without a leading underscore:

```text
Deblock4GridMode      : data    resolved mode, for example "mpeg2_field_separated"
Deblock4LumaStepX     : int
Deblock4LumaStepY     : int
Deblock4ChromaStepX   : int
Deblock4ChromaStepY   : int
Deblock4MidpointScale : float   present only when a luma midpoint class applies
Deblock4Backend       : data    "scalar" | "sse41" | "avx2"
```

Rules:

- `Deblock4Backend` records the backend actually used; `"auto"` is never written.
- `Deblock4MidpointScale` is omitted when midpoint processing is not applicable, rather than written as zero.
- Each scalar value has its own property so scripts and tests do not need to parse packed strings or arrays.
- The properties are always enabled because they are the audit trail for grid selection, under-deblocking reports, and backend diagnosis.


---

# 14. Validation specification

## 14.1 Validation layers

Validation must be separated and ordered into:

1. scalar arithmetic and bounds self-tests;
2. scalar Schedule A/B quality tests;
3. selection and removal of the losing production schedule;
4. luma midpoint-scale and proper-chroma quality tests;
5. scalar versus SSE4.1 equivalence;
6. scalar versus AVX2 equivalence;
7. boundary memory-safety tests;
8. dispatch tests;
9. assembly inspection;
10. performance benchmarks;
11. real VapourSynth integration tests.

No SSE4.1 production backend work begins before the scalar Schedule A/B gate closes.

## 14.2 Arithmetic vector tests

For each format family and filter class, test hand-computed vectors around:

- zero;
- maximum sample;
- midpoint;
- minimum and maximum signed differences;
- every filter threshold;
- one below/at/one above threshold;
- clipping boundaries;
- rounding ties;
- normal/no-filter branches;
- parameter extremes;
- primary and midpoint threshold-set selection;
- midpoint scale endpoints `0.0` and `1.0`;
- creation-path fixed-point conversions around half-unit rounding boundaries;
- proof that threshold scaling uses `i64` and cannot overflow at 16-bit;
- future-derived threshold domain clamps;
- non-finite float footprints;
- signed-zero bit-pattern preservation for unchanged samples.

## 14.3 Backend equivalence dimensions

Test widths and heights:

- below minimum footprint;
- exactly minimum footprint;
- around every block-grid multiple;
- around 8, 16, 32, and 64;
- `N-3` through `N+3` around relevant boundaries;
- odd sizes;
- prime sizes;
- large normal sizes;
- luma sizes whose subsampled chroma sizes are awkward.

Examples should include, but not be limited to:

```text
1..65 exhaustive small dimensions
127, 128, 129
191, 192, 193
719, 720, 721
853, 854, 855
1919, 1920, 1921
3839, 3840, 3841
```

## 14.4 Format matrix

At minimum:

- Gray8;
- Gray9/10/12/14/16 where available;
- GrayS;
- YUV420P8/10/12/16;
- YUV422P8/10/12/16;
- YUV444P8/10/12/16;
- float YUV formats supported by VapourSynth;
- planar RGB integer and float formats where supported.

Test:

- all planes selected;
- luma/first plane only;
- chroma subset;
- no selected plane if API permits, with unchanged output;
- luma proper/full filter and proper chroma filter;
- development-only HolyWu-compat chroma comparison;
- `mpeg2_progressive` preset expansion on both YUV420 and YUV422;
- `mpeg2_field_separated` preset expansion and format rejection rules;
- generic/custom YUV422 processing, while the named interlaced separated-field MPEG-2 4:2:2 preset remains deferred.

## 14.5 Random and exhaustive testing

Use:

- deterministic PRNG seeds;
- thousands of random small planes;
- exhaustive sample combinations for reduced toy domains where feasible;
- repeated runs under forced scalar/SSE4.1/AVX2;
- per-edge-position NaN/Inf masks with non-finite lanes at every position inside an SSE4.1 and AVX2 batch;
- exact audit-frame-property values for every named/custom grid and backend;
- midpoint position tests at strictness `0`, `1`, and swept intermediate values;
- exact fixed-point threshold-scaling parity across backends;
- primary-versus-midpoint branch reporting;
- chroma same-orientation batch-order permutation tests;
- explicit proof that cross-orientation chroma order is still preserved.

The first differing coordinate must be reported with:

- plane;
- x/y;
- source footprint;
- scalar value;
- SSE value;
- AVX value;
- edge orientation;
- edge index;
- branch/mask decisions.

## 14.6 Memory-safety proof

Build a buffer-level harness independent of VapourSynth that supports:

- arbitrary positive stride;
- deliberately minimal row storage;
- canary bytes before and after every row;
- canary rows before and after the plane;
- awkward pointer alignments;
- read-only source;
- write-only destination regions where possible.

Verify:

- no source over-read;
- no destination overwrite;
- no use of row padding;
- no use of extra bottom rows;
- no tail overrun;
- identical canaries after processing.

Use sanitizers or guard pages where supported by the Zig/Windows toolchain.

## 14.7 Float validation

Test:

- ordinary finite values in nominal range;
- finite out-of-range values;
- positive and negative zero;
- subnormal values if preserved;
- NaN and infinities after policy is defined.

Compare bit patterns, not just decimal formatting.

## 14.8 Assembly inspection

### Generic objects

Verify:

- no accidental AVX/AVX2 instructions;
- safe DLL load on minimum supported CPU.

### SSE4.1 objects

Verify:

- intended XMM operations;
- no AVX/AVX2;
- no unexpected scalarisation of the hot kernel;
- no decomposition into obviously inferior code without justification.

### AVX2 objects

Verify:

- intended YMM operations;
- no accidental AVX-512;
- expected widening/narrowing/shuffle sequence;
- no large-vector decomposition caused by an incorrect lane count;
- no unsafe aligned loads;
- correct `vzeroupper` behaviour;
- no FMA contraction in strict float kernels.

Generated assembly is a release gate, not an optional curiosity.

## 14.9 Performance benchmarking

Measure the complete real filter path, including destination preparation, not only an isolated arithmetic microkernel.

Benchmark:

- scalar;
- SSE4.1;
- AVX2;
- candidate schedules if both remain under consideration.

Use:

- 720x576 and field-separated 720x288;
- 1080p;
- 2160p;
- 8-bit;
- 10/16-bit;
- float;
- Gray/YUV420/YUV422/YUV444 where practical.

Report:

- frames/s;
- ns/pixel;
- CPU cycles if available;
- effective speedup;
- variance;
- whether the path is compute-, shuffle-, or memory-bound.

Do not publish guessed multipliers as requirements.

---

# 15. Quality-versus-performance decision rules

## 15.1 Performance must not silently change the algorithm

An optimisation is valid when it:

- groups independent work;
- uses wider arithmetic safely;
- improves loading/transposition;
- preserves the canonical state seen by every operation;
- preserves output.

An optimisation is an algorithm change when it:

- reorders dependent edges;
- evaluates thresholds from stale preloaded pixels;
- changes arithmetic width with overflow or different clipping;
- uses FMA/reassociation on only one backend;
- skips a valid tail;
- filters an incomplete footprint with invented pixels;
- lets a future strength analyser produce backend-dependent thresholds;
- computes a future strength map from partially filtered output rather than an unmodified-source pre-pass.

Algorithm changes require separate quality approval.

## 15.2 "More accurate" must be defined

A different output is not automatically more accurate because it came from:

- a codec-inspired schedule;
- AVX2;
- narrower arithmetic;
- fewer instructions.

An equal-or-better claim should refer to:

- reduced actual block discontinuities;
- retained legitimate detail;
- fewer artifacts;
- closer agreement with a clean reference;
- stable behaviour across representative content.

## 15.3 Default conservative choice

If the candidate schedule is not demonstrably equal or better:

- retain the verified HolyWu-equivalent schedule;
- still implement AVX2 within that schedule's legal batching opportunities;
- accept a smaller AVX2 gain rather than silently changing image character.

---

# 16. Revision history

This section replaces the former "Proposed README corrections" list, which instructed this document to amend itself and became self-referential once those amendments were applied.

## Revision 1.0

- Promoted the document from draft revision 0.6 to the accepted design-specification baseline; this does not claim that a plugin binary has been released.
- Corrected the legacy offset attribution from the HolyWu source: `aoffset` became `boundary_strength_offset` and drives `alpha` plus `tc0`; `boffset` became `side_activity_offset` and drives `beta` only.
- Finalised `strength` range `0..60`, default `25`, and independent offset ranges `-strength .. 60-strength`, with errors instead of silent clamping.
- Recorded the threshold-table no-op domain: either resolved activation index `<=15` disables filtering; zero base `tc0` at boundary indices `16..20` does not necessarily mean zero correction.
- Added production `backend="scalar"` as the always-available diagnostic/reference path.
- Finalised float exceptional-value handling as a per-edge-position decision with per-lane SIMD masking; added signed-zero and inherited-MXCSR rules.
- Finalised always-on audit frame properties for resolved grid steps, midpoint scale, and actual backend.
- Closed the public naming/range/property questions and retained only measurement gates, bounded Zig/VapourSynth spikes, and explicitly deferred scope.

## Revision 0.6

- Incorporated the designer's approval of README v0.5 and closed the midpoint fixed-point design: scale in `i64` once at filter creation, producing immutable primary and midpoint threshold sets; no scaling remains in the hot kernels.
- Settled proper chroma as the production design while preserving the distinction between design adoption and quality validation.
- Clarified that proper-chroma edge independence is intra-orientation only; vertical-versus-horizontal pass order remains output-defining.
- Replaced the provisional 4:2:0 chroma clause search with the structural 8x8-block/macroblock-composition proof, supported by decoder/encoder implementation evidence.
- Included the progressive MPEG-2 preset for both 4:2:0 and 4:2:2, while deferring only the named interlaced separated-field MPEG-2 4:2:2 preset.
- Added a meaning-based proposed public API, including a legacy translation table and explicit preset/custom precedence.
- Renamed `midpoint_strictness` to `midpoint_threshold_scale`, reflecting its actual 0-to-1 threshold-multiplier semantics.
- Added future automatic-strength extensibility guards: explicit threshold inputs, proved-domain clamping, canonical analyser identity, unmodified-source pre-pass, per-call scratch, shared kernels, and a separate driver.
- Made the scalar Schedule A/B quality gate a prerequisite for SSE4.1 work.
- Corrected recorded finding F2 so its uniform geometry statement is explicitly limited to HolyWu rather than Deblock4.
- Added the six broad development stages and preserved the later Deblock4_qed/autoadjust workstreams.

## Revision 0.5

- Incorporated the accepted BestSource/MPEG-2 research findings: decoded pixels and frame-level properties only, no per-macroblock `dct_type`, no normative MPEG-2 in-loop deblocking, and no recorder-brand default.
- Recast field-separated MPEG-2 luma as one step-4 candidate grid with primary (`y mod 8 == 0`) and midpoint (`y mod 8 == 4`) position classes.
- Replaced the proposed second midpoint detector with canonical `alpha`/`beta` activation scaled by `midpoint_threshold_scale`, reading the current canonical destination state.
- Made the grid selection required while allowing `auto` as an explicit accepted value; named modes expand to per-plane-class primitive steps.
- Confirmed the field-separated MPEG-2 4:2:0 chroma grid as 8x4 in chroma coordinates and retained 4:2:2 preset geometry as a bounded open task rather than removing generic 4:2:2 support.
- Added the proposed proper chroma normal filter, its smaller footprint, per-filter-class bounds, and same-orientation edge independence; retained cross-orientation pass ordering.
- Corrected the arithmetic decision table to 8-12-bit candidate `i16` and 13-16-bit `i32`.
- Added `grid_policy.zig` and expanded the validation matrix for midpoint strictness and chroma equivalence.

## Revision 0.4

- Reserved. The document moved directly from the independently assessed revision 0.3 to the consolidated coder/designer revision 0.5 requested by the coordinator.

## Revision 0.3

- Fixed the section 3.5 statement that HolyWu's four-position base segment "must be verified", which contradicted the verified-facts subsection immediately below it.
- Added the normative edge-position indexing convention to section 3.4, and restated the verified read/write footprints in those terms. This closes a real off-by-one hazard: the previous prose mixed boundary-relative and `e`-relative reference points.
- Made the section 6.2 eligibility rule concrete, added the derivation of the first candidate edge from `edge_step`, and required both radii to be named constants rather than literals.
- Added section 6.5's derivation of the minimum processable plane extent from `edge_step`, replacing an implied constant that is correct only for `edge_step = 4`.
- Added section 3.9 as an explicit blank, recording that the 0.2 renumbering omitted no content.
- Reconciled the section 2 decision table against the completed assessment round.
- Added A.9.1 (chroma is filtered, and HolyWu filters it too), A.9.2 (chroma steps must not be derived from luma steps by the subsampling ratio), and A.9.3 (candidate 4:2:0 chroma simplification, pending verification against the standard).
- Converted section 17 from open questions to recorded assessment findings.

## Revision 0.2

- Replaced the flat `deblock_kernel(16)` / `deblock_kernel(32)` model with the backend `vector_bytes` model, since Zig vector lengths count elements rather than bytes.
- Separated algorithmic frame-boundary eligibility from SIMD batch cleanup, and stated that an incomplete footprint is left unchanged while an incomplete vector is still processed.
- Established the canonical scalar implementation as the executable specification and correctness oracle, demoting HolyWu to a quality baseline.
- Rejected whole-frame padding, resize, and crop, and rejected reliance on VapourSynth stride padding.
- Introduced section 3.11 distinguishing coded transform size from processing edge-grid pitch, and the `edge_step_x` / `edge_step_y` parameter naming.
- Added the format-specific arithmetic policy, the strict floating-point policy, and the `x86_64_v3` dispatch reconciliation rule.
- Pinned the toolchain to Zig 0.16.0 for ZLS support.
- Added Appendix A (MPEG-2 transform geometry) and Appendix B (open source/default question).
- Recorded Schedule C as deliberately deferred.

## Revision 0.1

- Initial consolidated proposal.

---


# 17. Recorded assessment findings

The independent source-level assessment requested in revision 0.1 has been completed. The questions posed there are answered below and the answers are normative unless explicitly superseded.

Where a finding rests on inspection of the HolyWu source, the implementation phase must still pin the exact source tag or commit and preserve file, function, and line evidence in the repository.

## F1. HolyWu source schedule (was Q1)

Verified. Per plane, the traversal is:

```text
for x = 4 step 4 while x < width:        vertical edge          (first band, y = 0..3)
advance 4 rows
for y = 4 step 4 while y < height:
    horizontal edge at x = 0..3                                 (first column)
    for x = 4 step 4 while x < width:
        horizontal edge at (x, y)
        vertical   edge at (x, y)
    advance 4 rows
```

So: raster order over 4x4 positions, horizontal filtered **before** vertical within each interior position, with a vertical-only first band and a horizontal-only first column. The SSE4.1 path has the same structure as the C path.

Dependencies present in this schedule, in the convention of section 3.4:

- HolyWu luma and chroma alike: a vertical edge reads columns `e-3 .. e+2` and writes `e-2 .. e+1`, over four rows;
- HolyWu luma and chroma alike: a horizontal edge reads rows `e-3 .. e+2` and writes `e-2 .. e+1`, over four columns;
- within one position, the vertical edge reads rows that the horizontal edge has just written;
- the vertical edge also reads columns written by the horizontal edge one block-column to the left;
- the horizontal edge one block-row below reads rows written by the vertical edge above it.

Both directions of dependency exist. This is why Schedule A cannot batch either orientation beyond four positions, and therefore why Schedule B exists.

## F2. Exact HolyWu footprint and Deblock4 divergence (was Q2)

Source review established the following for HolyWu:

- HolyWu luma and chroma alike read `e-3 .. e+2` and write `e-2 .. e+1`.
- Modified samples are `p1`, `p0`, `q0`, `q1`, with `p1` and `q1` modified conditionally on their respective side's activity test.
- Grid step is **4**, verified in source, not 8. See F12 for the consequence.
- Base segment length is 4 positions along the edge, in both the C and SSE4.1 paths.
- In HolyWu, geometry is identical across all sample-format paths and planes; only arithmetic types differ.

Deblock4 deliberately departs from HolyWu for proper chroma:

- luma/full normal filter retains the HolyWu footprint;
- proper chroma reads `e-2 .. e+1`, writes `e-1 .. e`, and modifies only `p0/q0`;
- geometry is therefore per-plane/filter-class in Deblock4.

## F3. 8-bit `i16` range assessment (was Q3)

Assessed against the HolyWu formulas. Worst-case magnitudes for 8-bit input, with `scale = 1`, `alpha <= 255`, `beta <= 18`, `c0 <= 35` hence `c <= 37`:

| expression | range | fits `i16` |
|---|---|---|
| `p0-q0`, `p1-p0`, `q0-q1`, `p2-p0`, `q2-q0` | +/- 255 | yes |
| `c = c0 + 2*c1` | <= 37 | yes |
| `avg = (p0+q0+1) >> 1` | 0 .. 255 | yes |
| `(q0-p0) << 2` | +/- 1020 | yes |
| `((q0-p0) << 2) + p1 - q1 + 4` | +/- 1279 | yes |
| `p2 + avg - (p1 << 1)` | +/- 510 | yes |
| `p0 +/- delta` before clipping | -37 .. 292 | yes |

**No branch requires `i32` at 8 bits.** Two conditions attach:

1. Right shift of negative values must be specified as arithmetic shift with floor semantics, matching the C++ behaviour being ported. Zig's `>>` on signed integers is arithmetic, but the scalar reference must state the requirement rather than rely on it.
2. This proof is against the HolyWu formulas. If `spec.zig` alters any formula, threshold table, or parameter scaling, the whole table must be re-derived. See section 8.4.

At 10-bit the shifted term reaches +/- 4092 and `c` scales by four, still within `i16` mathematically; at 16-bit the shifted term reaches +/- 262140 and `i32` is required, as already specified.

## F4. Schedule B safety (was Q4)

Confirmed, with the structural facts that make it safe:

- **Along-edge segments are genuinely disjoint.** For a vertical edge, the row ranges `[y .. y+3]` and `[y+4 .. y+7]` do not overlap in reads or writes, because each segment's reads are confined to its own rows. The mirror argument holds for horizontal edges along x. AVX2 may therefore concatenate any number of base segments along a single edge. **This is where the AVX2 width gain lives, and it is fully safe.**
- **Adjacent edges are not disjoint.** A vertical edge at `e` writes `e-2 .. e+1` while the next at `e + edge_step` reads from `e + edge_step - 3`. For `edge_step = 4` these overlap. Left-to-right vertical order and top-to-bottom horizontal order are therefore **output-defining, not stylistic**, and neighbouring edge columns or rows must never share a SIMD batch.
- **Transpose staleness** is not a hazard within a single along-edge batch, since nothing intervenes between its loads and stores. The illegal pattern is pre-loading a tile spanning two *adjacent* edge columns and filtering both from it; section 5.4 already forbids this and section 10.5 states the general rule.
- **Cross-pass**: the vertical pass completes before the horizontal pass reads anything, so the two-pass boundary is trivially deterministic.

## F5. Codec analogy precision (was Q5)

The distinction drawn in section 5.3 is correct and must be preserved.

H.264, and VP8 in RFC 6386 section 15, define a **macroblock-local** order: all edges of one orientation within a macroblock, then the other, with macroblocks traversed in raster order. That is **not** equivalent to a whole-plane vertical pass followed by a whole-plane horizontal pass. Under macroblock-local order, horizontal results from one macroblock feed vertical decisions in the next; whole-plane two-pass eliminates that coupling entirely.

Schedule B is therefore **codec-informed, not codec-identical**, exactly as section 5.3 states. The consequence is that the A/B quality gate in section 5.5 is substantive rather than ceremonial: Schedule B is a genuinely new schedule and must earn its place on quality evidence.

## F6. Boundary rule (was Q6)

Confirmed. Deriving eligibility from the actual footprint and the actual plane extent, per section 6.2:

- covers every edge whose complete footprint exists;
- skips only incomplete-footprint candidates at the extreme frame edges;
- handles subsampled chroma correctly, provided the derivation uses each plane's own dimensions and that plane's own steps (see A.9.2);
- is independent of vector width, since the eligibility test never mentions lanes.

The minimum processable extent that follows from the rule is derived in section 6.5 and is **not** a constant.

## F7. Zig vector implementation (was Q7)

The `vector_bytes` abstraction and the derived vector types are endorsed as specified in section 9.

The array-copy load and store idiom in section 9.5 is the correct choice over pointer casting, because arrays have defined byte layout while vector memory layout is not a basis for arbitrary casts. `@shuffle` masks are compile-time in Zig, which suits fixed-shape transposes well.

Two codegen risks should be treated as specific targets for the section 14.8 assembly gate:

1. **Widening and narrowing between `u8` and `i16`.** The intent is byte-to-word unpack and saturating word-to-byte pack instructions. Verify that the chosen Zig formulation produces them and does not scalarise, particularly for the narrowing direction.
2. **The vertical-pass gather.** Six columns across N rows should be assembled from contiguous row loads plus a transpose, not from per-lane gathers. Verify which one the compiler emits.

`vzeroupper` is normally compiler-inserted at the ABI boundaries of AVX-compiled functions, but section 12.7's "verify rather than assume" posture is correct and should be retained.

## F8. One-DLL build (was Q8)

The architecture is endorsed: shared source instantiated separately per target, a stable non-vector ABI at the object boundary, and a single DLL link.

Exact `build.zig` syntax is deliberately **not** stated here, in accordance with this specification's own rule that untested spellings must not become normative. It is spike work against Zig 0.16.0.

## F9. Runtime CPU detection (was Q9)

`std.zig.system.resolveTargetQuery` and the surrounding `std.zig.system` surface are semi-internal, subject to change, and bring substantially more machinery than this task needs. They are not the normative mechanism.

The expected landing point is a small explicit CPUID/XGETBV unit. At minimum, AVX2 eligibility requires:

```text
SSE4.1 : CPUID leaf 1,          ECX bit 19
XSAVE   : CPUID leaf 1,          ECX bit 26
OSXSAVE : CPUID leaf 1,          ECX bit 27
AVX     : CPUID leaf 1,          ECX bit 28
AVX2    : CPUID leaf 7 sub 0,    EBX bit  5
OS XMM/YMM state:
          XGETBV XCR0, bits 1 and 2 both set
```

The final check must match the exact feature closure used to compile the AVX2 object, including any required baseline features beyond those listed above.

The detector can be unit-tested by injecting synthetic CPUID/XCR0 words. Confirm exact Zig 0.16.0 intrinsic/assembly spellings in the implementation spike before freezing code.

## F10. AVX2 target features (was Q10)

The complete `x86_64_v3` feature set is the `x86_64_v2` set (SSE3, SSSE3, SSE4.1, SSE4.2, POPCNT, CMPXCHG16B, LAHF/SAHF) plus AVX, AVX2, BMI1, BMI2, F16C, FMA, LZCNT, MOVBE, and XSAVE.

**The recommendation is the minimal explicit alternative offered in section 12.3**, not `x86_64_v3`: compile the AVX2 object for the `v2` baseline plus AVX and AVX2 only, and have dispatch check exactly that set plus OS YMM state.

Beyond being simpler to verify, this choice has a second benefit that reinforces section 8.6 mechanically: **excluding FMA from the AVX2 object's target features removes the possibility of float contraction at the code generation level**, rather than relying solely on strict-mode flags to suppress it. The strict-float requirement and the target-feature choice then agree instead of one policing the other.

## F11. Quality test sufficiency (was Q11)

The section 5.5 matrix is sound. Four additions are recommended:

1. **Field-separated plane shapes specifically**, since that is the production geometry for this project: 720x288 luma and 360x144 chroma, not only woven frame sizes.
2. **Repeated-application stability.** Apply the filter two to five times and confirm the result converges rather than progressively eroding detail. Progressive erosion under repeated application is a classic deblocker failure that a single-pass matrix cannot detect, and it is a sensitive discriminator between schedules.
3. **A directional-bias probe.** Schedule B is inherently asymmetric between the two orientations. Compare its output against the same schedule applied to transposed input with the pass order swapped, and treat the difference as a measurement of the asymmetry rather than discovering it anecdotally later.
4. **Parameter endpoints**, including the minimum `strength`, every threshold-table transition, and the maximum `strength`.

## F12. Grid step is 4, and the consequence for MPEG-2 (new finding)

This finding did not correspond to a posed question. It arose from applying section 3.2's requirement that the grid step be extracted from the algorithm rather than assumed.

HolyWu's candidate edges advance in steps of **4**, being H.264-derived, where the transform is 4x4. MPEG-2 uses 8x8 transforms. Therefore on MPEG-2 material **half of HolyWu's candidate edges fall mid-block**, and are prevented from doing damage only by the threshold detector declining to fire on block interiors. That protection is weakest on noisy, soft, tape-sourced material, which is precisely this project's target content.

This is the origin of the `edge_step_x` and `edge_step_y` parameters in section 3.11 and of Appendix A. See also A.9.2, which shows that the chroma step is not derivable from the luma step.

---


## F13. BestSource and decoded MPEG-2 frames

Accepted. BestSource delivers decoded/reconstructed pixel planes plus frame-level properties. It does not expose a per-macroblock MPEG-2 `dct_type` map to VapourSynth.

H.262 has no normative H.264-style in-loop deblocking stage. Compression blocking therefore remains in the reconstructed pixels and can be treated by Deblock4 without assuming a decoder has already attempted the same operation.

Recorder brand and container extension are not valid grid selectors.

## F14. Field-separated MPEG-2 luma candidate set

Accepted with simplification:

```text
y mod 8 == 0 plus y mod 8 == 4 equals y mod 4 == 0
```

Therefore the mixed luma candidate set is one `edge_step_y = 4` grid. The design distinction is position class and threshold-set selection, not a second detector architecture.

The midpoint activation test reads the current destination state at its canonical schedule point.

`midpoint_threshold_scale` is converted once in `i64` at filter creation. The kernel receives immutable primary and midpoint threshold sets and performs no scaling.

## F15. MPEG-2 4:2:0 chroma geometry

Confirmed for interlaced MPEG-2 frame-picture material after field separation:

```text
chroma_edge_step_x = 8 chroma samples
chroma_edge_step_y = 4 chroma field rows
```

Structural proof:

- an MPEG-2 block is 8x8 samples;
- a 4:2:0 macroblock contains one 8x8 Cb block and one 8x8 Cr block;
- the macroblock therefore supplies exactly eight chroma frame rows per component;
- splitting those rows by field yields two four-row projections, so a field-DCT-style 8-row same-field chroma reorganisation cannot be represented for 4:2:0.

This agrees with current codec implementation evidence. MPEG-2 4:2:2 differs because it contains sufficient chroma rows/blocks for field organisation.

Progressive MPEG-2 4:2:0 and 4:2:2 both use 8x8 luma and 8x8 chroma steps in their own plane coordinates.

## F16. Proper chroma normal filter

Proper chroma is settled-by-design as the production path:

- read `p1`, `p0`, `q0`, `q1`;
- modify only `p0` and `q0`;
- use `tc = tc0 + one_sample_scale`;
- do not read `p2/q2` or modify `p1/q1`.

Consequences:

- footprint radii are per filter class;
- chroma minimum extents differ from luma;
- adjacent chroma edges within one orientation are independent for supported steps;
- backends may batch across same-orientation chroma edge positions;
- vertical-versus-horizontal pass order remains output-defining and the two passes must not be merged.

The HolyWu-compatible luma-on-chroma path is development/test-only and is removed after the chroma quality gate unless evidence requires its retention.

## F17. Remaining measurement gates, implementation spikes, and deferred scope

Open to measurement:

1. Schedule A versus Schedule B after scalar quality testing.
2. Default `midpoint_threshold_scale`.
3. Proper chroma quality validation on a chroma-dominant corpus.
4. AVX2 speed benefit and Zig code generation for widen/narrow and vertical transpose.
5. Whether canonical midpoint thresholds already discriminate sufficiently on noisy VHS material.

Open bounded implementation work:

6. Zig 0.16.0 object-link syntax and one-DLL link.
7. CPUID/XGETBV implementation and exact target-feature closure.
8. VapourSynth frame-property write mechanics using the settled names in section 13.5.

Deferred scope:

9. Named interlaced separated-field MPEG-2 4:2:2 preset; generic/custom YUV422 is supported.
10. MJPEG field-organisation research, only if named MJPEG presets are later proposed.
11. Automatic grid selection.
12. Automatic strength analysis.
13. `Deblock4_qed`.
14. `Deblock4_qed_autoadjust`.

The design round is closed. These items require evidence or implementation, not further architectural negotiation.

# 18. Source and evidence notes

This specification is based on:

- the attached Deblock4 README draft;
- the user/Claude design discussion;
- Zig 0.16.0 documentation for vectors and strict floating-point mode;
- VapourSynth R76 API documentation;
- HolyWu/VapourSynth-Deblock public project description;
- codec documentation showing that edge order matters and that disjoint segments along one edge facilitate vector processing;
- current FFmpeg H.264 loop-filter source as implementation prior art.

Primary/reference links:

- Zig language documentation:  
  https://ziglang.org/documentation/0.16.0/

- VapourSynth R76 API documentation:  
  https://www.vapoursynth.com/doc/api/vapoursynth4.h.html

- VapourSynth C API reference and threading notes:  
  https://www.vapoursynth.com/doc/apireference.html

- HolyWu VapourSynth-Deblock:  
  https://github.com/HolyWu/VapourSynth-Deblock

- VP8 loop-filter geometry and order, RFC 6386 section 15:  
  https://www.rfc-editor.org/rfc/rfc6386.html

- FFmpeg current H.264 loop-filter source:  
  https://www.ffmpeg.org/doxygen/trunk/h264__loopfilter_8c_source.html

- FFmpeg current MPEG-video encoder source, used as implementation evidence for interlaced 4:2:0/4:2:2 chroma organisation:  
  https://www.ffmpeg.org/doxygen/trunk/mpegvideo__enc_8c_source.html

Evidence caution:

- The HolyWu source schedule, footprint, base segment, grid step, and plane handling have been independently extracted in source review and are recorded in sections 3.5 and 17. The implementation phase must still pin the exact source tag or commit and preserve file, function, and line evidence in the repository, since the upstream project may change.
- The candidate two-pass schedule is codec-informed, not claimed to be a literal implementation of any one codec standard; see finding F5.
- The MPEG-2 4:2:0 chroma conclusion is supported normatively by the structural 8x8-block/macroblock-composition proof and corroborated by current FFmpeg MPEG-video implementation evidence. Any later H.262 clause citation is supporting evidence and does not replace the structural explanation.
- Zig 0.16.0 APIs and build syntax are moving and must be tested before exact spellings become normative.

---

# 19. Concise design baseline and remaining validation

The accepted design baseline is:

> Deblock4 defines one canonical scalar-specified algorithm and requires byte-identical integer output, and targeted bit-identical floating-point output, from scalar, SSE4.1, and AVX2 backends. HolyWu remains the initial quality baseline but is not an absolute output oracle. SIMD is parameterised by backend register width—16 bytes for SSE4.1 and 32 bytes for AVX2—with lane counts derived from the actual element type. Luma and proper chroma use separate canonical formulas and footprint descriptors. Horizontal and vertical data movement may be backend-specific. Every candidate edge on the explicitly selected per-plane processing grid is processed when its complete filter-class footprint lies inside the plane; incomplete-footprint frame-edge candidates remain unchanged, while incomplete SIMD batches are still processed by smaller-vector or scalar cleanup. Deblock4 does not resize/pad/crop whole frames and does not rely on undocumented stride padding. The candidate canonical schedule is a deterministic whole-plane vertical pass followed by a horizontal pass; dependent luma edges retain canonical order, while independent same-orientation proper-chroma edges may be batched across edge positions without merging the two orientation passes. For field-separated MPEG-2 4:2:0, luma uses an 8-by-4 candidate grid with primary and midpoint classes, and chroma uses an 8-by-4 grid in chroma coordinates. Midpoint candidates select an immutable threshold set whose `alpha` and `beta` values were scaled once in `i64` at filter creation. The meaning-based `grid_mode` parameter is required; the `"auto"` token is reserved but rejected until automatic selection exists. Proper chroma is settled-by-design but must pass its quality corpus. Schedule A versus B, the default midpoint threshold scale, proper-chroma quality, actual AVX2 benefit, and the Zig build/detection mechanisms remain subject to their stated evidence gates. Float exceptional-value behaviour and the public parameter API are settled in this specification.

# 20. Proposed development stages

The initial Deblock4 implementation uses six broad stages. These are intentionally much coarser than the CNR3 proof sequence because Deblock4 is stateless, 1-in/1-out, and has no cross-frame cache, pin, eviction, or recovery machinery.

## Stage 1 — Zig project scaffold and build/dispatch spikes

- establish the Zig 0.16.0 project;
- create `build.zig`, target-specific object builds, and one-DLL link;
- prove generic DLL loading;
- prove SSE4.1 object selection;
- prove AVX2 object selection with matching CPUID/XGETBV checks;
- establish Debug and Release build/test commands.

This spike does not block scalar algorithm work. Stage 2 may proceed if an exact build-system detail needs further investigation.

## Stage 2 — Canonical scalar core and proof harness

- implement the final meaning-based parameter names, ranges, validation errors, and preset expansion;
- implement threshold tables and immutable threshold sets;
- implement luma and proper-chroma scalar formulas;
- implement footprints, bounds, safe edges, and valid tails;
- implement explicit grid/custom policies;
- implement Schedule A and Schedule B in scalar form;
- add arithmetic, range, memory-canary, and backend-independent test infrastructure;
- include the future automatic-strength guards from section 4.4 in kernel signatures;
- begin assembling the real/synthetic quality corpus.

## Stage 3 — Scalar quality decisions

- compare Schedule A and Schedule B;
- select one production schedule and remove the loser from production code;
- sweep `midpoint_threshold_scale`;
- validate proper chroma against the development-only HolyWu-compatible path;
- test repeated application, directional bias, detail preservation, and chroma-dominant material;
- freeze the scalar canonical algorithm before SIMD work.

## Stage 4 — SSE4.1 backend

- implement 16-byte vector arithmetic;
- implement orientation-specific loads/transposes/stores;
- prove scalar == SSE4.1 for all supported formats, grids, dimensions, and tails;
- inspect assembly and reject scalarisation or accidental AVX;
- benchmark against scalar.

## Stage 5 — AVX2 backend

- implement 32-byte vector arithmetic and wider legal batches;
- preserve all canonical dependency rules;
- prove scalar == SSE4.1 == AVX2;
- inspect widening/narrowing, transpose, target features, and `vzeroupper`;
- benchmark actual AVX2 benefit without assuming a multiplier.

## Stage 6 — VapourSynth integration and release readiness

- complete API4/fmParallel integration;
- write and test the always-on audit frame properties from section 13.5;
- validate format/plane/frame-property behaviour;
- execute the complete correctness, safety, quality, dispatch, assembly, and performance matrices;
- finalise public parameter names, ranges, presets, errors, and user documentation;
- package and verify the single Windows DLL;
- prepare release notes and compatibility/translation documentation.

`Deblock4_qed` and `Deblock4_qed_autoadjust` remain later workstreams. They are not additional micro-stages of the initial Deblock4 implementation.

# Appendix A — MPEG-2/H.262 transform blocks and separated-field processing grids

## A.1 Standards identity and scope

ITU-T Recommendation H.262 and ISO/IEC 13818-2 are the jointly produced MPEG-2 Video specification. They specify the coded representation and the decoding process used to reconstruct progressive or interlaced pictures.

The operative distinction for Deblock4 is between:

- the official coded transform block;
- the arrangement of transform rows in a frame picture or field picture;
- the geometry visible after a decoded interlaced frame is separated into fields;
- the processing edge-grid pitch selected by a post-decoding filter.

These are related but are not interchangeable terms.

## A.2 Official coded transform size

For luma, the MPEG-2 transform block is always:

```text
8 columns x 8 samples
```

This remains true for:

- progressive pictures;
- interlaced frame pictures using frame DCT;
- interlaced frame pictures using field DCT;
- separately coded field pictures.

MPEG-2 does not define an 8x4 transform mode. An apparent 8x4 geometry arises only when an 8x8 frame-DCT block is viewed after its alternating lines have been split between two fields.

## A.3 Progressive MPEG-2

### A.3.1 Ordinary frame-DCT case

An 8x8 block contains eight consecutive frame rows:

```text
frame rows 0 1 2 3 4 5 6 7
```

The displayed progressive-frame transform grid is therefore:

```text
coded transform:       8 x 8
processing-grid pitch: 8 x 8
```

A historical corrigendum removed a prohibition on field-structured DCT coding in progressive frames. Such coding is possible under the consolidated standard but is unusual for genuinely progressive programme material.

The normal Deblock4 MPEG-2 progressive candidate remains an 8x8 processing grid.

## A.4 Interlaced MPEG-2 frame pictures

A frame picture contains both fields woven together:

```text
frame line 0 = top-field line 0
frame line 1 = bottom-field line 0
frame line 2 = top-field line 1
frame line 3 = bottom-field line 1
...
```

MPEG-2 can select frame-DCT or field-DCT organisation at macroblock level unless constrained otherwise by picture syntax.

### A.4.1 Frame DCT in an interlaced frame picture

The official 8x8 transform uses eight consecutive woven frame rows:

```text
top 0
bottom 0
top 1
bottom 1
top 2
bottom 2
top 3
bottom 3
```

Before field separation:

```text
coded transform:       8 x 8
displayed-frame pitch: 8 x 8
```

After field separation, each field receives four of those eight rows:

```text
top field:    frame rows 0, 2, 4, 6
bottom field: frame rows 1, 3, 5, 7
```

Therefore each original 8x8 frame-DCT block projects into each separated field as:

```text
processing-grid pitch: 8 columns x 4 field rows
```

This is an 8x4 **post-separation projection**, not an 8x4 DCT.

### A.4.2 Field DCT in an interlaced frame picture

A field-DCT block uses eight rows from one field, for example:

```text
top field in woven coordinates:
0, 2, 4, 6, 8, 10, 12, 14
```

or:

```text
bottom field in woven coordinates:
1, 3, 5, 7, 9, 11, 13, 15
```

The official transform remains 8x8. In the woven frame, its same-field rows occupy an 8x16 bounding region because every second frame line belongs to the other field.

After field separation, those rows become eight consecutive rows in the relevant field:

```text
processing-grid pitch: 8 x 8
```

## A.5 MPEG-2 field pictures

MPEG-2 may code top and bottom fields as separate field pictures.

A field picture is already in field coordinates. Its transform blocks use eight successive rows of that field:

```text
coded transform:       8 x 8
processing-grid pitch: 8 x 8
```

## A.6 Definitive luma table

| MPEG-2 picture and DCT organisation | Official coded transform | Geometry in woven frame | Processing-grid pitch after field separation |
|---|---:|---:|---:|
| Progressive, frame DCT | 8x8 | 8x8 | normally not separated |
| Progressive, unusual field DCT | 8x8 | same-parity rows over an 8x16 area | 8x8 in each even/odd line set |
| Interlaced frame picture, frame DCT | 8x8 | 8x8 | **8x4 per separated field** |
| Interlaced frame picture, field DCT | 8x8 | same-field rows over an 8x16 area | **8x8 per separated field** |
| Top or bottom field picture | 8x8 | separately coded field | **8x8** |

The normative conclusion for luma is:

```text
MPEG-2 always uses 8x8 transform blocks.

Progressive/frame-DCT MPEG-2:
    displayed processing grid 8x8.

Interlaced frame picture using frame DCT:
    woven grid 8x8;
    separated-field processing grid 8x4.

Interlaced frame picture using field DCT:
    same-field 8x8 transform;
    separated-field processing grid 8x8.

Separately coded MPEG-2 field picture:
    field processing grid 8x8.
```

## A.7 Mixed DCT organisation is the practical difficulty

In an interlaced MPEG-2 frame picture, frame DCT and field DCT can be selected at macroblock granularity.

One decoded frame may therefore contain:

```text
macroblock A: frame DCT
macroblock B: field DCT
macroblock C: frame DCT
...
```

After field separation, the locally correct luma vertical processing pitch may vary:

```text
frame-DCT macroblock area:
    4 field rows

field-DCT macroblock area:
    8 field rows
```

No single global `edge_step_y=4` or `edge_step_y=8` can exactly reconstruct every mixed interlaced MPEG-2 frame after field separation.

That is a property of the encoded stream, not a defect in Deblock4.

An exact implementation would require a per-macroblock DCT-organisation map from the MPEG-2 decoder. Ordinary decoded pixel frames do not inherently contain such a map.

## A.8 Practical field-separated MPEG-2 luma policy

For field-separated MPEG-2 luma without decoder macroblock metadata:

```text
luma_edge_step_x = 8
luma_edge_step_y = 4
```

This is not a claim that every local transform projection is 8x4. It is the smallest single candidate set that contains:

- primary boundaries at `y mod 8 == 0`, required by both frame-DCT and field-DCT regions;
- midpoint boundaries at `y mod 8 == 4`, additionally required by frame-DCT regions.

Primary candidates use the canonical activation thresholds. Midpoint candidates use those same tests with `alpha` and `beta` scaled by `midpoint_threshold_scale`.

Ordinary decoded frames do not expose a per-macroblock `dct_type` map, so the user is not expected to identify local frame-DCT versus field-DCT coding.

A fixed global step-8 mode remains useful as an explicit proof/expert mode but is not sufficient as the normal mixed-material candidate set because it necessarily misses frame-DCT-projected midpoint boundaries.

## A.9 Chroma qualification and resolved 4:2:0 policy

The chroma case must not be derived mechanically from luma subsampling.

### A.9.1 Chroma is processed by default

HolyWu processes all selected planes and applies the same luma formula and step-4 geometry in each plane's own coordinates.

Deblock4 retains default chroma processing and per-plane dimensions, but deliberately replaces HolyWu's luma-on-chroma formula with the proper chroma normal filter described in section 8.8. This is settled-by-design and remains subject to quality validation.

### A.9.2 Chroma steps use chroma coordinates

An MPEG-2 4:2:0 macroblock contains four luma 8x8 blocks covering a 16x16 luma area, plus one 8x8 Cb block and one 8x8 Cr block covering that area.

```text
luma   block boundaries: every 8 luma samples
chroma block boundaries: every 8 chroma samples
                        = every 16 luma samples
```

Therefore `chroma_step = luma_step / subsampling` is wrong. Per-plane-class steps are explicit and expressed in that plane's own sample coordinates.

### A.9.3 Interlaced MPEG-2 frame-picture 4:2:0 chroma

For field-separated MPEG-2 4:2:0 frame-picture material:

```text
chroma_edge_step_x = 8 chroma samples
chroma_edge_step_y = 4 chroma field rows
```

There is no luma-style primary/midpoint distinction for this chroma preset.

Structural proof:

1. An MPEG-2 transform block is an 8-row by 8-column matrix.
2. A 4:2:0 macroblock contains one 8x8 Cb block and one 8x8 Cr block.
3. The macroblock therefore supplies exactly eight chroma frame rows per component.
4. Separating the two fields projects those eight frame rows into four rows in each field.
5. A field-DCT organisation would require an 8-row same-field block, which cannot be formed from a 4:2:0 macroblock's four same-parity chroma rows.

This structural result agrees with current codec implementation behaviour.

Qualifications:

- separately coded field pictures use field-coordinate chroma blocks and require their own preset;
- MPEG-2 4:2:2 differs because it has enough chroma rows/blocks for field organisation;
- generic/custom YUV422 processing remains supported;
- the progressive MPEG-2 preset supports both 4:2:0 and 4:2:2 with luma/chroma steps of 8x8 in each plane's own coordinates;
- only the named interlaced separated-field MPEG-2 4:2:2 preset is deferred;
- conversions performed before field separation can alter the plane geometry seen by Deblock4 and must be documented in the calling script/preset.

### A.9.4 Proper chroma filter consequence

The proper chroma filter reads `e-2..e+1` and writes `e-1..e`. Same-orientation adjacent chroma edges are independent for supported steps, permitting wider batching than luma. Vertical and horizontal passes still retain their selected canonical order.

## A.10 Public parameter terminology

Do not call an 8x4 post-separation processing grid an MPEG-2 transform block size.

Prefer:

```text
edge_step_x
edge_step_y
```

or a mode enum that expands to explicitly documented steps.

This keeps separate:

- codec transform geometry;
- decoded picture geometry;
- separated-field geometry;
- Deblock4's post-decoding candidate-edge grid.

## A.11 Cropping and grid origin

The initial-release grid origin is zero.

Spatial cropping before Deblock4 can shift the visible coded block boundaries away from zero. Where coded-grid alignment matters, apply Deblock4 before cropping or provide a future explicit grid-origin facility.

No spatial offset facility is part of the initial design.

## A.12 Standards and reference sources

- ITU-T H.262 recommendation record:  
  https://www.itu.int/rec/T-REC-H.262

- Freely available consolidated H.262 (2000) edition record:  
  https://www.itu.int/rec/T-REC-H.262-200002-S/en

- H.262 summary noting progressive/interlaced pictures and field-structured DCT corrigendum:  
  https://www.itu.int/dms_pubrec/itu-t/rec/h/T-REC-H.262-200002-S%21%21SUM-HTM-E.htm

- ISO/IEC 13818-2 catalogue entry:  
  https://www.iso.org/standard/61152.html

---

# Appendix B — BestSource, decoded MPEG-2 pixels, and grid-selection findings

## B.1 What reaches VapourSynth

BestSource is an FFmpeg source wrapper. It delivers decoded/reconstructed pixel planes and frame-level properties such as picture type, field order, timing, colour information, dimensions, and format.

It does not expose a per-macroblock MPEG-2 `dct_type` map to ordinary VapourSynth filters.

## B.2 MPEG-2 is not already deblocked

H.262 defines reconstruction through inverse scan, inverse quantisation, inverse DCT, motion compensation, and decoded-picture output. It has no normative H.264-style in-loop deblocking stage.

BestSource exports the reconstructed decoder pixels and does not silently add a post-deblock filter. Quantisation and prediction artifacts therefore remain visible and are valid Deblock4 input.

## B.3 No recorder-brand or container default

No defensible public evidence establishes a stable LG, JVC, or other recorder-brand frame-DCT/field-DCT policy suitable for a shipped default. MPEG-2 encoders may select local organisation according to motion, detail, noise, rate control, chipset, and firmware.

Container extensions are also not grid specifications:

- lossless/uncompressed AVI may contain no MPEG-2 grid;
- MJPEG is a separate 8x8 problem;
- DV is a separate codec/grid problem;
- losslessly transcoded DVD pixels may retain artifacts after the original macroblock metadata is gone.

## B.4 User-facing consequence

The normal user shall not be asked to identify MPEG-2 macroblock `dct_type`.

The required `grid_mode` prevents scripts from silently inheriting an inappropriate H.264 4x4 grid.

Initial named choices are:

- `h264`;
- `mpeg2_progressive`;
- `mpeg2_field_separated` for 4:2:0;
- `custom`.

The `auto` token is reserved but rejected until implemented.

Named modes expand to primitive per-plane-class steps and policy values. Steps are always expressed in the relevant plane's own sample coordinates.

## B.5 Open items after research

The source/default research leaves only bounded issues:

- select the default luma `midpoint_threshold_scale` through the quality harness;
- derive and validate a named interlaced separated-field MPEG-2 4:2:2 preset only if later prioritised;
- preserve the explicit custom path regardless of preset coverage;
- research MJPEG field organisation only if named MJPEG presets are proposed.

