# Deblock4 - External Investigation Brief for GAIS - MPEG-2 Chroma Block
# Organisation in Field Coding, and Prior Art in MPEG-2 Deblocking

**Version:** 1.0
**Date:** 2026-08-16
**Prepared by:** W3D (designer) for W3X to submit to GAIS
**Covers project issues:** D4-Q01 (chroma block period under field coding) and
D4-Q08 (prior art survey)
**Nature of ask:** independent verification and research. We have working
conclusions and we want them CHECKED, including refuted if wrong. Please do
not simply agree with us.
**Encoding:** US-ASCII; CRLF.

---

# 0. What we are building, in one paragraph (context only)

We are writing a VapourSynth video filter plugin for restoring PAL 576i
material that was encoded as MPEG-2 (ISO/IEC 13818-2 / ITU-T H.262). The
plugin has two filters. "Classic" is a faithful reimplementation of an
existing H.264-style deblocker that operates on a FIXED 4x4 grid; it is
finished and proven. "Deblock4" is the new filter, and its purpose is to
deblock on the ACTUAL MPEG-2 8x8 DCT grid rather than a 4x4 one. Deblock4
currently validates its parameters and passes frames through unchanged; we
are about to design its filtering kernel, and we want the block-geometry
questions settled BEFORE we write any mathematics on top of them.

We work to a discipline where design decisions must be traceable to normative
text or to measured evidence, not to recollection. That is why we are asking.

---

# PART A - D4-Q01: chroma block organisation under field coding

## A1. What we believe we already know (please verify or correct)

From a prior exchange, and from our own reading of ITU-T H.262 / ISO/IEC
13818-2, we hold the following as settled. Each is stated so you can confirm
or refute it individually.

A1.1  The DCT in MPEG-2 always operates on 8x8 blocks of SAMPLES, for luma
      and for chroma alike, in every chroma format.

A1.2  Block coordinates and dimensions are defined on the SAMPLING GRID OF
      THE PLANE BEING CODED - the chroma plane's own coordinates - not in
      luma coordinates. In 4:2:0 a chroma 8x8 block therefore covers a 16x16
      region in luma coordinates, but the transform is on 8x8 actual chroma
      samples.

A1.3  Per-macroblock block counts are: 4:2:0 = 4 luma + 1 Cb + 1 Cr = 6;
      4:2:2 = 4 luma + 2 Cb + 2 Cr = 8; 4:4:4 = 4 luma + 4 Cb + 4 Cr = 12.

A1.4  We further believe, from H.262 subclause 6.1.3, that in 4:2:0 the
      CHROMINANCE blocks are ALWAYS ORGANISED IN FRAME STRUCTURE, regardless
      of the value of dct_type - that is, dct_type (frame DCT vs field DCT)
      applies to the LUMINANCE blocks only in 4:2:0.

## A2. The question we actually need answered

Our filter has a grid mode intended for interlaced/field-coded material. In
that mode it currently derives a vertical block PERIOD of 8 luma rows for
frame material and 4 luma rows for field material (i.e. it treats the field
as being separated, so consecutive rows of one field are 4 apart in the
interleaved frame). It applies the SAME halving to chroma, giving a chroma
vertical period of 4 in chroma-plane coordinates.

If A1.4 is correct, that chroma halving looks WRONG for 4:2:0: if chroma
blocks are always frame-organised, the chroma vertical block period should
remain 8 chroma rows even when luma is field-organised. Deblocking chroma on
a 4-row period would then place filtering at positions that are not chroma
block boundaries at all.

**Q-A1.** For 4:2:0 MPEG-2, when a FRAME PICTURE is coded with dct_type
indicating FIELD DCT, what is the correct vertical block boundary period for
(i) the luma plane and (ii) each chroma plane, expressed in rows of that
plane's own sampling grid? Please cite the normative subclause.

**Q-A2.** Does the answer to Q-A1 differ for 4:2:2 and for 4:4:4? Our reading
is that the "always frame-organised" rule in A1.4 is specific to 4:2:0 and
that chroma in 4:2:2 and 4:4:4 may be field-organised, but we are NOT
confident of this and would like it checked against the normative text.

**Q-A3.** THE DISTINCTION WE MOST WANT CLARIFIED. MPEG-2 has two different
mechanisms that both get loosely called "interlaced coding":
   (a) a FRAME PICTURE (picture_structure = frame) whose macroblocks may
       individually select field DCT via dct_type;
   (b) FIELD PICTURES (picture_structure = top field / bottom field), where
       each coded picture IS a single field.
For a post-decode filter that sees only the reconstructed, re-interleaved
FRAME, what is the resulting block geometry in each case, for luma and for
chroma, in 4:2:0? Specifically:
   - In case (b), are the effective block boundaries in the interleaved frame
     at every 4th luma row for luma AND at every 4th chroma row for chroma
     (because each field was independently coded with its own 8x8 blocks
     covering 8 rows OF THAT FIELD)?
   - In case (a), does A1.4 mean luma boundaries appear at a 4-row period in
     the interleaved frame while chroma boundaries remain at an 8-row period?
