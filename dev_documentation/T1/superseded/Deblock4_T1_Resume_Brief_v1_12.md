# Deblock4 - T1 Resume Brief

**Version:** 1.12
**Date:** 2026-08-19
**Author:** W3D (successor session)
**Route:** W3D -> W3X -> successor W3D / W3C
**Nature:** RECOVERY ARTIFACT. It decides nothing. Section 0a is the live
task-state handoff and PREVAILS over older state summaries in chat blurbs,
introductions and informative status documents where those have not yet been
refreshed.
**Basis:** W3C's `T1S01a5_B_Recovery_Closure_Response_v1_0.md` (review of
ledger v1.6); W3C's `T1S01a5_B_W3C_Knowledge_Capture_Response_v1_0.md` (the
seven-part debrief taken before that session became unavailable); delivered
ledger v1.6; Classification Repair v1.1; W3C's Tier C sample review
`T1S01a5_B_Coder_Response_v1_1.md`; Standing Task Register v1.31.
**Encoding:** US-ASCII; CRLF.

---

# 0a. STATE ADVANCE (v1.12) - WHAT IS OWED RIGHT NOW

## Read this first if you are a successor

```text
YOU ARE PICKING UP A BOUNDED CORRECTION, NOT A FRESH SUB-TRANCHE AND NOT A
RECOVERY. The recovery is over. What remains is a list of specific, named
repairs to one ledger plus four supporting documents.

THE SINGLE MOST IMPORTANT FACT: W3C's review of ledger v1.6 IS THE
SPECIFICATION FOR THE NEXT PIECE OF WORK. Its section 17 lists the required
changes as classes A to G, and its section 18 lists what W3C will check
afterwards. IF YOU READ NOTHING ELSE, READ THAT DOCUMENT. This brief exists to
add what that document does not contain - the ordering, the reasons, and the
traps.

WHAT IS ALREADY SETTLED AND MUST NOT BE REOPENED:
    the Tier C sample                 W3X selected 11; W3C reviewed exactly
                                      those 11; result 3 AGREE / 8 DISAGREE.
                                      DEC-73. DO NOT SELECT ANOTHER SAMPLE.
    the 22-probe a5 search round      settled and independently reproduced.
                                      DO NOT RERUN IT.
    Classification Repair v1.1        substantively settled.
    the a5/a5b split                  ratified at DEC-68.
    DEC-67 search methodology         settled. Do not reopen it.
    the architecture                  not in question here at all.

IF YOU FIND YOURSELF DESIGNING A NEW PROCESS RULE, STOP. W3C's own closing
advice was: do not let a5 recovery become the project. Close a5 on the bounded
corrections; a5b is the next useful test of whether the machinery works.
```

## The work owed, in order, and why this order

