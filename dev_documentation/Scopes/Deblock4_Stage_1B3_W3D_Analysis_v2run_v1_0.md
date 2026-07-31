# Deblock4 - Stage 1B.3 W3D Analysis: build_1B3_v2 run

Version: v1.0
Date: 2026-07-31
Inputs: build_1B3_v2.bat, build_1B3_v2.log, inspection_1B3.zip
Encoding: US-ASCII only
Status: THE LLVM QUESTION IS RESOLVED (no miscompile). The run halted on a
   BENIGN Zig test-runner artifact that is now (correctly) fatal, which in turn
   BLOCKED the 1B.3 proof matrix from running. One targeted assertion fix is
   needed, then a clean re-run.

## 1. Headline

- OUTER_BATCH_EXIT_CODE=1; the harness halted at "Verify inherited unit tests
  mode Debug emitted no failed command marker".
- The tests PASSED: `Build Summary: 15/15 steps succeeded; 10/10 tests passed`.
  The halt was on the `failed command:` TEXT marker, not on a test failure and
  not on a nonzero exit (the step's own exit was 0).
- The LLVM red diagnostic is EXPLAINED and is NOT a compiler error (section 2).
- Because the halt is at the FIRST 1B.3-specific step, the 1B.3 proof matrix
  (three-surface absence, force-down matrix, build-reject, 7.4 perturbation,
  XGETBV disasm) did NOT run this pass. The benign marker is now blocking the
  real proofs (section 4).

## 2. The LLVM question - RESOLVED, no miscompile

The combined-stream capture did its job. The diagnostic index and a full-log
scan show:

- NO real LLVM error anywhere in the combined stdout+stderr: no "LLVM ERROR",
  no "internal compiler error", no "unable to emit", no codegen error. The only
  "LLVM" strings in the tree are the benign builtin metadata
  (std.builtin.CompilerBackend.stage2_llvm).
- The only `error:` lines in the index are the INTENTIONAL negative controls:
  `error: invalid option: -Dcpu` and `error: invalid option: -Dtarget` - the
  native-override rejection checks, which are SUPPOSED to fail.
- The `failed command:` lines are all the Zig test-runner artifact (section 3).

Conclusion: the red console flash W3X saw was one of these - a red
`failed command:` line or a red negative-control `error:` line scrolling past.
There is no R76-class miscompile and no unexplained diagnostic. This closes the
G9-sensitive concern with evidence rather than assumption, which is exactly why
the combined-stream capture was added.

## 3. Why the `failed command:` marker is BENIGN here

The Debug unit-test output shows, together:

```text
+- run test w
deblock4: 0.1.0-dev dll-probe backend=auto tier=x86_64_v3_with_avx2
failed command: "...test.exe" ... --listen=-
Build Summary: 15/15 steps succeeded; 10/10 tests passed
test success
+- run test 2 pass (2 total) ...
```

The test that emits the marker is `run test w` - the dll_probe test, which
calls initInstanceCapabilities and therefore PRINTS the always-on summary line
to stderr during the test. Under Zig 0.16's `--listen=-` build-runner protocol,
a test that writes to stderr causes the runner to emit a `failed command:` note
for that test process EVEN WHEN THE TEST PASSES. The authoritative signals on
the same run are unambiguous: 15/15 steps succeeded, 10/10 tests passed, "test
success". This is a known runner-protocol artifact, not a test or build
failure.

Note this is a GOOD outcome of the harness design: the v1 batch would have
sailed past this; the v2 batch correctly refused to treat a `failed command:`
line as automatically fine and stopped for classification. The classification
is now done (benign), so the assertion should be refined - not removed.

## 4. Consequence: the 1B.3 proofs did not run

The halt is at the first 1B.3-specific step (the Debug unit-test verification),
which sits immediately after the 1B.2 regression block. Everything below it in
the matrix did not execute this pass:

```text
DID run and PASSED:
  - 1B.2 regression, all three modes (probe, headers, DLL smoke, backend
    isolation);
  - export-table / symbol / within-level deny-list gates;
  - native -Dcpu and -Dtarget override rejection;
  - all 10 unit tests (10/10 passed), across the inherited modes reached.

DID NOT run (blocked by the halt):
  - three-surface absence proof (ReleaseSafe/ReleaseFast, DLL + selftest exe);
  - Debug positive control (markers present);
  - force-down behaviour matrix (v1/v2/invalid/absent);
  - build-reject checks in the three release modes;
  - 7.4 perturbation-fires demonstration;
  - 7.2 XGETBV one-instruction/one-call disasm assertion.
```

So this run proves the toolchain, the 1B.2 regression, and the unit tests, and
resolves the LLVM question - but it does NOT yet deliver the 1B.3 acceptance
evidence, purely because the benign marker halted it early.

## 5. Required fix (harness only; one assertion)

Refine the unit-test success criterion so a PASSING test run is not failed by
the runner-protocol `failed command:` artifact, while a REAL failure still is.
Recommended (W3C to choose exact spelling and verify):

```text
Treat a `zig build test` invocation as PASS iff:
    - its process exit code is 0, AND
    - the output contains an authoritative success line, specifically
      "tests passed" within a "Build Summary: N/N steps succeeded; M/M tests
      passed" line (or the per-run "test success").
Treat it as FAIL iff:
    - nonzero exit, OR
    - a "Build Summary:" line reporting fewer tests passed than run, OR
    - "transitive failure", OR
    - an LLVM/internal-compiler-error/unable-to-emit/codegen error marker.
Do NOT fail solely on the presence of "failed command:", because the Zig
0.16 --listen runner emits it for a stderr-writing test that nonetheless
passes. (The dll_probe test legitimately writes the always-on summary line to
stderr.)
```

This keeps the strength the v2 batch added (exit-code fatal, transitive-failure
fatal, real-error fatal) and only removes the ONE over-broad trigger that a
passing stderr-writing test trips. It must NOT weaken into "ignore failed
command entirely" - pair it with the positive `tests passed` assertion so a
genuine failure (which would NOT show N/N passed) is still caught.

Optionally, add a dedicated assertion that the dll_probe test's stderr contains
the expected always-on summary line - turning the very thing that caused the
false halt into a positive proof that the 13.6 line is emitted from a test
context.

## 6. Sequence after the fix

```text
1. apply the one-assertion harness fix (build_1B3 -> next revision);
2. re-run; expect it to pass the unit-test step and PROCEED into the full
   1B.3 matrix for the first time;
3. capture the combined log again;
4. W3D/W3C review the 1B.3 proofs (absence, force-down, reject, 7.4, 7.2);
5. submit the unchanged membership classification for formal R3 approval;
6. W3X commits.
```

No production source change is implicated. The XGETBV source, detection code,
and all nine implementation files remain as accepted.

## 7. One line for W3X

No LLVM miscompile - the red flash was a benign `failed command:`/negative-
control line; the harness correctly halted on that benign marker so it now
needs a one-assertion refinement (pass a test run on exit-0 + "N/N tests
passed", stop failing solely on "failed command:"); re-run and the 1B.3 proof
matrix will execute for the first time.
