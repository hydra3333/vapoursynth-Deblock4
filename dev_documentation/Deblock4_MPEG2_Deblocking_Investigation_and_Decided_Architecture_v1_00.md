# Deblock4 - MPEG-2 Deblocking: Investigation Results and Decided Architecture

**Document:** Deblock4_MPEG2_Deblocking_Investigation_and_Decided_Architecture
**Version:** 1.00
**Date:** 2026-08-16
**Author:** W3D (designer); ratified by W3X
**Status:** PREVAILING SINGLE SOURCE OF TRUTH for MPEG-2 deblocking matters in
this project. It supersedes Deblock4_MPEG2_Grid_Field_DCT_Knowledge_v1_2.md
(whose verified content is absorbed here; that file is to be marked
SUPERSEDED with a pointer to this document). The three GAIS raw-response
capture files and the W3C verification report remain in the record as raw
EVIDENCE; where any of them and this document disagree, THIS DOCUMENT
PREVAILS. Living document: sections 8-10 hold ratified placeholders for
results not yet produced.
**Provenance discipline:** every factual claim below carries its verification
class: [H.262-VERIFIED] read in the authoritative ITU text by W3C
(2026-08-16 verification round); [SPEC-VERIFIED] read in another published
standard by W3C; [SOURCE-VERIFIED] read in named source code by W3C or W3D;
[DERIVED] reasoned by W3D/W3C from verified facts, W3X-ratified;
[MEASURED] from project measurement; [PENDING] awaiting evidence. Nothing
in this document rests on unverified GAIS testimony.
**Encoding:** US-ASCII; CRLF.

---

# 1. Purpose and scope

Deblock4 is the filter this project exists to build: deblocking PAL 576i
MPEG-2 material on its ACTUAL 8x8 DCT grid. Before designing its kernel, an
investigation (2026-08-12 .. 2026-08-16) settled the block-geometry facts,
surveyed prior art, calibrated the external research instrument, and decided
the architecture. This document is the complete record and the design
authority for what follows. Classic (the H.264-style fixed-grid filter) is
out of scope here except where explicitly contrasted; the ratified rule
stands that NOTHING in Classic is a design or acceptance basis for Deblock4.

# 2. Verified MPEG-2 block-geometry facts (the F-series)

```text
F1  [H.262-VERIFIED] The DCT operates on 8x8 blocks of SAMPLES, luma and
    chroma alike, in every chroma format.
F2  [H.262-VERIFIED] Block coordinates and dimensions are defined on the
    SAMPLING GRID OF THE PLANE BEING CODED. In 4:2:0 a chroma 8x8 block
    covers 16x16 in luma coordinates, but the transform is on 8x8 actual
    chroma samples.
F3  [H.262-VERIFIED] Blocks per macroblock: 4:2:0 = 4Y+1Cb+1Cr = 6;
    4:2:2 = 4Y+2Cb+2Cr = 8; 4:4:4 = 4Y+4Cb+4Cr = 12.
F4  [H.262-VERIFIED] THE CENTRAL RULE: in 4:2:0, when a FRAME PICTURE is
    coded with dct_type = field DCT, the CHROMINANCE blocks remain
    FRAME-ORGANISED (8 consecutive chroma rows). Field DCT applies to the
    LUMINANCE blocks only. In 4:2:2 and 4:4:4, chroma FOLLOWS the luma
    organisation. Authority: ITU-T H.262 (02/2000) subclause 6.1.3, read
    directly by W3C in the 2026-08-16 verification round; the verbatim
    sentences are quoted in the W3C verification report
    (Deblock4_D4_W3C_Verification_and_Design_Review_v1_0.md, section V4),
    which is the quotation of record. This closes checklist item G1,
    PENDING since Stage 4C.
F5  [H.262-VERIFIED] dct_type is a MACROBLOCK-level syntax element
    (subclause region 6.3.17.x) and may vary macroblock-to-macroblock
    within one frame picture (available when the sequence does not force
    frame_pred_frame_dct). Consequence: any uniform whole-frame grid
    assumption is an APPROXIMATION on genuinely mixed Case (a) material.
F6  [DERIVED] A post-decode filter has no bitstream access and therefore
    cannot KNOW per-macroblock dct_type; it can only measure decoded
    pixels and be seeded by a user declaration.
F7  [DERIVED] TFF/BFF does NOT affect block geometry. Field order swaps
    which field is which, not where any block boundary sits; each field is
    filtered at stride 2 within itself identically. The mode parameter
    therefore needs THREE values, not five (D4-Q15, closed).
```

