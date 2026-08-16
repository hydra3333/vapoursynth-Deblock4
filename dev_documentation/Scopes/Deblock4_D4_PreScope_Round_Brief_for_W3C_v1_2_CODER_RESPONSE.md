# Deblock4 - D4 Pre-Scope - W3C Verification and Independent Design Review

**Deliverable:** W3C-D4-VERIFY-1
**Version:** 1.0
**Date:** 2026-08-16
**From:** W3C
**Route:** W3C -> W3X -> W3D
**Basis:** `Deblock4_D4_PreScope_Round_Brief_for_W3C_v1_2.md`
**Nature:** INVESTIGATION AND ADVICE ONLY. No repository file is created,
modified or deleted by this investigation.
**Encoding:** US-ASCII; CRLF.

---

# DECISIONS/QUESTIONS FOR W3X

## Q1 - preserve the ratified "Classic never-a-basis" rule?

**Current rule:** the ratified 4C/5C position is explicit: nothing in
`classic_vector_backend.zig` is a design or acceptance basis for Deblock4.
Deblock4 is to derive its own algorithm, dependency analysis and oracle; only
engineering disciplines/patterns carry forward, never code inheritance.

**Pre-scope tension:** W3D's current D4 recommendation says the Deblock4 KERNEL
can use "Classic's existing per-edge activity gating, reused", with part of the
rationale being that the difficult filter mathematics have already been proved
byte-exact in Classic.

**W3C recommendation:** PRESERVE the current rule. Keep the useful architectural
idea - separate geometry scheduling from local edge filtering - but specify and
prove the Deblock4 predicate/kernel independently against the future Deblock4
oracle. Classic may be cited as an observed precedent showing that a local
boundary/activity predicate is practical; Classic's code and its Classic proof
must not become D4's acceptance basis.

If W3X actually wants literal Classic-kernel/code/proof reuse, the existing
never-a-basis ruling must be amended explicitly before a D4 implementation
scope. W3C will not reinterpret "reuse" silently.

## Q2 - temporal hysteresis in the first D4 geometry selector?

**W3C recommendation:** DO NOT make hidden previous-frame hysteresis part of the
first D4 scheduler.

VapourSynth API4 `fmParallel` permits multiple threads to call one filter
instance's getFrame concurrently. Even `fmUnordered` serialises calls but does
not guarantee frame-number order. Therefore a selector whose output for frame N
depends on whichever frame happened to be processed previously risks
request-history-dependent output unless temporal dependencies are explicitly
modelled.

For the first kernel/scheduler, use a deterministic stateless per-frame detector
with an explicit confidence/unknown state and, if useful, spatial
regularisation/deadband. Temporal hysteresis can be a later policy only if its
frame dependencies, cache/lifetime and random-access semantics are explicitly
designed and proved.

## Q3 - fallback when Case-(a) phase confidence is inadequate?

Do not freeze the fallback before D4-Q14 measurement. W3C recommends that the
detector contract have an explicit UNKNOWN/LOW-CONFIDENCE result so the
fallback is a policy decision rather than an accidental threshold outcome.

Candidate policies to measure are:

1. declared-mode uniform phase;
2. skip phase-uncertain candidate edges;
3. experimental dual-phase candidate union, relying on the independent local
   artifact predicate to reject false edges.

W3C does **not** recommend (3) for production without evidence; it is useful as
an experiment because it tests whether a phase classifier is necessary at all.

---

# PART A - VERIFICATION

# V1. FFmpeg libpostproc chroma behaviour under the alleged interlaced flag

**Source examined:** FFmpeg 7.1 `libpostproc/postprocess.c` /
`postprocess.h`, cross-checked against current FFmpeg public API/filter wiring.

## V1.1 Interlaced/field mode mechanism

**Classification: REFUTED.**

The load-bearing GAIS claim assumes a libpostproc deblocking picture flag that
switches vertical deblocking into field mode by doubling the line stride (or an
equivalent explicit field loop).

I could not find such a deblocking picture-mode mechanism in the FFmpeg 7.1
libpostproc API or implementation.

`pp_postprocess()` receives a `pict_type` integer, but the public libpostproc
picture flag defined for it is `PP_PICT_TYPE_QP2`, documented as MPEG-2-style
QScale. In `pp_postprocess()` that bit controls QP-table conversion. It is not
an interlace geometry flag.

The public postprocess entry receives the caller-supplied per-plane strides and
calls `postProcess()` with them. There is no interlaced deblocking branch that
doubles the plane stride.

