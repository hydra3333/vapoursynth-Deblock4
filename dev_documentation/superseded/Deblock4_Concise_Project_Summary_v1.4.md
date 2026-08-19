# Deblock4 - Concise Project Summary

**Version:** 1.4
**Date:** 2026-08-18
**Status:** INFORMATIVE user-facing companion. It is an authority in NO domain.
The AI Charter controls; for every MPEG-2 matter the ratified
`Deblock4_MPEG2_Deblocking_Investigation_and_Decided_Architecture` prevails
over this document, over the README, and over any other statement in the set.
**Encoding:** US-ASCII; CRLF.

---

# 0. READ THIS BEFORE ANYTHING ELSE - WHAT IS LIVE AND WHAT IS NOT

```text
THE DEBLOCK4 FILTER HAS NO FILTERING KERNEL. Every dispatch path is a
pass-through copy. Nothing in this document describes working MPEG-2
deblocking, because none exists yet. The Classic filter IS complete and
working.

THE DEBLOCK4 PARAMETER SURFACE DESCRIBED BELOW IS LEGACY SCAFFOLDING. It was
ratified at Stage 1C, BEFORE the architecture was re-decided, and it is
awaiting redesign under issue D4-Q16. In particular:

    grid_mode="mpeg2_field_separated"   REJECTED ARCHITECTURE. Do not use it,
                                        do not recommend it, and do not treat
                                        the 8x4 field-separated grid as a
                                        supported design. Its geometry was an
                                        artefact of separated-field
                                        coordinates and is false in the whole
                                        frame the filter actually receives.
    midpoint_threshold_scale            part of the same rejected design.
    luma_midpoint_enabled               same.
    Deblock4LumaStepY and the other     cannot express the adopted
    grid frame properties               architecture's mixed geometry.

The filter still ACCEPTS these parameters, because the scaffolding is
committed and its removal is a separate bounded task. Accepting them is not
endorsing them.

THE ADOPTED ARCHITECTURE, in one paragraph: the filter takes the WHOLE
reconstructed interleaved frame plus a declared source mode. SeparateFields is
not a supported contract - it tears frame-organised transform blocks across
two clips. Architecture B2 is the adopted PRIMARY CANDIDATE: classify each
16x16 luma macroblock as FRAME, FIELD or UNKNOWN, then derive the horizontal
edge topology explicitly. Architecture D, which needs no detector, is the
mandatory comparator and fallback and must meet its own separate viability
bar. NEITHER has passed the D4-Q14 discriminator experiment, which has not yet
been designed. No kernel may be written before it reports.

WHY THIS DOCUMENT STILL EXISTS: it is the short user-facing orientation. For
current project state read Deblock4_Project_Status section 0; for MPEG-2
matters read the ratified authority; for the work queue read the Standing Task
Register. This document is scheduled for adjudication in the T1 consolidation
sweep, which may retire it or reduce it to an index.
```

---

# 1. Purpose and scope

Deblock4 is a new Zig 0.16.0 VapourSynth API4 plugin for reducing visible compression-block artifacts, initially focused on PAL tape material recorded to MPEG-2 by consumer DVD recorders.

One Windows x64 DLL (`Deblock4.dll`) registers TWO core filters, built in this order, plus later QED workstreams:

```text
INITIAL CORE DELIVERY (this project):
    deblock4.Classic     H.264 filter, faithful to HolyWu     <- built FIRST
    deblock4.Deblock4    MPEG-2-aware filter (the end goal)    <- built SECOND

LATER PLANNED WORKSTREAMS (separate):
    deblock4.Deblock4_qed             masked/blended variant
    deblock4.Deblock4_qed_autoadjust  automatic-strength variant
```

`deblock4.Classic` is built first because it is a known algorithm with HolyWu's plugin as an external reference oracle, so it de-risks the shared infrastructure before the novel MPEG-2 algorithm. `deblock4.Deblock4` is the project's end goal. The two are DIFFERENT algorithms, registered as two separate filter calls (not selected by a parameter).

Each filter is stateless, one-frame-in/one-frame-out, and intended for `fmParallel`.

---

# 2. Public parameters

The exact VapourSynth invocations are:

```python
core.deblock4.Classic(clip, ...)
core.deblock4.Deblock4(clip, grid_mode=..., ...)
```

