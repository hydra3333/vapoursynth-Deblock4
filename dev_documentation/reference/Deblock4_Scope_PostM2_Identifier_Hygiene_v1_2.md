# Deblock4 - Scope - Post-5C Maintenance M2 - Identifier Retirement and Historical Batch Retirement

**Deliverable:** W3D-M2-SCOPE (W3X-RATIFIED)
**Version:** 1.2
**Date:** 2026-08-16
**Author:** W3D (designer)
**Route:** W3D -> W3X (ratified) -> W3C
**Base:** the committed Stage 5C tree plus accepted M1, identity 0.1.0-dev+5C,
confirmed with W3X per C-DELIV-01. No commit hash.
**Authority set:** charter v1_29 or later PREVAILS (note C-STY-10, C-DELIV-09);
D0 Binding Knowledge Index v1_14 (note K30, K16, K23, K26); Project Status
v1_27 (which CARRIES the 2026-08-12 W3X CLEAN UP ruling this scope executes);
Documentation Currency Audit v1_4.
**Status:** W3X-RATIFIED 2026-08-16. The mandatory discovery round is
COMPLETE and its outcome is RATIFIED (section 6a). IMPLEMENTATION IS RELEASED.
**Encoding:** US-ASCII; CRLF.

**Incremental emission (charter C-DELIV-09) - standing reminder:** When this
scope/phase is large enough that withholding all output creates a material
interruption or review-continuity risk - normally multiple modules or more
than a few files - W3C EMITS complete modules or small coherent groups as they
are finished, each marked "increment N of ~M: <what>" (~M is an estimate and
may be revised). Each increment is a complete, self-identifying recovery and
review artifact against the stated base; it need not be independently
applyable. ONLY EMITTED ARTIFACTS SURVIVE an interruption: the recoverable
state is the last complete emitted increment(s); the current incomplete
increment AND any later un-emitted integration, reconciliation, validation, or
revision work may be lost, and earlier increments may be superseded by later
integration. W3C does not claim to preserve or resume un-emitted internal
work. The increments do NOT replace the final deliverable: at scope/phase end
W3C rebuilds and re-packages the complete integrated work against the
authoritative base as one deliverable of record meeting C-DELIV-01..08 in
full, validated as a whole - merely concatenating increments is not proof of
integration. W3X ordinarily applies only the final package, unless W3X
explicitly directs otherwise.

---

# 0. KNOWLEDGE SWEEP (standing, two-sided - D0 section 6.1, verbatim)

```text
KNOWLEDGE SWEEP (standing, two-sided): Before implementation, W3C must
independently search the committed documentation set (excluding
superseded/) for relevant non-superseded, non-withdrawn knowledge,
rules, or decisions bearing on this scope, WITHOUT starting from the
checklist below, and report as numbered findings anything relevant that
the checklist or the Stage 2C+ Binding Knowledge Index does not carry.
Withdrawn alternatives are reportable only as do-not-revisit
confirmations. W3D verifies; confirmed items become new index K-numbers;
W3X adopts any scope amendment.
```

# 1. Provenance of this version - two W3D defects, both W3C-found

```text
M2 v1.0 contained two W3D errors, both raised by W3C and both upheld.
They are recorded here rather than quietly corrected.

DEFECT 1 - a ratified ruling was presented as an open choice.
  Project Status (v1_26 section 0, carried into v1_27) records:
  "identifier-cleanup: W3X RULED 2026-08-12 -> CLEAN UP", registered as
  its own bounded future scope, with binding cautions that it be a
  COORDINATED ATOMIC rename across source symbols, gate-asserted PASS
  tokens, batch assertions and expected-output captures, followed by a
  full proof-matrix re-run. W3D surveyed the SOURCE TREE thoroughly but
  failed to sweep the DECISION RECORD, and offered W3X options A/B/C -
  inviting W3X to unknowingly reverse its own ruling. W3X confirmed
  2026-08-16 that the ruling stands. This scope executes it.

DEFECT 2 - the mandatory C-DELIV-09 scope-header block was omitted.
  Charter C-DELIV-09 (v1.25+) requires the current reminder block
  copied verbatim into every scope issued henceforth. W3D omitted it
  from BOTH the M1 and the M2 v1.0 scopes. It is present above. The M1
  omission is recorded in the currency audit as a process defect; it
  was not material to M1's proof (M1 was two files, comments only), but
  it is not excused by that.
```

