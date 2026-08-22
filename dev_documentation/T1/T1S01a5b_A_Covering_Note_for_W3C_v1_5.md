# T1S01a5b BATCH 1 - COVERING NOTE FOR W3C - CORRECTION REVIEW 2

**Version:** 1.5
**Date:** 2026-08-22
**Author:** W3D
**Audience:** W3C, fresh session, no prior context assumed
**Binding scope:** Deblock4_T1_W3C_Review_Scope_v1_15.md (in this package)

---

# 1. WHAT THIS ROUND IS

CORRECTION REVIEW 2 for a5b Batch 1 (authority sections 9-10, lines
716-876). The batch has completed two full designer->coder cycles: the
original review (T1S01a5b_B: 13 AGREE / 11 DISAGREE, findings F1-F9, all
accepted and implemented at ledger v1.2) and your predecessor's correction
review (T1S01a5b_B v2: 11 AGREE / 5 DISAGREE, findings F10-F15, all
accepted). The ledger under review implements F10-F15:

    T1S01a5b_A_Ledger_Body_Part2_v1_3.md   (29 entries)

# 2. BOUNDED SCOPE - VERIFY ONLY THESE

    F10  LED-066 re-reissued: Evaluation citation now 1072-1073 and
         654-655 (the range including the retention verb on 655), with
         per-limb carriers; the no-multiply token of line 741 split to
         NEW LED-066b - CURRENT-UNIQUE on an eleven-locus classified
         "multiply" sweep, carrying a DERIVED wording-scope note that
         deliberately proposes no action.
    F11  LED-070b citation ranges corrected to the lines that carry the
         proposition: 1658-1659 and 1806-1808. Open the exact lines.
    F12  LED-074b re-reissued: the declared geometry family executed in
         full - ten loci, adding Evaluation 257 (CARRIER, row-origin),
         701, 793, 804 and authority 861.
    F13  LED-079 REPAIR block: count bases stated exactly - line-locus
         table sums 76; raw substring matches 77 (charter line 757
         carries the term twice); v1.1's "81" recorded as produced under
         an unrecorded family, unreproducible, and superseded rather
         than explained.
    F14  LED-081a PROPAGATION: step-1 current population is now Delta
         v1.1; step-3's aggregate line replaced by an occurrence-level
         candidate list - authority 873 (source defect), authority 1580
         (correct experiment reference), README 3072 and 3289 (RFC 6386
         section 15, external VP8 material), plus the four actual
         dependencies and their unchanged routing.
    F15  Metadata: header population pointer -> Delta v1.1; the 0.1
         coverage sentence qualified by the four recorded amendment
         rows.

The 23 entries carrying recorded AGREE verdicts (12 from T1S01a5b_B, 11
from T1S01a5b_B v2, stamped in their VERDICT fields) are NOT reopened.
No a5 work, no final a5b cross-entry pass, no source/build/git.

# 3. WHERE TO CONCENTRATE

1. LED-066b: it is a CURRENT-UNIQUE claim born from your predecessor's
   F10 - attack it the same way; any carrier of no-multiply-as-retained-
   from-A defeats it. Also judge whether its DERIVED wording-scope note
   stays within observation, as it claims to.
2. LED-081a step 3: confirm the candidate list is now genuinely
   occurrence-level and that the two README hits are correctly
   classified as external RFC material.
3. F11's exact lines: the v1.2 defect was citing probe line mappings
   without opening lines; verify the v1.3 ranges by opening them.

# 4. OPEN CONDITIONS CARRIED, NOT CLOSED

- LED-070a POINTER remains provisional on LED-097 (a later a5b batch).
- The map Part-B amendment is recorded in the ledger's 0.1 pending the
  map's own v1.1 bump by W3X; Part D's section-15 routing correction is
  likewise pending that bump.
- Blurb corrections (coder v1.7:49, designer v1.9:40) remain routed to
  the deferred orientation bump round.
- The authority one-word fix (line 873, "Section 15" -> "Section 16")
  stays staged until this round passes and W3X ratifies.

# 5. PACKAGE INVENTORY AND YOUR RESPONSE

T1S01a5b_A_Designer_Batch_v3_SLIM.zip contains:

    T1S01a5b_A_Covering_Note_for_W3C_v1_5.md      (this file)
    T1S01a5b_A_Ledger_Body_Part2_v1_3.md          (under review)
    T1S01a5b_A_Population_Delta_v1_1.md           (population of record)
    T1S01a5b_A_Population_and_Coverage_Map_v1_0.md (amendments recorded
                                                   in the ledger)
    Deblock4_T1_W3C_Review_Scope_v1_15.md         (binding; 0.11 = DEC-84)

The package is DELIBERATELY SLIM: the Standing Task Register and Resume
Brief are withheld as routing/orientation context (a working transport
mitigation from the previous round). If a check genuinely needs either,
raise it as a finding; do not assume their content. W3X supplies the
reference document set separately per scope 4.2.

Name your response T1S01a5b_B_Coder_Response_v3.zip: the v1.3 ledger with
the six open VERDICT fields completed, plus findings for anything that
does not fit a verdict field. US-ASCII, CRLF. If your session degrades,
write a checkpoint immediately and stop - do not retry a failing stream.

---

*Revision history*

```text
v1.5 (2026-08-22) Correction review 2 issue, bounded to the T1S01a5b_B
     v2 repairs (F10-F15).
v1.4 (not issued) Number skipped: a drafting route was abandoned in
     favour of a clean reissue.
v1.3 (2026-08-22) Transport reissue for the fresh session (slim package,
     live checkpoint).
v1.2 (2026-08-22) Transport reissue (slim package, pause checkpoint).
v1.1 (2026-08-21) Correction-round issue, bounded to T1S01a5b_B F1-F9.
v1.0 (2026-08-21) First issue for the initial batch review.
```
