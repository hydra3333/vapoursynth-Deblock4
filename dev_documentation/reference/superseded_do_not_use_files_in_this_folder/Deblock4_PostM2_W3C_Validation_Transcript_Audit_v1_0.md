# Deblock4 - Post-5C Maintenance M2 - W3C Validation Transcript Audit v1.0

**From:** W3C (coder/reviewer)
**Route:** W3C -> W3X -> W3D
**Date:** 2026-08-16
**Controlling scope:** `Deblock4_Scope_PostM2_Identifier_Hygiene_v1_3.md`
**Transcript audited:** `Pasted text(20260816-051735).txt`
**Transcript size:** 6,178 lines
**Execution owner:** W3X
**Status:** W3C transcript review complete. No false-success path or unclassified
failure found. W3D artifact review and W3X acceptance remain the governance
steps named by the proof matrix itself.

## DECISIONS/QUESTIONS FOR W3X

None.

## 1. Disposition

W3C audited the complete 6,178-line W3X transcript, not only the terminal status.

Result:

    M2 VALIDATION TRANSCRIPT: GENUINELY GREEN
    FALSE-SUCCESS AUDIT: CLEAN
    UNCLASSIFIED FAILURE: NONE FOUND

The matrix terminates with:

    STAGE 5C_v1 FULL PROOF MATRIX COMPLETED SUCCESSFULLY
    OUTER_BATCH_EXIT_CODE=0

and immediately before completion repeats the live structural gates:

    STAGE_2C_CROSSWALK_COMPLETE_PASS
    S2_SWEEP_PASS
    S3_STAGE_1C_DELIVERABLE_TREE_PASS

The transcript itself correctly retains:

    W3D ARTIFACT REVIEW AND W3X ACCEPTANCE ARE STILL REQUIRED

W3C therefore recommends proceeding to W3D artifact/evidence review. W3C does
not recommend commit before that review and W3X acceptance.

## 2. M2-specific runtime evidence

### M2-T5 / M2-T6 - new contract token visibly observed in all three modes

The new permanent token is visibly emitted and the matching batch gate visibly
fires in all three required modes:

ReleaseSafe, transcript lines 121-131:

    deblock4_selftest: PASS ... selection_and_creation_contract=PASS
    === ReleaseSafe selftest selection and creation contract

ReleaseFast, transcript lines 1323-1333:

    deblock4_selftest: PASS ... selection_and_creation_contract=PASS
    === ReleaseFast selftest selection and creation contract

Debug, transcript lines 2730-2735:

    deblock4_selftest: PASS ... selection_and_creation_contract=PASS
    === Debug selftest selection and creation contract

The old emitted token `stage_1c=PASS` occurs zero times in the complete
transcript.

The old human gate label `retained Stage 1C section` occurs zero times.

This is important: the matrix did not merely reach exit zero; the M2-renamed
gate is visibly exercised in each mode, satisfying the specific no-silent-gate
concern that motivated M2-T6.

### Live proof-surface gates

At matrix start:

    S2_SWEEP_PASS
    S3_STAGE_1C_DELIVERABLE_TREE_PASS
    STAGE_2C_CROSSWALK_COMPLETE_PASS

At matrix end, after all retained negative controls, all three are run again
and pass again.

That provides runtime evidence that:

- the retirement tripwire does not self-trip;
- the S3 root-batch replacement remains a valid ASCII/CRLF audit surface;
- the amended live O/G crosswalk remains complete under the 45-ID gate.

## 3. Positive retained matrix evidence

### Complete retained unit suites

All three modes report:

    Build Summary: 23/23 steps succeeded; 85/85 tests passed

for:

- ReleaseSafe;
- ReleaseFast;
- Debug.

### Retained Classic v2 suites

All three modes report:

    Build Summary: 3/3 steps succeeded; 28/28 tests passed

for the Classic v2 vector differential unit suite.

### Classic v3 two-leg proof

All three modes report:

    Build Summary: 5/5 steps succeeded; 35/35 tests passed

for the Classic v3 two-leg vector proof.

### Differential proofs

Retained Stage-4C scalar/v2 differential:

    STAGE_5C_SCALAR_VECTOR_DIFFERENTIAL_ALL_PASS
    kind=stage4c-regression
    cases=18
    legs=x86_64_v2_with_sse41

Current Stage-5C scalar/v2/v3 differential:

    STAGE_5C_SCALAR_VECTOR_DIFFERENTIAL_ALL_PASS
    kind=positive
    cases=17
    legs=x86_64_v2_with_sse41,x86_64_v3_with_avx2

Both runners exit zero on their positive legs.

### Other retained evidence

The transcript also records, among the retained Stage-5C gates:

- ReleaseSafe / ReleaseFast production byte identity PASS;
- v3 object YMM use;
- `vzeroupper` transition hygiene;
- named-model guard perturbation checks;
- source/manifest and structural audits;
- no-padding graph audit;
- K31 byte-row audit;
- successful non-gating benchmark runs for v1/v2/v3.

## 4. False-success audit of every alarming block

### 4.1 Literal `error:` lines

There are exactly 27 lines beginning with `error:` in the complete transcript.

All 27 are classified.

#### A. Deliberate V1-tail mutant: 12 `error:` lines

The Stage-5C V1-tail perturbation intentionally corrupts the temporary mutant
copy.

Its unit run produces:

- 6 expected failing tests in the 28-test vector-body leg;
- 5 expected failing tests in the 7-test Stage-5C leg;
- 1 final Zig build-command error after those deliberate failures.