# 3. The three geometries (the case table)

For a post-decode filter seeing the reconstructed, re-interleaved frame:

```text
GEOMETRY            LUMA BLOCK BOUNDARIES          4:2:0 CHROMA BOUNDARIES
progressive /       every 8 consecutive frame      every 8 consecutive
frame DCT           rows (pitch 1, period 8)       chroma rows (pitch 1)

Case (a):           FIELD-ORGANISED: staggered,    FRAME-ORGANISED (F4):
frame picture,      16-frame-row period; six-tap   every 8 consecutive
field DCT (per      footprint at SAME-FIELD rows   chroma rows (pitch 1) -
macroblock, F5)     = frame-row offsets            THE LUMA/CHROMA GRID
                    -6,-4,-2,0,+2,+4 (pitch 2)     DIVERGENCE, unique to
                                                   4:2:0 MPEG-2
Case (b):           each field independently       each field independently
field pictures      coded: period 8 WITHIN the     coded: period 8 within
                    field = 16-frame-row period,   the field, pitch 2
                    pitch 2
```

[DERIVED, decisive] SEPARATEFIELDS TEARS FRAME-ORGANISED BLOCKS: alternate
rows of every plane go to different field clips, so a frame-organised block's
8 consecutive rows split 4/4 across two clips and NO instance can see it.
Separated-field input is therefore only ever correct for Case (b); for Case
(a) chroma and for progressive material it is unfixable by any algorithm.
This drove decision D4-D01.

# 4. Prior art and external verification: what was actually established

```text
P1  [SOURCE-VERIFIED, REFUTING GAIS] FFmpeg libpostproc: in the examined
    interface, pict_type carries QP semantics (PP_PICT_TYPE_QP2); NO
    interlaced deblocking flag doubling line stride was found; Y, U, V are
    passed separately at ordinary per-plane strides. GAIS's load-bearing
    claim that libpostproc field-splits chroma under an interlaced flag is
    NOT SUPPORTED. Consequence: there is no evidence the wider ecosystem
    "gets Case (a) chroma wrong", and equally none that anyone handles it;
    our design rests on the standard (F4), not on novelty claims.
P2  [SPEC-VERIFIED] H.264 clause 8.7 MBAFF: mixed frame/field boundaries
    genuinely invoke field-mode filtering with field-spaced sample
    addressing, and chroma FOLLOWS the macroblock pair's frame/field
    geometry. The MBAFF boundary-mapping analogy for LUMA is sound. Two
    GAIS details corrected: 8.7.2.2 is "Derivation process for the
    thresholds for each block edge" (not a chroma boundary-strength
    clause), and no 2x2 chroma deblocking-edge concept exists in 8.7.
    The chroma asymmetry of F4 has NO MBAFF analogue: MBAFF chroma follows
    the pair decision, so MBAFF contributes nothing to the Case (a)
    luma/chroma divergence.
P3  [SOURCE-VERIFIED] One real literature find: Changick Kim,
    "Adaptive post-filtering..." (Signal Processing: Image Communication,
    2002, single author - recovered from a distorted GAIS citation). It
    independently documents that inter-frame prediction PROPAGATES block
    artifacts away from the nominal grid - supporting issue D4-Q11.
P4  [DERIVED from the calibration record] No verified prior art addresses
    the Case (a) luma/chroma grid divergence. This is now a
    "nothing verified found" statement, NOT a verified absence.
```

# 5. The GAIS engagement: record and calibration verdict