The current FFmpeg `vf_pp` integration likewise supplies the ordinary frame
plane line sizes. FFmpeg frames have a distinct interlaced-frame flag, but the
postproc filter does not turn that into a libpostproc deblocking geometry flag.

Therefore the claimed field-mode mechanism is not present in the examined
FFmpeg libpostproc path.

**Primary references:**
- FFmpeg 7.1, `libpostproc/postprocess.c`, `pp_postprocess()`.
- FFmpeg 7.1/current, `libpostproc/postprocess.h`,
  `PP_PICT_TYPE_QP2`.
- Current FFmpeg `libavfilter/vf_pp.c`, call to `pp_postprocess()`.

## V1.2 Per-plane chroma effect

**Classification: REFUTED AS STATED.**

Because the alleged interlaced deblocking mode does not exist, there is no
field-stride mechanism to apply to either luma or chroma.

When chroma processing is enabled, `pp_postprocess()` calls the same
`postProcess()` engine separately for:

- Y with `srcStride[0]` / `dstStride[0]`;
- U with `srcStride[1]` / `dstStride[1]`;
- V with `srcStride[2]` / `dstStride[2]`;

after reducing width/height according to the configured chroma subsampling.

That is ordinary per-plane processing, not "double all plane strides in
interlaced mode".

This matters directly to the project: libpostproc cannot be used as evidence
that a single interlaced flag should field-split MPEG-2 4:2:0 chroma in Case
(a). The cited implementation precedent does not establish that proposition.

## V1.3 QP input and fallback

**Classification: VERIFIED WITH CORRECTION.**

libpostproc's external QP table is macroblock-oriented. `pp_postprocess()`
computes macroblock dimensions from `(width+15)>>4` and `(height+15)>>4`.
When `QP_store` is absent, or FORCE_QUANT is selected, it uses an internal
forced-QP table; absent an explicit forced quantizer, the fallback value is 1.

`PP_PICT_TYPE_QP2` controls conversion of MPEG-2-style QScale values before use.

The deblock traversal itself is based on the 8-pixel block grid, but that does
**not** mean the caller provides an independently signalled QP for every 8x8
edge. The incoming QP metadata is one value per coded macroblock and is used by
the filtering machinery over the finer deblock schedule.

Context therefore is:

    external strength metadata: macroblock QP table (normally 16x16 MB raster)
    filtering geometry:         8-pixel block-boundary schedule
    no QP table:                internal fallback / forced quant path

## V1.4 DGDecode internal postprocessor

**Classification: COULD-NOT-DETERMINE.**

I did not obtain a sufficiently authoritative, reasonably accessible DGDecode
source tree for its internal postprocessor during this round. Per the brief, I
stop here rather than infer equivalence from historical similarity or binaries.

No claim is made that DGDecode has, or does not have, the same chroma behaviour.

---

# V2. H.264 / ISO-IEC 14496-10 clause 8.7 MBAFF mixed-boundary rule

**Published text used:** ITU-T Recommendation H.264 (06/2011), freely
available from ITU-T. Clause numbering below is from that edition.

## V2.1 Mixed frame/field top boundary

**Classification: VERIFIED IN SUBSTANCE, WITH WORDING CORRECTION.**

For an MBAFF mixed top macroblock-pair boundary, H.264 invokes the filtering
process twice in field mode, once for each field-positioned set of samples.
The normative mechanism uses `fieldModeInFrameFilteringFlag = 1`; horizontal
sample addressing derives a vertical spacing factor

    dy = 1 + fieldModeInFrameFilteringFlag

so field-mode filtering uses alternate frame rows.

Thus the GAIS description - "treat the frame-coded neighbour as two temporary
field halves and filter at stride 2" - is a reasonable implementation intuition,
but it is not the normative wording. The standard specifies two field-mode
filtering invocations and field-spaced sample addressing.

**Relevant H.264 homes:** 8.7.1 (edge filtering invocation / MBAFF special
case) and the sample derivation in the filtering process used by 8.7.

## V2.2 Does chroma follow the macroblock-pair field/frame geometry?

**Classification: VERIFIED.**

The MBAFF mixed-boundary field-mode treatment is also invoked for chroma.
There is no MPEG-2-Case-(a)-style exception in which 4:2:0 chroma remains on an
independent frame-organised DCT grid while luma switches to field-DCT geometry.

An important chroma special case is different: chroma boundary strength is
derived from the corresponding luma edge in the same field. Chroma then uses
its own threshold/QP derivation/filtering rules.

Therefore the H.264 transition concept is useful as a precedent for this
Deblock4 design question: adjacent regions can legitimately have different
frame/field geometry and a defined mixed transition can be specified. It is
not, however, a direct MPEG-2 geometry mapping.

