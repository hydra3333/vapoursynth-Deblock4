# Deblock4 - Concise Project Summary

**Version:** 1.7
**Date:** 2026-08-19
**Status:** INFORMATIVE user-facing companion. It is an authority in NO domain.
The AI Charter controls; for every MPEG-2 matter the ratified
`Deblock4_MPEG2_Deblocking_Investigation_and_Decided_Architecture` prevails
over this document, over the README, and over any other statement in the set.
**Encoding:** US-ASCII; CRLF.

---

# 0. READ THIS BEFORE ANYTHING ELSE - WHAT IS LIVE AND WHAT IS NOT

```text
THE DEBLOCK4 FILTER STILL HAS NO FILTERING KERNEL. Every live dispatch path is
pass-through/writable-copy infrastructure. Classic is complete for the ratified
integer tier set at identity 0.1.0-dev+5C plus completed M1/M2 maintenance.

THE OLD DEBLOCK4 PARAMETER SURFACE BELOW IS LEGACY SCAFFOLDING. It was ratified
at Stage 1C, BEFORE the architecture was re-decided, and it awaits redesign
under issue D4-Q16. In particular:

    grid_mode="mpeg2_field_separated"   REJECTED ARCHITECTURE. Do not use it,
                                        do not recommend it, and do not treat
                                        the 8x4 field-separated grid as a
                                        supported design. Its geometry was an
                                        artefact of separated-field
                                        coordinates and is FALSE in the whole
                                        frame the filter actually receives.
    midpoint_threshold_scale            part of the same rejected design.
    luma_midpoint_enabled               same.
    Deblock4LumaStepY and the other     cannot express the adopted
    grid frame properties               architecture's mixed geometry.

The filter still ACCEPTS these parameters, because the scaffolding is committed
and its removal is a separate bounded task under D4-Q16. ACCEPTING THEM IS NOT
ENDORSING THEM.

CURRENT ARCHITECTURE:
    B2 is the primary candidate;
    D is the mandatory detector-free comparator/fallback;
    A and C are rejected;
    Q14 has not run;
    no kernel scope may be drafted before Q14 reports and W3X ratifies what may
    enter later kernel/oracle development.

THE ADOPTED ARCHITECTURE, IN ONE PARAGRAPH: the filter takes the WHOLE
reconstructed interleaved frame plus a declared source mode. SeparateFields is
NOT a supported contract - it tears frame-organised transform blocks across two
clips, four rows into each, so no single field-clip filter instance holds the
original eight consecutive rows. Architecture B2 is the PRIMARY CANDIDATE:
classify each 16x16 luma macroblock as FRAME, FIELD or UNKNOWN, then derive the
horizontal edge topology explicitly rather than assuming a generic phase.
Architecture D, which needs no detector, is the mandatory comparator and
fallback and must meet its own separate viability bar. NEITHER has passed the
D4-Q14 discriminator experiment, which has not yet been designed. No kernel may
be written before it reports.

CURRENT WORK IS T1 DOCUMENT CONSOLIDATION, NOT CODE.
The preceding W3D session died after delivering Classification Repair v1.1 and
before delivering its promised a5 ledger rewrite. W3C reconstructed that ledger
as v1.4 solely for recovery. Because W3C authored it, successor W3D must
independently verify/adopt/correct it before W3X closes a5. T1S01a5b must not
start before that closure.

CURRENT T1 POPULATIONS:
    frozen T1S00 survey ........ 47 documents;
    current adjudication ....... 41 documents;
    settled a5 search snapshot . 46 files.
T1/ is process/workshop material, and GAIS_investigations/ is ignored for T1
search/adjudication. Neither is applicable project knowledge merely because it
exists in dev_documentation.

AFTER T1:
    T8 provenance-gap closure -> T5 detector mathematics -> separately-ratified
    T6/Q14 planning.

FOR PRECISE LIVE STATE:
    T1 task/recovery ..... Deblock4_T1_Resume_Brief section 0a, latest;
    project state ........ Deblock4_Project_Status section 0, latest;
    MPEG-2 authority ..... Deblock4_MPEG2_Deblocking_Investigation_and_
                           Decided_Architecture v1.05 unless W3X supplies a
                           later ratified version;
    work decisions ....... Deblock4_Standing_Task_Register_T_Series, latest.

NOTHING HAS BEEN RATIFIED INTO ANY AUTHORITY DOCUMENT BY THE T1 SWEEP. Every
ledger remedy is a PROPOSAL until W3X ratifies the corresponding authority
change. The MPEG-2 authority is still at v1.05 and that is DELIBERATE, not
staleness - if you meet a higher generation, something was ratified and you
should ask W3X what.

This summary is informative only and remains in scope for later T1 adjudication.
IT IS NOT A DEFINITIVE SOURCE OF PROJECT KNOWLEDGE and must not be cited as one.
It is a short reading of Project Status; where the two differ, Project Status
section 0 is right and this document has staled.
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
Stage 2C      COMPLETE. Classic ReleaseSafe scalar core, proven byte-identical
              to the pinned HolyWu r9 reference; it is now the IN-TREE
              YARDSTICK (oracle) that every later Classic backend is proved
              against.
Stage 3C      COLLAPSED. Its only content - a quality question about one
              threshold derivation - is deferred to a later quality phase.
Stage 4C      COMPLETE (accepted 2026-08-13). Classic SSE4.1 / x86-64-v2
              vector backend, proven byte-identical to the scalar yardstick.
Stage 5C      COMPLETE (accepted 2026-08-15). Classic AVX2 / x86-64-v3
              backend: the same width-generic vector code at 256-bit, proven
              byte-identical.
M1, M2        COMPLETE. Post-5C maintenance commits on top of 5C.
Identity      0.1.0-dev+5C.

CLASSIC       COMPLETE for the ratified integer tier set.

DOCUMENTATION AND DESIGN WORK NOW, NOT CODE:

T1            IN PROGRESS. Formal consolidation sweep of the MPEG-2-bearing
              document set under a frozen search frame. IT RUNS BEFORE THE
              DETECTOR MATHEMATICS, because the README has already proved a
              ratified design can sit unread in a document nobody swept.
              a5 search/classification repair is settled; successor-W3D
              verification of the recovery ledger and W3X closure remain.
              a5b/a6/a7 have not started.
              THIS DOCUMENT IS NOT MAINTAINED FOR SUB-TRANCHE STATE and will
              stale between them. Read Deblock4_T1_Resume_Brief section 0a.

T8            AFTER T1. Close provenance gaps T1 identifies.
T5            AFTER T8. Derive detector/features/confidence/UNKNOWN maths.
T6/Q14        AFTER T5 and separately ratified. Plan/run the discriminator.

Q14           GATE. B2 may advance only if viable; otherwise D only if viable;
              if neither is adequate, reopen architecture. Nothing ships at
              Q14.

Deblock4      scalar/oracle/kernel and vector backends are FUTURE and cannot be
              scoped from the old Stage-2D shorthand. The future sequence must
              follow whichever architecture W3X permits after Q14.
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

Immediate process gate: **close T1S01a5 recovery correctly**. Successor W3D
must independently verify/adopt/correct the W3C-authored recovery ledger v1.4;
W3X then closes the one-off review path before a5b starts.

After T1, T8 closes the provenance gaps T1 named. The highest-priority recorded
item is the basis for F8 vertical-geometry invariance because later architecture
relies on it.

After T8, T5 derives the detector/features/confidence/UNKNOWN mathematics. T6
then specifies the Q14 experiment under a separate ratification. Q14 still
requires per-macroblock ground truth from real target-like MPEG-2 bitstreams.

Later measurement/quality items remain gated by the architecture and scalar
oracle sequence. Rejected Architecture-A midpoint parameters are not open
quality knobs waiting to be tuned; their mechanism is retired - the default
`midpoint_threshold_scale` is NO LONGER an open item.

BOUNDED SPIKES still outstanding: Zig 0.16.0 object/link syntax; the
whole-level detection mechanism (ONE mechanism for compile target and runtime
detection, so the two cannot drift); VapourSynth frame-property writes.

DEFERRED WORKSTREAMS, listed so they are not mistaken for open items:
named interlaced separated-field MPEG-2 4:2:2 preset; MJPEG and DV research;
automatic grid selection; automatic strength analysis; Deblock4_qed;
Deblock4_qed_autoadjust; Schedule-SC. NONE is scheduled, and none is blocked
on anything currently in flight.

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

Development priority from here: close the current T1 recovery gate -> finish
T1 -> close provenance gaps at T8 -> derive detector mathematics at T5 ->
separately ratify/plan Q14 at T6 -> run Q14 -> ratify what architecture may
enter Deblock4 scalar/oracle development -> vector backends -> integration and
release validation.

---

*Revision history*

```text
v1.7 (2026-08-19) RESTORATION PASS. v1.6's state currency is retained in full;
     what returns is material v1.6 dropped with no mandate, all of it the
     REASONING rather than the status. Restored from v1.5:
       - the per-parameter REJECTED-ARCHITECTURE warning table, including the
         instruction not to use or recommend `mpeg2_field_separated`, the
         naming of the 8x4 field-separated grid, and the reason - its geometry
         was an artefact of separated-field coordinates and is FALSE in the
         whole frame the filter receives;
       - why the rejected parameters are still ACCEPTED, and that accepting
         them is not endorsing them;
       - the adopted architecture in one paragraph, including the
         SeparateFields TEARING MECHANISM and B2's classify-then-derive
         description;
       - "NOTHING HAS BEEN RATIFIED INTO ANY AUTHORITY DOCUMENT", every ledger
         remedy being a PROPOSAL, and v1.05 being deliberate rather than stale;
       - the Stage 2C HolyWu provenance and the in-tree yardstick role, and the
         4C/5C acceptance dates;
       - why T1 runs BEFORE the detector mathematics;
       - the BOUNDED SPIKES and DEFERRED WORKSTREAM lists.
     ADDED, at W3X's direction: an explicit statement that this document is NOT
     a definitive source of project knowledge, is a short reading of Project
     Status, and loses to Project Status section 0 wherever the two differ.
     ALSO REPAIRED: v1.6's revision record had SPLIT INTO TWO BLOCKS - a
     "Revision history" carrying only v1.4 and a separate "Revision note"
     carrying v1.6 and v1.5 out of order - and every entry before v1.4 had been
     dropped. One block, newest first, restored below.
     No architecture, parameter or implementation authority is created here.