Summary:

    24/35 tests passed (11 failed)

This is then followed by the differential mutant leg, which detects 6,652
differing bytes and exits 2, followed by:

    STAGE_5C_TAIL_MUTANT_CORRECTLY_REJECTED
    kind=tail-mutant-expected-failure

Therefore all 12 `error:` lines in this block are required negative-control
evidence, not production/test failure.

#### B. Deliberate command-line override rejection: 6 `error:` lines

Two intentionally invalid commands are run:

    zig build -Dcpu=x86_64_v3
    zig build -Dtarget=x86_64-windows-msvc

Each produces three `error:` lines and exit 1, immediately followed by:

    Reject command-line CPU override PASS observed exit 1
    Reject command-line target override PASS observed exit 1

Total: 6 expected `error:` lines.

#### C. Deliberate debug-only option rejection: 9 `error:` lines

For each of ReleaseSafe, ReleaseFast and ReleaseSmall, the matrix deliberately
tries each debug-only option:

- `enable_force_down`;
- `enable_verbose_detection`;
- `enable_trace_lifecycle`.

Each invocation panics with:

    Deblock4 debug-only options require -Doptimize=Debug

and Zig then emits a secondary configure-phase `FileNotFound` `error:` line.

There are exactly 9 such secondary `error:` lines, and every one is followed by
the corresponding:

    PASS observed exit 1

plus a gate that the rejection names the Debug requirement.

Total: 9 expected `error:` lines.

Classification sum:

    V1 mutant                              12
    CPU/target override rejection           6
    debug-only release-mode rejection       9
                                             --
    TOTAL                                   27

No literal `error:` line remains unclassified.

### 4.2 Panic blocks

There are exactly 9 real `panic:` blocks.

They are the 3 debug-only options multiplied by 3 non-Debug modes:

- ReleaseSafe: 3;
- ReleaseFast: 3;
- ReleaseSmall: 3.

Every panic contains the expected Debug-only requirement and is followed by the
expected exit-1 PASS gate.

No other panic exists.

### 4.3 `PASS observed exit 1`

There are exactly 11 such markers:

- 2 command-line override rejections;
- 9 debug-only-option release-mode rejections.

This exactly matches the intended rejection matrix.

### 4.4 Differential exit code 2

There are exactly 2 differential exit-code-2 outcomes:

1. retained Stage-4C tail mutant:
       STAGE_5C_TAIL_MUTANT_CORRECTLY_REJECTED
       kind=stage4c-tail-mutant-expected-failure

2. Stage-5C V1 tail mutant:
       STAGE_5C_TAIL_MUTANT_CORRECTLY_REJECTED
       kind=tail-mutant-expected-failure

Both are deliberate negative controls and both are positively recognised by
the harness.

### 4.5 Expected validation-error cases

The transcript contains 52 explicit expected-error PASS markers:

- 20 `STAGE_1C_EXPECTED_ERROR_PASS`;
- 32 `STAGE_2C_EXPECTED_ERROR_PASS`.

These are normal invalid-input/refusal validation cases. Their enclosing vspipe
cases exit zero and report the expected PASS marker.

### 4.6 Python traceback check

There is no actual:

    Traceback (most recent call last)

anywhere in the complete transcript.

The many occurrences of wording such as:

    emitted no Python traceback

are positive harness checks, not tracebacks.

## 5. M2 stale-surface checks visible in the run

The complete transcript contains zero occurrences of:

- `stage_1c=PASS`;
- `retained Stage 1C section`;
- `n02a`;
- `n02b`;
- `build_1C_v1.bat`;
- `build_2C_v1.bat`;
- `build_4C_v1.bat`;
- `holywu_reference`;
- `stage_1c_classic_passthrough.vpy`.

This is consistent with the pre-run byte-equality/deletion verification and
with the passing S2 retirement sweep.

The surviving N04 proof visibly reports v3 and the batch visibly confirms:

    N04 reaches implemented v3
    N04 no longer reports the retired v2 implementation cap

So the exact stale expectation that previously existed in the old historical
surface is not present in the surviving live matrix.

## 6. Non-gating benchmark record

All benchmark invocations report `rc=0`.

Recorded runs:

v1:
    0.302917
    0.303579
    0.307853 seconds

v2:
    0.270148
    0.267660
    0.267817 seconds

v3:
    0.265547
    0.264900
    0.265124 seconds

The benchmark remains non-gating as designed. No performance acceptance claim
is made from these values.

## 7. W3C conclusion

The W3X-run M2 validation transcript is not a false success.

The proof matrix:

- exercises and visibly observes the new permanent contract token in all three
  required modes;
- runs the amended S2/S3/crosswalk gates successfully before and after the
  retained negative-control section;
- preserves the complete retained positive test matrix;
- correctly rejects both tail mutants;
- correctly rejects command-line target/CPU overrides;
- correctly rejects debug-only options in all non-Debug modes;
- contains no unclassified `error:`, panic, nonzero differential outcome or
  Python traceback;
- terminates with `OUTER_BATCH_EXIT_CODE=0`.

W3C assessment:

    M2 validation transcript: PASS / genuinely green.
    False-success audit: PASS.
    New M2 blocker: NONE FOUND.

Next governance step: W3D independent artifact/evidence review. After W3D
accepts the delivery/evidence and W3X marks M2 accepted, the tree may be
committed under the normal W3X workflow.