## V2.3 Claimed 8.7.2.2 title and "2x2 or 4x4 chroma block boundaries"

**Classification: REFUTED.**

In the 06/2011 H.264 text, 8.7.2.2 is:

    Derivation process for the thresholds for each block edge

It is **not** "Derivation process for the chroma content dependent boundary
filtering strength".

I found no 2x2 chroma **deblocking-edge** concept in clause 8.7. The deblocking
process maps chroma edges according to chroma subsampling and the standard's
block-edge positions; "2x2" terminology elsewhere in H.264 (for example in
chroma transform/DC structure) must not be imported into the deblocking-edge
description.

GAIS's clause title and 2x2-deblocking statement should both be removed from
the D4 knowledge basis.

---

# V3. Patent citations - both GAIS rounds

Patent metadata/substance was checked against public patent records (principally
Google Patents, which links the USPTO record). The classifications for the new
three numbers use the taxonomy requested by the brief.

## V3.1 Replacement patent US 6,167,157

**GAIS:** Sony/Ohta; block-boundary smoothing with an interlace-aware vertical
mode switch.

**Actual public record:**
- US 6,167,157
- title: `Method of reducing quantization noise generated during a decoding
  process of image data and device for decoding image data`
- inventor/assignor: Takayuki Sugahara
- assignee: Victor Company of Japan, Ltd. (JVC)
- priority family: 1994
- US filing: 1998
- grant: 2000

**Classification: PARTIALLY-ACCURATE.**

The number is real and relevant to decoded-image post-filtering / quantization
noise reduction, but the Sony/Ohta attribution is wrong. I did not find primary
support sufficient to preserve GAIS's specific claimed "Sony interlace-aware
vertical mode switch" characterization. It must not be cited under that
description.

## V3.1 Replacement patent US 7,031,552

**GAIS:** LSI Logic/Winger; adaptive post-filtering of coded interlaced video
with frame/field boundary handling.

**Actual public record:**
- US 7,031,552
- title: `Adaptive post-filtering for reducing noise in highly compressed
  image/video coding`
- inventor: Changick Kim
- assignee: Seiko Epson Corporation
- priority/filing family: 2002
- grant: 2006

The method is an adaptive reconstructed-image/video post-filter based on local
pixel/block characteristics; the public record does not support the claimed
LSI/Winger attribution or the claimed frame/field-boundary method.

**Classification: PARTIALLY-ACCURATE.**

The number is a real and relevant post-filter patent. The attribution and the
load-bearing interlace characterization are wrong.

## V3.1 Replacement patent US 6,983,079

**GAIS:** Samsung/Kim; blocking-artifact reduction with separate handling for
field-structured blocks.

**Actual public record:**
- US 6,983,079
- title: `Reducing blocking and ringing artifacts in low-bit-rate coding`
- inventor: Changick Kim
- assignee: Seiko Epson Corporation
- priority: 2001
- filing: 2001
- grant: 2006

The disclosed method predicts low-frequency AC information from block DC
information, classifies block activity, and adaptively applies filtering to a
reconstructed frame. The public record supports general blocking/ringing
artifact reduction, not the claimed Samsung attribution or a field-structured
special case.

**Classification: PARTIALLY-ACCURATE.**

## V3.2 Round-one US 6,633,612

W3D's calibration is partly right and should be made more precise.

**Actual record:**
- US 6,633,612
- title: `Method and apparatus for detecting motion between odd and even video
  fields`
- inventor: Steve Selby
- inter-field motion / deinterlacing-related subject matter

It is not evidence for an interlaced deblocking algorithm. Faroudja/DCDi is
relevant historical context to this technology family, but describing this
patent simply as a "Faroudja DCDi deblocking patent" would also be misleading.

**Result:** W3D's substantive conclusion - "wrong patent for deblocking" - is
VERIFIED; its shorthand attribution should be tightened.

## V3.2 Round-one US 7,139,437

W3D's belief that this was a Microsoft patent is itself wrong.

**Actual record:**
- US 7,139,437
- title: `Method and system for removing artifacts in compressed images`
- inventors: Paul W. Jones, Keith A. Jacoby
- assignee: Eastman Kodak Company
- filing: 2002
- grant: 2006

Its subject is compressed-image artifact removal using image segmentation /
adaptive filtering. It is not the claimed Microsoft interlaced-video deblocking
method.

**Result:** the GAIS round-one citation is REFUTED. W3D's "different substance"
conclusion is right; the "Microsoft" attribution is not.

## V3.3 Bounded replacement-patent search

