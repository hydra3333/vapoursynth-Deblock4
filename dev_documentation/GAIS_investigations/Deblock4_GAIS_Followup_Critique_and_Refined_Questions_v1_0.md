# Deblock4 - Follow-up to GAIS - Critique of Your Prior-Art Answer, and
# Refined Questions

**Date:** 2026-08-16
**Re:** your answer to our investigation brief (chroma field geometry and
prior art). Part A was excellent and is being verified against the published
text through a separate channel. This follow-up concerns Part B and your
supplementary research note. We are giving you our internal assessment of
your answer VERBATIM below, because we want you to see exactly where we
think you overclaimed or may have erred, and then answer the refined
questions that follow. As before: please refute us where we are wrong.

---

## Our internal assessment of your answer (verbatim)

Is MBAFF the same problem? Same problem class for luma; materially not the
same in three ways.

Where the analogy is genuine: in both standards, one picture can contain a
mixture of block organisations - MPEG-2's per-macroblock dct_type gives you
frame-DCT blocks (8 consecutive interleaved rows, genuinely spanning both
fields) sitting adjacent to field-DCT blocks (8 rows of one field,
16-frame-row staggered boundaries). MBAFF has the same adjacency zoo, and
H.264's clause 8.7 mixed-boundary rule (treat the frame-coded neighbour as
two temporary field halves and filter at stride 2) is a proven, deterministic
answer to that adjacency geometry. As reusable mapping logic for luma, it is
legitimate prior art.

Where it is not the same:

1. The chroma asymmetry - the crux of our design question - has no MBAFF
analogue. In H.264 MBAFF, chroma follows the macroblock pair's frame/field
decision: field-coded pair, field-coded chroma. In MPEG-2 4:2:0, chroma is
never field-split even when luma is. So the one property that makes our
field mode hard - luma staggered at 16 while chroma stays consecutive at 8
in the same picture - simply does not occur in MBAFF, and its mapping logic
contributes nothing to it. Your own summary point 2 states the divergent
chroma rule; the "exact same problem" framing in your section 1 oversells
the luma part.

2. MBAFF's mapping presupposes knowledge we do not have. H.264's deblocker
is in-loop: it knows each block's frame/field mode. dct_type is
per-macroblock and invisible post-decode (your own Q-A4 answer). So MBAFF's
deterministic case table degrades, for us, into "two filtering paths chosen
by a classifier" - the local-interlacing-measure heuristic - with all the
misclassification risk that implies. The geometry is adoptable; the
certainty is not.

3. Granularity and semantics differ. MBAFF decides per 16x32 macroblock
pair; MPEG-2 per 16x16 macroblock. And clause 8.7 is a whole filter model
(boundary strength from coding data, transform-size-dependent taps) -
adopting its boundary mapping is separable from, and should not be confused
with, adopting its filter.

Reliability triage of your answer: Part A is high-confidence. Two items we
treat as leads, not facts: the paper titles (plausible, possibly paraphrased
or confabulated), and the patents - US 6,633,612 in particular we believe is
the Faroudja DCDi motion-detection patent, not a Sony deblocking one, so at
least one attribution looks wrong. And the load-bearing Q-B6 claim - that
libpostproc field-splits chroma under its interlaced flag, making everyone
misaligned in Case (a) - is exactly the kind of flattering-to-us claim that
must be verified in actual source before it enters the record.

---

## Refined questions

F1. PATENTS, RETRIED WITH VERIFICATION. Please re-derive the patent
citations. For each patent you cite this time: give number, exact title,
assignee, filing/grant years, and state explicitly whether you have verified
the number-to-title correspondence or are recalling it. If you cannot verify
a number, describe the method and say the number is uncertain - an accurately
described method with an uncertain number is more useful to us than a
confident wrong citation.

F2. PAPERS, RETRIED WITH VERIFICATION. Same treatment for the academic
papers: exact titles, authors, venue and year where you can verify them;
where you cannot, say plainly that the title you gave was a paraphrase of a
research direction rather than a citable paper. We do not penalise "this is
a research area, not a specific paper I can cite" - we penalise unmarked
paraphrase.

F3. THE CHROMA ASYMMETRY, SPECIFICALLY. Our central remaining prior-art
question, sharpened: is there ANY prior art - paper, patent, or code - that
addresses the MPEG-2 4:2:0-specific situation where, within one frame
picture, LUMA block boundaries are field-organised (staggered, 16-frame-row
period) while CHROMA boundaries remain frame-organised (8-chroma-row period)?
Not generic interlaced deblocking; this exact luma/chroma grid divergence.
If the honest answer is that nothing addresses it, say so plainly - that
negative is a design-relevant result.

F4. MBAFF CHROMA, PRECISELY. In H.264 MBAFF deblocking, does chroma follow
the macroblock pair's frame/field decision, or does it have special-case
handling? Cite the clause. (We are having the spec text checked
independently; we want your reading as a cross-check.)

F5. THE CLASSIFIER'S FAILURE MODES. The local-interlacing-measure approach
you described decides field-vs-frame filtering from D_frame vs D_field. Its
obvious failure mode is STATIC field-coded content: no motion means
D_frame is approximately D_field, the classifier says "frame", but the
blocks may still be field-DCT (encoders may choose field DCT for reasons
other than motion, and frame_pred_frame_dct=0 sequences can use it freely).
What does the literature say about this failure mode and its visual cost?
Is there a known refinement (e.g. biasing toward the coded picture_structure,
temporal hysteresis, or detecting the staggered blockiness signature itself
rather than motion)?

F6. DETECTING THE GRID ITSELF. Rather than inferring dct_type from motion,
is there prior art on detecting BLOCK BOUNDARY PHASE directly from the
decoded image - i.e. measuring where the blockiness energy actually sits
(8-row consecutive vs 16-row staggered, per region) and filtering there?
This sidesteps classification of coding mode in favour of measuring the
artefact. If this has a name in the literature, we want it.
