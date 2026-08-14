# Deblock4 - W3D Acceptance Review of Stage 4C (Classic SSE4.1 Vector Backend)

**Version:** 1.0
**Date:** 2026-08-13
**Author:** W3D (designer)
**Route:** W3D review -> W3X acceptance and commit
**Reviews:** the Stage 4C implementation delivery, the W3C validation-repair
package v1.2, the final W3D batch edit, and the green validation run.
**Encoding:** US-ASCII; CRLF.

---

# 1. Verdict

Stage 4C is COMPLETE and RECOMMENDED FOR ACCEPTANCE. The Classic SSE4.1
vector backend is proven byte-for-byte identical to the committed Stage 2C
scalar oracle. The full validation matrix passed with outer exit code 0 and
zero failed steps on the Windows R79 build. No production source change is
outstanding.

# 2. What was proven, in plain terms

The scalar version of the Classic filter (accepted at Stage 2C) is the
yardstick. Stage 4C added a second version of the same filter that uses SSE4.1
vector instructions to process several pixels at once. The whole point of the
stage was to show the fast version produces EXACTLY the same output as the
yardstick - not close, identical to the byte - and to show the test that
checks this can actually catch a fault if one existed.

Both were shown:

- Every one of the 18 end-to-end test cases produced byte-identical output
  between the scalar version and the SSE4.1 version, including odd-width and
  odd-height frames that force the awkward "leftover" pixels at the right and
  bottom edges, all three colour-subsampling layouts, 8-bit through 16-bit,
  and single-plane selections.
- The unit-test suite (28 tests) passed, including an exhaustive check of
  every possible leftover-width case and the four-row vertical-edge packing.
- The compiled machine code was inspected: the SSE4.1 version contains only
  SSE4.1-class instructions, and the plain-baseline version contains none of
  them. The two are properly separated.
- A deliberately corrupted copy of the code (one pixel lane altered) was
  correctly REJECTED by both the unit suite and the end-to-end comparison,
  proving the tests are not passing vacuously.

# 3. The repair round and the emergency batch edit (for the record)

Validation reached its final gate through several harness iterations. The
substantive history:

- The vector production code was correct at first delivery and never required
  a change. Every failure encountered during validation was in the test
  harness or the test-corpus content, not in the backend being tested.
- W3D's differential harness needed three fixes on the way to running: a
  VapourSynth environment-setup call transplanted from a proven script; the
  frame generators and comparison idioms aligned to proven forms; and the
  "blocky" test pattern softened so it actually triggers filtering (the first
  pattern was so blocky the filter correctly treated it as real image
  structure and left it alone). A region-targeted non-vacuity check was then
  added, adopting a strengthening the coder had proposed.
- The coder delivered a validation-repair package (v1.2) that corrected three
  real harness/batch defects: the instruction-scan matched instruction names
  as substrings (so the AVX2 instruction "pext" wrongly matched the SSE4.1
  instruction "pextrb"), fixed to whole-token matching; the batch misread the
  differential runner's success signal, fixed to require the explicit
  success marker; and it added a direct unit test for the one-lane cleanup
  path. This package is accepted.
- One defect remained after that package: the deliberate corruption was being
  injected at a line the real filter never runs, so the corrupted DLL behaved
  identically and the control could not fire. Because the coder session had
  ended, W3D specified and W3X hand-applied a two-line edit to the batch's
  mutation step, moving the corruption to the final-column cleanup path that
  the filter genuinely executes. W3D verified this fix by reproducing the
  mutation on a scratch copy: clean source passes 28/28; the corrupted copy
  fails 6 tests immediately. On the subsequent run the control fired
  correctly.

This edit was made under the project's provision for W3X acting on a W3D
specification when no coder session is available. It touches only the test
batch's fault-injection step; it changes no production source and no other
test.

# 4. The accepted file set

Against the Stage 2C-accepted base:

  new  src/classic_vector_backend.zig       the width-generic vector body
  new  src/classic_backend_v2_sse41.zig     the 128-bit SSE4.1 object
  new  build_4C_v1.bat                       the 4C proof matrix
  mod  build.zig                             vector object and test wiring
  mod  src/classic_ar_all_frames_ready.zig   backend dispatch; the scalar
                                             path is retained unchanged as
                                             the plain-baseline branch
  mod  src/deblock4_config.zig               tier ceiling raised to SSE4.1
  mod  src/deblock4_selftest.zig             self-test additions
  mod  src/deblock4_version.zig              identity 0.1.0-dev+4C
  mod  tests/stage_2c_classic_obligations.vpy  expected tier now read from
                                             the environment; the standalone
                                             Stage 2C behaviour is unchanged
  new  tools/stage_4c/stage_4c_scalar_v2_diff.py     the W3D differential
  new  tools/stage_4c/run_stage_4c_differential.cmd  the W3D runner

The three frozen oracle files (scalar kernel, edge schedule, thresholds) were
NOT touched, as required.

# 5. Conformance to the ratified 4C decisions

All eight ratified decisions from the design round hold in the delivered code:
the single width-generic body; scalar-versus-vector byte identity as the sole
acceptance basis; the uniform schedule with no batching of adjacent edges; the
two leftover-pixel handling classes; instruction-level tier confinement; the
per-plane structuring freedom (unused, but permitted); the tier-ceiling raise
as the only configuration change; and the identity advance to 0.1.0-dev+4C.
Two earlier conformance notes stand and are not defects: the kernel's
branchless conditional expression is the formula, not leftover-lane masking;
and the one pointer cast is the established sample-pointer conversion, not a
forbidden vector-memory overlay.

# 6. Recommendation

Accept and commit, using the provided commit message. The items to commit are
the file set in section 4. After commit, the next stage is Stage 5C (the AVX2
version of Classic), which reuses the width-generic body at the wider vector
width and is not yet scoped.

---

*Revision history*
```text
v1.0 (2026-08-13) Acceptance review of Stage 4C: recommended for acceptance;
     records the validation history (all failures were harness/corpus, never
     the backend), the accepted coder repair package v1.2, and the emergency
     two-line batch edit W3D specified and W3X applied to make the
     tail-corruption control fire.
```
