# T1S01a5b BATCH 1 - COVERING NOTE FOR W3C

**Version:** 1.0
**Date:** 2026-08-21
**Author:** W3D
**Audience:** W3C, fresh session, no prior context assumed
**Binding scope:** Deblock4_T1_W3C_Review_Scope_v1_15.md (in this package)

---

# 1. WHAT YOU ARE REVIEWING

You are the independent reviewer for T1 sub-tranche a5b, BATCH 1: the
designer's claim-level adjudication of the ratified MPEG-2 authority's
sections 9 and 10 (lines 716-876) against the 38-file documentation
population. The ledger under review is:

    T1S01a5b_A_Ledger_Body_Part2_v1_1.md   (24 entries, LED-064..081a)

Your job is to attack it: verify dispositions against the corpus, not
against the designer's confidence. The scope document is binding on both
of us; where this note and the scope disagree, the scope wins.

# 2. WHAT KIND OF REVIEW THIS IS - AND IS NOT

This is the FIRST a5b batch and NOT the final sub-tranche of the T1S01
document set. Per scope 4.0a that means:

- PER-SUB-TRANCHE REVIEW ONLY: the five standard questions of scope 4.1
  applied to these 24 entries, plus Q-F on every entry carrying a DERIVED
  block (LED-067, LED-081 - check the ledger's own DERIVED fields; if you
  find a DERIVED block anywhere else, review it under Q-F too).
- NO CROSS-ENTRY CONSISTENCY PASS. That pass runs once, at the final a5b
  sub-tranche, over the whole Part-2 ledger. Do not attempt it here and do
  not charge the ledger with cross-batch inconsistencies that the declared
  batch structure already routes (section 3 below).
- Sections 11-13 (lines 877-1098, LED-082..097) are LATER a5b batches.
  Entries here that cite them carry IN-RANGE CROSS-NOTES naming the owning
  reserved entry. Verify the citation is honest; do not adjudicate the
  cited material.

# 3. GROUND RULES ALREADY SETTLED - DO NOT REOPEN

- Sub-tranche a5 (authority lines 223-715) is CLOSED: final ledger
  T1S01a5_A_Ledger_Body_Part1_v1_10, 44 entries, ratified cap-and-carry
  (DEC-85, DEC-88). Its residue is routed at Standing Task Register v1.36
  section 0c. Per DEC-73 there is NO Tier C resample and NO probe-suite
  rerun for a5, and no a5 correction generation may be opened. Where a
  batch-1 entry cites a5 ground as settled footing, take it as settled.
- The population is FIXED at 38 files, derived and enumerated in
  T1S01a5b_A_Population_Delta_v1_0.md (in this package). It supersedes
  Part A.3 of the coverage map (which declared 40). If you believe a file
  is wrongly in or out, that is a FINDING to report, not a licence to
  sweep a different population.
- The authority is pinned at v1.05. Its own next bump is W3X-ratified
  only; ledger PROPOSED ACTIONs are proposals.

# 4. OPEN CONDITION YOU MUST CARRY, NOT CLOSE

LED-070a proposes duplicate-action POINTER for the 9.3 pointer sentence,
PROVISIONAL on LED-097 (section 13.5) confirming the canonical home. That
condition is OPEN ACROSS BATCHES: LED-097 belongs to a later a5b batch and
is not in front of you. Review LED-070a's reasoning as stated; verdict on
its evidence; do NOT treat the open condition as a defect. If you think
the provisional structure itself is unsound, say so as a finding.

# 5. WHERE TO CONCENTRATE ATTACK

In descending order of value to the project:

1. LED-081a (the batch's ONE Tier A, CONFLICTING). The ledger claims the
   authority's line 873 sentence "Section 15 requires a revisit ..." names
   the wrong section: section 15 (1157-1260) contains no revisit
   requirement, section 16 (1261-1284) imposes it. READ BOTH SECTIONS
   YOURSELF. If you find a revisit requirement inside section 15 that the
   designer's semantic sweep missed, the entry is overturned and you
   should say so plainly. If you confirm it, verdict on the proposed
   one-word remedy ("Section 15" -> "Section 16").
2. LED-074 (the batch's ONE CURRENT-UNIQUE). Uniqueness claims are where
   a5 failed. The SWEPT field enumerates the ownership and collision probe
   families and classifies every neighbour as DIFFERENT. Attack it with
   any carrier the families missed - a reformulation of exactly-once
   descriptor ownership anywhere in the population defeats the entry.
3. LED-076. The designer counted the Re-Decision Evaluation's "changes one
   thing vertically" sentence as a CARRIER of the authority's "most direct
   observable difference" claim - a deliberate semantic-reformulation
   call, stated attackably in the entry. If you read those as different
   propositions, say so; the entry records the consequence either way.
4. Every STAY-CANONICAL's named-copy evidence: open the named copies and
   check they say what the entry says they say, including the recorded
   HISTORICAL VARIANCES at LED-075/077 (Evaluation pre-decision UNKNOWN
   rows) and the NAMING VARIANCE at LED-077 (section 0 labels).
5. The near-zero-Tier-A reasoning in the batch summary (sections 9-10
   DESCRIBE rejected designs, they do not ASSERT them). If any line of
   716-876 reads to you as an assertion of rejected design, that finding
   outranks everything else in this list except item 1.

# 6. EVIDENCE STANDARD

Occurrence-level, per scope: name file and line(s) for every disagreement;
open and read before classifying; "probe found nothing" is not evidence of
absence unless the probe family is stated. Verdict vocabulary is the
scope's (section 6). Every entry ends with a blank VERDICT (W3C) field:
fill each one.

# 7. PACKAGE INVENTORY AND YOUR RESPONSE

This package (T1S01a5b_A_Designer_Batch_v1.zip) contains:

    T1S01a5b_A_Covering_Note_for_W3C_v1_0.md      (this file)
    T1S01a5b_A_Ledger_Body_Part2_v1_1.md          (under review)
    T1S01a5b_A_Population_Delta_v1_0.md           (population of record)
    T1S01a5b_A_Population_and_Coverage_Map_v1_0.md (segmentation; Part A.3
                                                    superseded by the Delta)
    Deblock4_T1_W3C_Review_Scope_v1_15.md         (binding)
    Deblock4_Standing_Task_Register_T_Series_v1_36.md (routing context)
    Deblock4_T1_Resume_Brief_v1_16.md             (orientation)

W3X supplies the reference document set separately per scope 4.2; sweep
against that set, not against this zip.

Name your response T1S01a5b_B_Coder_Response.zip. Deliver: the ledger with
VERDICT fields completed, plus a findings document for anything that does
not fit a verdict field. US-ASCII, CRLF.

---

*Revision history*

```text
v1.0 (2026-08-21) First issue, authored by W3D per W3X ruling A12.
```
