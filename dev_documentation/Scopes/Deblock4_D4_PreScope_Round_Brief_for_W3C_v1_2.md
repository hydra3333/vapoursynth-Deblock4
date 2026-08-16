# Deblock4 - Pre-Scope Round for W3C - Part A Verification, Part B Design Review

**Deliverable:** W3D-D4-VERIFY-1 (W3X-approved), for W3C
**Version:** 1.2
**Date:** 2026-08-16
**Nature:** INVESTIGATION AND ADVICE ONLY. No repository file is created,
modified or deleted. The output is a written report. PART A is verification
of external claims. PART B (new at v1.2, W3X-requested) asks for W3C's
INDEPENDENT DESIGN JUDGEMENT on the Deblock4 architecture: concur with the
W3D recommendation, or propose better. W3C is expected to disagree where it
sees cause. This precedes any Deblock4 kernel
scope; its findings feed the D4-Q issue register and the MPEG-2 knowledge
document v1_3.
**Context supplied:** the GAIS investigation brief v1_0; ALL THREE GAIS
answers (original two-part; follow-up with replacement citations; the
option-space analysis); and ALL W3D assessments of them, including the
assessment in section B1 below. Read all first.
NOTE ON POSTURE: in its follow-up GAIS REPLACED its entire citation set and
labelled every new citation "Fully Verified". A verification retry that
replaces everything and upgrades all confidence, retracting nothing, is a
warning sign, not reassurance. Treat every citation below as UNTRUSTED
until you have checked it against the public record yourself.
**Discipline:** the standing rules apply - verify against the actual source
or the actual published text, cite file/line or clause, and where you cannot
verify, say so plainly. Classify every finding as VERIFIED / REFUTED /
COULD-NOT-DETERMINE. Do not fill gaps with plausibility.
**Encoding:** US-ASCII; CRLF.

---

# PART A - VERIFICATION

## V1. libpostproc chroma behaviour under the interlaced flag (HIGH PRIORITY)

The load-bearing GAIS claim (its Q-B6): when libpostproc's interlaced mode is
active, vertical deblocking field-splits BOTH luma and chroma by doubling the
stride - which, if true, misaligns chroma in Case (a) (frame pictures with
field DCT, where 4:2:0 chroma stays frame-organised on an 8-row grid).

Read the actual FFmpeg libpostproc source (libpostproc/postprocess.c and
relatives; use the current FFmpeg master or a recent release, and state which):
  V1.1  Locate the interlaced/field mode mechanism. Report the exact flag(s),
        where they are set, and the mechanism (stride doubling? explicit
        field loop?), with file and line.
  V1.2  Determine PER PLANE whether the vertical deblock path applies the
        field mechanism to chroma as well as luma. This is the decisive
        question. Quote the controlling lines.
  V1.3  Determine what drives filter strength (QP array? fallback constant?)
        and whether QP, when present, is applied per macroblock on the 8x8
        grid. Brief; this is context, not the crux.
  V1.4  If DGDecode source is reasonably accessible, confirm or refute that
        its internal post-processor is a port of the same code with the same
        chroma behaviour; if not accessible, say so and stop there.

## V2. H.264 clause 8.7 MBAFF mixed-boundary rule (published spec text)

GAIS describes: frame-to-frame boundaries filtered on consecutive samples;
field-to-field within a field at stride 2; and at MIXED boundaries the
frame-coded neighbour treated as two temporary field halves and filtered at
stride 2. W3D's assessment additionally claims that in MBAFF, CHROMA FOLLOWS
the macroblock pair's frame/field decision (no MPEG-2-style chroma
asymmetry).

Against the published H.264 / ISO-IEC 14496-10 text (any freely available
edition; state which):
  V2.1  VERIFY or correct the mixed-boundary description, citing the
        subclause(s).
  V2.2  VERIFY or refute the chroma-follows-pair claim, citing the
        subclause(s). If chroma has any special-case behaviour in MBAFF
        deblocking, describe it precisely - this calibrates how much of the
        MBAFF mapping is reusable for Deblock4.
  V2.3  GAIS's follow-up cited "8.7.2.2, Derivation process for the chroma
        content dependent boundary filtering strength" and spoke of "2x2 or
        4x4 chroma block boundaries". W3D doubts both the clause title and
        the 2x2 claim (H.264 chroma deblocking is not believed to operate on
        2x2 edges). Check the actual clause numbering/titles in the edition
        you use and state what 8.7.2.2 actually is, and whether any 2x2
        chroma boundary concept exists in the deblocking process.

## V3. The patent citations - BOTH ROUNDS (LEADS, all distrusted)

