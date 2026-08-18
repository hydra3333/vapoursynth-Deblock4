# Deblock4 - T1 Resume Brief (Designer Chat 4 / Coder Chat Death, 2026-08-18)

**Deliverable:** T1-RESUME-BRIEF
**Version:** 1.0
**Date:** 2026-08-18
**Author:** W3D (designer chat 4)
**Route:** W3D -> W3X -> successor W3D and successor W3C
**Purpose:** RECOVERY. The coder chat hit its length limit mid-review. This
brief exists so that a new designer chat, a new coder chat, or both, can
resume T1 without reconstructing anything from conversation.
**Status:** INFORMATIVE RECOVERY RECORD. It decides nothing. The charter
prevails, then the ratified MPEG-2 authority, then the task register.
**Encoding:** US-ASCII; CRLF.

---

# 0. READ THIS FIRST IF YOU ARE A SUCCESSOR

```text
The committed files are the truth. This brief is a map to them, not a
substitute. In order:

  AI_Charter_and_Invariants_Card_v1_29           the rulebook, prevails
  Deblock4_MPEG2_..._Decided_Architecture_v1_05  MPEG-2 single source of truth
  Deblock4_Standing_Task_Register_T_Series_v1_6  work queue + every decision
  T1S00_A_Scope_Manifest_v1_3                    the FROZEN sweep frame
  Deblock4_T1_W3C_Review_Scope_v1_5              what W3C is bound by
  T1S01a1_A_Ledger_PR1_PR2_v1_0                  the only ledger issued so far
  T1_Evidence_Old_Designer_..._files.zip         previous designer's handover

The task register's DECISION LOG (section 1) carries DEC-01 to DEC-22 with a
plain-English REASON for each. Read it before doing anything. It is the single
densest recovery artifact in the project.
```

---

# 1. Where T1 actually is

```text
T1S00   scope manifest        COMPLETE. v1.3, three W3C review rounds, frame
                              frozen at 90 terms / 47 documents.
T1S01a1 ledger tranche 1      ISSUED, REVIEWED, AND BOTH ENTRIES REJECTED BY
                              W3C. See section 2 - this is the live item.
T1S01a2 rest of the authority NOT STARTED. Deliberately held pending the
                              tranche-1 method finding.
T1S01b  Scopes/ + GAIS record NOT STARTED.
T1S02-3 README parts 1 and 2  NOT STARTED.
T1S04   charter, D0, D2       NOT STARTED.
T1S05   remaining 30 docs     NOT STARTED.
```

**Nothing has been ratified into any authority document. No authority document
has been edited. The sweep has produced two proposed adjudications, both of
which W3C rejected as written.**

---

# 2. THE LIVE ITEM: W3C rejected both tranche-1 entries, and W3C is right

The coder chat died immediately after posting its verdicts. The verdicts
themselves arrived and are recorded here in case the coder's response file is
lost with the chat.

## 2.1 W3C's method finding - ACCEPT, fix before T1S01a2

```text
W3C: the ledger entries mix TWO DIFFERENT ACTS - the disposition of an
existing quoted statement, and a newly derived general proposition. Keep
DISPOSITION strictly to the five registered values; add a SEPARATE field for
derived propositions.

W3C's reason, which is the important part: "otherwise future entries can make
a statement 'current in substance' by inventing the substance they wish it
had."

W3D ASSESSMENT: correct, and it is the single most valuable thing found so
far. LED-002 invented a sixth disposition ("SUPERSEDED-IN-FORM, CURRENT-IN-
SUBSTANCE") which assumed its own conclusion. The template must be fixed
before any further tranche.
```

## 2.2 PR-1 - W3D overreached; W3C's narrower core is right

