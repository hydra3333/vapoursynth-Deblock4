# T1S01a5b BATCH 2 - COVERING NOTE FOR W3C

**Version:** 1.0
**Date:** 2026-08-22
**Author:** W3D
**Audience:** W3C, fresh session, no prior context assumed
**Binding scope:** Deblock4_T1_W3C_Review_Scope_v1_15.md (in this package)

---

# 1. WHAT THIS ROUND IS

FIRST REVIEW of a5b BATCH 2: MPEG-2 authority v1.05, sections 11-13,
lines 877-1098, adjudicated at

    T1S01a5b_A_Ledger_Body_Part2_Batch2_v1_2.md    21 entries

Batch 1 (sections 9-10, LED-064..081) is CLOSED - ledger Part2 v1.5,
29 entries, all AGREE across four rounds. It is NOT reopened here. Where
batch 1 left a cross-note owed to this range, the owing entry below
discharges it and says so.

Naming: a5b remains ONE Part-2 ledger for the final cross-entry pass, so
this document is Part2_Batch2; an integrated Part 2 is assembled from both
closed batches at a5b's end. W3X may override.

# 2. THE DELIVERY PROTOCOL FOR THIS ROUND - READ BEFORE STARTING

W3X ruled that batch 2 ships WHOLE rather than pre-split, with the size
risk mitigated by incremental delivery. Three rules bind this round. They
are stated here in full, not merely by reference; the protocol document
itself is `T1S01a5b_A_Batch2_Delivery_Protocol_v1_0`.

```text
RULE 1 - CHECKPOINT BEFORE EACH SECTION
    Before beginning verification of section 11, then 12, then 13, write a
    checkpoint recording: which sections are COMPLETE and DELIVERED, which
    is STARTING, and the position within it. Write it BEFORE the work.

RULE 2 - DELIVER PER SECTION, NOT AT THE END
    On finishing each section, deliver immediately:
        T1S01a5b_B_Batch2_S<nn>_Verdicts_v1_0.md
        T1S01a5b_B_Batch2_S<nn>_Findings_v1_0.md  (or "none raised")
    Do NOT hold section 11's verdicts until section 13 is done. A
    delivered section is banked; an undelivered one dies with the session.

RULE 3 - AT THE FIRST STREAM ERROR, CHECKPOINT AND STOP
    Do not retry. Retrying re-sends the same context and worsens it - six
    consecutive retries failed identically on 2026-08-22, and two coder
    sessions died having delivered nothing. Write the checkpoint, tell
    W3X, stop. A fresh session resumes from the last delivered section.
```

If the session survives to the end, assemble the delivered sections into
`T1S01a5b_B_Coder_Response_v1.zip` with a combined reviewed ledger. If it
does not, W3D assembles from the delivered parts - which is the point.

# 3. WHAT THE BATCH CONTAINS

```text
Section 11 (877-914)    LED-082, 082a, 083, 084, 085
Section 12 (915-1048)   LED-086..090, 091, 091a, 091b, + one recorded
                        no-proposition segment (1047-1048)
Section 13 (1049-1098)  LED-092..096, 097, 097a, 097b

DISPOSITIONS  19 CURRENT-DUPLICATE, 2 CURRENT-UNIQUE
TIERS         21 C. No Tier A or B arose anywhere in batch 2.
C-O-R         15 records, all owned by T1S01a6 - Appendix C is cited by
              five, the D4 registers by seven.
```

# 4. WHERE TO ATTACK FIRST

These are the places W3D considers most likely to be wrong. Attack them
before the routine entries.

```text
1. THE TWO CURRENT-UNIQUE FINDINGS. LED-091a (midpoint_threshold_scale
   "is not a proof of safety") and LED-097b ("runtime correctness must
   not depend on side data until its trust contract is scoped"). Both
   claim NO carrier exists on the 38-file population. Batch 1's review
   overturned uniqueness claims twice; rerun the families independently.
   LED-091a's declared nearest miss is Evaluation 606-607 (the converse
   claim); LED-097b's is register D4-Q13 1575-1577, which carries the
   other two limbs of the same segment but not this one.

2. THE FIVE SPLITS. LED-082a, LED-091a/091b, LED-097a/097b. Each was
   split at authoring time because EVIDENCE STATUS differed across limbs
   - the LED-066/066b lesson from batch 1. Test whether the splits are
   real or whether I manufactured atomicity that is not there. Test also
   for splits I MISSED: batch 1 produced four entries only because review
   found propositions the map and I had both walked past.

3. LED-092's CANONICAL-HOME RULING. The map asked for it. I ruled section
   13 STAYS CANONICAL for the retained rules, with the README as their
   historical ORIGIN and de-duplication left to T3. If that is wrong, the
   consequences run through LED-093..096, all of which cite README
   carriers.

4. LED-093's USE OF PR-1. I applied a settled precedent (Project Status
   457-463: principle at 13.1, proof at 12.5) rather than re-adjudicating.
   Check that I applied it correctly and did not smuggle in a new ruling.

5. COVERAGE ITSELF. Section 0.1 claims lines 877-1098 tile exactly, with
   one no-proposition segment recorded. Verify the tiling against the
   authority. A missed heading was batch 1's LED-070b.
```

# 5. WHAT IS NOT IN SCOPE

No a5 or batch-1 reopening. No source, build, test or git work. No
cross-entry consistency pass in batch 2 - scope 4.0a governs whether one
runs at a5b's end, not this round. Nothing in the ledger is ratified;
every PROPOSED ACTION is a proposal awaiting T3.

# 6. PACKAGE INVENTORY AND YOUR RESPONSE

T1S01a5b_A_Designer_Batch2_v1_SLIM.zip contains:

    T1S01a5b_A_Covering_Note_for_W3C_Batch2_v1_0.md   (this file)
    T1S01a5b_A_Ledger_Body_Part2_Batch2_v1_2.md       (under review)
    T1S01a5b_A_Batch2_Delivery_Protocol_v1_0.md       (binding this round)
    T1S01a5b_A_Population_Delta_v1_1.md               (38 files, the
                                                       population of
                                                       record)
    T1S01a5b_A_Population_and_Coverage_Map_v1_1.md    (B.4/B.5/B.6 govern
                                                       this batch)
    Deblock4_T1_W3C_Review_Scope_v1_15.md             (binding; 0.6 =
                                                       C-O-R form,
                                                       0.11 = DEC-84)

The package is deliberately SLIM: the Standing Task Register and the T1
Resume Brief are WITHHELD as routing context, a transport mitigation that
has now worked four times. If a check genuinely needs either, raise it as
a finding rather than assuming their content. W3X supplies the reference
document set separately per scope 4.2.

Respond per section (Rule 2). US-ASCII, CRLF. Verdict vocabulary and
evidence standard per scope; a DISAGREE needs the line numbers that
support it, opened and read - probe line approximations locate, they do
not cite.

---

*Revision history*

```text
v1.0 (2026-08-22) First issue for the batch-2 review round: sections
     11-13, 21 entries, under the W3X-ruled incremental delivery
     protocol.
```
