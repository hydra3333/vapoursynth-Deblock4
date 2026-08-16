# Deblock4 - MPEG-2 Deblocking: Investigation Results, Architecture and Decision Record

**Document:** Deblock4_MPEG2_Deblocking_Investigation_and_Decided_Architecture
**Version:** 1.03
**Date:** 2026-08-16
**Author:** W3C consolidation proposal, based on W3D v1.02 and the W3X/W3D/W3C decision record
**Status:** PROPOSED SUCCESSOR TO v1.02 FOR W3D REVIEW AND W3X RATIFICATION.
After ratification this document is intended to become the PREVAILING SINGLE
SOURCE OF TRUTH for MPEG-2 deblocking matters in Deblock4. Until ratified,
v1.02 remains the prevailing document. No new repository or algorithmic
implementation authority is claimed merely by issuing this draft.

**Single-source intent after ratification:**
- verified MPEG-2 geometry facts, measurements, architecture mathematics,
  decisions, open questions, quality gates and implementation-facing MPEG-2
  requirements live HERE;
- other current documents should retain only short pointers where they need to
  mention MPEG-2-specific matters;
- raw GAIS captures, W3C verification/re-decision reports and standards/source
  extracts remain EVIDENCE, not competing design authorities;
- global project rules that are not MPEG-2-specific (charter, tiering,
  ownership, delivery, general SIMD/toolchain rules) remain in their existing
  authorities and are referenced rather than duplicated here.

**Supersession intent after ratification:** this document absorbs and supersedes
`Deblock4_MPEG2_Grid_Field_DCT_Knowledge_v1_2.md`. The MPEG-2-specific content
still present in `README_Deblock4_Design_Spec_v1_12.md`, the concise summary,
roadmap, status/orientation files and current Stage-1C parameter descriptions
should then be reduced to references to this document as part of the planned
currency/consolidation pass. Historical scope/evidence files remain historical.

**Provenance discipline:**
- `[H.262-VERIFIED]` - read in authoritative ITU-T H.262 text by W3C;
- `[SPEC-VERIFIED]` - read in another published standard/API;
- `[SOURCE-VERIFIED]` - read in named source code;
- `[MEASURED]` - project measurement on named material/tooling;
- `[DERIVED]` - reasoned from verified facts and ratified by W3X where marked;
- `[PENDING]` - evidence/decision not yet produced;
- `[W3C-PROPOSED]` - recommendation in this v1.03 draft that requires explicit
  W3D/W3X review/ratification before it becomes a project decision.

Nothing in this document rests on unverified GAIS testimony.

**Encoding:** US-ASCII; CRLF.

---

# 0. CURRENT ARCHITECTURE POSITION - READ THIS FIRST

```text
STATUS AT 2026-08-16

No Deblock4 filtering mathematics is implemented. The live Deblock4 frame path
is a validated writable-copy/pass-through shell. No D4 pixel-kernel scope is
open. The next substantive artifact is the D4-Q14 architecture-discriminator
EXPERIMENT, not a filtering implementation.

SETTLED AND NOT RE-OPENED
------------------------
1. WHOLE-FRAME INPUT ONLY for MPEG-2. The plugin receives the reconstructed,
   interleaved frame plus a declared source mode. SeparateFields input is not a
   supported MPEG-2 contract because it tears frame-organised transform blocks
   between two clips. [D4-D01]

2. THREE SOURCE-MODE SEMANTICS are required:
      progressive
      MPEG-2 frame picture / interlaced content (Case a)
      MPEG-2 field pictures (Case b)
   Exact public tokens remain a D4-Q16 parameter-surface decision. The old
   `mpeg2_field_separated` name is retired in principle. TFF/BFF is not a grid
   parameter because field order does not move transform-block boundaries.
   [D4-D02, F7]

3. 4:2:0 CHROMA CASE-(a) GEOMETRY IS NORMATIVE, NOT DETECTED. In a FRAME
   PICTURE, 4:2:0 chroma transform blocks stay frame-organised even when luma
   macroblocks use field DCT. 4:2:2 and 4:4:4 chroma FOLLOW the luma DCT
   organisation and therefore cannot inherit the 4:2:0 simplification. [F4]

4. LUMA CASE-(a) IS THE HARD GEOMETRY. `dct_type` is macroblock-level and may
   vary within one frame picture. A post-decode pixel filter does not know that
   bit unless trusted side data is supplied. [F5, F6]

5. VERTICAL TRANSFORM-BLOCK EDGES ARE GEOMETRY-INVARIANT. Frame-vs-field DCT
   changes HORIZONTAL row adjacency only. Luma vertical boundaries remain at
   x = 8*k and filter across columns within a row. No parity split or DCT-phase
   classification is required for vertical luma filtering. The same principle
   applies to plane-relative vertical block boundaries in chroma. [D4-D12]

6. NO HIDDEN TEMPORAL STATE in v1. Detector output for a frame is a pure
   function of that frame, its immutable parameters and declared source mode.
   No previous-call/request-history hysteresis under fmParallel. [D4-D06]

7. DEBLOCK4 GETS ITS OWN ORACLE, MATHEMATICS AND PROOF CHAIN. Classic may
   supply engineering patterns only. Classic code, thresholds, formulas and
   acceptance evidence are not a Deblock4 design/acceptance basis. [D4-D08]

8. v1 FILTERS NOMINAL TRANSFORM-GRID BLOCKINESS ONLY. Motion-predicted or
   inherited blockiness shifted away from the nominal current-frame transform
   grid is a documented limitation. [D4-D09, D4-Q11]

PRIMARY ARCHITECTURE CANDIDATE - B2
-----------------------------------
9. In Case (a), classify the natural MPEG-2 unit: each 16x16 LUMA macroblock
   receives runtime detector state FRAME / FIELD / UNKNOWN plus confidence.
   Then DERIVE EDGE TOPOLOGY; do not assign an arbitrary region a generic
   phase:

      internal horizontal edge at mb_y + 8:
          FRAME   -> one pitch-1 edge
          FIELD   -> no edge
          UNKNOWN -> current v1 policy: no edge, count it

      macroblock-row boundary at mb_y + 16, per 16-pixel x segment:
          FRAME / FRAME -> one pitch-1 edge
          FIELD / FIELD -> two pitch-2 parity edges
          FRAME / FIELD -> two pitch-2 mixed-boundary edges
          FIELD / FRAME -> two pitch-2 mixed-boundary edges
          UNKNOWN involved -> current D4-D07 policy: no filtering for that
                              unresolved segment; count it; revisit after Q14

   The mixed boundary is therefore an EXPLICIT EDGE TYPE, not a detector seam.
   [D4-D12]

10. The B2 macroblock map is produced only where geometry is genuinely unknown:
      progressive                       -> fixed frame geometry; no detector
      Case (b) field pictures           -> fixed field geometry; no detector
      Case (a) luma                     -> B2 detector/map
      Case (a) 4:2:0 chroma            -> fixed frame geometry from H.262 F4
      Case (a) 4:2:2 / 4:4:4 chroma    -> FOLLOW the resolved luma macroblock
                                           organisation; no independent chroma
                                           detector is required

11. Compile the topology into geometry-homogeneous work spans/jobs. The span is
    the SIMD scheduling unit. Classification is never a per-lane SIMD branch.
    Horizontal span descriptors carry at least plane, x bounds, edge row,
    edge kind, pitch and parity where applicable. Vertical work does not gain a
    fake pitch-2/parity split merely because neighbouring luma macroblocks were
    field-DCT. [D4-D05 reconciled by D4-D12]

MANDATORY DETECTOR-FREE FALLBACK/COMPARATOR - ARCHITECTURE D
------------------------------------------------------------
12. For Case-(a) luma, D uses whole-frame topology without a classifier:
      vertical edges:              x = 8*k, normal within-row filtering
      macroblock-row boundaries:   always two pitch-2 parity edges
      internal mb_y+8 candidate:   one TRUE pitch-1 candidate, tested
                                    conservatively; an A-derived threshold-
                                    scaling IDEA may be measured here
   D is deterministic and has no UNKNOWN state. Its known approximation is
   FRAME/FRAME macroblock-row boundaries: it uses the conservative pitch-2
   pair instead of the exact pitch-1 frame edge. [D4-D12]

REJECTED ARCHITECTURES
----------------------
13. Architecture A - the old separated-field step-4 primary/midpoint union - is
    REJECTED as the primary whole-frame architecture. Its elegant union property
    depended on separated-field coordinates. In the woven frame, frame-DCT and
    field-DCT horizontal edges have different sample adjacency and footprints.
    A literal transposition tests the wrong frame-DCT edge; a faithful union of
    both real geometries creates overlapping/double-written operations at
    macroblock-row boundaries. Its local-threshold false-activation tradeoff is
    also irreducible in principle. Appendix C contains the exact derivation.

14. Architecture C - motion-based frame-vs-field classification - remains
    REJECTED. Static field-DCT material can make motion metrics ambiguous while
    the transform boundary geometry remains different.

NEXT GATE - D4-Q14
------------------
15. Before any pixel-kernel scope, run a ground-truth architecture-discriminator
    experiment on representative target MPEG-2. Extract bitstream-side truth and
    compare:
      B2 -> classification/confidence/UNKNOWN/false-confident behaviour;
      D  -> true-boundary vs false-candidate feature separation and the cost of
            D's conservative topology.
    NO_DCT/skipped/motion-only macroblocks are their own truth class; they are
    never fabricated into FRAME/FIELD labels.

16. [W3C-PROPOSED safety correction to v1.02] The experiment must not encode a
    forced binary outcome "B2 fails => D ships". The architecture entering the
    later kernel scope must itself meet predeclared viability criteria:
      - if B2 is viable, B2 proceeds;
      - if B2 is not viable and D is viable, D proceeds;
      - if neither is viable, REOPEN architecture rather than force a bad
        fallback.
    The experiment selects the architecture to TAKE INTO KERNEL/QUALITY WORK; it
    cannot by itself make an unimplemented filter "ship".

STILL OPEN AFTER THE ARCHITECTURE GATE
--------------------------------------
17. Luma kernel mathematics; exact luma footprint/eligibility; threshold design;
    UNKNOWN-policy revisit; proper-chroma vertical siting; processing-order
    Schedule-SA vs Schedule-SB quality winner; proper-chroma quality gate;
    pipeline guidance; side-data interface; final public parameter/property
    surface; scalar oracle; later SIMD backends.
```

