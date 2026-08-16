# Deblock4 - Post-5C Maintenance M2 - W3C Mandatory Discovery Round v1.0

**From:** W3C (coder)
**Route:** W3C -> W3X -> W3D
**Date:** 2026-08-16
**Controlling scope:** `Deblock4_Scope_PostM2_Identifier_Hygiene_v1_1.md`
**Source snapshot:** `src(20260816-021513).zip`
**Documentation snapshot:** `dev_documentation(20260816-021514).zip`
**Base:** committed Stage 5C plus accepted M1, identity `0.1.0-dev+5C`
**Status:** DISCOVERY ROUND ONLY. No repository file was edited, created or deleted.

## DECISIONS/QUESTIONS FOR W3X

### DQ1 - live O/G crosswalk must be amended if the historical proof files are retired

**Question:** May M2's authorised surface be expanded to amend
`tests/Deblock4_Stage_2C_D3_v1_10_O_G_to_Test_Crosswalk.md`?

**Why it matters:** `build_5C_v1.bat` actively reads this crosswalk and gates
its completeness. The crosswalk is therefore part of the LIVE proof surface,
not merely historical prose.

It currently contains stale/historical rows that would become false pointers
after the section-4 deletions:

- T-S5-2 still says "intentionally capped auto";
- T-S5-3 points to `build_2C_v1.bat`;
- T-S5-4 still names `n02a`, `n02b`, `n03`;
- T-S5-5 points to `build_2C_v1.bat`;
- H0-H6 points to `tools/holywu_reference/run_stage_2c_holywu_reference.cmd`
  and `stage_2c_holywu_diff.vpy`.

The current live batch has already moved on:

- it does not invoke n02a or n02b;
- it invokes n03 only for the effective-tier refusal;
- it invokes n04 expecting implemented v3;
- it explicitly checks that n04 DOES NOT report `reason=intentionally-capped`;
- its proof summary records H0-H6 as `NOT_RERUN_2C_HISTORY`.

Leaving the crosswalk unchanged while deleting the named files would preserve a
gate that still executes but whose prose no longer describes the live proof.
That is the same broad stale-proof-surface defect class M2 is intended to
remove.

**W3C recommendation:** YES. Amend the crosswalk in the same atomic M2
delivery, limited to making the affected T-S5/H0-H6 rows describe the current
5C proof surface/history accurately. Add the crosswalk to M2-T3 diff
confinement.

### DQ2 - S3 should replace the retired root batch with the live batch, not just remove it

**Question:** Should
`tools/audit_stage_1c_s3_eol.ps1` change its root-file list from:

    build.zig, build.zig.zon, build_1C_v1.bat

to:

    build.zig, build.zig.zon, build_5C_v1.bat

rather than merely removing `build_1C_v1.bat`?

**Why it matters:** The S3 script's recursive prefixes cover `src/`, `tests/`,
`tools/` and `third_party/`, but root batches are included only through the
explicit `$rootFiles` list. If M2 simply removes `build_1C_v1.bat`, NO live
root proof batch is in S3's CRLF/US-ASCII domain.

That is especially undesirable because M2 itself modifies
`build_5C_v1.bat`, and M2-T7 requires every changed text file to preserve
US-ASCII/CRLF.

**W3C recommendation:** YES. Replace the historical runner entry with
`build_5C_v1.bat`. This preserves the original audit intent and makes S3 audit
the live proof runner.

The known S2 edit is different: its line-23 `build_1C_v1.bat` skip is already
effectively dead because S2's `$roots` list does not include root batch files.
Removing that stale skip is still correct, but no replacement is needed there.

### DQ3 - retire the newly orphaned Stage-1C Classic vpy harness?

**Question:** May M2 delete `tests/stage_1c_classic_passthrough.vpy`?

**Evidence:** In the supplied repository snapshot its basename is referenced
only by `build_1C_v1.bat`. `build_5C_v1.bat` uses
`tests/stage_2c_classic_obligations.vpy` for Classic instead. Deleting
`build_1C_v1.bat` therefore leaves the old Stage-1C Classic vpy harness with no
live caller.

**W3C classification:** D2 class (b), genuine orphan candidate.

**W3C recommendation:** DELETE it in M2, subject to W3D verification and W3X
ratification. It is stage-numbered disposable proof scaffolding and has a
first-class successor in the current proof surface.

Do NOT confuse it with `tests/stage_1c_deblock4_passthrough.vpy`; the latter is
still actively called by `build_5C_v1.bat` and must stay.

### DQ4 - retire the stale n02a/n02b cases inside the live Stage-2C vpy?

**Question:** Should M2 be expanded narrowly to remove the n02a and n02b case
branches from `tests/stage_2c_classic_obligations.vpy`?

