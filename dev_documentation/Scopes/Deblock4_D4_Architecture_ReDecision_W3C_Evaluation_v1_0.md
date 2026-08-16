# Deblock4 - D4 Architecture Re-Decision - W3C Joint Evaluation

**Deliverable:** W3C-D4-ARCH-REDECISION-1
**Version:** 1.0
**Date:** 2026-08-16
**From:** W3C
**Route:** W3C -> W3X -> W3D
**Basis:** `Deblock4_D4_Architecture_ReDecision_Brief_for_W3C_v1_0.md`,
the supplied current `dev_documentation` generation, and the supplied current
`src` tree.
**Nature:** INVESTIGATION AND ADVICE ONLY. No repository file is changed by
this review.
**Encoding:** US-ASCII; CRLF.

---

# DECISIONS/QUESTIONS FOR W3X

## R1 - Do NOT adopt old Architecture A as the primary whole-frame design

**W3C recommendation: REJECT Architecture A as the primary architecture.**

The reason is geometric, not stylistic. The elegant old primary/midpoint union
exists because, after field separation, BOTH frame-DCT and field-DCT luma are
being expressed in one field-coordinate system and therefore share one
same-field filtering footprint. Returning to the woven whole frame destroys
that common-footprint property:

- a true frame-DCT horizontal edge is a pitch-1 edge between consecutive frame
  rows;
- a true field-DCT horizontal edge is a pair of pitch-2 same-field edges,
  one per parity.

There is no faithful whole-frame "single candidate grid + same footprint"
transposition that preserves both.

Two possible transpositions exist:

1. preserve old A literally by operating luma internally as two pitch-2 field
   views; this is deterministic and collision-free, but it does NOT apply the
   true pitch-1 frame-DCT footprint;
2. take the actual union of pitch-1 frame edges and pitch-2 field edges; this
   contains every true edge, but the operations overlap and double-write pixels
   at macroblock-row boundaries, making the old A mechanism no longer a simple
   union.

That is a structural failure of A's whole-frame transposition, not a tuning
issue.

## R2 - Retain B's detector idea, but replace generic "per-region phase spans"
with a macroblock-topology scheduler (Architecture B2)

**W3C recommendation: ADOPT B2 as the PRIMARY candidate, subject to the
ground-truth experiment.**

The detector should classify the MPEG-2 luma DCT organisation at the natural
unit - the 16x16 macroblock - as:

    FRAME
    FIELD
    UNKNOWN / NO-USABLE-TRUTH

Then derive HORIZONTAL edge work from an explicit transition table.

Important simplification: frame-vs-field DCT changes the HORIZONTAL block-edge
geometry only. The vertical luma block edge remains at x multiples of 8 in both
organisations. A vertical-edge sample is filtered across columns in one row;
there is no reason to split its independent row lanes by field merely because
the macroblock used field DCT.

For each 16-pixel horizontal macroblock segment:

    Internal edge at mb_y + 8:
        FRAME  -> one pitch-1 edge
        FIELD  -> no edge
        UNKNOWN -> policy to be measured

    Macroblock-row boundary at mb_y + 16:
        FRAME / FRAME -> one pitch-1 edge
        FIELD / FIELD -> two pitch-2 parity edges
        FRAME / FIELD -> two pitch-2 parity edges
        FIELD / FRAME -> two pitch-2 parity edges
        UNKNOWN involved -> explicit fallback policy, measured before freezing

The mixed rule is the useful H.264/MBAFF analogy, but Deblock4 must derive and
quality-prove it independently.

Consecutive x macroblocks with the same resolved edge mode are coalesced into
contiguous horizontal SIMD spans. This is more precise than an arbitrary
"region phase" map and gives mixed boundaries an explicit home.

## R3 - Retain an improved detector-free architecture as the REQUIRED fallback
comparator, but it is NOT old A

W3C proposes **Architecture D - whole-frame topology-aware conservative
fallback**:

    vertical luma edges:
        x = 8*k, all rows, unchanged

    horizontal macroblock boundaries:
        y = 16*k
        use two pitch-2 parity edges as the conservative/mixed-compatible form

    horizontal internal candidate:
        y = 16*k + 8
        one TRUE pitch-1 candidate
        optionally gated with the old midpoint alpha/beta scaling idea

