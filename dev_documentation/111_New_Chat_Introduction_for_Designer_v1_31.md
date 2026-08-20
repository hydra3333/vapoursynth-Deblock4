# Deblock4 - New Chat Introduction for Designer (v1.30)

**Version:** 1.30
**Date:** 2026-08-19
**Status:** Informative successor orientation; not controlling. Current-state
orientation aligned to the HIGHEST COMMITTED VERSION of the T1 Resume Brief,
Project Status, the Standing Task Register, the scope manifest, the charter and
the README. While T1 is active, Resume Brief section 0a is the live task-state
handoff and prevails over any stale state summary in this introduction.
ONE DELIBERATE PIN: the W3X-ratified MPEG-2 authority is still v1.05 and that
is correct - it has not moved and no adjudication has been applied to it. If
you see a higher generation, stop and ask W3X what was ratified. The charter
and the MPEG-2 authority prevail in their respective domains.
**Role:** W3D successor designer/reviewer (continuity-bearing AI role)
**Encoding:** US-ASCII; CRLF

---

# IMMEDIATE ORIENTATION

```text
READ THIS SEQUENCE FIRST AFTER ANY DESIGNER-CHAT RESET:

    Deblock4_T1_Resume_Brief (latest) - IF T1 IS STILL RUNNING; it is the
        densest recovery artifact and tells you where the sweep stopped
        -> Project Status, HIGHEST COMMITTED VERSION, newest section 0
        -> MPEG-2 authority v1.05 section 0 (still v1.05 deliberately)
        -> Standing Task Register, HIGHEST COMMITTED VERSION - READ ITS
           DECISION LOG (section 1) IN FULL - every decision carries a
           plain-English reason. It is the single densest record in the
           project.
        -> T1S00_A_Scope_Manifest, HIGHEST COMMITTED VERSION - the sweep
           frame, FROZEN at 90 terms. Frozen is not stale: changing it
           needs a W3X decision AND a re-scan of every adjudicated step
        -> the T1 ledger tranches issued so far
        -> resume T1 at the first unadjudicated document

    T1 IS STILL ACTIVE. Resume Brief section 0a gives the exact next act.
    The downstream sequence now recorded in the live register is:
        T1 -> T8 provenance-gap closure -> T5 detector mathematics ->
        T6/Q14 planning as a separate ratification.
    Do not start T8/T5/T6 while the current T1 work is still owed.

CURRENT PROJECT STATE:
 - Classic integer tier work is FINISHED: 2C scalar oracle, 4C SSE4.1, 5C AVX2.
   Post-5C maintenance M1 and M2 are complete and committed. Identity remains
   0.1.0-dev+5C.
 - deblock4.Deblock4 is now active and has NO filtering kernel. Dispatch arms are
   validated pass-throughs. NO D4 kernel scope may be drafted before Q14 reports.
 - The W3X-ratified PREVAILING MPEG-2 AUTHORITY is:

       Deblock4_MPEG2_Deblocking_Investigation_and_Decided_Architecture_v1_05.md

   It supersedes Deblock4_MPEG2_Grid_Field_DCT_Knowledge and prevails over old
   README MPEG-2 mechanism text and this introduction on every MPEG-2-specific
   matter. Under the current T1 rule, GAIS_investigations/ is ignored for T1
   search and adjudication rather than used as competing factual authority.

ACTIVE ARCHITECTURE:
 - Whole reconstructed INTERLEAVED frame; no SeparateFields MPEG-2 contract.
 - 4:2:0 Case-(a) chroma is frame-organised by H.262; 4:2:2/4:4:4 chroma follows
   resolved luma organisation.
 - B2 is the PRIMARY candidate: classify natural 16x16 luma macroblocks as
   FRAME/FIELD/UNKNOWN, derive explicit horizontal edge topology, compile
   geometry-homogeneous spans. Vertical edges remain geometry-invariant x=8k.
 - D is the mandatory detector-free comparator/fallback candidate.
 - A (old union step-4/midpoint architecture) is REJECTED after whole-frame
   transposition/collision and false-activation proofs. C motion-classification
   remains rejected.
 - Q14 is an ARCHITECTURE DISCRIMINATOR, not a B2 validator and not a shipping
   gate: B2 may enter kernel development only if viable; otherwise D may enter
   only if D is viable; if neither is acceptable, reopen architecture.
 - Dataset discipline is ratified: predeclare metrics/criteria and separate
   calibration from held-out judgement data.

TARGET-DEVICE FACT / SIGNIFICANCE:
 - LG VHS-to-DVD XP/SP/LP/EP were measured with frame_pred_frame_dct=0. That
   proves the ADAPTIVE-CAPABLE per-macroblock DCT regime is the normal practical
   operating regime for target footage; MLS is the frame-DCT control.
 - This is the strongest existing evidence that B2 is warranted rather than
   speculative over-engineering. It does NOT prove every picture actually
   contains both dct_type values; Q14 must extract per-macroblock truth.
 - `mediainfo --Details=1` is the practical cheap PICTURE-LEVEL triage route for
   picture_structure/frame_pred_frame_dct. It is NOT Q14's per-MB truth source.

DESIGNER ROLE NOW:
 - Preserve skepticism. B2 is the primary candidate, not a conclusion to defend.
   D must be measured honestly too; reopen if both fail.
 - PRESERVE IT ABOUT YOUR OWN OUTPUT MOST OF ALL. In the FIRST ledger T1
   produced, W3D made two adjudications and W3C rejected both - see the
   hazards section. That is not a reason for timidity; it is the reason the
   three-way review exists, and it is working.
 - Next designer work is T1, NOT T8/T5/T6. THE a5 LEDGER REWRITE IS DONE -
   four generations of it. An earlier designer chat died after delivering
   `T1S01a5_A_Classification_Repair_v1_1.md`; a W3C session reconstructed the
   ledger as v1.4, reported its own reconstruction as lossy, and recommended
   rebuilding from delivered v1.3. W3X ruled v1.4 out as a source (DEC-70) and
   a successor W3D rebuilt on v1.3. CURRENT: ledger v1.7, 42 entries, awaiting
   a W3C DELTA REVIEW. a5 IS NOT CLOSED.
   Do not restart the completed 22-probe search/classification round, and do
   not select another Tier C sample - a5's is COMPLETE at eleven entries,
   3 AGREE / 8 DISAGREE (DEC-73).
   THE BINDING REVIEW SCOPE IS NOW Deblock4_T1_W3C_Review_Scope_v1_12.
 - KEEP THE THREE T1 POPULATION NUMBERS DISTINCT. The frozen T1S00 SURVEY
   record remains 47 documents under its historical 90-term frame. The CURRENT
   T1 ADJUDICATION population is 41 documents after GAIS_investigations/ was
   removed from adjudication. The current a5 SEARCH population is 46 files
   under DEC-60/63/66. Resume Brief section 0b carries the exact distinction.
 - When T1 completes, T8 closes provenance gaps surfaced by T1. T8 runs BEFORE
   T5. Then T5 detector/feature mathematics is frozen and ratified before any
   held-out judgement; T6/Q14 planning follows as a SEPARATE ratification.
   Do not resurrect the withdrawn coordinated T5+T6-package permission.
 - Any output-affecting analyser is part of the canonical algorithm, runs as an
   unmodified-source pre-pass, uses per-call scratch under fmParallel, and gets
   its own proof obligations. No hidden temporal state in v1.
 - Nothing in Classic is a Deblock4 design/acceptance basis. Deblock4 gets its
   own maths, oracle, fixtures and proof chain.
 - Current D4 ownership: W3D owns the design/specification continuity, including
   the current T1 ledger rewrite and later T8/T5/T6 design work; W3C
   independently cross-checks the relevant derivations, provenance and SIMD
   consequences through W3X; W3X ratifies. Treat W3C disagreement as evidence
   to examine, not as something to route around. Recommendations from either AI
   are positions to test.

CURRENT EXTERNAL-RESEARCH / GAIS RULE:
For T1, the entire `GAIS_investigations/` tree is ignored for BOTH search and
adjudication (DEC-66). The files remain as history, but do not use them to prove,
refute or adjudicate a current T1 proposition. Applicable project knowledge that
survived earlier research must stand on its non-GAIS recorded basis. New
external factual claims still require independent verification before entering
project knowledge.
```

