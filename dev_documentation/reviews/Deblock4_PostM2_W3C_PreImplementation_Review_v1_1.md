# Deblock4 - Post-5C Maintenance M2 - W3C Pre-Implementation Review v1.1

**From:** W3C (coder)
**Route:** W3C -> W3X -> W3D
**Date:** 2026-08-16
**Scope reviewed:** `Deblock4_Scope_PostM2_Identifier_Hygiene_v1_0.md`
**Source reviewed:** `src(20260816-021513).zip`
**Documentation reviewed:** `dev_documentation(20260816-021514).zip`
**Base observed:** accepted M1 tree, identity `0.1.0-dev+5C`
**Status:** PRE-IMPLEMENTATION REVIEW ONLY. No source or batch change made.

## DECISIONS/QUESTIONS FOR W3X

### Q1 - M2 v1.0 presents A/B/C as open, but the current Project Status already
records a W3X decision to CLEAN UP this exact cluster

**Question:** Is the 2026-08-12 W3X ruling still in force?

**Why it matters:** Current `Deblock4_Project_Status_v1_27.md` states:

- `identifier-cleanup: W3X RULED 2026-08-12 -> CLEAN UP`;
- `runStage1CPureContracts`, `stage_1c=PASS`, and kin are to be renamed to
  intent-describing names;
- the rename is a separate bounded future scope;
- it must be coordinated atomically across source symbols, emitted token,
  batch assertions and any expected-output captures;
- a full proof-matrix rerun follows.

That is the exact work M2 now scopes. Unless W3X intentionally reverses that
earlier ruling, M2 Option B is not merely one of three equal choices: it is the
already-recorded W3X direction.

**W3C recommendation:** Keep the earlier W3X ruling. Ask W3D to reissue M2 as
v1.1 with Option B selected and the A/C alternatives retained only as rejected
history/rationale.

**Options:**
- **Recommended:** confirm the 2026-08-12 CLEAN UP ruling remains binding and
  reissue M2 with B selected.
- Explicitly reverse the earlier ruling and choose A or C, recording that
  reversal in Project Status.

Refs: Project Status v1.27 section 0; M2 v1.0 section 3.

### Q2 - the new scope omits the mandatory C-DELIV-09 scope-header reminder

**Question:** May W3D reissue the scope with the current reminder block inserted
verbatim?

**Why it matters:** Charter v1.29 C-DELIV-09 requires the current
`Deblock4_Scope_Header_CDELIV09_Reminder_Block` to be copied verbatim into every
scope issued henceforth. M2 v1.0 has no such block after its encoding line.

This is a scope-format/process defect, not an implementation defect.

**W3C recommendation:** Reissue as part of the same v1.1 correction. No separate
design round is necessary for the block itself because it merely restates the
already-ratified charter rule.

Refs: charter v1.29 C-DELIV-09; scope-header reminder block v1.1; M2 v1.0 header.

### Q3 - if Option B proceeds, should the new PASS token name both halves of the
contract?

**Question:** Should the replacement token be
`selection_and_creation_contract=PASS` rather than `selection_contract=PASS`?

**Why it matters:** M2 itself correctly says the permanent contract covers both
selection AND creation/validation, and proposes
`runSelectionAndCreationContracts` for the function. The selftest body proves
auto/explicit selection, above-effective and unknown-token refusal, Classic and
Deblock4 validation, and invalid-call refusal. `selection_contract=PASS` is
therefore narrower than the function and the actual contract.

**W3C recommendation:** Use
`selection_and_creation_contract=PASS` so the permanent emitted marker states
the full intent. If W3X/W3D deliberately prefers the shorter
`selection_contract=PASS`, W3C will use it exactly; W3C will not choose this
silently.

Refs: M2 v1.0 sections 2-3; current `src/deblock4_selftest.zig`.

## W3C assessment of W3D's pre-scope warning about Option B

W3D's observation is technically correct and should be preserved in the design
record:

> Option B is defensible, but it is the only option that spends proof on
> cosmetics; and the specific hazard it introduces - a batch asserting a token
> the source no longer emits, so the gate silently never fires - is the same
> class of defect that bit Stage 5C twice.

W3C agrees with both halves.