This uses whole-frame access to improve on old A:

- it tests the actual frame-DCT internal edge, not two field projections;
- it uses only one uncertain internal candidate instead of two parity
  projections;
- it has no pitch-1/pitch-2 double-write collision.

Its remaining compromise is important: a FRAME/FRAME macroblock-row boundary
is still processed in the pitch-2 conservative form rather than the exact
pitch-1 form.

Architecture D should be measured as the fallback if B2 classification is not
good enough. It should NOT be silently assumed better than B2.

## R4 - Expand D4-Q14 from a "B detector gate" into an architecture
discriminator

Before any Deblock4 pixel kernel scope, the ground-truth experiment should
measure BOTH:

1. B2 classification quality:
   FRAME/FIELD accuracy, confidence, UNKNOWN rate, false-confident rate;
2. A/D false-candidate selectivity:
   distributions of boundary-step and side-activity features at TRUE edges
   versus FALSE internal candidates.

The experiment should also report by boundary type:

    frame/frame
    field/field
    mixed frame/field
    frame-only internal edge
    no-DCT / skipped / motion-only macroblock

Do not force macroblocks with no signalled DCT residual into a false FRAME or
FIELD ground-truth class.

## R5 - Do not let existing Stage-1 API plumbing bias the architecture

The current source has old `mpeg2_field_separated`, midpoint and scalar step
parameter plumbing, but the live Deblock4 pixel path remains pass-through.
That plumbing is cheap to replace compared with getting the algorithm wrong.

Once W3X chooses the architecture, reconcile the public mode/diagnostic surface
BEFORE a D4 kernel scope. In particular, a single frame-level
`Deblock4LumaStepY` cannot truthfully describe B2 mixed whole-frame operation.

---

# 1. Sources reviewed and current implementation state

The re-decision brief explicitly re-opens the 2026-08-16 architecture before
any kernel scope.

The current README is `README_Deblock4_Design_Spec_v1_12.md`. Its own authority
note says it is fallback general guidance where later ratified authority does
not settle a matter. The old primary/midpoint design remains valuable evidence,
but its `field_separated` assumptions cannot override the newer whole-frame
contract.

The current source confirms that no Deblock4 pixel algorithm has landed:

`src/deblock4_ar_all_frames_ready.zig` lines 23-27 selects the backend tier but
all three arms call `passThroughWritableCopy()`.

There IS old creation/API scaffolding:

`src/filter_call_parameters.zig` lines 40-63 still defines:

    mpeg2_progressive
    mpeg2_field_separated
    custom

and the midpoint/custom-step records.

This is implementation debt to reconcile after the architecture decision, not
a reason to preserve the old geometry.

---

# 2. Coordinate convention used for T1-T5

Use the README's established convention:

    e = first sample on the q side of an edge

For a six-tap luma edge with vertical row pitch `s`:

    p2 = e - 3*s
    p1 = e - 2*s
    p0 = e - 1*s
    q0 = e
    q1 = e + 1*s
    q2 = e + 2*s

Read set:

    R_s(e) = {e-3s, e-2s, e-s, e, e+s, e+2s}

Write set for the full luma normal filter:

    W_s(e) = {e-2s, e-s, e, e+s}

For whole-frame field parity:

    p in {0,1}
    field row r maps to frame row y = 2*r + p

A boundary every eight FIELD rows therefore maps to:

    e = 16*k + p
    s = 2

---

# 3. A1 / T1 - exact candidate sets after whole-frame transposition

# 3.1 Progressive / ordinary frame-DCT geometry

Horizontal luma edges:

    e = 8*k
    s = 1

Six-tap footprint:

    e-3, e-2, e-1, e, e+1, e+2

Writes:

    e-2, e-1, e, e+1

No field parity is involved.

Vertical luma edges remain:

    x = 8*k

with ordinary across-column footprint.

# 3.2 Case (a), actual frame-DCT macroblock

A frame-DCT macroblock has true horizontal 8x8 edges at:

    e = 8*k
    s = 1

Within a 16-row macroblock beginning at `M = 16*m`:

    internal block edge:       e = M + 8
    macroblock-row boundary:   e = M + 16