# 2. Mission

```text
Retire stage-bound vocabulary from permanent contracts, and retire the
superseded historical batches, as ONE atomic maintenance change to the
LIVE proof surface. Two joined jobs:

  JOB A - RENAME. The Stage 1C identifier cluster in
  src/deblock4_selftest.zig asserts what is in fact the standing
  SELECTION AND CREATION contract - auto and explicit selection,
  above-effective refusal, unknown-token refusal, Classic and Deblock4
  validation, invalid-call refusal. None of that is stage-bound; all of
  it is as live at 5C as at 1C. The names, and the emitted gate token,
  become intent-describing.

  JOB B - RETIRE. build_1C_v1.bat, build_2C_v1.bat and build_4C_v1.bat
  are DELETED, together with genuinely orphaned tooling, and the two
  live audit scripts that reference build_1C_v1.bat are AMENDED so the
  S2 and S3 gates stay meaningful.

NO FILTER BEHAVIOUR CHANGES. No arithmetic, no dispatch, no selection
logic, no threshold, no vector path.
```

# 3. Why the historical batches are DELETED, not repaired (the evidence)

```text
This is not tidiness. Two findings drive it.

FINDING 1 - THEY ARE SUPERSEDED, NOT MERELY UNUSED. build_5C_v1.bat
re-executes the earlier surfaces. Its own retained summary artifact
(zig-out/inspection_5C/proof_matrix_summary.txt, from the accepted 5C
run) reads:
    STAGE1_REEXEC B1 B2 G1 G2 E1 E2 E3 E4 E5 E6 V1 S1 S2 S3 N1 PASS
    STAGE2_D3_O_G K31 S5 PASS H0_H6=NOT_RERUN_2C_HISTORY
    STAGE4C_REEXEC T1 T2 T3 T4 T5 P3 K30 K31 PASS
    STAGE5C T1 T2 T3 T4 T5 T6 K30 K31 PASS
The one documented exception, H0_H6, is the 2C HolyWu external-reference
arc, which K26 already rules 2C EVIDENCE HISTORY that the live matrix
never re-runs. So the older batches prove nothing the live batch does
not, except an arc already ruled historical.

FINDING 2 - THEY ARE STALE BY CONSTRUCTION AND CANNOT PASS TODAY. W3D
verified against the committed build_4C_v1.bat:
    line 413  for %%C in (n02b) - the gate expecting explicit v3 to be
              REFUSED. Stage 5C made that false by design; this is the
              identical defect W3D-5C-F1 removed from the 5C batch.
    line 438  asserts "reason=intentionally-capped(x86_64_v2_with_sse41)
              actual=x86_64_v3_with_avx2" - an expectation the 5C
              ceiling raise permanently invalidated.
Repairing such gates would mean editing accepted artifacts so they can
run for a purpose that no longer exists, and would INVITE future
execution of gates whose premises later stages deliberately inverted. A
gate that cannot pass is worse than no gate: nobody discovers it until
someone runs it.

CONCLUSION: delete, and RECORD the deletion with its reason. The files
remain in prior commits, which is the correct home for a historical
record. W3X ruled this 2026-08-16.
```

# 4. Authorised surface

