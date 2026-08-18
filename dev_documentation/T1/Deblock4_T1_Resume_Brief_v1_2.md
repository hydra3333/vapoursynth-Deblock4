# Deblock4 - T1 Resume Brief (Designer Chat 4 / Coder Chat Death, 2026-08-18)

**Deliverable:** T1-RESUME-BRIEF
**Version:** 1.2
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

# 0a. STATE ADVANCE (v1.1) - WHAT IS OWED RIGHT NOW

If you are a new designer chat, THIS SECTION IS YOUR TASK LIST. Everything
below section 0 is still accurate background; this is what changed and what is
outstanding.

## MAINTENANCE RULE FOR THIS SECTION - read before relying on it

```text
BUMP THIS BRIEF WHENEVER A LEDGER SUB-TRANCHE IS ISSUED OR REISSUED.

That is the trigger that was missed once already. v1.1 of this brief was
written, and then within the same session the task register, the review scope,
Project Status and the designer introduction all advanced and a sub-tranche was
reissued - while this map of them sat still. A cold successor would have landed
on a wrong task list.
```

## Which document generation to use

```text
DERIVE IT: for every project document, the HIGHEST COMMITTED VERSION of the
filename prevails. The superseded/ discipline makes that reliable, so this
brief deliberately does NOT pin a version table - a pinned table is what
staled last time and it is the part a successor can work out anyway.

THE EXCEPTIONS, which you CANNOT derive and must read here:

  MPEG-2 authority ....... STILL v1.05, AND DELIBERATELY SO. It has NOT
      moved and NO adjudication has been applied to it. Several ledger
      entries propose version bumps to it; NONE has been made. If you see a
      higher generation, something has been ratified that this brief does not
      know about - stop and ask W3X.

  T1S00_A_Scope_Manifest . whatever the highest version is, its 90-TERM SEARCH
      FRAME IS FROZEN. A frozen frame is not a stale one. Changing it needs a
      W3X decision AND a re-scan of every already-adjudicated step.

  Forward Roadmap and Documentation Currency Audit .. both carry an in-scope
      STALENESS BANNER. The banner is NOT an adjudication and NOT permission
      to skip them during T1 - they are still in the sweep population.

  Session Bootstrap Header .. current, but note it is a CODING-session header.
      Nothing in T1 uses it.
```

## Where T1 actually is

```text
T1S00     manifest .................. COMPLETE, frame frozen
T1S01a1   PR-1 and PR-2 ............. reviewed; both entries REJECTED;
                                      corrections at DEC-24/25/26
T1S01a2   currency statements ....... reviewed, REISSUED at v1.1, accepted
                                      shape
T1S01a3   architecture summary ...... ISSUED, REVIEWED, and REISSUED at v1.1
                                      under the ratified RETAIN-SUMMARY rule.
                                      Eleven of its twelve corrections came
                                      from W3C. The reissue has NOT yet been
                                      reviewed by W3C.
T1S01a4   section 23 steps 6-10 ..... NOT STARTED. THIS IS THE NEXT WORK.
                                      Carries the DEC-32 ordering defect,
                                      which must be DERIVED, not guessed -
                                      see owed item 2
T1S01a5   Appendix E, and the FINAL
          sub-tranche of this doc ... not started; whole-document cross-entry
                                      consistency is checked HERE and nowhere
                                      earlier
T1S01b, T1S02..T1S05 ................ not started
```

## OWED ITEM 1 - DISCHARGED. T1S01a3 was reissued at v1.1.

The corrections below are recorded because they are the SPECIFICATION the
reissue was written against, and because a reviewer of the reissue needs to
know what it was meant to fix. `T1S01a3_B_Coder_Response_v1_0.md` was the
input.

WHAT REMAINS: the reissue itself has not been reviewed. If W3X sends it to
W3C, expect that review before T1S01a3 is treated as closed.

W3C's findings, all accepted by W3X and all now applied:

```text
THE METHOD DEFECT (W3C Q1), and it is the important one.
    LED-013 through LED-019 identify canonical homes OUTSIDE section 0, then
    say in PREVAILS "THIS COPY STAYS as summary". That outcome requires a rule
    W3X has NOT ratified. The ledger proposed the exception at LED-024, said
    it must not be applied retroactively - and had already applied it seven
    times.
    THIS IS DERIVED REASONING LEAKING INTO THE FINDING HALF, which is exactly
    what review scope 5.1 and question Q-F exist to catch. FOURTH INSTANCE of
    the designer's recurring failure. See section 6.

W3C'S COUNTER-PROPOSAL, WHICH IS BETTER THAN W3D's AND SHOULD BE USED:
    Do NOT add a sixth disposition, and do NOT use DESIGNED / INCIDENTAL -
    that axis is wrong, because a stale duplicate can be deliberately designed
    too. What matters is whether the copy has an APPROVED CONTINUING ROLE.
    Use a narrow exception plus an optional field:
        DUPLICATE-ACTION: RETAIN-SUMMARY | POINTER
    with the rule: a non-canonical CURRENT-DUPLICATE copy normally becomes a
    pointer; EXCEPTION - an explicitly designated summary/index/orientation
    layer INSIDE the canonical authority may be RETAINED as a subordinate
    summary when its declared function requires a concise restatement, provided
    the entry identifies the canonical source and the summary introduces no
    unique normative content.
    W3C also observed that T3's actual wording strips duplicates from OTHER
    documents into pointers to the authority - it never instructed anyone to
    hollow out the authority's own summary. W3D overstated that danger.
    RATIFIED AND LANDED at review scope v1.9 section 5.4, in W3C's wording,
    and recorded at task register DEC-36. Every CURRENT-DUPLICATE entry now
    carries DUPLICATE-ACTION: RETAIN-SUMMARY | POINTER.

DISPOSITION CORRECTIONS (W3C Q3):
    LED-020 and LED-021 are NOT CURRENT-UNIQUE. W3D invented a "declare versus
    refer" distinction that is not in the disposition definitions. The coder
    introduction, both blurbs and Project Status all restate the authority
    status and the single-source boundary. Both become CURRENT-DUPLICATE with
    the authority header as canonical home. LED-020 also bundles a second
    proposition - what the v1.05 revision did - whose home is Appendix E; split
    or map it.
    LED-021's SWEPT searched Project Status v1.29 when v1.30 exists, and
    omitted the orientation documents entirely. The search did not earn the
    claim.

CLAIM-COVERAGE CORRECTIONS (W3C Q2) - entries may bundle items, but the CLAIM
must visibly account for EVERY material proposition in a declared item:
    LED-013  item 2 also says the public token spelling is a D4-Q16 decision,
             that `mpeg2_field_separated` is retired in principle, and that
             TFF/BFF is not a grid parameter. Item 5 also states the
             plane-relative chroma vertical-edge consequence.
    LED-015  item 11 also requires the horizontal span descriptor contents -
             plane, x bounds, edge row, edge kind, pitch, parity - and the
             explicit rule that vertical work gains no fake pitch-2/parity
             split.
    LED-019  item 17 continues past processing-order with proper-chroma
             quality, pipeline guidance, side-data interface, the final public
             parameter/property surface, the scalar oracle and the later SIMD
             backends. THIS IS THE WORST OMISSION IN THE TRANCHE: item 17's
             entire purpose is stopping a successor believing open work is
             settled, and W3D truncated the list of open work.
    Canonical homes must be mapped PER PROPOSITION, not as "the register and
    the body sections" generically.

LED-023 -> W3C verdict UNSURE, and W3D agrees. "Nothing in this document rests
    on unverified GAIS testimony" is a blanket claim over 1,983 lines.
    CURRENT-UNIQUE requires the statement to be TRUE, and only a fraction of
    the document has been swept. Do NOT invent a temporary disposition. Carry
    it to T1S01a5 and settle it once the body is swept.

LED-022 is AGREED and needs no change.

TWO CLERICAL ERRORS W3C FOUND: section 1 of the ledger points at "LED-025"
    when the proposition is LED-024; and "ten entries need that field" when
    seven entries are CURRENT-DUPLICATE.
```

## OWED ITEM 2 - THE NEXT WORK: T1S01a4 and the DEC-32 ordering defect

```text
THE DEFECT, which is real and is in the ratified authority itself:
    section 23 step 8 says BUILD the independent ReleaseSafe scalar oracle.
    section 23 step 9 says PERFORM the Schedule-SA/SB quality decision and
        freeze the canonical scalar algorithm.
    BUT authority line 1153 says "The winner becomes part of the future
        Deblock4 scalar oracle."
    So the document specifies building an artifact BEFORE the decision that
    defines one of its constituent properties. The Verification and Tiering
    record independently requires the schedule as an obligation of the
    oracle-construction scope.

A SECOND WARNING IN THE SAME TAIL, from W3C: step 7 says to FREEZE thresholds
    before the later quality-decision step, while the authority's own open-
    items list still has final threshold and strength behaviour UNRESOLVED.

THE REPAIR IS NOT ESTABLISHED AND MUST BE DERIVED, NOT GUESSED. W3C
    deliberately declined to propose swapping steps 8 and 9, because scalar
    candidate implementations may be needed in order to COMPARE schedules in
    the first place. What IS established is narrower: the canonical schedule
    and quality decisions that define the accepted algorithm must be settled
    before the final accepted scalar oracle can serve as the reference for
    later backends.

WHAT THE DERIVATION MUST SWEEP: authority sections 14.4 and 21, Appendix D,
    and Verification and Tiering Decisions section 20.2. Record the sweep in
    the SWEPT field - this is exactly the class of claim that has gone wrong
    four times.
```

## OWED ITEM 2b - routing contradiction: RESOLVED

```text
Task register DEC-32 originally deferred the ordering defect to T1S01a3 while
DEC-35 put it in T1S01a4. Both corrected at register v1.12 and Project Status
v1.31. The route is T1S01a4. No action outstanding.
```

## OWED ITEM 3 - registered earlier, still outstanding