```text
THE ORDERING PRINCIPLE IS DO THE UNRECOVERABLE THINGS FIRST. Items 1-3 exist
nowhere else and are needed for a5b and a6 regardless of how a5 ends. Item 4 is
fully specified in W3C's review, so a successor could rebuild it from that
document even with no other context.

1. THIS BRIEF (v1.12)                                        DONE - you are in it
2. Deblock4_T1_W3C_Review_Scope_v1_12.md                     OWED
       Consolidate the method. W3C PROPOSED THIS; W3D drafts; W3C verifies;
       W3X ratifies - the I7 chain runs the right way round because the
       proposer is not the party the criteria judge.
       WHY IT MATTERS MORE THAN IT SOUNDS: the binding review scope no longer
       contains the binding rules. They are spread across Review Scope v1.11,
       the register's DEC-50/51/60/62/63/66/67, and Classification Repair
       v1.1's label definitions. A successor reading only the scope sees
       "Tier C: W3X selects a random sample" as a live instruction. THAT IS
       WHAT HAPPENED. It cost a round.
       MUST CARRY, PROMINENTLY:
           FOR T1S01a5 ONLY: Tier C sampling is COMPLETE.
           11 selected; 3 AGREE / 8 DISAGREE.
           DO NOT SELECT OR REVIEW ANOTHER a5 TIER C SAMPLE.
       ALSO CONSOLIDATES, WITHOUT CHANGING ANY SUBSTANTIVE RULE:
           the two-part entry template and five dispositions;
           the atomic-claim rule - one disposition, one proposition;
           SWEPT: any UNIQUE/INDEPENDENT/UNAFFECTED claim states what was
               actually searched, or it has not been earned;
           DEC-43 STAY-CANONICAL evidence - name a concrete non-canonical copy
               and its location; claim no exhaustiveness without a recorded
               sweep;
           RETAIN-SUMMARY as the narrow declared-summary-layer exception;
           DEC-50 check evidence and DEC-51 partial replacement;
           the populations and the three mechanical exclusions;
           DEC-62 tier derivation from disposition;
           DEC-67's three sweep rules and the bounded probe-family form;
           the classification labels CARRIER / APPLIES / DIFFERENT /
               IDENTIFIER / NOISE / MIXED, plus CANONICAL as the home marker -
               W3C asked that CANONICAL be listed explicitly so nobody wonders
               why the register's condensed list omits it;
           THE ENTRY-SWEEP GATE (new, see the traps below);
           OCCURRENCE-LEVEL EVIDENCE (new, see below).
3. Deblock4_Standing_Task_Register_T_Series_v1_32.md         OWED
       - current status: ledger v1.6 reviewed, corrections owed; retire the
         pre-DEC-73 successor-verification gate in section 0a;
       - annotate DEC-62's "W3X ACTION NOW OWED" Tier C sentence as RESOLVED;
       - record the closure-review outcome as a decision;
       - DEC-64 CAN NOW BIND: its propagation wording was ratified subject to
         W3C verification and W3C has now supplied verified wording (see 0g).
         It must bind BEFORE T3 reaches the rejected Architecture-A material.
4. T1S01a5_A_Ledger_Body_Part1_v1_7.md                       OWED
       W3C's review section 17, classes A to G. Summarised at 0d below.
5. T1S00_A_Scope_Manifest_v1_7.md                            OWED
       CURRENT STATUS paragraph ONLY. Do not touch the frozen frame.
6. Covering note v1.6 and batch v3 to W3C                    OWED
       W3C then delta-reviews per its review section 18.

AFTER THAT: if the delta review is clean, W3X closes a5 and a5b begins.

DEFERRED DELIBERATELY - do not do these now:
    the broad root-continuity refresh (Project Status, Documentation Currency
    Audit, Forward Roadmap, orientation files, Concise Project Summary). They
    still describe the older v1.4 recovery gate. W3C recommends ONE bounded
    pass AFTER a5 closes, so the whole set points at one settled endpoint
    rather than being rewritten twice.
```

## Current T1 state table

```text
T1S00   manifest, frozen search frame          COMPLETE; at v1.6; v1.7 owed
                                               for its CURRENT STATUS line only
T1S01a1 PR-1 / PR-2                            CLOSED by decision, DEC-54
T1S01a2 header + currency                      CLOSED; reissued v1.1
T1S01a3 section 0, seventeen items             CLOSED provisionally
T1S01a4 section 23 tail, steps 6-10            CLOSED provisionally
T1S01a5 sections 1-8, lines 223-715          < LEDGER v1.6 REVIEWED BY W3C.
                                               REISSUE REQUIRED. NOT CLOSED.
T1S01a5b sections 9-13, lines 716-1098         NOT STARTED. Blocked until a5
                                               closes. See 0f for what to
                                               expect - it is harder.
T1S01a6 sections 14-22, 24, Appendices A-D     NOT STARTED
T1S01a7 Appendix E, six owed items,
        whole-document consistency             NOT STARTED; DECLARED FINAL
T1S01b  working record                         NOT STARTED; SCOPES-ONLY, DEC-66
T1S02-05                                       NOT STARTED

LEDGER GENERATIONS - KNOW WHICH IS WHICH:
    v1.3  last W3D artifact delivered before the designer session died.
          THE TEXTUAL BASIS of everything after it. Lineage audited: entry
          text rose monotonically 114,731 -> 117,030 -> 116,968 -> 121,333
          and the only two per-entry shrinks are the recorded atomic splits.
          IT IS A FAITHFUL ACCUMULATION.
    v1.4  W3C emergency reconstruction. RULED OUT AS A SOURCE by W3X, DEC-70.
          Not a gap in the sequence; not to be used.
    v1.5  successor-W3D rebuild on v1.3. Superseded by v1.6.
    v1.6  current delivered ledger. 39 entries. REVIEWED; REISSUE REQUIRED.
    v1.7  owed.
```