Both use the pitch-1 six-tap footprint.

# 3.3 Case (a), actual field-DCT macroblock

For each parity `p`:

    e = 16*k + p
    s = 2

Six taps:

    e-6, e-4, e-2, e, e+2, e+4

Writes:

    e-4, e-2, e, e+2

Thus at a macroblock-row boundary near frame row 16:

    top/even-field edge:    e = 16
    bottom/odd-field edge:  e = 17

There is no field-DCT internal horizontal edge at frame row 8.

# 3.4 Case (b), separately coded field pictures presented as a woven frame

For each parity `p`:

    e = 16*k + p
    s = 2

The luma footprint is exactly the pitch-2 form above.

For proper chroma the footprint is four samples rather than six. With pitch
`s` it is:

    p1 = e-2s
    p0 = e-s
    q0 = e
    q1 = e+s

and only p0/q0 are written.

# 3.5 What literal old Architecture A becomes

Old A in a separated field uses:

    candidate field row r = 4*m

with:

    primary:  r = 8*k
    midpoint: r = 8*k + 4

Map back with `e = 2*r + p`.

For each parity:

    ALL A candidates:
        e = 8*m + p
        s = 2

    PRIMARY:
        e = 16*k + p

    MIDPOINT:
        e = 16*k + 8 + p

Examples:

    even/top parity:
        8,16,24,32,...
        midpoint 8,24,...; primary 16,32,...

    odd/bottom parity:
        9,17,25,33,...
        midpoint 9,25,...; primary 17,33,...

W3D's sketch `y mod 8 == p` is therefore correct for the UNION SET, but the
primary/midpoint distinction requires mod 16:

    primary:  e mod 16 == p
    midpoint: e mod 16 == 8+p

Every one of these literal-A operations uses pitch 2.

---

# 4. A1 / T2 - does literal A contain every real whole-frame luma boundary?

## Answer: NO, not as the same edge/filtering operation

It contains every **separated-field projection** of a frame-DCT boundary, but
that is not equivalent to scheduling the actual whole-frame pitch-1 edge.

Counterexample: a true frame-DCT edge before frame row 8.

The actual edge is:

    e = 8, s = 1
    reads 5,6,7 | 8,9,10
    writes 6,7,8,9

Literal A schedules two projected edges:

    even parity:
        e = 8, s = 2
        reads 2,4,6 | 8,10,12
        writes 4,6,8,10

    odd parity:
        e = 9, s = 2
        reads 3,5,7 | 9,11,13
        writes 5,7,9,11

Neither projected operation contains the actual adjacent p0/q0 pair 7/8.
Together they read a twelve-row region and can write rows 4 through 11,
whereas the true pitch-1 operation reads six rows and writes 6 through 9.

Therefore old A can be implemented internally on a whole-frame input, but it is
an ALTERNATIVE FILTERING ALGORITHM for frame-DCT luma, not a coordinate
transposition of the true 8x8 edge.

That distinction is decisive because Deblock4's purpose is to deblock the
actual MPEG-2 DCT geometry.

---

# 5. A1 / T3 - candidate overhead and false-position fraction

There are two different counts depending on whether "real" means a true
whole-frame edge operation or an old separated-field projection.

## Literal old A

Per 16 frame rows in Case (a), literal A schedules:

    even parity candidates:  e = 8,16
    odd parity candidates:   e = 9,17

= four pitch-2 operations.

A correct geometry uses two horizontal operations per 16 rows:

    frame-DCT:
        e = 8 and 16, pitch 1

    field-DCT:
        e = 16 and 17, pitch 2

So literal A performs roughly 2x the horizontal-edge operations either way.

In a pure field-DCT region, two of A's four operations (8 and 9) are genuine
false midpoint candidates: 50%.

In a frame-DCT region the four A operations are best described as two
projections for each of the two true frame edges. Calling them all "real"
hides the fact established by T2: they are not the actual pitch-1 operations.

## Faithful actual-geometry union

If A is repaired to contain the actual operations, per 16 rows it contains:

    frame hypotheses:
        e = 8,  s = 1
        e = 16, s = 1

    field hypotheses:
        e = 16, s = 2
        e = 17, s = 2

