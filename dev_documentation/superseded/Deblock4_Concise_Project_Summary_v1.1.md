# Deblock4 - Concise Project Summary

**Version:** 1.1
**Date:** 2026-07-29
**Status:** User-facing companion only. The README specification and AI Charter remain controlling.
**Encoding:** US-ASCII only

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

| `grid_mode` | Luma | Chroma | Use |
|---|---:|---:|---|
| `"mpeg2_progressive"` | 8 x 8 | 8 x 8 | Progressive MPEG-2 4:2:0 or 4:2:2 |
| `"mpeg2_field_separated"` | 8 x 4 | 8 x 4 | Field-separated MPEG-2 4:2:0 |
| `"custom"` | explicit | explicit | Expert/proof use |
| `"auto"` | reserved | reserved | Initially rejected; future feature |

The H.264 4x4 grid is NOT a Deblock4 grid_mode; it is provided by the separate `deblock4.Classic` filter.

Steps are measured in each plane's own samples. For field-separated MPEG-2 4:2:0 luma:

```text
primary rows:   y mod 8 == 0
midpoint rows:  y mod 8 == 4
```

The midpoint threshold scale controls how difficult it is for the additional midpoint rows to activate; its release default is selected by quality testing.

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
Stage 1     shared scaffold: Zig project, one-DLL link, tiering/dispatch,
            whole-level CPU/OS detection (1B.2 confirms within-level; 1B.3
            implements the guard)

Classic first, then Deblock4:
Stage 2C..5C  Classic: scalar oracle + HolyWu external reference; compatibility
              gate; v2 backend; v3 backend
Stage 2D..5D  Deblock4: scalar core (grids, schedules, midpoint, proper chroma);
              quality decisions; v2 backend; v3 backend

Stage 6     VapourSynth integration, validation matrix, packaging (both filters)
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

Measurement: Schedule A/B winner; default midpoint_threshold_scale; proper-chroma quality; AVX2 benefit and generated-code quality; the exact HolyWu commit/tag to pin as Classic's oracle (at Stage 2C).

Bounded spikes: Zig 0.16.0 object/link syntax; whole-level detection mechanism (one mechanism for target + detection); VapourSynth frame-property writes.

Deferred: interlaced separated-field MPEG-2 4:2:2 preset; MJPEG research; automatic grid selection; automatic strength analysis; Deblock4_qed; Deblock4_qed_autoadjust.

---

# 9. Practical starting point

For a typical field-separated MPEG-2 4:2:0 restoration clip:

```text
core.deblock4.Deblock4(clip, grid_mode="mpeg2_field_separated",
                       strength=25, backend="auto")
```

For progressive MPEG-2: `grid_mode="mpeg2_progressive"`.
For H.264/HolyWu-style material: use `core.deblock4.Classic(clip, ...)` (the H.264 filter), not a Deblock4 grid mode.

Development priority: shared scaffold -> Classic scalar + external-oracle proof -> Classic v2/v3 -> Deblock4 scalar + measured schedule -> Deblock4 v2/v3 -> integration and release validation.
