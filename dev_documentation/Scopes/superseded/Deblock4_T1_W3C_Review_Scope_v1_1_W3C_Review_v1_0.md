# Deblock4 - W3C Review of T1 Documentation Consolidation Review Scope v1.1

**Deliverable:** T1-W3C-SCOPE-REVIEW
**Version:** 1.0
**Date:** 2026-08-18
**From:** W3C
**Route:** W3C -> W3X -> W3D
**Reviewed:** `Deblock4_T1_W3C_Review_Scope_v1_1.md`
**Nature:** Review of review-method scope only. No source, documentation set, ledger or repository change is authorised by this response.
**Encoding:** US-ASCII; CRLF.

---

# DECISIONS/QUESTIONS FOR W3X

## Q1 - Reissue the review scope before T1S00?

**Recommendation: YES.**

v1.1 has the right review philosophy and batch structure, but two evidence-package
defects make some of its assigned review questions impossible for a memoryless
W3C to perform. Reissue as v1.2 after the amendments in F1-F4 below.

No T1 ledger result or architecture decision needs to change. This is a review-
method correction before the first batch.

## Q2 - Final three-way closure

**Recommendation: make the end-of-six-batches three-way reconciliation explicit
in the scope.**

The intended process, as clarified by W3X, is:

    W3D batch
      -> W3C independent review
      -> pause / retain both records
      -> next batch

    after T1S00..T1S05:
      W3X collates the completed ledger + all W3C responses
      -> W3D answers disagreements / omissions
      -> W3C independently checks the proposed resolutions
      -> W3X decides and records the final adjudications

Entry-level silence between batches is not acceptance. A METHOD blocker may be
acted on immediately because allowing a broken method to continue would multiply
the defect.

---

# Overall assessment

**Disposition: REISSUE RECOMMENDED BEFORE RELEASE.**

The scope is unusually strong in several respects:

- it states plainly that this is review, not coding;
- it explains the historical failure that justifies independent review;
- it explicitly warns W3C against persuasion/confirmation bias;
- it separates high-risk conflicts from lower-risk routine duplication;
- it pre-registers four difficult issues before the sweep;
- it requires disagreement, uncertainty and missing-entry findings to be
  first-class outputs;
- it records that newest does not automatically mean correct;
- it correctly separates the MPEG-2 architecture authority from the work queue;
- it prevents batch-by-batch silence being interpreted as acceptance.

I would preserve all of those features.

The problems below are mechanical: the evidence package promised to W3C does not
currently contain enough information to discharge every review obligation the
scope assigns.

---

# Findings

## F1 - BLOCKER - later-session package cannot support Q-D or full independent review

Scope section 4.2 says a later W3C session receives only:

    - the task register;
    - that step's ledger.

But Q-D asks:

> "Does that document section contain something the designer walked past without
> logging?"

A ledger can show what the designer **did** log. It cannot show what the designer
**did not** log.

Similarly, Q-A asks W3C to verify that the quoted source supports the conclusion.
A short ledger quote may be sufficient for a narrow semantic check, but not for
context-dependent claims. Tier C explicitly asks the same five questions as
Tier A, and Tier B asks whether text is an operative specification.

### Required correction

Every step package must include the **underlying source document(s), or at least
the complete source section(s), covered by that ledger step**.

Recommended standing package for every memoryless W3C step:

    - current T1 W3C review scope;
    - current T-series task register;
    - current MPEG-2 authority;
    - that step's ledger;
    - the complete document(s), or complete relevant sections, swept by that
      step;
    - any specifically named evidence documents required by that step.

The charter / communication convention may be supplied through the normal
successor-chat orientation package, but because the scope declares each session
self-contained, including or explicitly requiring the current charter is safer.

### Why this is blocking

Without the underlying source, W3C can assess the designer's written reasoning
but cannot independently detect omissions. That recreates the exact failure
mode T1 exists to prevent.

---

## F2 - BLOCKER - Tier B needs read-only source evidence

Tier B asks:

> "is this really a specification the code implements, or is it background
> knowledge dressed as one?"

That is an implementation fact.

The scope forbids source **changes**, builds and proof runs, which is correct.
However section 11's phrase "Do not touch source" can be read as forbidding
source inspection, and section 4.2 does not supply the source tree.

### Required correction

State explicitly:

    READ-ONLY source inspection is PERMITTED and REQUIRED where an
    OPERATIVE-SPEC classification depends on what the current code actually
    implements.

    No modification, build, execution, patch, delivery package or git action is
    permitted.

For any step containing Tier-B entries, either:

1. attach the current `src` tree; or
2. put sufficient exact source references/extracts in the batch to prove the
   implementation fact, while allowing W3C to request the tree if context is
   insufficient.

I prefer option 1 when practical because it preserves independence.

---

## F3 - BLOCKER / PR-4 package defect - T1S00 cannot find what the search never found

T1S00 asks W3C to review the manifest's search terms and answer what they would
still miss.

The manifest is described as:

    "The list of every document in the sweep and the search terms used to build
    it."

That is not enough to detect documents excluded by the search. A list generated
from the search cannot reveal documents that the search failed to select.