## deblock4.Deblock4 (MPEG-2 filter)

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
    luma_step_x, luma_step_y, chroma_step_x, chroma_step_y, luma_midpoint_enabled
)
```

## deblock4.Classic (H.264 filter, faithful to HolyWu; fixed 4-pixel grid)

```text
deblock4.Classic(
    clip                        REQUIRED
    strength=25
    boundary_strength_offset=0
    side_activity_offset=0
    planes=all
    backend="auto"
)
```

Classic has NO grid_mode, NO midpoint machinery, and NO custom steps - its grid is the fixed H.264 4x4 boundary set, and it reproduces HolyWu including luma-on-chroma.

| Parameter | Values / range | Meaning |
|---|---|---|
| `clip` | VapourSynth node | Input clip |
| `grid_mode` | see below (Deblock4 only) | Required block-grid policy |
| `strength` | `0..60`, default `25` | Base deblocking table index |
| `boundary_strength_offset` | `-strength .. 60-strength` | Shifts `alpha` and `tc0`: boundary acceptance plus correction limit |
| `side_activity_offset` | `-strength .. 60-strength` | Shifts `beta`: per-side flatness/activity only |
| `planes` | valid plane indices, default all | Planes to process |
| `midpoint_threshold_scale` | `0.0..1.0`, conditional (Deblock4 only) | Scales luma midpoint `alpha`/`beta`; `0` disables, `1` gives parity |
| `backend` | see below | Runtime backend selection |
| custom steps (Deblock4 only) | validated integers | Explicit luma/chroma grid steps |
| `luma_midpoint_enabled` (Deblock4 only) | `0` or `1` | Enables custom luma primary/midpoint classes |

Out-of-range values are errors; they are not silently clamped.

Backend tokens (both filters):

```text
"auto"                   default; highest CPU-satisfied level wins
"x86_64_v3_with_avx2"    the full v3 level (AVX2-class)
"x86_64_v2_with_sse41"   the full v2 level (SSE4.1-class)
"x86_64_v1_baseline"     baseline (scalar); always available; mainly for diagnosis
```

Legacy HolyWu translation (applies to Classic, and to Deblock4's shared names):

```text
quant    -> strength
aoffset  -> boundary_strength_offset
boffset  -> side_activity_offset
opt      -> backend
```

---

# 3. Grid choices (Deblock4 filter)

`grid_mode` is required for `deblock4.Deblock4` because a silently wrong grid can miss real block boundaries or probe unnecessary mid-block positions.

| `grid_mode` | Luma | Chroma | Status |
|---|---:|---:|---|
| `"mpeg2_progressive"` | 8 x 8 | 8 x 8 | Progressive MPEG-2 4:2:0 or 4:2:2. Geometry still believed correct for progressive material; pending D4-Q16 review |
| `"mpeg2_field_separated"` | 8 x 4 | 8 x 4 | **REJECTED ARCHITECTURE - DO NOT USE.** See section 0 |
| `"custom"` | explicit | explicit | Expert/proof use; the step model cannot express the adopted mixed geometry |
| `"auto"` | reserved | reserved | Reserved; unavailable |

The H.264 4x4 grid is NOT a Deblock4 grid_mode; it is provided by the separate `deblock4.Classic` filter.

Steps are measured in each plane's own samples.

The primary/midpoint row model that earlier versions of this document
described here belonged to the rejected architecture and has been removed. The
adopted architecture derives horizontal edge topology from per-macroblock
FRAME/FIELD classification instead, and the mixed-neighbour boundary is an
explicit edge type rather than a hoped-for seam. Vertical luma edges remain
geometry-invariant at x = 8k regardless of any of this. The full mathematics
is in the ratified MPEG-2 authority; it is not summarised here, because a
summary of unratified detector mathematics is exactly the kind of duplicate
this project has been bitten by.

---

# 4. Main design decisions

## Canonical correctness (per filter)

Each filter's ReleaseSafe scalar implementation is its executable specification. The required relationship, per filter, against that scalar oracle:

```text
INTEGER:  scalar == v2 == v3        (byte-exact)
FLOAT:    same specified algorithm; v2 and v3 within a measured tolerance;
          structural results (geometry, masks, bounds, tails, lane mapping)
          EXACT; the near-threshold numeric activation decision may differ for
          float only, within a decision-boundary bound; integer shows zero
          activation differences.
