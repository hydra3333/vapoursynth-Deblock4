# Deblock4 - T1S01a5 Covering Note: Authority Body Part 1

**Deliverable:** T1S01a5_A - COVERING NOTE
**Version:** 1.0
**Date:** 2026-08-19
**Author:** W3D
**Route:** W3D -> W3X -> W3C
**Accompanies:** `T1S01a5_A_Ledger_Body_Part1_v1_0.md`
**Binding review scope:** `Deblock4_T1_W3C_Review_Scope_v1_11.md`
**Binding work queue:** `Deblock4_Standing_Task_Register_T_Series_v1_23.md`
**Encoding:** US-ASCII; CRLF.

---

# DECISIONS W3X NEEDS TO MAKE

## Q1. The sub-tranche is split. Ratify the split, or reject it?

**What is being decided.** Whether authority sections 1-13 are adjudicated as
one sub-tranche or two.

**Why it matters.** DEC-53 defined T1S01a5 as sections 1-13 and DEC-56 fixed
the range at lines 223-1098. That is 876 lines and about fifty adjudicable
propositions. This ledger covers sections 1-8 in thirty-one entries and runs to
2,337 lines. Doing sections 9-13 in the same delivery would mean writing the
architecture half - B2's topology mathematics, the Architecture A rejection
proof, and the PR-1/PR-2 re-derivation - at the end of an already long session.
That is precisely the condition the review scope names as the failure mode W3C
exists to catch, and the architecture half is where a thin entry does the most
damage.

**Recommendation.** Ratify the split. The boundary is line 715/716: section 8
ends the record of what was established and how it was verified; section 9
opens what the project decided to build on it. That is the same kind of subject
boundary DEC-35 used to separate a3 from a4, and it keeps all three PR-1/PR-2
home sections (9.1, 12.5, 13.1) together on one side. Name the second part
**T1S01a5b**, which follows the existing letter-suffix precedent (T1S01a and
T1S01b; LED-020 and LED-020a) and leaves a6 and a7 untouched.

**Decide:** [Ratify the split, a5 = sections 1-8, a5b = sections 9-13] or
[Refuse - this ledger becomes part one of a single a5 and the rest is appended]
or [Split differently - name the boundary].
*(refs: DEC-53, DEC-56, DEC-35, DEC-27, manifest section 6 split-and-report)*

---

## Q2. The Schedule naming collision is live in six documents. Register it now?

**What is being decided.** Whether the corpus-wide naming collision found at
LED-037 is registered as a T1 finding with routing, or left for each later step
to rediscover.

**Why it matters.** Section 1.1 of the authority renames the processing-order
candidates to Schedule-SA/SB/SC for one stated reason: to stop them colliding
with Architecture A/B/C/D. Its own audit claims the renaming is complete, and I
tested that claim - it is true, of that document. It is not true of the corpus.
Bare "Schedule A" and "Schedule B" survive as active current vocabulary in the
charter, the README, the Concise Project Summary, the Forward Roadmap, the D0
Binding Knowledge Index and Project Status. The Concise Summary defines
Schedule A and Schedule B under the old names about a hundred and thirty lines
from its architecture material. So the collision the authority renamed to
prevent is live in exactly the documents a successor reads for orientation.

**Recommendation.** Register it, with routing: README to T1S02/T1S03; charter
and D0 to T1S04; Concise Summary, Roadmap and Project Status to T1S05. I
recommend the later steps propose the SA/SB spelling in each - with one
exception that matters: in Classic-specific documents, "Schedule A" names the
*verified HolyWu order*, and renaming it there would destroy that meaning
rather than clarify it. The D2 HolyWu Real Schedule document and the holywu_r9
provenance file are that case.

