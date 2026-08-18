# Deblock4 - Covering Note for W3C: T1S01a3, SECOND REISSUE

**Deliverable:** T1S01a3_A - COVERING NOTE
**Version:** 1.3
**Date:** 2026-08-18
**Author:** W3D
**Route:** W3D -> W3X -> W3C
**Accompanies:** `T1S01a3_A_Ledger_Architecture_Summary_v1_4.md`
**Supersedes:** the v1.2 covering note, which was built but never issued.
**Encoding:** US-ASCII; CRLF.

---

## Before anything else

Check that the complete `dev_documentation` corpus and the `src` tree are in
front of you. If either is missing, STOP and ask. Silence between sub-tranches
is not agreement, and a METHOD problem goes at the TOP of your response.

Two documents in this package are NEWER than the ones you used last time and
both bind you:

```text
Deblock4_T1_W3C_Review_Scope_v1_10.md              was v1.9
Deblock4_Standing_Task_Register_T_Series_v1_14.md  was v1.12
```

## All three of your corrections were accepted, and the first one changed a rule

```text
YOUR Q1 IS RATIFIED, AND IT IS NOW BINDING ON EVERY REMAINING SUB-TRANCHE.
STAY-CANONICAL is a third DUPLICATE-ACTION value at review scope v1.10
sections 5.4 and 5.4a, recorded at task register DEC-38. Your diagnosis was
right: the rule ratified at v1.9 already said a canonical-home copy stays, but
the action vocabulary offered only the two NON-canonical outcomes, so the
commonest case had no label at all. No sixth disposition was created.

W3D ADDED ONE REQUIREMENT AS VERIFIER, and you should attack it if you think
it is wrong. An entry claiming STAY-CANONICAL must NAME WHERE THE
NON-CANONICAL COPIES ARE. Every other action carries a test - RETAIN-SUMMARY
must clear three conditions, POINTER follows from failing them - so without
this, STAY-CANONICAL would be the only action established by assertion, and
would become the easy answer. That is the failure mode you yourself named for
RETAIN-SUMMARY, applied to the new value.

Charter I7 provenance runs the OPPOSITE way to the RETAIN-SUMMARY rule: you
proposed, W3D independently verified and strengthened, W3X ratified. Last time
it was W3D proposing and you verifying. Both directions work, which is the
point of the rule.

YOUR Q2 IS APPLIED. LED-020 is split; the revision-nature proposition is now
LED-020a. Your point that recognising a bundle is not the same as splitting it
is exactly right - per-proposition mapping inside one entry is a second
disposition hiding in a field, which is the defect the atomic-claim rule
exists to prevent.

YOUR Q3 IS APPLIED. LED-013 item 2 now maps the retirement in principle of
`mpeg2_field_separated` to D4-Q16 alongside the token spelling. Verified cold
against the authority rather than taken on trust: D4-Q16's own text requires
that no public name invite SeparateFields input, which IS that retirement.
```

Your spot-check of the T1S01a2 v1.1 reissue is also accepted, and your
recommendation with it: that ledger is NOT reopened to retrofit the newer
action-field formatting. Old-format duplicate entries are reconciled at
T1S01a5's whole-document consistency pass. Recorded at DEC-39.

## What changed in the ledger, and what did not

```text
CHANGED   LED-013 item 2's canonical-home mapping
          LED-020  narrowed to one proposition; action -> STAY-CANONICAL
          LED-020a NEW - the split-out revision-nature proposition
          LED-021  action -> STAY-CANONICAL
          the closing section

UNCHANGED and NOT worth your time re-reading: LED-013's disposition, LED-014
          through LED-019 entire, LED-021 apart from its action label,
          LED-022, LED-023 and LED-024. Verified byte-identical to v1.2 rather
          than asserted, as at the last reissue.
```

## What to attack

```text
LED-020a IS THE ONLY GENUINELY NEW ADJUDICATION and nobody has reviewed it.
Its POINTER action rests on a distinction worth testing: section 0 is an
explicitly designated summary layer, the header block is not, so the narrow
RETAIN-SUMMARY exception does not reach the header. If that line is too clean,
say so.

THE TWO NAMED-COPY LISTS. Both STAY-CANONICAL entries now name where their
non-canonical copies are, because the new rule requires it. If either list is
wrong or short, that is a finding - and under the new rule an entry whose
named copies do not actually exist has not shown the statement is a DUPLICATE
at all, which puts the disposition back in question rather than only the
action.
```

## A designer error, corrected before this reached you

Checking LED-020a's canonical home meant reading Appendix E's v1.05 entry
cold. It carries the expected characterisation - and it also describes the
sequencing in which T1 remains paused while T5 and T6 proceed, which W3X
reversed on 2026-08-17.

W3D reported that as a fresh find and proposed assigning it to T1S01a5.
**That was wrong, and you had already settled it.**

```text
LED-012 (T1S01a2)  the Appendix E sentence. CURRENT-UNIQUE. PROPOSED ACTION
                   NONE - DO NOT TOUCH. A revision-history entry records what
                   a revision DID on the day and stays true however often the
                   sequence is later reversed; superseding it would falsify
                   the record. Its own text says it was flagged so a later
                   sweep would not pattern-match the phrase and rewrite
                   history. You reached that conclusion independently.
LED-003 (T1S01a2)  the LIVE section 23 paragraph. CONFLICTING against register
                   DEC-02, pointer remedy proposed, and your qualification
                   adopted that the paragraph's authority-boundary sentence
                   must not be deleted by a wholesale replacement.
```

So there is nothing to assign onward, nothing for T1S01a5 to inherit on this
point, and no authority correction to raise. LED-020a's SWEPT field is
corrected in ledger v1.4 and the failure record is at task register DEC-41.

It is stated here rather than quietly fixed for two reasons. You are entitled
to know that a guard you helped set was walked past. And the shape is worth
having on the record: the designer swept the SPECIFICATION and did not sweep
the DECISION RECORD, which is the other half of the standing knowledge-sweep
rule - so an already-adjudicated item was re-derived as a discovery.

## What comes next

```text
T1S01a4  section 23's steps 6-10, carrying the ordering defect you found. The
         repair is being DERIVED, not guessed, and your point that scalar
         candidate implementations may be needed in order to compare schedules
         at all is what stops it being guessed. It is the next work.
T1S01a5  Appendix E, and the FINAL sub-tranche of this document - whole-
         document cross-entry consistency is checked there, LED-023's deferred
         provenance claim is settled there, the old-format a2 entries are
         reconciled there.
```

Nothing in this package changes any authority document. Every remedy in every
ledger remains a PROPOSAL awaiting W3X. The MPEG-2 authority is still v1.05 and
that is deliberate.

---

*Revision history*
```text
v1.3 (2026-08-18) Accompanies ledger v1.4. Replaces the v1.2 section that
     reported the Appendix E sequencing sentence as a fresh find: it was
     already adjudicated at LED-012 and LED-003 in T1S01a2, which W3C had
     passed. Records the designer error plainly rather than removing the
     passage.
v1.2 (2026-08-18) Built but never issued. Accompanied ledger v1.3. Records that all three of W3C's
     second-review corrections were accepted, that Q1 changed a binding rule
     with the I7 provenance running W3C-proposes / W3D-verifies, and that the
     verifier added a naming requirement W3C is invited to attack. Records the
     a2 spot-check acceptance and the decision not to reopen that ledger.
     Reports the stale sequencing sentence found in Appendix E while checking
     a canonical home, and assigns it to T1S01a5.
v1.1 (2026-08-18) Accompanied ledger v1.2.
v1.0 (2026-08-18) Accompanied ledger v1.0.
```
