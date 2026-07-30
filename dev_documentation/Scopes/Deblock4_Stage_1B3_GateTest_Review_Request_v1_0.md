# Deblock4 Stage 1B.3 - Review Request: debug-module inclusion pattern + omission test

Version: v1.0
Audience: W3C (coder)
Encoding: US-ASCII only
Status: REVIEW request. No production code is authorised. W3C is asked to review
two attached artifacts for correctness and completeness BEFORE W3X runs the test
on the real toolchain. The aim is to confirm the test actually proves what the
pattern claims, and to catch any Zig 0.16 subtlety we have missed.

## What is attached

1. Deblock4_Debug_Module_Inclusion_Pattern_v1_0.md
   The settled W3X pattern for including debug-only code that must be ABSENT from
   release binaries. Three layers: (1) C-3 source-level conditional import as the
   primary omission guarantee; (2) per-feature inner gates as defence in depth;
   (3) marker-based proof of absence. Applies to all debug modules, not just the
   force-down seam.

2. gate_pattern_test.zip
   A minimal Zig 0.16.0 package (build.zig, src/main.zig,
   src/force_down_debug.zig, run_gate_test.bat) that is intended to PROVE, on the
   real toolchain, that the C-3 pattern omits the seam in release. It compiles
   several scenarios in ReleaseFast with the gate off and scans the produced
   binary for a unique marker string (FORCE_DOWN_MODULE_MARKER).

## Decisions already settled (context, not under review)

- Force-down enabling is an EXPLICIT opt-in build option, default OFF, not tied
  to Debug mode.
- The chosen inclusion mechanism is C-3, the top-level conditional DECLARATION:
      const fd = if (build_options.enable_force_down)
          @import("force_down_debug.zig")
      else
          struct {};
  chosen over the build-side module-swap alternative because the condition stays
  visible in the source where a maintainer reads it, rather than hidden in
  build.zig. C-3 is chosen but NOT yet ratified: ratification depends on the
  attached test confirming true omission on the toolchain.

## What we are asking W3C to check

Please review both artifacts and answer:

1. INTENT MATCH. Does the test actually exercise the C-3 pattern as the pattern
   document describes it? In particular:
   - main.zig declares `const fd_c3 = if (enable) @import(...) else struct {};`
     at file scope (the C-3 form).
   - c3_ok references `fd_c3.tools.applyMaskOnly` only inside `if (enable)`.
   - c3_leak references it in ungated (active) code, expecting a compile error
     against `struct {}` in release.
   - c3_importonly declares fd_c3 but never references it, to check a bare
     declaration does not leak.
   If the test does not faithfully represent C-3, say what is wrong.

2. OMISSION CLAIM. Do you agree that, in Zig 0.16.0, the C-3 conditional
   DECLARATION with the option false results in TRUE omission (no symbol, no
   string, no machine code for force_down_debug.zig)? Is a conditional
   DECLARATION treated the same as a conditional STATEMENT for this purpose?
   If you have any doubt, name the specific Zig 0.16 behaviour in question so the
   test can be extended to settle it.

3. TEST SUFFICIENCY. Is the marker scan (findstr for FORCE_DOWN_MODULE_MARKER on
   the built exe) a sufficient absence proof, or should the test also check
   symbols and disassembly (e.g. via dumpbin) to be conclusive? If the current
   scan could give a false ABSENT (marker optimised out of a string table even
   when code remains) or a false PRESENT, note it and suggest the stronger check.
   The project standard for absence proof is symbols + strings + disassembly;
   advise whether this small test should match that fully or whether the string
   scan suffices for this specific proof.

4. SCENARIO GAPS. Are there scenarios we should add to be conclusive? Candidates
   we considered: the build-side module-swap form (for comparison, even though
   C-3 is chosen); a ReleaseSafe run in addition to ReleaseFast; a Debug run to
   confirm behaviour is not mode-dependent; a check that passing the option in a
   release-production profile is rejected. Advise which, if any, are worth
   adding.

5. PATTERN CORRECTNESS. In the pattern document, is anything about the three-
   layer model technically wrong or misleading for Zig 0.16 - especially the
   claim that Layer 2 inner gates are redundant for omission but valuable for
   provability and as a breach fallback, and the caveat that inner gates must not
   be treated as licensing an unconditional import? Correct anything inaccurate.

## What we are NOT asking

We are not asking for the Stage 1B.3 scope or any implementation. We are asking
whether the test faithfully proves the pattern, and whether the pattern is
technically sound for Zig 0.16, so that W3X's subsequent test run is meaningful.

## After this review

W3X runs gate_pattern_test on the real toolchain. If it confirms true omission
(and W3C's review raises no correctness problem), C-3 is ratified and the
Stage 1B.3 coder scope is written on top of it. Any scenario additions W3C
recommends will be folded in before that run.