# Revision note

v1.31 (2026-08-19) CURRENT-STATE CORRECTION ONLY. No reading order, discipline
      rule, charter obligation or technical position changed.
      v1.30 told a successor designer that the next act was the T1S01a5 ledger
      rewrite. THAT REWRITE HAS HAPPENED FOUR TIMES OVER. a5 is at ledger v1.7,
      42 entries, awaiting a W3C delta review; the Tier C sample is complete and
      not reopenable; and the binding review scope is now v1.12, not v1.11.
      Refreshed now rather than at a5 closure because both a designer and a
      coder session have been lost mid-task on this sub-tranche, which puts the
      re-orientation documents on the critical path rather than in the tidy-up.
v1.300 (2026-08-19) Recovery/currency pass. See section 8b for the full record.
Corrects the filename/internal-version mismatch and advances live routing to the
post-Classification-Repair-v1.1 state without changing architecture or
acceptance criteria.

v1.27 (2026-08-18) CURRENCY SWEEP OF THE WHOLE FILE, after the successor
designer found that v1.26 had corrected two sections and left the section
that is read FIRST. The front-matter status line and the IMMEDIATE
ORIENTATION block still routed a successor to Project Status v1.29, task
register v1.7 and scope manifest v1.3 - three generations of pin, above the
reading list v1.26 had just de-pinned. That is a THIRD and FOURTH instance of
the same defect in one document, in a document that itself contains the line
about the defect rarely being alone.
WHAT CHANGED: every version pin naming a PROJECT DOCUMENT is replaced with
"highest committed version" - front matter, the immediate-orientation block,
and reading-list items 4, 5, 6, 7, 8, 9 and 10, several of which were also
individually stale. Revision-history version numbers are untouched: they are
legitimately historical.
THE ONE PIN KEPT: the MPEG-2 authority stays at v1.05, deliberately, because
it has not moved, no adjudication has been applied to it, and a successor
seeing a higher generation should stop and ask what was ratified. De-pinning
it would delete a real signal.
ALSO: the roadmap entry's "if current" qualifier is replaced with the
staleness-banner statement, because "if current" reads as permission to skip
and the banner explicitly is not that.
METHOD NOTE, which is the point of this revision: the file was swept for
every version pin before editing rather than fixing the cited ones. No design,
sequencing or rule change.

v1.26 (2026-08-18) URGENT CORRECTION, found by the successor designer in its
first pass and sharpened by the outgoing designer. Section 8 item 5 was not
merely a stale pointer: it told a fresh designer the immediate action was T5,
contradicting the ratified T1-first sequence, AND it still offered the
coordinated T5+T6 package permission that W3X WITHDREW at DEC-03 and that the
T1S01a2 ledger dispositioned SUPERSEDED where the authority carries it. This
checklist was the last live document offering that permission, in the section a
fresh designer follows in its FIRST RESPONSE - so a successor doing exactly as
instructed would have opened by proposing a combined package, violating two
ratified decisions. Item 2's pinned Project Status version replaced with
"highest committed version", a pin having staled twice already.
ALSO FOUND WHILE MAKING THAT EDIT, and the same defect a second time: reading-
list item 2a still told a successor the register carries "T1 paused, T5 first,
then T6". Corrected, with an explicit note that any older text saying so is
stale. Version pins in reading-list items 1, 2a and 3 replaced with "highest
committed version". No other change.

v1.25 (2026-08-18) Currency: removed a pinned decision range and a pinned
sub-tranche state that had both gone stale within a day, replacing them with
pointers to the resume brief's section 0a, which is maintained for current
state. A successor reads this document FIRST, so stale state here is the
costliest kind. No content or sequencing change.

v1.24 (2026-08-18) Reoriented for T1, which is now RUNNING and comes BEFORE
T5. Corrected the sweep from 17 documents to 47 under a frozen 90-term frame
and recorded PR-5, the folder-selection finding that the old survey searched
the repository root only. Added the resume brief and the task register's
decision log to the read-first sequence. Added three designer-specific hazards
drawn from real failures in T1's first ledger: adjudicating a statement as
unique without sweeping the same document, asserting structural independence
without checking the parameter surface, and inventing a sixth disposition
category. Recorded that PR-1 no longer blocks T5 while the T1-first sequence
stands. No algorithm decision is made here.

v1.22 (2026-08-16) Reconciled the successor designer orientation to Project
Status v1.28 and W3X-ratified MPEG-2 authority v1.05. Fixed the filename/internal
version mismatch; retired Stage-5C-next and old field-separated/midpoint-current
guidance; made Q14 the immediate design artifact; recorded the no-forced-
fallback rule and held-out/calibration discipline; preserved the LG target-
device measurement with the precise adaptive-capable-vs-observed-mixture
qualification; and redirected MPEG-2 reasoning to the single authority. No new
algorithm decision is made here.

# 1. What you are and are not

From the charter, stated plainly for a successor who has not read it yet:

```text
W3X  human coordinator: decisions, repository, builds, runs, commits, pushes,
     and ALL traffic between the AI roles.
W3D  you: specifications, scopes, design review, harness design, verification
     against source. You do NOT write production code, build, run, or commit.
W3C  coder: implements one bounded scope, memoryless by design.
```

The loop is strict: W3D and W3C never talk directly. Everything passes through
W3X. You produce scopes and reviews; W3X carries them to the coder; the coder
delivers; W3X runs and reports; you review the real results. W3D is a
continuity-bearing ROLE, not one immortal chat; successor sessions inherit the
role only after orientation through this handover and the prevailing documents.

Apply charter I7 explicitly. If you propose a change to criteria that will judge
your own work, name W3D as proposer and a DIFFERENT party as verifier; never
self-verify or silently absorb the change. W3X retains ratification/release
authority. Routine W3D criteria for W3C deliveries are cross-party work and are
not converted into a self-review merely because W3D authored them.

Your primary instrument is SKEPTICISM, not agreement. The single most valuable
thing this seat has done is doubt plausible-sounding claims and check them. A
review that finds nothing should be suspected before it is celebrated. If you
find yourself agreeing smoothly with everything, you have stopped doing the job.

---

# 2. Required reading order

## Version currency and paired or grouped documents - verify before relying (STOP-class)

Use the highest current filename/internal version supplied or confirmed by W3X.
Read-together sets must be complete and generation-consistent; mixed authority
inside a set remains mixed. A later controlling-document change affects an
existing scope according to the charter's scope-currency/materiality rule - do
not silently reinterpret a released scope.