```text
JOB A - RENAME (identifier/token/label surface only):
  MOD  src/deblock4_selftest.zig   the identifier cluster and the
                                   emitted token ONLY
  MOD  build_5C_v1.bat             the matching assertions AND the
                                   human-readable gate labels
                                   (W3X-authorised 2026-08-16)

JOB A extension - RATIFIED FROM DISCOVERY (DQ4, C2):
  MOD  tests/stage_2c_classic_obligations.vpy
       (i)  DELETE the n02a and n02b case branches (lines 484 and 487 in
            the base). Both expect "requested backend is not available in
            this build" - n02a for v2, n02b for v3. BOTH PREMISES ARE NOW
            FALSE: 4C implemented v2 and 5C implemented v3. Neither is
            invoked by build_5C_v1.bat, which is the ONLY reason they do
            not fail today. A dormant fixture whose premise a later stage
            deliberately inverted is a trap: this is the identical defect
            class as W3D-5C-F1, which cost a full validation run.
       (ii) UPDATE the two stale caller comments (base lines 10-14) which
            describe build_4C_v1.bat and build_2C_v1.bat as the invoking
            batches. Comments only; confined to those lines; no other
            wording in the file.
  MOD  tests/Deblock4_Stage_2C_D3_v1_10_O_G_to_Test_Crosswalk.md
       [DQ1 - THIS FILE IS LIVE PROOF SURFACE, NOT PROSE. W3D verified:
        build_5C_v1.bat loads it at line 98, ABORTS if absent at line 112,
        and gates the presence of 45 obligation IDs at line 1028 -
        including T-S5-1a, T-S5-2, T-S5-3, T-S5-4, T-S5-5 and H0-H6.]
       Correct ONLY the rows the deletions and Stage 5C falsify, so the
       map describes the CURRENT proof surface or states plainly that a
       row is history:
         T-S5-1a  remove n02a/n02b as current count-1 proof
         T-S5-2   "intentionally capped auto" -> the current n04 position
                  (auto reaches implemented v3; the cap line is asserted
                  ABSENT)
         T-S5-3   build_2C_v1.bat -> build_5C_v1.bat
         T-S5-4   n02a/n02b/n03 -> n03 only (the live refusal case)
         T-S5-5   build_2C_v1.bat -> build_5C_v1.bat
         H0-H6    tools/holywu_reference/... -> marked EVIDENCE HISTORY
                  per K26 and the live summary's NOT_RERUN_2C_HISTORY
       EVERY obligation ID gated at batch line 1028 MUST still be present
       after the edit, or the D3 crosswalk audit fails. Removing a row is
       NOT authorised; only its description changes.

JOB B - RETIRE:
  DEL  build_1C_v1.bat
  DEL  build_2C_v1.bat
  DEL  build_4C_v1.bat
  DEL  tools/stage_4c/run_stage_4c_differential.cmd
  DEL  tools/stage_4c/stage_4c_scalar_v2_diff.py
       (superseded by tools/stage_5c/; the live batch's 4C-regression
        leg calls the STAGE 5C runner, not these)
  DEL  tests/stage_1c_classic_passthrough.vpy   [DQ3 RATIFIED]
       Sole live caller was build_1C_v1.bat (W3D-verified). Classic proof
       now runs through tests/stage_2c_classic_obligations.vpy.
       DO NOT CONFUSE with tests/stage_1c_deblock4_passthrough.vpy, which
       build_5C_v1.bat calls repeatedly and which MUST STAY.
  DEL  tools/holywu_reference/  (the whole directory: README.md,
       build_holywu_r9_scalar.cmd, reference-build-record-schema.json,
       run_stage_2c_holywu_reference.cmd, stage_2c_holywu_diff.vpy)
       [DQ5 RATIFIED] No live caller once build_2C_v1.bat is deleted;
       K26 rules the arc pinned external-oracle EVIDENCE HISTORY; the
       accepted 5C summary records H0_H6=NOT_RERUN_2C_HISTORY.
       ORDER: the crosswalk H0-H6 row is corrected BEFORE this deletion.
  MOD  tools/audit_stage_1c_s3_eol.ps1    [DQ2 RATIFIED - REPLACE, do
                                          NOT merely remove]
       Line 2 becomes:
         $rootFiles=@('build.zig','build.zig.zon','build_5C_v1.bat')
       W3D verified WHY replacement is required, not optional: the script
       enumerates via git ls-files and admits root files ONLY through this
       explicit list ($prefixes covers src/, tests/, tools/, third_party/
       but no root file). Merely removing build_1C_v1.bat would leave NO
       root proof batch in the CRLF/US-ASCII audit domain - while M2
       itself edits build_5C_v1.bat and M2-T7 demands that very property.
       Removal would silently shrink an audit; replacement preserves its
       intent and points it at the live runner.
  MOD  tools/audit_stage_1c_s2_sweep.ps1  TWO edits:
       (i)  remove the now-pointless line-23 skip of build_1C_v1.bat (its
            $roots are directories plus build.zig/.zon, so root batches
            were never in its domain - the skip is already dead);
       (ii) [W3D-M2-F2 RATIFIED] ADD the M2-deleted paths to the
            hardcoded RETIRED-FILE list at line 1, which already fails
            the gate if any of backend_probe_*.zig, dll_probe.zig,
            build_probe.zig and their siblings reappear. That list is the
            PROJECT'S ESTABLISHED PATTERN for retirement: delete, then
            assert the deletion stays. Add build_1C_v1.bat,
            build_2C_v1.bat, build_4C_v1.bat,
            tools/stage_4c/run_stage_4c_differential.cmd,
            tools/stage_4c/stage_4c_scalar_v2_diff.py,
            tests/stage_1c_classic_passthrough.vpy and the
            tools/holywu_reference/ members. Retirement then becomes
            ENFORCED rather than merely performed, and accidental
            resurrection is impossible.
            CAUTION: that script also scans live files for the retired
            BASENAMES and fails on a match. The crosswalk and the .vpy
            comments are being edited in this same delivery precisely so
            they no longer name the retired batches - sequence the edits
            so no surviving live file mentions a newly retired basename,
            or the S2 gate will correctly fail. This interaction is the
            single most likely way M2 self-trips; handle it deliberately
            and report it if it bites.
  These two .ps1 files are LIVE proof machinery executed by the S2 and
  S3 gates. They MUST be corrected in the SAME atomic delivery. A
  deletion that leaves S3 pointing at a missing file, or S2 skipping a
  file that no longer exists, silently disables an audit - the same
  defect class as a stale gate.

  RETAINED, NOT DELETED (discovery class (c), W3X-confirmed): the manual
  root developer utilities make_blocky.bat, dump_mpeg2_info_01.bat and
  000-SET_USER_PATH_PERMANENTLY.BAT. Zero static callers does NOT prove
  orphaned for hand-invoked tools, and the first two support MPEG-2 and
  blockiness inspection likely wanted for later Deblock4 work.

BYTE-FROZEN: everything else. In particular all four frozen Classic
units, both backend objects, build.zig, every .vpy, tools/run_vs.cmd,
tools/stage_5c/*, and the two remaining audit scripts.

NOT AUTHORISED: any filter-behaviour change; any module filename change;
any rename inside the frozen Classic units; removal of the historical
PE-export exclusion tripwires (deblock4_backend_probe, deblock4_dll_probe)
which assert ABSENCE by design and MUST stay.
```