Round one GAIS cited US 6,633,612 ("Sony, adaptive post-filter for
interlaced video") and US 7,139,437 ("Microsoft, deblocking interlaced
video"). In its follow-up, GAIS WITHDREW those (conceding the first is a
Faroudja/Genesis DCDi patent and the second a Microsoft codec patent of
different substance) and REPLACED them with three new citations, each
labelled "Fully Verified":
    US 6,167,157   attributed Sony/Ohta, block-boundary smoothing with an
                   interlace-aware vertical mode switch
    US 7,031,552   attributed LSI Logic/Winger, adaptive post-filtering of
                   coded interlaced video, frame/field boundary handling
    US 6,983,079   attributed Samsung/Kim, reducing blocking artifacts with
                   separate handling for field-structured blocks

From the public USPTO / Google Patents record:
  V3.1  For EACH of the three new numbers: actual title, assignee(s),
        filing/grant years, and one-paragraph substance from the actual
        abstract/claims. Classify each GAIS citation VERIFIED /
        PARTIALLY-ACCURATE (number real, attribution or substance wrong) /
        REFUTED.
  V3.2  Also confirm, briefly, W3D's belief about the two ROUND-ONE numbers
        (6,633,612 Faroudja DCDi; 7,139,437 Microsoft) so the calibration
        record covers both rounds.
  V3.3  If any new number is refuted: bounded search (30 minutes each, no
        more) for a real patent matching the DESCRIBED method; report what
        you find or that you found nothing.

## V3b. The two paper citations from the GAIS follow-up (LEADS, distrusted)

GAIS's follow-up cited, as "Fully Verified":
    Kim, Kim, Cho (1999), "A post-processing algorithm for reducing blocking
    artifacts in interlaced coded video", IEEE Trans. Consumer Electronics,
    vol 45 no 3;
    Han, Kim (2002), "Adaptive post-filtering for reducing blocking and
    ringing artifacts in MPEG-2 coded video", attributed to IEEE Trans.
    Circuits and Systems for Video Technology.
  V3b.1  Determine whether each exists as cited (title, authors, venue,
         year, volume). Classify VERIFIED / PARTIALLY-ACCURATE / REFUTED /
         COULD-NOT-DETERMINE. IEEE metadata is publicly searchable even
         where full text is paywalled; do not purchase anything.
  V3b.2  If the 1999 interlaced-coded-video paper is real and its abstract
         is accessible: does the abstract indicate anything about CHROMA
         handling, or is it luma/generic? One sentence; do not chase the
         full text in this round.

## V4. G1 closure attempt: the verbatim H.262 subclause 6.1.3 text

Our knowledge document has carried G1 as PENDING since Stage 4C: the verbatim
6.1.3 sentence on 4:2:0 chroma frame-organisation has never been read by us
in an authoritative copy. ITU-T publishes H.262 without charge.

  V4.1  Obtain the ITU-T H.262 text (state edition and source URL). Quote
        VERBATIM the sentence(s) in 6.1.3 (or wherever they actually live)
        governing chroma block organisation under field DCT for 4:2:0, and
        the corresponding statements for 4:2:2 and 4:4:4.
  V4.2  Compare against both GAIS quotations (the 2026-08-12 response and
        the current one). Classify each GAIS quote VERBATIM-ACCURATE /
        SUBSTANTIVELY-ACCURATE-BUT-PARAPHRASED / WRONG.
  V4.3  Also quote the dct_type semantics subclause (GAIS cites 6.3.17.1)
        sufficient to confirm: per-macroblock signalling, the conditions
        under which it is present, and the default when absent.

# PART B - DESIGN REVIEW (W3X-requested; advisory, not implementation)

## B1. The state of the design question, and W3D's current recommendation