Not formally triggered.

The three replacement numbers are classified PARTIALLY-ACCURATE rather than
REFUTED because each is a real post-filter / artifact-reduction patent. Their
claimed assignees and interlace-specific descriptions are what fail.

No substitute patent is promoted into the design basis in this round.

---

# V3b. Two paper citations from the GAIS follow-up

## V3b.1 Kim, Kim, Cho (1999), claimed interlaced-coded-video paper

**Claimed citation:**
`A post-processing algorithm for reducing blocking artifacts in interlaced
coded video`, IEEE Transactions on Consumer Electronics, 45(3), 1999.

**Classification: REFUTED AS CITED (metadata level).**

An exact-title search found no IEEE record. I also checked the indexed table of
contents for IEEE Transactions on Consumer Electronics, volume 45, number 3
(1999); the claimed article is not present.

I therefore find no evidence that this paper exists with the claimed title,
authors, venue, volume and issue.

Because the negative result rests on bibliographic metadata rather than a
full-text article, I do not infer that no related interlaced post-processing
paper ever existed. I only reject this specific citation.

## V3b.2 Chroma statement for the claimed 1999 paper

Not applicable. Since the cited paper could not be established as a real
article, there is no verified abstract from which to infer chroma handling.

## V3b.1 Han, Kim (2002), claimed MPEG-2 / IEEE TCSVT paper

**Classification: REFUTED AS CITED; a likely real source of the distortion was
identified.**

The real 2002 paper is:

- Changick Kim (single author)
- `Adaptive post-filtering for reducing blocking and ringing artifacts in
  low bit-rate video coding`
- Signal Processing: Image Communication
- volume 17, issue 7
- August 2002
- pages 525-535
- DOI 10.1016/S0923-5965(02)00026-7

It is not Han/Kim, not IEEE Transactions on Circuits and Systems for Video
Technology, and not an MPEG-2 experiment. Its published abstract states that
TMN8/H.263+ was used.

One useful independent observation from the real paper is directly relevant to
D4-Q11: its introduction notes that in inter-frame video, block artifacts from
a previous frame may be propagated by prediction to arbitrary positions within
a current block. That supports W3D's decision to log inherited shifted
blockiness as a real, broader problem rather than attempt to solve it in the
first interlace-aware kernel.

---

# V4. H.262 G1 closure - chroma organisation and dct_type

**Published text used:** ITU-T Recommendation H.262 (02/2000), freely available
from ITU-T; this edition consolidates the 1995 text and amendments through
February 2000.

## V4.1 Chroma organisation

**Classification: VERIFIED. G1 can close.**

H.262 6.1.3 distinguishes frame and field organisation for DCT coding.

The decisive 4:2:0 sentence is:

> "However, in the 4:2:0 format the chrominance blocks shall always be
> organised in frame structure for the purposes of DCT coding."

This is the normative asymmetry behind the project's Case (a).

For 4:2:2 and 4:4:4, the chrominance blocks follow the same frame/field DCT
organisation as luminance. For field pictures, blocks are naturally formed
from successive lines of the field.

Therefore the settled three-geometry project model is supported:

- progressive/frame DCT: luma/chroma frame-organised;
- frame picture + field DCT: luma field-organised while 4:2:0 chroma remains
  frame-organised;
- field picture: the field picture's luma/chroma samples are field-organised.

## V4.2 Compare the two prior GAIS quotations verbatim

**Classification: COULD-NOT-DETERMINE for quote fidelity.**

The current W3C-accessible package contains the pre-scope brief's summary of
the GAIS claims, but not the literal two earlier GAIS quotation strings required
to decide:

- VERBATIM-ACCURATE;
- SUBSTANTIVELY-ACCURATE-BUT-PARAPHRASED;
- WRONG.

I searched the accessible conversation/library material for the distinctive
GAIS wording/patent numbers and could not recover those two source quotations
as separate records.

I therefore will not manufacture quote text from memory.

The **underlying technical proposition** attributed to those quotations is
VERIFIED by H.262 6.1.3 as stated in V4.1. If W3X supplies the two literal GAIS
quotes later, their quotation fidelity can be classified mechanically.

## V4.3 `dct_type` signalling and semantics

**Classification: VERIFIED.**

The syntax is macroblock-level.

In a frame picture, `dct_type` is present when `frame_pred_frame_dct == 0` and
the macroblock is intra-coded or has a coded block pattern. The semantic
subclause defines `dct_type == 0` as frame DCT organisation and
`dct_type == 1` as field DCT organisation.