---

# 1. PURPOSE, AUTHORITY BOUNDARY AND TERMINOLOGY

Deblock4 is the project's MPEG-2-aware deblocking filter, initially aimed at PAL
576i material recorded by consumer DVD recorders. The purpose of this document
is to hold the complete current MPEG-2-specific knowledge and design state so a
successor designer/coder does not have to reconstruct it from the README,
old grid notes, GAIS captures and chat history.

This document deliberately separates four kinds of statements:

```text
CODEC FACT       what MPEG-2/H.262 actually signals/organises
PIXEL GEOMETRY   where the reconstructed-frame block boundaries/taps are
ARCHITECTURE     how Deblock4 decides/schedules candidate edges
KERNEL           whether/how a scheduled candidate is filtered
```

Confusing these layers caused several earlier design errors.

Classic is referenced only for engineering contrast. The standing rule remains:
nothing in Classic's algorithm or vector source is a Deblock4 design or
acceptance basis.

## 1.1 Avoid the A/B naming collision

Two unrelated historical A/B pairs exist:

```text
Architecture A / B / C / D
    = MPEG-2 GEOMETRY-ARCHITECTURE alternatives in the 2026-08-16 re-decision.

Processing Schedule A / B / C in the old README
    = ORDER OF FILTERING already-selected edges.
```

This document calls the latter **Schedule-SA**, **Schedule-SB** and
**Schedule-SC** to prevent accidental conflation.

## 1.2 Coordinate convention

Unless explicitly stated otherwise:

```text
e = first sample on the q side of an edge
k,m = non-negative integer grid indices
p = woven-frame row parity, p in {0,1}
s = row pitch of a horizontal filter footprint in frame-memory rows
```

All chroma coordinates are in that chroma plane's own sample grid. Never derive
a chroma block step mechanically by dividing a luma step by subsampling.

---

# 2. VERIFIED MPEG-2 BLOCK-GEOMETRY FACTS - F SERIES

```text
F1  [H.262-VERIFIED]
    The DCT operates on 8x8 blocks of SAMPLES in the coded plane. An 8x8
    chroma block is eight chroma samples by eight chroma samples, not an
    8x8 luma-coordinate rectangle.

F2  [H.262-VERIFIED]
    Block coordinates are plane-relative. In 4:2:0, one 8x8 chroma block
    spans the area corresponding to 16x16 luma samples, but the transform
    still acts on 8x8 actual chroma samples.

F3  [H.262-VERIFIED]
    Blocks per macroblock:
        4:2:0 -> 4 Y + 1 Cb + 1 Cr = 6
        4:2:2 -> 4 Y + 2 Cb + 2 Cr = 8
        4:4:4 -> 4 Y + 4 Cb + 4 Cr = 12

F4  [H.262-VERIFIED - CENTRAL ASYMMETRY]
    For a FRAME PICTURE in 4:2:0, chrominance blocks SHALL remain organised
    in frame structure for DCT coding even when the luma macroblock uses
    field DCT. In 4:2:2 and 4:4:4, chroma follows the luma frame/field DCT
    organisation.

F5  [H.262-VERIFIED]
    `dct_type` is macroblock-level syntax where applicable. With
    frame_pred_frame_dct == 0, relevant coded macroblocks in one frame
    picture may choose frame or field DCT independently. With
    frame_pred_frame_dct == 1, frame DCT organisation is forced/inferred.
    Macroblocks with no coded transform residual do not necessarily carry a
    meaningful `dct_type` bit and MUST NOT be fabricated into a truth class
    merely to make an experiment table rectangular.

F6  [DERIVED]
    A normal post-decode VapourSynth filter sees reconstructed pixels, not the
    MPEG-2 macroblock syntax. It cannot KNOW per-macroblock dct_type unless a
    trusted decoder/source supplies side data. Pixel inference and bitstream
    truth are different things.

F7  [DERIVED]
    TFF/BFF changes temporal field order, not spatial transform-block
    boundary locations. It is not a Deblock4 grid parameter.

F8  [DERIVED]
    Frame-vs-field DCT changes vertical SAMPLE ADJACENCY for HORIZONTAL
    edges. It does not move vertical block columns. Vertical luma edges stay
    at x=8*k and filter across columns within one row.
```

The H.262 quotation of record and exact clause discussion remain in
`Deblock4_D4_W3C_Verification_and_Design_Review_v1_0.md` section V4.

---

# 3. PICTURE/SYNTAX REGIMES AND GROUND-TRUTH SEMANTICS

The cheap picture-level flags are useful for corpus triage but are not a
runtime substitute for per-macroblock truth.

```text
Case                         picture_structure / flag         Geometry knowledge
--------------------------   ------------------------------   --------------------
progressive/frame geometry   frame picture                    fixed frame grid

frame picture, forced        frame_pred_frame_dct = 1         frame DCT forced;
frame DCT                                                       no field-DCT choice

frame picture, adaptive      frame_pred_frame_dct = 0         per-MB dct_type MAY
Case (a)                                                       vary where signalled

field pictures, Case (b)     picture_structure = top/bottom   field geometry is
                                                               inherent to picture
```

Important qualification:

`frame_pred_frame_dct = 0` means that per-macroblock adaptation is PERMITTED.
It does **not** prove that a particular picture actually contains both FRAME and
FIELD macroblocks. D4-Q14 must extract per-MB ground truth to answer that.

## 3.1 Cheap regime triage with MediaInfo [MEASURED tool usage]

The older grid-knowledge work proved the following useful inspection route on
the project toolchain:

```cmd
mediainfo --Details=1 <file.mpg> | findstr /C:"frame_pred_frame_dct" /C:"picture_structure"
```

Use it to triage/categorise corpus material, not to generate B2 ground truth.
MediaInfo/ffprobe do not provide the required labelled per-macroblock dct_type
map for the experiment.

---

# 4. WHOLE-FRAME GEOMETRY MATHEMATICS

This section freezes the architecture geometry, not the still-open final luma
kernel mathematics.

## 4.1 Generic horizontal-edge row-pitch notation

For the six-sample luma footprint used in the architecture/transposition
analysis, with pitch `s`:

```text
p2 = e - 3*s
p1 = e - 2*s
p0 = e - 1*s
q0 = e
q1 = e + 1*s
q2 = e + 2*s

R_s(e) = { e-3s, e-2s, e-s, e, e+s, e+2s }
W_s(e) = { e-2s, e-s, e, e+s }
```

`R_s/W_s` are the CURRENT architecture-analysis footprint used to prove that
old Architecture A does not transpose faithfully. D4-Q02/Q04 still own the
final Deblock4 luma formula and final footprint; if the future kernel footprint
changes, its bounds/proofs are re-derived. The pitch-1 versus pitch-2 adjacency
distinction itself does not depend on the eventual exact filter coefficients.

## 4.2 Frame-organised luma

Horizontal transform-block edges:

```text
e = 8*k
s = 1
```

Example edge before frame row 8:

```text
reads  rows 5,6,7 | 8,9,10
writes rows 6,7,8,9
```

Within one 16-row luma macroblock beginning at `M = 16*m`:

```text
internal block edge:       e = M + 8
macroblock-row boundary:   e = M + 16
```

Both are pitch 1 when the relevant topology is FRAME/FRAME.

## 4.3 Field-organised luma in a woven frame

Map field-row index `r` to frame row:

```text
y = 2*r + p,  p in {0,1}
```

A boundary every 8 field rows becomes, per parity:

```text
e = 16*k + p
s = 2
```

Six-tap footprint:

```text
e-6, e-4, e-2 | e, e+2, e+4
```

Example at the macroblock-row boundary around row 16:

```text
even/top parity edge: e = 16
odd/bottom parity edge: e = 17
```

TFF/BFF does not alter these spatial row sets.

## 4.4 Vertical luma edges

For FRAME and FIELD DCT alike:

```text
x = 8*k
```

Filtering is across columns within each row. There is no `s=2` vertical-row
footprint simply because the macroblock used field DCT. This corrects an early
pre-B2 W3C SIMD description that suggested a parity-split vertical four-row
pack; that description is RETIRED.

## 4.5 4:2:0 chroma

All coordinates below are CHROMA-PLANE coordinates.

Progressive and Case-(a) FRAME PICTURES:

```text
horizontal chroma block edges: e_c = 8*k, pitch 1
vertical chroma block edges:   x_c = 8*k
```

There is NO luma-style midpoint/phase ambiguity in 4:2:0 Case (a).

Case (b) FIELD PICTURES represented as a woven frame use field adjacency, hence
pitch 2 in frame-memory rows for horizontal chroma filtering.

## 4.6 4:2:2 and 4:4:4 chroma

F4 is explicitly 4:2:0-specific. For Case (a), 4:2:2 and 4:4:4 chroma follow
the luma macroblock's FRAME/FIELD DCT organisation. The B2 luma classification
map therefore also controls their frame/field chroma topology, transformed into
that chroma plane's own coordinates. There is no need for an independent
chroma classifier, but there is also no legal "always frame" simplification.

Exact per-format chroma scheduler tables and D4-Q10 vertical-siting consequences
remain to be frozen in the later kernel/scheduler scope; do not guess them from
luma subsampling ratios.

---

# 5. SEPARATEFIELDS TEARING DERIVATION - WHY D4-D01 IS NON-NEGOTIABLE

[DERIVED]

`SeparateFields` sends alternate rows to different clips.

A frame-organised 8-row transform block therefore becomes:

```text
field clip 0: four rows from that transform block
field clip 1: four rows from that transform block
```

No single field-clip filter instance has the original eight consecutive rows.
For Case-(a) 4:2:0 chroma this is fatal because H.262 F4 says the chroma DCT
block remains frame-organised even while luma may be field-organised.

The same problem exists for progressive/frame-DCT geometry. Therefore
SeparateFields cannot be the general MPEG-2 input contract. Whole-frame input
is a codec-geometry correctness requirement, not a performance preference.

---

# 6. MEASURED TARGET MATERIAL - WHY THE ADAPTIVE REGIME MATTERS

These measurements are absorbed from
`Deblock4_MPEG2_Grid_Field_DCT_Knowledge_v1_2.md`. They survive because they
are real target-corpus evidence that would otherwise be lost when that document
is superseded.

## 6.1 Broadcast OTA capture [MEASURED]

`home_576i.mpg`:

```text
720x576, 4:2:0, interlaced frame pictures, about 5.2 Mb/s
317 sampled pictures:
    picture_structure = Frame
    frame_pred_frame_dct = No / 0
```

Correct interpretation in the new architecture:

- all sampled pictures are in the regime where per-MB dct_type ADAPTATION IS
  PERMITTED;
- this does NOT prove the pictures actually contain both dct_type values;
- it strongly justifies extracting per-MB truth rather than assuming uniform
  frame-DCT geometry.

`home_576p.mpg` is a progressive control.

## 6.2 LG VHS-to-DVD recorder - target device [MEASURED]

The earlier measurement record gives:

```text
mode   nominal duration   resolution   approx bitrate   frame_pred_frame_dct
XP     1 hour             720x576      ~2.8 Mb/s        No / 0
SP     2 hour             720x576      ~2.8 Mb/s        No / 0
LP     4 hour             720x576      ~2.6 Mb/s        No / 0
EP     6 hour             352x576      ~1.8 Mb/s        No / 0
MLS    ~14 hour           352x288      ~0.7 Mb/s        Yes / 1
```

The practical restoration modes XP/SP/LP/EP therefore permit adaptive per-MB
DCT organisation. MLS is a useful uniform-frame-DCT control.

Again: `No / 0` proves capability/regime, not actual mixture. D4-Q14 exists to
measure the real per-MB distribution.

## 6.3 Corpus consequence

The Q14/quality corpus should preserve at least:

```text
uniform frame-DCT control:  LG MLS
adaptive-capable target:    LG XP/SP/LP/EP
adaptive-capable OTA:       home_576i
progressive control:        home_576p
```

The target-device measurements make the B2/D decision a real restoration
problem, not a theoretical codec corner case.

---

# 7. PRIOR ART AND EXTERNAL VERIFICATION - WHAT ACTUALLY SURVIVED

```text
P1  [SOURCE-VERIFIED, REFUTING GAIS]
    Examined FFmpeg libpostproc did not expose the alleged interlaced
    deblocking flag that field-splits both luma and chroma by doubling stride.
    `pict_type` carries QP semantics (`PP_PICT_TYPE_QP2`); Y/U/V are passed at
    ordinary per-plane strides. Therefore libpostproc is not evidence for the
    wrong Case-(a) 4:2:0 chroma treatment.

P2  [SPEC-VERIFIED]
    H.264 clause 8.7 MBAFF genuinely defines mixed frame/field boundary
    filtering with field-spaced sample addressing. Chroma follows MBAFF's
    macroblock-pair frame/field geometry; there is no MPEG-2-F4 chroma
    asymmetry. The useful carry-forward is the CONCEPT that a mixed boundary
    can be an explicit topology, not the H.264 algorithm itself.

    Corrected GAIS details:
      8.7.2.2 = "Derivation process for the thresholds for each block edge";
      no 2x2 chroma deblocking-edge concept was found in clause 8.7.

P3  [SOURCE/PUBLICATION-VERIFIED]
    Changick Kim, "Adaptive post-filtering for reducing blocking and ringing
    artifacts in low bit-rate video coding", Signal Processing: Image
    Communication 17(7), 2002, records that inter-frame prediction can
    propagate prior blocking artifacts to non-nominal positions. This supports
    D4-Q11's documented shifted-grid limitation.

P4  [DERIVED]
    No verified prior art from the investigation was found that directly solves
    MPEG-2 Case-(a) 4:2:0 luma/chroma grid divergence. This is NOT a claim that
    no such prior art exists.
```

---

# 8. GAIS ENGAGEMENT AND CALIBRATION RULE

GAIS was useful as an option-generation/reasoning instrument but failed as a
citation/factual authority. The adopted standing rule is:

```text
No GAIS factual claim, quotation or citation enters project knowledge without
independent verification. GAIS raw outputs remain evidence captures only.
This document, after ratification, prevails on MPEG-2 design facts.
```

Useful reasoning ideas retained after independent assessment included:

- Case-(a) versus Case-(b) framing;
- static field-DCT failure of motion-only classifiers;
- texture/noise masking and classifier-flicker failure modes;
- direct phase/energy measurement as an option family;
- grid-shift warning, later independently corroborated by P3.