```

Float output is NOT required to be byte-identical across backends or machines; hardware accuracy differences are a feature, not a defect. `backend="x86_64_v1_baseline"` (scalar) gives a reproducible reference.

For `deblock4.Classic`, the pinned HolyWu C/scalar implementation is the normative EXTERNAL oracle (on all planes, including luma-on-chroma). For `deblock4.Deblock4`, HolyWu is an initial quality reference only, not an absolute oracle.

## Schedule is output-defining (Deblock4)

Two scalar schedules are tested before SIMD work:

```text
Schedule A: verified HolyWu-equivalent raster/interleaved order
Schedule B: whole-plane vertical pass, then whole-plane horizontal pass
```

Only the quality winner becomes production. Schedule C is deferred.

## Proper chroma (Deblock4 only)

`deblock4.Deblock4` uses a proper chroma filter (reads p1 p0 q0 q1; changes p0 q0 only) - gentler, cheaper, and more safely batchable than applying the luma filter to chroma. `deblock4.Classic` deliberately does NOT do this; it reproduces HolyWu's luma-on-chroma behaviour, because Classic's value is being the known reference.

## Boundaries and SIMD tails

```text
Incomplete algorithmic footprint:  leave unchanged
Complete footprint underfilling a vector:  still process (narrower SIMD or scalar)
```

No whole-frame padding/resize/crop; no undocumented stride padding.

## Runtime architecture

```text
global once:   detect immutable CPU/OS capabilities (whole named levels)
per instance:  resolve auto / x86_64_v3_with_avx2 / x86_64_v2_with_sse41 /
               x86_64_v1_baseline; store immutable entry points
per frame:     no feature test or backend-choice branch
```

The one DLL contains shared generic/dispatch plus, per filter, scalar/v2/v3 backends. Tiers are the named x86-64 psABI levels used IN FULL (FMA is part of the v3 level and is NOT excluded; `.strict` prevents contraction, so ordinary a*b+c is not result-changing fused). Whole-level dispatch selects the highest fully-satisfied level, falling back v3 -> v2 -> v1.

## Diagnostics

Each filter instance emits its version, filter name, requested backend, selected tier, and any fallback reason to stderr ONCE per filter-instance creation (not per frame). Output frames record:

```text
Deblock4Filter    "Classic" | "Deblock4"
Deblock4Tier      the selected named level
Deblock4Version
# Deblock4-only grid properties (Classic omits them):
Deblock4GridMode, Deblock4LumaStepX/Y, Deblock4ChromaStepX/Y, Deblock4MidpointScale
```

---

# 5. Initial limitations

- The Deblock4 filter does not filter anything yet; only Classic is usable.
- Two core filters this round: Classic first, then Deblock4. QED variants are later.
- `grid_mode="auto"` is reserved but initially unavailable.
- No named interlaced separated-field MPEG-2 4:2:2 preset initially (YUV422 and custom steps remain available; progressive 4:2:2 uses the progressive preset).
- No initial MJPEG or DV presets.
- No initial spatial grid-origin offset; run before cropping when coded-grid alignment matters.
- Schedule C is deferred.
- Deblock4 is a post-decoding spatial filter, not a complete codec loop-filter.
- AVX2 speed benefit is measured, not assumed.
- Exact Zig build syntax, the CPU detector, and frame-property mechanics remain implementation spikes.

---

# 6. Development stages

```text
Stage 1       COMPLETE. Shared scaffold: Zig project, one-DLL link,
              tiering/dispatch skeleton, runtime capability detection,
              filter creation for both filters.
Stage 2C      COMPLETE. Classic scalar core, proven byte-identical to the
              HolyWu reference; it is now the in-tree yardstick (oracle).
Stage 3C      COLLAPSED. Its only content (a quality question about one
              threshold derivation) is deferred to a later quality phase.
Stage 4C      COMPLETE (accepted 2026-08-13). Classic SSE4.1 vector
              backend, proven byte-identical to the scalar yardstick.
Stage 5C      COMPLETE (accepted 2026-08-15). Classic AVX2 backend: the
              same width-generic vector code at 256-bit, proven
              byte-identical. Identity 0.1.0-dev+5C.
M1, M2        COMPLETE. Post-5C maintenance commits on top of 5C.

              CLASSIC IS FINISHED for the ratified integer tier set.

DOCUMENTATION AND DESIGN WORK NOW, NOT CODE:
T1            IN PROGRESS. Formal consolidation sweep of the MPEG-2-bearing
              document set - 47 live documents under a frozen search frame.
              It runs BEFORE the detector mathematics, because the README
              has already proved a ratified design can sit unread in a
              document nobody swept.
T5, T6        AFTER T1. T5 derives the detector/feature mathematics; T6 is
              the D4-Q14 experiment plan. T5 must be frozen before any
              held-out judgement.
D4-Q14        THE GATE. The discriminator experiment decides whether B2 or
              D may enter kernel development, on per-macroblock ground
              truth from real PAL MPEG-2 bitstreams. It is not a forced
              binary: if neither is viable the architecture reopens.
              NOTHING SHIPS AT Q14 - oracle, kernel, chroma, quality and
              SIMD gates all still follow.

