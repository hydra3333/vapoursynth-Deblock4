# T1S01a5b BATCH 1 - COVERING NOTE FOR W3C - CORRECTION REVIEW ROUND

**Version:** 1.2
**Date:** 2026-08-22
**Author:** W3D
**Audience:** W3C, fresh session, no prior context assumed
**Binding scope:** Deblock4_T1_W3C_Review_Scope_v1_15.md (in this package)

---

# 0. RESUMING AFTER A TRANSPORT FAILURE - READ FIRST

A previous W3C session for this exact round died repeatedly with
message-stream transport errors before any verification work was done. It
left a checkpoint, included in this package as
T1S01a5b_B_W3C_Pause_Checkpoint_20260822.md. Its own record of the pause
point is authoritative and this note agrees with it: NO v2 verdict was
issued, NO reviewed v1.2 ledger was generated, NO v2 findings document was
generated. Nothing is owed back to that session and nothing from it is
carried forward except the checkpoint itself.

Do not re-orient from scratch. Start at section 1 below.

PACKAGE REDUCED DELIBERATELY: this round ships without the Standing Task
Register v1.36 and the T1 Resume Brief v1.16, which the v2 package carried
and which together were half its bulk. They are routing/orientation
context, not evidence for delta verification, and their absence is a
transport mitigation, not an oversight. If a correction under review turns
out to need either document, say so as a finding and W3X will supply it -
do NOT substitute assumptions about their content.

# 1. WHAT THIS ROUND IS

Batch 1 (authority sections 9-10, lines 716-876) has completed one full
designer->coder review cycle. Your predecessor session's review
(T1S01a5b_B, findings F1-F9, 13 AGREE / 11 DISAGREE) was verified and
ACCEPTED IN FULL by W3D; the ledger under review here is the correction
generation implementing it:

    T1S01a5b_A_Ledger_Body_Part2_v1_2.md   (28 entries)

This round is BOUNDED CORRECTION REVIEW, not a fresh batch review:

- VERIFY the 16 entries marked "reissued", "new", "repaired" or "amended"
  in the batch summary - for reissued/new entries the whole entry; for
  repaired/amended entries ONLY the labelled REPAIR-v1_2 block.
- The 12 entries marked "agreed" carry their T1S01a5b_B AGREE verdicts
  and are NOT re-opened.
- The review question per corrected item: does the repair implement the
  finding, and is its evidence sound? Use the scope's verdict vocabulary.
- Still NO cross-entry consistency pass (that runs at the final a5b
  sub-tranche), no a5 reopening, no source/build/git.

# 2. WHAT CHANGED, BY FINDING

    F1.1  lines 718 heading -> occurrence records at LED-064/067
    F1.2  line 749 heading -> occurrence records at LED-068/069
    F1.3  line 763 B2 PRIMARY CANDIDATE -> new LED-070b
    F2    Grid Knowledge v1.2 stale current-knowledge assertions ->
          decided-conflict records at LED-064/067
    F3    LED-066 narrowed to items 1-4; new LED-066a (uncertainty
          clause, CURRENT-UNIQUE)
    F4    LED-067a reissued: pointer VERIFIED via Appendix C 1873-1901;
          v1.1 over-restriction retracted
    F5    LED-073 narrowed to role/origin; new LED-073a (section-11
          pointer, CURRENT-UNIQUE)
    F6    LED-074 narrowed to the ownership clause; new LED-074b
          (geometry, CURRENT-DUPLICATE)
    F7    LED-079 REPAIR block prints the 18-file/76-locus enumeration
          with the 81-vs-76 count basis reconciled
    F8    LED-081 REPAIR block adds the intro v1.33:779 carrier and
          retracts the false "no other file matched"
    F9    LED-081a reissued: SUPERSEDED / SUPERSEDED-KIND ERRONEOUS
          (DEC-84 cited, not paraphrased), Tier A retained, mandatory
          PROPAGATION executed (four dependencies found and routed),
          false sweep statement replaced by the full 13-locus revisit
          enumeration, authority remedy unchanged

# 3. WHERE TO CONCENTRATE

1. LED-081a: check the PROPAGATION block against DEC-84's six steps
   (scope 0.11) - population declared, reliance-not-wording searched,
   candidates classified with locations, each dependency routed, no
   exhaustiveness overclaim. Package member
   T1S01a5b_A_Population_Delta_v1_1.md IS one of the routed corrections;
   verify its one-word change.
2. The three CURRENT-UNIQUE entries (066a, 073a, 074) - each carries its
   reformulation families; attack with any carrier they missed.
3. LED-070b's copy list - open the cited lines.
4. The REPAIR-v1_2 blocks' claim that no adjudication outcome changed
   where they only extend evidence (064, 067, 068, 069, 070, 079, 081).

# 4. OPEN CONDITIONS CARRIED, NOT CLOSED

- LED-070a POINTER remains provisional on LED-097 (a later a5b batch).
- The map Part-B amendment (four resegmented rows) is RECORDED in the
  ledger's coverage declaration pending the map's own v1.1 bump by W3X.
- Blurb corrections (coder v1.7:49, designer v1.9:40) are routed to the
  deferred orientation bump round, not performed here.

# 5. PACKAGE INVENTORY AND YOUR RESPONSE

T1S01a5b_A_Designer_Batch_v2_SLIM.zip contains:

    T1S01a5b_A_Covering_Note_for_W3C_v1_2.md      (this file)
    T1S01a5b_A_Ledger_Body_Part2_v1_2.md          (under review)
    T1S01a5b_A_Population_Delta_v1_1.md           (population of record,
                                                   DEC-84-corrected)
    T1S01a5b_A_Population_and_Coverage_Map_v1_0.md (amendment recorded in
                                                   the ledger, bump pending)
    Deblock4_T1_W3C_Review_Scope_v1_15.md         (binding; 0.11 = DEC-84)
    T1S01a5b_B_W3C_Pause_Checkpoint_20260822.md   (prior session's pause
                                                   record; see section 0)

W3X supplies the reference document set separately per scope 4.2.

Name your response T1S01a5b_B_Coder_Response_v2.zip: the v1.2 ledger with
the 16 open VERDICT fields completed, plus findings for anything that
does not fit a verdict field. US-ASCII, CRLF.

---

*Revision history*

```text
v1.2 (2026-08-22) Reissued for a fresh W3C session after the prior
     session's transport failures. Adds section 0 (resume instructions,
     declared package reduction); inventory updated. NO change to the
     review's scope, bounds or subject matter.
v1.1 (2026-08-21) Correction-round issue, bounded to the T1S01a5b_B
     repairs; supersedes v1.0 for this round only.
v1.0 (2026-08-21) First issue for the initial batch review.
```