When the syntax element is absent, its inferred/default value is determined by
the picture/macroblock conditions; in particular a frame picture with
`frame_pred_frame_dct == 1` uses frame DCT organisation.

Therefore the project statement "real Case-(a) material can mix DCT geometry
per macroblock" is correct. A single uniform frame-level grid for a frame
picture is necessarily an approximation when both macroblock dct_type values
occur.

---

# PART B - INDEPENDENT DESIGN REVIEW

# B2.1 Concur or dissent with W3D's recommendation

## W3C disposition

**CONCUR with the scheduler/kernel separation.**

**DISSENT with two parts of the current wording:**

1. the Deblock4 kernel must not inherit Classic's code/proof acceptance basis;
2. temporal hysteresis should not be a hidden stateful mechanism in the first
   scheduler.

The architecture should be stated as four distinct layers:

    A. GEOMETRY POLICY
       declared source mode establishes which geometries are legal

    B. GEOMETRY DETECTOR
       for uncertain Case-(a) luma only:
       measure candidate phases in the current frame/region
       -> {phase, confidence, unknown}

    C. SPAN/JOB COMPILER
       convert the geometry map into homogeneous work:
       {plane, orientation, phase, row_pitch, parity, region bounds}

    D. DEBLOCK4-OWNED EDGE PREDICATE + FILTER KERNEL
       for each scheduled candidate edge:
       independently decide whether the local discontinuity looks like a
       compression artifact, then apply the independently specified D4
       filtering mathematics

This separation is useful because geometry uncertainty and filtering
mathematics are different problems and should fail independently.

### Fixed geometry cases

- Progressive:
  - luma/chroma: frame grid, row pitch 1.
- Case (a), frame picture with possible field DCT:
  - luma: detector/scheduler may choose the field-DCT phase locally;
  - 4:2:0 chroma: forced frame-organised normative grid; no detector.
- Case (b), field picture:
  - luma/chroma: field grid, row pitch 2.

### Why I prefer confidence/UNKNOWN over a forced binary phase

If the two phase-energy scores are close, forcing a binary label converts
"detector does not know" into an apparently precise geometry decision.

A first-class confidence margin permits:

- conservative fallback;
- measurement of ambiguity;
- later threshold calibration;
- deterministic spatial regularisation;
- easy substitution of decoder metadata/sidecar ground truth in the future.

That makes the detector replaceable without changing the kernel ABI.

### Temporal hysteresis

W3D is right that thresholded decisions can flicker over time. I do not accept
"therefore add previous-frame hysteresis" as a safe first implementation.

VapourSynth API4 documents that `fmParallel` can execute several frames of one
filter instance concurrently. Even `fmUnordered` can call frame activations in
non-frame-number order. A mutable "last phase" state can therefore make frame N
depend on request history unless temporal dependencies are made explicit.

For first D4:

    same input frame + same parameters -> same geometry map

independent of request order.

If temporal smoothing is later shown necessary, design it as an explicit
temporal dependency/prepass rather than an incidental mutable member.

---

# B2.2 Test W3D assessments (i)-(iv)

## (i) Flicker

**W3C: PARTLY CONCUR.**

W3D correctly identifies the logical flaw in using flicker as an argument
against one thresholded architecture while another thresholded architecture
also makes unstable decisions near its threshold.

But "flicker argues for hysteresis" is too narrow. Flicker argues for a
**stability policy**. Options include:

- confidence deadband / UNKNOWN state;
- spatial regularisation;
- minimum region/run size;
- temporally explicit hysteresis.

For a VapourSynth `fmParallel` design, the first three are much easier to keep
deterministic and request-order independent.

## (ii) Seams at neighbouring macroblocks of different geometry

**W3C: CONCUR with the existence/cause; add a missing obligation.**

The discontinuity is real material geometry, not automatically a detector
error. H.264 MBAFF is useful evidence that adjacent frame/field-coded regions
are normal enough to require a defined mixed-boundary rule.

However, "the blast radius is small" is not enough for implementation.
Deblock4 still needs an explicit **region-boundary ownership rule**:

- Which region owns an edge exactly at a phase-transition boundary?
- Can two scheduled jobs touch the same edge?
- Can one job's write footprint modify samples that the neighbouring job later
  reads?
- What is the canonical order if footprints overlap?

These are scalar schedule/dependency questions first, SIMD questions second.

The future scalar D4 oracle must freeze those answers before vectorisation.

## (iii) shifted inherited blockiness

**W3C: CONCUR; defer from first kernel.**

W3D is right that inter-frame prediction can move inherited blocking
discontinuities away from the nominal current-frame DCT grid.