Discredited citation set:

```text
US 6,633,612     claimed Sony adaptive post-filter     -> wrong attribution/use
US 7,139,437     claimed Microsoft interlaced         -> actually Eastman Kodak
US 6,167,157     claimed Sony/Ohta                    -> JVC / T. Sugahara
US 7,031,552     claimed LSI/Winger                   -> C. Kim / Seiko Epson
US 6,983,079     claimed Samsung/Kim                  -> C. Kim / Seiko Epson
Kim/Kim/Cho 1999 IEEE TCE 45(3)                       -> absent from indexed issue
Han/Kim 2002 IEEE TCSVT MPEG-2                         -> distorted citation;
                                                         real source is P3
```

The detailed calibration record remains in the W3C verification report and raw
GAIS evidence files.

---

# 9. ARCHITECTURE OPTIONS AND THE RE-DECISION

## 9.1 Architecture A - old separated-field union grid - REJECTED

Original design:

```text
separated-field luma candidate row step = 4 field rows
primary:   r mod 8 == 0
midpoint:  r mod 8 == 4
```

Both position classes used the same local activation family. Midpoint `alpha`
and `beta` were scaled once at creation:

```text
S = round_half_up(midpoint_threshold_scale * 65536)
scale_threshold(t,S) = (i64(t)*i64(S) + 32768) >> 16
```

`tc0` and the one-sample correction addition were deliberately not scaled, so a
midpoint that activated was corrected at normal strength.

Good engineering ideas retained from A:

- creation-time fixed-point conversion;
- immutable threshold sets;
- no float/multiply in the pixel loop;
- deterministic/stateless operation;
- uncertainty should be measurable and explicit.

The geometry mechanism itself is rejected. Appendix C gives the exact proof.

## 9.2 Architecture B - generic region phase - SUPERSEDED BY B2

The first 2026-08-16 design used:

```text
measure two phase energies per region -> phase + confidence + UNKNOWN
-> compile geometry spans -> filter
```

The good detector/pre-pass/span ideas survive. The vague "region phase" model
did not say enough about mixed macroblock-row boundaries and encouraged an
incorrect parity-split interpretation of vertical SIMD. B2 replaces it with
macroblock topology.

## 9.3 Architecture B2 - PRIMARY CANDIDATE

B2 separates four layers:

```text
A. MODE POLICY
   declared source mode determines whether geometry is fixed or needs Case-(a)
   inference.

B. MAP PRODUCER
   for uncertain Case-(a) luma only:
       pixels -> FRAME / FIELD / UNKNOWN + confidence
   Future trusted decoder side-data may replace/bypass the pixel detector
   without changing the downstream topology contract.

C. EDGE-TOPOLOGY COMPILER / SPAN SCHEDULER
   macroblock states -> exact horizontal edge kinds -> geometry-homogeneous
   spans/jobs. Vertical transform edges remain uniform.

D. DEBLOCK4-OWNED EDGE PREDICATE + KERNEL
   independently decide whether a scheduled candidate is an artifact and apply
   the independently derived Deblock4 mathematics.
```

This keeps "where is the transform edge?" separate from "does this local edge
look like a compression artifact?".

## 9.4 Architecture C - motion classifier - REJECTED

Motion similarity is not a reliable dct_type classifier. Static field-DCT
content can have little frame/field motion difference while the block geometry
is still field-organised. It can therefore miss real staggered boundaries and
probe non-boundaries simultaneously.

## 9.5 Architecture D - detector-free topology-aware fallback/comparator

D was created during the re-decision as a better detector-free fallback than
literal old A. It uses the actual whole-frame internal frame edge and avoids
A's competing pitch-1/pitch-2 union collision.

Its exact Case-(a) luma topology is in section 11.

---

# 10. B2 MACROBLOCK-TOPOLOGY MATHEMATICS

Let one luma macroblock row begin at:

```text
M = 16*m
```

Each macroblock occupies a 16-pixel x segment. A horizontal boundary descriptor
is owned exactly once for each half-open x interval `[16*n,16*(n+1))`; adjacent
segments may be coalesced only when their resolved edge kind/geometry match.

## 10.1 Internal edge at M+8

```text
macroblock state FRAME:
    edge e = M + 8
    pitch s = 1

macroblock state FIELD:
    no transform edge at M + 8

macroblock state UNKNOWN:
    current D4-D07 v1 policy: no filter; increment diagnostics
```

This is the most direct observable difference between FRAME and FIELD topology.

## 10.2 Macroblock-row boundary at M+16

Let `U` be the macroblock above and `L` the macroblock below for the same x
segment.

```text
U       L       B2 horizontal topology at e=M+16
-----   -----   ---------------------------------------------
FRAME   FRAME   one pitch-1 edge at e
FIELD   FIELD   pitch-2 edge at e plus pitch-2 edge at e+1
FRAME   FIELD   pitch-2 edge at e plus pitch-2 edge at e+1
FIELD   FRAME   pitch-2 edge at e plus pitch-2 edge at e+1
UNKNOWN any     current v1 policy: unresolved -> no filtering
any     UNKNOWN current v1 policy: unresolved -> no filtering
```

The mixed rule is an independently adopted Deblock4 topology choice, informed
by the verified H.264 MBAFF concept but not inherited from H.264 code/math.
It must be covered explicitly by Q14 truth statistics and later scalar quality
fixtures.

## 10.3 Why B2 eliminates the old "seam" ambiguity

A change from FRAME to FIELD classification is not a region boundary that the
filter hopes will behave. It is input to a table that creates one explicit
boundary type. The scheduler performs exactly ONE chosen topology for that
16-pixel segment; it never schedules competing pitch-1 and pitch-2 hypotheses
on the same samples.

## 10.4 UNKNOWN remains asymmetric in cost

Current D4-D07 is intentionally conservative:

```text
UNKNOWN -> leave blockiness unchanged rather than apply a confidently wrong
           geometry that may blur real detail.
```

That is a current policy, not a timeless truth. Section 15 requires a revisit
after measured UNKNOWN prevalence/error costs are known.

---

# 11. ARCHITECTURE D - EXACT DETECTOR-FREE FALLBACK

For Case-(a) luma:

```text
VERTICAL:
    x = 8*k
    geometry-invariant; process normally

HORIZONTAL MACROBLOCK-ROW BOUNDARY:
    e = 16*k
    always process the two field-compatible pitch-2 parity edges:
        e,   s=2
        e+1, s=2

HORIZONTAL INTERNAL CANDIDATE:
    e = 16*k + 8
    one actual pitch-1 candidate, s=1
    use a conservative local activation policy; an A-derived alpha/beta
    threshold scale is an experiment candidate, not yet a public parameter
```

D is exact for field/field macroblock-row boundaries and naturally conservative
for mixed boundaries. It is approximate for frame/frame macroblock-row
boundaries because the true topology there is one pitch-1 edge.

D therefore has no classifier failure mode but does have two measurable quality
risks:

1. false activation at the internal pitch-1 candidate in a FIELD macroblock;
2. quality difference from using pitch-2 rather than exact pitch-1 at a
   FRAME/FRAME macroblock-row boundary.

D must earn viability; it is not an automatic fallback simply because it is
simpler.

---

# 12. ARCHITECTURE A TRANSPOSED TO WHOLE-FRAME COORDINATES - REJECTION PROOF

This section is intentionally detailed because the old A design was once
ratified and must not be accidentally rediscovered as "forgotten good design"
without the reason it was rejected.

## 12.1 Literal transposition of old A

In one separated field, old A tested candidate field rows:

```text
r = 4*j
primary:  r = 8*k
midpoint: r = 8*k + 4
```

Map to frame row `e = 2*r + p`:

```text
all literal-A candidates: e = 8*j + p, s=2
primary:                  e = 16*k + p
midpoint:                 e = 16*k + 8 + p
```

For p=0:

```text
8,16,24,32,...
```

For p=1:

```text
9,17,25,33,...
```

Every literal-A operation is pitch 2.

## 12.2 Counterexample: true frame-DCT edge before row 8

Actual frame-DCT edge:

```text
e = 8, s=1
reads  5,6,7 | 8,9,10
writes 6,7,8,9
```

Literal A instead schedules:

```text
even projection: e=8, s=2
    reads  2,4,6 | 8,10,12
    writes 4,6,8,10

odd projection: e=9, s=2
    reads  3,5,7 | 9,11,13
    writes 5,7,9,11
```

Neither projection filters the actual adjacent p0/q0 pair 7/8. Therefore literal
A is not a faithful coordinate transposition of the whole-frame frame-DCT edge.
It is a different filtering algorithm.

## 12.3 Faithful union of actual frame and field hypotheses collides

At e=16, a faithful union would schedule:

```text
frame hypothesis F: e=16, s=1
    W1(16) = {14,15,16,17}

even-field hypothesis E: e=16, s=2
    W2(16) = {12,14,16,18}

odd-field hypothesis O: e=17, s=2
    W2(17) = {13,15,17,19}
```

Overlaps:

```text
F intersect E = {14,16}
F intersect O = {15,17}
```

Every frame-edge output pixel can also be written by one field hypothesis if
both hypotheses activate. Their read footprints overlap as well, so canonical
order changes later decisions/output.

The old statement "test the union and let the local edge gate decide" therefore
no longer defines a simple candidate superset; it creates a new double-filter
algorithm requiring mutual exclusion, competition or a composite kernel. The
architecture was rejected rather than silently inventing that algorithm.

## 12.4 Candidate-count cost

Per 16 frame rows, literal A performs four pitch-2 horizontal operations
(two parities at two candidate positions) whereas the true FRAME or FIELD
geometry needs two horizontal operations. Its basic horizontal candidate cost
is therefore about 2x before activation rejection.

A faithful actual-geometry union likewise contains four hypotheses for two true
operations in a pure FRAME or pure FIELD region.

## 12.5 In-principle local false-activation limit

For a harmless non-block step and a true compression seam that present the
same local samples:

```text
p2,p1,p0 = A,A,A
q0,q1,q2 = A+d,A+d,A+d
```

side activity is zero. A canonical boundary-vs-side-activity gate reduces to a
condition of the form:

```text
d < alpha_candidate
and side-flatness tests pass
```

No threshold can distinguish two different causes that generate the identical
sample tuple. Lowering the candidate threshold trades false positives for weak
seam misses; raising it trades the other way. Threshold scaling can tune the
trade, not eliminate it.

This is why `midpoint_threshold_scale` is not a proof of safety. It is also not
"soft confidence" in the output: it changes the hard pass/fail activation
threshold and the old A design then applies normal correction strength.

---

# 13. SCHEDULER/KERNEL SEPARATION AND ANALYSER DISCIPLINE

The architecture must retain the following older README rules because they are
still exactly right and load-bearing.

## 13.1 Schedule decides WHERE; kernel decides WHETHER/HOW

```text
geometry/map/topology layer:
    selects candidate edge topology

local artifact predicate:
    decides whether the candidate looks filterable

kernel:
    applies the independently specified Deblock4 correction
```

Do not let a local edge predicate become an implicit geometry classifier.

## 13.2 Detector pre-pass reads unmodified source

Any B2 detector that can affect output is part of the canonical algorithm.
Its map must be computed from the unmodified input before filtering writes begin.
Do not let earlier filtered pixels influence later geometry classification.

## 13.3 Per-call scratch, never mutable cross-frame instance state

Under fmParallel, detector maps/scratch are per-frame activation/per-call data.
Immutable configuration may be per instance; output-affecting previous-frame
state is forbidden in v1 unless a later scope explicitly models temporal frame
dependencies.

## 13.4 Detector itself needs proof

If B2 proceeds, its scalar definition becomes part of the oracle-level
structural algorithm. Integer scalar/v2/v3 detector classifications must be
structurally exact under the project's per-type verification rules. Do not hide
the detector in an unproved convenience helper.

## 13.5 Future trusted side data

D4-Q13 remains open. If a source/decoder later supplies trustworthy dct_type
metadata, that producer should feed the SAME FRAME/FIELD/UNKNOWN macroblock-map
contract so the topology compiler/kernel do not change. Runtime correctness
must not depend on side data until its format/lifetime/trust contract is scoped.

---

# 14. PROCESSING ORDER IS A SEPARATE, STILL-OPEN ALGORITHM DECISION

This is the old README Schedule-A/Schedule-B quality gate, renamed here to avoid
collision with Architecture A/B.

Deblocking writes can affect pixels read by later edges, so ordering is
output-defining.

## 14.1 Schedule-SA - raster/interleaved reference candidate

A scalar candidate inspired by the verified HolyWu traversal order. It is a
processing-order comparator only; HolyWu/Classic are not Deblock4 output
oracles.

## 14.2 Schedule-SB - whole-plane two-pass candidate

```text
Pass 1: vertical edges, canonical left-to-right edge order
Pass 2: horizontal edges, canonical top-to-bottom edge order
```

Independent along-edge positions may be batched, but dependent neighbouring
luma edges are not reordered merely to fill a vector.

## 14.3 Schedule-SC

Macroblock-local ordering remains deferred unless SA/SB quality evidence gives
a reason to revisit it.

## 14.4 Required quality comparison

SA versus SB must be compared in scalar form using identical geometry, formulas,
thresholds, clipping and boundary policy. Only order differs.

The OLD README corpus wording that said "interlaced material only after field
separation" is RETIRED by D4-D01. The updated corpus uses WHOLE reconstructed
frames and includes:

- target LG XP/SP/LP/EP and OTA material;
- progressive and uniform-frame controls;
- synthetic isolated vertical/horizontal edges and crossings;
- diagonals, checkerboards, one/two-pixel lines, text/subtitles;
- flat gradients, high-frequency texture, grain/noise, maximum contrast;
- values around every activation threshold;
- chroma-dominant and luma-dominant blocking;
- repeated application (2-5 passes);
- directional-bias/transposition probes where meaningful;
- clean-source -> low-quality MPEG-2 encode -> decode -> filter comparisons.

Measure/inspect discontinuity reduction, detail retention, haloing, directional
smear, staircasing, text/diagonal damage, grain loss, maximum/mean sample
change, PSNR/SSIM where a clean reference exists, and visual crops. A lower
blockiness metric obtained by indiscriminate blur is not success.

The winner becomes part of the future Deblock4 scalar oracle.

---

# 15. D4-Q14 ARCHITECTURE-DISCRIMINATOR EXPERIMENT - NEXT ARTIFACT

This experiment happens BEFORE final luma kernel mathematics is frozen.

## 15.1 Ground truth extraction

Validation tooling, not plugin runtime, records per picture/macroblock:

```text
picture_structure
frame_pred_frame_dct
dct_type when signalled/meaningful
coded/no-DCT status
macroblock x/y
frame number / decoded-frame correspondence
```

Truth classes must distinguish at least:

```text
FRAME
FIELD
NO_DCT / NOT_SIGNALED
UNAVAILABLE/CORRUPT (if encountered)
```

A macroblock with no coded DCT is not assigned a fake FRAME/FIELD label.

## 15.2 B2 leg

For every eligible Case-(a) macroblock, compute the detector's candidate
features and record:

```text
predicted state FRAME/FIELD/UNKNOWN
confidence / score margin
truth state
false-confident indicator
```

Report:

- confusion matrices;
- false-confident rate (most dangerous cell);
- UNKNOWN rate;
- confidence-margin distributions;
- results by source/device/bitrate/content class;
- results around FRAME/FRAME, FIELD/FIELD and MIXED macroblock-row boundaries;
- NO_DCT separately;
- worst false-confident examples, not merely averages.

## 15.3 D / false-candidate leg

Measure the candidate boundary/activity feature distributions at:

```text
true internal FRAME edges
false internal candidates in FIELD macroblocks
FRAME/FRAME macroblock-row boundaries
FIELD/FIELD boundaries
MIXED boundaries
```

Sweep the candidate strictness/threshold family and report true-edge acceptance
versus false-candidate acceptance. This is a viability/ROC-style measurement,
not permission to inherit Classic thresholds.

Where possible, also measure the actual sample/topology difference between D's
pitch-2 treatment and exact pitch-1 treatment on FRAME/FRAME boundaries once a
minimal neutral experimental operation is available. Final quality still waits
for the real kernel.

## 15.4 Dataset discipline [W3C-PROPOSED]

Do not tune and judge on the same clips.

```text
calibration/tuning subset -> choose detector feature/threshold candidates
held-out subset           -> report final architecture-gate statistics
```