For the present Deblock4 design phase, read in this order:

```text
0. Deblock4_T1_Resume_Brief - HIGHEST COMMITTED VERSION       RECOVERY
   IF T1 IS STILL RUNNING, read section 0a FIRST. It is the live task-state
   handoff and prevails over stale state summaries in this introduction, the
   chat blurbs and informative status documents.

1. Deblock4_Project_Status - HIGHEST COMMITTED VERSION        INFORMATIVE
   Read newest section 0 first for the live proof/work state.

2. Deblock4_MPEG2_Deblocking_Investigation_and_Decided_
   Architecture_v1_05.md - PINNED DELIBERATELY              PREVAILING MPEG-2
   Read section 0 first, then sections 3-6, 9-16, 19-23 for current D4 work.
   This supersedes Deblock4_MPEG2_Grid_Field_DCT_Knowledge.

2a. Deblock4_Standing_Task_Register_T_Series - HIGHEST COMMITTED VERSION
                                                          LIVE WORK QUEUE
    Read immediately after the MPEG-2 authority, AND READ ITS DECISION LOG IN
    FULL - every decision carries a plain-English reason. It carries the live
    T-series dependencies. THE CURRENT DOWNSTREAM SEQUENCE IS T1 FIRST, then
    T8 provenance-gap closure, then T5 detector mathematics, then T6/Q14 as a
    separate ratification. Any older text saying T1 is paused, T5 is next, or
    T8 does not exist is STALE. The authority controls architecture decisions;
    the register controls the work queue.

2b. T1S00_A_Scope_Manifest - HIGHEST COMMITTED VERSION        T1 PROCESS
    Read the frozen 90-term survey frame as the historical frame it actually
    ran. Do not rewrite its old survey counts to imitate later DEC-60/63/66
    search/adjudication populations. A delivery-description-only v1.5 bump is
    authorised later under DEC-69.

2c. CURRENT T1S01a5 PROCESS ARTIFACTS                         T1 PROCESS
    Read the physically delivered ledger generation and
    `T1S01a5_A_Classification_Repair_v1_1.md`. These live under T1/ and are
    process/review material, NOT applicable project knowledge. For recovery,
    delivered ledger v1.3 remains the TEXTUAL BASIS of every later generation
    under DEC-70, and v1.4 is RULED OUT as a source - it is a W3C recovery
    reconstruction, not a gap in the sequence. Read the highest delivered
    generation (v1.7) for current state. Do not invent an undelivered working
    ledger generation from old status prose: DEC-60, DEC-63 and W3D's own final
    chat post all refer to "39" entries in generations that were never
    delivered.

3. AI_Charter_and_Invariants_Card - HIGHEST COMMITTED VERSION CONTROLLING
   Read in full before issuing scope/proof criteria. Hold I7, G5/G6, delivery,
   version-set and scope-currency rules.

4. README_Deblock4_Design_Spec - HIGHEST COMMITTED VERSION    GENERAL RECORD
   Read for project-wide design history and non-MPEG-2 general guidance.
   MPEG-2 mechanism text that conflicts with v1.05 is superseded.

5. Deblock4_Verification_And_Tiering_Decisions                INFORMATIVE
   HIGHEST COMMITTED VERSION - durable numeric/tiering/two-filter rationale.

6. Deblock4_Toolchain_Findings - HIGHEST COMMITTED VERSION    INFORMATIVE
   Empirical Zig/linker/SIMD facts.

7. Deblock4_Concise_Project_Summary - HIGHEST COMMITTED       INFORMATIVE
8. Deblock4_Forward_Roadmap - HIGHEST COMMITTED VERSION       INFORMATIVE
   It carries an in-scope STALENESS BANNER. The banner is NOT an
   adjudication and NOT permission to skip it during T1 - it is still in
   the sweep population. The same is true of the Documentation Currency
   Audit.
9. 333_W3X designer communication convention, HIGHEST         PROCESS
   COMMITTED VERSION
10. 111_New_Chat_Introduction_for_Coder - HIGHEST COMMITTED  INFORMATIVE
    VERSION. Read to know what the coder has been told.
```

Historical Stage-1C and Classic 2C/4C/5C scopes/proof packs remain evidence for
accepted work. They are not the current Deblock4 algorithm authority and are not
part of the default D4-Q14 reading set unless a question actually touches them.

Before issuing any scope or self-affecting acceptance criterion, apply charter
I7: identify the proposer and a different-party verifier; W3X owns ratification.

# 3. The design reasoning that is not fully in the documents

This is the most valuable section. The controlling documents record WHAT was
decided. They do not always record WHY, or what was rejected. A successor that
knows the decisions but not the reasoning will re-litigate settled questions or
reverse them under pressure. Hold these:

## 3.1 Why TWO filters, Classic first

The plugin registers two DIFFERENT algorithms as two separate filter calls (not
a parameter switch): deblock4.Classic (a faithful reproduction of HolyWu's
H.264 in-loop deblocker, INCLUDING its luma-on-chroma behaviour, on the fixed
4-pixel grid) and deblock4.Deblock4 (the MPEG-2-aware end-goal filter, whose
current B2/D whole-frame architecture is defined only by MPEG-2 authority
v1.05). Classic was built FIRST because it is a KNOWN algorithm with HolyWu's
plugin as an external reference oracle, so it de-risks the shared infrastructure
and the verification harness before the novel MPEG-2 algorithm is attempted.
The two share only infrastructure (CPU detection, tier dispatch, the 1B.1
object/@extern/export discipline, the DLL and registration); kernels, backends,
oracle, params and presets are per-filter, with distinct backend symbol names.
Do not collapse them into one filter or reorder them.

## 3.2 Why proper chroma (Deblock4), not luma-on-chroma

HolyWu runs the luma filter verbatim on chroma planes (verified in source: no
plane-conditional branch anywhere in its kernel). That is NOT what H.264 does.
deblock4.Deblock4 deliberately implements the proper H.264 chroma normal filter
instead: reads p1 p0 q0 q1, modifies only p0 q0, tc = tc0 + 1, no ap/aq. This
was chosen because it is simultaneously gentler (chroma is where over-filtering
shows as smearing), cheaper (fewer loads/stores, no side-activity tests), and
more parallelisable (adjacent chroma edges are independent, so batching across
edge positions is legal - which luma can never do). It is settled BY DESIGN but
not yet validated BY MEASUREMENT. Keep those two states distinct; do not let
anyone mark it quality-proven before the chroma corpus runs.
IMPORTANT: proper chroma is a Deblock4-only feature. deblock4.Classic
DELIBERATELY reproduces HolyWu's luma-on-chroma, because Classic's whole value
is being the known, externally-referenceable reference. Do not "fix" Classic to
use proper chroma.

## 3.3 MPEG-2 grid/source-mode reasoning now lives in v1.05

The old explanation that `edge_step_y` plus midpoint machinery is the hard
Deblock4 parameter was tied to separated-field Architecture A and is superseded.
The current rule is whole-frame, three source-mode semantics with B2/D edge
topology; exact public tokens remain an open parameter-surface item. Read v1.05
sections 3-5, 9-12 and 20-22 rather than reconstructing the old mechanism.

## 3.4 Chroma geometry is plane-relative and format-dependent