# 5. The ratified naming (M2-N series)

```text
M2-N1  fn runStage1CPureContracts        -> runSelectionAndCreationContracts
M2-N2  error.Stage1CAutoSelectionFailed  -> error.SelectionAutoFailed
M2-N3  error.Stage1CExplicitSelectionFailed
                                         -> error.SelectionExplicitFailed
M2-N4  error.Stage1CAboveEffectiveWasAccepted
                                -> error.SelectionAboveEffectiveWasAccepted
M2-N5  error.Stage1CUnknownBackendWasAccepted
                                -> error.SelectionUnknownBackendWasAccepted
M2-N6  error.Stage1CClassicValidationFailed
                                -> error.CreationClassicValidationFailed
M2-N7  error.Stage1CDeblock4ValidationFailed
                                -> error.CreationDeblock4ValidationFailed
M2-N8  error.Stage1CInvalidCallWasAccepted
                                -> error.CreationInvalidCallWasAccepted
M2-N9  EMITTED TOKEN  stage_1c=PASS
                     -> selection_and_creation_contract=PASS
       W3X-ratified 2026-08-16 on W3C's Q3: the selftest proves BOTH
       halves, so the shorter selection_contract=PASS that W3D first
       proposed was narrower than the contract it marks.
M2-N10 HUMAN GATE LABELS in build_5C_v1.bat, e.g. "selftest retained
       Stage 1C section" -> an intent-describing label such as "selftest
       selection and creation contract". W3X AUTHORISED the label
       surface 2026-08-16; leaving stage-numbered labels beside renamed
       tokens would recreate the confusion at one remove.

The exact spellings above are NORMATIVE. W3C does not vary them; if any
reads wrongly, report it rather than adjusting silently.
```