Four rounds (2026-08-12 grid confirmation; 2026-08-16 investigation brief;
critique/refined-questions; option-space request). ENGAGEMENT CLOSED
2026-08-16 by W3X.

```text
WHAT GAIS WAS GOOD FOR (retained, marked [DERIVED] where adopted):
  - The Case (a)/(b) distinction and its framing of Q-A3.
  - Failure-mode reasoning: the static field-coded classifier failure
    (motion-based D_frame vs D_field measures cannot see it); the dual
    cost (staggered boundaries unfiltered AND non-boundaries blurred);
    texture-masking; noise-floor masking; classifier flicker.
  - The option space: classifier vs direct phase measurement vs
    overcomplete sliding-DCT (the last rejected with sound reasons:
    field-blind smearing, chroma tearing, prohibitive cost).
  - Grid-shift warning (with P3 later corroborating it independently).

WHAT GAIS WAS NOT (the calibration verdict, complete):
  - FIVE patent citations across two rounds: all real numbers, ALL
    misattributed (6,633,612 Faroudja DCDi not Sony; 7,139,437 Eastman
    Kodak not Microsoft; 6,167,157 JVC/Sugahara not Sony/Ohta; 7,031,552
    and 6,983,079 both Changick Kim/Seiko Epson, not LSI/Winger or
    Samsung/Kim).
  - TWO paper citations: the "1999 Kim/Kim/Cho IEEE TCE 45(3)" paper is
    absent from the indexed issue metadata (REFUTED as cited); the 2002
    citation was a distortion of the real single-author Kim paper (P3).
  - A "verification retry" that REPLACED the whole citation set and
    labelled everything "Fully Verified" while retracting nothing, and a
    claim to have "analyzed the source code of libpostproc" (refuted by
    P1).
  - One self-contradiction: advising "default to the frame path when
    static", which institutionalises the exact failure its own F5 answer
    described. Retracted by GAIS when confronted.

STANDING RULE (W3X-ratified): GAIS output is a REASONING AID only. No GAIS
factual claim, citation or quotation enters project knowledge without
independent verification. Its raw responses remain captured as evidence;
this document prevails over all of them.
```

# 6. Issue register (D4-Q series) - dispositions

```text
D4-Q01  Chroma period under field coding          CLOSED by F4: chroma
        (suspected chroma_step_y=4 defect)        stays 8 in Case (a).
                                                  The shipped parameter
                                                  resolution IS defective;
                                                  superseded by D4-D02
                                                  redesign rather than
                                                  patched.
D4-Q02  What the kernel mathematics is            OPEN - first kernel-scope
                                                  question. Direction: the
                                                  boundary-discontinuity-
                                                  vs-local-activity FAMILY,
                                                  derived independently for
                                                  8x8 (see D4-D08).
D4-Q03  Correctness without an external oracle    OPEN - Deblock4 gets its
                                                  OWN oracle: hand-derived
                                                  fixtures, W3D-derived
                                                  mathematics, W3X-ratified
                                                  (D4-D08). No HolyWu
                                                  analogue exists.
D4-Q04  Grid-mode semantics / eligibility at 8x8  OPEN - kernel scope.
D4-Q05  midpoint_threshold_scale meaning          OPEN - kernel scope.
D4-Q06  Corpus (synthetic proof / real quality)   OPEN - make_blocky.bat,
                                                  dump_mpeg2_info_01.bat
                                                  and the Python blockiness
                                                  analyser are the retained
                                                  instruments.
D4-Q07  One width-generic body vs two bodies      DECIDED in principle:
                                                  independent scalar oracle
                                                  + width-generic vector
                                                  body incl. N=1 leg (the
                                                  Classic pattern, applied
                                                  fresh; D4-D08 forbids
                                                  inheritance, not the
                                                  pattern).
D4-Q08  Prior-art survey                          CLOSED (section 4).
D4-Q09  Per-MB dct_type mixture vs uniform modes  CLOSED into the
                                                  architecture: per-region
                                                  phase decision, UNKNOWN
                                                  state, D4-Q14 gate.
D4-Q10  Interlaced 4:2:0 chroma vertical siting   OPEN - kernel scope
        (Fig 6-1/6-2 weighting question)          (affects tap weights,
                                                  not grid).
D4-Q11  Grid shift via motion compensation        LOGGED, deliberately NOT
                                                  solved in v1 (P3
                                                  corroborates the effect).
                                                  Nominal-grid filtering is
                                                  the v1 posture, stated
                                                  openly.
D4-Q12  Pipeline position (before deinterlace)    OPEN - documentation
                                                  guidance item.
D4-Q13  Per-MB side-data from source filters      OPEN - if a source filter
                                                  can supply dct_type maps
                                                  as frame properties, the
                                                  detector gains truth
                                                  input; investigate later.
D4-Q14  Phase separability on real material       OPEN - THE GATE. Now
                                                  strengthened to a
                                                  ground-truth experiment
                                                  (section 8).
D4-Q15  TFF/BFF relevance                         CLOSED by F7: irrelevant
                                                  to geometry; excluded.
D4-Q16  Parameter-surface redesign                OPEN - "field_separated"
                                                  name now actively invites
                                                  the forbidden input;
                                                  three-geometry vocabulary
                                                  required (D4-D02).
```

