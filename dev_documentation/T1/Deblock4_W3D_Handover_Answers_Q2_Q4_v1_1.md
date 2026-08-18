# Deblock4 - Outgoing W3D Answers to Successor Designer Questions Q2-Q4

**Deliverable:** W3D-HANDOVER-ANSWERS
**Version:** 1.1
**Date:** 2026-08-18
**Author:** outgoing W3D (designer chat 4)
**Route:** W3D -> W3X -> successor W3D
**Nature:** RECORD, with one judgement clearly marked as such. Nothing here
decides anything; W3X decides.
**Encoding:** US-ASCII; CRLF.

---

# Q2. Has the reissued third sub-tranche gone to W3C?

## ANSWER: NOT YET ISSUED. It is still with the designer side.

```text
FACT, from the outgoing designer's own record of what it produced:

  T1S01a3_A_Ledger_Architecture_Summary_v1_1.md  WAS produced, at the very
      end of the session, and presented to W3X.
  A COVERING NOTE AT v1.1 WAS NEVER WRITTEN. The only covering note is the
      v1.0 one that accompanied the original issue.
  NO W3C RESPONSE TO v1.1 EXISTS. The only response file,
      T1S01a3_B_Coder_Response_v1_0.md, reviews v1.0 and predates the reissue.
```

Your reading of the supplied set is correct and your inference from it is
correct. So the answer is your first option: **[Not yet issued - write the
note]**.

## What the covering note needs to say that the v1.0 one did not

W3C is memoryless and will receive the reissue cold. Three things it cannot
work out for itself:

```text
1. THAT ITS OWN FINDINGS DROVE THE REISSUE. Eleven of the twelve corrections
   came from W3C's T1S01a3_B response. Say so plainly - it is the difference
   between a reviewer checking a document and a reviewer checking whether it
   was listened to.

2. THAT THE RULE IT PROPOSED IS NOW RATIFIED AND BINDING. RETAIN-SUMMARY is at
   review scope v1.9 section 5.4, IN W3C's WORDING rather than the designer's,
   recorded at task register DEC-36. The reissue's DUPLICATE-ACTION fields rest
   on it. W3C should be told its wording was adopted over the designer's,
   because it will otherwise be reviewing entries against a rule it last saw as
   a proposal it had rejected.

3. WHAT TO ATTACK. The reissue's own weak points are the seven RETAIN-SUMMARY
   claims - RETAIN-SUMMARY is the easier answer and will be reached for where
   POINTER is correct - and the per-proposition canonical homes, which are new
   and which the designer produced quickly.
```

---

# Q3. The closing section still asks two settled questions

## ANSWER: your finding is correct, and your reading of its shape is correct.

```text
WHAT HAPPENED: the reissue rewrote the ENTRIES and the header, and left the
closing "What W3C is asked here" section as it stood in v1.0. So the document
now asks W3C:

  - whether LED-023's blanket provenance claim should stay CURRENT-UNIQUE,
    when the same document's LED-023 has already WITHDRAWN that disposition
    and deferred it to T1S01a5;
  - whether the designed-versus-incidental distinction is needed, calling it
    "the substance of this sub-tranche", when LED-024 in the same document
    records the proposal as CLOSED and superseded by W3C's ratified
    RETAIN-SUMMARY wording.
```

**And you are right that this is the same shape as the defect that caused the
reissue.** In both cases part of the document was not brought to the ratified
position, and in both cases the stale part is the part that tells the reviewer
what to think. The first time it was seven PREVAILS fields applying an
unratified rule; this time it is a closing section inviting a reviewer to
reopen a ratified one. Recording that as a pattern rather than two incidents is
worth more than the fix itself: **the designer updates what it is thinking
about and leaves the framing text behind.**

## RECOMMENDATION: correct before issue - your first option.

The cost of not doing so is not just a wasted W3C round. A reviewer answering
those questions in good faith would produce findings that CONTRADICT a ratified
W3X decision, and someone then has to work out that the reviewer was answering
a stale question rather than disagreeing with the ratification. That is
expensive to untangle and easy to prevent.

Issue it as a3 v1.2, closing section only, no entry touched. Note in the
revision history that the entries are unchanged from v1.1, so W3C knows it does
not need to re-review them.

## What the corrected closing section should ask instead

```text
1. Are the seven RETAIN-SUMMARY claims justified under the ratified rule -
   is each copy really inside the canonical authority, is its summary function
   really declared, and does it really add nothing normative?
2. Are the per-proposition canonical homes right? They are new in v1.1 and
   were produced quickly.
3. Is the expanded coverage now complete - especially LED-019's twelve open
   items and LED-015's span descriptor contents, which were the two worst
   omissions in v1.0?
4. LED-020 and LED-021 changed disposition. Is CURRENT-DUPLICATE with the
   authority header as canonical home the right call, or does one of them
   belong somewhere else?
```

---

# Q4. Three orientation documents with stale pointers

## ANSWER: I disagree with your recommendation, and the reason is a fourth
## defect you did not list.

Your instinct to batch currency work is sound in general and matches W3C's
request not to interrupt the sweep. But the three items are not equivalent, and
one of them is not a stale pointer at all.

## STATUS: FIXED. Designer introduction v1.26 is issued.