```text
W3D CLAIMED: the false-activation limit is universal; 12.5 is CURRENT-UNIQUE
but misfiled inside the Architecture A rejection proof; proposed relocating it
as a general constraint, with an A/B2/D severity gradation.

W3C COUNTERED: the sound core is only "if two different physical causes
produce identical values for every input available to a decision rule, that
rule cannot distinguish the causes" - i.e. a local artifact predicate must not
be used as an implicit geometry classifier. It does NOT prove every future
kernel uses only those six samples, nor that this is "the reason the detector
exists at all".

DECISIVE EVIDENCE, VERIFIED COLD BY W3D AGAINST THE SOURCE:
    Authority section 13.1 ALREADY STATES THE GENERAL PRINCIPLE:
        "Do not let a local edge predicate become an implicit geometry
         classifier."
    It is already outside the rejection proof, already load-bearing, already
    listed among rules retained because they are "still exactly right".
    Sections 11 and 15.3 already record Architecture D's exposure at its
    uncertain internal candidate.

THEREFORE the CURRENT-UNIQUE disposition is WRONG. What section 12.5 uniquely
holds is the PROOF/construction, not the principle. The principle has a home.

W3D ERROR, RECORDED PLAINLY: W3D adjudicated a statement as unique without
sweeping the same document for whether the principle already lived elsewhere.
That is precisely the T1 failure mode - the one this entire task exists to
correct - committed by the designer, inside T1, in the first ledger issued.
It was caught only because an independent party read the source.

LIKELY CORRECT REMEDY (for the successor to re-derive, not inherit): the
proof at 12.5 stays where it is as the Architecture A application; a pointer
from 13.1 to 12.5 makes the proof findable from the principle. This is much
smaller than the relocation W3D proposed.
```

## 2.3 PR-2 - W3D's argument refuted by the project's own specification

```text
W3D CLAIMED: the tc0-unscaled rule ("tighten the evidence bar, but correct at
full strength once it passes") is a standing kernel principle, because the two
decisions are structurally independent.

W3C COUNTERED: the source proves only that rejected Architecture A scaled
alpha/beta and left tc0 unscaled. It does not prove a universal rule. "Full
strength" is also imprecise - unscaled tc0 means the normal correction law
remains AVAILABLE, not that maximum correction is always applied.

DECISIVE EVIDENCE, VERIFIED COLD BY W3D AGAINST THE SOURCE:
    README v1.12 line 692 - the shipped, ratified parameter
    `boundary_strength_offset` "offsets the index used for `alpha` and `tc0`".
    One parameter moves the evidence threshold AND the correction limit
    together. The project has therefore NEVER treated evidence and correction
    strength as logically independent.

THEREFORE W3D's independence argument is refuted by the project's own live
specification, which W3D did not check before asserting it.

W3C's PROPOSED DISPOSITION: do not ratify as a standing rule; preserve A's
behaviour as history; record the coupling question as an OPEN kernel/quality
decision under D4-Q02/D4-Q05. W3D assesses this as correct.
```

## 2.4 What this means for T5

```text
PR-1 was registered as BLOCKING T5. It is now substantially resolved: the
principle that constrains the detector already exists at authority 13.1 and
did not need to be derived. T5 is therefore closer to unblocked than the
register currently says - but the successor must confirm that with W3X rather
than assume it, and the ledger template must be fixed first.
```

---

# 3. What is OWED, in priority order

```text
1. LEDGER TEMPLATE FIX before T1S01a2. Five registered dispositions only,
   plus a separate DERIVED-PROPOSITION field. Update the review scope and the
   task register together.
2. TASK REGISTER v1.7 recording: W3C's method finding; the corrected PR-1 and
   PR-2 positions; W3D's two errors; the T5 status change.
3. T1S01a1 RE-ISSUE OR SUPERSESSION. W3C said the tranche is reviewable as-is
   and should NOT be discarded. W3X to decide whether it is re-issued
   corrected or left standing with the corrections recorded against it.
4. RECOVERY DOCUMENT REFRESH (W3X requested, in progress when this brief was
   written): designer intro, coder intro, both chat blurbs, Project Status.
   None had been updated for T1 when the coder chat died.
5. THEN T1S01a2 and onwards.
```