= four operations for two true operations.

Thus a faithful union is also 2x and, in a pure FRAME or pure FIELD region,
half of its geometry hypotheses are wrong.

---

# 6. A1 / T4 - overlap and double filtering

This is where the two A interpretations diverge.

## Literal old A

The even- and odd-parity pitch-2 jobs write disjoint parity rows, so the two
parity projections do NOT double-write the same pixel.

Adjacent candidate edges within one parity have disjoint write sets, although
their read/write footprints overlap. Therefore canonical top-to-bottom order
still affects later activation.

So W3D's feared pitch-1/pitch-2 collision does not occur in literal A.

But it avoids the collision only because it never schedules the true pitch-1
frame-DCT edge.

## Faithful whole-frame union

At a macroblock-row boundary `e = 16*k`, the actual union contains:

    frame edge F:
        e, s=1
        writes {e-2,e-1,e,e+1}

    even field edge T:
        e, s=2
        writes {e-4,e-2,e,e+2}

    odd field edge B:
        e+1, s=2
        writes {e-3,e-1,e+1,e+3}

Overlaps:

    F intersect T = {e-2,e}
    F intersect B = {e-1,e+1}

Every pixel written by the true frame edge is also written by one of the field
hypotheses if all three activate.

The read footprints overlap even more strongly, so order can change later
activation and output.

Therefore a faithful whole-frame union cannot preserve A's old property of
"just test the union and let the existing local gate decide". It needs one of:

- mutual exclusion;
- hypothesis competition;
- a new composite mixed-geometry kernel;
- or an explicit ordering whose double filtering is itself the new algorithm.

The first two are classification/selection again. The last two require a new
algorithm and proof.

T4 therefore does not merely make A awkward; it removes the mechanism that made
old A attractive.

---

# 7. A1 / T5 - chroma

For 4:2:0 Case (a), the answer is clean.

H.262 fixes chroma to frame-organised 8x8 blocks, so in CHROMA PLANE
coordinates:

    horizontal edges: e_chroma = 8*k
    pitch = 1

There is no midpoint class and no phase detector.

Nothing in a luma-only A/B/B2 mechanism requires chroma to share the luma
candidate set. So 4:2:0 chroma can remain fixed under any of the candidate
luma architectures.

**Important qualification:** this is special to 4:2:0.

The prevailing MPEG-2 facts say 4:2:2 and 4:4:4 chroma FOLLOW the luma
frame/field DCT organisation. If Deblock4 continues to promise those formats,
their Case-(a) chroma scheduler must inherit the resolved macroblock geometry
in the relevant chroma coordinates. The "chroma is always fixed" simplification
must not escape the 4:2:0 scope.

---

# 8. A2 - false activation: the strongest argument against A

The old README says midpoint candidates use the same activation test with only
`alpha` and `beta` scaled. `tc0` and the one-sample correction term remain
normal. Once a midpoint passes, it is corrected at normal strength.

That has three consequences.

## 8.1 W3D's "continuous uncertainty" description is overstated

`midpoint_threshold_scale` is continuous as a PARAMETER, but the per-edge
decision remains a strict binary comparison:

    pass / do not pass

The output therefore still has a hard decision boundary.

Furthermore, correction strength is deliberately NOT scaled after activation.

So Architecture A is not a soft probabilistic blend. It is a tunable hard
activation gate.

## 8.2 A does not eliminate temporal flicker

A removes phase-classifier flicker, but a midpoint whose pixel values move
around an alpha/beta threshold can still toggle active/inactive frame to frame.

Therefore A is deterministic and stateless, but "no temporal flicker" is not a
valid distinguishing claim.

## 8.3 Exact false-positive construction

Consider a non-block picture feature with a small piecewise-flat horizontal
step:

    p2,p1,p0 = A,A,A
    q0,q1,q2 = A+d,A+d,A+d

The side-activity terms are zero.

The canonical H.264-family gate reduces to:

    d < alpha_mid
    0 < beta_mid
    0 < beta_mid

So every such non-block feature satisfying those thresholds ACTIVATES.

This is not probabilistic. It is exact.