# 7. Ratified decisions (D4-D series) and the decided architecture

```text
D4-D01  WHOLE-FRAME INPUT CONTRACT (W3X, 2026-08-16). The plugin receives
        the interleaved frame plus a declared source mode. Separated-field
        input is NOT supported for MPEG-2. Basis: the SeparateFields
        tearing derivation (section 3), GAIS-confirmed but standing on our
        own geometry.
D4-D02  THREE-VALUE MODE DECLARATION replaces the current two-value
        grid_mode vocabulary: progressive / mpeg2_frame_interlaced
        (Case a) / mpeg2_field_pictures (Case b) - exact spellings to be
        settled at scope time; "field_separated" is retired as a name.
        No TFF/BFF parameter (F7).
D4-D03  SCHEDULER/KERNEL SEPARATION. The SCHEDULE decides WHERE candidate
        edges are; the KERNEL decides WHETHER each candidate edge is an
        artefact and filters it. The uncertain part (geometry) is thereby
        isolated from the provable part (mathematics).
D4-D04  DETECTOR OUTPUT IS PHASE + CONFIDENCE + EXPLICIT UNKNOWN (W3C
        design change (a), adopted). The declared mode restricts the
        candidate phase set: progressive -> {frame}; Case (b) -> {field};
        Case (a) -> {frame, field} decided per region FOR LUMA ONLY.
        Chroma in Case (a) is FORCED to the 8-consecutive frame grid with
        NO decision - the standard (F4) removes the uncertainty.
D4-D05  SPAN COMPILATION. The scheduler compiles detector output into
        GEOMETRY-HOMOGENEOUS SPANS, each carrying plane, orientation,
        phase, row pitch, parity and bounds. SIMD sees ONE geometry per
        span; phase is NEVER a per-lane decision. [DERIVED +
        SOURCE-VERIFIED consequence: no obstruction in the established
        vector patterns - pitch enters as a row-stride multiplier;
        x-direction loads stay contiguous; the four-row vertical pack
        becomes row_start + 2*lane within a field.]
D4-D06  NO HIDDEN TEMPORAL STATE IN v1 (W3C design change (b), adopted;
        W3D's casual hysteresis proposal is RETRACTED and recorded as a
        W3D error). Under fmParallel, mutable cross-frame detector state
        makes output depend on request history - non-deterministic output,
        violating the project's determinism discipline. Each frame's
        detection is a pure function of that frame plus the declared mode.
        Temporal smoothing, if ever added, is an explicitly designed frame
        dependency in its own scope. Flicker is addressed spatially
        (confidence margins, span-level decisions) until measurement says
        more is needed.
D4-D07  UNKNOWN POLICY v1: FILTER NOTHING in UNKNOWN regions, with
        diagnostic counters (W3X, 2026-08-16). Unfiltered blockiness is
        the user's status quo; wrongly-phased filtering destroys detail
        irreversibly. Revisit against ground-truth data (section 8).
D4-D08  OWN ORACLE, NOTHING INHERITED (reaffirming the standing
        never-a-basis rule; W3C design change (c), adopted; W3D's
        kernel-reuse overreach corrected). Deblock4 gets its own
        mathematics derivation, its own hand-derived fixtures, its own
        oracle and proof chain. The boundary-vs-activity gating FAMILY is
        a legitimate starting DIRECTION, derived on its own terms for the
        8x8 grid; Classic's code, proofs and thresholds transfer nothing.
        (Verified during the round: Classic's predicate gates an
        already-scheduled edge; it never chooses between grid phases.)
D4-D09  v1 FILTERS THE NOMINAL GRID ONLY. Grid-shifted inherited
        blockiness (D4-Q11) is a documented limitation, not a target.
D4-D10  SIMD IS UNAFFECTED IN PRINCIPLE (F7 companion): field-domain
        filtering changes row addressing, not lane geometry. 4D/5D-style
        vector stages remain applicable once the scalar oracle exists.

THE DECIDED ARCHITECTURE, in one paragraph: a per-frame, deterministic
three-stage pipeline. (1) DETECT - for Case (a) luma only, measure
block-boundary energy at the two candidate phases per region and emit
phase/confidence/UNKNOWN; all other plane/mode combinations have their
geometry fixed by the declared mode and the standard. (2) SCHEDULE -
compile geometry-homogeneous spans (plane, orientation, phase, pitch,
parity, bounds); UNKNOWN spans are emitted as no-filter spans with
counters. (3) FILTER - an independently derived 8x8 boundary-vs-activity
kernel processes each span at its pitch; vectorisation, when it comes,
branches at span boundaries only. The whole pipeline is gated on the
D4-Q14 ground-truth result: if measured phase separability on real
Case (a) material is inadequate, the fallback is the declared-mode uniform
grid (wrong on mixed frames, predictable, cheap) and stage (1) collapses
to a constant.
```

