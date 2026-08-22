# T1S01a5b BATCH 2 - COVERING NOTE FOR W3C - CORRECTION REVIEW 1

**Version:** 1.1
**Date:** 2026-08-22
**Author:** W3D
**Audience:** W3C, fresh session, no prior context assumed
**Binding scope:** Deblock4_T1_W3C_Review_Scope_v1_15.md (in this package)

---

# 1. WHAT THIS ROUND IS

CORRECTION REVIEW 1 for a5b BATCH 2 (authority sections 11-13, lines
877-1098). The first review returned 10 AGREE / 11 DISAGREE (F18-F28).
W3D verified every finding against the corpus at exact lines and ACCEPTED
ALL ELEVEN; none was contested. The ledger under review implements them:

    T1S01a5b_A_Ledger_Body_Part2_Batch2_v1_3.md    22 entries

Ten entries carry recorded AGREE verdicts (LED-086, 087, 088, 089, 090,
091, 093, 097, 097a, 097b) and are NOT reopened. Twelve are open: the
eleven disagreed entries plus the new LED-092a.

The incremental delivery protocol worked and remains in force for this
round: checkpoint before each section, deliver per-section verdicts and
findings as each completes, and at the first stream error checkpoint and
STOP rather than retrying.

# 2. THE TWO SUBSTANTIVE OUTCOMES - VERIFY THESE FIRST

```text
F23  LED-091a's CURRENT-UNIQUE is OVERTURNED to CURRENT-DUPLICATE /
     STAY-CANONICAL. W3C was right: Re-Decision Evaluation 606-607
     ("It proves tuning cannot remove the failure class in principle")
     carries the not-a-safety-proof proposition. W3D had quoted that
     exact passage in a nearest-miss note, labelled it DIFFERENT on the
     strength of the PRECEDING sentence, and moved on. Check that the
     rewritten entry now classifies 595-607 as CARRIER without
     over-correcting: the remaining fifteen-plus parameter occurrences
     are still DIFFERENT, and that negative sweep is retained.

F25  LED-092 is SPLIT on W3X's ruling. Its README-provenance limb becomes
     LED-092a: SUPERSEDED / SUPERSEDED-KIND ERRONEOUS, Tier A - the
     SECOND real ERRONEOUS case in a5b after LED-081a. Authority line
     1052 claims all five section-13 rules are "older README rules";
     the README carries 13.2-13.4 but has NO carrier for 13.1's
     separation rule and none for 13.5's side-data rules (its dct_type
     material runs the other way, recording that decoders do not expose
     the map).
     MANDATORY DEC-84 PROPAGATION WAS EXECUTED: four candidates opened,
     ZERO dependents - every downstream repetition quotes the RETENTION
     limb, never the provenance limb. Attack that result specifically.
     A nil propagation is exactly the kind of finding that is convenient
     to reach and must therefore be checked hardest. An authority repair
     is PROPOSED at LED-092a, not ratified.
```

# 3. THE OTHER NINE - EVIDENCE COMPLETENESS

```text
F18  LED-082: DOCUMENT/CLAIM boundary corrected - line 896 carries BOTH
     this entry's activation-policy clause and LED-082a's
     experiment-candidate clause, so the split is MID-LINE, declared in
     the LED-066b form. Evaluation 786/791-800/802-809 added.
F19  LED-082a: register D4-Q05 1541-1544 added as CARRIER and routed to
     a6; the v1.2 "no other file matched" statement is withdrawn.
F20  LED-083: Evaluation 117-119 and 670 added, for consistency with the
     single-limb restatement v1.2 already accepted.
F21  LED-084: authority 1224-1225 added as risk 2's carrier and routed to
     a6; Evaluation 670 and 1041-1043 added.
F22  LED-085: authority revision record 1971-1972 added and routed.
F24  LED-091b: README 652 and 694 added, plus Appendix C 1877-1878 routed
     to a6. Root cause named in the entry: the probe family used the
     AUTHORITY's vocabulary and never "normal correction strength",
     which is the phrase the README and Appendix C actually use.
F26  LED-094: designer introduction 134-136 reclassified APPLIES ->
     CARRIER.
F27  LED-095: introduction 134-136 and 731-732, and the PreScope response
     42-56 and 552-569, reclassified/added as CARRIER - the last of these
     is the fullest form of the temporal-escape limb in the corpus.
F28  LED-096: probe family widened with "proof obligations" and rerun;
     the introduction's compressed carrier added.
```

# 4. WHAT TO CHECK

1. The two substantive outcomes above, hardest at LED-092a's nil
   propagation and at whether the F23 correction over-corrected.
2. That the ten AGREE entries are byte-unchanged apart from their verdict
   lines.
3. That the added occurrences are real and correctly classified - W3D has
   now twice widened probe families only after review supplied the
   reformulation, so treat the widened families as suspect and test for
   further omissions.
4. Coverage: 22 entries, lines 877-1098 tiled exactly, one recorded
   no-proposition segment.

# 5. PACKAGE AND RESPONSE

T1S01a5b_A_Designer_Batch2_v2_SLIM.zip:

    T1S01a5b_A_Covering_Note_for_W3C_Batch2_v1_1.md   (this file)
    T1S01a5b_A_Ledger_Body_Part2_Batch2_v1_3.md       (under review)
    T1S01a5b_A_Batch2_Delivery_Protocol_v1_0.md
    T1S01a5b_A_Population_Delta_v1_1.md
    T1S01a5b_A_Population_and_Coverage_Map_v1_1.md
    Deblock4_T1_W3C_Review_Scope_v1_15.md

SLIM as before: register and resume brief withheld as routing context.
Raise a finding rather than assuming their content. Name your response
T1S01a5b_B_Coder_Response_v2.zip. US-ASCII, CRLF.

---

*Revision history*

```text
v1.1 (2026-08-22) Correction review 1 issue, bounded to the eleven
     disagreed entries plus the new LED-092a.
v1.0 (2026-08-22) First issue for the batch-2 review round.
```