First, Option B has no runtime-behaviour payoff. The existing names are
internally consistent and not presently causing an execution defect. The gain
is long-term maintainability: replacing stage-bound vocabulary with permanent
intent-describing names.

Second, Option B genuinely creates a proof-synchronisation risk that Option A
does not create at all. If the source changes from:

    stage_1c=PASS

to a new permanent token while even one accepted batch still asserts the old
token, source and proof machinery have diverged. A stale assertion may then
become ineffective or test the wrong surface. That is a real hazard, and Stage
5C provides direct project history showing why such drift must be treated as a
first-class proof problem.

W3C therefore does NOT dismiss W3D's warning as merely conservative. It
identifies the central engineering risk of Option B.

However, W3C draws a somewhat different conclusion from that warning.

The warning is a strong argument against a casual, opportunistic rename. It is
not necessarily an argument against a deliberately bounded, atomic rename whose
proof is specifically designed to eliminate stale source/gate vocabulary.

Given that current Project Status already records W3X's earlier CLEAN UP ruling,
the question is not simply:

    "Is this cosmetic rename worth inventing a proof exercise for?"

It is more accurately:

    "Having already decided that permanent Stage-1C vocabulary should be
     retired, is this isolated maintenance scope the safest point to do the
     coordinated cleanup?"

W3C's answer is yes, provided Option B is tightened as below.

There is also a reason not to prefer Option C merely to save proof effort now.
Deferring until a future stage that genuinely edits the selftest risks coupling:

    future behavioural change
    +
    identifier/token/gate rename

in one proof surface. If something then fails, causality is less clean. A
standalone M2 Option B is almost a pure rename stage: the proof cost is real,
but the source of any failure is unusually well isolated.

## The Stage 5C warning should affect *how* we do B

The fact that this stale-gate defect class bit Stage 5C twice should directly
shape M2's acceptance criteria.

W3C recommends that Option B be implemented and proved in the following
deliberately redundant order.

### B1 - enumerate the complete OLD vocabulary before editing

Before any source change, mechanically enumerate every occurrence of:

- `runStage1CPureContracts`
- every `Stage1C*` error identifier in the candidate cluster;
- `stage_1c=PASS`;
- every human-readable batch label whose meaning is tied to that old token.

Record the file list and occurrence counts in the delivery evidence.

The point is to establish the exact pre-change universe BEFORE renaming, rather
than discovering it opportunistically while editing.

### B2 - freeze the expected change surface

The delivery must state the exact authorised files before application.

On the current supplied tree, W3C finds the Option-B surface to be:

- `src/deblock4_selftest.zig`
- `build_1C_v1.bat`
- `build_2C_v1.bat`
- `build_4C_v1.bat`
- `build_5C_v1.bat`

No `.vpy`, `.cmd`, test file or other source file currently captures
`stage_1c=PASS`.

If W3D's independent search finds any additional live assertion/capture, that
file must be added explicitly before implementation; W3C should not absorb it
silently.

### B3 - rename source and every asserting batch as ONE atomic delivery

The source identifiers, emitted PASS token and every accepted batch assertion
must move together.

There must be no intermediate accepted state in which:

- source emits NEW while a batch asserts OLD; or
- a batch asserts NEW while source still emits OLD.

This is exactly the state-transition hazard the Stage 5C history warns about.

### B4 - require exhaustive OLD-token extinction

After application, search the whole live repository for the old token and old
identifier cluster.

For the live implementation/proof surface:

    old live token count = 0
    old live identifier count = 0

Historical documentation may of course describe the old names as history, but
such occurrences must be classified as documentation/history and must not be
mistaken for active source/gate use.

### B5 - prove the NEW token in both directions

Do not prove only that batches contain the new text.

Prove BOTH:

1. an emitter exists and emits the exact new spelling; and
2. every active assertion targets that exact emitted spelling.

For the proposed marker:

    selection_and_creation_contract=PASS

the evidence should classify every live occurrence as either:

- the single intended source emitter; or
- an intended batch assertion.

A gate asserting a token that nothing emits is not a gate. This bidirectional
check is therefore the heart of M2-T1.

### B6 - preserve assertion cardinality

For each changed accepted batch, record the pre-change and post-change assertion
count.

The desired invariant is not merely "new text exists". It is:

    expected assertion sites before == expected assertion sites after

