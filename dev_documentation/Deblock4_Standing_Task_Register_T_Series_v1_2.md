# Deblock4 - Standing Task Register (T-Series) for the MPEG-2 / Deblock4 Arc

**Version:** 1.2
**Date:** 2026-08-17
**Author:** W3D (v1.0); W3C v1.1 reconciliation; W3D v1.2 sequencing and method
**Status:** W3X-RATIFIED. This is the authoritative list of outstanding process
and design tasks for the Deblock4 MPEG-2 arc. (v1.1 was issued as a
"ratification candidate"; W3X confirmed ratification on 2026-08-17 and the
status line is corrected here.) It exists because the T-series was previously
carried only in conversation and in condensed form inside Project Status
section 0, which does not survive a session boundary well.
**Relationship to other documents:** the ARCHITECTURE authority is
Deblock4_MPEG2_Deblocking_Investigation_and_Decided_Architecture_v1_05
(or later; read its section 0 first). THIS document holds the WORK QUEUE, not
the decisions. Where the two touch, the authority document prevails.
**Maintenance rule:** when a task completes, mark it DONE with the date and
the artifact that discharged it - do not delete it.
**Encoding:** US-ASCII; CRLF.

---

# 0. Status at a glance

```text
  T1        Formal consolidation sweep ......... ACTIVE - NOW FIRST IN SEQUENCE
  T1.1      Mathematical inventory/gap table ... NEW; runs inside T1, reports
                                                 after it
  T2        Retire the Grid Knowledge document . BLOCKED by T1
  T3        De-duplicate into references ....... BLOCKED by T1
  T4        Boundary-set mathematics ........... SUBSUMED into T1.1-MATHS;
                                                 no longer closed "by absorption"
  T5        Detector mathematics ............... AFTER T1 (order reversed by
                                                 W3X 2026-08-17)
  T6        D4-Q14 experiment plan ............. AFTER T5, as a separate
                                                 ratification (not one package)
  T7        Final consolidation commit ......... BLOCKED by T1-T6

  HARD RULE, independent of this queue: NO DEBLOCK4 KERNEL SCOPE MAY BE
  DRAFTED until the D4-Q14 architecture-discriminator experiment reports and
  W3X ratifies the architecture allowed to enter kernel/oracle development.

  CURRENT RESUME ORDER FOR A NEW W3D:
      Project Status v1.28 section 0
      -> MPEG-2 authority v1.05 section 0
      -> this task register (READ SECTION 1: DECISION LOG)
      -> the T1 adjudication ledger as far as it has been delivered
      -> resume T1 at the first unadjudicated document in the scope manifest
```

---

# 1. DECISION LOG - decisions taken 2026-08-17, with the reason for each

Recorded here rather than only in conversation, because a chat death loses
conversation and this arc has already lost two designer sessions. Each entry
states what was decided and WHY, so a successor inherits the reasoning and not
just the instruction.