Stage 2D..5D  Deblock4 filter: scalar core, oracle, then vector backends.
              CANNOT BE SCOPED until Q14 reports and W3X ratifies. The
              earlier description of 2D as "grids, schedules, midpoint,
              proper chroma" named the rejected midpoint machinery and has
              been removed.
Stage 6       VapourSynth integration, validation matrix, packaging

```

---

# 7. Correctness testing (per filter)

```text
ReleaseSafe scalar oracle
    == production ReleaseFast scalar
    == v2 (integer byte-exact; float within tolerance, structural exact)
    == v3 (integer byte-exact; float within tolerance, structural exact)
```

The production scalar is checked against the ReleaseSafe oracle at least once per release. For Classic, output is additionally compared against the pinned HolyWu C/scalar external oracle (integer byte-exact target; float bounded).

Also: complete arithmetic range proofs; exhaustive small dimensions; block/vector-boundary dimensions; incomplete footprints vs valid SIMD tails; memory-safety (arbitrary strides/alignments, canaries, no assumed padding); float exceptional values (NaN/inf/signed-zero/subnormal, per-position masking); quality corpora (blocky MPEG-2, field-separated restoration material, chroma-dominant); assembly checks (no forbidden instructions; intended XMM/YMM; no accidental AVX-512; vzeroupper); full-filter benchmarks.

---

# 8. Remaining open items

THE GATING ITEM: the D4-Q14 architecture-discriminator experiment. Until it reports, the Deblock4 filter has no ratified algorithm to implement.

Measurement, after Q14: Schedule A/B winner; proper-chroma quality; the detector's confidence and UNKNOWN thresholds; Architecture D's false-activation rate at its one uncertain internal candidate. The default `midpoint_threshold_scale` is NO LONGER an open item - the mechanism it belonged to is rejected.

Bounded spikes: Zig 0.16.0 object/link syntax; whole-level detection mechanism (one mechanism for target + detection); VapourSynth frame-property writes.

Deferred: interlaced separated-field MPEG-2 4:2:2 preset; MJPEG research; automatic grid selection; automatic strength analysis; Deblock4_qed; Deblock4_qed_autoadjust.

---

# 9. Practical starting point

**There is no useful Deblock4 invocation yet.** The filter returns frames
unchanged whatever you pass it, so any example here would be a recommendation
to run a filter that does nothing.

Earlier versions of this document recommended
`grid_mode="mpeg2_field_separated"` as the starting point for restoration
clips. That is the REJECTED architecture and the recommendation has been
removed. It is called out rather than silently deleted because someone may
have copied it.

What you CAN use today:

```text
core.deblock4.Classic(clip, strength=25, backend="auto")
```

Classic is complete, proven byte-identical across all three backends against
its scalar oracle, and faithful to the HolyWu reference including
luma-on-chroma. It is an H.264-grid filter - appropriate for H.264-style
material, and it is not MPEG-2-aware.

Development priority from here: finish the T1 documentation sweep -> derive
the detector mathematics (T5) -> plan and run the D4-Q14 discriminator
experiment (T6) -> ratify an architecture -> Deblock4 scalar core and oracle
-> Deblock4 vector backends -> integration and release validation.

---

*Revision history*
```text
v1.4 (2026-08-18) Currency and safety correction at a project changeover.
     v1.3 was written before the MPEG-2 architecture was re-decided and had
     become actively misleading: its "practical starting point" recommended
     grid_mode="mpeg2_field_separated" - the REJECTED architecture - as the
     way to process restoration clips, its grid table listed that mode as
     supported, it described the rejected midpoint row model as live design,
     and it said Stage 5C was NEXT when 5C plus two maintenance scopes are
     complete. Added section 0 stating plainly that the Deblock4 filter has no
     kernel, that its parameter surface is legacy scaffolding awaiting D4-Q16,
     and what the adopted architecture actually is. Rewrote the stage list to
     show T1, T5/T6 and the Q14 gate. Rewrote section 9: there is no useful
     Deblock4 invocation yet, and the removed recommendation is named rather
     than silently deleted because someone may have copied it. Downgraded the
     status line - this document is an authority in no domain, and the README
     is not controlling. Converted LF line endings to CRLF to match the rest
     of the set.
     THIS DOCUMENT REMAINS IN SCOPE for the T1 consolidation sweep at step
     T1S05, which may retire it or reduce it to a pointer-only index. It is
     updated now rather than left stale because a document that recommends a
     rejected architecture cannot safely wait for its turn in a queue.
```
