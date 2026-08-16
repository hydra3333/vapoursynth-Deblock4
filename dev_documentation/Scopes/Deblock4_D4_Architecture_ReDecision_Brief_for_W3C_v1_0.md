# Deblock4 - Architecture Re-Decision Brief for W3C - Union-Grid vs
# Detect-and-Schedule

**Deliverable:** W3D-D4-ARCH-2 (for W3C review), W3X-requested
**Version:** 1.0
**Date:** 2026-08-16
**Nature:** INVESTIGATION AND ADVICE ONLY. No repository file changes. The
Deblock4 architecture decided on 2026-08-16 is RE-OPENED and must be
re-decided before any kernel scope.
**Why re-opened:** W3D discovered, while consolidating documentation, that
the project's own README design spec ALREADY CONTAINS a fully-worked
Deblock4 grid architecture that neither GAIS, nor W3C, nor W3D surfaced
during the entire investigation - because W3D did not read it. That is a
W3D process failure and it is recorded as one. The README design is a THIRD
architecture, materially different from both options we debated.
**Encoding:** US-ASCII; CRLF.

---

# 1. What is settled and NOT re-opened

```text
These stand (see the MPEG-2 Deblocking Investigation and Decided
Architecture document v1.00 for provenance):
  F4  [H.262-VERIFIED] In 4:2:0, when a FRAME PICTURE uses field DCT, the
      CHROMA blocks remain FRAME-ORGANISED (8 consecutive chroma rows).
      Field DCT applies to LUMA only. 4:2:2 and 4:4:4 chroma follow luma.
  F5  dct_type is per MACROBLOCK and may vary within one frame picture.
  F6  A post-decode filter cannot know dct_type; it can only measure
      pixels and be seeded by a user declaration.
  F7  TFF/BFF does not affect block geometry.
  D4-D01  WHOLE-FRAME INPUT CONTRACT. SeparateFields TEARS frame-organised
      blocks across two clips (4 rows each), so no field-clip instance can
      deblock Case (a) chroma or progressive material at all.
  D4-D06  NO HIDDEN TEMPORAL STATE in v1 (fmParallel determinism).
  D4-D08  Deblock4 gets its OWN oracle; nothing inherited from Classic.
  D4-D09  v1 filters the nominal grid only; inherited grid-shifted
      blockiness is a documented limitation.
```

# 2. The three architectures now on the table

## 2.1 ARCHITECTURE A - UNION GRID WITH SCALED THRESHOLDS (the README design)

Source: README_Deblock4_Design_Spec_v1_11 sections 3.11 and 3.13, and the
settled-decisions table. This is EXISTING RATIFIED PROJECT DESIGN, not a
new proposal.

```text
MECHANISM (as written, for field-separated input):
  luma_edge_step_y = 4, giving a step-4 vertical candidate grid with TWO
  POSITION CLASSES:
        primary  : y mod 8 == 0
        midpoint : y mod 8 == 4
  Both classes use THE SAME activation test. The midpoint uses SCALED
  alpha/beta thresholds - that is what midpoint_threshold_scale is.
        S = round_half_up(scale * 65536)
        scale_threshold(t,S) = (i64(t)*i64(S) + 32768) >> 16
  Converted ONCE at filter creation into two immutable threshold sets;
  no multiply, conversion or float in any pixel kernel. Only alpha and
  beta are scaled - tc0 and the one-sample addition are NOT, so a
  midpoint that passes the stricter evidence test is corrected at normal
  strength. The midpoint test reads the CURRENT DESTINATION STATE at that
  point in the canonical schedule, like every other edge decision.

RATIONALE, quoted from the README: "frame-DCT-coded MPEG-2 areas project
to a four-field-row pitch after field separation. Field-DCT-coded areas
have real boundaries only at the primary positions. The step-4 set is
therefore the smallest single candidate set that contains every real luma
boundary in mixed material."

WHAT IT IS, ABSTRACTLY: do not classify, do not measure phase - FILTER THE
UNION of both candidate phase sets, and let the EXISTING per-edge
activation test plus a stricter threshold at the uncertain positions
decide what is really a boundary. Confidence is expressed as THRESHOLD
SCALING, not as a decision.

WHAT IT AVOIDS BY CONSTRUCTION: no dct_type inference; no UNKNOWN state;
no per-region decision, so no seams, no temporal flicker, no classifier
failure on static field-coded content; no second detector pass; no
per-region state at all. It is a single-pass, deterministic, pure
function of the frame.

WHAT IT COSTS: it tests roughly twice as many luma candidate positions
vertically, and it accepts that a proportion of tested positions are not
real boundaries - relying entirely on the activation test to reject them.
```

## 2.2 ARCHITECTURE B - DETECT AND SCHEDULE (what we decided on 2026-08-16)

```text
Detect per region (measure block-boundary energy at both candidate
phases) -> emit phase + confidence + explicit UNKNOWN -> compile
geometry-homogeneous spans (plane, orientation, phase, pitch, parity,
bounds) -> filter each span at its pitch. Chroma in Case (a) forced to
the 8-consecutive frame grid. UNKNOWN spans filter nothing (v1).
Gated on D4-Q14: is phase energy separable on real material?
```

## 2.3 ARCHITECTURE C - CLASSIFY BY MOTION (rejected, recorded for completeness)

```text
Infer dct_type from D_frame vs D_field. REJECTED: fails on static
field-coded content, where D_frame is approximately D_field but the
boundaries are staggered - the real boundaries go unfiltered AND
non-boundaries get blurred. GAIS proposed, then retracted, this.
```

