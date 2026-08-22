# Deblock4 - T1S01a5b BATCH 2 DELIVERY PROTOCOL

**Deliverable:** T1S01a5b_A - BATCH 2 DELIVERY AND CHECKPOINT PROTOCOL
**Version:** 1.0
**Date:** 2026-08-22
**Author:** W3D
**Status:** W3X-RULED 2026-08-22. Governs how batch 2 (authority sections
11-13, lines 877-1098, reserved entries LED-082..097) is delivered to and
returned from W3C. It is a DELIVERY rule, not a review-scope rule: Review
Scope v1.15 remains binding and unchanged.
**Encoding:** US-ASCII; CRLF.

---

# 0. THE RULING AND WHY

W3X ruled: batch 2 ships WHOLE - it is NOT pre-split into separate coder
sessions. The size risk is accepted deliberately, and mitigated by
incremental delivery instead.

The reasoning, recorded so a successor does not re-litigate it: splitting a
round costs a coherence pass every time, whether or not the session survives.
Incremental delivery costs nothing when the session survives and limits the
loss to ONE SECTION when it does not. Two coder sessions died on 2026-08-22
before producing any verdict; both left checkpoints that recorded zero
progress, because nothing had been delivered yet. That is the failure this
protocol removes.

Batch 2 is roughly 220 authority lines against batch 1's 160, and batch 1's
final ledger reached 123 KB for 29 entries. Batch 2's package will therefore
likely exceed the payload that failed. Plan for interruption; do not hope
against it.

---

# 1. WHAT W3C MUST DO - THE THREE RULES

```text
RULE 1 - CHECKPOINT BEFORE EACH SECTION
    Before beginning verification of section 11, then 12, then 13, write a
    checkpoint file recording: which sections are COMPLETE and DELIVERED,
    which is STARTING, and the exact position within it. Write it BEFORE the
    work, not after. A checkpoint written before section 12 is what makes
    section 11's delivered verdicts safe.

RULE 2 - DELIVER PER SECTION, NOT AT THE END
    On finishing each section, deliver immediately:
        T1S01a5b_B_Batch2_S<nn>_Verdicts_v1_0.md   (that section's entries,
                                                    verdict fields completed)
        T1S01a5b_B_Batch2_S<nn>_Findings_v1_0.md   (findings for that
                                                    section, or a one-line
                                                    "none raised")
    Do NOT hold section 11's verdicts until section 13 is done. A delivered
    section is banked; an undelivered one is lost with the session.

RULE 3 - AT THE FIRST STREAM ERROR, CHECKPOINT AND STOP
    Do not retry a failing stream. Retrying re-sends the same context and
    makes the condition worse - six consecutive retries failed identically on
    2026-08-22. Write the checkpoint, tell W3X, stop. A fresh session
    resumes from the last delivered section.
```

At the end, W3C assembles the delivered sections into the usual
`T1S01a5b_B_Coder_Response_v1.zip` with a combined reviewed ledger. If the
session dies before assembly, W3D assembles from the delivered parts - which
is precisely why they are delivered separately.

---

# 2. WHAT W3D DOES

```text
- Authors batch 2 in section order (11, then 12, then 13) so the ledger's
  own structure matches the delivery increments.
- Ships the batch SLIM: covering note, ledger, Population Delta v1.1,
  coverage map v1.1, Review Scope v1.15. The Standing Task Register and
  Resume Brief are withheld as routing context - if a check needs either,
  W3C raises a finding rather than assuming content.
- States this protocol in the batch-2 covering note, not merely by
  reference.
- On a mid-round death, resumes from delivered sections only; nothing
  undelivered is treated as reviewed.
```

---

# 3. WHAT W3X DOES

```text
- Carries the package to a FRESH coder chat - one round per chat, never a
  reused or resumed conversation.
- Supplies the reference document set per scope 4.2, as usual. Note it is a
  further large upload into the same session; if a death occurs during or
  just after it, that is diagnostic (payload, not session length).
- Relays each delivered section back as it arrives, or at the end -
  whichever suits; the point is that they EXIST, not that they arrive fast.
- Notes WHERE a failure occurs if one does. Failing during upload or first
  response implicates payload; failing deep into verification implicates
  accumulated session length. The two have different remedies.
```

---

# 4. WHAT THIS PROTOCOL DOES NOT CHANGE

```text
- Review Scope v1.15 remains binding: same five standard questions, same
  verdict vocabulary, same evidence standard, same DEC-50 enumeration and
  DEC-84 propagation duties.
- No cross-entry consistency pass in batch 2 UNLESS batch 2 is the final
  a5b sub-tranche - scope 4.0a governs, not this document.
- No a5 reopening; no source, build, test or git work.
- Batch 1 is CLOSED (ledger Part2 v1.5, 29 entries, all AGREE). Its entries
  are not reopened by batch 2, though batch 2 MUST reconcile the in-range
  cross-notes batch 1 left owing:
      LED-064 -> LED-087        LED-070  -> LED-093
      LED-065 -> LED-091        LED-070a -> LED-097 (the provisional
      LED-067 -> LED-086..091               POINTER condition, still OPEN)
      LED-071 -> LED-093, 091   LED-073  -> LED-082
      LED-073a -> LED-082       LED-079  -> LED-091, 093
```

---

*Revision history*

```text
v1.0 (2026-08-22) First issue, on W3X's ruling that batch 2 ships whole with
     incremental per-section delivery and mandatory pre-section
     checkpointing rather than being pre-split into separate coder sessions.
```