```text
DEC-01  The task register is RATIFIED (status line corrected).
        WHY: it is the only document sequencing designer work; taking work
        direction from a document marked "candidate" left the sequence resting
        on conversation rather than a ratified record.
        (W3X, 2026-08-17)

DEC-02  T1 RUNS BEFORE T5. The earlier T5-first sequence is reversed.
        WHY: T5 derives detector features, scoring, confidence and the UNKNOWN
        threshold. The README already proved it can contain a fully-worked,
        previously ratified threshold and activation apparatus that nobody
        swept. If the sweep surfaces ratified detector-relevant material AFTER
        T5 is ratified, T5 is re-litigated with T6 built on top of it, and
        Q14's integrity depends on T5 being frozen and STAYING frozen. T1 costs
        time now; the alternative costs T5, T6 and possibly a Q14 re-run. The
        original reason for pausing T1 - not consolidating into a moving target
        - expired when the architecture re-decision settled.
        (W3X, 2026-08-17)

DEC-03  T5 is issued and ratified ALONE, then T6 separately. The permitted
        single coordinated T5+T6 package is NOT used.
        WHY: it makes "the detector mathematics were fixed before anyone saw
        held-out results" a matter of record rather than of internal document
        structure, and gives W3C a cleanly bounded artifact to cross-check.
        (W3X, 2026-08-17)

DEC-04  Forward Roadmap and Documentation Currency Audit currency is FOLDED
        INTO T1/T3 rather than fixed as a separate pass.
        WHY: T1/T3 will rewrite those passages properly; fixing them first is
        double work and would force pre-deciding adjudications that are T1's
        job.
        (W3X, 2026-08-17)

DEC-05  BANNERS: the Forward Roadmap v1.20 and the Documentation Currency Audit
        v1.4 receive an in-scope staleness banner NOW. The README and the Grid
        Knowledge document DO NOT, until adjudicated.
        WHY: a "superseded - do not rely on" banner placed BEFORE adjudication
        is a pre-judgement whose practical effect is permission to skip - the
        Architecture A mechanism relocated, not removed. The roadmap and audit
        are informative orientation with no unique ratified design to lose, so
        the risk is one-sided. The README and Grid Knowledge are the opposite:
        their danger is that they may still hold good, current, possibly-unique
        material, which is exactly what a premature label would bury. Their
        banners are written AFTER adjudication, reporting a disposition backed
        by a ledger entry. W3X identified this risk; W3D's original
        banner-all-four recommendation was withdrawn.
        (W3X, 2026-08-17)

DEC-06  PROTECTION DURING T1 COMES FROM THE SCOPE MANIFEST, NOT FROM LABELS.
        The first T1 artifact is a published manifest naming every in-scope
        document as UNADJUDICATED.
        WHY: a list of what MUST be read is safe; a label saying what MAY be
        skipped is the failure mode itself.
        (W3D recommendation, W3X accepted 2026-08-17)

DEC-07  README DESTINATION: it becomes a USER-FACING product document - what
        the filter does, the parameters, how to use it, a readable summary of
        how it works. It holds no controlling information and is an authority in
        no domain.
        WHY (W3X): it was an initial-phase document; controlling information
        should reside elsewhere. This also permanently removes the "ratified
        design hiding under a general-guidance label" condition.
        SEQUENCING CONSTRAINT (load-bearing): it CANNOT be reclassified yet.
        Reclassification is a promise about content, and the content has not
        been checked. Order is: T1 adjudicates every hit -> unique/current
        material is rehomed -> T3 strips the remainder -> ONLY THEN the
        classification changes to USER-FACING.
        INTERIM CLASSIFICATION: "unadjudicated - contains ratified design
        pending T1; not an authority, not yet user-facing." Deliberately grants
        no skip permission.
        (W3X, 2026-08-17)

DEC-08  T4 is NOT closed by absorption. It is subsumed into T1.1-MATHS, which
        produces an explicit gap table.
        WHY: "largely absorbed, confirm during T1" is an inference, and a gap
        discovered during T5 or the kernel scope is discovered at the worst
        possible time.
        (W3X, 2026-08-17)

DEC-09  SOURCE TREE: quick INVENTORY ONLY, no adjudication, no proposed edits.
        The inventory is handed to D4-Q16 as input.
        WHY: leaving source wholly out of scope would let T1 declare a clean
        single source of truth while the codebase still speaks the rejected
        architecture; full adjudication would sprawl T1 into a bounded coding
        scope that belongs to a different party. The inventory is already
        performed and recorded in section T1-SRC below.
        (W3X, 2026-08-17)

DEC-10  T1 IS DELIVERED INCREMENTALLY: the adjudication ledger is emitted and
        PRESENTED in batches as each document is adjudicated, not held to the
        end.
        WHY: two designer sessions have died mid-task and one died holding an
        unpresented batch. Incremental delivery caps the loss at one document's
        work. Only emitted artifacts survive an interruption (charter
        C-DELIV-09); un-emitted reasoning does not.
        (W3D recommendation, W3X accepted 2026-08-17 - noted as established
        practice with both designer and coder previously)
```

## 1.1 Registered follow-up, not yet drafted

