# Deblock4 - To GAIS - A Correction, and a Request for the Option Space
# (Not a Specification)

**Date:** 2026-08-16
**Re:** your input-contract recommendation and classifier advice.

We have adopted the whole-frame input contract with a declared source mode
(progressive / MPEG-2 frame-coded-interlaced / MPEG-2 field-pictures), and we
have separately established that field-domain filtering does not impede SIMD
vectorisation (row addressing changes; lane geometry along x does not). This
message does two things: corrects one piece of your advice against your own
earlier analysis, and asks you for something different from what we have
asked before.

---

## 1. A correction: your static-area advice contradicts your own F5 answer

In your latest reply you advised that, for luma, the per-region classifier
can "safely default to the frame path" where the region is static (D_frame
approximately equal to D_field).

One round earlier, answering our F5, you yourself identified the classifier's
known failure mode: STATIC FIELD-CODED CONTENT. Encoders may select field DCT
for reasons other than motion, and in that case a static region yields
D_frame approximately equal to D_field while the true block boundaries are
field-staggered. Your F5 answer correctly stated the dual cost: the real
staggered boundaries go UNFILTERED, and the frame-path filter blurs positions
that are NOT boundaries.

"Default to frame when static" does not avoid that failure - it
institutionalises it. Your own F5 refinements (measuring boundary energy
rather than motion, temporal hysteresis, biasing by declared picture
structure) were the better answer. Please treat this correction as accepted
context for what follows, or argue back if you believe we have misread you.

---

## 2. What we are asking for now - and what we are deliberately NOT asking for

We are NOT asking you to write our specification or our pseudocode. The
specification will be written and defended internally. What you have been
most useful for is reasoning about METHOD - your failure-mode analysis and
your boundary-phase material were the strongest parts of this whole exchange.
So:

**REQUEST: lay out the OPTION SPACE for deblocking a whole-frame MPEG-2
picture given only (a) the decoded pixels and (b) a per-clip declared mode
(progressive / frame-coded-interlaced / field-pictures), where dct_type may
vary per macroblock in the frame-coded-interlaced case.**

Give us two or three genuinely DISTINCT architectures - not variants of one
idea - and for EACH of them:

  - the core mechanism, in prose (pseudocode only if prose is genuinely
    insufficient);
  - what it gets RIGHT cheaply;
  - its FAILURE MODES, stated as concretely as your F5 answer was - which
    content defeats it, and what the viewer sees when it fails;
  - its computational character (single pass? two pass? per-region state?);
  - and its chroma story for 4:2:0 specifically, since the luma/chroma grid
    divergence in the frame-coded-interlaced case is our central problem.

EXPLICITLY INCLUDE approaches you would NOT recommend, with the reason - a
rejected option with a clear reason is as useful to us as a recommended one.
And explicitly argue AGAINST our current leanings wherever you can: we are
leaning toward per-region decision-making seeded by the declared mode, and
we would rather hear the strongest case against that now than discover it
in testing.

---

## 3. One specific challenge we want you to argue both sides of

Is per-region CLASSIFICATION (infer the coding structure, then filter
accordingly) even the right frame for this problem?

The alternative your own F6 material points at: measure BLOCK-BOUNDARY PHASE
directly from the pixels - where does the blockiness energy actually sit, at
an 8-row consecutive period or a 16-row staggered period, per region, per
plane - and filter where the artefact demonstrably is. That approach never
needs to know dct_type at all; it degrades gracefully when an encoder did
something unexpected; and it extends naturally to validating the user's
declared mode instead of trusting it.

Argue the strongest case FOR classification over phase measurement, and the
strongest case for the reverse. If a hybrid is genuinely better than either,
say precisely what each component contributes rather than gesturing at
"combine them".

---

## 4. Ground rules, as before

Mark clearly what is established knowledge, what is your reasoning, and what
is speculation. No citations are required in this round, and please do not
manufacture any; if a specific paper or implementation is genuinely
load-bearing for a point, name it and say plainly whether you can verify it.
We value a smaller answer of even reliability over a comprehensive-looking
one of mixed reliability.
