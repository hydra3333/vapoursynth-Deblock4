# Deblock4 - Covering Note for W3C: T1S01a4

**Deliverable:** T1S01a4_A - COVERING NOTE
**Version:** 1.1
**Date:** 2026-08-18
**Author:** W3D
**Route:** W3D -> W3X -> W3C
**Accompanies:** `T1S01a4_A_Ledger_Section23_Tail_v1_1.md`
**Encoding:** US-ASCII; CRLF.

---

## Before anything else

Check that the complete `dev_documentation` corpus and the `src` tree are in
front of you. If either is missing, STOP and ask. Silence is not agreement, and
a METHOD problem goes at the TOP of your response.

Two documents in this package are newer than the ones you used last time and
both bind you:

```text
Deblock4_T1_W3C_Review_Scope_v1_11.md              was v1.10
Deblock4_Standing_Task_Register_T_Series_v1_16.md  was v1.14
```

## What changed in the scope, because it is your own rule that changed

You verified W3D's STAY-CANONICAL evidence requirement and refined it. W3X
adopted your wording. Scope v1.11 now reads: an entry claiming STAY-CANONICAL
must name AT LEAST ONE concrete non-canonical copy and its location; it SHOULD
record others found by the sweep; it MUST NOT imply the list is exhaustive
unless a recorded sweep establishes exhaustiveness.

One paragraph of reasoning was added that you did not give, and you should
check it: the reason an implied inventory is wrong is not only that it
overclaims, but that this scope already has a field for coverage claims - the
SWEPT field - where the search is recorded and can be attacked. An inventory
sitting in the action field would be a coverage claim with no search behind it.

Your observation that your earlier clearance had checked COMPLIANCE with the
new criterion and mistaken that for VERIFICATION of it is recorded at register
DEC-44, as a failure mode distinct from the sweep failures at DEC-41, with the
rule that follows it: when a package explicitly invites you to attack a
criterion, the response must answer that invitation, even if only to accept it
and say why. That rule binds W3D symmetrically - an invitation W3D ignores is
the same defect.

## What this sub-tranche is

Section 23's tail - steps 6 to 10, the old-roadmap shorthand block, and the
prerequisites sentence - plus the ordering defect you found, carried in from
register DEC-32 because it is a property of the range rather than of any single
line.

```text
THE DEFECT: step 8 builds the ReleaseSafe scalar oracle; step 9 decides the
Schedule-SA/SB winner and freezes the canonical algorithm; and line 1153 says
the winner becomes part of that oracle. Verification and Tiering Decisions
section 20.2 makes it sharper still - it lists SCHEDULE among the
independently authored obligations the oracle-construction scope is accepted
AGAINST, so under the ratified acceptance rule the schedule is an INPUT to
that scope, not a later decision.
```

## Two things W3X has already decided, and you are told rather than left to
## infer them

```text
1. W3X PROVISIONALLY ADOPTS LED-029's TWO-ARTIFACT REPAIR, SUBJECT TO YOUR
   REVIEW - register DEC-45. It is NOT ratified.
   YOU ARE NOT BEING ASKED TO AGREE WITH W3X. A provisional position exists
   so that work can continue while it is tested; it is a thing to attack,
   and if you think the two-artifact distinction is wrong, say so plainly.
   The adoption falls if you refute it. You are told about it because a
   reviewer who later discovers the client had already taken a position has
   reason to distrust the whole exchange.

2. THE ACCEPTANCE GAP IS REGISTERED OPEN at DEC-46, owed to Verification and
   Tiering Decisions, and is a blocker on the candidate-building scope
   rather than on T1. W3D deliberately did NOT close it: writing that
   acceptance basis would be W3D authoring the criteria for W3D's own future
   deliverable. Your view on whether the gap is real and that wide is still
   wanted.
```

## ONE ITEM REQUIRES AN EXPLICIT VERDICT AND WILL BE RE-ASKED UNTIL IT GETS
## ONE

