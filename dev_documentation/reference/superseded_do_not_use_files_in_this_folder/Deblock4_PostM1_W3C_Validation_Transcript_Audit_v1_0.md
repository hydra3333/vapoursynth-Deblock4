# Deblock4 - Post-5C M1 - W3C Validation Transcript Audit v1.0

**From:** W3C (coder)  
**Route:** W3C -> W3X -> W3D  
**Date:** 2026-08-16  
**Subject:** False-success audit of the W3X M1 validation transcript  
**Input:** `Pasted text(20260816-015438).txt`  
**Status:** Transcript is internally consistent with a genuine successful M1 validation run; final W3D artifact review remains required by process.

## DECISIONS/QUESTIONS FOR W3X

None.

## Conclusion

W3C reviewed the complete 6,550-line W3X transcript, including every literal
`error:`, `fail`, panic, nonzero exit, expected-error row, negative-control
rejection and terminal summary.

The reported `OUTER_BATCH_EXIT_CODE=0` is NOT a false success on the evidence
in this transcript.

Every observed error/failure block belongs to a named test whose success
criterion is rejection/failure, and each is followed by the corresponding
positive acceptance marker. No unclassified error, unexpected Python traceback,
or unhandled nonzero exit was found.

## M1-specific inertness evidence

The amended M1 gates are consistent with inertness:

- T1a: base-vs-M1 Classic v2 object disassembly differs only in the dumpbin
  input-path header line; instruction stream is unchanged.
- T1b: `.text` length, relocation count, line-number count and checksum are
  identical. The only substantive SYMBOLS-file difference is the `.debug$S`
  checksum, while its size and relocation count remain identical.
- T1c: accepted Stage-5C DLL disassembly vs M1 candidate DLL disassembly differs
  only in the dumpbin input-path header line; linked instruction stream is
  unchanged.
- T1d: raw `.obj` and DLL byte differences are retained as metadata evidence, as
  required by the amended proof.
- T3: the source diffs contain comment lines only, and both v2 and v3
  comment-stripped projections compare byte-identical.

## Classification of the alarming blocks

### Expected validation errors

The transcript contains 52 `STAGE_1C_EXPECTED_ERROR_PASS` /
`STAGE_2C_EXPECTED_ERROR_PASS` markers. These are validation tests intentionally
feeding invalid parameters or unsupported inputs and confirming exact refusal
text. Their harness cases exit zero after observing the expected error.

### Deliberate tail-mutant failures

Two negative-control differentials deliberately mutate the V1 tail behavior:

1. the retained Stage-4C tail mutant;
2. the Stage-5C V1 tail mutant.

Both produce real pixel differences and a differential exit code 2, followed by
`STAGE_5C_TAIL_MUTANT_CORRECTLY_REJECTED`.

The Stage-5C mutant additionally causes 11 unit-test failures (24/35 passing),
which is exactly the required evidence that the tests are sensitive to the
mutated one-lane path. This failure occurs in the temporary mutant tree, not in
the M1 candidate tree.

### Deliberate build/configuration rejections

The transcript intentionally rejects:

- command-line `-Dcpu`;
- command-line `-Dtarget`;
- `enable_force_down`, `enable_verbose_detection`, and
  `enable_trace_lifecycle` under ReleaseSafe;
- the same three under ReleaseFast;
- the same three under ReleaseSmall.

The resulting Zig errors/panics and secondary configure-phase `FileNotFound`
messages are therefore expected. Every one is followed by a
`PASS observed exit 1` marker, and the debug-only option cases additionally
verify that the rejection names the Debug requirement.

## Positive gates

The same transcript shows the positive proof surface remaining green:

- complete retained unit suites: 85/85 in ReleaseSafe, ReleaseFast and Debug;
- retained Classic v2 vector suite: 28/28 in the applicable modes;
- Classic v3 two-leg suite: 35/35 in ReleaseSafe, ReleaseFast and Debug;
- retained Stage-4C scalar-v2 differential: ALL_PASS, 18 cases;
- Stage-5C scalar-v2-v3 positive differential: ALL_PASS, 17 cases;
- ReleaseSafe == ReleaseFast production byte identity: PASS;
- v3 inspection sees YMM work and `vzeroupper`;
- retained structural/source audits finish PASS;
- benchmark runner records all three backends with rc=0;
- terminal banner says `STAGE 5C_v1 FULL PROOF MATRIX COMPLETED SUCCESSFULLY`;
- final `OUTER_BATCH_EXIT_CODE=0`.

## W3C disposition

On the transcript evidence, W3C finds no false-success condition and no new
blocking implementation or harness finding.

The M1 change may proceed to W3D artifact review / W3X acceptance under the
normal governance process. W3C does not replace W3D's required independent
artifact review.
