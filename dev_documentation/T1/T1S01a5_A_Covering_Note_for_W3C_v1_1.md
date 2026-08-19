# Deblock4 - T1S01a5 Covering Note: Authority Body Part 1

**Deliverable:** T1S01a5_A - COVERING NOTE
**Version:** 1.1
**Date:** 2026-08-19
**Author:** W3D
**Route:** W3D -> W3X -> W3C
**Accompanies:** `T1S01a5_A_Ledger_Body_Part1_v1_1.md` and `T1S01a5_A_Corpus_Manifest_v1_0.md`
**Binding review scope:** `Deblock4_T1_W3C_Review_Scope_v1_11.md`
**Binding work queue:** `Deblock4_Standing_Task_Register_T_Series_v1_23.md`
**Encoding:** US-ASCII; CRLF.

---

# 0. WHY THIS IS v1.1 - W3C STOPPED THE REVIEW, CORRECTLY, AND FOUND TWO
# DEFECTS BEFORE IT STARTED

```text
W3C did not begin the formal review. It stopped and asked for the current
corpus, because Review Scope v1.11 requires exactly that when the population
needed to test SWEPT, uniqueness and duplication claims cannot be reproduced.
THAT IS THE RIGHT CALL AND W3D AGREES WITHOUT QUALIFICATION. Several a5
entries rest on whole-corpus searches; a reviewer who cannot rerun them can
only find the reasoning reasonable, which is the specific failure the review
scope warns about.

WHAT IS SUPPLIED IN RESPONSE, beyond the corpus itself:
  T1S01a5_A_Corpus_Manifest_v1_0.md - the EXACT population W3D searched,
  every live file with its line count and SHA-256 digest. A discrepancy
  between that list and the supplied tree is now detectable by comparison
  instead of arguable from memory. It also states plainly why the search
  population is 124 files while the adjudication population is 47.

TWO DEFECTS W3C FOUND BEFORE REVIEWING, BOTH CORRECTED HERE.

DEFECT 1 - RANGE CONFLATION IN THIS NOTE. Section 4 of v1.0 said the overlap
comparison was "against 226-712". The declared tranche is 223-715 (DEC-56);
226-712 is the span of the ENTRY ranges, which is a different thing. The
ledger itself is correct throughout - it says 223-715 in all ten places the
search found. The defect was confined to this note. Corrected at section 4,
and the whole batch was searched for the same conflation: one occurrence,
now zero.

DEFECT 2 - CHARTER P-08 DOES NOT SAY WHAT LED-057 SAID IT SAYS, AND THIS IS
THE ONE THAT MATTERS. v1.0 rested LED-057's finding on charter P-08. W3C's
challenge is correct: P-08 is titled SOURCE PROVENANCE IS PINNED and has two
limbs - software source, and standards. It has no measurement limb at all.
W3D extended a rule to a category it does not govern.

  THE FINDING SURVIVES, ON A STRICTER AND INTERNAL BASIS. The authority's
  own provenance discipline defines `[MEASURED]` as "project measurement on
  NAMED MATERIAL/TOOLING". Section 6.2 carries that tag, names the material,
  and names no tooling, sample size or date - while section 6.1 two
  paragraphs above, under the same tag, names its sample size. The tag's own
  definition is not satisfied. That is a defect against the document's
  declared discipline rather than against a charter rule that was never
  about measurement.

  A SECOND FINDING FALLS OUT OF THE CORRECTION: charter P-08 has no
  measurement limb, in a project that rests its strongest architectural
  argument on measurement and maintains a `[MEASURED]` tag. Routed to T1S04,
  which adjudicates the charter. NOT proposed as an amendment here - I7
  governs, and W3D does not write the rules that judge W3D's own evidence.

  THE MISUSE WAS SEARCHED FOR RATHER THAN ASSUMED ISOLATED, per DEC-51.
  Every charter citation in the batch was enumerated and checked against the
  charter text: B1, B2, B3, B4, B5, C-SIMD-03, Part 6.4, P-06 and I7 all
  hold. P-08 was the only overreach. It appeared at FOUR sites - two in the
  ledger, two in this note's Q4 - and all four are corrected.

WHAT DID NOT CHANGE, PROVED RATHER THAN ASSERTED per DEC-40(b): thirty of
the thirty-one ledger entries are byte-identical to v1.0. Each entry block
was extracted from both versions and compared by SHA-256; only LED-057's
digest differs. The per-entry table is at section 6 below, so W3C can confine
a re-read to one entry rather than repeat a review it has not yet performed.

W3D'S ASSESSMENT OF THE ROUND: W3C found a framing residue and a misapplied
rule before reading a single entry. That is the third consecutive sub-tranche
in which the designer's method, not the designer's findings, was the thing
that needed fixing - and the second time in two days that the correction has
made the finding stronger than the version W3D wrote.
```

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
pictures", which shows the omission is not house style. The authority's own
provenance discipline defines `[MEASURED]` as "project measurement on named
material/tooling", and section 6.2 carries that tag while naming no tooling -
so the table does not satisfy its own label. Q14's corpus design cites this
table.

CORRECTED AT v1.1: v1.0 of this note rested the same point on charter P-08.
W3C challenged that and is right - P-08 governs software source and
standards, not measurement. The correct basis is the tag definition above,
which is stricter. Separately, that P-08 has no measurement limb is itself
now a finding routed to T1S04.