**Evidence:**

- n02a expects explicit v2 to fail with
  "requested backend is not available in this build";
- n02b expects explicit v3 to fail with the same message;
- after Stage 4C/5C those premises are false: v2 and v3 are both implemented;
- `build_5C_v1.bat` invokes neither n02a nor n02b;
- the live crosswalk nevertheless still names them.

These are therefore stale expectation fixtures in a live script. They do not
currently make the 5C matrix fail only because the live batch stopped invoking
them.

**W3C classification:** D2 class (b) candidate for retirement, but it touches a
currently byte-frozen `.vpy`, so W3C will not act without an explicit scope
amendment.

**W3C recommendation:** Retire n02a/n02b now if W3D agrees. This is the same
rationale used to delete stale historical batches: a dormant test whose premise
has been deliberately inverted by later accepted work is a future trap.

If W3X prefers to keep M2 narrower, record these two cases as an explicit
follow-up and ensure the crosswalk no longer presents them as live 5C proof.

### DQ5 - HolyWu reference tooling

**Question:** May M2 delete the complete `tools/holywu_reference/` directory?

**Evidence:**

- its only executable caller in the supplied live tree is `build_2C_v1.bat`,
  which M2 retires;
- `build_5C_v1.bat` does not call it;
- the live 5C proof summary explicitly records
  `H0_H6=NOT_RERUN_2C_HISTORY`;
- D0 K26 treats the HolyWu external run as pinned external-oracle evidence
  history, not a continuously rerun acceptance surface;
- the remaining live-tree reference outside the directory is the Stage-2C
  crosswalk H0-H6 row, which DQ1 proposes to update to historical status.

**W3C classification:** D2 class (b), genuine orphan candidate after
`build_2C_v1.bat` retirement and crosswalk reconciliation.

**W3C recommendation:** DELETE the directory in M2, preserving the accepted
history in prior commits and current authority documentation. Do not delete it
until DQ1 is resolved.

### DQ6 - actual-repository `.gitignore` check still required

The supplied source snapshot contains no `.gitignore`, so W3C cannot truthfully
discharge the section-6 D2 request to inspect `.gitignore` entries from the
snapshot alone.

**W3C recommendation:** W3X performs one read-only check in the actual local
repository before ratifying this discovery round:

    if exist .gitignore (
      findstr /n /i /c:"build_1C_v1.bat" /c:"build_2C_v1.bat" /c:"build_4C_v1.bat" /c:"tools/stage_4c" /c:"tools/holywu_reference" .gitignore
    ) else (
      echo NO_ROOT_GITIGNORE
    )

If there are no relevant hits, D2's `.gitignore` leg closes NIL. If there are
hits, report them before implementation.

## D1 - OLD VOCABULARY UNIVERSE

### D1.1 Live source/proof tree

Mechanical occurrence counts in the supplied source snapshot:

- `runStage1CPureContracts`: 2
  - `src/deblock4_selftest.zig`: call + declaration.
- `Stage1CAutoSelectionFailed`: 1
  - `src/deblock4_selftest.zig`.
- `Stage1CExplicitSelectionFailed`: 1
  - `src/deblock4_selftest.zig`.
- `Stage1CAboveEffectiveWasAccepted`: 1
  - `src/deblock4_selftest.zig`.
- `Stage1CUnknownBackendWasAccepted`: 1
  - `src/deblock4_selftest.zig`.
- `Stage1CClassicValidationFailed`: 1
  - `src/deblock4_selftest.zig`.
- `Stage1CDeblock4ValidationFailed`: 3
  - `src/deblock4_selftest.zig`.
- `Stage1CInvalidCallWasAccepted`: 4
  - `src/deblock4_selftest.zig`.
- `stage_1c=PASS`: 9 total:
  - source emitter: `src/deblock4_selftest.zig`: 1;
  - live assertions: `build_5C_v1.bat`: 2;
  - to-be-deleted assertions:
    - `build_1C_v1.bat`: 2;
    - `build_2C_v1.bat`: 2;
    - `build_4C_v1.bat`: 2.

Gate-label universe tied to the token:

- `selftest retained Stage 1C section`: 6
  - `build_5C_v1.bat`: 2 live;
  - `build_2C_v1.bat`: 2 to be deleted;
  - `build_4C_v1.bat`: 2 to be deleted.
- `selftest Stage 1C section`: 2
  - `build_1C_v1.bat`: 2 to be deleted.

This establishes the pre-change cardinality required by M2-T2:

    live build_5C assertion sites before = 2

The required post-change live cardinality is therefore:

    selection_and_creation_contract=PASS assertions in build_5C = 2

plus exactly one source emitter.

### D1.2 Documentation occurrences

