# Deblock4 - T1S01a5b Batch 2 Section 11 W3C Verdicts

**Deliverable:** T1S01a5b_B_Batch2_S11_Verdicts
**Version:** 1.0
**Date:** 2026-08-22
**Author:** W3C
**Route:** W3C -> W3X -> W3D
**Reviews:** T1S01a5b_A_Ledger_Body_Part2_Batch2_v1_2.md, section 11 entries
**Binding scope:** Deblock4_T1_W3C_Review_Scope_v1_15.md
**Nature:** DOCUMENT REVIEW ONLY. No source, build, test or git.
**Encoding:** US-ASCII; CRLF.

---

# Plain-English summary

W3C reviewed LED-082, LED-082a, LED-083, LED-084 and LED-085 against the
38-file population and authority section 11, lines 877-914. The source
propositions themselves are supported, and W3C does not presently dispute any
of the five CURRENT-DUPLICATE / STAY-CANONICAL outcomes. However, all five
entries fail the binding evidence record in at least one independently
reproducible way: one source range omits text used by its own claim, and four
sweeps omit material carrier occurrences, including later-authority
CITED-OUTSIDE-RANGE obligations.

Result: 0 AGREE / 5 DISAGREE / 0 UNSURE / 0 MISSING.

---

# DECISIONS/QUESTIONS FOR W3X

None.

Recommendation: return only the five section-11 entries for bounded evidence
repair. Do not reopen Batch 1 and do not alter the substantive dispositions
unless a repair exposes new contradictory evidence.

---

# Entry-by-entry verdicts

## LED-082 - DISAGREE

The substantive D topology contract and CURRENT-DUPLICATE outcome are sound.
The entry nevertheless fails two checkable evidence details.

First, DOCUMENT says lines 878-895 while CLAIM includes `use a conservative
local activation policy`, which is authority line 896. The source range must
include the text used by the claim (or the claim must be narrowed).

Second, the occurrence record omits the Re-Decision Evaluation's later full D
restatement at lines 782-812: x=8*k at 786, internal e=16*m+8/pitch-1 at
791-800, row-boundary e=16*m and two pitch-2 parity edges at 802-809. This is
a material CARRIER of the same contract, not merely a lexical hit, and is not
one of the occurrences enumerated in SWEPT/REASON.

## LED-082a - DISAGREE

The section-11 source supports the status claim and CURRENT-DUPLICATE remains
plausible. The sweep is incomplete. Authority D4-Q05 at lines 1541-1544 says
the threshold-scaling IDEA may be measured for D's single uncertain internal
candidate and that the old parameter/name has no automatic right to survive.
That is a later-authority CARRIER of the same experiment-candidate / parameter-
fate proposition. It is absent from SWEPT and from CITED-OUTSIDE-RANGE, even
though the entry claims no other match. Scope 0.6 therefore requires a routed
later-tranche occurrence record.

## LED-083 - DISAGREE

The exact/conservative/approximate characterisation is substantively correct.
The occurrence record is incomplete under the entry's own treatment of
partial-limb carriers. Re-Decision Evaluation lines 117-119 state that a
FRAME/FRAME macroblock-row boundary is processed in pitch-2 conservative form
rather than exact pitch-1 form; its architecture-comparison row at line 670
again records D's FRAME/FRAME boundary as approximate. The entry treats the
authority section-0 approximation limb alone as a CARRIER, so these equivalent
occurrences cannot consistently be omitted from the declared sweep.

## LED-084 - DISAGREE

The three risk limbs are supported and share the stated CURRENT-DUPLICATE
status. The sweep/CITED-OUTSIDE-RANGE record is incomplete. In particular,
authority lines 1224-1225 explicitly require measuring the sample/topology
difference between D's pitch-2 treatment and exact pitch-1 treatment on
FRAME/FRAME boundaries. That is a later-authority CARRIER of risk 2 and must be
routed under scope 0.6. Re-Decision Evaluation line 670 and lines 1041-1043
also restate the false-internal-candidate / frame-frame-approximation cost and
are omitted from the occurrence enumeration.

## LED-085 - DISAGREE

The contingent-viability proposition and STAY-CANONICAL outcome are sound.
The later-authority occurrence record is not complete: the v1.01 revision note
at authority lines 1971-1972 explicitly records the safety correction that D
is not a forced fallback if it also fails its viability criteria. That is an
occurrence of the same proposition in the later a6-owned range and is absent
from the entry's CITED-OUTSIDE-RANGE record. The correction need not change the
disposition; it must make the occurrence record complete.