Predeclare primary metrics and acceptance limits before looking at held-out
results. This prevents the architecture criterion moving to fit the answer.

## 15.5 Decision rule [W3C-PROPOSED correction]

The experiment selects the architecture to enter kernel/oracle development:

```text
B2 meets predeclared viability criteria:
    take B2 into kernel scope

B2 fails, D meets its own predeclared viability criteria:
    take D into kernel scope

neither meets criteria:
    architecture reopens; do NOT force D merely because it is the fallback
```

No architecture "ships" on D4-Q14 alone. Later kernel, schedule, proper-chroma,
quality, scalar-oracle and SIMD proof gates still apply.

---

# 16. UNKNOWN POLICY REVISIT

Current D4-D07 remains:

```text
B2 runtime UNKNOWN -> do not filter unresolved Case-(a) luma topology; count it
```

Reason: leaving visible blockiness is reversible/status-quo; confidently wrong
geometry can destroy detail.

After D4-Q14, revisit using measured:

- UNKNOWN prevalence;
- false-confident rate;
- blockiness cost of skipping;
- measured D fallback behaviour;
- whether UNKNOWN at an internal edge and UNKNOWN at a macroblock-row boundary
  deserve different policies.

No hidden temporal hysteresis is introduced merely to reduce UNKNOWN.

---

# 17. PROPER CHROMA - SETTLED-BY-DESIGN MATH, QUALITY STILL OPEN

The old README contains MPEG-2/Deblock4 chroma information that must survive the
consolidation.

## 17.1 Plane-relative rule

Chroma grid positions, bounds and steps are always defined in chroma-plane
samples. Never infer them by dividing luma steps by subsampling.

## 17.2 Proper chroma normal-filter footprint

Settled-by-design production direction (still subject to D4-Q10 siting and the
proper-chroma quality gate):

```text
read:  p1, p0, q0, q1
write: p0, q0 only
```

Activation family:

```text
abs(p0 - q0) < alpha
abs(p1 - p0) < beta
abs(q1 - q0) < beta
```

Integer correction design:

```text
tc = tc0 + one_sample_scale

delta = clip3(
    -tc,
     tc,
    (((q0 - p0) * 4) + p1 - q1 + rounding_bias) >> 3
)

p0' = clip_to_sample_domain(p0 + delta)
q0' = clip_to_sample_domain(q0 - delta)
```

The multiply-by-4 spelling is preferred in the canonical derivation so no
language/toolchain question about negative left shifts can arise.

`one_sample_scale` is one unit in the bit-depth-scaled arithmetic domain; 8-bit
value 1. Higher-depth/float forms require their own scalar range/behaviour proof.

## 17.3 Independence property

Proper chroma writes a smaller footprint than the luma normal filter. For
supported edge steps, adjacent chroma edges of the SAME orientation can be
independent and may be batchable across edge positions. Cross-orientation
vertical/horizontal ordering remains output-defining.

## 17.4 Quality status

Proper chroma is SETTLED-BY-DESIGN but UNVALIDATED-BY-MEASUREMENT. It requires a
chroma-dominant corpus. A HolyWu-compatible luma-on-chroma path may exist only as
a development comparator; it is not a production quality option.

---

# 18. GRID ORIGIN, CROPPING, BOUNDS AND MEMORY SAFETY

## 18.1 Grid origin

Initial coded-grid origin is zero.

Spatial cropping BEFORE Deblock4 can shift visible coded block boundaries away
from that origin. Until an explicit origin parameter exists, apply Deblock4
before spatial cropping when original coded-grid alignment matters.

No spatial-origin public parameter is currently ratified for v1.

## 18.2 Footprint-derived eligibility

For a filter class with read radii:

```text
eligible(e, footprint, extent)
    <=> e - read_radius_before >= 0
    AND e + read_radius_after <= extent - 1
```

Do not replace this with a modulus guess or universal minimum-size literal.
Final luma radii remain D4-Q04 until the kernel is frozen; proper-chroma radii
are 2 before / 1 after.

## 18.3 Incomplete algorithmic footprint versus incomplete SIMD batch

These are different tail classes:

```text
incomplete FILTER footprint at frame/plane edge:
    leave unchanged

complete filter footprint but fewer lanes than native SIMD width:
    PROCESS using smaller vector/base/scalar cleanup
```

This engineering discipline carries forward from Classic as a method, not as
code inheritance.

## 18.4 No whole-frame padding / no assumed stride slack

Deblock4 must not pad/crop/resize the entire frame just to satisfy block/vector
widths. Stride is row spacing, not permission to read/write beyond logical plane
width. No backend may depend on undocumented allocator padding or extra bottom
rows.

---

# 19. SIMD CONSEQUENCES OF B2 AND D

The architecture decision is not blocked by SIMD.

## 19.1 Vertical work

Vertical transform-block columns remain geometry-invariant. Vectorise along the
edge direction under the later canonical processing schedule without per-field
classification/parity branching.

## 19.2 Horizontal B2 spans

Classification occurs before filtering. The topology compiler emits spans with
one geometry each:

```text
pitch-1 frame edge span
pitch-2 parity-0 span
pitch-2 parity-1 span
no-edge/unknown span
```

Horizontal pixel lanes remain contiguous in x. Pitch affects row addressing of
p/q taps, not x-lane contiguity.

A pathological checkerboard of FRAME/FIELD macroblocks yields 16-pixel x spans,
which remain vector-friendly under the accepted engineering widths:

```text
u8  v2 N=16 -> one full 128-bit storage batch
u8  v3 N=32 -> one exact V16 half-width/tail application
u16 v2 N=8  -> two full batches
u16 v3 N=16 -> one full batch
```

These are engineering feasibility observations only. D4 builds its own vector
body and byte-identity proof from the future scalar oracle.

## 19.3 Architecture D

D is even more regular because it has no classification map. It still uses two
different horizontal topologies (pitch-2 boundary pair and pitch-1 internal
candidate), but each work item is homogeneous and can use the same span/driver
shape.

## 19.4 Never branch on geometry per SIMD lane

Bad:

```text
for each lane: choose frame/field geometry
```

Good:

```text
span/job already says edge kind, pitch, parity and bounds
vector body runs under those constants
```

---

# 20. CURRENT SOURCE/API STATE - LEGACY SCAFFOLDING IS NOT AUTHORITY

The supplied 2026-08-16 source snapshot is important because it shows how cheap
this re-decision still is.

[SOURCE-VERIFIED]

`src/deblock4_ar_all_frames_ready.zig` currently sends all v1/v2/v3 Deblock4
arms to `passThroughWritableCopy()`. No Deblock4 deblocking kernel exists.

The Stage-1C-era public/scaffolding surface still contains old assumptions:

```text
filter_call_parameters.zig:
    mpeg2_field_separated
    midpoint_threshold_scale
    custom luma/chroma step fields

deblock4_plugin.zig:
    midpoint_threshold_scale and custom step arguments

deblock4_frame_properties.zig:
    Deblock4GridMode
    Deblock4LumaStepX/Y
    Deblock4ChromaStepX/Y
    Deblock4MidpointScale

lifecycle/effective-invocation/selftest/vpy surfaces:
    matching old vocabulary/shape
```

These tests prove creation/parsing/pass-through behaviour of the scaffold that
existed when Stage 1C was accepted. They do NOT make the old grid semantics an
algorithmic commitment after the MPEG-2 architecture was corrected.

D4-Q16 must redesign this surface coherently before the first real Deblock4
algorithm stage. In particular:

- no public name should invite SeparateFields input;
- one scalar `Deblock4LumaStepY` cannot describe a mixed B2 frame truthfully;
- a surviving threshold-scale control, if D needs one, should have a name tied
  to its new meaning rather than preserving `midpoint_threshold_scale` by
  inertia;
- current custom-step semantics must be reconsidered against B2/D topology;
- diagnostics should expose the resolved policy/map/span summary rather than
  pretending every frame has one fixed luma vertical step.

Candidate future diagnostic INFORMATION (names not ratified):

```text
declared MPEG-2 mode
architecture/detector version or policy
FRAME/FIELD/UNKNOWN macroblock counts
pitch-1 / pitch-2 / skipped horizontal span counts
fallback/unknown counts
selected backend tier and plugin version (existing global contract)
```

---

# 21. D4 ISSUE REGISTER - CURRENT DISPOSITIONS

