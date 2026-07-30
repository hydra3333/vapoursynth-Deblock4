# Deblock4 Stage 1B.3 - Force-Down Override: W3X Decisions (v1.0)

Encoding: US-ASCII only
Status: settled W3X policy decisions that constrain the Stage 1B.3 coder scope.
These are DECISIONS, not open questions. They do not by themselves authorise
code; they fix the shape of the force-down seam that the 1B.3 scope will specify.

## Background

Requirement H (recorded in the Stage 1B.2 within-level report) reserves a
DEBUG-ONLY, FORCE-DOWN capability override for Stage 1B.3: a test seam that
forces selection of a LOWER CPU tier than the machine supports, so the
v3 -> v2 -> v1 fallback dispatch can be exercised on a single x86_64_v3 box.
The seam is fenced by charter G5/G6: force-DOWN only, compiled OUT of release,
loudly announced, actual-vs-effective capability kept distinct.

Two questions were left open at 1B.2 for settlement at 1B.3 scope time:
  (Q1) the exact Zig build-option mechanism that omits the seam from release, and
  (Q2) whether the seam is gated by an explicit opt-in option or tied to build
       (optimize) mode.

## DECISION 1 (Q2) - EXPLICIT OPT-IN, defaulting OFF; NOT tied to Debug mode

The force-down seam is enabled by an EXPLICIT build option (working name
`-Dforce-down`, final spelling TBD at scope time), which DEFAULTS TO OFF. It is
NOT automatically present in Debug builds and NOT automatically absent by
optimize mode alone.

Rationale:
  - A tester enables the seam deliberately when exercising fallback dispatch; it
    is never silently present just because a build happens to be Debug.
  - Debug builds without the seam remain possible (a plain Debug build is not
    forced to carry test scaffolding).
  - The presence of the seam is explicit and visible in the build invocation,
    which aids auditability (charter G5/G6 posture: safety-relevant seams should
    be deliberate and obvious, not incidental).

Consequence for the mechanism: because the gate is an explicit option and the
seam must not exist in release, the option must additionally be STRUCTURALLY
prevented from enabling the seam in a release-production profile (see Decision 2
and the open scope items). "Defaults off" is necessary but NOT sufficient; the
G6 bar is "cannot exist in release", which is a structural-omission requirement,
not a default-value requirement.

## DECISION 2 (Q1, direction only) - STRUCTURAL OMISSION required; mechanism to be confirmed at scope time

The chosen mechanism must deliver TRUE OMISSION from the release binary (no
machine code, no symbol), not mere runtime unreachability. Reference-hygiene-
only approaches (omission that holds only while no maintainer accidentally
references the debug symbol) do NOT meet the bar on their own.

Preferred direction (to be confirmed by coder research before ratification): the
conditional-namespace pattern, where the debug helper lives inside a struct that
is an EMPTY struct when the option is off, so any stray reference in an active
path is a hard COMPILE ERROR rather than silent binary bloat. This mirrors C
`#ifdef` "the symbol does not exist" safety and enforces the boundary at compile
time rather than by discipline.

This direction is NOT yet ratified because it rests on one load-bearing Zig
0.16 behaviour that must be confirmed empirically (see Open Item O1).

## OPEN ITEMS carried into the coder reconciliation (NOT decisions)

O1 (load-bearing) - ANALYSIS-SKIP BEHAVIOUR. The conditional-namespace pattern
   assumes a comptime-false `if (option)` causes the compiler to SKIP semantic
   analysis of the gated body, so a reference to a member of the now-empty
   debug struct INSIDE the gate does not fail to compile in release. If instead
   the body is still ANALYSED (only its codegen omitted), the gated reference
   would fail against the empty struct and the pattern breaks. Coder must
   confirm this behaviour empirically for Zig 0.16.0 before the mechanism is
   ratified.

O2 - RUNTIME CPUID (separate from the seam, but adjacent). Research examples to
   date sketch capability detection via compile-time `builtin.cpu` reads. Stage
   1B.3 detection MUST read the ACTUAL CPU at run time via CPUID, not the
   compile-time target. This is a detection-core requirement, flagged here so
   the force-down mechanism discussion does not accidentally import a
   compile-time detection assumption.

O3 - FINAL OPTION SPELLING and the release-profile structural block. The exact
   option name and the precise construct that makes the seam impossible in a
   release-production build (e.g. forcing the option false for ReleaseFast /
   ReleaseSmall, or a separate structural exclusion) are settled at scope time
   once O1 is resolved.

## Inputs on file

  - Deblock4_Stage_1B3_ForceDown_GAIS_Research_v1_0.txt  (first GAIS answer:
    lazy-analysis omission, reference-hygiene caveat)
  - Deblock4_Stage_1B3_ForceDown_GAIS_Research_v1_1.txt  (supplementary GAIS
    answer: conditional-namespace compiler-enforced boundary)
  - Coder response to Deblock4_Stage_1B3_Prep_Coder_Research_Tasks_v1_0.md
    (pending) - to be diffed against the GAIS answers on: true-omission
    confirmation, the O1 analysis-skip behaviour, runtime-CPUID (O2), and the
    Part A CPUID bit table.