with only the asserted spelling/label changed.

This helps catch accidental deletion of a check while the rename is being made.

### B7 - diff confinement

Show mechanically that `src/deblock4_selftest.zig` differs only in the
authorised identifier/token cluster, and that each batch differs only in the
authorised assertion/associated label surface.

No opportunistic cleanup, reformatting or unrelated wording changes should ride
with M2.

### B8 - run the proof machinery W3D explicitly requires

The full retained Stage-5C matrix must run and finish green.

Because Option B modifies four accepted batch artifacts, W3D should explicitly
decide whether M2 additionally requires direct execution of:

- `build_1C_v1.bat`
- `build_2C_v1.bat`
- `build_4C_v1.bat`

rather than assuming that successful `build_5C_v1.bat` execution alone proves
the changed historical batches remain operational.

W3C recommends that W3D own and state this acceptance boundary in the reissued
scope.

### B9 - no false-success acceptance

Given the Stage 5C history, W3X/W3D review should not accept only a terminal
batch exit code.

The evidence review should classify any intentional negative-test errors and
confirm that no stale-token gate was silently skipped. In particular, the
selftest-section assertions in all required modes must be visibly observed
against the NEW token.

### B10 - only then retire the old vocabulary

Once B1-B9 are satisfied, the old Stage-1C vocabulary can be considered
intentionally retired from the live source/proof surface and the registered
identifier-cleanup item can be closed permanently.

This turns Stage 5C's warning into a stronger M2 design rather than treating it
as a reason to leave stage-bound permanent names indefinitely.

## R1 - live-tree survey verification

W3C independently surveyed the supplied current source tree.

### R1.1 Module-count reconciliation

There are 35 `.zig` files directly under `src/`.

Two are outside the designer's "33 production modules" count:

- `classic_5c_frozen_reexport.zig` - test-only module root;
- `deblock4_selftest.zig` - the first-class selftest executable under review.

That leaves exactly 33 production filter/library modules, so the scope's count
is internally explainable and not a finding.

### R1.2 Stage/probe/smoke/scratch/tmp identifiers

A code-token audit (comments and strings excluded) found the stage-numbered
identifier cluster only in `src/deblock4_selftest.zig`:

- `runStage1CPureContracts`
- `Stage1CAutoSelectionFailed`
- `Stage1CExplicitSelectionFailed`
- `Stage1CAboveEffectiveWasAccepted`
- `Stage1CUnknownBackendWasAccepted`
- `Stage1CClassicValidationFailed`
- `Stage1CDeblock4ValidationFailed`
- `Stage1CInvalidCallWasAccepted`

The only `probe` hits elsewhere in `src/` are comments in the G10 debug modules.
No production filename contains stage/probe/smoke/scratch/tmp vocabulary.

`deblock4_backend_probe` and `deblock4_dll_probe` do not exist as current source
symbols. They occur in the accepted batches only as PE-export exclusion
tripwires. The scope is correct to preserve them.

### R1.3 Current base

The supplied source reports identity `0.1.0-dev+5C`.

The accepted M1 state is present:

- v2 SSE4.1 header contains the full reconciled maintainer guide;
- v2 and v3 both carry the K33-complete
  `filterHorizontalLanes(T, 1, ...)` / V1 wording.

The supplied source is therefore consistent with the declared "Stage 5C plus
accepted M1" M2 base.

## R2 - exact Option-B change surface in the supplied repository

An exhaustive repository search found `stage_1c=PASS` assertions in exactly
FOUR accepted batch files, two assertions in each:

1. `build_1C_v1.bat`
2. `build_2C_v1.bat`
3. `build_4C_v1.bat`
4. `build_5C_v1.bat`

The emitted token itself is in `src/deblock4_selftest.zig`.

No `.vpy` or `.cmd` harness, test file, or other source file contains an
expected-output capture of that token.

Therefore, if Option B is selected, the currently observed repository change
surface is exactly five files:

- `src/deblock4_selftest.zig`
- `build_1C_v1.bat`
- `build_2C_v1.bat`
- `build_4C_v1.bat`
- `build_5C_v1.bat`

Everything else can remain byte-frozen as M2 requires.

## R3 - exact proposed identifier mapping for designer decision