v1.6 (2026-08-19) Recovery/current-state reconciliation. Records the a5
     classification repair as settled, the W3C ledger v1.4 as a recovery
     artifact requiring successor-W3D independent verification, and a5b as
     blocked until W3X closes that recovery path. Separates 47 frozen-survey /
     41 current-adjudication / 46 settled-a5-search populations; records T1/
     and GAIS_investigations/ applicability rules; and updates the downstream
     route to T1 -> T8 -> T5 -> separately-ratified T6/Q14. No architecture,
     parameter or implementation authority is created by this summary.
     ITS OMISSIONS ARE RESTORED AT v1.7 AND ARE LISTED THERE.
v1.5 (2026-08-18) Routing only; no status, architecture or parameter content
     changed. The T1 entry now states that the MPEG-2 authority is being
     adjudicated in declared sub-tranches with the last declared final, points
     at the resume brief's section 0a as the maintained record, and says
     plainly that this document is NOT maintained for that and will stale
     between sub-tranches. Also restates that nothing has been ratified into
     any authority document and that the MPEG-2 authority remains at v1.05
     deliberately.
     THIS DOCUMENT REMAINS IN SCOPE for the T1 sweep and has not been
     adjudicated.
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
v1.3 and earlier: see repository history. Their entries were dropped from this
     document before v1.7 and are not reconstructed here rather than invented.
```
