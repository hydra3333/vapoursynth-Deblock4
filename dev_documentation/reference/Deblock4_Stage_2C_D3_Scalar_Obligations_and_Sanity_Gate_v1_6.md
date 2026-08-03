# Deblock4 - Stage 2C Independent Scalar Obligations and Sanity Gate

**Deliverable:** W3D-2C-D3
**Version:** 1.6
**Date:** 2026-08-02
**Basis:** the ORACLE-CONSTRUCTION EXCEPTION (charter G7; V&T 20.2; D0 K9):
the Stage 2C scope that constructs the Classic ReleaseSafe scalar oracle is
accepted against THESE independently authored obligations plus the loose
whole-image sanity gate in section 9 - not against a pre-existing oracle.
**Independence statement:** every expected value below was derived by W3D
from the D2-documented formulas via hand arithmetic cross-checked by the
transparent reference model in Appendix B (authored from the D2 TEXT, not
by running HolyWu, and never shared as implementation source). The coder's
Zig oracle is written from D2 + the D4 scope; these vectors then judge it.
**Encoding:** US-ASCII; CRLF.

---

# 1. How obligations bind the delivery

```text
- PROOF ROUTING (per W3C D3 review F8): kernel/math/geometry O-items ->
  Zig unit tests; public creation/error O-items (O-1b) -> vspipe/batch
  end-to-end cases in the standing proof matrix; frame/property/copy
  obligations -> the narrowest test exercising the ACTUAL production
  path. Every O-item maps to at least one test on its designated
  surface, asserting the EXACT expected values (integer: no tolerance).
- Tests run in the standing three-mode matrix; per K10 (V&T 3.7) the
  ReleaseSafe and ReleaseFast oracle outputs must be byte-identical for
  every O-vector and for the O-4/G composite frames.
- Vectors are deliberately implementation-independent (D0 K5/G9): they
  discriminate floor-vs-truncate shifts (WP-1), strict-vs-nonstrict
  comparisons (WP-6), clamp bounds, and gating - the places a plausible
  reimplementation or a miscompile diverges.
- Notation: an edge lane is (p2,p1,p0,q0,q1,q2) -> writes (p1,p0,q0,q1),
  per D2 4.1/4.2. Every single-edge vector MUST be exercised in BOTH
  orientations: horizontal (taps across rows) and vertical (taps across
  columns); expected values are identical, footprint mapping per D2.
- Default parameters unless stated: 8-bit, quant/strength=25, offsets 0
  -> alpha=13, beta=4, c0=1, c1=1, peak=255 (O-1 V1).
```

# 2. O-1 Threshold derivation obligations

For (strength, aoffset, boffset, bits) the resolved
(alpha, beta, c0, c1, peak) must equal, after the D2 section-2 clamp
sequence and scaling:

```text
V1  (25,   0,  0,  8) -> (13,   4,    1,   1,   255)
V2  ( 0,   0,  0,  8) -> ( 0,   0,    0,   1,   255)   [see O-5c]
V3  (60,   0,  0,  8) -> (255, 27,   35,   1,   255)
V4  (30, -10, +5,  8) -> ( 7,  10,    0,   1,   255)   [c0=0 with c1=1]
V5  (50, +10,  0,  8) -> (255, 18,   35,   1,   255)   [aoffset +10 is
                                                        IN-RANGE for
                                                        strength 50
                                                        (legal -50..10);
                                                        aIndex=60]
V6  (25,   0,  0, 16) -> (3328, 1024, 256, 256, 65535) [scaled, c1=scale]
```
O-1c FULL-TABLE BINDING (W3C F4): the delivery must assert, element by
element, that its production threshold data (or table-construction
result) equals ALL 61 entries of each of alphas, betas, cs exactly as in
D2 Appendix A. Six sampled tuples cannot bind unused entries.
FULL-DOMAIN TUPLE CHECK, ENUMERATED (ambiguity removed per W3C F5a):
  (i)  every strength 0..60 with aoffset=0, boffset=0  -> 61 cases;
  (ii) at EACH of strengths 0, 25, 60, the FOUR legal offset-extreme
       corners (aoffset,boffset) = (-s,-s), (-s,60-s), (60-s,-s),
       (60-s,60-s) where s is that strength -> 12 cases.
  Total 73 enumerated cases, each asserting the resolved
  (alpha,beta,c0,c1,peak) tuple against the derivation model.
EXHAUSTIVE BIT-DEPTH CHECK (W3C F2): for bits = 8,9,10,...,16 assert
scale = 1<<(bits-8), peak = (1<<bits)-1, c1 = scale, and the scaled
(alpha,beta,c0) for at least strengths 0, 25, 60 -> 9 x 3 cases. Pure
arithmetic; no frame required.