---

# 0b. THE POPULATIONS NOW IN FORCE

```text
THREE POPULATIONS EXIST. DO NOT RECONCILE THEM BY REWRITING HISTORY.
    47   frozen T1S00 survey record - what was surveyed on 2026-08-18
    41   current T1 adjudication population, after DEC-66
    46   settled a5 SEARCH snapshot - what a5's SWEPT fields ran over

THE THREE MECHANICAL EXCLUSIONS:
    superseded* / scheduled_for_deletion* folders                     DEC-60
    everything under T1/                                             DEC-63
    everything under GAIS_investigations/                             DEC-66

a5b MUST NOT INHERIT THE 46-FILE SNAPSHOT. W3C was explicit: derive a5b's own
current population. The snapshot is a5's evidence of record and later version
bumps do not retroactively rewrite it, but a search run today would not return
the same 46 files.

DEC-63 CARRIES A STANDING OBLIGATION THAT BITES ON THIS DOCUMENT: T1/ is
excluded from every search, and this brief lives there. Anything durable
written here is invisible to every future sweep unless it is PROMOTED OUT into
a real authority document. This brief is process material and its location is
correct. If you write a substantive finding into it, promote it.
```

---

# 0c. THE TRAPS - EVERY ONE OF THESE HAS ALREADY HAPPENED

```text
THIS SECTION IS THE MOST VALUABLE PART OF THIS BRIEF. Each item below is a real
failure committed in a5 by W3D, W3C or both, and caught by the other party.
None was caught by its own author.

1. THE ENTRY-SWEEP GATE - THE ONE THAT KEEPS RECURRING.
   AFTER EDITING ANY FIELD OF AN ENTRY, RE-READ THE WHOLE ENTRY AND CHECK THAT
   NO OTHER FIELD CONTRADICTS THE EDIT.
   In ledger v1.6 the successor W3D corrected exactly the field each mandate
   named and left the rest of the entry stale, three times:
       LED-055  withdrew the uniqueness claim in REASON; left "the DERIVATION
                -> this section, uniquely" standing in PREVAILS, three lines
                above it.
       LED-061  rebuilt SWEPT to classify the coder introduction and D2 as
                DIFFERENT; left REASON and DUPLICATE-ACTION in the same entry
                still listing both as carriers. THE ENTRY CONTRADICTED ITSELF.
       LED-043  rebuilt the fabrication-prohibition half of SWEPT; left the
                dct_type half naming "the GAIS files" as live corpus, a
                population DEC-66 excludes.
   This is DEC-51 at entry level. It is mechanically checkable: after each
   edit, diff the entry's remaining fields for the terms the edit removed.

2. A COUNT THAT COMES OUT RIGHT CAN HAVE THE WRONG MEMBERS.
   In a5 a false candidate entered while a real carrier escaped the probe, and
   the two cancelled to give the correct total. COMPARE THE LISTS, NOT THE
   TOTALS.

3. OPENING A HIT IS NOT READING IT.
   Every hit was opened as rule 1 requires and seven files were still
   misclassified: a Zig comment about a version string counted as the MPEG-2
   single-source rule; charter I7 counted as the GAIS rule; the substring
   inside the identifier D4-Q01 counted as the edge-position convention.

4. A FILE-LEVEL HIT DOES NOT PROVE OCCURRENCE-LEVEL UNIQUENESS INSIDE THAT
   FILE. The harness returns one file even when the proposition occurs twice
   in it, in sections owned by different sub-tranches. See 0e.

5. ENUMERATE THE ROUNDS, NOT JUST THE DELTAS.
   Ledger v1.5 built its delta list from the classification-repair round alone
   and missed two of W3C's eight Tier C findings, because the Tier C round
   preceded it. The deltas were enumerated meticulously; THE ROUNDS THEY CAME
   FROM WERE NEVER ENUMERATED AT ALL. Worse, v1.5's own provenance section
   NAMED the Tier C review among artifacts used when it had not been opened -
   DEC-48's false assurance, written into the section asserting the provenance
   rule.

6. A CORRECTION CAN SURVIVE ITS OWN FIX. Ledger v1.5's entry count was
   asserted as 40, corrected to 39 by counting - and the stale figure survived
   in the document header two hundred lines away.

7. DO NOT INFER AN UNDELIVERED GENERATION FROM STATUS PROSE. DEC-60, DEC-63
   and W3D's own final post all refer to "39" entries or SWEPT fields in
   ledger generations that were never delivered. No delivered ledger ever had
   39 of anything until v1.6 arrived there by a different route. ENTRY COUNT
   IS NEVER A TARGET.
```