If those two cases genuinely differ, that is decisive for us, because our
single "field" grid mode may be conflating them.

**Q-A4.** Is dct_type signalled per macroblock, and can it therefore vary
WITHIN a single frame picture? If so, is there any way a post-decode filter,
which has no access to the bitstream, can determine per-macroblock DCT type
from decoded pixels alone - or is the honest answer that a post-decode filter
must assume a uniform grid and accept that it will be wrong for some
macroblocks?

**Q-A5.** Is there anything else about MPEG-2 block geometry that a
post-decode deblocker designer commonly gets wrong, that we have not asked
about? We would rather hear it now than discover it later.

## A3. What a useful answer looks like

Citations to specific subclauses of H.262 / ISO-IEC 13818-2 where possible;
an explicit statement where the standard does NOT determine the answer and
the honest answer is "it depends on the encoder" or "a post-decode filter
cannot know"; and a direct statement if any of A1.1-A1.4 is wrong.

---

# PART B - D4-Q08: prior art in MPEG-2 deblocking

## B1. Why we are asking

MPEG-2 produces 8x8 block artefacts by design, and has done for thirty years.
It seems implausible to us that deblocking MPEG-2 output has not been solved,
or at least seriously attempted, many times over. Before we design a filter
we want to know what already exists, what it does, and in particular HOW
EXISTING IMPLEMENTATIONS HANDLE THE INTERLACED / FIELD-CODING CASE - which is
exactly the question Part A is about.

We would rather adopt or adapt a well-understood existing approach than
invent one, and if the existing approaches all sidestep the field-coding
problem, that itself is important information.

## B2. Questions

**Q-B1.** Does MPEG-2 (H.262 / ISO-IEC 13818-2) itself define or describe any
deblocking or post-processing filter, normatively or informatively - in an
annex, in the Test Model, or elsewhere? For contrast, we are aware that some
other standards do (for example we believe H.263 has an optional deblocking
filter annex, and MPEG-4 Part 2 describes post-filters). Is there an MPEG-2
equivalent, and if not, is the absence deliberate and documented?

**Q-B2.** What do the well-known MPEG-2 REFERENCE and open-source DECODERS do
about block artefacts? We would like this checked rather than assumed, for at
least: the MPEG Software Simulation Group reference decoder (mpeg2decode),
libmpeg2, and FFmpeg's MPEG-2 decoder. Do any apply or offer deblocking, and
if not, do they document post-processing as an out-of-scope concern?

**Q-B3.** What do PLAYERS and POST-PROCESSING LIBRARIES actually ship? We
particularly want an accurate account of FFmpeg's libpostproc (the "pp"
filter, we believe derived from MPlayer) and of FFmpeg's spp/fspp/uspp
filters, plus whatever VLC and Media Player Classic style players use in
practice. For each, we would like to know:
   - what grid it deblocks on, and whether it is 8x8 fixed;
   - what drives its filter strength (quantiser parameter? measured local
     activity? a user parameter?);
   - and CRITICALLY, whether and how it handles INTERLACED or field-coded
     content - does it have an interlaced mode, does it deblock fields
     separately, or does it ignore the issue?

**Q-B4.** In the AviSynth / VapourSynth filter ecosystems specifically, what
MPEG-2-oriented deblockers exist and what approach do they take? We are aware
of H.264-style deblockers ported into that ecosystem (which is what our
"Classic" filter reimplements) and of DCT-domain approaches. We would like to
know what is actually used in practice for MPEG-2 material, and whether any
of them treats the field-coding geometry question explicitly.

**Q-B5.** Is there a published algorithm or paper that is regarded as the
standard approach to MPEG-2 deblocking as a post-process - something with a
name we should know - as distinct from generic smoothing?

**Q-B6.** Among everything you find, is there any implementation that
explicitly addresses the Part A question, i.e. that treats chroma block
boundaries differently from luma boundaries under field coding? If yes, that
implementation is of very high interest to us and we would like to know
precisely what it does.

## B3. What a useful answer looks like

Named implementations with enough specificity that we can go and read the
source ourselves; a clear separation between what you have verified and what
is your general impression; and an explicit statement where the honest answer
is "this appears not to be handled anywhere I can find", because a negative
result here is genuinely useful to us and we will not treat it as a failure
to answer.

---

# PART C - Notes on how we will use your response

Your response will be captured verbatim into our project record and used as a
cross-check against our own reading. Our internal knowledge document remains
the prevailing authority for our design decisions; where your findings and our
prior conclusions disagree, the disagreement is itself the valuable output and
we will investigate rather than simply adopt either side.

Please flag clearly anywhere you are uncertain, inferring, or working from
general knowledge rather than from a checkable source. We would much rather
have a narrow confident answer plus an explicit list of what you could not
determine, than a complete-looking answer of uneven reliability.

Thank you.