O-1d INTEGER-DEPTH REFUSAL (creation-path; W3C updated-package F1; K29).
VapourSynth permits integer bitsPerSample 8..32, so a valid 17..32-bit
integer clip is API-REACHABLE. Classic supports 8..16 only and MUST
refuse a valid out-of-domain integer depth with the ratified row
"Classic: integer input must be between 8 and 16 bits" (table v1_4) -
NEVER the "input video metadata is invalid" row (that means malformed
metadata, a different condition). Proof: an otherwise-valid 17-bit or
32-bit integer creation case (invocation-level, since such a format is
constructible via the normal format API). Float (16- and 32-bit) is a
SEPARATE refusal (D4 S1); this row is integer-only.

O-1b REJECTION (Classic resolver, not HolyWu): an offset outside
-strength..60-strength is a CREATION ERROR, never clamped (README 3.14,
error table v1_1, D0 K16). E.g. strength=25, boundary_strength_offset=40
-> "Classic: boundary_strength_offset is out of range for strength";
strength=25, side_activity_offset=-30 -> the side_activity error. These
are creation-path obligations (checked at 1C-style creation, distinct
from the pixel oracle) and they bound the differential harness domain.

V4 pins the c0-from-aIndex behaviour (D2 WP-5): c0 follows the ALPHA
index (offsets IN-RANGE: strength 30 legal -30..30). V5 pins the top of
the legal alpha range. CORRECTED per W3C F9: the earlier V5 used an
OUT-OF-RANGE aoffset importing HolyWu's clamp - Classic REJECTS
out-of-range offsets (README 3.14 + error table v1_1), it does NOT clamp.
All O-1 magnitude vectors here are Classic-LEGAL. HolyWu's clamp is an
external layer-(b) fact (D2 section 8), tested only via the differential
harness on the legal shared domain, never as a Classic obligation.

# 3. O-2 Activation obligations (strict comparisons, WP-6)

```text
A1  (100,100,100,113,113,113): |p0-q0| = 13 = alpha -> NOT filtered
    (all four outputs byte-identical to inputs).
A2  (100,100,100,112,112,112): |p0-q0| = 12 < alpha -> filtered;
    expected (p1,p0,q0,q1) = (101,103,109,111).
A3  (100,104,100,110,110,110): |p1-p0| = 4 = beta -> NOT filtered.
A4  strength 0 (O-1 V2): alpha = 0 -> NOTHING ever activates
    (|p0-q0| < 0 impossible); see O-5c whole-frame identity.
A5  (100,100,100,110,114,114): |q0-q1| = 4 = beta -> NOT filtered
    (completes strict-< coverage of the THIRD activation gate; W3C F5).
```

# 4. O-3 Single-edge arithmetic obligations

All at defaults (O-1 V1) unless stated; expected (p1,p0,q0,q1):

```text
B1  (100,100,100,110,110,110) -> (101,103,107,109)
      delta raw (((10)<<2)+100-110+4)>>3 = 34>>3 = 4, clamped to c=3;
      deltap1 = 5>>1 = 2 -> clamp +-c0 = 1; deltaq1 = (-5)>>1 = -3
      (FLOOR) -> clamp -1.
B2  (110,110,110,100,100,100) -> (109,107,103,101)
      delta raw = (-26)>>3 = -4 (FLOOR; truncation would give -3 and a
      DIFFERENT final answer) -> clamp -3. THE WP-1 discriminator.
      EXECUTION-PIN NOTE (D0 K26 signed-shift sentinels): the -4 assumes
      floor semantics for the DIVISION step; the Zig oracle computes the
      delta core with WELL-DEFINED arithmetic (i32 multiply by 4 - never
      a negative left shift, which is C++ UB in the reference source's
      language modes) and signed >> (floor), never @divTrunc. Externally,
      B2/B4/B5 are the designated K26 SIGNED-SHIFT BEHAVIOURAL SENTINELS
      (B2/B5 probe the negative-LEFT-shift UB region, q0-p0 negative; B4
      probes a negative RIGHT shift in the side-delta, q0-p0 positive -
      NOT all "negative-delta"): their outputs must be RECORDED from the
      exact SHA-256-hashed reference binary (opt=1) via D4 Addendum A's
      plugin-level fixtures before they count as reproduced layer-(b)
      facts; any rebuilt reference binary requires fresh hash AND
      sentinel revalidation (K26 rebuild rule).
B3  (200,100,100,110,110,110) -> (100,102,108,109)
      ap = 100 >= beta: c = 2 (not 3), delta clamped to 2, p1 NOT
      written; aq < beta still writes q1. Pins c-widening AND write
      gating sharing the same comparisons.
B4  (0,0,0,9,9,9) -> (1,3,6,8)          [low-value probe, deltas
      +3/+1/-1 with floor on (-4)>>1 = -2 -> clamp -1]
B5  quant=60 (O-1 V3): (195,195,195,5,5,5) -> (160,158,42,40)
      delta raw = (-566)>>3 = -71 (floor) -> clamp -c = -37;
      deltap1 raw = (-95)>>1 = -48 -> clamp -35; deltaq1 raw = 95>>1
      = 47 -> clamp +35. Pins large-c and +-c0 clamps at high strength.
B6  16-bit (O-1 V6): (25600,25600,25600,28160,28160,28160)
      -> (25856,26368,27392,27904). Pins scaled-threshold arithmetic
      including c1 = 256 in the c-widening.
B7  (104,100,100,110,110,110) -> (100,102,108,109)
      ap = |104-100| = 4 = beta: EQUALITY -> no p-side widening (c=2)
      and NO p1 write; aq=0<beta still writes q1. Strict-< at ap==beta
      (W3C F5; expected values independently confirmed by both parties).
B8  (100,100,100,110,110,106) -> (101,102,108,110)
      aq = |106-110| = 4 = beta: EQUALITY -> no q-side widening (c=2)
      and NO q1 write; p side active. Strict-< at aq==beta (W3C F5).
Structural: the 0..peak result clamps (deblock.cpp:111-116/184-189)
must be present in source and asserted by code-level unit test; no
natural in-range vector reaches them at these parameters.
```