The real Changick Kim 2002 paper independently notes this phenomenon: previous
frame blocking artifacts can propagate to arbitrary positions in a current
frame.

Solving arbitrary shifted inherited blockiness is substantially broader than
the MPEG-2 field-DCT geometry problem. Keep D4-Q11 logged and outside the first
D4 kernel.

I do **not** independently endorse the stronger statement that "every known
implementation" filters only the nominal grid; that universal claim was not
needed for this decision and was not verified in this round.

## (iv) GAIS Architecture-2 B_metric versus Classic's kernel

**W3C: PARTIALLY VERIFIED; W3D overstates reuse.**

Current `src/classic_scalar_kernel.zig` is clear.

At lines 48-50, Classic activates an already-scheduled edge only if:

    abs(p0-q0) < alpha
    abs(p1-p0) < beta
    abs(q0-q1) < beta

At lines 61-67 it then measures side activity:

    ap = abs(p2-p0)
    aq = abs(q2-q0)

and uses the beta tests to determine side filtering/clipping.

So Classic genuinely contains a **local boundary-step plus side-activity
predicate**. That is structurally in the same family as "measure discontinuity
at the boundary relative to activity around it, then filter only plausible
artifacts."

But Classic does **not**:

- compare two competing grid phases;
- rank a region's phase energy;
- normalise a region-wide boundary metric;
- determine where candidate edges should be.

It decides WHETHER to filter an edge whose location the schedule has already
chosen.

Therefore:

    phase detector / B_metric-like score -> geometry question
    Classic edge activation             -> local artifact question

They are complementary, not equivalent.

More importantly, the ratified never-a-basis rule means Classic's code and
byte-exact proof cannot simply be adopted as D4's oracle. The future D4
predicate may independently converge on similar local measurements, but its
formula, thresholds, outputs and proof must be frozen on D4's own evidence.

---

# B2.3 SIMD implications of the three geometries

## General conclusion

Field-domain processing does **not** fundamentally obstruct SIMD.

The important constraint is:

    keep each SIMD invocation geometry-homogeneous

Do not encode phase/pitch decisions per lane.

A scheduler can branch at region/span boundaries and still hand the vector
kernel long contiguous x-runs with one geometry.

## Current Classic body: what it proves and what it does not

Current `classic_vector_backend.zig` demonstrates two useful implementation
facts:

1. horizontal vectors load contiguous lanes along x;
2. vertical processing explicitly lane-packs four rows; it is not dependent on
   a hardware gather primitive.

But the frozen Classic body itself hardcodes the Classic schedule:

- `edge_step` traversal in `processPlane()` (lines 152-174);
- horizontal footprint at `edge_y-3,-2,-1,+0,+1,+2`
  (lines 218-246);
- vertical four-row pack at `row_start + lane`
  (lines 297-327).

It is therefore a pitch-1/fixed-schedule implementation, not a ready-made
field-DCT engine.

That is not a problem, because D4 must have its own vector body anyway under the
ratified never-a-basis rule.

## Geometry 1 - progressive

Vector geometry is simplest:

- vertical sample pitch in frame memory: 1 row;
- horizontal edge footprints use adjacent frame rows;
- vectorisation along x remains contiguous;
- vertical four-row pack uses consecutive rows;
- fixed 8-row phase.

No special per-region branch is required.

## Geometry 2 - Case (a), frame picture + field-DCT luma

For a luma region classified as field-DCT:

- the six vertical taps around a horizontal edge must stay in the same field:
  row offsets are conceptually `-6,-4,-2,0,+2,+4` frame rows for a six-sample
  p2..q2 footprint instead of `-3,-2,-1,0,+1,+2`;
- contiguous x loads are unchanged;
- a four-row along-edge vertical pack must select four same-field frame rows,
  conceptually `row_start + 2*lane`;
- top/bottom parity/phase must be represented by the job geometry;
- adjacent same-geometry regions should be coalesced before entering the
  vector kernel.

For MPEG-2 4:2:0 chroma in the same picture, none of that field pitch applies:
the normative DCT organisation remains frame-structured, so the chroma job uses
pitch 1 and the ordinary frame grid.

That luma/chroma split is why a single whole-plane "interlaced" flag is the
wrong abstraction.

## Geometry 3 - field picture

Both luma and chroma are field-domain jobs.

If the plugin receives an interleaved whole frame, the scheduler should expose
separate parity-homogeneous work with row pitch 2. Along-x vectors remain
contiguous. The vertical row pack gathers its four logical rows explicitly from
same-field frame rows.

Again, no per-lane phase branch is required.

## Does a per-region phase decision break SIMD?