Old vocabulary also appears in current and historical documentation. These are
not live emitters/assertions and are permitted by M2-T1 when classified as
history.

Current root authority/informative documents include, for example:

- `Deblock4_Project_Status_v1_27.md`
  - `runStage1CPureContracts`: 1;
  - `stage_1c=PASS`: 2;
  - these occur in the explicit 2026-08-12 CLEAN UP decision record.
- `Deblock4_Stage_2C_D0_Preface_and_Binding_Knowledge_Index_v1_14.md`
  - `runStage1CPureContracts`: 1;
  - `stage_1c=PASS`: 1;
  - these occur in K30's historical explanation of why normal 2C delivery did
    not rename them.

Older reviews/scopes/reference/superseded documents contain additional
historical occurrences. They are documentation history, not live proof
assertions, and must not be mechanically "cleaned" by M2.

## D2 - ORPHAN / BROKEN-REFERENCE SWEEP

### D2(a) - MUST be amended to keep live proof meaningful

#### A1 - known S3 reference: CONFIRMED, with a stronger correction

`tools/audit_stage_1c_s3_eol.ps1` line 2 currently has:

    $rootFiles=@('build.zig','build.zig.zon','build_1C_v1.bat')

The scope says remove the `build_1C_v1.bat` reference. W3C finds that the
stronger correct edit is to REPLACE it with `build_5C_v1.bat`; see DQ2.

#### A2 - known S2 reference: CONFIRMED

`tools/audit_stage_1c_s2_sweep.ps1` line 23 skips
`build_1C_v1.bat`.

Removing that stale skip is correct. No replacement root-batch entry is
recommended because the S2 search domain intentionally omits root batches and
the live batch contains historical absence-tripwire vocabulary by design.

#### A3 - live O/G crosswalk: NEW MUST-AMEND finding

`tests/Deblock4_Stage_2C_D3_v1_10_O_G_to_Test_Crosswalk.md` is actively read by
`build_5C_v1.bat` and its obligation IDs are gated.

It contains stale or soon-to-be-broken live-proof descriptions:

- T-S5-1a names N02a/N02b as current count-1 proof;
- T-S5-2 says "intentionally capped auto";
- T-S5-3 points to `build_2C_v1.bat`;
- T-S5-4 names n02a/n02b/n03;
- T-S5-5 points to `build_2C_v1.bat`;
- H0-H6 points to `tools/holywu_reference/...`.

W3C classifies this as MUST-AMEND if the deletions proceed, because a live proof
map should not remain semantically false merely because its current parser only
checks obligation-ID presence.

### D2(b) - CANDIDATES for deletion/retirement; W3X decides

#### B1 - Stage-4C differential tool pair: CONFIRMED orphan after batch retirement

- `tools/stage_4c/run_stage_4c_differential.cmd`
- `tools/stage_4c/stage_4c_scalar_v2_diff.py`

Outside their own mutual references, the live source tree points to them only
from `build_4C_v1.bat`, which M2 deletes. `build_5C_v1.bat` uses the Stage-5C
runner for its retained 4C-regression leg.

The scope already authorises these deletions; discovery confirms the premise.

#### B2 - `tests/stage_1c_classic_passthrough.vpy`: NEW candidate

Its only live-tree caller is `build_1C_v1.bat`. It becomes orphaned when that
batch is deleted. Current Classic proof uses
`tests/stage_2c_classic_obligations.vpy`.

Recommendation: delete.

#### B3 - `tools/holywu_reference/`: NEW candidate

After `build_2C_v1.bat` deletion, no live batch executes this directory.
The remaining crosswalk pointer should be converted to historical evidence
wording if DQ1 is accepted.

Recommendation: delete the whole directory, including its otherwise unreferenced
`reference-build-record-schema.json`, once crosswalk/documentation treatment is
settled.

#### B4 - stale n02a/n02b case branches in `stage_2c_classic_obligations.vpy`

These are not separate files, but they are stale proof fixtures:

- n02a expects v2 unavailable;
- n02b expects v3 unavailable;
- both premises are false in the accepted 5C tree;
- neither is invoked by `build_5C_v1.bat`.

Recommendation: retire the two branches if W3X/W3D expands the scope; otherwise
register them explicitly for later cleanup.

### D2(c) - UNCERTAIN / do not act

#### C1 - manual root utilities with zero static callers

The following have no basename references elsewhere in the supplied snapshot:

- `make_blocky.bat`
- `dump_mpeg2_info_01.bat`
- `000-SET_USER_PATH_PERMANENTLY.BAT`

This does NOT prove they are orphaned: each is plainly a manually invoked
developer utility. In particular the first two relate to MPEG-2/blockiness
inspection and may be useful for later Deblock4 work.

Recommendation: retain; no M2 action.