# 5. O-4 Whole-schedule composite obligation (Schedule A order)

Input: one 8x8 8-bit plane, strength 25, offsets 0:

```text
rows 0-3:  100 100 100 100 110 110 110 110
rows 4-7:  112 112 112 112 112 112 112 112
```
Applying the FULL D2 section-3 schedule (top-band vertical edges; then
per band: horizontal at x=0, then per x: horizontal THEN vertical;
sequential, in place) must yield EXACTLY:

```text
100 100 101 103 107 109 110 110
100 100 101 103 107 109 110 110
101 101 102 104 108 110 110 110
103 103 104 106 109 110 111 111
109 109 109 109 110 110 111 111
111 111 111 111 111 111 111 111
112 112 112 112 112 112 112 112
112 112 112 112 112 112 112 112
```
ORDER-SENSITIVITY obligation: with the crossing order deliberately
swapped (vertical before horizontal at each x), the output DIFFERS from
the above; first difference at (row 2, col 5): correct 110, swapped 109.
The delivery's test must demonstrate the inequality (proving the
implementation is not accidentally order-independent) and must NOT ship
the swapped order anywhere outside the test.
TOP-BAND obligation: after the schedule, rows 0-1 equal the values shown
(modified ONLY by the top-band vertical edge; no horizontal edge touches
rows 0-1).

# 6. O-5 Plane and format obligations

```text
a  LUMA-ON-CHROMA (D2 section 3; D0 K11): running the O-4 frame as a
   chroma plane produces the IDENTICAL output matrix - same thresholds,
   same 4-grid in the plane's own coordinates, no chroma-specific path.
b  PLANE SELECTION: an unprocessed plane is a COPY path - byte-identical
   for every ACCEPTED format (integer 8..16-bit in 2C, per D4 S1; V&T 20.1
   copy/share; K19 layer (c) strictest case). Source-frame immutability
   is separate and unconditional: see O-6d.
c  STRENGTH 0 IDENTITY (wording corrected per W3C F4a; K27/README 13.2):
   every output PLANE BYTE is identical to the corresponding source plane
   byte for any content (O-1 V2 + O-2 A4). Frame PROPERTIES are NOT
   included: existing source properties are preserved and the ratified
   audit keys (Deblock4Filter, Deblock4Tier, Deblock4Version,
   Deblock4Using) are still written to their required values. Never
   compare opaque frame-object memory.
d  16-BIT (CORRECTED per W3C F1 - the earlier x256 claim was FALSE):
   threshold scaling does NOT make the sequential in-place schedule
   homogeneous; later edges consume earlier ROUNDED writes (+1 average
   bias, +4 delta bias, floor shifts), so the whole-frame result is not
   the 8-bit result x256 (they differ at 18 positions). The obligation is
   the LITERAL native-16-bit output of the O-4 input x256 under V6
   thresholds, independently recomputed by both W3C and W3D:

   25600 25600 25856 26368 27392 27904 28160 28160
   25600 25600 25856 26368 27392 27904 28160 28160
   25856 25856 26112 26624 27648 28096 28288 28288
   26368 26368 26624 27136 27872 28192 28352 28352
   27904 27904 27976 27988 28108 28264 28480 28480
   28416 28416 28416 28408 28424 28480 28544 28544
   28672 28672 28672 28672 28672 28672 28672 28672
   28672 28672 28672 28672 28672 28672 28672 28672

   B6 remains the single-edge threshold-scaling vector (that one case
   happens to scale exactly; the frame does not).
```

