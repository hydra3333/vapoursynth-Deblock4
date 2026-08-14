# Deblock4 - W3X Communication Convention for W3D (Designer)

**Deliverable:** W3X-DESIGNER-COMMS-CONVENTION
**Version:** 1.1
**Date:** 2026-08-05
**Author:** W3X (coordinator)
**Route:** W3X -> W3D
**Status:** STANDING PROCESS INSTRUCTION. Applies to every W3D document and
message that asks W3X to decide, confirm, or choose anything. It changes
HOW you communicate with me, not WHAT the project decides or any ratified
technical content.
**Encoding:** US-ASCII; CRLF.

---

# 1. Why this exists

Your technical work is strong and the audit trail (numbered findings,
ratification-ready wording, ID tags) is exactly right and must continue.
But the recent documents address W3X as if I were a router between you and
W3C - a reader who already holds every ID in memory and only needs the tag
to act. I am not that reader. I am the human who has to UNDERSTAND each
decision and make it, often after time away, without re-reading five
documents to reconstruct what a tag means.

Right now, to answer one of your questions I have to: find the ID, find the
other IDs it refers to, search the source or the charter to learn what each
one is, and only then work out what you are actually asking me and what you
recommend. That is backwards. The tag should be the FOOTNOTE, not the
question.

A prior W3D established a convention that set me up to decide quickly and
correctly. This document restores it as a standing rule.

# 2. The rule: every decision I am asked to make is self-contained and in plain English

For ANY item that needs a W3X decision, confirmation, or choice, write it so
I can decide from that item ALONE, without looking anything up. Each such
item must contain, in this order:

```text
(a) A plain-English statement of the question - what is being decided, in
    ordinary words, no ID required to understand it. One or two sentences.
(b) Why it matters - the consequence of getting it wrong, or why it can't
    just be left as-is. One or two sentences.
(c) Your recommendation - your actual leaning, stated plainly ("I
    recommend X"), with the one-line reason. You are the expert; tell me
    what you would do. Do not hand me a neutral menu and make me choose
    blind.
(d) The options, if there is a real choice - each labelled in words, not
    just letters, with the trade-off of each in a few words.
(e) THEN the IDs, at the end, as a reference line - "(refs: F2a, C-STY-10,
    D0 K30)". This is for the audit trail and for W3C. It is the last
    thing in the item, not the first.
```

If an item is a simple confirm-this-fact, (a)+(c) is enough: state the fact
in plain words and tell me your recommended answer.

In addition to it being in the draft scope-or-response-to-scope-review document,
please surface decisions/questions to me n a similar same manner directly in the
chat so that I know there are decisions/questions to address with you.

# 3. Structure: decisions first, in one place, not scattered

- Put everything you need from me in ONE clearly headed section, near the
  TOP: "DECISIONS W3X NEEDS TO MAKE". I should be able to read that one
  section, answer every question, and be done - without hunting through
  the body.
- Number the questions simply and sequentially (Q1, Q2, Q3 ...) in THAT
  section. These are MY handles - separate from your internal F/D/K IDs.
  I answer "Q1: yes, option Reissue" and you map it back to the IDs.
- An item's cross-references to other IDs belong in its refs line (2e),
  not woven through the question text. If understanding Q3 truly requires
  knowing Q1's outcome, say so in plain words ("this only applies if you
  choose Reissue at Q1"), do not send me to find another tag.
- The detailed per-ID analysis, ratification-ready wording, and source
  citations stay where they are, LATER in the document, for the record and
  for W3C. I read those only if a plain-English question makes me want the
  detail. The top section is the interface; the body is the evidence.

# 4. Tone and length

- Write to me as the prior W3D did: warm, direct, efficient, setting me up
  for success. Lead me to good decisions; do not make me excavate them.
- Brevity in the question section is a feature. If a question needs three
  sentences of plain English plus a recommendation, that is better than
  half a line of IDs I have to decode.
- One question per item. Do not bundle two decisions behind one tag.
- Never ask me to confirm something you can verify yourself against the
  repo - verify it, state what you found, and ask only the genuine
  residual choice. (You have direct repo access; use it before asking.)

# 5. What does NOT change

- The three-way scope-review process itself: you investigate and form
  views, ask me plain-English questions, (re)form the scope, three-way
  back-and-forth with you AND W3C each giving me plain-English questions
  and recommendations, I answer and exchange documents, converging on the
  agreed scope set.
- Numbered findings, ID tags, ratification-ready quoted wording, cold
  source verification, the D0 knowledge-sweep discipline, US-ASCII/CRLF
  downloadable .md deliverables with bumped versions - all unchanged.
- Nothing technical or ratified is reopened by this document.

# 6. One worked contrast (illustrative only)

```text
INSTEAD OF (what makes me excavate):
  "F2a CONFIRMED. C-STY-10 applies and is unmapped. Adopt as K30."

WRITE (what lets me decide):
  Q2. A charter styling rule (C-STY-10) turns out to apply to this scope
      but isn't recorded in our knowledge index, so a future reader could
      miss it.
      Why it matters: unrecorded rules get violated by accident later.
      Recommendation: I recommend we record it as a new knowledge item
      (K30) - it costs nothing and closes the gap.
      Decide: [Record as K30]  or  [Leave unrecorded with a noted reason].
      (refs: F2a, C-STY-10 -> proposed D0 K30)
```

Same content, same IDs preserved at the end - but now I can answer in ten
seconds without opening another file.

---

# 7. General plain-English duty (added v1.1; applies to ALL communication)

The rule in section 2 governs decision items. This section extends the same
principle to EVERYTHING you write to me, decision or not:

- Expand any abbreviation, ID, or project code the FIRST time it appears in
  a message, in the same sentence ("the rule that forbids Git commands in
  delivery scripts (C-DELIV-10)"), after which the short form is fine.
- Never send me a sentence that is mostly capital letters and numbers. If
  you catch yourself writing one, rewrite it in ordinary words and move the
  codes to a trailing refs line.
- Status updates, findings, and explanations get the same treatment as
  questions: plain words first, tags last. I should never need a second
  document open just to read your message.

# 8. Companion convention for the coder

The same principles now bind W3C through the companion document
333_W3X_Coder_Communication_Convention (v1_0 or later). The two conventions
are deliberately parallel; if they ever diverge on a shared principle, raise
it rather than picking one silently.

---

Revision: v1.1 (2026-08-13) added section 7 (general plain-English duty for
all communication) and section 8 (pointer to the new coder companion
convention). Amendment drafted by W3D at W3X direction.
Revision: v1.0 (2026-08-05) initial standing communication convention.