**Recommendation.** Try to recover the method and sample size now, while the
material and the recorder are still to hand, and record them at the next
authority version bump. If they cannot be established, record that explicitly -
an acknowledged gap is auditable and a silent one is not. I am **not**
suggesting the numbers are wrong; I am saying a successor cannot reproduce them
from what is written.

**Decide:** [Recover and record before T6] or [Record as unrecoverable] or
[Leave as is].
*(refs: LED-057 v1.1, authority provenance tags at header lines 31-45,
section 6.1 versus 6.2, T1S01a3 LED-022, charter P-08 as the NEGATIVE case)*

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
recorded ranges and compared against THE DECLARED TRANCHE RANGE, 223-715. No
prior entry records a range inside it.

TWO NUMBERS APPEAR IN THIS BATCH AND THEY ARE NOT THE SAME NUMBER. 223-715 is
the DECLARED tranche, fixed by DEC-56 and used for the overlap test. 226-712
is the SPAN OF THE ENTRY RANGES, which starts three lines later because line
223 is the section 1 heading and ends three lines earlier because 713-715 are
a blank line, a rule and a blank. Every line in the gap between them was
listed and shown to be a heading, a blank or a code fence. v1.0 of this note
used the entry span where it should have used the declared tranche; W3C found
it before reviewing.

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

# 6. Per-entry digest table - proof of what the reissue did not touch

DEC-40(b) requires a reissue that leaves a region unchanged to PROVE it rather
than assert it. Each entry block was extracted from ledger v1.0 and v1.1 and
hashed. Only LED-057 differs.

```text
  LED-033  v1.0=b542b6d3bac958e1  v1.1=b542b6d3bac958e1  identical
  LED-034  v1.0=40559070f369de4f  v1.1=40559070f369de4f  identical
  LED-035  v1.0=d26ef9b9329bf5b8  v1.1=d26ef9b9329bf5b8  identical
  LED-036  v1.0=2f6cb2da3e157344  v1.1=2f6cb2da3e157344  identical
  LED-037  v1.0=443c56304a242716  v1.1=443c56304a242716  identical
  LED-038  v1.0=e94c7f2444adb7fc  v1.1=e94c7f2444adb7fc  identical
  LED-039  v1.0=c1934ffce71c251d  v1.1=c1934ffce71c251d  identical
  LED-040  v1.0=175c445fbfadfcf9  v1.1=175c445fbfadfcf9  identical
  LED-041  v1.0=35d82ecac5353236  v1.1=35d82ecac5353236  identical
  LED-042  v1.0=8c2d6d86e181732b  v1.1=8c2d6d86e181732b  identical
  LED-043  v1.0=41ed9747ef505928  v1.1=41ed9747ef505928  identical
  LED-044  v1.0=bd9f1145e3ac06d2  v1.1=bd9f1145e3ac06d2  identical
  LED-045  v1.0=b34c81fe7f6e4458  v1.1=b34c81fe7f6e4458  identical
  LED-046  v1.0=e788d7c7313e4b44  v1.1=e788d7c7313e4b44  identical
  LED-047  v1.0=0938526727fb9930  v1.1=0938526727fb9930  identical
  LED-048  v1.0=6b6d485a8d8772fd  v1.1=6b6d485a8d8772fd  identical
  LED-049  v1.0=5203554647fa4ecc  v1.1=5203554647fa4ecc  identical
  LED-050  v1.0=457b4df22b3ba738  v1.1=457b4df22b3ba738  identical
  LED-051  v1.0=7fbc42ee86ef8bdb  v1.1=7fbc42ee86ef8bdb  identical
  LED-052  v1.0=92892b8b6f09b99f  v1.1=92892b8b6f09b99f  identical
  LED-053  v1.0=b59ccc40f4281304  v1.1=b59ccc40f4281304  identical
  LED-054  v1.0=bf200fbcecd4fa89  v1.1=bf200fbcecd4fa89  identical
  LED-055  v1.0=c05d94e69b5241c8  v1.1=c05d94e69b5241c8  identical
  LED-056  v1.0=dcf9bc45a50749a9  v1.1=dcf9bc45a50749a9  identical
  LED-057  v1.0=1d4810a3e980f9d6  v1.1=42f7f5d60902933e  CHANGED
  LED-058  v1.0=52142291a7f2bf3e  v1.1=52142291a7f2bf3e  identical
  LED-059  v1.0=8d29b0c7020a6354  v1.1=8d29b0c7020a6354  identical
  LED-060  v1.0=3e4a1aed391ee018  v1.1=3e4a1aed391ee018  identical
  LED-061  v1.0=711838c9a9681932  v1.1=711838c9a9681932  identical
  LED-062  v1.0=fbb09efb68a83c45  v1.1=fbb09efb68a83c45  identical
  LED-063  v1.0=18ca9ef9f0c177f1  v1.1=18ca9ef9f0c177f1  identical

  RESULT: 30 of 31 entries byte-identical. LED-057 changed.
  METHOD: split each file on the entry headings, SHA-256 the block, compare.
  W3C may confine any re-read to LED-057.
```

---

*End of covering note. Nothing here is ratified.*
