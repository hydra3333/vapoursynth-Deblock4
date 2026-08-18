# Deblock4 - W3C Focused Re-Review of T1 Review Scope v1.4

**Deliverable:** T1-W3C-SCOPE-FOCUSED-REVIEW
**Version:** 1.0
**Date:** 2026-08-18
**From:** W3C
**Route:** W3C -> W3X -> W3D
**Reviewed:** `Deblock4_T1_W3C_Review_Scope_v1_4.md`
**Basis:** focused re-review against W3C findings F1-F6 on scope v1.1, plus
consistency check against the supplied current `dev_documentation` and `src`
reference packages.
**Encoding:** US-ASCII; CRLF.

---

# DECISIONS/QUESTIONS FOR W3X

None.

**Recommendation: RELEASE T1S00 under scope v1.4.**

All blocking and moderate findings from the previous W3C scope review have been
closed. I found no new method defect that warrants another scope reissue before
T1 starts.

---

# 1. Closure of the previous findings

## F1 - underlying documents needed for omission review

**CLOSED.**

v1.4 section 4.2 now supplies the complete `dev_documentation` corpus as the
standing reference library and requires the step's adjudicated documents/
sections to be identified. Sections 4.2.0 and 4.2.1 explicitly forbid working
from the ledger alone and explain why Q-D requires reading the swept source
section in full.

This directly fixes the prior impossibility: W3C can now detect statements the
designer failed to log rather than seeing only the statements the designer did
log.

## F2 - Tier B needs read-only source inspection

**CLOSED.**

v1.4 section 4.2.3 now states unambiguously that reading the source tree is
permitted and, for Tier B, required; modification, build, execution, patch,
delivery package and git remain forbidden.

The source tree now travels routinely with the standing reference set, so a
Tier-B classification no longer depends on a later round trip for evidence.

## F3 - PR-4 needs visibility outside the search result set

**CLOSED.**

v1.4 supplies the complete documentation corpus and section 4.2.2 explicitly
states the logical problem: a search-derived manifest cannot reveal documents
the search excluded.

W3C can therefore inspect the corpus for relevant documents whose content does
not use the registered search vocabulary.

## F4 - SUPERSEDED pointer-replacement case had no tier

**CLOSED.**

v1.4 section 6 assigns **every SUPERSEDED entry** to Tier A, whether the action
is deletion or replacement by a pointer.

The review surface is now exhaustive: every one of the five dispositions has a
defined review treatment.

## F5 - charter wording about PASS

**CLOSED.**

v1.4 section 1 no longer says the charter rule "does not apply." It correctly
states that no build/test/proof run occurs, so C-DELIV-07 is not triggered; it
is not waived or relaxed.

The review verdict vocabulary is also correctly separated from W3X acceptance.

## F6 - final three-way reconciliation

**CLOSED.**

v1.4 section 4.4 now records the complete closure round:

1. W3X assembles the completed ledger and all six W3C responses.
2. W3D answers every unresolved disagreement, UNSURE, MISSING and method item.
3. W3C performs a second, bounded review only where W3D disagreed with W3C or
   changed an adjudication.
4. W3X makes and records the final decisions.

It also preserves the intended exception that a method blocker may be corrected
immediately rather than propagated through later batches.

---

# 2. Reference-package consistency check

The supplied documentation package contains the versions the scope expects,
including:

- `AI_Charter_and_Invariants_Card_v1_29.md`;
- `Deblock4_Standing_Task_Register_T_Series_v1_3.md`;
- `Deblock4_MPEG2_Deblocking_Investigation_and_Decided_Architecture_v1_05.md`;
- `333_W3X_Coder_Communication_Convention_v1_0.md`;
- `Deblock4_Project_Status_v1_28.md`;
- the current coder/designer introductions;
- scope v1.4 itself.

The separate supplied source zip provides the read-only implementation evidence
required by Tier B.

The task register v1.3 is also consistent with the scope's sequencing context:
T1 is first; T1.1-MATHS runs inside T1 as an inventory/gap analysis rather than
new derivation; T5 follows T1; T6 follows T5 as a separate ratification.

---

# 3. One non-blocking wording refinement

## M1 - section 12 "NEITHER IS CHOSEN" is slightly ambiguous

Section 12 says:

    Two candidate architectures remain live and NEITHER IS CHOSEN:
    B2, the primary candidate ... and D, the detector-free comparator ...

The intended meaning is clear from the surrounding text and the authority:
B2 **has been adopted as the primary candidate**, D as the mandatory
fallback/comparator, but neither has passed Q14 and therefore neither has been
selected to enter kernel/oracle development.

For a future natural scope bump, I recommend:

    Two candidate architectures remain live. B2 is the adopted PRIMARY
    CANDIDATE and D the mandatory comparator/fallback. NEITHER has passed Q14
    or been selected to enter kernel/oracle development.

Likewise, the last sentence could be made narrower:

    No Deblock4 kernel scope or new kernel mathematics may be opened until Q14
    reports and W3X ratifies the architecture allowed to enter development.

rather than the broader "Nothing about the kernel may be designed", because T1
itself is explicitly allowed to adjudicate existing kernel-related principles
such as PR-2 and T1.1-MATHS inventories existing mathematics.

**This is not a release blocker.** The specific PR-2/T1.1 instructions and the
ratified task register make the present meaning recoverable without guessing.

---

# 4. Release verdict

**Scope v1.4 is fit for T1S00 release.**

No further method redesign is recommended before the sweep starts.

For each batch W3C will apply the scope as written:

- verify the current corpus/source reference set first;
- read the adjudicated source sections, not just ledger quotes;
- review Tier A and sampled Tier C against Q-A through Q-E;
- verify Tier B against current source where implementation status matters;
- escalate any METHOD problem immediately;
- otherwise emit the `_B_` response and leave entry-level reconciliation to the
  final three-way round.
