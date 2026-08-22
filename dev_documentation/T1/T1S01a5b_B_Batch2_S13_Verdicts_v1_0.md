# Deblock4 - T1S01a5b Batch 2 Section 13 W3C Verdicts

**Deliverable:** T1S01a5b_B_Batch2_S13_Verdicts
**Version:** 1.0
**Date:** 2026-08-22
**Author:** W3C
**Route:** W3C -> W3X -> W3D
**Reviews:** T1S01a5b_A_Ledger_Body_Part2_Batch2_v1_2.md, section 13 entries
**Binding scope:** Deblock4_T1_W3C_Review_Scope_v1_15.md
**Nature:** DOCUMENT REVIEW ONLY. No source, build, test or git.
**Encoding:** US-ASCII; CRLF.

---

# Plain-English summary

W3C reviewed LED-092 through LED-097b against authority section 13, lines
1049-1098, and the declared 38-file population. Four entries AGREE and four
DISAGREE. The scheduler/kernel separation and all three section-13.5 split
entries are supported. The principal defect is LED-092: its blanket statement
that all five 13.x rules are older README rules is not supported, and section
13.5 has no README carrier in the declared population. LED-094, LED-095 and
LED-096 retain plausible CURRENT-DUPLICATE / STAY-CANONICAL outcomes but their
occurrence records omit or misclassify direct current-document carriers.

Result: 4 AGREE / 4 DISAGREE / 0 UNSURE / 0 MISSING.

---

# DECISIONS/QUESTIONS FOR W3X

None.

Recommendation: return LED-092, LED-094, LED-095 and LED-096 for bounded
repair. LED-092 needs proposition/provenance repair rather than a mere sweep
count edit; if W3D concludes that the overbroad README-origin limb is
ERRONEOUS, scope 0.11's SUPERSEDED-KIND and PROPAGATION requirements apply.
Do not reopen the four AGREE entries.

---

# Entry-by-entry verdicts

## LED-092 - DISAGREE

The entry does not establish its own five-rule retention/provenance claim.
README 976-1017 directly carries the analyser-is-canonical, unmodified-source
pre-pass, per-call scratch and proof/helper material corresponding principally
to 13.2-13.4. It does not carry section 13.5's trusted-side-data rule. A
whole-README search likewise finds dct_type availability facts but no rule that
future side data must feed the same FRAME/FIELD/UNKNOWN map contract or that
runtime correctness must not depend on side data until a format/lifetime/trust
contract is scoped.

The cited Evaluation 858-875 is also narrower than LED-092's ASSERTS: it
identifies README 976-1017's analyser-discipline cluster, not all five 13.x
rules. Project Status 455-463 supports the retained status of the 13.1 general
principle, but does not establish README origin for all five rules.

Therefore the blanket proposition `the five 13.x rules are of README origin`
is not sound as written, and CURRENT-DUPLICATE is not established for that
whole proposition. The source retention sentence and the ledger entry need to
be narrowed/split so that provenance and retained-validity claims with
different evidence do not share one disposition.

## LED-093 - AGREE

Authority 1055-1068 states the schedule/predicate/kernel separation cleanly.
The non-canonical carriers cited by the entry reproduce: PreScope Brief 201
states that the schedule decides WHERE candidate edges are; the prior W3C
PreScope response 504-525 separates geometry/detector/compiler from an
independent edge predicate and Deblock4 kernel; Project Status 455-463 records
PR-1 and quotes the no-implicit-geometry-classifier principle; and later
D4-D03 1617-1618 compresses the rule to topology WHERE and predicate/kernel
WHETHER/HOW. CURRENT-DUPLICATE / STAY-CANONICAL is sound.

## LED-094 - DISAGREE

The substantive rule and CURRENT-DUPLICATE / STAY-CANONICAL outcome are sound,
but the occurrence classification is not. Current
111_New_Chat_Introduction_for_Designer_v1_33.md lines 134-136 directly states
that any output-affecting analyser is part of the canonical algorithm and runs
as an unmodified-source pre-pass. A cold reader can recover LED-094's central
proposition from that passage without assuming it first, so under scope 0.4 it
is a CARRIER, not merely an occurrence `applying or configuring` the rule as
LED-094's REASON groups the intro loci.

Recommended correction: enumerate/classify this current-introduction carrier,
update the occurrence accounting, and rerun the whole-entry gate. No
substantive disposition change is presently indicated.

## LED-095 - DISAGREE

The state rule and CURRENT-DUPLICATE / STAY-CANONICAL outcome are supported,
but the sweep omits material direct carriers. Current designer introduction
134-136 says the analyser uses per-call scratch under fmParallel and `No hidden
temporal state in v1`; its settled summary at 731-732 repeats the rule. More
importantly, the prior W3C PreScope response 42-56 says request-history-
dependent output is unsafe unless temporal dependencies are explicitly
modelled and permits temporal hysteresis later only if its frame dependencies,
cache/lifetime and random-access semantics are explicitly designed and proved.
The same document 552-569 restates the request-history problem and explicit-
dependency escape.

Those passages state, rather than merely apply, the same no-hidden-temporal-
state / explicit-later-dependency proposition. They must be classified in the
occurrence record under scope 0.3/0.5.

## LED-096 - DISAGREE

The proof-obligation rule and CURRENT-DUPLICATE / STAY-CANONICAL outcome are
supported by README 976-985 and Evaluation 864-875. The semantic sweep is
nevertheless incomplete. Current designer introduction 134-136 states that an
output-affecting analyser `gets its own proof obligations`. That is a compressed
CARRIER of the entry's headline proposition that the detector itself needs its
own proof, and it exposes an obvious equivalent probe phrase (`proof
obligations`) absent from the declared family.

Scope 0.3 requires an equivalent carrier phrasing discovered during reading to
be added to the probe family and the same population rerun. Recommended repair:
add/classify that occurrence, rerun the bounded sweep, and rederive any retained
count. No substantive disposition change is presently indicated.

## LED-097 - AGREE

Authority 1090-1092 says D4-Q13 remains open, and the later D4-Q13 register
occurrence at authority 1575-1577 independently says OPEN. The Batch-1
LED-070a provisional pointer condition is therefore correctly resolved as
confirmed. CURRENT-DUPLICATE / STAY-CANONICAL and the a6 routing are sound.

## LED-097a - AGREE

Authority 1092-1094 requires future trustworthy dct_type metadata to feed the
same FRAME/FIELD/UNKNOWN map contract so the compiler/kernel do not fork.
Authority D4-Q13 1575-1577 independently states that a future decoder/source
dct_type map should plug into the same B2 map contract, not fork the kernel.
CURRENT-DUPLICATE / STAY-CANONICAL and the a6 routing are sound.

## LED-097b - AGREE

The no-dependence safety rule at 1094-1095 is supported, and W3C independently
attacked the CURRENT-UNIQUE claim over the declared 38-file population. The
other side-data occurrences found are motivating facts or future-work/status
records: they do not state that runtime correctness may not depend on side data
until its format/lifetime/trust contract is scoped. The later D4-Q13 register
carries OPEN status and the same-map-contract limb only, not this safety limb.
No second carrier was found. CURRENT-UNIQUE is therefore supported.