# 7. O-6 Footprint obligations (D0 K7)

```text
a  GENERAL WRITE-FOOTPRINT INVARIANT (corrected per W3C follow-up F1;
   the earlier four-corners claim was FALSE for extents congruent to
   3 mod 4): every sample OUTSIDE the union of all ELIGIBLE edge write
   footprints is byte-identical to the source. This states the settled
   native complete-footprint policy directly.
   Why the corner claim failed: at W=7 the vertical edge e=4 IS eligible
   (reads cols 1..6, all in-plane) and writes cols 2..5, and W-2 = 5 -
   so the rightmost corner region IS written. Same for H=7,11,15,...
   NARROW COROLLARY (still true, and asserted for the mod-8 frames only):
   for the O-4 8x8 and G 64x64 composites the four 2x2 corner blocks ARE
   byte-identical to the source; G3 relies on this scoped form.
b  Single-edge tests assert bytes OUTSIDE the write footprint
   (p2/q2 taps and beyond) are unmodified.
c  Interior-only coverage per D2 section 3: no edge at x=0/y=0 or at the
   frame's far border; for mod-8 input taps stay in-frame, and for other
   geometries O-7 eligibility governs.
d  SOURCE-FRAME IMMUTABILITY (W3C F6): after processing, the ORIGINAL
   source frame is byte-unchanged for ALL planes including processed
   ones (the filter writes only the destination copy).
e  MEMORY CANARIES (W3C F6; V&T 20.2): guard-band patterns around the
   plane allocation, around each logical row (stride slack), and around
   single-edge test buffers must be intact after every O-test, including
   the O-7 non-mod-8 and small-plane cases (README 6.4: stride slack is
   NEVER algorithm-usable).
f  i32 RANGE PROOF (W3C F6): the delivery carries a complete worst-case
   bound proof (test or comptime assertion) for all legal 8..16-bit
   inputs; the governing bounds (16-bit worst case):
     sample 0..65535; alpha <=65280; beta <=6912; c0 <=8960; c <=9472;
     p0+q0+1 <=131071; 4*(q0-p0)+p1-q1+4 in -327671..327679;
     p2+avg-2*p1 in -131070..131070; pre-clamp p0/q0 in -9472..75007;
     pre-clamp p1/q1 in -8960..74495. All within i32.
```

# 7b. O-7 Boundary and small-plane obligations (W3C F2; README 6.1/6.2/6.5; D0 K3)

Eligibility is PER EDGE POSITION PER AXIS: eligible(e) <=> e-3 >= 0 AND
e+2 <= extent-1, candidates at multiples of 4; min_extent = 7 per
orientation; orientations are independent; neither eligible -> byte-
identical pass-through. NO padding, NO crop, NO invented pixels.
Traversal keeps the Schedule-A order with ineligible edges skipped and
vertical band rows clipped to plane height (Appendix C model; derived
outputs below independently recomputed).

```text
a  10x10 (rows 0-3 = 100 100 100 100 110 110 110 110 110 110;
   rows 4-9 all 112), strength 25: candidates x/y in {4,8}; x=8 and y=8
   are INELIGIBLE (e+2=10 > 9) and MUST be skipped. Expected output:
     100 100 101 103 107 109 110 110 110 110
     100 100 101 103 107 109 110 110 110 110
     101 101 102 104 108 110 110 110 110 110
     103 103 104 106 109 110 111 111 111 111
     109 109 109 109 110 110 111 111 111 111
     111 111 111 111 111 111 111 111 111 111
     112 112 112 112 112 112 112 112 112 112   (x4 rows)
   (rows 6-9 unchanged; cols beyond the eligible region unchanged except
   via the eligible y=4 horizontal edge which spans ALL columns.)
b  12x6 (each row = 100x4 110x4 120x4), strength 25: H=6 < min_extent 7
   -> NO horizontal edges; W=12 -> vertical edges at x=4 AND x=8 filter
   ALL SIX rows. Expected output, every row identically:
     100 100 101 103 107 109 111 113 117 119 120 120
c  6x6: both extents < 7 -> EMPTY candidate sets -> output byte-identical
   to source (pass-through, no error).
c2 11x7 - the extent-mod-4 == 3 class (W3C follow-up F1; the 10x10/12x6/
   6x6 cases do NOT expose it). Rows 0-3 = 100x4 110x4 120x3; rows 4-6
   all 112. Eligible: vertical x=4 and x=8 (x=8 reads 5..10 <= W-1=10);
   horizontal y=4 only (y=4 reads 1..6 <= H-1=6). Expected output:
     100 100 101 103 107 109 111 113 117 119 120
     100 100 101 103 107 109 111 113 117 119 120
     101 101 102 104 108 110 111 113 116 118 119
     103 103 104 106 109 110 111 113 115 116 117
     109 109 109 109 110 111 112 113 113 114 115
     111 111 111 111 111 111 112 112 113 113 113
     112 112 112 112 112 112 112 112 112 112 112
   Note rows 5 (=H-2) and column 9 (=W-2) ARE written here - the exact
   case that falsified the old O-6a corner claim.
d  For all FOUR cases (a, b, c, c2): no read or write outside the
   logical plane (O-6 canaries apply), and no resize/crop node appears
   in the graph.
```