Not if the decision is outside the inner lane loop.

Recommended pipeline:

    geometry map
        -> coalesce runs/rectangles with identical geometry
        -> emit span/job descriptors
        -> vector kernel loops over homogeneous span

Bad shape:

    for each SIMD lane:
        if lane says field phase A ...
        else if lane says field phase B ...

Good shape:

    job says pitch=2, parity=1, phase=P
    vector body runs all lanes under those constants

The latter preserves contiguous loads and simple masks/tails.

---

# B2.4 Architecture W3D and GAIS have both missed

## Stateless confidence-bearing geometry map + span compiler

This is W3C's preferred first architecture.

### Detector output

For each luma classification region in uncertain Case (a), compute both
candidate phase scores and emit:

    phase:       frame-like candidate / field-like phase A / phase B as defined
                 by the D4 geometry model
    confidence:  score margin or another monotonic separability measure
    state:       KNOWN / UNKNOWN

The exact region granularity is a D4-Q14 empirical question, not frozen here.

### Spatial stabilisation

Before scheduling, optionally apply deterministic, same-frame rules:

- minimum confidence;
- minimum region/run size;
- neighbour agreement;
- deadband;
- deterministic tie rule.

No previous-frame mutable state is required.

### Span compiler

Convert the resulting map into the longest practical homogeneous jobs carrying
explicit geometry:

    plane
    orientation
    edge phase
    row pitch
    field parity
    region/span bounds

This becomes the only geometry contract seen by the kernel.

### Benefits

1. Detector can later be replaced by decoder metadata without kernel changes.
2. SIMD sees uniform geometry, not per-lane branches.
3. UNKNOWN is measurable rather than hidden.
4. Scalar schedule can be proved independently of pixel math.
5. Random VapourSynth request order does not change the phase map.
6. Mixed-region boundary ownership can be tested explicitly.
7. The architecture permits a cheap diagnostic-only D4-Q14 implementation
   before any filtering code exists.

### Experimental "dual-phase union" variant

For research only, one can schedule both candidate phase sets in low-confidence
regions and let the future local D4 predicate reject implausible edges.

If this performs well without false smoothing, it weakens the need for a hard
phase classifier. If it overfilters/double-filters, that is useful evidence too.

It should be tested, not assumed.

---

# B2.5 Risk ranking

## Highest risk: D4-Q14 phase-energy separability

The single most likely architectural failure is not SIMD.

It is the assumption that decoded luma contains enough reliable information to
infer local encoder `dct_type` phase from boundary-energy measurements.

Why this is hard:

- natural edges/textures can dominate a boundary score;
- quantizer strength changes visibility;
- motion compensation can import blockiness at shifted positions;
- residual coding can create fresh nominal-grid structure;
- mixed neighbouring macroblocks contaminate region scores;
- weakly coded/high-detail material may make both phases plausible.

If the detector is not separable, all downstream architecture can be perfectly
implemented and still schedule the wrong luma geometry.

## Cheapest high-value evidence

Before a D4 filtering kernel scope, build a **diagnostic-only phase detector
experiment** with encoder/bitstream ground truth.

Needed corpus:

- real and synthetic MPEG-2 frame pictures;
- per-macroblock ground-truth `dct_type` obtained from bitstream parsing or
  decoder instrumentation;
- mixtures of neighbouring frame-DCT and field-DCT macroblocks;
- multiple QPs/bitrates;
- progressive-looking and strongly interlaced content;
- texture, text, diagonals, flat areas and motion-compensated sequences.

For every ground-truth macroblock/region, record:

    E_phase0
    E_phase1
    score margin
    predicted class
    confidence/unknown
    true dct_type

Then report:

- confusion matrix;
- error rate by QP/content type;
- confidence-margin distributions;
- false confident classifications;
- UNKNOWN rate;
- performance at mixed-geometry boundaries.

Do **not** tune and judge on the same clips. Hold out a small validation set.

This experiment can be done without any filtering, SIMD or output mutation.
It is therefore the cheapest way to falsify the architecture before expensive
kernel proof work.

## Secondary architectural risk: hidden temporal state

If temporal hysteresis were implemented naively, request-order dependence would
be a severe correctness/reproducibility risk in VapourSynth.

The easiest mitigation is architectural: do not put hidden temporal state in
the first detector.

---

# CONSOLIDATED FINDINGS