```text
DEC-29  after T3 strips the README, raise the charter proposal removing its
        "controlling specification" status - enumerating all SEVEN charter
        sites and NAMING THE REPLACEMENT OBJECT for I2 and P-09, because
        deleting the status alone leaves two rules operating on nothing.
DEC-32  the authority's own section 23 orders step 8 (build the scalar
        oracle) before step 9 (decide the schedule) - while line 1153 says
        the schedule winner BECOMES PART OF that oracle. The repaired order
        is NOT established and must be derived, not guessed: scalar candidate
        implementations may be needed to compare schedules in the first place.
```

## Suggested order of work

```text
1. Bump this brief whenever a sub-tranche is issued or reissued. See the
   maintenance rule at the top of this section - it was missed once.
2. T1S01a4: derive the section 23 steps 6-10 ordering repair. Sweep the
   sources named in owed item 2 and RECORD THE SWEEP.
3. T1S01a5: Appendix E, and the FINAL sub-tranche of this document - the
   whole-document cross-entry consistency check is due there and nowhere
   earlier. LED-023's deferred blanket provenance claim is settled there too.
4. Then T1S01b (the architecture re-decision record and the GAIS evidence),
   then T1S02-T1S05.
```

## What has NOT happened, so nobody assumes it has

```text
- NO authority document has been edited. Every proposed remedy in every
  ledger is a PROPOSAL awaiting W3X.
- NO code has changed. Identity is still 0.1.0-dev+5C and deblock4.Deblock4
  still has no kernel.
- T5, T6 and the Q14 experiment have NOT started and come after T1.
- The README has NOT been reclassified. Its destination is user-facing, but
  reclassification is sequenced behind T1 and T3 because it is a promise
  about content that has not been swept.
```

---

# 0. READ THIS FIRST IF YOU ARE A SUCCESSOR

```text
The committed files are the truth. This brief is a map to them, not a
substitute. In order:

  AI_Charter_and_Invariants_Card_v1_29           the rulebook, prevails
  Deblock4_MPEG2_..._Decided_Architecture_v1_05  MPEG-2 single source of truth
  Deblock4_Standing_Task_Register_T_Series       work queue + every decision
  T1S00_A_Scope_Manifest                         the FROZEN sweep frame
  Deblock4_T1_W3C_Review_Scope                   what W3C is bound by
  the T1S01a* ledgers and W3C responses issued so far
  (SEE SECTION 0a FOR THE CURRENT VERSION OF EACH)
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

**IT HAS NOW HAPPENED FOUR TIMES**, and a successor should expect to do it too
rather than assume the pattern died with the last designer:

```text
1. claimed a section was the UNIQUE home of a principle
      -> section 13.1 of the SAME document already stated it;
2. claimed two design decisions were INDEPENDENT
      -> the shipped `boundary_strength_offset` moves both;
3. claimed a list's tail was UNAFFECTED by a reordering
      -> line 1153 of the same document contradicts the order;
4. proposed a rule, wrote that it must NOT be applied before ratification,
      and had already applied it seven times in the same document.

The SWEPT field exists because of 1-3. Instance 4 shows the field is not
enough on its own: the failure is asserting a conclusion the evidence in front
of you does not yet support, and it takes a different form each time.
W3C caught all four. That is the system working - but only because W3C reads
the source rather than the ledger.
```

The corrective is not more care. It is that no adjudication should be trusted
because its author was careful, including this one. The three-way process is
not overhead on this project; on the evidence so far it is the only thing that
has caught anything.

---

*Revision history*
```text
v1.2 (2026-08-18) Refreshed after the successor designer found section 0a
     stale - it named four documents at generations that had all advanced
     within the same session, and listed as owed a reissue that had already
     been made. The fix is structural rather than a re-pin: the version TABLE
     is REMOVED in favour of "highest committed version prevails", with only
     the cases a successor cannot derive kept explicitly - chiefly that the
     MPEG-2 authority is deliberately still at v1.05 with no adjudication
     applied, so a higher generation means something was ratified this brief
     does not know about. Added an explicit MAINTENANCE RULE: bump this brief
     whenever a ledger sub-tranche is issued or reissued, which is the trigger
     that was missed. Owed item 1 marked discharged with its specification
     retained; owed item 2 rewritten as the actual next work, the DEC-32
     ordering derivation, with the sources it must sweep named; the routing
     contradiction recorded as resolved. Added a short list of what has NOT
     happened, so nobody assumes an authority edit or a code change occurred.
v1.1 (2026-08-18) Added section 0a: current document generations, where T1
     actually stands, and the three owed items - chiefly the T1S01a3 reissue,
     for which W3C's response is the specification. Recorded W3C's better
     counter-proposal (RETAIN-SUMMARY rather than DESIGNED/INCIDENTAL) and the
     fourth instance of the designer's recurring unchecked-assertion failure.
     Replaced the pinned version numbers in section 0 with pointers to 0a, so
     the read-first list cannot stale again.
v1.0 (2026-08-18) Written immediately on the coder chat reaching its length
     limit mid-review, at W3X's direction, and emitted before any larger
     document refresh - because the previous designer chat died holding an
     undelivered batch of eight documents, and what saved the project then was
     a brief exactly like this one.
```