# 7c. O-8 Production-path routing obligations (W3C F5b/F4b; K27/K28)

Plane-neutral mathematics and copy semantics can be satisfied by module
tests while production is wired wrongly. These obligations are proved on
the ACTUAL production path (vspipe end-to-end), not by module tests:

```text
a  planes omitted           -> EVERY plane of the source format processed.
b  explicit one-plane subset-> ONLY that plane processed; others exact
                              plane-byte copies.
c  YUV chroma plane selected-> full luma algorithm in that plane's OWN
                              coordinates (K28: actual plane width/height/
                              stride/bytes-per-sample from the frame; NEVER
                              inferred from luma dims and subsampling).
d  Gray                     -> processed.
e  RGB, selected plane      -> processed (no colour-family special-casing
                              of the mathematics).
f  source frame             -> byte-unchanged for ALL planes (O-6d).
g  audit properties         -> exact ratified values on every output frame
                              (K27), including Deblock4Tier reporting the
                              IMPLEMENTED tier actually executed.
h  bit depths               -> production cases at 8-bit, one u16-stored
                              intermediate depth (10 or 12), and 16-bit.
```

# 7d. O/G-to-test crosswalk (required delivery artefact; W3C F5b)

The delivery MUST include a crosswalk table naming, for EVERY O-item and
G-item in this document, the exact test identifier and the mode(s) it
runs in. "Every obligation is tested somewhere" is not auditable; the
crosswalk is the audit surface, and its completeness is itself a gate.

# 8. Conditional float obligations (T-2)

RESOLVED BY D4 S1 (W3X-ratified): float is OUTSIDE the accepted Stage 2C
format domain and MUST be refused at creation with the ratified exact row
"Classic: float input is not supported" (table v1_4), proved by an
otherwise-valid constant-format float-input case. When Classic float
support lands as a later bounded step, this document gains a versioned
float appendix (bias-free unclamped formulas; K22/V&T 3.8 tolerance
numbers; V&T 3.5 activation-flip reporting) and the row is retired.
Integer obligations above are unconditional.

# 9. The loose whole-image sanity gate (exception clause companion)

Frame G: 64x64 8-bit, 8x8-block DC checkerboard of values 100/108
(inter-block step 8 < alpha 13). At strength 25, offsets 0, the oracle
must satisfy ALL of:

```text
G1  Mean absolute discontinuity across all 8-aligned block boundaries
    (both directions; source value exactly 8.000) is reduced by AT
    LEAST 40 percent. (Derivation model achieves 78.7 percent; the
    bound is deliberately loose - the SHARP external check is the D4
    HolyWu differential harness, K19 layer (b).)
G2  Every output sample is in 0..255.
G3  The four 2x2 corners are byte-identical to the source (O-6a).
G4  Two consecutive runs produce byte-identical output (determinism,
    K23). COMPARISON DEFINED (W3C F4a): all PLANE BYTES compared exactly,
    PLUS an explicit exact check of the ratified audit-property set
    (Deblock4Filter, Deblock4Tier, Deblock4Version, Deblock4Using);
    no opaque frame-object memory comparison.
G5  Maximum absolute per-sample change <= 12 (verified reference: 5;
    bound loose; kills wholesale shifts). (W3C F3; V&T 20.2 corruption
    tripwire.)
G6  Mean absolute per-sample change over the frame <= 3.0 (verified
    reference: 1.667236...; bound loose but MUST reject the recorded
    counterexample below).
NEGATIVE CONTROL (W3C F3): the constant-fill corruption "all non-corner
samples := 104, corners restored" passes G1-G4 (discontinuity 0, mean
change 3.984375) and MUST be rejected by G6. The delivery's gate test
includes this counterexample and asserts the gate fails it.
```

# 9b. Open Rule Questions (standing three-way discussion register)

Recorded per W3X standing invitation: where any party thinks a rule is
wrong, over-constraining, or should change to deliver a better result, it
is raised here rather than silently followed or silently broken. Entries
are resolved by W3X after W3D/W3C positions; resolutions become ratified
notes (and D0 K-numbers where they are knowledge, not one-off calls).