# 6. MANDATORY DISCOVERY ROUND - before any edit or deletion

```text
D1  ENUMERATE THE OLD VOCABULARY UNIVERSE. Mechanically list every
    occurrence, with file and count, of each M2-N1..N9 old spelling and
    of every gate label tied to them, ACROSS THE WHOLE REPOSITORY.
    Establish the pre-change universe BEFORE editing, not while editing.
    Classify each occurrence as: live source emitter / live gate
    assertion / live gate label / historical documentation / to-be-
    deleted file.

D2  ORPHAN SWEEP - W3X EXPRESSLY REQUESTED, AND IT IS NOT LIMITED TO
    W3D's LIST. Sweep the repository for ANYTHING that becomes orphaned
    or broken by the section 4 deletions, and for anything else that is
    already orphaned and may have been missed - files, scripts,
    fixtures, directories, references inside .bat/.cmd/.ps1/.py/.vpy/
    .zig/.zon, build.zig steps, .gitignore entries, and documentation
    pointers to deleted paths. Report findings in three classes:
      (a) MUST be amended in this delivery to avoid breaking a live
          gate (the two .ps1 files are already known; report any more);
      (b) CANDIDATE for deletion as genuinely orphaned, each with the
          evidence that nothing live references it - explicitly
          including tools/holywu_reference/;
      (c) UNCERTAIN - report to W3X, do not act.
    W3C does NOT delete anything in class (b) or (c) in this round.
    W3X decides after W3D review.

D3  STALE-EXPECTATION NOTE. While sweeping, report any expectation
    surviving in build_5C_v1.bat (the batch that remains) whose premise
    a later stage has invalidated - the n02b/intentionally-capped class.
    W3D believes 5C cleared these, but a second pair of eyes on the
    batch that SURVIVES is worth more than one on batches being deleted.

D4  KNOWLEDGE SWEEP findings per section 0, or an explicit NIL.

No file is edited, created or deleted in this round.
```

# 6a. DISCOVERY ROUND OUTCOME - RATIFIED 2026-08-16

```text
W3C's discovery report (v1_0, 2026-08-16) is ACCEPTED. It did exactly what
section 6 existed to do: it found live-proof consequences BEFORE any edit,
including two that W3D's scope had missed (the live crosswalk, and the S3
audit-domain hole). Every source claim in it was independently W3D-verified
against the committed tree. Ratified outcomes are folded into section 4.

D1 CARDINALITY, established pre-change and now BINDING on M2-T2:
     stage_1c=PASS total 9 = 1 source emitter
                            + 2 live assertions (build_5C_v1.bat)
                            + 6 in the three batches being deleted.
     Gate labels: 6 "selftest retained Stage 1C section" (2 live) and
                  2 "selftest Stage 1C section" (in build_1C, deleted).
     REQUIRED POST-CHANGE: exactly 1 source emitter of
     selection_and_creation_contract=PASS, and exactly 2 live assertions
     of it in build_5C_v1.bat. Not "at least"; exactly.

D3 NIL, CONFIRMED: the SURVIVING batch carries no stale later-stage-
     inversion expectation. No n02b, no v3-unavailable assertion, no
     positive intentionally-capped expectation; the one occurrence is a
     deliberate NEGATIVE gate asserting that line is ABSENT, and n04
     expects tier=x86_64_v3_with_avx2. This was worth asking: the
     staleness was in the crosswalk and the .vpy, not the batch.

D4 NIL: no additional binding knowledge changes the M2 design.

DQ6 CLOSED NIL: W3X ran the check in the real repository 2026-08-16. The
     .gitignore references no deletion target. (Incidental, NOT M2 work:
     zig-out is ignored, so retained inspection evidence is not version-
     controlled - archive it outside the repo when a stage's evidence
     matters.)

W3D FINDINGS ADDED AT RATIFICATION (not in the W3C report):

W3D-M2-F1  ORDERING / GIT-INDEX INTERACTION - STATED SO IT IS NOT
     REDISCOVERED. tools/audit_stage_1c_s3_eol.ps1 enumerates with
     "git ls-files -co --exclude-standard", i.e. it reads the INDEX. After
     M2 deletes files from the working tree but BEFORE W3X commits, the
     index still lists them. W3D read the script: line 18 is
     "if(-not(Test-Path -LiteralPath $r)){continue}", so deleted files are
     SKIPPED, not errored. THE MATRIX RUN AFTER DELETION AND BEFORE COMMIT
     IS THEREFORE VALID. This is recorded because the project's standing
     rule is that the build/test loop never depends on git staging, and
     here a proof script's enumeration does read the index - a successor
     is entitled to know that was considered rather than overlooked.
     No action required; no staging step is introduced.

W3D-M2-F2  ENFORCE THE RETIREMENT, do not merely perform it. Folded into
     the S2 amendment in section 4. Rationale: the project already has
     this pattern (the existing retired-file tripwire list), and a
     deletion that is only recorded in prose can be undone by accident.
```