```text
CHARTER PROPOSAL (W3D to draft; charter I7 applies - W3D is proposer, W3C is
the named independent verifier, W3X ratifies):

  A knowledge sweep selects documents by CONTENT MATCH, never by
  classification. Classification governs which document PREVAILS in a conflict;
  it never governs whether a document is READ. No document may carry a
  classification whose practical effect is permission to skip it.

WHY IT IS A CHARTER MATTER AND NOT JUST A LESSON: the recorded incident was not
caused by carelessness. It was caused by a correct-looking process - the
currency audit classified the README as "fallback general guidance" and the
designer accepted the classification instead of checking it. A lesson in a
status document does not bind a successor; a charter rule does. It constrains
W3D's own sweeps, hence the I7 verifier requirement.
```

---

# T1 - Formal consolidation sweep of the MPEG-2-bearing document set

```text
WHAT: read and adjudicate EVERY MPEG-2, grid, field-DCT, interlacing and
related design statement in the live document set. For each hit decide: is it
current, relevant and accurate? If consistent with the authority document, is
it duplication that should become a reference (T3)? If it CONFLICTS, decide and
RECORD which prevails and why, naming the document it came from. Anything worth
keeping is folded into the authority document at the right place, without
duplicating.

WHY THIS IS NOT ALREADY DONE, STATED HONESTLY: authority document v1.05 is
ratified and prevails, and it is a good document. But it was built from the
investigation rounds plus a TARGETED recovery during the v1.03-v1.05 passes. It
has never been fed by the full sweep. "Single source of truth" is therefore
currently a STATUS WE HAVE GRANTED IT, not a state it has been demonstrated to
be in. T1 is the work that makes the claim true.

COMPLETION TEST: T1 is DONE when every MPEG-2-bearing statement in the live set
has an individual recorded disposition. It is NOT done when the authority
document merely looks comprehensive. T1 must not be marked DONE by inference.
```

## T1-METHOD - how the sweep is run

```text
M1  HIT SET DERIVED MECHANICALLY, NOT INHERITED.
    A defined term list is swept across every live document, so the population
    is reproducible and W3X can see what was searched and what matched. The
    "seventeen documents" figure from v1.0/v1.1 is treated as an estimate to be
    replaced by the actual manifest, not as the scope.
    WHY: an inherited count cannot be audited and may itself be wrong.

M2  SCOPE MANIFEST PUBLISHED FIRST (DEC-06).
    Every in-scope document listed as UNADJUDICATED before adjudication begins.
    superseded/ folders are OUT of scope as authority, with one mechanical
    exception: a check that no live document cites anything in them as current.

M3  EVERY HIT IS ADJUDICATED IN SITU.
    The document is opened and read FOR THIS QUESTION, with document and
    section quoted. Not from an index, not from a summary, and specifically not
    from prior familiarity.
    WHY, AND THIS IS THE SHARP EDGE OF THE RECORDED INCIDENT: the previous
    designer HAD read parts of the README earlier in the project, and that is
    precisely why skipping it felt safe. The useful check is not "did I read
    the specifications" but "did I read them FOR THIS QUESTION". Prior
    familiarity is treated as a reason for suspicion, not a reason to move on.

M4  FIVE DISPOSITIONS, each recorded with its reason:
      CURRENT-UNIQUE      leave in place
      CURRENT-DUPLICATE   becomes a pointer (T3)
      CONFLICTING         decide and record which prevails and its origin
      SUPERSEDED          retire or excise (T2/T3)
      OPERATIVE-SPEC      stays where it is used, gets a pointer alongside
                          (the deliberate T3 carve-out)

M5  OUTPUT IS A WRITTEN ADJUDICATION LEDGER listing every hit and its
    disposition. The ledger is what PROVES the sweep was thorough and lets a
    successor see that a document was CONSIDERED rather than SKIPPED. It is
    also the evidence for any authority-document version bump that absorbs
    recovered material.

M6  INCREMENTAL DELIVERY (DEC-10). Ledger batches emitted and presented per
    document as adjudication completes.

M7  SUPERSESSION IS READ FROM THE DOCUMENTS THEMSELVES.
    Where a document states what it supersedes or is superseded by, the ledger
    records that statement and its source. Where supersession is UNCLEAR or the
    documents disagree, the ledger records UNRESOLVED and the item comes to
    W3X as a decision item rather than being settled by W3D inference.
    WHY: inferred supersession is exactly how good work gets discarded quietly.

M8  THE CHARTER IS READ BUT NOT STRIPPED.
    T1 adjudicates the charter like everything else - it does carry MPEG-2
    content (the chroma-step invariant B5, Part 0, the parameter reference).
    T3 does NOT strip it, because rule-context belongs where the rules are. A
    charter statement conflicting with the ratified authority becomes a
    PROPOSAL to W3X, never a W3D edit (charter P-09).
```