W3X directed the immediate fix. What follows records what was wrong and what
was done, because the second instance below was NOT in the original question
and a successor should know the defect occurred twice in one document.

## The designer introduction's checklist was NOT merely stale

Section 8, item 5, currently reads:

```text
"5. Immediate designer action: T5 detector/feature mathematics, then T6 Q14
    experiment plan unless W3X directs another bounded task. ONE COORDINATED
    PACKAGE IS ACCEPTABLE ONLY IF T5 IS FROZEN BEFORE HELD-OUT JUDGEMENT."
```

Two separate problems, and the second is the one that matters:

```text
STALE SEQUENCE - which you identified. It tells a fresh designer the immediate
    action is T5, contradicting the same document's front matter and the
    ratified T1-first decision at DEC-02.

A WITHDRAWN PERMISSION, STILL LIVE - which you did not. The coordinated T5+T6
    package permission was WITHDRAWN by W3X at DEC-03, and the T1S01a2 ledger
    dispositioned the authority's copy of that same permission SUPERSEDED. This
    checklist is now the only live document still offering it.
```

That is not a pointer that sends someone to an old version. It is an
instruction to do the wrong task, plus a permission the project has explicitly
revoked, sitting in the checklist a fresh designer is told to follow in its
FIRST RESPONSE. A successor doing exactly as instructed would propose a
combined T5+T6 package as its opening move.

Item 2 of the same checklist also pins Project Status v1.28, two generations
stale.

**Item 5 and item 2 are fixed in v1.26.** Item 5 now names the T1 sweep as the
immediate action, points at the resume brief section 0a for current sub-tranche
state, and states explicitly that the coordinated-package permission is
WITHDRAWN and must not be proposed. Item 2's pinned Project Status version is
replaced with "highest committed version", and it now notes that the MPEG-2
authority being at v1.05 is deliberate.

## A SECOND INSTANCE OF THE SAME DEFECT, found while making that edit

Reading-list item 2a described the task register as carrying:

```text
    "T1-T7 dependencies, including T1 PAUSED, T5 FIRST, then T6"
```

Same withdrawn sequence, same document, a different section - and it sits in
the READING LIST, so a successor meets it before reaching the checklist that
was already being corrected. Two independent places in one orientation document
still instructing a fresh designer to follow a sequence W3X reversed on
2026-08-17.

Item 2a now states the correct order and adds a line saying explicitly that
ANY older text claiming T1 is paused or T5 is next is STALE - which is worth
more than the correction itself, because that text exists elsewhere and will be
met again.

Version pins in reading-list items 1, 2a and 3 were replaced with "highest
committed version" in the same pass.

## Why this matters more than the count of fixes

The successor found one instance by reading the checklist. The second turned up
only because someone opened the document to edit the first. That is the same
lesson the project keeps relearning in different clothes: **the defect is
rarely alone, and finding one is a reason to sweep the document rather than a
reason to close the item.**

## The other two can wait, and I would batch them as you suggest

```text
CODER INTRODUCTION v1.32 - points at Project Status v1_29 and task register
    v1_7. Both are "(or later)" style pointers in a document whose reader is
    handed the current corpus anyway, and the coder's actual binding document
    is the review scope. Low harm. BATCH.

SESSION BOOTSTRAP HEADER v1.2 - pins "charter v1_29 at this writing". The
    header is a CODING-session artifact and no coding session is possible
    before Q14. It also already says W3X corrects it at issuance. Lowest
    harm of the three. BATCH.
```

## A suggestion about the batch itself

When you do it, consider removing the pins rather than updating them. Both of
those documents have now staled twice by carrying a specific version number
where "highest committed version" would have been correct and self-maintaining.
The resume brief v1.2 has just been rewritten on exactly that principle, and
the designer introduction and blurb were changed the same way. A pinned version
in an orientation document is a scheduled defect.

---

# One thing I would add, unasked

You found all three of these in your first substantive pass, and Q3 in
particular required noticing that a document contradicted itself between its
body and its closing section. That is the failure mode this project keeps
producing, and the reason it keeps being caught is that somebody reads the
whole artifact rather than the part they are working on.

The four-instance failure pattern recorded at task register DEC-37 is written
as a prediction, not as history. Expect to commit that class of error yourself.
The countermeasure that has actually worked, four times out of four, is not
care - it is W3C reading the source instead of the ledger.

---

*Revision history*
```text
v1.0 (2026-08-18) Answers to successor designer questions Q2-Q4 from the
     outgoing designer chat. Q2 answered from record: the reissue was never
     issued and no v1.1 covering note exists. Q3 confirmed, with the
     observation that it is the same shape as the defect that caused the
     reissue. Q4 answered against the successor's recommendation on one of
     three items: the designer introduction's first-response checklist carries
     a WITHDRAWN permission and an instruction to do the wrong task, not
     merely a stale pointer, and should be fixed immediately rather than
     batched.
v1.1 (2026-08-18) Records that W3X directed the immediate fix and that designer
     introduction v1.26 is issued. Adds a SECOND instance of the same defect,
     found while making the first edit: reading-list item 2a also described the
     register as carrying "T1 paused, T5 first, then T6". Two independent
     sections of one orientation document were still instructing a fresh
     designer to follow a reversed sequence. Q2 and Q3 answers unchanged.
```