```text
Q1 (W3C) EXPLICIT FINAL CLAMPS - RESOLVED by D4 S2 (retain; W3X-
   ratified with the released scope); leaves the register on release.
   Original entry retained for the record:
   EXPLICIT FINAL CLAMPS. Must the ReleaseSafe scalar kernel retain
   explicit final 0..peak sample clamps for structural fidelity to the
   reference and defensive safety, or may they be omitted if a complete
   proof establishes every legal integer input/parameter combination
   keeps pre-final writes within 0..peak?
   W3C position: RETAIN - cheap, mirrors the reference, makes the range
   guarantee locally obvious, survives future maintenance and changed
   preconditions, avoids acceptance depending on a global proof staying
   intact forever.
   W3D position: AGREE, retain - and note D3 already carries the O-6f
   worst-case bound proof, so retention costs nothing that the proof
   saves. Record as an intentional architecture/safety decision, NOT as
   though byte-equivalence compels that exact source expression.
   STATUS: open for W3X ratification.

Q2 (W3D) REVIEW-LOOP TERMINATION. "Review until no findings" has no
   natural terminator and the yield is converging (round 1: structural
   policy errors; round 2: residuals of round 1; round 3: one arithmetic
   error + coverage additions; round 4: one boundary error + this
   register). Proposal: D3+D4 receive ONE combined review, after which
   findings are TRIAGED into "blocks release" vs "recorded for the
   post-delivery review", on the grounds that a real oracle failing a
   real vector is a stronger error-detector than a further document
   pass. Counter-consideration: documents are cheap to fix, deliveries
   are not.
   STATUS: open for W3X ratification.

Q3 (W3D) KNOWLEDGE-SWEEP SCOPE. The D0 section-6 two-sided sweep
   currently searches the whole doc set per scope, and that set grows.
   Proposal: IF two consecutive sweeps return "confirmed, no gaps",
   narrow the standing sweep to documents touched by the deliverable's
   subject matter, retaining full-set sweeps for stage-opening scopes.
   Not proposed now - the sweeps are still finding things.
   STATUS: watch item, no action requested.
```

# 10. Binding Knowledge Checklist (D0 v1_3)

```text
K2     these integer vectors become PERMANENT exact regression
       obligations for every later backend (v2 at 4C, v3 at 5C).
K3     APPLIES NOW (W3C F2): O-7 encodes the settled README 6.1/6.2/6.5
       boundary and small-plane policy as operative obligations.
K5/G9  vectors are implementation-independent discriminators (B2, B5,
       B7, B8).
K26    B2/B4/B5 are the designated K26 SIGNED-SHIFT behavioural
       sentinels (B2/B5 probe the negative-LEFT-shift C++ UB region,
       q0-p0 negative; B4 probes a negative RIGHT shift in the
       side-delta, q0-p0 positive). D4 Addendum A is the plugin-level
       FIXTURE AUTHORITY for observing them: mandatory reference-binary SHA-256,
       recorded sentinel outputs, rebuild -> revalidation. Zig-side:
       multiply-by-4 delta core, no negative-left-shift analogue,
       signed >> floor divisions. Appendix B/C models use (q0-p0)*4.
K7     footprints bound by O-6; confirmed source-true in D2.
K8     this document IS the "never HolyWu-only" oracle basis.
K9     acceptance basis under the oracle-construction exception; after
       2C acceptance, layer-(c) differential discipline takes over.
K10    RS-vs-RF byte-identity duty attached to every O-test (sec 1).
K11    O-4 pins Schedule A order; no Schedule B content present.
K16    O-1b encodes the ratified Classic offset-REJECTION obligations
       (never clamp). Creation-error table v1_4 ADDS the THREE ratified
       Stage 2C rows (float refusal; INTEGER-DEPTH refusal per O-1d/K29;
       backend-unavailable refusal) under the D0 section-5 exception; no
       EXISTING string or using-echo surface is altered.
K29    O-1d: valid integer depths extend to 32; refuse 17..32-bit
       explicitly, never as malformed metadata.
K27    O-5c/G4 corrected to PLANE BYTES + explicit audit-property set;
       O-8g pins the property contract.
K28    O-8c/O-8h pin actual per-plane geometry and storage; never
       inferred chroma bounds.
K23    G4 pins determinism; O-6d/O-6e pin memory/source safety; together
       the K23 reproducibility conditions for the scalar oracle.
K19    these are internal-layer obligations; the external layer-(b)
       harness is D4's; WP-1/WP-5/WP-6 pinned by B2, V4, A1/A3.
K22    float REFUSED in 2C (D4 S1); float obligations carried forward to
       the later bounded float step, not a 2C obligation.
K24    obligations are kernel-agnostic: they bind outputs, leaving D4
       free to author the shared-kernel comptime shape.
Sweep  (D0 sec 6): W3C reviews THIS document (with D4) - feasibility,
       ambiguity, gaps, plus the independent doc-set sweep.
```