## T1-KNOWN - items the sweep must handle (already surfaced; do not rediscover)

```text
  - the current Deblock4LumaStepY / midpoint audit-property model CANNOT
    express mixed B2 geometry as a single per-frame string;
  - 4:2:2 and 4:4:4 chroma FOLLOW luma DCT organisation and therefore CANNOT
    inherit the 4:2:0 fixed-chroma simplification;
  - the analyser rules require an unmodified-source pre-pass and per-call
    scratch under fmParallel;
  - schedule remains output-defining; proper chroma is a separate quality gate;
    grid origin / crop ordering is load-bearing;
  - the successor introductions are reconciled to the single MPEG-2 authority;
    check the remaining documents for equivalent stale field-separated /
    midpoint / one-step-per-frame wording;
  - Forward Roadmap v1.20: Stage 2D line still lists "schedules A/B, midpoint,
    proper chroma" as Deblock4 scalar-core content; no mention of B2,
    Architecture D or the Q14 gate anywhere; "next candidates" list names two
    items M1/M2 have completed; header date field (2026-08-01) predates the 5C
    content it describes (DEC-04);
  - Documentation Currency Audit v1.4: its "canonical current set" omits the
    prevailing MPEG-2 authority AND this task register, and pins three
    superseded versions (coder intro v1_27, designer intro v1_20, Project
    Status v1_27; actual v1_30, v1_23, v1_28) (DEC-04);
  - Grid Knowledge v1.2 header carries two conflicting version blocks
    ("Version: 1.2" immediately followed by "Version: 1.0, Date: 2026-07-27")
    and no supersession banner while sitting at top level (T2);
  - GAIS_GATING_RESPONSE.txt is still misnamed; it is a Zig
    conditional-compilation response and the currency audit records that it
    should be GAIS_ZIG_GATING_RESPONSE.txt (W3X manual act);
  - D0 Binding Knowledge Index v1.14 section 1.1 still pins README v1_9 as
    "fallback general guidance" - harmless in practice (D0 governs completed
    Stage 2C) but a stale pin, and an instance of the classification wording
    DEC-07 retires.
```

## T1-SRC - source-tree inventory (DEC-09; PERFORMED 2026-08-17)

```text
STATUS: DONE as an inventory. Handed to D4-Q16 as input. No adjudication, no
dispositions, no proposed edits - those belong to that bounded coding scope.

VERIFIED COLD against the W3X-supplied source tree, not from memory:

  NO DEBLOCK4 PIXEL MATHEMATICS EXISTS. src/deblock4_ar_all_frames_ready.zig
  lines 25-27 send all three dispatch arms (v1/v2/v3) to
  passThroughWritableCopy(). There is no threshold table, no activation test
  and no filter arithmetic anywhere in the deblock4_*.zig modules. Classic by
  contrast carries real kernels (classic_scalar_kernel.zig 194 lines;
  classic_vector_backend.zig 913; classic_thresholds.zig 123; plus the v2/v3
  thin objects). W3X's understanding is CONFIRMED on this point.

  THE PARAMETER / PROPERTY / DIAGNOSTIC SURFACE DOES STILL CARRY SUPERSEDED
  MPEG-2 VOCABULARY. This is NOT a defect and NOT a process failure: it was
  correctly ratified at Stage 1C, BEFORE the architecture re-decision, and
  authority v1.05 section 20 already registers it as legacy scaffolding awaiting
  D4-Q16. It is recorded here so it cannot be lost:

    src/filter_call_parameters.zig            74 hits
    tests/stage_1c_deblock4_passthrough.vpy   75 hits
    src/effective_invocation_text.zig         56 hits
    src/lifecycle_trace_debug.zig             36 hits
    src/deblock4_frame_properties.zig         30 hits
    src/deblock4_instance_creation.zig        20 hits
    src/deblock4_selftest.zig                 18 hits
    src/deblock4_plugin.zig                    5 hits
    build_5C_v1.bat                            present
    (terms: mpeg2_field_separated, midpoint_threshold_scale, luma_step_*,
     chroma_step_*, grid_mode, Deblock4LumaStepY/ChromaStep*/MidpointScale)

  CONSEQUENCE FOR THE RULE "source always reflects latest knowledge": it holds
  for ALGORITHM content, because no Deblock4 algorithm content exists yet. It
  does not hold for the PUBLIC SURFACE, which advertises a grid model the
  project has since rejected. Anyone calling the filter today can still pass
  grid_mode="mpeg2_field_separated". That is a D4-Q16 item, not a T1 item.
```