# 8. [PENDING] D4-Q14 ground-truth experiment - THE GATE (results land here)

```text
RATIFIED INTENT (W3X, 2026-08-16): before any kernel scope, run a
diagnostic-only experiment on real PAL MPEG-2 material: obtain
per-macroblock dct_type TRUTH from the bitstream/decoder side; compute
both candidate phase scores from decoded pixels; report confusion
matrices, confidence-margin distributions, and the false-confident rate,
across content types, QP levels and mixed-region frames. UNKNOWN-rate
statistics feed the D4-D07 revisit. Ownership per D4-D11 below.
Experiment plan: separate W3D document, to be drafted next.
RESULTS: [PENDING - this section is the landing place.]
```

# 9. [PENDING] UNKNOWN-policy revisit (results land here)

```text
D4-D07 stands until section 8 data exists. Revisit criteria: measured
UNKNOWN prevalence on representative material, and the measured cost of
each error direction. [PENDING]
```

# 10. Ownership and process for what follows

```text
D4-D11 (W3X, 2026-08-16): W3D derives the phase-detector mathematics and
the kernel mathematics (designer work, presented for ratification with
worked fixtures); W3C cross-checks the derivations and their SIMD
consequences and implements only under ratified scopes; the ground-truth
experiment validates against reality; W3X ratifies every step. The
established three-way discipline (scopes, pre-implementation rounds,
independent verification, evidence-based acceptance) applies unchanged.
```

# 11. References of record (verified only)

