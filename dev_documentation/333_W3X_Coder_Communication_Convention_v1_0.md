# Deblock4 - W3X Communication Convention for W3C (Coder)

**Deliverable:** W3X-CODER-COMMS-CONVENTION
**Version:** 1.0
**Date:** 2026-08-13
**Author:** W3X (coordinator; drafted by W3D at W3X direction)
**Route:** W3X -> W3C
**Status:** STANDING PROCESS INSTRUCTION. Applies to every W3C document and
message. It changes HOW you communicate with me, not WHAT the project decides
or any ratified technical content. Companion to the designer convention
(333_W3X_Designer_Communication_Convention v1_1 or later); the two are
deliberately parallel.
**Encoding:** US-ASCII; CRLF.

---

# 1. Why this exists

Your job produces precise, heavily-labelled artifacts - knowledge-item
numbers, ratified-decision tags, charter rule names, gate identifiers. Those
labels are right for the audit trail and for the designer. They are wrong as
the LANGUAGE you use with me. I am the human who has to understand what you
did and decide what happens next, often after time away, without five
documents open. When a message to me is a lattice of IDs, I have to excavate
it before I can act. The tag should be the FOOTNOTE, not the sentence.

# 2. The rule: plain English to W3X, always

- Write to me in ordinary words. Expand any abbreviation, ID, or project
  code the FIRST time it appears in a message, in the same sentence - for
  example "the checklist item that says vector counts are element counts,
  never bytes (K1)" - after which the short form is fine.
- Never send me a sentence that is mostly capital letters and numbers. If
  you catch yourself writing one, rewrite it in plain words and move the
  codes to a trailing refs line.
- Keep all your internal precision for the places it belongs: the delivery
  manifest, the findings register, the refs lines. Nothing in this
  convention weakens the audit trail; it moves it out of my reading path.

# 3. Decisions and questions for me: self-contained, in one place

For ANY item that needs a W3X decision, confirmation, or choice:

```text
(a) A plain-English statement of the question. One or two sentences, no ID
    required to understand it.
(b) Why it matters - the consequence of getting it wrong. One or two
    sentences.
(c) Your recommendation, stated plainly ("I recommend X"), with the one-line
    reason. Do not hand me a neutral menu.
(d) The options, if there is a real choice - each labelled in words, with
    its trade-off in a few words.
(e) THEN the IDs, last, as a refs line - "(refs: K19c, 4C-RAT-3)".
```

Put every such item in ONE clearly headed section near the TOP of your
response - "DECISIONS/QUESTIONS FOR W3X" - numbered Q1, Q2, Q3. I answer by
those numbers. If there are none, say so in one line; silence is not "no
questions".

This applies with full force to the pre-implementation response each stage
scope requires: its questions section is written for ME in this form, and
the deep per-item analysis stays in the body for W3D and the record.

# 4. Reporting work you have done

- Describe checks and results descriptively and honestly: what you ran or
  reasoned, what you observed, what you did NOT verify. Remember the
  standing rule: you never claim PASS - I run the validation, and the
  verdict is mine (charter C-DELIV-07).
- Lead with the plain-English summary (three to six sentences a human can
  absorb); put the detailed evidence after it.
- If something surprised you or you are uncertain, say so plainly. A stated
  doubt is worth more to me than polished confidence.

# 5. Tone and length

- Direct, practical, efficient. I have decades of development experience:
  do not over-explain basics, and never make me keep a glossary open.
- One question per item; never bundle two decisions behind one tag.
- Never ask me to confirm something you can check yourself in the material
  you were given - check it, state what you found, and ask only the genuine
  residual question.

# 6. What does NOT change

- The three-way process, the numbered findings, the ID tags for the audit
  trail, cold source verification, the knowledge-sweep duty, the delivery
  package rules, and US-ASCII CRLF deliverables with bumped versions.
- Nothing technical or ratified is reopened by this document.

# 7. One worked contrast (illustrative only)

```text
INSTEAD OF (what makes me excavate):
  "T5 mutant leg: K14 not implicated; RAT-6 site dead per ladder N==1
   analysis; propose relocation per S4C-4 to the L==1 path."

WRITE (what lets me act):
  Q1. The test that deliberately corrupts a copy of the code is injecting
      its corruption into a line the real filter never executes, so the
      corrupted build behaves normally and the control cannot prove
      anything.
      Why it matters: an ineffective corruption test would let a real
      fault pass validation unnoticed.
      Recommendation: move the injected corruption to the final-column
      code path the filter genuinely runs; I have verified that path
      executes in both the unit tests and the end-to-end cases.
      Decide: [Move the corruption site]  or  [Keep it and accept a
      weaker control].
      (refs: 4C-RAT-6, S4C-4, tail ladder N==1 analysis)
```

Same content, same tags preserved at the end - and I can answer in ten
seconds.

---

Revision: v1.0 (2026-08-13) initial coder communication convention,
parallel to the designer convention v1.1.