# 7. Implementation order and proof (M2-T series)

```text
ORDER (deliberately redundant; adapted from W3C's B1-B10):
  1  discovery round ratified (section 6);
  2  rename source + live batch assertions/labels, and perform the
     deletions and the two .ps1 amendments, as ONE atomic delivery.
     There must be NO intermediate accepted state in which source emits
     NEW while a gate asserts OLD, or a gate asserts NEW while source
     emits OLD, or a deletion has landed while a referencing script has
     not been amended.

PROOF - deliberately TARGETED, W3X-ratified 2026-08-16:
  W3D assessed and states plainly that a reduced burden is SAFE here,
  and why: this change alters no arithmetic, no dispatch, no selection
  logic and no vector path. It moves internal error identifiers, one
  function name, one emitted diagnostic token, gate labels, and deletes
  superseded artifacts. The only questions the proof must answer are
  whether the token moved coherently in BOTH directions and whether the
  live gates still fire. Therefore:

  M2-T1  BIDIRECTIONAL TOKEN PROOF (the heart of this stage).
         (a) OLD-vocabulary extinction: across the live source and proof
             surface, old token count = 0 and old identifier count = 0.
             Occurrences inside historical DOCUMENTATION are permitted
             and must be classified as history, never silently counted
             as live.
         (b) NEW-vocabulary both ways: exactly one source emitter emits
             the exact new spelling, and EVERY live assertion targets
             that exact spelling. Classify every live occurrence as
             emitter or assertion. A gate asserting a token nothing
             emits is not a gate.
  M2-T2  ASSERTION CARDINALITY. For build_5C_v1.bat, record assertion
         counts before and after. The invariant is not "new text
         exists" but "same number of assertion sites, only the spelling
         and label changed". This catches a check accidentally deleted
         during the rename.
  M2-T3  DIFF CONFINEMENT, per file:
         src/deblock4_selftest.zig      only the M2-N1..N9 cluster;
         build_5C_v1.bat                only assertions and labels;
         audit_stage_1c_s3_eol.ps1      only the $rootFiles line;
         audit_stage_1c_s2_sweep.ps1    only the dead skip and the
                                        retired-list additions;
         stage_2c_classic_obligations.vpy  only the n02a/n02b branch
                                        removal and the two caller
                                        comments;
         crosswalk .md                  only the named T-S5/H0-H6 row
                                        descriptions - every gated
                                        obligation ID still present.
         No opportunistic cleanup, reformatting or unrelated wording
         rides with M2.
  M2-T3b CROSSWALK ID PRESERVATION. After the edit, all 45 obligation IDs
         gated at build_5C_v1.bat line 1028 must still be found. The D3
         crosswalk audit proves this at run time, but W3C states the
         before/after ID count explicitly in the delivery as well - a
         run-time pass alone would not distinguish "all present" from
         "the audit was not reached".
  M2-T3c RETIRED-BASENAME COHERENCE. After the edits, no surviving live
         file under the S2 search domain names any newly retired
         basename. This is the self-trip hazard flagged in section 4;
         prove it explicitly rather than discovering it via a failed
         S2 gate.
  M2-T4  DELETION INTEGRITY. After deletion, no live file references any
         deleted path. Prove by repository-wide search, reported with
         counts. Historical DOCUMENTATION references are permitted and
         must be classified as history, never counted as live.
  M2-T5  ONE FULL build_5C_v1.bat RUN, green, OUTER_BATCH_EXIT_CODE=0 -
         including the S2 and S3 audits, which exercise the two amended
         .ps1 files.
  M2-T6  NO FALSE-SUCCESS ACCEPTANCE. A terminal exit code is NOT
         sufficient. The selftest-section assertions must be VISIBLY
         OBSERVED against the NEW token in all three modes, and the
         evidence review must classify every intentional negative-test
         error. This is required because an exit code cannot distinguish
         a passing gate from a silently skipped one.
  M2-T7  US-ASCII / CRLF preserved on every changed text file.

  NOT REQUIRED, and deliberately so: instruction-stream identity (this
  is a genuine source change, unlike M1); any differential corpus; any
  benchmark; execution of the deleted batches.
```