Subject to Q3 on the PASS token, W3C recommends the following permanent,
intent-describing mapping:

- `runStage1CPureContracts`
  -> `runSelectionAndCreationContracts`
- `Stage1CAutoSelectionFailed`
  -> `SelectionAutoFailed`
- `Stage1CExplicitSelectionFailed`
  -> `SelectionExplicitFailed`
- `Stage1CAboveEffectiveWasAccepted`
  -> `SelectionAboveEffectiveWasAccepted`
- `Stage1CUnknownBackendWasAccepted`
  -> `SelectionUnknownBackendWasAccepted`
- `Stage1CClassicValidationFailed`
  -> `CreationClassicValidationFailed`
- `Stage1CDeblock4ValidationFailed`
  -> `CreationDeblock4ValidationFailed`
- `Stage1CInvalidCallWasAccepted`
  -> `CreationInvalidCallWasAccepted`

For the emitted marker, W3C recommends:

- `stage_1c=PASS`
  -> `selection_and_creation_contract=PASS`

The batch labels such as "selftest retained Stage 1C section" should also be
made permanent if W3D authorises that wording as part of the gate rename, for
example "selftest selection and creation contract". The M2 scope currently
authorises matching assertions but should say explicitly whether the human
gate labels are included; W3C will not broaden the edit without that
clarification.

## R4 - independent knowledge sweep

### Finding M2-W3C-F1 - prior W3X CLEAN UP ruling is not carried by M2 v1.0

This is the material knowledge-sweep finding described in Q1.

Current Project Status v1.27 records the 2026-08-12 W3X decision to perform the
coordinated rename as its own bounded future scope. M2 v1.0 instead presents
A/B/C as an undecided choice and W3D recommends A or C.

Because the scope is still DRAFT and awaiting W3X ratification, the cleanest
resolution is to reissue it carrying the existing W3X ruling, unless W3X
deliberately reverses that ruling.

### Other sweep result: NIL

Beyond F1, no additional current, non-superseded knowledge item changes the
substance of this M2 work:

- charter C-STY-10 supplies the permanent-name rule already cited by M2;
- D0 K30 preserves the rule that ordinary feature deliveries must not casually
  rename these accepted regression identifiers and points cleanup to a separate
  deliberate future decision - M2 is that separate decision;
- Currency Audit v1.4 records M1 complete and identifier cleanup as the next
  registered follow-up;
- Forward Roadmap v1.20 likewise lists identifier cleanup as a registered next
  candidate;
- K16 protects creation-error/public using-echo text and does not forbid an
  internal selftest error identifier rename;
- K23 introduces no contrary naming constraint for this scope.

## R5 - proof comments

The M2 v1.0 proof model is otherwise sound:

- exhaustive old/new token cross-check is necessary;
- the full retained matrix is appropriate;
- source diff confinement to the named cluster is appropriate;
- ASCII/CRLF preservation is required;
- no instruction-stream identity proof is appropriate because Option B is a
  genuine source and emitted-string change.

The Stage 5C history strengthens, rather than weakens, the case for explicit
bidirectional token proof and assertion-cardinality checks if B proceeds.

## W3C disposition

No implementation has begun.

W3C now positively recommends Option B, subject to a narrow M2 v1.1 reissue
before ratification that:

1. carries the prior W3X CLEAN UP ruling (Option B), unless W3X explicitly
   reverses it;
2. inserts the mandatory C-DELIV-09 header reminder;
3. fixes the exact permanent identifier/token names;
4. explicitly authorises or excludes the human-readable batch-label changes;
5. incorporates the Stage-5C-derived B1-B10 stale-gate protections above;
6. states exactly which of the four modified accepted batches must be executed
   in addition to the full retained Stage-5C matrix.

W3C's reason for favouring B is not that W3D's proof-cost warning is weak.
W3C agrees that the warning is strong. The reason is that the safest response
to that known hazard, once W3X has already decided to retire the stage-bound
vocabulary, is to make the rename a deliberately isolated, atomic,
bidirectionally-proved maintenance stage rather than defer it until it becomes
entangled with later behavioural work.

After W3X ratifies that corrected scope, the implementation remains small and
mechanical: five files, coordinated atomically, with no intended filter-
behaviour change.