```text
SETTLED (ratified or W3D-derived, not open for re-litigation here):
  D4-D01  Whole-frame input contract. The plugin receives the interleaved
          frame plus a declared source mode; separated-field input is NOT
          supported for MPEG-2. Reason (geometric, ours): SeparateFields
          tears frame-organised blocks across two clips, so for Case (a)
          and for progressive material no field-clip instance can deblock
          4:2:0 chroma at all.
  Three geometries exist, not two:
    progressive              luma and chroma both 8-row consecutive
    frame-picture/field-DCT  ("Case a") luma field-organised, staggered,
                             16-frame-row period; 4:2:0 CHROMA REMAINS
                             frame-organised at 8 consecutive chroma rows
    field-pictures           ("Case b") luma AND chroma both field-
                             organised, 16-frame-row period, stride 2
  dct_type is per MACROBLOCK, so any uniform per-frame grid is an
  approximation on real Case (a) material.
  TFF/BFF does not affect block geometry (it swaps which field is which,
  not where boundaries sit), so the mode parameter needs three values.
  SIMD is NOT impeded by field-domain filtering: filtering at frame rows
  y+/-2,4,6 instead of y+/-1,2,3 changes the row-stride term only; loads
  remain contiguous N-lane loads along x, and the vertical four-row lane
  pack remains four rows of one field.

W3D's ASSESSMENT OF THE GAIS OPTION-SPACE ANSWER (test this, do not adopt
it on W3D's authority):
  (i)  Its temporal-flicker argument is asymmetric and therefore partly
       wrong. It attributes flicker to classifiers, but ANY thresholded
       per-region decision flickers - including its own Architecture 2,
       whose stated failure mode is boundaries "flickering back into
       visibility". Flicker argues for HYSTERESIS, not for one
       architecture over another.
  (ii) Its "seam" argument names a real effect but misattributes cause.
       Adjacent macroblocks genuinely differ in dct_type; the
       discontinuity is in the MATERIAL. H.264 clause 8.7 exists because
       that adjacency is normal and needs a defined transition rule. The
       blast radius is also small, since filtering only touches pixels
       near boundaries.
  (iii) Its grid-shift argument is the strongest and is BIGGER than
       interlacing: in P/B pictures, motion-compensated blocks carry
       INHERITED blockiness at shifted positions plus fresh residual
       blockiness at the nominal grid. Every known implementation
       (libpostproc, HolyWu-style Deblock, and our own Classic) filters
       the nominal grid only. W3D's position: LOG IT (D4-Q11), do NOT
       attempt to solve it in the first kernel.
  (iv) GAIS MISSED that its Architecture 2 B_metric - step across the
       boundary over activity either side - is structurally what
       CLASSIC'S EXISTING KERNEL ALREADY DOES per edge. Classic gates
       each edge on local activity against thresholds before filtering.
       Architecture 2 is therefore less a competing architecture than a
       description of machinery we already own AND HAVE PROVEN
       BYTE-EXACT across three tiers.

W3D's CURRENT RECOMMENDATION - split the problem at its natural seam:
  SCHEDULE decides WHERE candidate edges are:
      global declared mode restricts the candidate phase set;
      luma in Case (a): per-region phase selection driven by MEASURED
        boundary energy at the two candidate phases (not by motion);
      chroma in Case (a): FORCED to the 8-consecutive normative grid -
        no decision, because the standard removes the uncertainty;
      Case (b): both planes on the field grid; progressive: both on the
        frame grid;
      temporal hysteresis on the per-region decision, against flicker.
  KERNEL decides WHETHER each candidate edge is really an artefact:
      Classic's existing per-edge activity gating, reused.
  Rationale: the uncertain part (grid geometry) is small, declarative and
  testable; the hard-to-prove part (filter mathematics) is code we have
  already proven byte-exact three times.

  GATING DEPENDENCY: this recommendation assumes per-region phase energy
  is SEPARABLE on real material. That is being measured separately
  (D4-Q14). If it is not separable, the honest fallback is a uniform
  per-clip grid taken from the flag - wrong on mixed Case (a) frames, but
  predictable and cheap.
```

## B2. What W3D wants from W3C

  B2.1  CONCUR OR DISSENT with the recommendation in B1, with reasons. A
        reasoned dissent is more valuable than agreement; W3D has been
        wrong three times in the last two scopes and each time W3C caught
        it.
  B2.2  TEST the four W3D assessments (i)-(iv) above. In particular (iv):
        read src/classic_scalar_kernel.zig and state whether Classic's
        per-edge decision really does subsume the B_metric concept, or
        whether W3D is overstating the reuse. Quote the controlling lines.
  B2.3  SIMD IMPLICATIONS. For each of the three geometries, state what
        the vector backends would actually have to do differently from
        the accepted 4C/5C code, and whether anything in the frozen
        width-generic body obstructs a per-region phase decision (e.g.
        does a per-region branch break the contiguous-load pattern or the
        four-row vertical pack?). This is the question W3C is best placed
        in the project to answer.
  B2.4  ANY ARCHITECTURE W3D AND GAIS HAVE BOTH MISSED. Both have been
        reasoning inside the same frame for several rounds; say so if you
        see a different one.
  B2.5  RISK RANKING. Of everything in B1, which single element is most
        likely to be the thing that goes wrong, and what cheap evidence
        would surface it earliest?

## V5. Report form

One .md report: PART A sections V1-V4 (incl. V3b), each finding classified,
every claim carrying its citation (file+line for source, clause for specs,
number+title for patents); PART B sections B2.1-B2.5 as reasoned advice.
Where GAIS is refuted, state the refutation neutrally - the point is
calibration of a research instrument, and both confirmations and refutations
are equally useful. Where W3D is wrong, say so as directly. End with a
DECISIONS/QUESTIONS FOR W3X section, or state none.
