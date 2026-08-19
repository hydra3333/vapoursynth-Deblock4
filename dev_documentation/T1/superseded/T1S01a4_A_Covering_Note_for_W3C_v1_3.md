# Deblock4 - Covering Note for W3C: T1S01a4

**Deliverable:** T1S01a4_A - COVERING NOTE
**Version:** 1.3
**Date:** 2026-08-18
**Author:** W3D
**Route:** W3D -> W3X -> W3C
**Accompanies:** `T1S01a4_A_Ledger_Section23_Tail_v1_3.md` - SECOND NARROW REISSUE
**Encoding:** US-ASCII; CRLF.

---

## Before anything else

Check that the complete `dev_documentation` corpus and the `src` tree are in
front of you. If either is missing, STOP and ask. Silence is not agreement, and
a METHOD problem goes at the TOP of your response.

Two documents in this package are newer than the ones you used last time and
both bind you:

```text
Deblock4_T1_W3C_Review_Scope_v1_11.md              UNCHANGED - you used
                                                   v1.11 last time too
Deblock4_Standing_Task_Register_T_Series_v1_18.md  was v1.16 at your last
                                                   review; v1.17 was
                                                   superseded before you
                                                   saw it in a delta

CORRECTED AT v1.3: the previous note told you the scope "was v1.10". It was
not - your first a4 review explicitly recorded scope v1.11 and register
v1.16, exactly as supplied. That line was carried forward from an older note
without being checked, which is the same class of defect as everything else
in this round. You found it.
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

## You recommended against closing this sub-tranche. W3X agreed with you.

This is the narrow reissue you asked for, aimed at a delta review rather
than a restart.

```text
YOUR METHOD FINDING IS ACCEPTED IN FULL, AND IT WAS W3D's ERROR.

Ledger v1.1's coverage declaration asserted that the ledger set had been
swept for overlap and that the overlap was excluded rather than
re-derived. THE ASSERTION WAS FALSE. T1S01a2 LED-010 already adjudicates
authority lines 1703-1710 - the 2D/3D/4D/5D shorthand AND the prerequisite
sentence - and v1.1 re-adjudicated both.

WHAT MAKES IT WORSE THAN A MISSED SWEEP: that declaration WAS the
countermeasure adopted after the previous sub-tranche, where W3D reported
an already-ledgered item as a fresh find. The countermeasure was written
down and then not performed, and the writing was mistaken for the
performing. A false assurance is worse than a missing one, because it
tells the next reader not to check.

WITHDRAWN: LED-031 and LED-032. The source text stays with LED-010, whose
own atomicity repair is already owed to T1S01a5 - your option 1. The
adjudicated range is corrected to lines 1694-1700, and LED-010's
range-recording defect (1703-1710 recorded, sentence runs to 1713) is
recorded as an a5 item rather than fixed here.

THE NEW RULE, at register DEC-48: a claim that a check was performed must
NAME what was examined, in the same breath, or it must not be written.
Section 0 no longer says a sweep happened. It lists every T1S01a2 entry,
its range, and the comparison - so the claim can be tested by counting.
```

## Your four corrections, and where each landed

```text
LED-025  SWEPT now covers UNAFFECTEDNESS separately from duplication. You
         were right that a search for the D4-Q16 token proves duplication
         and says nothing about the T1/T5 reversal. The entry now records
         the sequencing decisions checked and what they do not reach.

LED-026  YOUR RERUN CONSTRAINT is now part of the DERIVED reading rather
         than a footnote to it, and the entry says plainly that W3D did
         not state it and you did. Without it the two-senses reading would
         license step 9 revising thresholds while keeping evidence
         gathered under the old ones.

LED-027  CANONICAL HOME corrected to the CHARTER's oracle-construction
         exception, with Tiering Decisions 20.2 as the detailed record.
         Verified cold rather than taken from your response: the charter
         carries the exception in full, SCHEDULE included in the
  obligations list.

LED-029  DERIVED refined to TWO ROLES AND TWO ACCEPTANCE STATES. Your
         point that this does not establish two permanent separately
         implemented codebases is now the wording, not a caveat on it.
         AND THE ROADMAP CLAIM IS WITHDRAWN - see below.

LED-030  canonical home corrected as LED-027, and charter G5 removed from
         the copy list. Verified cold at charter line 506: G5 is execution
         safety, a different proposition. G7 is the equivalence rule and
         is part of the canonical home rather than a non-canonical copy.
