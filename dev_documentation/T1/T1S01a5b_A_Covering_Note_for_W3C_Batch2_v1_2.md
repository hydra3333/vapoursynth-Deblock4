# T1S01a5b BATCH 2 - COVERING NOTE FOR W3C - CORRECTION REVIEW 2

**Version:** 1.2
**Date:** 2026-08-23
**Author:** W3D
**Audience:** W3C, fresh session, no prior context assumed
**Binding scope:** Deblock4_T1_W3C_Review_Scope_v1_15.md (in this package)

---

# 1. WHAT THIS ROUND IS

CORRECTION REVIEW 2 for a5b BATCH 2 (authority sections 11-13, lines
877-1098). Rounds so far:

    Batch2 v1        10 AGREE / 11 DISAGREE   F18-F28  -> ledger v1.3
    Correction 1      3 AGREE /  9 DISAGREE   F29-F37  -> ledger v1.4

W3D verified all nine of the latest findings at exact lines and ACCEPTED
ALL NINE; none was contested. The ledger under review:

    T1S01a5b_A_Ledger_Body_Part2_Batch2_v1_4.md    22 entries

THIRTEEN entries carry recorded AGREE verdicts - ten from Batch2 v1
(LED-086, 087, 088, 089, 090, 091, 093, 097, 097a, 097b) and three from
correction review 1 (LED-082, 085, 096). They are NOT reopened. NINE are
open: LED-082a, 083, 084, 091a, 091b, 092, 092a, 094, 095.

Correction review 1 changed NOTHING substantive - no disposition, tier or
outcome moved, and W3C endorsed the LED-091a overturn, the LED-092 split
and the ERRONEOUS classification. It was a hygiene round, and W3D treats
that as the more damning result: the substance survived review, the
housekeeping did not.

# 2. WHAT WAS REPAIRED, IN THREE GROUPS

```text
ENTRY-SWEEP STALENESS - v1.3 rewrote a field and left its neighbour
asserting the opposite. Scope 0.7 names this failure mode and one
correction generation produced three instances of it.
  F32  LED-091a: SWEPT still said all eight reformulation hits were
       DIFFERENT after REASON had classified one as CARRIER; the a6
       instruction still said CURRENT-UNIQUE after the overturn.
  F33  LED-091b: still justified its split by "its neighbour has none".
       Restated on the ground it should always have used - two distinct
       propositions with different carrier sets, neither proving the
       other.
  F34  LED-092: still said "the README remains their historical ORIGIN".
       Provenance is now stated ONLY at LED-092a; LED-092 states
       retention and nothing else.

CROSS-ENTRY CONSISTENCY
  F29  LED-082a: derived locus count six -> SEVEN, not re-derived after
       F19 added an occurrence. Third stale derived count in a5b.
  F30  LED-083 and F31 LED-084: v1.3 added Evaluation 117-119 to 083 but
       not 084, and authority 1224-1225 to 084 but not 083, although each
       passage carries both entries' limbs. Both entries now carry both;
       1224-1225 is routed to a6 from 083 as well.

EVIDENCE AND CITATION
  F35  LED-092a's PROPAGATION rewritten explicitly against DEC-84's six
       ratified steps. See section 3.
  F36  LED-094: designer introduction line 731 added as CARRIER, and the
       citation to introduction v1.34 WITHDRAWN - that generation is
       outside the declared population. W3X has ruled the population
       stays as declared (Population Delta v1.1, 38 files) for the
       remainder of this batch.
  F37  LED-095: introduction lines 801 and 850 added as CARRIER.
```

# 3. WHERE TO ATTACK FIRST - THE REWRITTEN PROPAGATION

F35 is the finding that mattered, and it deserves the hardest look now.

W3C did not challenge LED-092a's nil-dependents RESULT; it refused the
RECORD, correctly - v1.3 declared no scope inside the block, stated no
method, jumped straight to four opened candidates without showing they
exhausted anything, and silently omitted a README-provenance-adjacent
passage that LED-092 itself cites.

The rewrite answers each point against scope 0.11's six steps: a declared
38-file scope with an explicit statement that no code, mathematics or test
objects can rely on a documentation-provenance claim; a stated method that
is lexical AND semantic, because a provenance dependent could rely without
repeating the phrase; FIVE candidates enumerated with location and basis,
including the Re-Decision Evaluation's A5 section, now classified
NON-RELIANCE on the ground that it is INDEPENDENT PRIOR EVIDENCE which the
false claim over-generalised FROM - the direction of dependence runs the
other way; no routing, since no dependency was found; "none found" recorded
with scope and method; and an explicit residual-risk statement bounding the
exhaustiveness claim.

Test that A5 classification hardest. If A5 is in fact a dependent rather
than a source, the nil result fails and routing is owed.

# 4. ALSO WORTH TESTING

1. That the three groups above did not introduce NEW staleness. W3D has
   now produced three entry-sweep failures in one generation; assume the
   repairs can do the same and read each repaired entry whole.
2. That the thirteen AGREE entries are byte-unchanged apart from verdicts.
3. That the added occurrences are real and correctly classified. W3D has
   now three times added carriers only after review supplied them - treat
   the occurrence records as the weakest part of this ledger.
4. Coverage: 22 entries, lines 877-1098 tiled exactly.

# 5. PACKAGE AND RESPONSE

T1S01a5b_A_Designer_Batch2_v3_SLIM.zip:

    T1S01a5b_A_Covering_Note_for_W3C_Batch2_v1_2.md   (this file)
    T1S01a5b_A_Ledger_Body_Part2_Batch2_v1_4.md       (under review)
    T1S01a5b_A_Batch2_Delivery_Protocol_v1_0.md
    T1S01a5b_A_Population_Delta_v1_1.md
    T1S01a5b_A_Population_and_Coverage_Map_v1_1.md
    Deblock4_T1_W3C_Review_Scope_v1_15.md

SLIM as before: register and resume brief withheld as routing context;
raise a finding rather than assuming their content. The delivery protocol
still binds - checkpoint before each section, deliver per section, and at
the first stream error checkpoint and STOP. Name your response
T1S01a5b_B_Coder_Response_v3.zip. US-ASCII, CRLF.

---

*Revision history*

```text
v1.2 (2026-08-23) Correction review 2 issue, bounded to the nine
     disagreed entries.
v1.1 (2026-08-22) Correction review 1 issue.
v1.0 (2026-08-22) First issue for the batch-2 review round.
```
