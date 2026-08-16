# Deblock4 - Scope - Post-5C Maintenance M2 - Identifier Retirement and Historical Batch Retirement

**Deliverable:** W3D-M2-SCOPE (W3X-RATIFIED)
**Version:** 1.1
**Date:** 2026-08-16
**Author:** W3D (designer)
**Route:** W3D -> W3X (ratified) -> W3C
**Base:** the committed Stage 5C tree plus accepted M1, identity 0.1.0-dev+5C,
confirmed with W3X per C-DELIV-01. No commit hash.
**Authority set:** charter v1_29 or later PREVAILS (note C-STY-10, C-DELIV-09);
D0 Binding Knowledge Index v1_14 (note K30, K16, K23, K26); Project Status
v1_27 (which CARRIES the 2026-08-12 W3X CLEAN UP ruling this scope executes);
Documentation Currency Audit v1_4.
**Status:** W3X-RATIFIED 2026-08-16. Released to W3C for the discovery round
(section 6) - implementation begins only after W3X ratifies that round.
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

JOB B - RETIRE:
  DEL  build_1C_v1.bat
  DEL  build_2C_v1.bat
  DEL  build_4C_v1.bat
  DEL  tools/stage_4c/run_stage_4c_differential.cmd
  DEL  tools/stage_4c/stage_4c_scalar_v2_diff.py
       (superseded by tools/stage_5c/; the live batch's 4C-regression
        leg calls the STAGE 5C runner, not these)
  MOD  tools/audit_stage_1c_s3_eol.ps1    remove the build_1C_v1.bat
                                          reference (line 2 root-file
                                          list)
  MOD  tools/audit_stage_1c_s2_sweep.ps1  remove the build_1C_v1.bat
                                          reference (line 23 skip)
  These two .ps1 files are LIVE proof machinery executed by the S2 and
  S3 gates. They MUST be corrected in the SAME atomic delivery. A
  deletion that leaves S3 pointing at a missing file, or S2 skipping a
  file that no longer exists, silently disables an audit - the same
  defect class as a stale gate.

  DEFERRED, DO NOT TOUCH WITHOUT A REPORT:
       tools/holywu_reference/ and anything else the sweep (section 6)
       identifies as possibly orphaned. W3D will NOT guess. Report
       first; W3X decides.

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
  M2-T3  DIFF CONFINEMENT. src/deblock4_selftest.zig differs only in the
         M2-N1..N9 cluster; build_5C_v1.bat differs only in the
         assertion/label surface; each .ps1 differs only in the removal
         of the build_1C_v1.bat reference. No opportunistic cleanup,
         reformatting or unrelated wording rides with M2.
  M2-T4  DELETION INTEGRITY. After deletion, no live file references any
         deleted path. Prove by repository-wide search, reported with
         counts.
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