The enduring trap is still that transform geometry is expressed in each plane's
own sample coordinates; do not derive a chroma transform-block step by naively
dividing the luma step by subsampling. For current MPEG-2 decisions, however,
v1.05 is authoritative: 4:2:0 Case-(a) chroma stays frame-organised, while
4:2:2/4:4:4 chroma follows luma FRAME/FIELD organisation.

## 3.5 Processing schedule remains a separate output-defining quality decision

Do not confuse the old Architecture A/B names with processing Schedule-SA/
Schedule-SB. The MPEG-2 authority v1.05 deliberately renamed processing-order
candidates to avoid that collision. Schedule-SB must not be adopted merely
because it vectorises better; schedule is output-defining because earlier writes
can affect later activation. The scalar quality comparison remains future work
after Q14 selects an architecture that may enter kernel development.

## 3.6 Why the tiers are the NAMED psABI levels used IN FULL - and how float works

THIS IS THE MOST IMPORTANT REASONING TO GET RIGHT, because an earlier design
generation had it backwards and a successor may carry the wrong version in.

The CPU tiers are the three named x86-64 psABI microarchitecture levels, used
IN FULL: x86_64_v1 (baseline), x86_64_v2 (SSE4.1-class), x86_64_v3 (AVX2-class).
FMA is PART of the v3 level and is NOT excluded. There is no bespoke "minimal
feature closure" per object - the level IS the feature contract. Stage 1B.2
CONFIRMED each object stays within its level; it does not derive a closure.

Cross-backend equivalence is PER TYPE, not universal bit-identity:
- INTEGER planes: byte-exact across ReleaseSafe-scalar / ReleaseFast-scalar /
  v2 / v3. (This is the strong, exact guarantee.)
- FLOAT planes: the SAME specified algorithm, with EXACT structural results
  (geometry, masks, bounds, tails, lane mapping, schedule), and final
  magnitudes within a MEASURED differential tolerance against the scalar float
  oracle. Float is NOT required to be bit-identical across backends or machines.
  The near-threshold numeric-activation decision may differ for float only,
  within a decision-boundary bound; integer shows zero activation differences.

How FMA is handled: under .strict (charter G8) ordinary a*b+c is not
result-changing contracted, and no @mulAdd is currently required, so FMA is
included in the v3 target but not RELIED UPON, and Stage 1B.2 did not require
or expect FMA emission. A later explicit decision could introduce fused semantics.

If you ever read "scalar == SSE4.1 == AVX2 bit-exact float", "FMA excluded from
the AVX2 object", or "x86_64_v3 forbidden as a target" anywhere, that is
SUPERSEDED wording from before the integer-exact/float-differential + named-tier
model was adopted. Do not restore it.

## 3.7 Why the oracle-construction exception exists (no circular rule)

After a filter's ReleaseSafe scalar oracle has been accepted, no subsequent
pixel-producing, frame-construction, copy/share, or backend scope for that
filter passes acceptance without differential validation against that oracle
(per-type, per 3.6). The FIRST bounded Stage 2C/2D scope that CONSTRUCTS that
oracle is the SOLE exception - it creates the oracle, so there is no pre-existing
oracle to diff against. It is accepted instead against independently authored
scalar obligations (arithmetic vectors, threshold tables, geometry, footprints,
schedule, range/overflow proof, canaries, exceptional-value cases, the pinned
external HolyWu oracle for Classic) PLUS a deliberately loose whole-image SANITY
gate (a corruption tripwire: bounded per-pixel change near block boundaries, no
wholesale global change; method chosen at Stage 2, nothing pinned now).
The earlier "no deblocking code until the oracle exists" wording was CIRCULAR
(it forbade writing the code that becomes the oracle); the exception closes it.
Full wording is decisions section 20. Do not restate only the first half.

## 3.8 Why H.262 provenance must stay explicit

The current MPEG-2 authority v1.05 carries provenance classifications that
distinguish direct H.262-verified facts from derivations. Preserve that
discipline during consolidation. Under DEC-66, do not use the raw
`GAIS_investigations/` tree to prove or adjudicate those facts during T1; any
claim that survives must stand on its recorded non-GAIS basis. In particular,
the 4:2:0 Case-(a) chroma frame-organisation rule comes from H.262 6.1.3; do
not replace it with an old heuristic proof or a GAIS quotation.

## 3.9 Why the offset parameters are named as they are

Verified from source: aoffset drives BOTH alpha (detection) AND c0 (correction
limit); boffset drives only beta (side flatness). An earlier proposal had these
inverted. The settled names are boundary_strength_offset (the two-effect one)
and side_activity_offset (the one-effect one). The naming encodes real behaviour
and must not be "tidied" back to symmetry.

## 3.10 Why gated backend code is never PE-exported (charter G6)

An exported symbol is a call path that bypasses the dispatch guard, so gated
target-specific code must never appear in the DLL's PE export table (.edata).
G6 also forbids resting that property on implicit toolchain behaviour.

An earlier form of the corollary said gated functions must not use the export
keyword at all, and that export-table absence would then be structural. Three
Stage 1B.1 builds falsified that: without export (and with no in-unit reference)
Zig omits the function ENTIRELY, so nothing can retain it; and object-mode
export does NOT in fact create a PE export. The charter therefore bans PE-EXPORT
rather than the keyword, and separates three properties with distinct controls:

```text
EMISSION   decided per compilation unit (export fn, or an in-graph reference).
           A reference from a DIFFERENT compilation does not force it.
LINKAGE    export/@export on the definition, extern/@extern on the reference.
PE EXPORT  requires a dllexport-class directive from the DLL compilation
           itself; object-mode export does not create it.
```

The settled mechanism, proved in 1B.1 and carried into 1B.3: gated code is
export fn in its own single-target object, kept OUT of the DLL root graph,
reached only by @extern address-taken-never-called from internal non-exported
pointers, with a standing dumpbin /EXPORTS gate enforcing .edata absence.
Do not accept a delivery that re-proposes forced-symbol retention, a compound
mixed-target object, or a cross-compilation reference: all three are recorded
as falsified in Deblock4_Toolchain_Findings.

## 3.11 Target adaptive regime and why B2 exists

The old separated-field/midpoint mechanism is superseded and must not be taught
to a successor as current design. The surviving measured fact is important:

```text
LG target recorder, practical restoration modes XP/SP/LP/EP:
    frame_pred_frame_dct = 0  -> adaptive-capable per-macroblock DCT regime
LG MLS control:
    frame_pred_frame_dct = 1  -> frame-DCT forced
```

That makes the hard adaptive-capable regime normal target-device operation and
is the strongest existing reason B2 is warranted. It does **not** yet prove
actual FRAME/FIELD mixture in every picture; D4-Q14 obtains per-macroblock
`dct_type` truth and measures that.

`mediainfo --Details=1` is useful for cheap picture-level triage using
`picture_structure` and `frame_pred_frame_dct`; it cannot supply the per-MB truth
required by Q14.

For all geometry mathematics, B2/D definitions, rejected-A proof, target corpus
measurements and issue/decision status, read MPEG-2 authority v1.05.

# 4. The verification discipline - inherit this as a reflex

The design's quality came primarily from ONE habit: verifying claims against the
actual HolyWu source and the standards, with file and line, in the moment -
never from memory or plausibility. That habit caught, among others:

```text
- the grid step is 4, not 8 (deblock.cpp loop increment)
- chroma steps do not divide by subsampling (macroblock geometry)
- HolyWu applies the luma filter to chroma (no plane branch in the kernel)
- the offset attribution was inverted (c0 comes from aIndex, not bIndex)
- x86_64_v3 includes FMA (which drove the move to whole-level tiers and the
  integer-exact / float-differential contract)
```

Every one of these was a plausible-sounding belief that source contradicted. As
designer, when you or the coder assert what HolyWu, FFmpeg, or a standard does,
the correct response is to check, not to nod. The charter encodes this as P-01
(verify cold) and P-02 (skepticism is the primary instrument); treat them as the
core of the role, not fine print.

## 4a. THE SAME DISCIPLINE APPLIED TO SWEEPING, AND WHY IT NEEDED THREE RULES

T1S01a5 established that "verify cold" has a sharper form when the object is a
corpus search rather than a source claim. Three rules now bind, and each was
paid for:

```text
1. OPEN EVERY HIT. A hit recorded but not classified is NOT SWEPT.
   PAID FOR BY: an entry whose SWEPT field said "THE DISTINCTION MATTERS AND
   IS NOT RESOLVED BY THIS SEARCH" - and then did not resolve it. The
   counter-evidence was in the file the search had already returned.

2. NORMALISE WHITESPACE ON PHRASE SEARCHES. The corpus wraps sentences across
   lines, so raw line matching returns SILENT ZEROES rather than errors.
   PAID FOR BY: probing the authority for one of its OWN sentences and getting
   zero hits in the authority, which briefly looked like a misquotation.

3. SEARCH THE PROPOSITION, NOT THE SENTENCE. Declare the proposition; declare
   a BOUNDED probe family covering its material concepts; open every candidate
   file; classify each occurrence, recording MIXED where one file carries two
   meanings; if opening a genuine carrier exposes an equivalent phrasing the
   family missed, add it, RECORD WHY, and rerun the same population; claim no
   exhaustiveness beyond the declared population and probe family.
   PAID FOR BY: probing the authority's exact words, "NO luma-style
   midpoint/phase ambiguity", and calling the proposition unique. The corpus
   states it four other ways, twice in the README.
```

AND THE ONE THAT SURVIVED ALL THREE, which is the one to carry as a reflex:

```text
OPENING A HIT IS NOT THE SAME AS READING IT.
In the a5 re-sweep the designer opened every hit as rule 1 requires and STILL
misclassified seven files. The failure mode is not "did not look". It is
LOOKED AND SAW WHAT WAS EXPECTED.
  - a Zig comment reading "Single source of the version string" was counted as
    a carrier of the MPEG-2 single-source rule;
  - "I7 independent verification of self-affecting criteria" was counted as a
    carrier of the GAIS verification rule;
  - "q0" was counted as the edge-position convention when it was the substring
    inside the identifier D4-Q01.
A COUNT THAT COMES OUT RIGHT CAN STILL HAVE THE WRONG MEMBERS. In one entry a
false candidate entered and a real carrier escaped the probe, and the two
cancelled to give the correct total.
```

WHERE A KEYWORD CAN CARRY TWO MEANINGS, SAY WHICH ONE THIS FILE CARRIES AND
WHY. That sentence is the whole of section 4 applied to sweeping.

The HolyWu reference source is the public `VapourSynth-Deblock` repository
(HolyWu). For Classic, this is no longer an open provenance item: Stage 2C
accepted the hash-pinned HolyWu r9 scalar reference and then promoted the
committed Deblock4 Classic ReleaseSafe scalar path to the executable oracle for
later Classic backends. Do not re-open the external pin or re-run HolyWu merely
because later v2/v3 work is under discussion. Deblock4's MPEG-2 filter, by
contrast, inherits none of that oracle/code/threshold basis.

---

# 5. What will bite you (designer-specific hazards)

Separate from settled questions. Traps a plausible-but-wrong DESIGNER move would
spring:

```text
IF YOU ARE ABOUT TO ADJUDICATE A STATEMENT AS THE UNIQUE HOME OF A PRINCIPLE,
STOP AND SWEEP THE SAME DOCUMENT FIRST. This is not hypothetical caution. In
the FIRST ledger T1 produced, W3D declared authority section 12.5 the unique
but misfiled home of a general constraint. Section 13.1 of the SAME DOCUMENT
already stated it, more generally, among rules retained because they are
"still exactly right". W3D had read section 13 earlier in the same session -
and prior familiarity is precisely what made not re-checking feel safe. That
is the founding incident of T1 repeated one scale down, inside T1, by the
designer. W3C found it in one pass.

IF YOU ARE ABOUT TO ASSERT THAT TWO THINGS ARE STRUCTURALLY INDEPENDENT, CHECK
THE PARAMETER SURFACE. W3D asserted that evidence thresholds and correction
strength are independent decisions. The shipped control
`boundary_strength_offset` offsets the index used for `alpha` AND `tc0` - one
knob moving both. The project's own live specification refuted the argument.

IF YOU ARE ABOUT TO INVENT A DISPOSITION CATEGORY, STOP. There are FIVE, and
there will only ever be five: CURRENT-UNIQUE, CURRENT-DUPLICATE, CONFLICTING,
SUPERSEDED, OPERATIVE-SPEC. W3D wrote "SUPERSEDED-IN-FORM, CURRENT-IN-
SUBSTANCE" and thereby assumed its own conclusion. Anything you INFER rather
than FIND goes in the separate derived-proposition field, marked as inference
(DEC-23).

If you are about to mark a coder finding as a settled decision, stop. Only W3X
ratifies. You propose; W3X decides. A finding is a candidate until ratified.

If you are about to close a measurement-gated question by argument, stop.
The immediate example is D4-Q14: B2-versus-D viability must come from the
predeclared ground-truth experiment, not from defending the preferred
architecture. Later examples include Schedule-SA/Schedule-SB and proper-chroma
quality. Once an item is measurement-gated, more argument is not progress.

If you are about to approve a scope or delivery that would let pixel or copy
code pass before the relevant filter's ReleaseSafe scalar oracle exists, stop -
UNLESS it is the first Stage 2C/2D oracle-CONSTRUCTION scope, which is the sole
exception (section 3.7). For every later scope, nothing that produces or copies
pixels passes acceptance before the oracle can diff it, per-type.

If you are about to let "settled by design" read as "proven by measurement",
stop. Keep the two states visibly distinct in every document. Proper chroma is
the standing example.

If you are about to restore "float bit-identity", "FMA excluded", or a "bespoke
feature closure", stop. The model is named psABI levels in full, integer
byte-exact, float differential within tolerance (section 3.6). That wording is
superseded and dangerous to reintroduce.

If you are about to bump a document version, propagate it everywhere: filename,
internal version, and every load-bearing cross-reference. Prefer de-versioned
"see that document" citations for INCIDENTAL cross-references so they do not
cascade; keep only genuinely load-bearing pins exact (the charter companion pin;
the coder/designer charter-verification items). Silent version or cross-
reference drift is the failure mode that has bitten this project more than once
and that you are best placed to catch.

If you are about to treat every member of a read-together set as controlling,
stop. Charter 2.3a requires complete-set reading; it does not erase each
document's declared authority.

If you are about to change criteria that will be applied to your own work, stop
and apply I7: name the proposer, name a DIFFERENT independent verifier, and keep
W3X's adoption authority explicit. Never silently absorb the change.

If you are about to write a scope, quote the controlling README and charter
sections it relies on IN FULL, inline. The coder is memoryless and works from
what the scope contains, not from what the attached spec merely includes.

If you are about to accept a claim about existing code without a file:line
check, stop. That is the exact move whose absence produced this project's
quality.
```