#### C2 - live Stage-2C vpy top comments become historically stale

`tests/stage_2c_classic_obligations.vpy` lines 10-14 currently explain its tier
input in terms of `build_4C_v1.bat` and `build_2C_v1.bat`. Deleting those
batches leaves those comments as historical statements about superseded
callers.

This does not break executable proof, but it is a stale pointer inside a live
harness. The current M2 scope says comment/documentation wording is out of
scope.

Recommendation: W3D/W3X decide whether to update these two comments as part of
the same proof-surface retirement, or register a tiny post-M2 documentation/
comment correction. W3C will not touch them without authorisation.

#### C3 - current documentation contains references to files being retired

The current documentation set contains numerous historical references to
`build_1C_v1.bat`, `build_2C_v1.bat`, `build_4C_v1.bat`, Stage-4C tooling and
HolyWu tooling. Many are legitimate history.

One current-document problem is more active: `111_New_Chat_Introduction_for_Coder_v1_27.md`
still describes Stage 4C as the current ceiling, says the 4C matrix is
`build_4C_v1.bat`, names `tools/stage_4c/`, and elsewhere says Stage 5C is next.
That document is already stale relative to accepted Stage 5C and will become
more visibly wrong when the 4C files are retired.

Recommendation: no source-tree action in this discovery round, but the
post-M2 documentation-generation update should correct the current coder intro
and record the historical-batch/tool retirement.

#### C4 - `.gitignore` unavailable in supplied source snapshot

See DQ6. No deletion decision is made from absence in the ZIP.

## D3 - STALE EXPECTATION SWEEP OF SURVIVING `build_5C_v1.bat`

Result: CLEAN for the specific later-stage inversion class requested by M2.

W3C found:

- no `n02b` occurrence in `build_5C_v1.bat`;
- no positive assertion that v3 is unavailable;
- no positive `reason=intentionally-capped(...)` expectation;
- one deliberate NEGATIVE gate:
  `N04 no longer reports the retired v2 implementation cap`, which asserts
  `reason=intentionally-capped` is absent;
- N04 explicitly expects `tier=x86_64_v3_with_avx2`;
- Debug force-down v1/v2 expectations are current and intentional;
- the retained positive scalar-v2-v3 selection/differential surfaces use the
  current Stage-5C runner.

Therefore D3 itself returns NIL: no stale 4C-style ceiling/refusal expectation
was found in the batch that survives.

Important adjacent finding: the LIVE CROSSWALK is stale even though the batch
is clean; that is reported under D2(a) A3 rather than D3.

## D4 - INDEPENDENT KNOWLEDGE SWEEP

Result: **NIL for additional binding design knowledge**.

The current non-superseded documentation was swept independently. No additional
binding rule changes the M2 design beyond what v1.1 already carries.

Relevant confirmations:

- Charter v1.29 C-STY-10 supports permanent naming and deliberate scaffolding
  retirement.
- Charter C-DELIV-07/09/10/11 matches the scope's manual-delivery and
  no-W3C-execution model.
- D0 v1.14 K30 records the old Stage-1C names as accepted regression vocabulary
  deliberately left for a separately scoped future cleanup; M2 is that cleanup.
- D0 K26 records the HolyWu execution artefact as pinned external-oracle
  evidence and distinguishes evidence history from current live rerun.
- Project Status v1.27 carries the 2026-08-12 W3X CLEAN UP ruling that M2 v1.1
  now correctly executes.
- Currency Audit v1.4 records M1 complete and identifier cleanup as the next
  registered follow-up.

The stale current coder-introduction material and stale live crosswalk are
currency/proof-surface findings, not contrary binding knowledge.

## DISCOVERY ROUND DISPOSITION

W3C does **not** recommend implementation release yet.

The discovery round has successfully done what section 6 intended: it found
additional live-proof and orphan-retirement consequences before any edit.

W3C recommends W3D review and W3X ratify a narrow M2 v1.2 adjustment that:

1. adds the live Stage-2C O/G crosswalk to the authorised MOD surface and
   defines its current 5C/historical row corrections;
2. changes the S3 amendment from "remove build_1C" to
   "replace build_1C with build_5C";
3. decides deletion of `tests/stage_1c_classic_passthrough.vpy`;
4. decides deletion of `tools/holywu_reference/`;
5. decides whether stale n02a/n02b case branches are retired now or explicitly
   deferred;
6. decides whether the two stale caller comments at the top of
   `stage_2c_classic_obligations.vpy` are updated now or deferred;
7. records a post-M2 current-document refresh, especially coder intro v1.27;
8. closes the actual-repository `.gitignore` leg after W3X reports DQ6.

No repository file should be edited or deleted until that discovery-round
outcome is ratified, exactly as M2 v1.1 requires.