---

# 0d. THE LEDGER v1.7 CORRECTIONS OWED

```text
FULL SPECIFICATION IS W3C's REVIEW SECTION 17. This is the summary.

A. COVERAGE AND RANGES
   - authority line 225 project-scope/target proposition has no entry;
   - authority line 269 "Unless explicitly stated otherwise:" scopes the
     coordinate-convention block and has no entry;
   - LED-060 range is 646-673 and must be 646-674, because its own CLAIM
     includes P4's qualification at line 674;
   - minor stale line pointers: LED-038 refers to line 269 although `e` is at
     272; reconcile LED-040 similarly.

B. THE THREE PARTIAL TIER C REPLACEMENTS - see trap 1 above
   - LED-043: remove the stale GAIS/T1 applicable-population wording; keep the
     Scopes no-fabrication carrier attached to (c2); use the section-3 regime
     table as the named non-canonical copy for (a)/(b);
   - LED-055: remove the false "uniquely" from PREVAILS, and COMPLETE THE
     ATOMIC DECOMPOSITION W3C's original finding required. Three layers:
         duplicated row-projection mechanism (README A.9.3 carries it);
         POSSIBLY UNIQUE derivation qualifiers - progressive/frame-DCT
             generality, and "correctness requirement, not performance
             preference";
         duplicated D4-D01 conclusion.
     Use already-settled candidate material. NO new corpus-search round.
     THE ENTRY COUNT WILL PROBABLY MOVE. Let it.
   - LED-061: remove the coder introduction and D2 from REASON and
     DUPLICATE-ACTION; retain the designer introduction and both chat blurbs;
     keep LED-061a's split assessment.

C. LED-047 TESTED CLAIM
   The entry reports a literal search for "H.262-VERIFIED" returning seven
   lines. It returns EIGHT: line 291 is "[DERIVED FROM H.262-VERIFIED FACTS]".
   Either redefine the population as standalone tags and keep seven, or report
   eight and classify line 291 separately.

D. LED-059
   The entry proposes authority section 15 as canonical home for the
   file-level corpus composition (LG MLS, XP/SP/LP/EP, home_576i, home_576p).
   W3C READ SECTION 15: IT DOES NOT STATE THAT. Remove the duplication claim
   and the section-15 canonical-home pointer; retain section 6.3 as the
   present home unless another is established. THIS IS A REAL ADJUDICATION
   ERROR, not a framing one.

E. LED-063 - TIER A, THE ONLY ONE
   The exact filename in section 24's R8 is genuinely absent, but v1.6
   overstates it as the report possibly not existing. A strong likely referent
   survives under a different filename: the W3C-D4-VERIFY-1 coder-response
   report, "Deblock4 - D4 Pre-Scope - W3C Verification and Independent Design
   Review". Distinguish a WRONG FILENAME from MISSING CONTENT. Remove stale
   GAIS/T1S01b population language. Full Tier-A re-review is owed on this
   entry.

F. RECOVERY SELF-CHECK
   - section 0.1 split status -> RATIFIED at DEC-68;
   - 0.4c completeness claim;
   - 0.4e stale count, after the proposition count settles;
   - 0.4f LED-037 restoration wording, which currently contradicts LED-037's
     own correction;
   - Q-K2's "all eight applied" - only assert it when it is true;
   - covering note diff target and work-queue pointer.

G. CURRENT STATUS RECORDS - items 3 and 5 of the work list at 0a.

EXPLICITLY NOT REQUIRED: no Tier C resampling; no 22-probe rerun; no DEC-67
reopening; no architecture reopening; no source, build, test or git work.
```

