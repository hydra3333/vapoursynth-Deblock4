# Deblock4 - T1S01a5b Batch 2 Section 12 W3C Verdicts

**Deliverable:** T1S01a5b_B_Batch2_S12_Verdicts
**Version:** 1.0
**Date:** 2026-08-22
**Author:** W3C
**Route:** W3C -> W3X -> W3D
**Reviews:** T1S01a5b_A_Ledger_Body_Part2_Batch2_v1_2.md, section 12 entries
**Binding scope:** Deblock4_T1_W3C_Review_Scope_v1_15.md
**Nature:** DOCUMENT REVIEW ONLY. No source, build, test or git.
**Encoding:** US-ASCII; CRLF.

---

# Plain-English summary

W3C reviewed LED-086 through LED-091b and the recorded 1047-1048 separator.
The coverage is complete and the worked transposition, footprint, collision,
candidate-cost and irreducible-threshold arguments reproduce. Six entries
AGREE. Two do not: LED-091a's CURRENT-UNIQUE claim fails because the
Re-Decision Evaluation already states that tuning cannot remove the failure
class in principle, and LED-091b's occurrence record misses direct carriers in
the README and Appendix C.

Result: 6 AGREE / 2 DISAGREE / 0 UNSURE / 0 MISSING.

---

# DECISIONS/QUESTIONS FOR W3X

None.

Recommendation: carry the six AGREE entries unchanged and return LED-091a and
LED-091b for bounded correction only. For LED-091a, change the disposition to
CURRENT-DUPLICATE / STAY-CANONICAL unless W3D can show why Evaluation 596-607
does not semantically carry the no-safety-guarantee proposition.

---

# Entry-by-entry verdicts

## LED-086 - AGREE

Authority 916-920 supports the record-preservation rationale. Appendix C
1865-1871 is a genuine compressed duplicate: it explicitly labels itself a
compact permanent rejection record and identifies resurfacing of old A as the
trigger. CURRENT-DUPLICATE / STAY-CANONICAL and the a6 routing are sound.

## LED-087 - AGREE

The transposition arithmetic reproduces: r=4*j maps through e=2*r+p to
literal-A e=8*j+p, with primary e=16*k+p, midpoint e=16*k+8+p and pitch 2.
The Evaluation 307-346 and 397-412 and Appendix C 1880-1883 independently
carry the result. The LED-082 lattice cross-note is correctly classified as a
different proposition.

## LED-088 - AGREE

The worked e=8 counterexample is correct. The two pitch-2 projections do not
filter the actual adjacent 7/8 pair, and Evaluation 357-383 plus Appendix C
1885-1888 duplicate the result. CURRENT-DUPLICATE / STAY-CANONICAL is sound.

## LED-089 - AGREE

The write-set intersections reproduce exactly: F intersects E at {14,16} and
F intersects O at {15,17}; their union covers all four frame-edge outputs.
Evaluation 458-497 and Appendix C 1890-1893 carry the same collision/new-
algorithm consequence. The literal-A non-collision occurrence at Evaluation
453 is correctly classified DIFFERENT.

## LED-090 - AGREE

The 4-for-2 candidate arithmetic reproduces for both literal A and the faithful
union. Evaluation 397-435 carries both cost limbs. The separate 50 percent
false-midpoint consequence at 414-415 is correctly kept outside this entry.

## LED-091 - AGREE

The identical-tuple argument is valid: a local threshold cannot distinguish
causes producing the same samples, so threshold scaling tunes the false-
positive/weak-seam trade rather than eliminating it. Evaluation 595-607,
Appendix C 1895-1897 and authority section-0 item 13 independently carry the
proposition. The CURRENT-DUPLICATE / STAY-CANONICAL result is sound.

## LED-091a - DISAGREE

The source proposition is supported, but CURRENT-UNIQUE is not. Re-Decision
Evaluation 595-607 is not merely the converse proposition. In the immediately
preceding threshold-scale analysis it states that rejecting the identical
pattern also rejects a real two-level seam, then concludes: `No local
threshold can distinguish` the causes and `tuning cannot remove the failure
class in principle`. A cold reader can recover from that passage the same
substantive proposition as `midpoint_threshold_scale is not a proof of safety`:
no tuning of that threshold scale provides a safety guarantee.

Recommended correction: classify Evaluation 595-607 as a non-canonical
CARRIER, change the entry to CURRENT-DUPLICATE / STAY-CANONICAL, and rerun the
whole-entry sweep/count/tier fields. Tier remains C.

## LED-091b - DISAGREE

The substantive CURRENT-DUPLICATE conclusion is right, but the occurrence
record is incomplete. README lines 652 and 694 directly state that only the
activation thresholds are scaled and that a passing midpoint is filtered at
normal correction strength. They are carriers of the entry's hard-threshold /
normal-strength proposition and are absent from REASON despite the declared
probe family containing `normal correction strength`.

Appendix C 1877-1878 also states `midpoint alpha/beta scaled once at creation;
normal correction strength after activation`. That later-authority carrier is
missing from CITED-OUTSIDE-RANGE and must be routed to a6 under scope 0.6.

## 1047-1048 no-proposition segment - AGREE

The two lines are only a blank and the section-closing horizontal rule. The
recorded no-proposition rationale is correct; the order of the two typographic
items in the prose description is immaterial.
