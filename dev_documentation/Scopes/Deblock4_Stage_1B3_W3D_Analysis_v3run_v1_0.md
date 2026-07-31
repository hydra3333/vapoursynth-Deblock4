# Deblock4 - Stage 1B.3 W3D Analysis: build_1B3_v3 run

Version: v1.0
Date: 2026-07-31
Inputs: build_1B3_v3.bat, build_1B3_v3.log, inspection_1B3.zip
Encoding: US-ASCII only
Status: One remaining harness bug - a `findstr /X` exact-line check fails on
   an LF-only Zig output file although the line is present byte-exact. One-line
   fix, no logic change. The v3 test-classification design is otherwise correct
   and thorough. 1B.3 proof matrix still blocked behind this step.

## 1. Headline

- OUTER_BATCH_EXIT_CODE=1; halted at "Verify inherited unit tests mode Debug
  reports test success".
- The tests PASSED again: `Build Summary: 15/15 steps succeeded; 10/10 tests
  passed`. The v3 refinement correctly PASSED its substring checks (build
  summary, steps succeeded, tests passed) and correctly classified the benign
  `failed command:` / `--listen=-` stderr warning.
- The ONLY failing assertion is the exact-line check for "test success" via
  `:find_exact_line`, which uses `findstr /X`.

## 2. Root cause - findstr /X on an LF-only file

The line IS present, byte-exact. The captured file's line 7 is exactly:

```text
test success
```

(verified: raw bytes `b'test success'`, a bare line). So the content is right.

The failure is mechanical: the file `unit_tests_inherited_Debug.txt` is Zig's
captured stdout, which is LF-ONLY (23 bare LF, 0 CRLF). `:find_exact_line` uses
`findstr /X`, whose exact-LINE anchoring is defined against CRLF line
boundaries; on an LF-only file `/X` does not reliably see `test success` as a
complete line and returns no-match (exit 1), so the step fails.

Corroboration from the same run: the sibling checks that use `find_present`
(substring `/C:`, not `/X`) - "Build Summary:", "steps succeeded", "tests
passed" - all PASSED on the same LF file, because substring matching is not
sensitive to the line-terminator convention. Only the `/X` exact-line check
tripped. That is the signature of the findstr-/X-on-LF interaction, not a
content problem.

## 3. Why this is not a content or logic error

The v3 test-classification block is actually WELL DESIGNED: it asserts the
authoritative success signals (build summary present, all steps succeeded, all
tests passed), classifies the known benign stderr warning (exactly one
`run test w`, exactly one `failed command:`, `--listen=-` context present), and
only THEN checks `test success`. The intent and coverage are correct. The lone
defect is the tool choice for that one line on an LF file.

## 4. Fix (harness only; one assertion)

Replace the `/X` exact-line dependency for this check with an LF-safe match.
Options, any of which is acceptable (W3C to choose and verify):

```text
A. Use a substring assertion instead of exact-line:
     call :find_present "... reports test success" "!TEST_OUT!" "test success"
   The other classification lines already bound this so tightly (10/10 tests
   passed, one stderr warning, listen context) that substring "test success"
   is unambiguous here.

B. Keep exactness but make :find_exact_line LF-safe, e.g. normalise the
   captured file to CRLF before matching (write it back through a CRLF filter),
   or match with a regex anchor that tolerates the LF case
     findstr /R /C:"^test success$"
   noting findstr /R end-anchor has the same CRLF caveat, so (A) or the
   normalise-to-CRLF route is more robust.

C. Drop the standalone "test success" line check entirely and rely on the
   authoritative `Build Summary: N/N steps succeeded; M/M tests passed`
   assertion plus the passed==run equality, which is the real proof of success.
   "test success" is a redundant secondary signal.

W3D preference: C or A. The `Build Summary` N/N line is the authoritative
success proof; the bare "test success" token is a secondary Zig progress line
and does not need exact-line matching. Whichever is chosen, keep the existing
strong triggers (nonzero exit fatal, passed<run fatal, transitive failure
fatal, real LLVM/ICE fatal). Do not reintroduce "fail solely on failed
command".

General note for the harness: any assertion that runs against a CAPTURED ZIG
OUTPUT file (LF) rather than a repository file (CRLF) must not use `findstr /X`
exact-line matching. Prefer substring `/C:` or normalise to CRLF first. This is
the LF-file analogue of the CRLF discipline already ratified for repository
files.

## 5. Sequence after the fix

```text
1. apply the one-assertion harness fix;
2. re-run; expect the unit-test step to pass and the batch to PROCEED into the
   full 1B.3 proof matrix for the first time;
3. capture the combined log;
4. W3D/W3C review the 1B.3 proofs (three-surface absence, force-down matrix,
   build-reject, 7.4 perturbation, 7.2 XGETBV disasm);
5. submit the unchanged membership classification for formal R3 approval;
6. W3X commits.
```

No production source change is implicated; the nine implementation files and
the XGETBV source remain as accepted. The LLVM question stays resolved (no
miscompile; see the v2-run analysis).

## 6. One line for W3X

Content is correct (test success line present, 10/10 passed); the only failure
is `findstr /X` exact-line matching being unreliable on Zig's LF-only output
file - switch that one check to a substring or the authoritative N/N summary
assertion, re-run, and the 1B.3 proof matrix should finally execute.
