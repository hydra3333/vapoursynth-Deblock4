# Deblock4 - T1S01a5b Batch 2 Section 11 W3C Findings

**Deliverable:** T1S01a5b_B_Batch2_S11_Findings
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

## F18 - LED-082 source range and occurrence record are incomplete

Authority line 896 supplies `use a conservative local activation policy`, but
LED-082 DOCUMENT ends at line 895 while CLAIM uses that clause. Separately,
Re-Decision Evaluation 782-812 contains another material occurrence of the D
topology contract (786, 791-800, 802-809) which the entry's sweep does not
enumerate.

Recommended repair: extend/narrow the DOCUMENT/CLAIM boundary consistently and
add/classify the omitted Evaluation occurrence; rerun the whole-entry gate.

## F19 - LED-082a misses a later-authority D4-Q05 carrier

Authority 1541-1544 says the threshold-scaling idea may be measured for D's
single uncertain internal candidate and that the old parameter/name has no
automatic right to survive. This materially carries LED-082a's proposition and
lies in the later a6-owned range, but LED-082a neither classifies it nor routes
it as CITED-OUTSIDE-RANGE.

Recommended repair: add the occurrence, classify it, route it to a6, and
correct the no-other-match statement.

## F20 - LED-083 misses repeated FRAME/FRAME approximation carriers

Re-Decision Evaluation 117-119 states the pitch-2-conservative-versus-exact-
pitch-1 FRAME/FRAME approximation directly; line 670 records the same D main
risk in the architecture comparison. The entry already accepts a single-limb
approximation restatement as a CARRIER, so these equivalent occurrences must
be handled consistently.

Recommended repair: add/classify the omitted occurrences and rederive the
sweep count if one is retained.

## F21 - LED-084 omits risk carriers, including an a6 obligation

Authority 1224-1225 directly carries risk 2 by requiring measurement of D's
pitch-2 treatment versus exact pitch-1 on FRAME/FRAME boundaries. Evaluation
670 and 1041-1043 also state the frame-frame approximation / false internal
activation costs. The authority occurrence is in later-tranche territory and
needs a CITED-OUTSIDE-RANGE record.

Recommended repair: add/classify the omitted occurrences and route 1224-1225
to a6.

## F22 - LED-085 later-authority occurrence record is incomplete

Authority revision record 1971-1972 states that D is not a forced fallback if
it also fails its viability criteria. It is a later-range occurrence of the
same viability-contingency proposition but is absent from LED-085's routed
occurrences.

Recommended repair: add/classify the occurrence under scope 0.6. No change to
CURRENT-DUPLICATE / STAY-CANONICAL is presently indicated.
