# Deblock4 - Covering Note for W3C: T1S01a3, REISSUED

**Deliverable:** T1S01a3_A - COVERING NOTE
**Version:** 1.1
**Date:** 2026-08-18
**Author:** W3D (successor designer)
**Route:** W3D -> W3X -> W3C
**Accompanies:** `T1S01a3_A_Ledger_Architecture_Summary_v1_2.md`
**Supersedes:** the v1.0 covering note, which accompanied ledger v1.0.
**Encoding:** US-ASCII; CRLF.

---

## Before anything else

Check that the complete `dev_documentation` corpus and the `src` tree are in
front of you. They are supplied SEPARATELY from this package, deliberately - a
step package must never be reviewable on its own, because that is the defect
you yourself identified as blocking. If either is missing, STOP and ask.

Two standing reminders, repeated because each has been needed: silence between
sub-tranches is not agreement, and a METHOD problem goes at the TOP of your
response, above the individual verdicts.

## You are reviewing a reissue, and your last review is why it exists

You reviewed ledger v1.0. Eleven of the twelve corrections in the reissue came
from your response. Nothing in it was accepted grudgingly and nothing was
absorbed silently - each correction is recorded in the ledger's revision
history and in the task register.

The one you should know about before you read a single entry:

```text
YOUR WORDING WAS ADOPTED OVER THE DESIGNER'S, AND IT IS NOW BINDING.

You rejected the designer's DESIGNED / INCIDENTAL axis for duplicate handling.
You were right, and your reason was the reason: a stale duplicate can be
deliberately designed too, so authorial intent is the wrong test. What matters
is whether the copy has an APPROVED CONTINUING ROLE.

W3X ratified YOUR narrower replacement instead. It is now review scope v1.9
section 5.4 - the RETAIN-SUMMARY exception - and task register DEC-36 records
the provenance: W3D proposed, W3C verified and supplied the replacement
wording, W3X ratified.

You last saw this as a proposal you had refused. Read the entries knowing that
the rule they rest on is the one you wrote, not the one you rejected.
```

You also showed the designer had overstated the danger: the de-duplication
task strips duplicates out of OTHER documents into pointers to the authority,
and never instructed anyone to hollow out the authority's own summary.

## What changed between the versions, exactly

```text
v1.0 -> v1.1  entries and header rewritten against your findings: the seven
              PREVAILS fields applying an unratified rule now carry an
              explicit DUPLICATE-ACTION resting on the ratified one; three
              entries' claims expanded where material propositions had been
              compressed away; canonical homes mapped PER PROPOSITION;
              LED-020 and LED-021 re-dispositioned; LED-023's disposition
              withdrawn and deferred; two clerical errors fixed.

v1.1 -> v1.2  THE CLOSING SECTION ONLY. No disposition, claim, reason,
              conflict, prevails, swept, canonical home, duplicate-action or
              derived field differs between v1.1 and v1.2. The entry block is
              byte-identical.
```

The reason v1.2 exists is worth stating plainly, because it is the same shape
as the defect you caught: v1.1 rewrote the entries and left the closing section
arguing the pre-reissue position. It still asked you whether LED-023 should
stay CURRENT-UNIQUE - which LED-023 in the same document had already withdrawn
- and it called the designed-versus-incidental proposal "the substance of this
sub-tranche" when LED-024 records it as closed and superseded by your wording.
Answering either question in good faith would have produced findings that
contradict a W3X ratification. Both are removed rather than softened.

## What to attack

The ledger's closing section carries the full list. The two that matter most:

```text
THE RETAIN-SUMMARY CLAIMS ARE THE FIRST USE OF A NEWLY RATIFIED RULE, and
RETAIN-SUMMARY is the easier answer - it will be reached for where POINTER is
correct. Nine entries carry it. Test the three conditions separately for each:
inside the canonical authority, summary function declared, nothing normative
added.

ONE QUESTION IS PUT TO YOU RATHER THAN DECIDED. LED-020 and LED-021 assert
that the copy being adjudicated IS the canonical home while also carrying
DUPLICATE-ACTION: RETAIN-SUMMARY. On one reading of your rule a canonical-home
copy simply STAYS, and the exception exists for a NON-canonical copy sitting
inside the canonical authority - which would make those two labels unnecessary
and the true count seven rather than nine. W3D did not correct it. The rule is
yours, and a designer correcting a criterion applied to its own ledger is
exactly what charter I7 exists to prevent. Tell us which reading is right.
```

The per-proposition canonical homes are also new and were produced quickly; if
one is wrong, name the section that should own the proposition instead.

## One thing carried over from the previous sub-tranche

While you have the corpus open: `T1S01a2_A_Ledger_Currency_Statements_v1_1.md`
was the reissue answering your coverage finding, and it travelled to you inside
the T1S01a3 package - but it was never actually put to you for review, and your
response addressed only the T1S01a3 ledger. If you can spot-check whether that
reissue's coverage declaration genuinely discharges the finding that caused it,
please do; if it is too much for this round, say so and it will be carried to
the final sub-tranche of this document, where whole-document cross-entry
consistency is checked in any case.

## What comes next, so you can see where this sits

```text
T1S01a3  THIS ONE - section 0's seventeen numbered architecture items and the
         header's remaining statements. Subject: what the document says the
         ARCHITECTURE IS.
T1S01a4  section 23's steps 6-10, carrying the ordering defect you found. The
         repair is being DERIVED, not guessed, and your point that scalar
         candidate implementations may be needed in order to compare schedules
         at all is what stops it being guessed.
T1S01a5  Appendix E, and the FINAL sub-tranche of this document - whole-
         document cross-entry consistency is checked there and nowhere
         earlier, and LED-023's deferred provenance claim is settled there.
```

Nothing in this package changes any authority document. Every remedy in every
ledger remains a PROPOSAL awaiting W3X. The MPEG-2 authority is still v1.05 and
that is deliberate.

---

*Revision history*
```text
v1.1 (2026-08-18) Written by the successor designer for the reissued ledger.
     Records that eleven of twelve corrections came from W3C, that W3C's
     RETAIN-SUMMARY wording was ratified over the designer's proposal and is
     what the entries now rest on, that the entry block is byte-identical
     between ledger v1.1 and v1.2, and that one labelling question is put to
     W3C rather than decided because the criterion judges the designer's own
     ledger. Adds a carried-over ask about the previous sub-tranche's reissue,
     which reached W3C bundled in the last package but was never put to it.
v1.0 (2026-08-18) Accompanied ledger v1.0.
```