---

# 0e. TWO METHOD REFINEMENTS W3C SUPPLIED - ADOPT BEFORE a6

```text
1. OCCURRENCE-LEVEL EVIDENCE, WITHOUT REDEFINING MIXED.
   MIXED MEANS ONE FILE CARRIES MORE THAN ONE MEANING. LED-049 is the clean
   example: Grid Knowledge carries the MediaInfo triage route AND a separate
   evidence-discipline statement.
   LED-053d STRETCHED IT: section 4.5 and Appendix A state the SAME
   proposition at two locations in one physical file. W3C accepted that
   pragmatically to avoid losing the second occurrence and did NOT intend a
   redefinition. DO NOT USE MIXED MERELY BECAUSE A PROPOSITION OCCURS TWICE.
   The fix is occurrence-level evidence where it matters:
       FILE:         <path>
       FILE-CLASS:   CARRIER / APPLIES / DIFFERENT / IDENTIFIER / NOISE / MIXED
       OCCURRENCES:
           <section/range>  CANONICAL occurrence of proposition P
           <section/range>  CARRIER occurrence of proposition P
   THIS MATTERS MOST AT a6, which holds Appendix A, section 24 and the D4
   registers - all of which restate body propositions.

2. CITED-OUTSIDE-RANGE, for evidence in another sub-tranche's territory.
   Q-K asked whether citing Appendix A without adjudicating it is right. W3C
   AGREED IT IS: the carrier may affect the current disposition, and the
   out-of-range occurrence remains for its owning sub-tranche. Adjudicating it
   would violate the tranche boundary. Carry it explicitly:
       CITED-OUTSIDE-RANGE:
           location
           proposition
           evidence use in the current tranche
           owning later tranche
           the later tranche must reconcile the occurrence with this use
   a7's whole-document consistency pass is where these finally reconcile.
```

---

# 0f. WHAT a5b SHOULD EXPECT - FROM W3C, WHO HAS READ SECTIONS 9-13

```text
THIS IS FREE INTELLIGENCE. It was captured from the W3C session before it
became unavailable and exists in no other artifact. It is ADVANCE WARNING, NOT
PRE-DISPOSITION - a5b adjudicates the text, not this list.

a5b IS HARDER THAN a5. Sections 1-8 are evidence; 9-13 transform facts into
architecture, topology, rejection arguments and scheduler/kernel obligations.

HIGH-RISK PATTERNS:
    1. a current principle embedded inside REJECTED architecture;
    2. derived architecture accidentally described as codec fact;
    3. decision reasoning substantially duplicated in Scopes/;
    4. rejected Architecture A described extensively elsewhere, with some
       generic principles potentially SURVIVING its rejection;
    5. PR-1/PR-2 home and pointer remedies needing faithful home adjudication
       WITHOUT reopening settled decisions;
    6. same-file duplication across section 0, body, registers and appendices.

SPECIFIC WARNINGS:
    B2-primary / D-mandatory-comparator is repeated widely;
    section-10 B2 topology mathematics has Scopes ancestry - do not presume
        uniqueness;
    Architecture D's high-level role and its detailed topology may have
        DIFFERENT canonical homes;
    the Architecture A rejection proof will likely need the most Tier-A atomic
        splitting in the whole sub-tranche;
    scheduler/kernel separation is likely duplicated but is an APPLICATION of
        the four-layer taxonomy, not a copy of it;
    old Schedule A/B vocabulary must not be confused with assertion of the
        renaming rule.

EXPECT MORE TIER A THAN a5, because the architecture half deliberately
contains rejected and superseded material. Expect few or no Tier B: Deblock4
still has no filtering kernel, and scaffolding does not make an architecture
statement an OPERATIVE-SPEC.

METHOD FOR a5b:
    derive a5b's own population; do not inherit a5's 46;
    bounded proposition probes FROM THE BEGINNING;
    exact coverage map BEFORE adjudication, not after;
    open and understand every candidate;
    record intra-file occurrence locations when material;
    atomicise rejected and surviving clauses;
    apply DEC-51 after every correction;
    W3D NEVER chooses the Tier C sample;
    no target entry count;
    carry out-of-range evidence to the owning tranche;
    preserve prior reasoning losslessly unless evidence mandates a change.
```