# Appendix A - consolidated vector quick table

Single-edge (p2,p1,p0,q0,q1,q2) -> (p1,p0,q0,q1), defaults unless noted:
```text
A1 100,100,100,113,113,113 -> unchanged (not filtered)
A2 100,100,100,112,112,112 -> 101,103,109,111
A3 100,104,100,110,110,110 -> unchanged (not filtered)
B1 100,100,100,110,110,110 -> 101,103,107,109
B2 110,110,110,100,100,100 -> 109,107,103,101
B3 200,100,100,110,110,110 -> 100,102,108,109
B4 0,0,0,9,9,9             -> 1,3,6,8
B5 (q60) 195,195,195,5,5,5 -> 160,158,42,40
B6 (16b) 25600x3,28160x3   -> 25856,26368,27392,27904
```

# Appendix B - derivation record (transparent reference model)

Authored by W3D from the D2 text solely to derive/cross-check the
expected values above; retained verbatim as the derivation record. It is
NOT implementation source and must never be translated into the
delivery.

```python
alphas=[0]*16+[4,4,5,6,7,8,9,10,12,13,15,17,20,22,25,28,32,36,40,45,50,
56,63,71,80,90,101,113,127,144,162,182,203,226]+[255]*11
betas=[0]*16+[2,2,2,3,3,3,3,4,4,4,6,6,7,7,8,8,9,9,10,10,11,11,12,12,13,
13,14,14,15,15,16,16,17,17,18,18,19,20,21,22,23,24,25,26,27]
cs=[0]*21+[1]*10+[2,2,2,2,3,3,3,4,4,5,5,6,7,8,8,10,11,12,13,15,17,19,
21,23,25,27,29,31,33,35]
def clamp(v,lo,hi): return max(lo,min(hi,v))
def thresholds(q,ao,bo,bits=8):
    ao=clamp(ao,-q,60-q); bo=clamp(bo,-q,60-q)
    ai=clamp(q+ao,0,60); bi=clamp(q+bo,0,60); s=1<<(bits-8)
    return alphas[ai]*s,betas[bi]*s,cs[ai]*s,s,(1<<bits)-1
def edge6(p2,p1,p0,q0,q1,q2,al,be,c0,c1,pk):
    if not(abs(p0-q0)<al and abs(p1-p0)<be and abs(q0-q1)<be):
        return p1,p0,q0,q1,False
    ap,aq=abs(p2-p0),abs(q2-q0)
    c=c0+(c1 if ap<be else 0)+(c1 if aq<be else 0)
    avg=(p0+q0+1)>>1
    d=clamp((((q0-p0)*4)+p1-q1+4)>>3,-c,c)   # *4: K26 no-left-shift
                                             # corollary; >> floor
    dp=clamp((p2+avg-(p1<<1))>>1,-c0,c0)
    dq=clamp((q2+avg-(q1<<1))>>1,-c0,c0)
    return (clamp(p1+dp,0,pk) if ap<be else p1, clamp(p0+d,0,pk),
            clamp(q0-d,0,pk), clamp(q1+dq,0,pk) if aq<be else q1, True)
def full(frame,q=25,ao=0,bo=0,bits=8):
    al,be,c0,c1,pk=thresholds(q,ao,bo,bits)
    f=[r[:] for r in frame]; H=len(f); W=len(f[0])
    def ver(x,y0):
        for r in range(y0,y0+4):
            a=edge6(f[r][x-3],f[r][x-2],f[r][x-1],f[r][x],f[r][x+1],
                    f[r][x+2],al,be,c0,c1,pk)
            f[r][x-2],f[r][x-1],f[r][x],f[r][x+1]=a[0],a[1],a[2],a[3]
    def hor(x0,y):
        for i in range(4):
            c=x0+i
            a=edge6(f[y-3][c],f[y-2][c],f[y-1][c],f[y][c],f[y+1][c],
                    f[y+2][c],al,be,c0,c1,pk)
            f[y-2][c],f[y-1][c],f[y][c],f[y+1][c]=a[0],a[1],a[2],a[3]
    for x in range(4,W,4): ver(x,0)
    for y in range(4,H,4):
        hor(0,y)
        for x in range(4,W,4): hor(x,y); ver(x,y)
    return f
```

# Appendix C - boundary-eligibility schedule model (derivation record)

Extends Appendix B for O-7: identical edge math; per-position eligibility
velig(x): x-3>=0 and x+2<=W-1; helig(y): y-3>=0 and y+2<=H-1 (README
6.2); traversal identical to Appendix B's full() with ineligible edges
skipped and vertical band rows range(y0, min(y0+4, H)):