---

# 6. Classification of open threads - keep these classes distinct

The highest risk is confusing "ratified architecture candidate" with "quality
proved" or "fallback" with "must ship". Use v1.05's D4-Q/D4-D registers as the
source of truth. Current compact classification:

## 6.1 SETTLED / RATIFIED

```text
- whole interleaved-frame MPEG-2 input; no SeparateFields contract
- three source-mode semantics; TFF/BFF irrelevant to block geometry
- H.262 4:2:0 Case-(a) chroma frame organisation; 4:2:2/4:4:4 follow luma
- vertical luma edges geometry-invariant at x=8k
- scheduler/kernel separation; detector is an unmodified-source pre-pass
- no hidden temporal state in v1; per-call scratch under fmParallel
- Deblock4 owns its maths/oracle/fixtures/proof; nothing inherited from Classic
- Architecture A rejected; motion Architecture C rejected
- B2 primary candidate; D mandatory detector-free comparator/fallback candidate
- Q14 decision rule: B2 if viable, else D only if viable, else reopen
- Q14 chooses entry into kernel development, never "ships"
- calibration/held-out split and predeclared criteria for Q14
- v1 nominal-grid limitation; inherited shifted blockiness deferred
```

## 6.2 NEXT / MEASUREMENT-GATED

```text
- T1 CONSOLIDATION SWEEP - IN PROGRESS, and it comes before everything below.
  FOR THE CURRENT SUB-TRANCHE STATE READ Deblock4_T1_Resume_Brief SECTION 0a
  (latest version) - it is maintained for exactly this and this list is not.
  Current recoverable state: T1S01a5 covers authority sections 1-8;
  Classification Repair v1.1 is delivered and is the correction basis; the
  REWRITTEN T1S01a5 LEDGER is next. T1S01a5b (sections 9-13) is ratified as a
  later separate sub-tranche. NOTHING has yet been ratified into the authority
  document - ledger remedies remain proposals.
  KEEP POPULATIONS DISTINCT: frozen T1S00 historical survey = 47 documents /
  90 terms; current adjudication population = 41; current a5 search population
  = 46 files. T1/ and GAIS_investigations/ are excluded from current T1 search;
  GAIS_investigations/ is also excluded from adjudication.
  DO NOT TRUST A SUB-TRANCHE COUNT FROM ANY DOCUMENT BUT THE RESUME BRIEF.
- T1.1-MATHS mathematical inventory and gap table, running inside T1
- T8 provenance-gap closure exposed by T1. OPEN and sequenced AFTER T1 but
  BEFORE T5; it does not block T1/T2/T3.
- T5 detector/feature mathematics, frozen before held-out judgement and
  sequenced AFTER T8.
- T6 D4-Q14 experiment plan and execution, separately ratified after T5:
  per-MB truth, B2 false-confident rate, UNKNOWN/confidence statistics, and D
  false-candidate/true-edge separation.
- actual FRAME/FIELD mixture prevalence in target footage (not inferred solely
  from frame_pred_frame_dct=0)
- viability of B2 and D under predeclared held-out criteria
```

## 6.3 OPEN AFTER Q14 / KERNEL-SCOPE OR QUALITY WORK

```text
- detector mathematics and thresholds if B2 survives
- D4 kernel mathematics and independent scalar oracle
- UNKNOWN-policy revisit using Q14 data
- processing Schedule-SA vs Schedule-SB quality choice
- proper-chroma quality validation and chroma vertical-siting/tap question
- public parameter/diagnostic property redesign; retire legacy old-A names
- grid origin/crop guidance and exact production bounds proof
- later D4 v2/v3 SIMD differential work only after scalar oracle acceptance
```

## 6.4 DEFERRED

```text
- inherited motion-shifted blockiness beyond nominal grid
- trusted per-MB side data if a future source/decoder exposes it
- automatic strength/grid analysis, QED variants, broader codec-specific work
- float path and its measured tolerances under its future bounded scope
```

## 6.5 REJECTED / DO NOT RESURRECT WITHOUT NEW EVIDENCE

```text
- separated-field MPEG-2 Architecture A / midpoint-union mechanism
- motion-based Architecture C
- hidden cross-frame detector hysteresis under fmParallel
- forced rule "if B2 fails, D ships"
- GAIS as factual authority
- Classic code/proofs/thresholds as Deblock4 acceptance basis
```

Keep the project-wide settled infrastructure decisions (named psABI tiers,
G5/G6, per-type differential model, oracle-construction exception, delivery
rules) in their normal authorities rather than duplicating them here.

# 7. What may not be fully written down

Verify rather than assume:

```text
1. Highest current charter/README/status/roadmap filenames and internal versions.
2. MPEG-2 authority v1.05 is W3X-ratified and records that status in its own
   header. A package containing only v1.04 with W3X-PENDING wording is stale;
   ask W3X for v1.05 rather than inferring ratification from conversation.
3. Exact Q14 experiment-plan generation and corpus/truth-extraction tooling.
4. MediaInfo is only picture-level regime triage; per-MB dct_type requires the
   dedicated ground-truth path.
5. LG XP/SP/LP/EP adaptive-capable measurement does not by itself establish the
   prevalence of actual mixed dct_type macroblocks.
6. No D4 kernel scope exists until Q14 reports and W3X ratifies the next step.
7. Existing Stage-1C `mpeg2_field_separated`, midpoint/step properties and
   related creation plumbing are legacy source debt awaiting bounded redesign.
8. Any new self-affecting acceptance criterion must satisfy I7 and name an
   independent verifier.
9. Any new claim from external research must be independently verified before
   it enters project knowledge. During T1, GAIS_investigations/ is ignored for
   search and adjudication; do not use it as a shortcut around that rule.
```

These are checks, not invitations to reopen settled decisions.

# 8. First response expected from you

Before producing design work, give W3X a compact orientation check:

```text
1. Exact current document filenames/internal versions and authority classes.
2. Confirm Project Status (HIGHEST COMMITTED VERSION) section 0 and MPEG-2
   authority v1.05 section 0 were read first. NOTE the authority is still at
   v1.05 deliberately - no adjudication has been applied to it; if you see a
   higher generation, ask W3X what was ratified.
3. Current state: Classic 2C/4C/5C plus M1/M2 complete; identity +5C;
   deblock4.Deblock4 has NO kernel and is the active workstream.
4. Current architecture: B2 primary candidate, D mandatory comparator/fallback,
   A/C rejected; no hidden temporal state; own Deblock4 oracle.
5. Immediate designer action: THE T1 CONSOLIDATION SWEEP, unless W3X directs
   another bounded task. For the current sub-tranche and what is owed, read
   Deblock4_T1_Resume_Brief section 0a - IT PREVAILS OVER THIS CHECKLIST AND
   OVER EVERY STATE SUMMARY IN THIS DOCUMENT. It is bumped as the sweep state
   advances; this document is not. If they disagree, the brief is right and
   you should tell W3X this document has staled.
   CURRENT ENDPOINT: a5 ledger v1.7, 42 entries, delivered and awaiting a W3C
   DELTA REVIEW of v1.6 -> v1.7. The rewrite this document previously named as
   the next designer act HAS HAPPENED. Not another search round, and not
   another Tier C sample.
   EXPECT LEDGER VERSION NUMBERS TO MISLEAD YOU: later generations have often
   represented method/framing repairs rather than a changed technical result.
   Use delivered artifacts and the Resume Brief; do not invent an undelivered
   working generation from old status prose.
   AFTER T1: T8 closes provenance gaps named by T1; THEN T5 detector/feature
   mathematics is issued and ratified; THEN T6/Q14 planning follows as a
   SEPARATE ratification. THE ONE-COORDINATED-T5+T6-PACKAGE PERMISSION IS
   WITHDRAWN - do not propose one. T5 must be frozen before any held-out
   judgement. T6 must use per-MB truth, predeclared metrics,
   calibration/held-out separation, and evaluate B2 AND D honestly.
6. State the no-forced-fallback rule: B2 viable -> may enter kernel development;
   else D only if viable; else architecture reopens. Nothing "ships" at Q14.
7. State the LG target-device measurement precisely: adaptive-capable regime is
   normal in XP/SP/LP/EP; actual mixed-macroblock prevalence remains to measure.
7a. TWO PROCESS RULES CAME OUT OF T1 AND BOTH BIND YOU FROM YOUR FIRST
   DELIVERABLE. FIRST, A CLAIM THAT A CHECK WAS PERFORMED must identify the
   population examined and the basis, in a form another party can test:
   enumerate for a bounded set, range, overlap or coverage check; use the
   method appropriate to other checks; invent no line range where none
   exists; and never write a bare assurance like "the set was swept". The
   designer wrote precisely that assurance into a ledger, not having done it,
   one sub-tranche after committing the same failure. SECOND, AFTER
   REPLACING A REJECTED FORMULATION, declare the replacement scope, search by
   the method appropriate to the PROPOSITION rather than the string, and
   enumerate and classify what you find as live or historical - do not report
   the replacement complete from the edited location. Three consecutive
   rounds died on a correction landing in its target field while the
   surrounding framing still argued the rejected position, and that framing
   is usually the part that tells the reviewer what to think.
   AN ENUMERATION WRITTEN FROM MEMORY OF WHAT YOU EDITED IS THE SAME
   ASSURANCE IN A LONGER FORM. The distinction that matters is SEARCHING
   versus REMEMBERING.
8. Apply I7 to any criterion you propose that judges your own work, and retain
   the W3X/W3D/W3C separation of design, implementation, execution and acceptance.
9. Report any stale pointer, missing input or ambiguity before issuing scope.
```

Do not re-summarise every historical document. Demonstrate that you know the
current architecture, why it is measurement-gated, and what evidence would
falsify the preferred candidate.

# 8b. Revision note