---

# 0g. DEC-64 CAN NOW BIND - W3C-VERIFIED PROPAGATION WORDING

```text
DEC-64 was ratified SUBJECT TO W3C wording verification and has not been
binding. W3C has now supplied verified wording. W3D must put the exact binding
text through W3X. IT MUST BIND BEFORE T3 REACHES THE REJECTED ARCHITECTURE-A
MATERIAL, which is the first real ERRONEOUS case and where getting it wrong
costs most.

    SUPERSEDED-KIND    OVERTAKEN | ERRONEOUS

    OVERTAKEN   valid in its former context/state and replaced by a later
                statement. PROPAGATION normally N/A unless evidence suggests
                dependent work may not remain valid.

    ERRONEOUS   false, materially misleading, or otherwise invalid in the
                context in which project work may have relied on it.

    PROPAGATION - REQUIRED FOR ERRONEOUS
        1. DECLARE THE PROPAGATION SCOPE/POPULATION: the bounded set of
           current documents, decisions, code, mathematics, tests or other
           objects in which reliance could materially survive.
        2. SEARCH FOR RELIANCE ON THE PROPOSITION, NOT MERELY ITS WORDING.
        3. ENUMERATE AND CLASSIFY CANDIDATE DEPENDENCIES, identifying actual
           reliance and non-reliance with attackable location/basis.
        4. ROUTE EACH ACTUAL DEPENDENCY: valid for an independent reason;
           needs correction/re-verification; or is itself superseded/erroneous.
        5. If none are found, record "none found" with scope and method.
        6. Claim no exhaustiveness beyond the declared scope/method.

    PROPAGATION IS ABOUT POTENTIALLY AFFECTED CURRENT WORK. It is NOT an
    archaeological search for every historical mention.
```

---

# 0h. THE PROVENANCE RULE AND WHAT IT COSTS

```text
RECORDED BECAUSE A SUCCESSOR WILL MEET THE SAME TENSION AND SHOULD KNOW THE
ANSWER WAS ALREADY WEIGHED.

THE RULE (DEC-70): every change to the ledger traces to a delivered artifact
or a ratified decision. Anything the designer adds on its own judgement is
labelled a NEW W3D FINDING with its evidence, never presented as a mandate.

WHAT IT COST, EXACTLY ONCE, AND IT IS WORTH KNOWING: ledger v1.4 contained
LED-055a, in which W3C had DELIBERATELY isolated the possibly-unique
SeparateFields qualifiers from the duplicated mechanism and conclusion. The
rebuild deleted it as unmandated. W3C's later debrief calls it "the most
important original v1.4 analysis that the later rebuild did not preserve
correctly."

THE RULE WAS NOT CHANGED, AND SHOULD NOT BE. Two reasons:
    the finding CAME BACK anyway through the ordinary review - the closure
        review reached the same conclusion independently, so the cost was one
        round, not a lost finding;
    the alternative - a designer adopting unmandated material from a
        ruled-out document on judgement - is how the original mess happened.
W3C's own position: it would defend the NEED for atomic LED-055 qualifier
treatment, not the identifier or wording. That need is now in the v1.7 work
list at 0d(B) on its own evidence.
```

---

# 0i. WHAT W3C's FINAL SESSION LEFT, AND WHAT IT DID NOT

