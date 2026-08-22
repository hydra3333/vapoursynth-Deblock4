# Deblock4 - T1S01a5b Batch 2 Section 13 W3C Findings

**Deliverable:** T1S01a5b_B_Batch2_S13_Findings
**Version:** 1.0
**Date:** 2026-08-22
**Author:** W3C
**Route:** W3C -> W3X -> W3D
**Encoding:** US-ASCII; CRLF.

---

# DECISIONS/QUESTIONS FOR W3X

None.

---

# Findings

## F25 - LED-092 overstates README provenance and mixes evidence-status limbs

LED-092 ASSERTS that all five section-13 rules are of README origin, still
exactly right, load-bearing and retained. Its stated proof does not establish
that proposition. README 976-1017 carries the analyser/pre-pass/scratch/proof
cluster corresponding principally to 13.2-13.4. A whole-README search finds no
carrier for 13.5's same-map-contract/no-runtime-dependence side-data rule.
Evaluation 858-875 likewise discusses the README analyser-discipline cluster,
not all five rules. Project Status 455-463 supports retention of the 13.1
principle but not blanket README provenance.

Recommended repair: split or narrow LED-092 so README provenance is asserted
only for rules actually evidenced, separately from the proposition that the
section-13 rules remain load-bearing/current. Re-evaluate the source sentence
at authority 1052-1053 itself. If the overbroad provenance limb is adjudicated
SUPERSEDED / ERRONEOUS, apply scope 0.11 PROPAGATION rather than treating this
as a wording-only edit.

## F26 - LED-094 misclassifies a current direct carrier

111_New_Chat_Introduction_for_Designer_v1_33.md 134-136 says that any
output-affecting analyser is part of the canonical algorithm and runs as an
unmodified-source pre-pass. That directly states LED-094's central proposition;
it is not merely an implementation/configuration use of the rule.

Recommended repair: classify the passage as CARRIER, update the occurrence
record/count as needed, and rerun the whole-entry gate. The proposed
CURRENT-DUPLICATE / STAY-CANONICAL outcome otherwise remains supported.

## F27 - LED-095 omits direct temporal-state carriers

The current designer introduction 134-136 and 731-732 directly state per-call
scratch under fmParallel and no hidden temporal state in v1. The prior W3C
PreScope response 42-56 and 552-569 goes further: it states the request-history
hazard, requires explicit temporal modelling, and identifies a later explicitly
designed temporal dependency/pre-pass as the permitted escape. These are
CARRIER occurrences of LED-095's proposition, not mere APPLIES references.

Recommended repair: add/classify the omitted occurrences, rerun the semantic
probe family and occurrence accounting, and run the whole-entry gate. No
substantive disposition change is presently indicated.

## F28 - LED-096 misses the `proof obligations` carrier/reformulation

111_New_Chat_Introduction_for_Designer_v1_33.md 134-136 states that an
output-affecting analyser `gets its own proof obligations`. This is a compressed
carrier of the detector-needs-proof proposition and supplies a reasonable
independent reformulation that the declared probe family omitted.

Recommended repair: add `proof obligations` (or an equivalent analyser-proof
probe), rerun the same 38-file population, classify the occurrence and rederive
any count. CURRENT-DUPLICATE / STAY-CANONICAL otherwise remains supported.