```text
R1  ITU-T H.262 (02/2000) - block geometry authority (F1-F5). Verbatim
    6.1.3 quotation of record: the W3C verification report, section V4.
R2  ITU-T H.264 - clause 8.7 deblocking; MBAFF mixed-boundary and chroma
    behaviour (P2).
R3  FFmpeg libpostproc public interface documentation - basis of the P1
    refutation (examined 2026-08-16; details in the W3C report, V1).
R4  VapourSynth API v4 documentation - fmParallel concurrency semantics
    underlying D4-D06.
R5  Changick Kim, adaptive post-filtering paper, Signal Processing: Image
    Communication (2002) - D4-Q11 corroboration (P3).
DISCREDITED - DO NOT CITE (Appendix A carries the full calibration list):
    all five GAIS patent citations; the "1999 Kim/Kim/Cho IEEE TCE" paper.
EVIDENCE FILES (raw, this document prevails):
    GAIS_MPEG2_GRID_CONFIRMATION_RESPONSE.txt (2026-08-12);
    the two GAIS answer captures of 2026-08-16;
    Deblock4_D4_W3C_Verification_and_Design_Review_v1_0.md.
```

# Appendix A - Full GAIS citation calibration table

```text
CITED (round 1): US 6,633,612 "Sony adaptive post-filter"
  ACTUAL: Faroudja/Genesis DCDi motion-detection patent.     REFUTED
CITED (round 1): US 7,139,437 "Microsoft deblocking interlaced"
  ACTUAL: Eastman Kodak.                                     REFUTED
CITED (round 2, "Fully Verified"): US 6,167,157 "Sony/Ohta"
  ACTUAL: JVC / Takayuki Sugahara.                           MISATTRIBUTED
CITED (round 2, "Fully Verified"): US 7,031,552 "LSI/Winger"
  ACTUAL: Changick Kim / Seiko Epson.                        MISATTRIBUTED
CITED (round 2, "Fully Verified"): US 6,983,079 "Samsung/Kim"
  ACTUAL: Changick Kim / Seiko Epson.                        MISATTRIBUTED
CITED: Kim/Kim/Cho 1999, IEEE Trans. Consumer Elec. 45(3)
  ACTUAL: absent from indexed issue metadata.                REFUTED
CITED: Han/Kim 2002, IEEE TCSVT, MPEG-2 post-filtering
  ACTUAL: distortion of single-author C. Kim 2002, Signal
  Processing: Image Communication (real; = R5).              DISTORTED
Round-2 claim to have "analyzed the source code of libpostproc":
  refuted by P1.                                             REFUTED
```

# Appendix B - Terminology

```text
Case (a)      MPEG-2 FRAME PICTURE in which macroblocks may individually
              select field DCT (dct_type). Luma may be field-organised
              per macroblock; 4:2:0 chroma is ALWAYS frame-organised (F4).
Case (b)      MPEG-2 FIELD PICTURES: each coded picture is one field.
              All planes field-organised.
Phase         Which candidate grid the blockiness energy sits on:
              8-row-consecutive (frame) vs 16-frame-row staggered (field).
Pitch         Row stride of filtering taps in frame coordinates: 1 (frame-
              organised) or 2 (within one field of an interleaved frame).
Span          A geometry-homogeneous scheduling unit: plane, orientation,
              phase, pitch, parity, bounds (D4-D05).
UNKNOWN       Detector state meaning "phase not established with adequate
              confidence"; v1 policy: filter nothing there (D4-D07).
Tearing       Destruction of frame-organised block integrity by
              SeparateFields (section 3).
```

---

*Revision history*
```text
v1.00 (2026-08-16) First issue as the prevailing single source of truth for
      MPEG-2 deblocking matters: verified geometry facts F1-F7 (G1 closed
      via the W3C verification round against ITU-T H.262 (02/2000)); the
      three-geometry case table and the SeparateFields tearing derivation;
      prior-art results P1-P4 including the libpostproc refutation and the
      MBAFF verification with corrected clause detail; the complete GAIS
      engagement record and calibration verdict with the standing
      reasoning-aid-only rule; issue register D4-Q01..Q16 with
      dispositions; ratified decisions D4-D01..D4-D11 and the decided
      three-stage architecture (detect / schedule-into-spans / filter),
      gated on the D4-Q14 ground-truth experiment; pending-results
      placeholders (sections 8-9); references of record and the
      discredited-citation appendix. Supersedes
      Deblock4_MPEG2_Grid_Field_DCT_Knowledge_v1_2.md.
```