```text
THE W3C SESSION THAT WORKED ALL OF a5 IS EFFECTIVELY UNAVAILABLE - response
times of tens of minutes, and it will need re-orientation. TREAT THE NEXT W3C
AS A FRESH MEMORYLESS SESSION (charter I2). It gets the bootstrap header, the
charter, the specification, one scope and the files it touches. IT WILL NOT
REMEMBER a5.

DELIVERED AND SAFE - four documents carrying everything W3C concluded:
    T1S01a5_B_Coder_Response_v1_1.md              the Tier C sample review
    T1S01a5_B_ReSweep_CrossCheck_Response_v1_0.md the cross-check
    T1S01a5_B_Classification_Repair_Response_v1_0 the repair review
    T1S01a5_B_Recovery_Closure_Response_v1_0.md   the v1.6 review - THIS IS
                                                  THE SPEC FOR v1.7
    T1S01a5_B_W3C_Knowledge_Capture_Response_v1_0 the seven-part debrief

THE DEBRIEF IS EVIDENCE, NOT KNOWLEDGE. Its durable content has been promoted
into this brief at 0c, 0e, 0f, 0g and 0h, and belongs in Review Scope v1.12
and the register. Left only in T1/ it would be invisible to every sweep.

W3C REPORTED NO WITHHELD TECHNICAL OBJECTION: no undisclosed conclusion that
B2 or D is non-viable, and no hidden objection to F8, the row mathematics or
the 4:2:0 asymmetry. Where provenance was weak - F8 especially - it said so
openly. ITS CLOSING ASSESSMENT: the present difficulty is continuity and
adjudication reliability, NOT evidence that the Deblock4 algorithm cannot be
built.
```

---

# 1. PROJECT POSITION - UNCHANGED BY THE a5 PROCESS CORRECTIONS

```text
CLASSIC:
    complete for the ratified integer tiers:
        2C scalar oracle
        4C SSE4.1
        5C AVX2
        post-5C M1/M2 maintenance
    retained identity: 0.1.0-dev+5C unless W3X supplies a later base.

deblock4.Deblock4:
    NO FILTERING KERNEL.
    Live dispatch remains pass-through writable-copy infrastructure.

MPEG-2 ARCHITECTURE:
    B2 primary candidate;
    D mandatory detector-free comparator/fallback;
    A and C rejected;
    Q14 rule:
        B2 if viable;
        otherwise D if viable;
        otherwise reopen architecture.
    Nothing ships at Q14.

NO KERNEL SCOPE:
    no Deblock4 kernel scope may be drafted before Q14 reports and W3X
    ratifies the architecture allowed to enter kernel/oracle development.

CURRENT WORK:
    T1 documentation consolidation remains active.

DOWNSTREAM:
    T8 must close named provenance gaps before T5.
    T5 detector mathematics then precedes separately-ratified T6/Q14 planning.

TARGET-MATERIAL FACT:
    LG XP/SP/LP/EP measured frame_pred_frame_dct=0.
    This establishes adaptive-capable per-macroblock DCT operation as normal
    target-device operation.
    It does NOT establish that any particular picture actually contains both
    FRAME and FIELD dct_type macroblocks; Q14 must obtain per-macroblock truth.
```

---

# 2. SUCCESSOR DISCIPLINE

```text
1. Do not treat T1/ as project knowledge merely because it contains a statement.
2. Do not use GAIS_investigations/ to prove, refute or adjudicate a current
   proposition.
3. Do not restart the settled a5 search round.
4. Do not trust a hit count as a carrier count.
5. Do not trust an "opened" file as a correctly read file.
6. Do not infer an undelivered ledger generation from status prose.
7. Every W3D remedy remains a proposal until W3X ratifies the resulting change
   to the applicable project knowledge set.
8. Preserve W3C's independent-review role; do not use it as confirmation.
9. Keep the immediate work bounded. a5 needs the bounded corrections at 0d,
   NOT a new process framework. W3C's closing advice: do not let a5 recovery
   become the project.
10. After editing any field of an entry, RE-READ THE WHOLE ENTRY. A correction
    reported complete from the edited location is the failure that has recurred
    most. See 0c trap 1.
11. Enumerate the ROUNDS an instruction came from, not only the deltas. Two
    rounds fed a5 and building from one missed two findings. See 0c trap 5.
12. Never claim a document was used unless it was opened.
```

---

# 3. HOW THIS BRIEF CAME TO BE

v1.11 existed because the W3D designer session reached its context limit after
delivering Classification Repair v1.1 but before delivering the promised ledger
rewrite. W3C wrote it as a recovery reconstruction.