---

# 4. Method and naming, so a successor does not re-derive it

```text
POPULATION vs SEARCH: the document population is a RECURSIVE INVENTORY minus
    explicit recorded exclusions. The term set searches that population; it
    does NOT build it. (DEC-17. This is the structural fix for PR-5.)
TERM FRAME: 90 terms, groups 1-12, FROZEN. Any addition needs a W3X decision
    AND a re-scan of everything already adjudicated. (DEC-21.)
POPULATION: 47 documents. Explicitly excluded: T1's own process artifacts
    (audited at closure instead), the evidence zip, the pinned third-party
    HolyWu source. (DEC-19, manifest 2.0a-2.0c.)
FIVE DISPOSITIONS: CURRENT-UNIQUE, CURRENT-DUPLICATE, CONFLICTING,
    SUPERSEDED, OPERATIVE-SPEC. No others. Ever.
TIERS: A = all CONFLICTING, all SUPERSEDED, all pre-registered items.
    B = OPERATIVE-SPEC. C = the rest, W3X-sampled at random.
REVIEW MODEL: W3C reviews each tranche; W3X does NOT adjudicate between
    tranches except for the first ledger-bearing response and any METHOD
    finding; full reconciliation happens at closure. (DEC-12.)
NAMING: T1Snn[a|b][tranche]_A_ to the coder, _B_ back.
    Issued so far: T1S00_A, T1S00_B, T1S01a1_A, T1S01a1_B.
    Next: T1S01a2_A.
SUPPLY: complete dev_documentation zip AND src zip at the start of every
    coder chat, re-supplied when the chat is replaced. Each tranche then
    carries only its ledger plus any bumped register. (DEC-14.)
```

---

# 5. Standing facts a successor must not re-litigate

```text
- Classic is complete for the ratified integer tiers at 0.1.0-dev+5C.
- deblock4.Deblock4 has NO filtering kernel. All three dispatch arms are
  pass-through copies. Verified cold in the supplied source.
- B2 is the ADOPTED PRIMARY CANDIDATE; D is the mandatory detector-free
  comparator and fallback which must meet its OWN viability bar. NEITHER has
  passed Q14. Architectures A and C are rejected; B is superseded by B2.
- No kernel scope and no NEW kernel mathematics before Q14 reports and W3X
  ratifies. T1 MAY adjudicate kernel principles that already exist.
- The target LG recorder was measured with frame_pred_frame_dct=0 in
  XP/SP/LP/EP, so the adaptive per-macroblock DCT regime is normal target
  operation. This does NOT prove any given picture mixes FRAME and FIELD
  macroblocks; Q14 must obtain per-macroblock truth.
- 4:2:0 Case-(a) chroma is frame-organised by H.262; 4:2:2/4:4:4 chroma
  follows luma organisation.
- The previous survey searched the dev_documentation ROOT only, missing the
  Scopes/ architecture re-decision record and GAIS_investigations/ - twelve
  live documents, 3,758 lines (PR-5). They are now in scope at T1S01b.
```

---

# 6. The lesson this brief exists to transmit

The recorded incident that caused T1 was a designer skipping a document
because an index called it "fallback general guidance" - a classification
believed instead of checked.

**In the first ledger produced by T1 itself, the designer repeated it**: an
entry claimed a statement was the unique home of a principle without checking
whether the same document already housed that principle three sections later.
It did. An independent reviewer found it in one pass.

The corrective is not more care. It is that no adjudication should be trusted
because its author was careful, including this one. The three-way process is
not overhead on this project; on the evidence so far it is the only thing that
has caught anything.

---

*Revision history*
```text
v1.0 (2026-08-18) Written immediately on the coder chat reaching its length
     limit mid-review, at W3X's direction, and emitted before any larger
     document refresh - because the previous designer chat died holding an
     undelivered batch of eight documents, and what saved the project then was
     a brief exactly like this one.
```