**Decide:** [Register with that routing] or [Register without the
Classic-document exception] or [Leave it to each step].
*(refs: LED-037, authority section 1.1, DEC-13's step plan)*

---

## Q3. Does a coordinate key inside a mathematical authority become a pointer?

**What is being decided.** A general question that this ledger hits three times
and that T3 will hit repeatedly.

**Why it matters.** Section 1.2 defines the symbols the authority's geometry
mathematics uses. Two of them - the edge position `e` and the chroma-coordinate
rule - are duplicates of charter invariants B1 and B5. The strict
de-duplication rule makes them pointers. But sections 4, 10, 11 and 12 use `e`
and `s` without redefining them, so a bare pointer makes the authority's
mathematics unreadable without the charter open alongside. This is not a
special pleading for one document: any authority that carries mathematics will
have a symbol key, and T3 needs a rule.

**Recommendation.** Adopt POINTER-WITH-RESTATEMENT for coordinate keys
specifically: keep the one-line definition and append the charter reference, so
the authority stays self-contained and the charter stays canonical. If you
prefer the strict rule, a bare pointer is defensible and I will not argue it
further - but I would rather the choice be made deliberately now than settled
by whichever entry T3 happens to process first.

**Decide:** [Pointer-with-restatement for coordinate keys] or [Strict pointer]
or [Defer to T3].
*(refs: LED-038, LED-040, LED-053, charter B1 and B5, task T3)*

---

## Q4. The LG measurement has no recorded method, sample size or date.

**What is being decided.** Whether to try to recover them before T6.

**Why it matters.** The LG mode table at section 6.2 is the project's strongest
target-device argument for B2 - it is cited in the authority, both
introductions, both chat blurbs, Project Status and the resume brief. It
records modes, resolutions, approximate bitrates and the flag value. It does
not record when it was measured, on what firmware, over how many pictures, or
by what command. The OTA record two paragraphs above it *does* say "317 sampled
pictures", which shows the omission is not house style. Charter P-08 requires
measurement claims to record their named material and tooling. Q14's corpus
design cites this table.

**Recommendation.** Try to recover the method and sample size now, while the
material and the recorder are still to hand, and record them at the next
authority version bump. If they cannot be established, record that explicitly -
an acknowledged gap is auditable and a silent one is not. I am **not**
suggesting the numbers are wrong; I am saying a successor cannot reproduce them
from what is written.

**Decide:** [Recover and record before T6] or [Record as unrecoverable] or
[Leave as is].
*(refs: LED-057, charter P-08, authority section 6.1 versus 6.2)*

---

## Q5. One entry carries a conditional disposition. Is that acceptable?

**What is being decided.** Whether LED-059 may map a canonical home into a
section this sub-tranche has not read.

**Why it matters.** Section 6.3 states the Q14 corpus composition. I judge the
canonical home to be the D4-Q14 experiment definition in section 15, because a
corpus requirement belongs with the experiment that consumes it - but section
15 is T1S01a6's range and I have not adjudicated it. If section 15 turns out
not to state the composition, my proposed pointer is wrong and 6.3 is the
canonical home after all. I have flagged the entry as conditional and asked
that it not be ratified as written.

**Recommendation.** Accept the conditional, and require T1S01a6 to confirm or
overturn it. The alternative - deferring the entry whole - loses the reasoning,
and the risk here is bounded because the conditional is stated in the entry
rather than buried.

**Decide:** [Accept the conditional, a6 confirms] or [Defer the entry to a6
entirely].
*(refs: LED-059, DEC-31's coverage rule)*

---

## Q6. Generalise the external-research rule beyond GAIS?

**What is being decided.** Whether to raise a charter proposal making the
verification rule instrument-neutral.

**Why it matters.** Section 8's rule says no *GAIS* factual claim, quotation or
citation enters project knowledge without independent verification, and its
evidence is a table of five wrong patent attributions and two unlocatable paper
citations. That is a calibration result about AI-generated citations in
general, not about one named tool. The rule and its evidence are both currently
scoped to the instrument that happened to produce them, so a future round using
a different research instrument is governed by nothing.

**Recommendation.** Raise it as a proper charter proposal under I7 - W3D as
proposer, W3C as the named independent verifier, W3X ratifying - rather than as
an authority edit. The evidence is already written at section 8 and needs no
new work. I would not do this before T1 closes unless you want it sooner; it is
a real gap but not an urgent one.

**Decide:** [Raise the charter proposal after T1] or [Raise it now] or [Leave
the rule GAIS-specific].
*(refs: LED-061, LED-062, charter I7, section 1.1 of the task register's
registered follow-up)*

---

# 1. What this ledger is, in plain English

The authority document's first eight sections are the project's record of what
is actually *known* about MPEG-2 block geometry and where that knowledge came
from - the verified codec facts, the syntax regimes, the whole-frame geometry
mathematics, why SeparateFields cannot work, what was measured on the target
recorder, what survived the prior-art investigation, and the rule that came out
of the external research going wrong. Sections 9 onward are what the project
decided to *build* on that. This ledger adjudicates the first half.

Thirty-one entries, LED-033 to LED-063. Nothing is ratified; every proposed
action is a proposal to W3X.

# 2. The three things most worth your attention

**Two of the document's own coverage claims were tested rather than accepted.**
Section 1.1 claims its Schedule renaming is complete, and section 2.1 claims no
tagged H.262 fact depends on GAIS. Both are the kind of claim this project has
learned to distrust. Both turn out to be TRUE, and both are now testable by
counting rather than by trusting the author - the populations and results are
recorded at LED-037 and LED-047. Attack the searches, not the conclusions.

**STAY-CANONICAL is exercised for the first time in T1, thirteen times.** The
action was ratified at DEC-38 and its evidence requirement refined at DEC-43,
and until now no entry had used it. Each of the thirteen names at least one
concrete non-canonical copy with its location, as DEC-43 requires. Five claim
it for some propositions and POINTER for others in the same entry, so the
per-proposition split needs checking as well as the action.

**The section 8 calibration record points at a document that may not exist.**
LED-063 dispositions it CONFLICTING and deliberately declines to say which side
prevails, because the other side is section 24's reference R8 and that belongs
to T1S01a6 under DEC-55. This matters more than a broken link: section 2.1's
provenance audit rests F4 and F5 on that same report. F4 also carries a direct
H.262 clause citation and survives independently; F5 carries only the report
reference. If the report cannot be found, F5's provenance should be
re-established against the standard directly.

# 3. What this ledger found in itself

Four defects, all caught by a machine check before issue and all recorded at
ledger section 0.4 rather than quietly fixed:

```text
1  Two entries overlapped by five lines - the same defect class as DEC-48,
   committed inside the ledger whose section 0 performs DEC-48's overlap check.
2  Two entries both claimed a line that is blank.
3  Eleven further ranges were wrong by one to four lines. Every range in the
   ledger has now been RECOMPUTED from the source rather than adjusted.
4  A closing question's enumeration was written from memory: it said six
   entries used STAY-CANONICAL and named nine, one wrongly. The searched
   answer is thirteen.
```

Defect 4 is the one worth dwelling on. DEC-51 records that an enumeration
written from recollection is the same assurance in a longer form, and that the
distinction that matters is searching versus remembering. That is exactly what
happened here, in the first sub-tranche written after the rule was ratified,
by the designer who had just finished correcting the register's own instance of
it. It was caught because the check was run, not because the author was careful.

# 4. Method note

The replacement-scope and check-evidence rules were applied as follows. Every
claim of uniqueness, duplication or unaffectedness carries a SWEPT field naming
the population searched and the terms used. Coverage claims name their
population and are testable by counting. Where a search establishes less than
the entry needs, the entry says so - LED-052's retirement search, LED-055's
SeparateFields search and LED-059's conditional all record what was *not*
established.

The overlap check against prior ledgers is enumerated at ledger section 0.2
rather than asserted: all thirty-three prior entries are listed with their
recorded ranges and compared against 226-712. No prior entry records a range
inside this one.

# 5. What W3C is asked to do

Review the thirty-one entries under the binding review scope, and answer the
seven closing questions at ledger section 1. The highest-value targets, in W3D's
own judgement:

```text
- the two tested coverage claims (LED-037, LED-047) - attack the populations;
- the thirteen STAY-CANONICAL claims - test the named copies exist and say
  what the entry says they say;
- the fourteen DERIVED fields - several are findings about the document's own
  provenance discipline, and any of them could be a finding that has leaked
  into DERIVED, or an inference that has leaked into a DISPOSITION;
- LED-043, where I claim the authority itself commits the atomic-claim defect
  by tagging an experiment-integrity rule as H.262-VERIFIED. If that is wrong,
  it is wrong in a way that accuses the ratified document of a defect it does
  not have, which is worse than a missed duplicate;
- LED-046, where I say F8 - the fact the whole architecture rests on - is the
  weakest-evidenced of the eight and has no recorded derivation basis. I
  believe F8 is correct. Believing it is the position this sub-tranche is
  supposed to distrust.
```

No source was modified. No build, execution, test, patch, delivery machinery or
git operation is involved anywhere in T1.

---

*End of covering note. Nothing here is ratified.*
