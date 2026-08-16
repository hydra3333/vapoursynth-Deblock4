# Deblock4 - Pre-Scope Verification Round for W3C - GAIS Prior-Art Claims

**Deliverable:** W3D-D4-VERIFY-1 (W3X-approved), for W3C
**Version:** 1.0
**Date:** 2026-08-16
**Nature:** INVESTIGATION ONLY. No repository file is created, modified or
deleted. The output is a written report. This precedes any Deblock4 kernel
scope; its findings feed the D4-Q issue register and the MPEG-2 knowledge
document v1_3.
**Context supplied:** the GAIS investigation brief v1_0, the GAIS answer
(both parts), and the W3D assessment of that answer. Read all three first.
**Discipline:** the standing rules apply - verify against the actual source
or the actual published text, cite file/line or clause, and where you cannot
verify, say so plainly. Classify every finding as VERIFIED / REFUTED /
COULD-NOT-DETERMINE. Do not fill gaps with plausibility.
**Encoding:** US-ASCII; CRLF.

---

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

## V3. The two patent citations (LEADS, currently distrusted)

GAIS cited US 6,633,612 (attributed Sony, "Adaptive post-filter for
interlaced video") and US 7,139,437 (attributed Microsoft, "Deblocking
interlaced video"). W3D believes at least the first attribution is wrong
(6,633,612 is believed to be a Faroudja/Genesis motion-detection patent).

From the public USPTO/Google Patents record:
  V3.1  For each number: actual title, assignee, and one-paragraph substance.
        Classify each GAIS citation VERIFIED or REFUTED.
  V3.2  If refuted, a bounded search (30 minutes each, no more) for whether a
        real patent matching the DESCRIBED method exists; report what you
        find or that you found nothing. Do not go down the rabbit hole.

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

## V5. Report form

One .md report, sections V1-V4, each finding classified, every claim carrying
its citation (file+line for source, clause for specs, number+title for
patents). Where GAIS is refuted, state the refutation neutrally - the point
is calibration of a research instrument, and both confirmations and
refutations are equally useful. End with a DECISIONS/QUESTIONS FOR W3X
section, or state none.