---

# T1.1-MATHS - mathematical inventory, gap analysis and disposition (NEW)

```text
WHAT: a distinct thread running INSIDE the T1 sweep and reporting AFTER it.
During adjudication, every mathematical statement encountered is captured to a
separate maths inventory as well as to the main ledger, recording:
    what the mathematics asserts;
    where it lives (document and section);
    its evidence class (H.262-VERIFIED / SPEC / SOURCE / MEASURED / DERIVED /
        PENDING / W3X-RATIFIED);
    whether it is current under the ratified authority.

ON COMPLETION the inventory is reconciled against what the architecture and the
forthcoming detector work actually REQUIRE, producing a three-column table:
    mathematics we have and can rely on;
    mathematics we have but which is superseded or unverified;
    mathematics we need and do not have.

Each gap gets a recommendation - derive now / derive inside T5 / defer to the
kernel or scheduler scope, with the reason - and each recommendation comes to
W3X as a decision item under the normal communication convention.

BOUNDARY: T1.1-MATHS records WHERE the mathematics is and WHAT is missing. It
does not itself derive new mathematics.

KNOWN STARTING POSITION (verified 2026-08-17, to be confirmed by the sweep):
  PRESENT in authority v1.05 section 4: whole-frame pitch mathematics -
    frame-organised luma e=8k pitch 1; field-organised luma e=16k+p pitch 2;
    the six-tap footprints R_s/W_s; vertical edges at x=8k; 4:2:0 chroma.
  PRESENT in authority v1.05 section 10: the complete B2 macroblock topology
    table including the mixed-boundary rule.
  ABSENT and DEFERRED BY DESIGN: 4:2:2 / 4:4:4 chroma scheduler tables
    (v1.05 section 4.6 defers these to the kernel/scheduler scope); final luma
    kernel footprint and eligibility radii (open under D4-Q02/Q04 and NOT
    closable before the architecture gate - deriving them now would invent
    numbers ahead of the evidence meant to determine them).

WHY IT EXISTS: T4 was marked "largely absorbed; confirm during T1", which is an
inference. A gap discovered during T5 or the kernel scope is discovered at the
worst possible time. (DEC-08)
```

---

# T2 - Retire the Grid Knowledge document

```text
WHAT: Deblock4_MPEG2_Grid_Field_DCT_Knowledge_v1_2 is superseded by the
authority document but still sits in the main dev_documentation directory
looking current, carrying possibly-misleading load-bearing content. Move it to
superseded/, and edit the Documentation Currency Audit in the SAME pass so
nothing references it as live. Its post-adjudication banner (DEC-05) is written
at this point, reporting a disposition backed by ledger entries.

WHY AFTER T1: it is the file most likely to hold content the sweep still needs
- its G-series checklist, and the Fig 6-1/6-2 chroma-siting material behind
D4-Q10. Retiring a referenced document is a COORDINATED edit, not a
drag-and-drop: the M2 lesson, where deleting a batch without amending the two
audit scripts that named it would have silently disabled two gates.
```

# T3 - De-duplicate MPEG-2 content into references