# 8. Delivery and process (charter v1_29 rules bind)

```text
No-script package per C-DELIV-10/11: apply_to_tree/ mirror applied by one
manual W3X copy; restore_to_base/ pre-change copies for every MOD file;
the DELETIONS listed as an explicit manual W3X command block in the
manifest (no delivery script deletes anything); manifest with the manual
per-file backout block including restoration of the deleted files from
their restore copies. No PowerShell added, no git in machinery, no
staging. Base confirmed with W3X. K30-style identifier audit reports the
renamed set explicitly. C-DELIV-07: no execution or PASS claims by W3C.
Harness ownership unchanged.
```

# 9. Out of scope

```text
Any filter-behaviour change                     -> would need its own
                                                   scope and full proof
Module filename renames                         -> already first-class;
                                                   churns imports, build
                                                   wiring and every audit
                                                   for no gain
Renames inside the four frozen Classic units    -> frozen
Removing the PE-export exclusion tripwires      -> they assert ABSENCE
                                                   by design; keep
Comment or documentation wording                -> M1 discharged that
Deleting anything in discovery class (b) or (c) -> W3X decides after the
                                                   report; not this round
```

---

*Revision history*
```text
v1.2 (2026-08-16) Discovery round complete and ratified (section 6a);
     IMPLEMENTATION RELEASED. Authorised surface EXPANDED on W3C's
     discovery findings, all W3D-verified: the live O/G crosswalk added as
     MOD (it is gated by build_5C_v1.bat lines 98/112/1028, not prose);
     the S3 amendment changed from removal to REPLACEMENT with
     build_5C_v1.bat (removal would have emptied the root-batch audit
     domain); tests/stage_1c_classic_passthrough.vpy and the whole
     tools/holywu_reference/ directory added as ratified deletions; the
     stale n02a/n02b branches and two caller comments in the live
     stage_2c_classic_obligations.vpy added as ratified edits. Two W3D
     findings added: F1 records that the S3 script enumerates from the git
     index and safely skips deleted files, so the post-deletion
     pre-commit run is valid; F2 folds the deletions into the existing S2
     retired-file tripwire so retirement is enforced. Proof extended with
     M2-T3b crosswalk ID preservation and M2-T3c retired-basename
     coherence. DQ6 closed NIL from the real repository.
v1.1 (2026-08-16) Reissued carrying the 2026-08-12 W3X CLEAN UP ruling
     (Option B selected; A/C retained only as rejected rationale in the
     record), with the mandatory C-DELIV-09 header block inserted, the
     normative M2-N1..N10 naming fixed (including W3C's
     selection_and_creation_contract=PASS and the authorised gate-label
     surface), W3C's B1-B10 stale-gate protections folded into sections
     6-7, and the historical-batch treatment changed from repair to
     RETIREMENT BY DELETION on evidence that build_5C_v1.bat supersedes
     them and that build_4C_v1.bat is stale by construction. Two W3D
     defects recorded in section 1. Proof deliberately targeted, with
     the safety assessment stated.
v1.0 (2026-08-16) Initial M2 scope, written after surveying the source
     tree. SUPERSEDED: it presented A/B/C as an open choice, missing the
     ratified W3X ruling, and omitted the C-DELIV-09 block.
```