```python
def full_bounds(F,q=25,ao=0,bo=0,bits=8):
    al,be,c0,c1,pk=thresholds(q,ao,bo,bits)
    f=[r[:] for r in F]; H=len(f); W=len(f[0])
    velig=lambda x: x-3>=0 and x+2<=W-1
    helig=lambda y: y-3>=0 and y+2<=H-1
    def ver(x,y0):
        for r in range(y0,min(y0+4,H)):
            a=edge6(f[r][x-3],f[r][x-2],f[r][x-1],f[r][x],f[r][x+1],
                    f[r][x+2],al,be,c0,c1,pk)
            f[r][x-2],f[r][x-1],f[r][x],f[r][x+1]=a[0],a[1],a[2],a[3]
    def hor(x0,y):
        for c in range(x0,min(x0+4,W)):
            a=edge6(f[y-3][c],f[y-2][c],f[y-1][c],f[y][c],f[y+1][c],
                    f[y+2][c],al,be,c0,c1,pk)
            f[y-2][c],f[y-1][c],f[y][c],f[y+1][c]=a[0],a[1],a[2],a[3]
    for x in range(4,W,4):
        if velig(x): ver(x,0)
    for y in range(4,H,4):
        if helig(y): hor(0,y)
        for x in range(4,W,4):
            if helig(y): hor(x,y)
            if velig(x): ver(x,y)
    return f
```
Verified: reproduces the O-4 8x8 matrix exactly on mod-8 input (the
eligibility tests are vacuous there), and produces the O-7 a, b, c and
c2 (11x7) expected outputs above.

---

Revision: v1.6 (2026-08-03) W3C updated-package: F1 added O-1d integer-
depth refusal obligation (17..32-bit reachable; ratified row; K29); F6
sentinel wording -> K26 signed-shift with B4 distinguished, B2 note
points at Addendum A; K16 names all three v1_4 rows. v1.5 (2026-08-03)
aligned with the ratified D4 decisions (W3C
revised-package F8): float refusal replaces the open T-2 conditional;
O-5b names the accepted integer domain; O-7d covers all four boundary
cases and Appendix C's verification names c2; sentinels renamed
signed-shift with Addendum A as fixture authority; K16 names both v1_2
rows; Q1 marked resolved-by-S2.
v1.4 (2026-08-03) applied W3C combined-review findings reaching
D3: F4a corrected O-5c and G4 to PLANE-BYTE comparison plus an explicit
audit-property set (K27/README 13.2); F5a enumerated O-1c's full-domain
tuple set (73 cases) and added the exhaustive bits=8..16 arithmetic check
(F2); F5b/F4b added O-8 production-path routing obligations (plane
selection, colour families, chroma in its own coordinates per K28, bit
depths, audit properties) and 7d the mandatory O/G-to-test crosswalk.
v1.3 (2026-08-03) applied W3C D3 v1.2 follow-up: F1 replaced
O-6a's four-corners claim (FALSE at extents = 3 mod 4; verified at W=7
where the eligible x=4 edge writes W-2) with the general
outside-the-write-footprint-union invariant, keeping the corner form as a
scoped corollary for the mod-8 O-4/G frames; added O-7 c2 (11x7,
extent-mod-4==3 class) with derived expected output; added section 9b
Open Rule Questions register (Q1 explicit clamps - W3C and W3D both say
retain; Q2 review-loop termination; Q3 sweep scope). v1.2 (2026-08-03)
applied W3C D3 review F1-F8: F1 corrected
O-5d to the literal native-16-bit matrix (x256 homogeneity claim was
false; both parties recomputed identically); F2 added O-7 boundary/
small-plane obligations with derived 10x10, 12x6, 6x6 expected outputs
and Appendix C model; F3 added gate G5/G6 with the recorded constant-
fill counterexample as a mandatory negative control; F4 added O-1c
full-table + full-index binding; F5 added A5, B7, B8 strict-equality
vectors (values cross-confirmed with W3C); F6 added O-6d source
immutability, O-6e canaries, O-6f i32 range-proof bounds; F7 aligned
K26 handling (sentinels, mandatory binary hash, rebuild rule, *4
models); F8 rewrote proof routing, fixed O-5b wording, updated
checklist (K2, K3, K23, K26). v1.1 (2026-08-02) applied W3C D2 findings reaching D3: F9
replaced the out-of-range V5 with an in-range vector and added O-1b
(Classic REJECTS out-of-range offsets per ratified policy); F2 attached
the K26 execution-pin note to floor-shift vectors B2/B4/B5. Integer
derivations otherwise unchanged (D2 formula transcription verified PASS
by W3C). v1.0 initial authoring in parallel with D2 verification. To be
reviewed by W3C together with D4.