```text
WHAT: once T1 establishes what is duplicated, strip duplicated KNOWLEDGE and
DECISIONS out of the other documents and replace them with pointers to the
authority document. One home per fact.

TWO CARVE-OUTS, both deliberate:
  - operative SPECIFICATIONS stay where they are used. A document describing
    parameter behaviour the filter implements is specification, not knowledge;
    it gets a pointer, not a hollowing-out.
  - the charter's MPEG-2 mentions are rule-context and are NOT touched (M8).

README-SPECIFIC (DEC-07): the superseded MPEG-2 architecture sections are
EXCISED and replaced with pointers, NOT annotated in place.
WHY: annotated wrong design is still wrong design sitting under a heading that
looks authoritative, and this project has already proved that readers trust the
heading. Rehoming targets: MPEG-2 content -> the ratified authority; tiering /
verification / two-filter rationale -> Deblock4_Verification_And_Tiering_
Decisions; global rules -> the charter BY PROPOSAL TO W3X, never by W3D edit.
Load-bearing content with no existing home comes to W3X as a list with a
proposed destination; W3D does not invent a new authority document
unilaterally.
```

# T4 - Boundary-set mathematics

```text
STATUS: SUBSUMED into T1.1-MATHS (DEC-08). Retained here so the thread is not
lost. T4 closes when T1.1-MATHS delivers its gap table and W3X rules on the
recommendations - not by a judgement that the authority document "appears to
cover it".
```

# T5 - Detector mathematics

```text
WHAT: the formal specification of the B2 classifier - which features are
computed per macroblock, how the FRAME and FIELD hypotheses are scored, how
confidence is derived, and where the UNKNOWN threshold sits. Also the
equivalent statement for Architecture D's single uncertain internal candidate.

SEQUENCE: AFTER T1 (DEC-02). Issued and ratified ALONE; T6 follows separately
(DEC-03).

WHY IT PRECEDES T6: the experiment measures THIS SPECIFIC DETECTOR. A detector
that has not been defined cannot be measured, and defining it after seeing
held-out results would be tuning to the test.

OWNERSHIP: W3D derives; W3C independently cross-checks the derivation and its
SIMD consequences; W3X ratifies (D4-D11). Charter I7 applies to any acceptance
criterion W3D proposes that will judge W3D's own derivation.
```

# T6 - The D4-Q14 architecture-discriminator experiment plan

```text
WHAT: the written plan for the experiment that decides B2 versus D:
  - how per-macroblock dct_type GROUND TRUTH is extracted from real PAL MPEG-2
    bitstreams (frame_pred_frame_dct is readable per picture via
    mediainfo --Details=1, which gives cheap regime triage ONLY);
  - how both legs are scored (B2: confusion matrices, confidence margins,
    UNKNOWN rate, FALSE-CONFIDENT rate, reported separately for FRAME/FRAME,
    FIELD/FIELD and MIXED boundaries; D leg: true-boundary versus
    false-candidate feature distributions with ROC sweeps);
  - NO_DCT / skipped / motion-only macroblocks as their OWN truth class, never
    fabricated into FRAME or FIELD;
  - the CALIBRATION and HELD-OUT subsets, with primary metrics and viability
    criteria PREDECLARED before held-out results are examined;
  - the decision rule: B2 if viable; else D if viable; else REOPEN the
    architecture - never force D merely because it is the fallback.

WHY IT MATTERS MORE THAN IT LOOKS: the target LG VHS-to-DVD recorder was
measured with frame_pred_frame_dct=0 in every practical restoration speed mode
(XP/SP/LP/EP; MLS is the frame-DCT control). The ADAPTIVE-CAPABLE per-macroblock
regime is therefore normal target-device operation and B2 is not engineering for
a merely theoretical regime. This picture-level fact does NOT prove that every
recording or picture actually contains both FRAME and FIELD macroblocks; Q14's
per-MB truth extraction measures that prevalence.

DEPENDS ON: T5 ratified first (DEC-03).
```

# T7 - Commit the consolidated set

```text
WHAT: the eventual commit that closes the FORMAL consolidation/retirement arc
and records the ratified experiment-plan set. This is NOT a prohibition on W3X
committing interim T1 ledger batches, banner edits or register bumps as they
land. Record what moved, what was retired and why, so a successor is not left
doing git archaeology.
```