Using the familiar Classic 8-bit strength-25 thresholds only as an
ILLUSTRATIVE reference (`alpha=13`, `beta=4`, not a Deblock4 acceptance
basis):

    scale 1.00 -> alpha_mid=13, beta_mid=4
    scale 0.50 -> alpha_mid= 7, beta_mid=2
    scale 0.25 -> alpha_mid= 3, beta_mid=1

For `d=2`, all three scales activate.

With the familiar normal-filter correction values as an illustration:

    input  = 100,100,100 | 102,102,102
    output = 100,100,101 | 101,101,102

Thus a two-level real picture edge at a false midpoint is visibly altered even
at scale 0.25.

To reject the pattern, alpha_mid must be <= 2 (or beta_mid zero). But an actual
two-level compression seam with the IDENTICAL six samples is then rejected too.

No local threshold can distinguish two physically different causes that
produce the same pixel footprint.

That is the irreducible A tradeoff:

    lower scale -> fewer false midpoint edits AND more missed weak real seams
    higher scale -> more weak real seams caught AND more real-detail edits

This does not prove A gives bad pictures. It proves tuning cannot remove the
failure class in principle.

## 8.4 Why a real-world percentage cannot yet be stated responsibly

A false-activation probability requires a distribution of real false-candidate
pixel patterns and the final D4 predicate/thresholds. Neither is frozen.

The correct next measurement is therefore empirical ROC-style separation on
the real corpus, not a guessed probability.

---

# 9. Re-evaluating W3D's four reasons for Architecture A

## Reason 1 - "A eliminates the detector failure class"

PARTLY TRUE, but incomplete.

A eliminates FRAME/FIELD classifier mistakes.

It replaces them with false-candidate activation and weak-seam miss errors.
Those are not hypothetical; section 8 gives an exact indistinguishability
example.

A also does not eliminate threshold flicker.

## Reason 2 - "A is deterministic and stateless"

TRUE.

This is a real advantage in simplicity.

But B2 is also deterministic/stateless when the detector is a per-frame pure
pre-pass, so this is not an exclusive correctness advantage.

## Reason 3 - "A is continuous rather than a hard decision"

REFUTED AS STATED.

The scale changes the activation thresholds continuously, but each edge still
makes a hard pass/fail decision and, once active, receives normal correction
strength.

## Reason 4 - "A is already designed to project standards"

PARTLY TRUE AS ENGINEERING HISTORY, NOT AS WHOLE-FRAME GEOMETRY.

The fixed-point creation-time scaling, immutable threshold sets and no-float
kernel discipline remain excellent patterns.

The geometry itself was designed around separated-field input, now forbidden by
D4-D01. Its strongest union property does not survive whole-frame geometry.

---

# 10. A3 - architecture comparison

| Architecture | Geometry fidelity | Detector dependency | False non-boundary work | Overlap/double-write | Deterministic | Main risk |
|---|---|---|---|---|---|---|
| A literal old field-view union | Approximate for frame-DCT | none | field midpoints + projected duplicates | no same-pixel parity collision | yes | wrong frame-DCT footprint |
| A' faithful actual union | contains all true geometries | none | about 50% wrong hypotheses | YES at macroblock boundaries | yes if order frozen | double filtering/order becomes algorithm |
| B current generic regions | potentially exact | yes | only classification mistakes | avoidable | yes if stateless | region/transition semantics underspecified |
| **B2 W3C topology scheduler** | **potentially exact incl. mixed boundaries** | **yes** | confidence/UNKNOWN controlled | **mutual exclusion by schedule** | **yes** | detector separability |
| **D W3C detector-free fallback** | exact internal frame edge; conservative at MB boundary | none | one uncertain internal candidate in field MB | none | yes | frame/frame MB boundary approximate + false midpoint |

W3C ranking:

    1. B2 if Q14 proves useful separability
    2. D as detector-free fallback/comparator
    3. literal A only as an experimental historical comparator
    4. faithful A' should not be pursued unless someone proposes a compelling
       new composite-kernel theory
    5. motion-classifier Architecture C remains rejected

---

# 11. The architecture both prior discussions were missing: edge topology

The natural unit is not an arbitrary "phase span". It is the MPEG-2 macroblock
topology.

Frame/field DCT changes one thing vertically:

- FRAME has an internal horizontal block edge at `mb_y+8`;
- FIELD does not.

At the next macroblock-row boundary, there is always a block boundary, but its
sample topology depends on the pair of neighbouring macroblocks.

That leads directly to B2's transition table and resolves W3D's earlier "seam"
concern in a more principled way.

For horizontal filtering, each x position is independent of neighbouring x
positions except for the already-defined orientation schedule. Therefore
different 16-pixel macroblock segments can legitimately resolve to different
row-pitch edge modes and then be coalesced into same-mode x spans.

This is much cleaner than assigning a rectangular region one pitch and hoping
the boundary between region types is self-explanatory.

---

# 12. A4 - SIMD consequences

## 12.1 Architecture A literal

Filtering is regular:

- two pitch-2 parity streams;
- no detector pre-pass;
- no geometry branch inside the x-vector loop.

But it performs about twice the horizontal candidate operations and pays for
that regularity by using the wrong frame-DCT footprint.

Easy SIMD is not a correctness argument.

## 12.2 Faithful A'

Poor SIMD/algorithm shape at the macroblock boundaries because pitch-1 and
pitch-2 hypotheses overlap and cannot safely execute independently.

A vector implementation would have to preserve a newly defined hypothesis
order or mutual exclusion. This is much worse than old A.

## 12.3 B2

After classification, horizontal work is geometry-homogeneous:

    pitch-1 span
    pitch-2-even span
    pitch-2-odd span
    no-edge span

The horizontal pixel lanes remain contiguous along x exactly as in the accepted
4C/5C engineering pattern.

Span boundaries occur naturally at 16-pixel macroblock boundaries. Consecutive
same-mode macroblocks are coalesced.

Worst-case alternating macroblock types produce 16-pixel horizontal spans:

- v2 u8 N=16: one full 128-bit storage batch;
- v3 u8 N=32: one half-width V16 path;
- v2 u16 N=8: two full batches;
- v3 u16 N=16: one full batch.

So even pathological phase alternation does not reduce the work to scalar
lanes. The accepted exact-span tail discipline already proves the engineering
pattern needed for such bounded spans, although D4 must build its own body and
proof.

## 12.4 Important correction to the earlier W3C SIMD description

A frame/field DCT choice does NOT require every vertical-edge vector pack to
contain one field parity.

The vertical luma block boundary remains at x=8*k for both frame and field DCT.
Each vertical-edge lane filters across columns within its own row. Adjacent row
lanes do not use one another's pixels.

Therefore the D4 detector/scheduler can leave vertical-edge processing uniform
across rows. The pitch-1/pitch-2 distinction is load-bearing for HORIZONTAL
edges.

This reduces B2's SIMD and schedule complexity materially.

---

# 13. Architecture D - detector-free whole-frame fallback in more detail

Architecture D is not proposed as better than a successful B2. It is the
strongest detector-free design W3C sees after whole-frame input reopened the
geometry.

For Case (a) luma:

## Vertical orientation

    x = 8*k
    process every eligible row

No frame/field decision.

## Horizontal internal macroblock edge

    e = 16*m + 8
    pitch 1

This is a real edge only for frame-DCT macroblocks.

If no detector is available, apply an A-style stricter activation policy here,
or conservatively skip it. This is the one genuine "midpoint uncertainty" in
whole-frame topology.

## Horizontal macroblock-row boundary

    e = 16*m

Use two pitch-2 parity edges:

    e
    e+1

This is exact for field/field and the natural conservative/mixed form for a
mixed boundary. It approximates a frame/frame boundary.

Why D is better than literal old A:

- one uncertain internal candidate instead of two parity midpoint candidates;
- actual pitch-1 frame internal footprint;
- no pitch-1/pitch-2 overlap;
- fewer horizontal filter operations;
- direct correspondence to macroblock topology.

The ground-truth experiment should include D because it is the honest fallback
if B2 does not earn its detector.

---

# 14. UNKNOWN / no-DCT handling needs more precision than the previous B text

The old MPEG-2 knowledge record correctly notes that `dct_type` is signalled
only for relevant coded macroblocks. Skipped or motion-only macroblocks may have
no DCT organisation bit because there is no coded residual block to organise.

