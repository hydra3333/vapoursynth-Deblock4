# T1S01a5b BATCH 1 - COVERING NOTE FOR W3C - CORRECTION REVIEW 3

**Version:** 1.6
**Date:** 2026-08-22
**Author:** W3D
**Audience:** W3C, fresh session, no prior context assumed
**Binding scope:** Deblock4_T1_W3C_Review_Scope_v1_15.md (in this package)

---

# 1. WHAT THIS ROUND IS

CORRECTION REVIEW 3 for a5b Batch 1 (authority sections 9-10, lines
716-876) - a TWO-ITEM round. The batch has completed three designer->coder
cycles:

    T1S01a5b_B      13 AGREE / 11 DISAGREE   F1-F9    -> ledger v1.2
    T1S01a5b_B v2   11 AGREE /  5 DISAGREE   F10-F15  -> ledger v1.3
    T1S01a5b_B v3    4 AGREE /  2 DISAGREE   F16-F17  -> ledger v1.4

The ledger under review implements F16-F17:

    T1S01a5b_A_Ledger_Body_Part2_v1_4.md   (29 entries)

27 of the 29 entries now carry recorded AGREE verdicts (12 from B, 11 from
B v2, 4 from B v3: LED-070b, LED-074b, LED-079, LED-081a). They are NOT
reopened.

# 2. BOUNDED SCOPE - VERIFY ONLY THESE TWO

    F16  LED-066: every reference to the split token's source line
         corrected from authority line 741 to line 743. 741 is the
         fixed-point item; 743 is "no float/multiply in the pixel loop".
         Five sites were wrong in v1.3 and all five are corrected: the
         0.3 entry-count note, LED-066's annotation, LED-066's DOCUMENT
         field, LED-066b's DOCUMENT field, LED-066b's DERIVED note.
    F17  LED-066b: SWEPT's distinct-file count corrected from eight to
         SEVEN. The eleven-locus set is unchanged and was already right;
         only the file count was wrong, and the entry's own enumeration
         proves seven.

Both are attackability/accounting repairs. No disposition, tier or
evidence conclusion changed, and W3C's v3 review independently confirmed
LED-066b's CURRENT-UNIQUE result on a rerun of the declared family.

# 3. WHAT TO CHECK

1. Open authority lines 738-745 and confirm 743 is the float/multiply
   item - the whole round turns on that one line number.
2. Count the distinct files in LED-066b's printed locus list and confirm
   seven.
3. Confirm no stale 741 survives as a live claim anywhere. Two mentions
   remain by design, both as correction records that state 743 alongside;
   the revision note also quotes the old "eight files" wording when
   describing what was fixed. If you find a 741 or an eight-file claim
   presented as current fact, that is a finding.

# 4. OPEN CONDITIONS CARRIED, NOT CLOSED

- LED-070a POINTER remains provisional on LED-097 (a later a5b batch).
- Map Part-B amendment and Part-D routing fix recorded in the ledger,
  pending the map's v1.1 bump by W3X.
- Blurb corrections (coder v1.7:49, designer v1.9:40) routed to the
  deferred orientation bump round.
- The authority one-word fix (line 873, "Section 15" -> "Section 16")
  stays staged until Batch 1 closes and W3X ratifies.
- Standing Task Register v1.37 now registers T9, the External Basis
  Revalidation gate (W3X ruling, 2026-08-22). It does not affect this
  round; it is noted so a successor session knows it exists.

# 5. PACKAGE INVENTORY AND YOUR RESPONSE

T1S01a5b_A_Designer_Batch_v4_SLIM.zip contains:

    T1S01a5b_A_Covering_Note_for_W3C_v1_6.md      (this file)
    T1S01a5b_A_Ledger_Body_Part2_v1_4.md          (under review)
    T1S01a5b_A_Population_Delta_v1_1.md           (population of record)
    T1S01a5b_A_Population_and_Coverage_Map_v1_0.md (amendments recorded
                                                   in the ledger)
    Deblock4_T1_W3C_Review_Scope_v1_15.md         (binding; 0.11 = DEC-84)

Package is deliberately SLIM (register and resume brief withheld as
routing context - a working transport mitigation). If a check genuinely
needs either, raise it as a finding rather than assuming their content.
W3X supplies the reference document set separately per scope 4.2.

Name your response T1S01a5b_B_Coder_Response_v4.zip: the v1.4 ledger with
the two open VERDICT fields completed, plus findings for anything that
does not fit a verdict field. US-ASCII, CRLF. If your session degrades,
write a checkpoint immediately and stop - do not retry a failing stream.

If both items pass, Batch 1 is complete and returns to W3X for closure.

---

*Revision history*

```text
v1.6 (2026-08-22) Correction review 3 issue, bounded to F16-F17
     (LED-066 and LED-066b only).
v1.5 (2026-08-22) Correction review 2 issue, bounded to F10-F15.
v1.4 (not issued) Number skipped: a drafting route was abandoned.
v1.3 (2026-08-22) Transport reissue (slim package, live checkpoint).
v1.2 (2026-08-22) Transport reissue (slim package, pause checkpoint).
v1.1 (2026-08-21) Correction-round issue, bounded to F1-F9.
v1.0 (2026-08-21) First issue for the initial batch review.
```