v1.12 is written by the successor W3D session after that recovery completed, and
its purpose is different: it is a HANDOVER ARTIFACT WRITTEN WHILE THE DESIGNER
IS STILL AVAILABLE, rather than a reconstruction attempted after one is gone.
Both a designer and a coder session have now been lost mid-task on this
sub-tranche. This brief assumes a third loss is likely and is written to make it
survivable.

IT SEPARATES, DELIBERATELY:

```text
DELIVERED ARTIFACTS
    from
CAPTURED REASONING, which is evidence and not knowledge
    from
OLDER CONTINUITY SUMMARIES, several of which are still a generation behind.
```

WHAT IT DOES NOT DO. It decides nothing. It promotes nothing inside `T1/` into
applicable project knowledge - the durable content at 0c to 0h must reach Review
Scope v1.12 and the register to count. It manufactures no ledger generation that
was not physically delivered. And it does not restate the technical adjudication
of sections 1-8, which is in the ledger and has survived every review round
without a single MPEG-2 conclusion being overturned.

A NOTE ON WHERE THE COST HAS ACTUALLY GONE, because a successor should not
misread five rounds as technical difficulty. DEC-52 recorded it for a4: "The
TECHNICAL result was substantially right at v1.0 and survived every round.
Rounds two, three and four were spent on W3D's own method and framing defects."
a5 repeated it. The classification content held throughout; the rounds went on
method, framing, provenance and recovery. Review Scope v1.12 and the entry-sweep
gate exist to make a5b cost less, and a5b is the test of whether they work.

---

*Revision history*

```text
v1.12 (2026-08-19) SUCCESSOR-W3D HANDOVER REWRITE, written while the designer
      session is still available rather than reconstructed after a loss.
      Advances the state past W3C's recovery-closure review of ledger v1.6:
      records that the reissue is REQUIRED and a5 is NOT closed, and carries
      W3C's section-17 A-G correction list at 0d as the specification for
      ledger v1.7. Sets the work order at 0a on the principle DO THE
      UNRECOVERABLE THINGS FIRST - this brief, then Review Scope v1.12, then
      register v1.32, then the ledger, because the ledger corrections are fully
      specified in W3C's review and the rest exist nowhere.
      PROMOTES THE DURABLE CONTENT OF W3C's SEVEN-PART KNOWLEDGE CAPTURE, taken
      before that session became unavailable: the traps at 0c, the
      occurrence-level evidence and CITED-OUTSIDE-RANGE refinements at 0e, the
      a5b advance warnings at 0f, DEC-64's now-verified propagation wording at
      0g, and at 0h the one recorded cost of the DEC-70 provenance rule.
      Records that the Tier C sample is COMPLETE and must not be reopened -
      the stale generic instruction in Review Scope v1.11 caused a successor to
      believe it was still owed.
      Adds successor-discipline items 10 to 12, including the ENTRY-SWEEP GATE.
      Notes that the long-lived W3C session is effectively unavailable and the
      next W3C must be treated as fresh and memoryless.
v1.11 (2026-08-19) W3C reconstruction after W3D designer-chat session limit.
      Advances the live state past Classification Repair v1.1: confirms the
      three mechanical v1.0 review defects are visibly repaired and sets the
      next act to the T1S01a5 ledger rewrite. Records DEC-68 split ratification,
      DEC-66's 41-document adjudication population / GAIS ignore rule, DEC-67
      sweep rules, DEC-69's later T1S00 delivery-only bump, the six a5
      disposition-structure changes, eight rebuilt carrier lists, four changed
      findings, and the corrected 28-of-34 figure. Removes the stale
      "classification repair next", "split not ratified" and 24-of-34 state.
      Explicitly records that the supplied live T1 tree contains ledger v1.3,
      not the working v1.5/v1.6 generations mentioned in older continuity prose,
      so no undelivered generation is invented.
v1.10 (2026-08-19) Last W3D-authored resume brief before the designer session
      ended; state stopped immediately before Classification Repair v1.1.
```

---

*End of resume brief. Nothing here is ratified by this document.*