---

# 2. THE RECORDED INCIDENT - why T1 is shaped this way

Kept in full because it is the reason for M3, DEC-05, DEC-06, DEC-07 and the
pending charter proposal, and because a successor who knows the rules but not
this incident will relax them.

```text
WHAT HAPPENED: Deblock4's grid architecture was an open design question. W3D
ran a four-round external research engagement plus two rounds of coder
verification to settle MPEG-2 block geometry and decide an architecture. That
produced the whole-frame input contract, the chroma findings and a decided
architecture. Then, while BEGINNING the consolidation sweep, W3D opened
README_Deblock4_Design_Spec and found sections 3.11 and 3.13 already contained a
fully-worked, PREVIOUSLY RATIFIED Deblock4 grid architecture - the union step-4
grid with scaled midpoint thresholds - complete with fixed-point threshold
conversion, immutable threshold sets and canonical read ordering. Someone had
already designed it properly. Nobody in the investigation had read it.

WHY IT WAS MISSED: the source tree was swept thoroughly. The decision record was
swept thoroughly. The SPECIFICATION was not, because the currency audit
described the README as "fallback general guidance" and that classification was
ACCEPTED INSTEAD OF CHECKED. A 2,800-line document carrying 137 MPEG-2 hits and
a ratified architecture is not fallback anything.

WHAT IT COST: everything downstream reopened. The just-decided architecture went
back on the table; a full comparison brief and a coder evaluation round were
needed; and the outcome changed materially. The rediscovered design was
ultimately REJECTED - but only after proper analysis, and that analysis produced
B2, which is better than what the investigation had reached alone. The near-miss
therefore ran BOTH ways: the project nearly shipped past good work, and nearly
missed the argument that improved it.

THE RULE THAT FOLLOWS: any knowledge sweep must include SPECIFICATION documents,
not merely decision records - and a document's CLASSIFICATION in an index is a
CLAIM TO BE VERIFIED, not a fact to be relied on. If a document plausibly
touches the question, read it, whatever the audit calls it.

THE SHARPER POINT, for anyone who has reported a sweep as done: the useful check
is not "did I read the specifications" but "did I read them FOR THIS QUESTION".
The previous designer HAD read parts of the README earlier in the project - that
is precisely why skipping it felt entitled and safe. FAMILIARITY IS WHAT MADE
THE OMISSION FEEL SAFE.
```

---

*Revision history*
```text
v1.2 (2026-08-17) W3D. Status corrected to RATIFIED (DEC-01). T1 moved ahead of
     T5 on W3X's reversal (DEC-02) with the reason recorded. T5-alone-then-T6
     confirmed (DEC-03). Roadmap/currency-audit currency folded into T1/T3
     (DEC-04). Banner policy split, README and Grid Knowledge deliberately NOT
     bannered pre-adjudication (DEC-05) after W3X identified the mislabelling
     risk in W3D's original recommendation. Scope manifest adopted as the
     protection mechanism (DEC-06). README destination and its sequencing
     constraint recorded (DEC-07). T4 subsumed into the new T1.1-MATHS
     (DEC-08). Source inventory performed and recorded (DEC-09). Incremental
     ledger delivery adopted (DEC-10). T1-METHOD, the decision log and the
     recorded incident added in full so the reasoning survives a session death.
v1.1 (2026-08-16) W3C handoff reconciliation for W3X: authority pointer
     advanced to ratification-recording v1.05; T1 progress corrected so the
     targeted v1.03-v1.05 recovery is not mistaken for the formal sweep;
     T5->T6 sequencing made explicit; LG evidence tightened to
     adaptive-capable rather than assumed observed mixture; T7 clarified as the
     eventual consolidation commit, not the current pre-handoff documentation
     commit.
v1.0 (2026-08-16) First issue. Captures the T1-T7 queue that previously existed
     only in conversation and in condensed form in Project Status section 0,
     with the T1 pause reason recorded in full so the sequencing decision is
     not mistaken for neglect.
```