# 3. THE TRANSPOSITION PROBLEM - the crux W3C must check

Architecture A was designed for SEPARATED-FIELD input, which D4-D01 now
forbids. It must therefore be TRANSPOSED to whole-frame input, and W3D has
NOT verified that the transposition preserves its properties. This is the
single most important thing to check.

```text
W3D's TRANSPOSITION SKETCH (VERIFY OR REFUTE - do not assume it is right):

In a separated field clip, one field's rows are consecutive. Frame-DCT
blocks project to a 4-field-row pitch; field-DCT blocks have boundaries
every 8 field rows. Hence step-4 in field-clip coordinates.

In the INTERLEAVED FRAME, filtering within one field means pitch 2. The
same union set should therefore become, per field, candidate boundaries
every 4 FIELD rows = every 8 FRAME rows within that field's parity, with
taps at pitch 2. Expressed in frame coordinates for a given parity p in
{0,1}: candidate boundary before frame row y where y mod 8 == p... [W3D
IS NOT CONFIDENT OF THIS EXPRESSION - derive it properly.]

QUESTIONS W3C MUST ANSWER:
  T1  Write the candidate boundary set for Architecture A transposed to
      whole-frame input, EXACTLY, in frame-row coordinates, for each of
      the three geometries and for each parity, with the six-tap
      footprints. Show the derivation, not just the result.
  T2  Does the union set in whole-frame Case (a) contain EVERY real luma
      boundary for both frame-DCT and field-DCT macroblocks? That is the
      README's core claim ("smallest single candidate set that contains
      every real boundary"). Prove it or find the counterexample.
  T3  How many candidate positions are NOT real boundaries, as a fraction?
      In the separated-field formulation the answer was 2x. Is it still
      2x after transposition, or worse?
  T4  DO THE TWO PHASES OVERLAP OR COLLIDE after transposition? W3D's
      concern: frame-DCT boundaries sit between frame rows 7/8, 15/16;
      field-DCT boundaries for the even field sit between frame rows
      14/16 and for the odd field between 15/17. These are NEARBY but not
      identical. If a position is tested under both phases, is any pixel
      filtered TWICE in one pass, and if so what is the consequence?
      This is the property most likely to break the transposition.
  T5  CHROMA. In whole-frame Case (a), F4 fixes chroma at 8 consecutive
      chroma rows with NO ambiguity and NO midpoint class. The README's
      "chroma 8x4, no dct_type ambiguity" line is the D4-Q01 DEFECT and
      does not survive. Confirm that Architecture A's luma-only midpoint
      policy transposes cleanly with chroma simply fixed - i.e. that
      nothing in the mechanism depends on chroma sharing the step-4 set.
```

# 4. W3D's assessment and recommendation

```text
W3D's POSITION, offered for testing, not as a conclusion:

Architecture A is probably better than Architecture B, for four reasons:
  1. It eliminates an entire failure class rather than mitigating it. B
     must detect, and every detector has failure modes (noise floor,
     texture masking, flicker, seams, UNKNOWN policy). A has no detector.
  2. It is deterministic and stateless by construction - it satisfies
     D4-D06 trivially rather than by discipline.
  3. Its uncertainty mechanism is CONTINUOUS (threshold scaling) rather
     than a HARD DECISION. A hard per-region decision is wrong or right;
     a scaled threshold degrades gracefully and is user-tunable.
  4. It is already designed to this project's standards: fixed-point,
     creation-time conversion, no float in the kernel, immutable
     threshold sets, canonical-schedule read ordering.

The strongest argument AGAINST A, which W3C should press hard: it
deliberately tests positions that are not boundaries, relying wholly on
the activation test to reject them. On flat, low-contrast or noisy
content the activation test may accept a midpoint that is NOT a block
boundary, blurring real detail at every 4th row. Architecture B at least
tries to avoid testing there. Is midpoint_threshold_scale a sufficient
control for this, or is it a knob that merely trades one failure for
another?

W3D's RECOMMENDATION: adopt A as the PRIMARY candidate, subject to W3C's
transposition verification (section 3) and to the false-activation
question above. Retain B's SPAN COMPILATION idea regardless - A still
needs geometry-homogeneous spans for SIMD, since Case (b) and Case (a)
have different pitches. If A survives, D4-Q14 changes character
completely: it stops being an architecture gate and becomes a
QUALITY question (how often does a midpoint falsely activate on real
material?), which is cheaper and lower-risk.
```

# 5. What W3D asks of W3C

```text
A1  Answer T1-T5 in section 3. T4 is the one most likely to kill the
    transposition; do it carefully.
A2  Press the false-activation argument in section 4. Quantify it if you
    can: for a plausible alpha/beta and a plausible flat-area gradient,
    how likely is a non-boundary midpoint to activate?
A3  RECOMMEND: A, B, a hybrid, or something none of us has proposed. A
    reasoned dissent from W3D is worth more than agreement; W3D has now
    been wrong four times in this project and W3C caught each one.
A4  SIMD consequence of A versus B. A tests more positions but has no
    per-region branching; B tests fewer but needs span compilation. Which
    vectorises better, given the accepted 4C/5C patterns?
A5  Flag anything else in the README design spec bearing on Deblock4 that
    W3D has not yet consolidated - W3D has read only sections 3.11/3.13
    and the settled-decisions table so far, and the consolidation sweep is
    PAUSED pending this re-decision. If you see other load-bearing
    Deblock4 design content there, say so.
```