```text
D4-Q01  4:2:0 Case-(a) chroma geometry
         CLOSED by H.262 F4. The old field-separated chroma-step resolution is
         defective and will be replaced, not patched.

D4-Q02  Luma kernel mathematics
         OPEN. Boundary-discontinuity-vs-local-activity is a DIRECTION only;
         derive Deblock4's own formula/thresholds/fixtures.

D4-Q03  Correctness without an external Deblock4 oracle
         OPEN by construction. Build the first scalar oracle from independently
         authored obligations/fixtures under the project's oracle-construction
         exception; HolyWu is quality context, not output authority.

D4-Q04  Final 8x8 luma eligibility/footprint
         OPEN - kernel scope. Architecture pitch/topology is already frozen;
         final kernel read/write radii are not.

D4-Q05  midpoint_threshold_scale fate
         OPEN. Old Architecture-A mechanism is rejected. A threshold-scaling
         IDEA may be measured for D's single uncertain internal candidate, but
         the old parameter/name has no automatic right to survive.

D4-Q06  Corpus / synthetic proof / real quality
         OPEN. Retain make_blocky.bat, dump_mpeg2_info_01.bat, blockiness
         analyser, target LG/OTA clips and clean-reference workflow.

D4-Q07  Scalar/vector body structure
         DECIDED IN PRINCIPLE: independent scalar oracle, then a fresh
         width-generic D4 vector body with explicit exact-span cleanup. This is
         an engineering pattern re-derived for D4, not Classic inheritance.

D4-Q08  Prior-art survey
         CLOSED for current scope by sections 7-8.

D4-Q09  Per-MB dct_type mixture vs uniform modes
         CLOSED INTO B2 TOPOLOGY: classify at macroblock granularity, not a
         generic per-region phase; explicit FRAME/FIELD/UNKNOWN runtime map;
         explicit mixed boundary; Q14 gate.

D4-Q10  Interlaced 4:2:0 chroma vertical siting / weighting
         OPEN - kernel/scheduler scope. It can affect correspondence/weighting,
         not the F4 grid fact.

D4-Q11  Motion-shifted inherited blockiness
         LOGGED, deliberately out of v1. Filter nominal transform grid only.

D4-Q12  Pipeline position / user guidance
         OPEN, but whole-frame uncropped coded geometry must be preserved at
         Deblock4 input. SeparateFields before Deblock4 is forbidden. Cropping
         before Deblock4 shifts the zero-origin grid.

D4-Q13  Trusted per-MB side data
         OPEN. Future decoder/source dct_type map should plug into the same B2
         map contract, not fork the kernel.

D4-Q14  Real-material architecture discriminator
         OPEN - NEXT ARTIFACT, section 15.

D4-Q15  TFF/BFF relevance
         CLOSED by F7; excluded from grid parameters.

D4-Q16  Public parameter / audit-property redesign
         OPEN. Current Stage-1C grid_mode/midpoint/step surface is legacy
         scaffolding and is not the final MPEG-2 API.
```

Open quality gates that must not be lost merely because they lack separate
D4-Q numbers:

```text
- Schedule-SA versus Schedule-SB processing-order winner;
- proper-chroma quality validation;
- D4-Q14 B2-vs-D architecture viability;
- final kernel thresholds/strength behaviour;
- later scalar/vector/full-filter quality and performance validation.
```

---

# 22. RATIFIED DECISION REGISTER - D4-D SERIES

This section reconciles older decision wording with D4-D12 so the active
single-source text does not contradict itself.

```text
D4-D01  WHOLE-FRAME INPUT CONTRACT.
         Reconstructed interleaved frame + declared mode. No SeparateFields
         MPEG-2 input contract.

D4-D02  THREE SOURCE-MODE SEMANTICS.
         progressive / frame-picture-interlaced Case(a) / field-pictures
         Case(b); final public token spelling belongs to D4-Q16. No TFF/BFF.

D4-D03  SCHEDULER/KERNEL SEPARATION.
         Topology says WHERE. Local predicate/kernel says WHETHER/HOW.

D4-D04  DETECTOR CONTRACT - RECONCILED BY D4-D12.
         The old "regional phase" wording is RETIRED. Active meaning:
         for Case-(a) luma, the map producer emits per-16x16-macroblock
         FRAME/FIELD/UNKNOWN plus confidence. Progressive/Case(b) are fixed.
         4:2:0 Case-(a) chroma is fixed frame geometry; 4:2:2/4:4:4 chroma
         follows the resolved luma macroblock organisation.

D4-D05  SPAN COMPILATION - RECONCILED BY D4-D12.
         Compile macroblock edge topology into geometry-homogeneous jobs/spans.
         Horizontal jobs carry edge kind/pitch/parity/bounds. Vertical luma
         block edges remain geometry-invariant; NO parity-split vertical pack
         is created merely because dct_type=FIELD.

D4-D06  NO HIDDEN TEMPORAL STATE IN v1.
         Per-frame deterministic detector/pre-pass; no request-history
         hysteresis under fmParallel.

D4-D07  UNKNOWN POLICY v1.
         No filtering in unresolved B2 topology; diagnostics count it. Revisit
         after Q14.

D4-D08  OWN ORACLE / NOTHING INHERITED FROM CLASSIC.
         Independent D4 mathematics, fixtures, oracle and proof. Engineering
         disciplines may be re-used as methods, not acceptance/code inheritance.

D4-D09  NOMINAL GRID ONLY in v1.

D4-D10  SIMD FEASIBLE IN PRINCIPLE - RECONCILED BY D4-D12.
         Geometry decisions occur outside the lane loop. Frame/field DCT changes
         horizontal row addressing; vertical block columns are invariant. D4
         still requires its own scalar-to-SIMD proof.

D4-D11  OWNERSHIP/PROCESS.
         W3D derives detector/kernel mathematics and experiment/scopes; W3C
         independently cross-checks and implements only ratified scopes; W3X
         ratifies and executes/accepts proof evidence under normal governance.

D4-D12  ARCHITECTURE RE-DECISION.
         Old Architecture A rejected; generic regional B superseded; B2
         macroblock-topology architecture PRIMARY candidate; D detector-free
         topology-aware FALLBACK/COMPARATOR; C rejected; Q14 expanded to an
         architecture discriminator; no kernel scope before its result.
```

**[W3C-PROPOSED for explicit ratification into the eventual successor]**

```text
D4-D13  NO FORCED FALLBACK / EXPERIMENT INTEGRITY.
         Q14 acceptance criteria are declared before held-out results. Q14
         chooses the architecture allowed to enter kernel development, not a
         shipping filter. B2 proceeds only if B2 is viable; D proceeds only if
         B2 is not viable AND D independently meets its viability criteria; if
         neither does, architecture reopens.
```

---

# 23. DEVELOPMENT SEQUENCE AFTER THIS DOCUMENT IS RATIFIED

```text
1. Ratify the single-source MPEG-2 knowledge/architecture document.
2. Complete documentation de-duplication/currency update so other documents
   point here rather than retaining competing MPEG-2 designs.
3. Draft and ratify the D4-Q14 experiment plan, including map/detector feature
   mathematics sufficient for the diagnostic experiment and predeclared
   acceptance rules.
4. Run Q14 with bitstream-side per-MB truth on calibration and held-out target
   material.
5. Ratify B2, D, or a reopened architecture based on evidence.
6. Reconcile D4-Q16 public parameter/diagnostic surface before real pixel work.
7. Derive/freeze Deblock4's scalar kernel mathematics, footprints, thresholds,
   mixed-boundary fixtures and proper-chroma siting consequences.
8. Build the independent ReleaseSafe scalar oracle under its own obligations.
9. Perform processing Schedule-SA/SB and quality decisions; freeze the
   canonical scalar algorithm.
10. Only then develop D4 v2/v3 vector backends and differential proof.
```

The old roadmap shorthand remains conceptually:

```text
2D  Deblock4 scalar/oracle construction
3D  Deblock4 scalar quality/canonical freeze
4D  Deblock4 v2 backend + differential proof
5D  Deblock4 v3 backend + differential/performance proof
```

but Q14 and the architecture/API reconciliation are now prerequisites before
2D's pixel mathematics can be responsibly scoped.

---

# 24. REFERENCES OF RECORD