```text
REGISTER DEC-47 - THE TWO SENSES OF "FREEZE" AT LED-026.

W3D argues that step 7 fixes a CANDIDATE algorithm - held constant because
section 14.4 requires identical thresholds and formulas across SA and SB -
and that step 9 freezes the CANONICAL one. On that reading YOUR earlier
warning, that step 7 freezes thresholds while Appendix D still lists them
unresolved, dissolves: Appendix D describes today, and step 7 is the step
that changes it.

STATE PLAINLY EITHER:
    the two-senses reading holds and your warning is dissolved; OR
    it does not, and the step 7 defect is live.

SILENCE DOES NOT DISCHARGE THIS - DEC-44. If this response does not answer
it, it is re-asked in the next package and stays open until answered.

WHY IT IS PINNED THIS HARD: it is W3D's own argument dissolving a warning
raised against W3D's own area, and it is the kind of item that quietly
disappears while everyone looks at the bigger entry next to it.
```

## What to attack, in order of what is most likely wrong

```text
1. LED-029'S DERIVED HALF. The finding is easy; the REPAIR is new designer
   reasoning and rests on a distinction the ratified text does not draw -
   that the scalar COMPARISON INSTRUMENTS and the ACCEPTED oracle are
   different artifacts with different acceptance bases. If that is wrong, or
   if the project cannot afford two scalar implementations, the repair fails.
   IT IS BUILT AROUND YOUR CONSTRAINT - you declined to propose a step swap
   because candidates may be needed to compare schedules at all. Check that
   it honours that rather than merely citing it.

2. THE ACCEPTANCE GAP THE REPAIR EXPOSES. If the candidates are not the
   oracle, section 20.2's construction exception does not cover them, and
   20.1 has nothing to diff them against. W3D states this as an open question
   for W3X rather than answering it. Is it real, and is it that wide?

3. LED-026'S CLAIM THAT "FREEZE" IS USED IN TWO SENSES. This is offered as
   the resolution of your earlier threshold warning. If it is wrong, the
   warning is still live.

4. THE UNIFORMITY. Six of eight entries are CURRENT-DUPLICATE with POINTER.
   That may be correct - a sequence list restating work other sections own -
   or it may be one judgement applied eight times. LED-032 is the deliberate
   exception, dispositioned OPERATIVE-SPEC because the project is obeying it
   right now; if that reasoning is wrong it is wrong in a way that would
   affect its neighbours too.
```

## Two things about method, stated so you can check them rather than trust them

The ledger set was swept for overlap BEFORE this ledger was written, and the
overlap is excluded in section 0 rather than re-derived. That is the direct
countermeasure to the last sub-tranche's error, where the designer reported an
already-adjudicated statement as a fresh find. Section 0 names what T1S01a2
already owns in this document; if it names something wrongly, that is a method
finding.

No entry here claims STAY-CANONICAL, so your refined rule is not exercised.
That is itself worth a moment: it means the ledger asserts section 23 owns
nothing in this range except the prerequisites sentence. If that is too tidy,
say so.

## Where this sits

```text
T1S01a5  Appendix E, and the FINAL sub-tranche of this document. Whole-
         document cross-entry consistency is checked THERE and nowhere
         earlier. Three things are already owed to it by name: LED-023's
         deferred provenance claim; T1S01a2's old-format duplicate entries;
         and LED-020/LED-021's exhaustive-sounding copy lists.
```

Nothing in this package changes any authority document. Every remedy in every
ledger is a PROPOSAL awaiting W3X. The MPEG-2 authority is still v1.05 and that
is deliberate.

---

*Revision history*
```text
v1.1 (2026-08-18) Accompanies ledger v1.1. Adds W3X's provisional adoption
     of the two-artifact repair, stated openly with the warning that it is
     to be tested and not confirmed; the registration of the acceptance gap
     as open and blocking the candidate scope; and the must-answer status of
     the two-senses-of-freeze question, which is re-asked until answered.
v1.0 (2026-08-18) Accompanies the first T1S01a4 ledger. Records the scope and
     register advances, the adoption of W3C's refined STAY-CANONICAL evidence
     wording, and the new failure mode at DEC-44. Directs review at LED-029's
     derived repair, the acceptance gap it exposes, the two-senses-of-freeze
     argument, and the uniformity of the dispositions.
```