```text
v1.30 (2026-08-19) RECOVERY/CURRENCY PASS after the immediately preceding W3D
      designer chat reached its session/context limit. Fixes the filename /
      internal-version mismatch (v1.29 filename carried Version 1.28). Routes
      precise live state to Resume Brief v1.11 and advances the recoverable a5
      endpoint: Classification Repair v1.1 delivered; rewritten T1S01a5 ledger
      NEXT; no new 22-probe search round. Separates the frozen 47-document
      T1S00 survey record from the current 41-document adjudication population
      and 46-file a5 search population; records DEC-66 GAIS exclusion from T1
      search/adjudication; records the live downstream sequence T1 -> T8 -> T5
      -> separately-ratified T6/Q14; and removes live wording that treated raw
      GAIS as a T1 reasoning source. No architecture or acceptance decision
      changed.
v1.29 Adds section 4a: the three sweep method rules ratified during T1S01a5
      (open every hit; normalise whitespace; search the proposition, not the
      sentence, in W3C's bounded form), and the harder lesson that opening a
      hit is not reading it. Records the search-population rules - retired
      trees, all of T1/, and GAIS_investigations/ excluded, giving a 46-file
      SEARCH population distinct from the 47-document ADJUDICATION
      population. Also ratified since v1.28: SUPERSEDED split by kind with a
      propagation search (DEC-64), task T8 opened for provenance gaps
      (DEC-65), and the T1S01a5 / T1S01a5b split. No architecture or
      acceptance decision changed.
v1.23 Loss/sequence audit after v1.22. Added the live T-series register to the
      resume path; reconciled the dying-W3D shorthand "T6 next" with the task
      dependency by making T5 detector mathematics the first design subtask
      (or first frozen part of one T5+T6 package); made W3C independent
      cross-check of T5/T6 explicit; advanced the authority pointer to v1.05.
      No architecture or acceptance decision changed.
v1.22 Reconciled the designer handover to Project Status v1.28 and W3X-
      ratified MPEG-2 authority v1.05. Fixed title/internal-version mismatch;
      removed Stage-5C-next and old field-separated/midpoint-current guidance;
      replaced MPEG-2 reading authority with v1.04; condensed stale MPEG-2
      reasoning into authoritative pointers; rewrote the open-thread buckets and
      first-response block around B2/D and Q14; recorded the ratified no-forced-
      fallback and held-out/calibration rules; and preserved the LG adaptive-
      capable target-device fact without overstating it as observed per-MB mix.
      No independent algorithm change in this intro.
v1.13 Reconciled the successor orientation to the prevailing 2026-08-01
      package: charter v1_23 + I7 +
      continuity-bearing W3D role; decisions v1_10; status v1_16; Phase 3a
      Designer Briefing v1_2 at its actual root path; Phase 3a delivery v1_0
      produced and awaiting review/validation/acceptance. Corrected the review
      set from falsely all-controlling to mixed authority, corrected the
      creation-callback "body unchanged" shorthand to the ratified narrow ABI/
      trace allowance, recorded the unrestructured switch/C5/anti-stall 3a->3b
      boundary, added I7 guidance, and flagged the charter/coder/status metadata
      still needing separate reconciliation. No design change.
v1.12 Added the Phase 3a review-set trio to the reading list as item 11 (scope
      v1_5 + addendum v1_1 + the new Phase 3a Designer Briefing v1_0), flagged
      as a charter-2.3a version group that must be read together with the
      latest of each member prevailing. Bumped the charter pin v1_21 -> v1_22
      (2.3a generalised to sets) and the coder-intro ref to v1_18.
v1.11 Added the standalone STOP-class subsection "Version currency and paired
      documents" at the top of section 2, and a first-response gate item 2a
      (confirm with W3X that no newer package supersedes and no paired versions
      mismatch). Bumped the charter pin v1_20 -> v1_21 (which adds the
      governing section 2.3a). No design change.
v1.10 Status advanced to the frozen handoff point: Phases 1 and 2 accepted and
      committed; the immediate action is reviewing the incoming
      Phase_3a_W3C_delivery_v1_0.zip (with the three named 3a verification
      points). Bumped reading-list refs to Project Status v1_15, Forward
      Roadmap v1_13, and delivery addendum v1_1. No design change; status
      currency for the designer-chat handoff.
v1.9  Added the charter C-DELIV-09 incremental-emission awareness for the
      reviewer role (W3C emits increments then re-packages one final
      deliverable; hold formal acceptance for the package; only delivered work
      survives an interruption). Bumped the controlling charter pin
      v1_19 -> v1_20.
v1.8  Stage 1C position advance + prevailing-source alignment. Immediate
      designer action retargeted from "author the filter-creation scope when
      W3X asks" to "review W3C's Stage 1C Phase 2/3 deliveries" (the scope is
      authored, ratified v1_5, and Phase 1 is accepted). Status pointers,
      dispatch-idiom phrasing, the implementation-spikes list, and the
      first-response block advanced to Stage 1C. Added the Stage 1C scope
      v1_5 and delivery addendum v1_0 to the reading list (items 11/11a,
      CONTROLLING) and bumped the coder-intro pin to v1_14. No design or rule
      change; the design line is unchanged.
v1.7  Coder-review corrections: fixed the line-break-split "future 1B.3
      dispatch table" phrase that a single-line replacement missed (now
      "filter-creation-stage dispatch wiring" - the v1.6 revision note's claim
      to have removed it was premature); completed-stage tense corrections
      (CONFIRMS -> CONFIRMED; FMA expectation to past tense); added the roadmap
      to the reading list for package consistency; cross-pins advanced to the
      new generation (status v1_14, coder v1_13, roadmap v1_12). Version bumped
      per immutable-version discipline.
v1.6  Full reconciliation: the v1.5 pass advanced the headline sections but left
      several later passages stale. This pass fixed the reading-list charter pin
      (v1_16 -> v1_19), replaced the non-exact "(latest version)" reading-list
      forms with exact filenames, rewrote the "Stage 1B.3 will follow / future
      1B.3 dispatch" phrasings (dispatch is now filter-stage work consuming the
      EFFECTIVE record), moved 1B.2/1B.3 out of the unresolved implementation-
      spike list into settled material, and replaced the obsolete "1B.3 delivery
      awaits review / coder chat died" handover note with the accepted-and-
      committed state.
v1.5  Refresh after Stage 1B.3 COMPLETE and committed. Charter pin v1.17 ->
      v1.19 (v1.18 recorded the 1B.3 ratifications; v1.19 the CRLF rule).
      Current position advanced: 1B.3 done, its full proof matrix verified at
      the instruction/byte level; immediate action changed from "review the
      1B.3 delivery" to "author the filter-creation scope". Added the settled-
      detection-contract lesson and the captured-output findstr lesson from the
      1B.3 harness rounds.
v1.4  Refresh after Stage 1B.2 completion and the Stage 1B.3 scope/delivery
      round. Charter v1.16 -> v1.17 (adds G10, the debug-only inclusion
      pattern). Current position advanced: 1B.2 complete and committed; 1B.3
      scoped at v1.3 (resolving W3C reviews B1-B7/P1-P3 then R1-R5) with a
      first W3C delivery in hand awaiting designer review. Immediate action
      changed from "author 1B.2 scope" to "review the 1B.3 delivery". Added
      the G10 three-layer debug-inclusion lesson alongside the 1B.1 export
      lesson. Noted the 1B.3 coder chat died post-delivery.
v1.3  Major reconciliation to the current package (charter v1.10 -> v1.16,
      README v1.2 -> v1.9, plus the decisions record v1.9). Corrected the two
      most dangerous stale reversals: (a) the tiering/float model - replaced
      "FMA excluded from AVX2" and "scalar == SSE4.1 == AVX2 bit-exact float"
      with the NAMED psABI levels used in full + per-type contract (integer
      byte-exact, float differential within tolerance, structural exact); (b)
      added the two-filter Classic-first architecture (reasoning 3.1) and the
      Deblock4-only scope of proper chroma. Added the oracle-construction
      exception (3.7) and removed the circular oracle rule. Reframed Stage 1B.2
      as within-level confirmation (not "feature-closure spikes") and added the
      1B.2/1B.3 boundary. Added OSXSAVE membership vs runtime XGETBV/XCR0.
      Updated the SETTLED/REJECTED buckets accordingly (universal float identity
      and FMA exclusion moved to REJECTED; two-filter and named tiers added to
      SETTLED). Added the decisions record and backend-objects explainer to the
      reading order. Recorded the owed HolyWu-oracle pin (D-CLASSIC-4) and the
      SHA-256 clarification (controlling identity = filename+version; SHA-256 is
      a reviewer convenience). Added the no-package-mixing and de-versioning
      guidance to the version-drift hazard.
v1.2  Stage 1B.1 complete; charter v1.9 -> v1.10 and README v1.1 -> v1.2.
      Rewrote reasoning 3.8 for the corrected G6 corollary (the ban is on
      PE-EXPORT, not the export keyword) with the three falsified mechanisms
      named. Added Deblock4_Toolchain_Findings to the reading order, added
      1B.1 and the @extern anchor mechanism to SETTLED, and removed the
      resolved retention crux from SPIKES. Stage 1B.2 is now active.
v1.1  Updated from v1.0: charter v1.8 -> v1.9 (adds G6); milestone to
      1A.1-complete; 1B.1 active at scope v1.3; added the retention/export
      research package and the MPEG-2 grid/field-DCT knowledge document to the
      reading order; added reasoning 3.8 (G6/no-export) and 3.9 (three DCT
      regimes, midpoint machinery, measured LG behaviour); added G6, the DCT
      regimes, and 1A.1 to the SETTLED bucket; added the forceUndefinedSymbol
      retention crux to the SPIKES bucket.
```

# 9. A note on why this handover matters

The designer seat is where the project's judgement lives. The coder implements a
bounded scope; you guard the whole line. A weak designer handover is therefore
more dangerous to the project than a weak coder one - a confused coder produces a
failing build that W3X catches, but a confused designer can quietly approve a
wrong decision, relax an invariant, or let a measurement question be settled by
argument, and those errors propagate.

The way to be a good successor is not to be clever or to improve the design. It
is to hold the line that is already drawn: verify against source, keep the fact
classifications distinct, make W3X the decider, and doubt smooth agreement -
including your own.

---

*This file preserves designer-session orientation and durable process reasoning.
It is not an algorithm specification, an invariant source, or a coding scope.
The charter prevails on global rules; the W3X-ratified MPEG-2 authority prevails
on MPEG-2 design/architecture; other current controlling/binding documents
prevail in their own domains.*

---

# Revision note addendum

v1.28 (2026-08-18) ROUTING AND LESSONS PASS; no version pin changed, because
v1.27 had already de-pinned them and a search confirmed only the deliberate
MPEG-2 authority pin remains live.
     ROUTING: the resume brief's section 0a is now stated to PREVAIL over
     this checklist and over every state summary in this document, with the
     reason - the brief is bumped as the sweep advances and this document is
     not - and with the instruction to report a disagreement as staleness.
     STRUCTURE: section 6.2 no longer names a fixed sub-tranche count. It
     states the structure and warns that it has already been extended once,
     when the authority's BODY turned out to have been assigned to unnamed
     "later sub-tranches" and nothing had picked it up.
     LESSONS: new checklist item 7a carries the two rules T1 produced - a
     claimed check must name its population and basis, and a replacement must
     declare its scope and enumerate what was found - together with the
     observation that an enumeration written from memory is the same
     assurance in a longer form.
     Also warns that ledger version numbers mislead: four and five versions
     with the technical result unchanged from v1.0.
     No rule, tier, acceptance criterion or design statement changed.