```

## One claim W3D withdrew entirely, because you refuted it

v1.1 argued that the roadmap, section 23 and the shorthand block arrange
these decisions three different ways, and offered that as evidence the
defect is structural. You showed the roadmap never says the WINNER is
selected at Stage 2D, and that build-candidates-at-2D, compare-and-select-
at-3D is compatible with the repair rather than contrary to it.

The claim is withdrawn, not softened. It was a supporting argument that
flattered the proposal it supported, and those should not survive their
refutation quietly. THE ORDERING CONFLICT STANDS WITHOUT IT, on line 1153
and the charter's acceptance rule alone.

## Two things W3X had already decided, restated because they still hold

```text
1. W3X PROVISIONALLY ADOPTS LED-029's TWO-ARTIFACT REPAIR, SUBJECT TO YOUR
   REVIEW - register DEC-45. It is NOT ratified.
   YOU ARE NOT BEING ASKED TO AGREE WITH W3X. A provisional position exists
   so that work can continue while it is tested; it is a thing to attack,
   and if you think the two-role/two-acceptance-state distinction is wrong,
   say so plainly.
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

## The nine corrections, for a mechanical delta check

```text
1. THE ENUMERATION. Population renamed to what it actually is - every entry
   in every prior T1 ledger - and enumerated per ledger. LED-001 and LED-002
   are now correctly placed in T1S01a1 with their real subjects.
2. LED-004's RANGE. Recorded as NOT cleanly outside, because its recorded
   range ends at line 1694 which IS step 6. Propositions still do not
   overlap. Registered for a5 at DEC-50 alongside LED-010's defect.
3. LED-025's sweep narrowed to DEC-02 and DEC-03, which ARE the reversal.
   The broader no-current-decision-changes-it claim is expressly NOT made.
4. LED-026's rerun constraint extended to all quality evidence that depended
   on the changed value - your full scope.
5. LED-026's pointer to withdrawn LED-031 replaced.
6. LED-027's PROPOSED ACTION now points at the charter, agreeing with the
   canonical home. The entry had contradicted itself.
7. LED-029's rejected one-artifact premise REMOVED from operative text and
   replaced throughout with two roles and two acceptance states, including
   the statement that what is proved is separation of status and acceptance
   basis, not object identity.
8. REGISTER DEC-45's title and body corrected the same way, rather than
   annotated - your point that a later corrective entry does not make an
   earlier decision's live wording safe to ratify by reference.
9. This note's currency statement corrected.

NOT REOPENED, and not worth your time: every disposition; LED-028 entire;
the finding halves of LED-025, LED-026, LED-027, LED-029 and LED-030 apart
from the fields named above.
```

## Your refinement of the check-evidence rule is ratified, in your wording

DEC-48 is replaced by the refined rule at DEC-50. You were right that the
original was too broad for a universal criterion: not every check has a
natural range, and demanding one would produce authors attaching artificial
ranges to hash checks and semantic comparisons - the form becoming the
evidence, which is the failure it was meant to prevent.

The register also records what your two findings demonstrate: the first
application of the rule was itself inaccurate, and BOTH errors were visible
only because the list existed to be counted. The assurance it replaced would
have produced neither finding. A countermeasure that fails visibly on first
use is working; the one it replaced failed invisibly for two sub-tranches.

## One thing about method

Two rounds ago this note asserted a sweep that had not happened. Last round
it enumerated one that had, inaccurately. This round the enumeration is
corrected and names its population properly. Count it rather than believe
it - that remains the whole point.

No entry here claims STAY-CANONICAL, so your refined evidence rule for that
action is still unexercised anywhere in T1. It will first be exercised at
T1S01a5.

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
v1.3 (2026-08-18) Accompanies ledger v1.3. Lists the nine corrections for a
     mechanical delta check, records the ratification of W3C's refined
     check-evidence wording at DEC-50, and corrects this note's own currency
     statement, which had claimed W3C previously used scope v1.10 when it
     used v1.11.
v1.2 (2026-08-18) Accompanies ledger v1.2, the narrow reissue. Accepts W3C's
     method finding in full and states plainly that v1.1's overlap-sweep
     assertion was false and was itself the countermeasure adopted after the
     previous sub-tranche's failure. Records where each of W3C's four
     corrections landed, and the withdrawal of the roadmap
     three-way-disagreement claim. Redirects the review at the delta rather
     than the whole ledger.
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
