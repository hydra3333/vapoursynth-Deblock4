# Deblock4 - W3C Review of Reissued T1S01a3 Architecture-Summary Ledger

**Deliverable:** T1S01a3_B - W3C REVIEW
**Version:** 1.1
**Date:** 2026-08-18
**Author:** W3C
**Route:** W3C -> W3X -> W3D
**Reviews:** `T1S01a3_A_Ledger_Architecture_Summary_v1_2.md`
**Covering note:** `T1S01a3_A_Covering_Note_for_W3C_v1_1.md`
**Current review scope used:** `Deblock4_T1_W3C_Review_Scope_v1_9.md`
**Current task register used:** `Deblock4_Standing_Task_Register_T_Series_v1_12.md`
**Current charter used:** `AI_Charter_and_Invariants_Card_v1_31.md`
**Authority adjudicated:** `Deblock4_MPEG2_Deblocking_Investigation_and_Decided_Architecture_v1_05.md`
**Encoding:** US-ASCII; CRLF.

---

# Plain-English summary

I re-read the corrected closing section of ledger v1.2 against the now-binding
Review Scope v1.9 and Task Register v1.12. I did not needlessly re-review entry
text that the covering note identifies as byte-identical between ledger v1.1
and v1.2.

The important result is that W3D's reading of Question 2 is correct:
`RETAIN-SUMMARY` is the exception for a NON-canonical duplicate inside the
canonical authority. A copy that IS the canonical home does not need that
exception; it simply stays because it is canonical.

That exposes a small inconsistency in Review Scope v1.9: the rule text says the
canonical copy stays, but the `DUPLICATE-ACTION` vocabulary offers only
`RETAIN-SUMMARY | POINTER`. I recommend adding a third action,
`STAY-CANONICAL`.

The seven section-0 entries LED-013 through LED-019 genuinely satisfy the
ratified RETAIN-SUMMARY rule. LED-020 and LED-021 do not rely on that exception.
LED-020 should also be split under the atomic-claim rule because it contains two
propositions with two different canonical homes/actions.

I also spot-checked the carried-over T1S01a2 v1.1 reissue. Its coverage
declaration genuinely discharges the original whole-range coverage blocker.

No source was changed. I performed no build, execution, test, patch, delivery
machinery or git operation.

---

# DECISIONS/QUESTIONS FOR W3X

## Q1. Correct the duplicate-action vocabulary

The binding rule now has three logically distinct cases:

1. this copy IS the canonical home;
2. this copy is NOT canonical but has an approved continuing summary role;
3. this copy is NOT canonical and should reduce to a pointer.

The current action vocabulary exposes only the last two.

I recommend:

```text
DUPLICATE-ACTION:
    STAY-CANONICAL
    RETAIN-SUMMARY
    POINTER
```

with these meanings:

```text
STAY-CANONICAL
    This proposition's copy IS the canonical home.

RETAIN-SUMMARY
    This copy is NOT the canonical home, but it satisfies the narrow
    Review Scope section 5.4 exception: it is inside the canonical authority,
    its summary/index/orientation role is explicitly declared, and it adds no
    unique normative content.

POINTER
    This copy is NOT the canonical home and does not satisfy RETAIN-SUMMARY.
```

This does not add a sixth disposition. It only makes the subsidiary
CURRENT-DUPLICATE action field consistent with the rule already ratified.

Because this is a process criterion applied to W3D's own ledger, W3D was right
not to self-correct it. W3D raised the ambiguity, W3C has independently reviewed
it here, and W3X should decide it.

Refs: Review Scope v1.9 section 5.4; Task Register v1.12 DEC-36; ledger v1.2
Question 2.

## Q2. Split LED-020 under the atomic-claim rule

LED-020 still contains two propositions with different canonical homes:

```text
authority status
    -> canonical home: authority header
    -> CURRENT-DUPLICATE
    -> STAY-CANONICAL

what v1.05 changed
    -> canonical home: Appendix E
    -> CURRENT-DUPLICATE
    -> POINTER from this header copy
```

The ledger already recognises the two different homes and two different
actions. That is evidence that these are two atomic propositions, not one entry.

I recommend splitting LED-020 accordingly rather than retaining one entry with
per-proposition actions.

LED-021 is simpler:

```text
CURRENT-DUPLICATE
canonical home: authority header
DUPLICATE-ACTION: STAY-CANONICAL
```

Refs: Review Scope v1.9 atomic-claim rule; LED-020; LED-021.

## Q3. One small canonical-home refinement in LED-013

LED-013 item 2 now correctly restores all material propositions.

One mapping should be slightly tightened: the statement that
`mpeg2_field_separated` is retired in principle should map explicitly to D4-Q16
as well as the token-spelling question. D4-Q16 is the public-surface redesign
home that says the future interface must not invite SeparateFields input.

I recommend a small mapping-only correction. It does not reopen the
CURRENT-DUPLICATE disposition or the RETAIN-SUMMARY decision.

Refs: LED-013 item 2; D4-Q16.

---

# Focused re-review results

## 1. Coverage declaration - PASS

The a3 coverage defect is discharged.

The reissue now visibly includes the material that v1.0 compressed away:

- LED-013 includes item 2's token deferral, retirement-in-principle and TFF/BFF
  rule, plus item 5's plane-relative chroma consequence.
- LED-015 includes the minimum horizontal span-descriptor fields and the
  no-fake-pitch-2/parity rule for vertical work.
- LED-019 includes the complete twelve-part open-work list rather than stopping
  after processing order.
- Section 23 tail, Appendix E and body material are explicitly assigned to
  named later sub-tranches.

VERDICT: PASS on the coverage question.

Refs: ledger v1.2 coverage declaration; LED-013; LED-015; LED-019.

## 2. RETAIN-SUMMARY - seven genuine uses

I tested the three ratified conditions independently for LED-013 through
LED-019:

```text
1. copy is inside the canonical authority
2. summary function is explicitly declared
3. summary adds no unique normative content
```

All seven pass.

Section 0 is explicitly the read-first architecture summary. The corrected
claims now account for the material qualifiers I previously found missing, and
the propositions trace to formal homes elsewhere in the same authority.

Therefore:

```text
LED-013  RETAIN-SUMMARY  PASS
LED-014  RETAIN-SUMMARY  PASS
LED-015  RETAIN-SUMMARY  PASS
LED-016  RETAIN-SUMMARY  PASS
LED-017  RETAIN-SUMMARY  PASS
LED-018  RETAIN-SUMMARY  PASS
LED-019  RETAIN-SUMMARY  PASS
```

LED-020 and LED-021 do NOT depend on the RETAIN-SUMMARY exception because the
copies being adjudicated are themselves canonical homes.

So the true count of entries relying on the exception is seven, not nine.

Refs: Review Scope v1.9 section 5.4; LED-013..LED-021.

## 3. Per-proposition canonical homes - PASS with one small correction

The new per-proposition mapping is materially better than the v1.0 "cloud of
possible homes" approach.

I found no major wrong home.

In particular, LED-017's separation is sound:

```text
Architecture A rejection decision
    -> section 12

Architecture A proof / derivation
    -> Appendix C

A-specific local false-activation application
    -> section 12.5

general no-implicit-geometry-classifier principle
    -> section 13.1

Architecture C rejection
    -> section 9.4
```

That is the correct distinction between a decision and evidence supporting the
decision.

The only refinement I found is LED-013 item 2, as stated in Q3.

VERDICT: PASS subject to that mapping refinement.

## 4. LED-020 and LED-021 dispositions - PASS

Changing both from CURRENT-UNIQUE to CURRENT-DUPLICATE was correct.