| ID | Finding | Classification |
|---|---|---|
| V1.1 | FFmpeg libpostproc interlaced deblock stride-doubling mode | REFUTED |
| V1.2 | alleged mode field-splits both luma and chroma | REFUTED AS STATED |
| V1.3 | macroblock QP table / fallback quant context | VERIFIED WITH CORRECTION |
| V1.4 | DGDecode same-code/same-chroma behaviour | COULD-NOT-DETERMINE |
| V2.1 | H.264 MBAFF mixed boundary uses field-spaced filtering | VERIFIED IN SUBSTANCE |
| V2.2 | H.264 chroma follows pair field/frame geometry | VERIFIED |
| V2.3 | GAIS 8.7.2.2 title / 2x2 chroma deblock edge | REFUTED |
| V3.1a | US 6,167,157 Sony/Ohta characterization | PARTIALLY-ACCURATE |
| V3.1b | US 7,031,552 LSI/Winger interlace characterization | PARTIALLY-ACCURATE |
| V3.1c | US 6,983,079 Samsung/field-structured characterization | PARTIALLY-ACCURATE |
| V3.2a | US 6,633,612 as deblock evidence | REFUTED for that use |
| V3.2b | US 7,139,437 Microsoft/interlaced description | REFUTED |
| V3b.1a | claimed 1999 Kim/Kim/Cho TCE paper | REFUTED AS CITED |
| V3b.1b | claimed 2002 Han/Kim IEEE/MPEG-2 paper | REFUTED AS CITED |
| V4.1 | H.262 4:2:0 frame-organised chroma exception | VERIFIED |
| V4.2 | fidelity of two unavailable GAIS literal quotes | COULD-NOT-DETERMINE |
| V4.3 | macroblock `dct_type` presence/semantics | VERIFIED |
| B2.2(iv) | Classic has local boundary/activity gating | VERIFIED, but not a phase detector |
| B2 | W3D scheduler/kernel split | CONCUR, with architecture corrections |
| B2 | literal Classic code/proof reuse for D4 | DISSENT under current ratified rule |
| B2 | hidden temporal hysteresis in first scheduler | DISSENT |

---

# SOURCE REGISTER

## Primary specifications / project source

1. ITU-T Recommendation H.262 (02/2000), especially 6.1.3, macroblock syntax
   6.2.5.1 and dct_type semantics 6.3.17.1.
2. ITU-T Recommendation H.264 (06/2011), especially clause 8.7 and 8.7.2.2.
3. FFmpeg 7.1 `libpostproc/postprocess.c` and `postprocess.h`; current
   `libavfilter/vf_pp.c`.
4. VapourSynth R76 API4 documentation, `VapourSynth4.h`, `VSFilterMode`.
5. Current accepted project source supplied to W3C:
   - `src/classic_scalar_kernel.zig`, especially lines 34-81;
   - `src/classic_vector_backend.zig`, especially lines 55-139, 141-175,
     218-246 and 275-350.
6. Ratified project rule:
   `Deblock4_Scope_Stage_4C_Classic_v2_SSE41_Backend_v1_2.md`, section 9,
   carried by Stage 5C: Classic vector code is not a D4 design/acceptance basis.

## Public patent records

- US 6,167,157.
- US 7,031,552.
- US 6,983,079.
- US 6,633,612.
- US 7,139,437.

Metadata/substance checked against the public Google Patents/USPTO-linked
record by exact patent number.

## Publication metadata

- Changick Kim, `Adaptive post-filtering for reducing blocking and ringing
  artifacts in low bit-rate video coding`, Signal Processing: Image
  Communication 17(7), 525-535, 2002,
  DOI 10.1016/S0923-5965(02)00026-7.
- IEEE Transactions on Consumer Electronics, volume 45, number 3 (1999)
  public issue metadata / DBLP index, used to test the claimed 1999 citation.

---

# W3C FINAL ADVICE TO THE D4 SCOPE AUTHOR

Do not scope a filter kernel yet.

The next cheapest and most discriminating work is D4-Q14 as a **diagnostic
geometry experiment with dct_type ground truth**, plus a small scalar design
note that freezes:

1. the geometry-map contract;
2. confidence/UNKNOWN semantics;
3. span/job fields;
4. phase-transition edge ownership and processing order;
5. deterministic fallback candidates;
6. the rule that first-stage geometry is stateless per frame.

If Q14 shows useful separability, then scope the scalar scheduler/oracle before
SIMD.

If Q14 does **not** show useful separability, do not rescue the detector with
ever-more-complex heuristics by default. Fall back honestly to a declared
uniform mode or another explicitly chosen conservative policy and keep the
uncertainty visible in the design record.

The scheduler/kernel seam is sound. The uncertain part is not how to vectorise
it; it is whether the decoded image tells us the true local DCT geometry
reliably enough to schedule it.
