# Deblock4 - T1S01a5b Batch 2 Section 12 W3C Findings

**Deliverable:** T1S01a5b_B_Batch2_S12_Findings
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

## F23 - LED-091a is not CURRENT-UNIQUE

LED-091a classifies Re-Decision Evaluation 606-607 as DIFFERENT on the ground
that it is a converse proposition. W3C disagrees. Evaluation 595-607 is a
threshold-scale/tuning analysis: an identical two-level real seam is rejected
when the false pattern is rejected; no local threshold distinguishes the two;
and `tuning cannot remove the failure class in principle`. Under scope 0.4's
cold-reader carrier test, that passage substantively carries the proposition
that midpoint threshold scaling does not establish safety.

Recommended repair:
- classify Evaluation 595-607 as CARRIER;
- change DISPOSITION to CURRENT-DUPLICATE;
- set DUPLICATE-ACTION to STAY-CANONICAL with section 12.5 as home;
- update REASON, SWEPT and PROPOSED ACTION accordingly;
- rerun the entry-sweep gate.

## F24 - LED-091b omits direct carriers and an a6 obligation

README 652 states that a midpoint passing the stricter evidence test is
filtered at normal correction strength; README 694 states that the scale
multiplies only alpha/beta activation thresholds and does not reduce correction
strength. Both are direct carriers of LED-091b and should have been reached by
the declared `normal correction strength` / hard-threshold probe family.

Authority Appendix C 1877-1878 independently says `midpoint alpha/beta scaled
once at creation; normal correction strength after activation`. Because that
carrier lies in the later a6-owned range, scope 0.6 requires an explicit
CITED-OUTSIDE-RANGE record.

Recommended repair: add/classify the README occurrences; add and route Appendix
C 1877-1878; rederive the sweep count and run the whole-entry gate. No change
to CURRENT-DUPLICATE / STAY-CANONICAL is otherwise indicated.