The Q14 truth extractor must therefore not force every macroblock into FRAME or
FIELD.

Use at least:

    FRAME
    FIELD
    NO_DCT / NOT_SIGNALED
    unavailable / corrupt

For detector scoring, NO_DCT is a valuable class in its own right.

For B2 scheduling, UNKNOWN policy should be edge-specific:

- uncertain internal `mb_y+8`: existence of a real transform edge is uncertain;
  "no filter" is a defensible v1 default;
- macroblock-row boundary: existence of a block boundary is not the same
  uncertainty; what is uncertain is pitch/topology. A conservative pitch-2
  treatment may be better than dropping it completely.

This should be measured rather than carrying the previous blanket "filter
nothing in UNKNOWN regions" rule unchanged.

---

# 15. A5 - additional load-bearing README / knowledge content W3D should
consolidate

W3D said it had read only README 3.11/3.13 and the old table. The following
other material bears directly on the re-decision.

## A5.1 README 4.4 - analyser discipline

README lines 976-1017 already states:

- an analyser that affects output is part of the canonical algorithm;
- it gets the same scalar/vector correctness obligations;
- analysis occurs as an unmodified-source pre-pass;
- per-call scratch is used, never per-instance mutable state under fmParallel;
- shared kernel / separate driver is explicitly acceptable.

This is almost exactly the engineering structure B2 needs and should be
retained.

## A5.2 README section 5 - schedule is output-defining

README 5.1 states that earlier writes can change later threshold decisions and
therefore schedule is part of the algorithm.

This is especially important to A': overlapping pitch-1/pitch-2 hypotheses
cannot be waved away as "extra candidates". Their order would define output.

The old Schedule-A/Schedule-B quality gate still exists for the later Deblock4
core. Its corpus text must be reconciled from separated-field to whole-frame
input before it is used.

## A5.3 README 8.8 - proper chroma remains a separate open quality gate

The production chroma formula is settled-by-design but explicitly
unvalidated-by-measurement.

Do not accidentally treat the current architecture re-decision as closing
proper-chroma quality.

## A5.4 4:2:2 / 4:4:4 Case-(a) chroma

The newly verified H.262 fact says 4:2:2 and 4:4:4 chroma follow luma field-DCT
organisation.

Therefore a B2 geometry map has reuse value beyond luma: for those formats the
resolved macroblock organisation also determines chroma horizontal geometry in
chroma-plane coordinates.

The 4:2:0 fixed-chroma simplification is not universal.

## A5.5 README A.11 - grid origin / crop ordering

README lines 3716-3722 says initial grid origin is zero and cropping before
Deblock4 can shift coded boundaries.

B2's macroblock topology makes that obligation even more explicit. The initial
release should continue to document "Deblock before spatial crop when coded
alignment matters", unless an explicit origin parameter is scoped.

## A5.6 Audit properties are stale for mixed geometry

README 13.5 and current source expose scalar properties such as:

    Deblock4LumaStepY
    Deblock4MidpointScale

A mixed B2 frame does not have one truthful `LumaStepY`.

Future audit properties should instead expose at minimum:

- declared source mode;
- geometry-policy/detector version;
- frame/field/unknown macroblock counts (or equivalent summary);
- number of pitch-1, pitch-2 and skipped horizontal spans;
- fallback/unknown counts.

Exact public names belong to a later parameter-surface scope.

## A5.7 Current source has stale old-A plumbing

The supplied current source contains old `mpeg2_field_separated`, midpoint and
step parsing, diagnostic text and frame properties.

The Deblock4 pixel path is still pass-through, so this is precisely the cheap
moment to replace the plumbing cleanly.

Do not preserve it merely because Stage 1C already proved its parser mechanics.

## A5.8 The old knowledge document contains a stale implementation statement

`Deblock4_MPEG2_Grid_Field_DCT_Knowledge_v1_2.md` says the midpoint mechanism is
"proportional strength driven by edge magnitude" and branchless.

That is inconsistent with the later README 3.13 mechanism, which scales only
alpha/beta once at creation and leaves correction strength normal.

The re-decision brief correctly uses the README mechanism. The stale
"proportional strength" wording should not be resurrected.

## A5.9 Real target-device measurements should not be lost in consolidation