```text
R1  ITU-T H.262 (02/2000)
    Normative MPEG-2 block/DCT-organisation authority, especially 6.1.3 and
    dct_type/picture-coding syntax discussed in the W3C verification report.

R2  ITU-T H.264, clause 8.7
    Verified MBAFF mixed-boundary conceptual precedent only.

R3  FFmpeg libpostproc source/API examined in the W3C verification round
    Basis for refuting the alleged all-plane interlaced-stride mode.

R4  VapourSynth API4 filter-mode documentation
    fmParallel determinism/concurrency basis for D4-D06.

R5  Changick Kim, Signal Processing: Image Communication 17(7), 2002
    Corroboration of motion-propagated shifted block artifacts.

R6  README_Deblock4_Design_Spec_v1_12.md
    Historical/general design source from which still-valid analyser,
    processing-order, bounds, chroma, crop/origin and SIMD-discipline content
    is absorbed here. Its old separated-field MPEG-2 architecture does NOT
    prevail over this document after ratification.

R7  Deblock4_MPEG2_Grid_Field_DCT_Knowledge_v1_2.md
    Source of the measured OTA/LG regime evidence and MediaInfo triage method;
    superseded after this document is ratified.

R8  Deblock4_D4_W3C_Verification_and_Design_Review_v1_0.md
    Independent external-verification record.

R9  Deblock4_D4_Architecture_ReDecision_Brief_for_W3C_v1_0.md
    W3D brief that reopened A-vs-B after the old README architecture resurfaced.

R10 Deblock4_D4_Architecture_ReDecision_W3C_Evaluation_v1_0.md
    W3C T1-T5 derivation, false-activation analysis, B2/D proposal and SIMD
    correction that led to D4-D12.
```

Raw GAIS files remain captured evidence and are not normative references.

---

# Appendix A - TERMINOLOGY

```text
Case (a)
    MPEG-2 FRAME PICTURE in which per-macroblock frame/field DCT choice may be
    available. Luma organisation may vary by macroblock. 4:2:0 chroma remains
    frame-organised; 4:2:2/4:4:4 chroma follows luma.

Case (b)
    MPEG-2 FIELD PICTURES. Each coded picture is one field; when represented as
    a woven frame, same-field horizontal filtering uses row pitch 2.

FRAME
    Runtime B2 classification meaning frame-DCT luma organisation for the
    macroblock.

FIELD
    Runtime B2 classification meaning field-DCT luma organisation.

UNKNOWN
    Runtime B2 detector state: decoded pixels did not establish FRAME/FIELD
    with required confidence. Current policy: no filtering of unresolved
    topology, count it.

NO_DCT
    Experiment/ground-truth class for a macroblock with no meaningful signalled
    DCT organisation. It is not a runtime detector state to fabricate from
    pixels.

Pitch
    Row-memory spacing between logically adjacent samples in a horizontal
    footprint: 1 for frame-organised, 2 for same-field samples in a woven frame.

Edge topology
    The selected actual edge kind/position/pitch/parity for one macroblock x
    segment, not merely a phase label.

Span/job
    Geometry-homogeneous scheduled work, normally a contiguous x range for one
    horizontal edge kind or a canonical vertical work unit.

Architecture A
    Rejected old separated-field primary/midpoint union-grid architecture.

Architecture B2
    Primary current candidate: per-MB FRAME/FIELD/UNKNOWN map -> explicit edge
    topology -> spans -> Deblock4-owned kernel.

Architecture D
    Detector-free conservative whole-frame topology fallback/comparator.

Schedule-SA / Schedule-SB / Schedule-SC
    Processing ORDER alternatives, unrelated to Architecture A/B/C/D.
```

---

# Appendix B - CURRENT SOURCE DEBT / RECONCILIATION CHECKLIST

When D4-Q16 is scoped, search and reconcile at least the currently observed
surfaces carrying old separated-field/midpoint/step assumptions:

```text
src/filter_call_parameters.zig
src/deblock4_instance_creation.zig
src/deblock4_plugin.zig
src/deblock4_frame_properties.zig
src/lifecycle_trace_debug.zig
src/effective_invocation_text.zig
src/deblock4_selftest.zig
tests/stage_1c_deblock4_passthrough.vpy
plus any build/proof assertions that capture their public text/properties
```

Do not delete/rename them piecemeal merely to match this document. The public
surface must be redesigned atomically under its own ratified scope with proof
updates, because current tests intentionally assert the accepted Stage-1C
scaffold contract.

---

# Appendix C - WHY ARCHITECTURE A WAS REJECTED - COMPACT PERMANENT RECORD

```text
Trigger:
    the old README's ratified separated-field union-grid design resurfaced
    after the first 2026-08-16 investigation architecture had already been
    chosen. W3X correctly reopened the decision before any D4 kernel existed.

Old A:
    separated-field candidate step 4;
    primary r mod 8 = 0;
    midpoint r mod 8 = 4;
    midpoint alpha/beta scaled once at creation;
    normal correction strength after activation.

Whole-frame transposition:
    field row r -> frame row 2r+p;
    literal A becomes e=8j+p, always pitch 2;
    primary e=16k+p; midpoint e=16k+8+p.

Failure 1 - wrong frame-DCT footprint:
    real frame edge e=8,pitch1 reads 5,6,7|8,9,10;
    literal A reads parity projections 2,4,6|8,10,12 and
    3,5,7|9,11,13 instead.

Failure 2 - faithful real-geometry union collides:
    at e=16 the pitch1 write set {14,15,16,17} overlaps both pitch2 parity
    write sets {12,14,16,18} and {13,15,17,19}; ordering/double filtering
    becomes a new algorithm.

Failure 3 - threshold ambiguity is irreducible:
    identical local pixel tuples can represent a true weak seam or harmless
    picture detail; no local threshold can distinguish identical observations.

Conclusion:
    A's good fixed-point/stateless engineering ideas survive as patterns;
    its separated-field union-grid geometry does not.
```

---

# Appendix D - OPEN MATHEMATICS / QUALITY ITEMS THAT MUST NOT BE ACCIDENTALLY
# TREATED AS SETTLED

```text
NOT YET FROZEN:
- B2 detector feature/score mathematics and confidence calibration;
- Q14 acceptance thresholds;
- final luma boundary/activity predicate;
- final luma correction formula and read/write footprint;
- exact mixed-boundary kernel fixtures/quality evidence;
- UNKNOWN policy after measurement;
- D internal-candidate strictness and whether any public control exists;
- proper-chroma D4-Q10 siting/weight consequence;
- proper-chroma quality acceptance;
- Schedule-SA vs Schedule-SB winner;
- final public mode/parameter/property names;
- custom-grid fate;
- pipeline/deinterlace documentation guidance;
- optional trusted dct_type side-data contract;
- scalar oracle obligations and later SIMD bodies.
```

This appendix is deliberately blunt: architecture geometry being decided does
not mean the pixel filter mathematics are decided.

---

# Appendix E - REVISION HISTORY

```text
v1.03 (2026-08-16) W3C proposed full consolidation successor to v1.02.
      Reconciles all active text to B2/D after the architecture re-decision;
      removes stale per-region-phase and parity-split-vertical implications;
      adds exact whole-frame pitch/topology mathematics; preserves the full A
      transposition/double-write rejection proof; absorbs OTA/LG measured regime
      evidence and MediaInfo triage from the old grid knowledge doc; absorbs
      still-valid README analyser/pre-pass, schedule, proper-chroma, bounds,
      crop/origin, SIMD and quality-gate content; makes 4:2:2/4:4:4 Case-(a)
      chroma-follow-luma explicit in the active B2 pipeline; records current
      pass-through/legacy API source debt; distinguishes Architecture A/B from
      processing Schedule-SA/SB; expands Q14 with calibration/held-out
      discipline; and PROPOSES the safety correction that D is not a forced
      fallback if it also fails its viability criteria. No code change.

v1.02 (2026-08-16) W3D read-first current-position summary added after D4-D12.

v1.01 (2026-08-16) Architecture re-decided: old A rejected; B2 primary; D
      fallback/comparator; C rejected; Q14 expanded.

v1.00 (2026-08-16) First prevailing MPEG-2 investigation/architecture document:
      H.262 geometry facts, SeparateFields derivation, prior-art verification,
      GAIS calibration, D4-Q/D4-D registers and initial detector/scheduler
      architecture.
```