### Required correction

T1S00 must additionally receive either:

- the complete current `dev_documentation` corpus; or
- a complete independent inventory of every live documentation file, whether or
  not it matched the sweep terms.

The full corpus is preferable. PR-4 is specifically an omission-finding task, so
the reviewer needs visibility outside the search result set.

---

## F4 - MODERATE - one disposition has no review tier

Section 6 assigns:

- CONFLICTING -> Tier A;
- SUPERSEDED **where deletion is planned** -> Tier A;
- OPERATIVE-SPEC -> Tier B;
- CURRENT-UNIQUE / CURRENT-DUPLICATE -> Tier C.

That leaves an unassigned case:

    SUPERSEDED where the action is replacement by a pointer rather than deletion.

Every ledger entry should have one review tier.

### Recommendation

Simplest rule:

    ALL SUPERSEDED entries -> Tier A.

Retiring stale knowledge is sufficiently high risk that the small extra review
cost is justified.

If W3D wants a lower tier for pointer-replacement cases, define it explicitly;
do not leave the case implicit.

---

## F5 - MODERATE GOVERNANCE WORDING - do not say a charter rule "does not apply"

Section 1 says the usual rule about W3C never claiming PASS "does not apply"
because nothing is being passed.

The practical meaning is harmless, but the wording is risky because a bounded
scope does not suspend the charter.

### Recommended replacement

    No build, test or proof execution occurs in T1, so C-DELIV-07's
    execution/PASS-claim restriction is simply not triggered. W3C must not
    imply that it executed anything. T1 outputs use review verdicts
    AGREE / DISAGREE / UNSURE / MISSING; none is W3X acceptance.

This preserves the charter's precedence exactly.

---

## F6 - MODERATE - final three-way reconciliation should be written down

Section 4.3 correctly says W3X collects the responses and reviews them together
at the end, and correctly says silence between steps is not agreement.

W3X has now clarified a stronger intended closure: a **three-way process on the
set of all batch results**.

That should be explicit so a successor W3D or W3C does not mistake W3X's final
read for a one-person adjudication.

### Recommended new subsection 4.4

    FINAL THREE-WAY RECONCILIATION

    After T1S05, no ledger adjudication is final merely because W3D proposed it
    or W3C agreed/disagreed with it.

    W3X supplies the completed ledger and the six W3C responses as the closure
    set. W3D responds to every unresolved disagreement, UNSURE, MISSING and
    method finding. W3C independently reviews those proposed resolutions.
    W3X makes and records the final decisions.

    A method-level blocker may be corrected earlier; entry-level adjudication
    normally waits for this closure round.

This matches W3X's clarified process.

---

## F7 - MINOR - change "review/confirm" launch wording to avoid confirmation bias

W3X's clarified conversational blurb says W3C will "independently
review/confirm".

The scope itself correctly says:

> "Do not confirm. Being asked to review is not being asked to approve."

For consistency I recommend the launch wording:

    "independently review, confirm or challenge"

or simply:

    "independently review"

This is not a scope blocker; it only removes a subtle priming effect.

---

# Specific amendment suggested for section 4.2

A compact replacement would be:

```text
EVERY W3C STEP SESSION IS SELF-CONTAINED.

STANDING REVIEW PACK - EVERY SESSION:
  - current T1 W3C review scope;
  - current T-series task register;
  - current MPEG-2 authority;
  - that step's ledger;
  - the complete source document(s), or complete relevant sections, that the
    ledger adjudicates.

T1S00 ADDS:
  - complete current dev_documentation corpus (or a complete independent file
    inventory), so PR-4 can find documents outside the search result set;
  - scope manifest;
  - outgoing designer evidence set.

TIER-B STEPS ADD:
  - current src tree, or exact sufficient source evidence, for read-only
    verification of claims that a specification is implemented.

READ-ONLY inspection is permitted. No source/document modification, build,
execution, git operation, patch or delivery package is permitted.

If W3C believes evidence is insufficient, it reports the affected entry as
UNSURE / METHOD BLOCKER and asks W3X for the missing material. It does not infer
the answer.
```

---

# What I would NOT change

I would keep unchanged:

1. the six-step decomposition T1S00-T1S05;
2. `_A_` / `_B_` naming;
3. W3X withholding entry-level feedback until the end;
4. immediate escalation of method defects;
5. the five disposition categories;
6. the three-tier unequal-effort principle;
7. the four pre-registered items;
8. the five Tier-A/Tier-C review questions;
9. the no-fault disagreement language;
10. the rule that W3C reviews but does not edit the documents.

Those are well designed.

---

# Scope release recommendation

**Do not start T1S00 under v1.1.**

Ask W3D to issue v1.2 incorporating:

- F1 underlying-source evidence in every batch;
- F2 read-only source access/evidence for Tier B;
- F3 full-corpus/inventory support for PR-4;
- F4 complete tier assignment;
- F5 charter-safe PASS wording;
- F6 explicit final three-way closure.

After those changes, I expect only a short focused re-review rather than another
full derivation of the method.