The propositions are repeated in live orientation/status material. Being the
correct canonical home does not make a statement unique.

Therefore:

```text
LED-020 authority-status proposition
    CURRENT-DUPLICATE
    canonical home: authority header
    action: STAY-CANONICAL

LED-021 single-source/scope-boundary proposition
    CURRENT-DUPLICATE
    canonical home: authority header
    action: STAY-CANONICAL
```

LED-020's revision-nature proposition belongs separately in Appendix E and
should be split as described above.

VERDICT: PASS on the disposition change; action labels need the Q1 correction.

## 5. SWEPT fields - PASS

### LED-022

AGREE remains correct.

The seven provenance tags are used elsewhere, but the vocabulary is defined
here. The uniqueness sweep is adequate for the proposition actually claimed.

### LED-021

Marking the earlier SWEPT as inadequate and withdrawing it as a uniqueness
basis is correct. It had used a superseded Project Status generation and omitted
current orientation documents.

### LED-023

The corrected treatment is now right:

```text
NO DISPOSITION YET
defer to T1S01a5
```

The text can be unique while its universal truth remains unproven. The whole
authority must be swept before the claim that nothing rests on unverified GAIS
testimony can be confirmed.

VERDICT: PASS.

## 6. Uniformity of LED-013 through LED-019 - PASS

I independently re-checked representative propositions against their stated
homes, including:

- source-mode / public-interface material;
- vertical-edge geometry;
- B2 span/descriptor material;
- Architecture D;
- Architecture A/C rejection;
- Q14;
- the complete open-work list.

I found no evidence that one blanket judgement was mechanically applied to
seventeen items.

The uniform CURRENT-DUPLICATE result follows from section 0's deliberate
read-first-summary design.

VERDICT: PASS.

---

# Carried-over T1S01a2 v1.1 spot-check

I also checked the reissued `T1S01a2_A_Ledger_Currency_Statements_v1_1.md`
against the specific defect that caused the reissue.

PASS.

The original defect was that the ledger claimed whole ranges had been
adjudicated while only selected statements had ledger entries.

The v1.1 reissue fixes that by:

- narrowing the coverage declaration to the currency/sequencing statements
  actually adjudicated there;
- assigning section 0 architecture material and remaining header material to
  T1S01a3;
- assigning the older Appendix E material to the final sub-tranche;
- accounting separately for the no-filtering prohibition, authority-stability
  statement and section-23 legacy-stage/prerequisite material.

I therefore consider the original a2 whole-range coverage blocker discharged.

I do not recommend reopening a2 solely to retrofit the newer v1.9
DUPLICATE-ACTION formatting. Any old-format duplicate entries can be reconciled
during the final T1S01a5 whole-document consistency pass.

---

# Current W3C position

T1S01a3 is now substantially corrected.

The remaining a3 matters are narrow:

1. ratify/fix the `DUPLICATE-ACTION` vocabulary;
2. relabel LED-020/021 canonical copies accordingly;
3. split LED-020 into atomic propositions;
4. make the small D4-Q16 mapping refinement in LED-013.

None is a reason to hold T1S01a4.

W3C is ready for T1S01a4, which should review section 23 steps 6-10 and the
ordering defect already recorded from the earlier independent review.

---

*Revision history*

```text
v1.1 (2026-08-18) Focused re-review of the reissued T1S01a3 ledger against
     Review Scope v1.9 and Task Register v1.12. Confirms seven genuine
     RETAIN-SUMMARY uses, resolves the LED-020/021 labelling question in favour
     of a distinct STAY-CANONICAL action, recommends splitting LED-020 under the
     atomic-claim rule, records one small D4-Q16 canonical-home refinement, and
     spot-checks the T1S01a2 v1.1 coverage reissue as discharging the original
     whole-range coverage blocker. No source change; no build/test/git.
v1.0 (2026-08-18) First W3C review of T1S01a3 v1.0.
```