The superseded MPEG-2 grid knowledge file records useful measured corpus facts
that are not obvious in the new prevailing v1.00 document:

- 317 sampled OTA pictures were frame pictures with
  `frame_pred_frame_dct=0`;
- LG XP/SP/LP/EP target modes were also measured with
  `frame_pred_frame_dct=0`;
- LG MLS was measured with `frame_pred_frame_dct=1`.

`frame_pred_frame_dct=0` means per-macroblock adaptation is permitted, not that
every picture definitely contains both types. Nevertheless it shows that the
hard adaptive regime is the real target operating regime and the uniform-frame
case is not sufficient.

The old document also records the cheap MediaInfo regime check. Those measured
facts should either be absorbed into the prevailing knowledge document or
explicitly preserved as a measurement appendix.

---

# 16. Revised D4-Q14 experiment - recommended gate before kernel scope

No filtering code is needed for the first discriminator.

# 16.1 Ground truth

Instrument FFmpeg or another decoder-side path to record, per macroblock:

    picture_structure
    frame_pred_frame_dct
    dct_type when meaningful
    coded/no-DCT status
    macroblock x/y

This is validation tooling only, not a runtime plugin dependency.

# 16.2 Pixel features

On the unmodified decoded frame calculate, per macroblock / boundary:

For B2:

    frame-hypothesis energy
    field-hypothesis energy
    score margin
    predicted FRAME/FIELD/UNKNOWN

For A/D:

    local boundary discontinuity
    side activity
    candidate class: TRUE / FALSE
    scaled-threshold pass/fail over a sweep

# 16.3 Required reports

B2:

    confusion matrix
    false-confident rate
    UNKNOWN rate
    results by QP/content/device
    results at frame/frame, field/field and mixed boundaries
    results for NO_DCT macroblocks separately

A/D:

    true-edge acceptance versus false-candidate acceptance
    ROC-style curves over threshold scale
    weak-seam miss rate
    false internal-edge activation rate
    distributions for texture, flat areas, noise, text and diagonals

# 16.4 Architecture decision rule

Choose B2 only if:

- confident classifications are sufficiently reliable on held-out real target
  material;
- UNKNOWN remains bounded;
- mixed-boundary cases have enough evidence to define the transition table.

Choose D if B2 cannot achieve that reliability and D's measured false internal
activation / frame-frame approximation cost is better than B2's classification
cost.

Do NOT fall back automatically to literal A merely because B2 fails.

---

# 17. Final W3C recommendation

The resurfaced README architecture is valuable, but its most elegant property
belongs to the coordinate system for which it was designed.

Moving Deblock4 to whole-frame input changes the problem fundamentally:

    separated-field world:
        frame-DCT and field-DCT can be represented by one same-field footprint
        at different candidate frequencies

    whole-frame world:
        frame-DCT and field-DCT use DIFFERENT sample adjacency / footprints

That is why old A does not survive as the best primary architecture.

W3C therefore recommends:

1. **REJECT literal Architecture A as the primary D4 architecture.**
2. **ADOPT Architecture B2 - macroblock classification plus explicit edge
   topology/transition scheduling - as the primary candidate.**
3. **KEEP Architecture D as the detector-free fallback and mandatory
   comparator.**
4. **RETAIN A's good engineering ideas** - immutable creation-time threshold
   sets, fixed-point scaling, no hidden state - and optionally its scaled
   activation idea for the one genuinely uncertain internal `mb_y+8` edge.
5. **EXPAND D4-Q14** so one ground-truth experiment compares B2 classification
   against A/D false-candidate selectivity before any kernel mathematics is
   frozen.
6. **DO NOT write the Deblock4 kernel yet.** Resolve this architecture and the
   experiment first.
7. After W3X/W3D ratify the result, reconcile the stale README/API/frame-property
   surface before the first D4 kernel scope.

The most important new insight is that whole-frame access does not merely force
us to repair old A. It gives us a BETTER abstraction than either original
proposal: macroblock topology. That makes the mixed boundary explicit, limits
detection to the orientation where DCT organisation actually changes the edge,
and preserves geometry-homogeneous SIMD work without pretending pitch-1 and
pitch-2 filters are the same edge.
