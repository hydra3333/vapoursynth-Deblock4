# Deblock4 - Stage 1B.3 W3D Acceptance Review (build_1B3_v5)

Version: v1.0
Date: 2026-07-31
Inputs: build_1B3_v5.bat, build_1B3_v5.log, inspection_1B3.zip
Against: scope v1.3, charter v1.19.
Encoding: US-ASCII only
Status: IMPLEMENTATION ACCEPTED by W3D. Every scope-7 proof executed and
   passed, and W3D independently re-verified the load-bearing ones at the
   instruction/byte level rather than trusting the batch's own gates. Recommend
   W3X commit after the R3 sign-off recorded in section 5.

## 1. Headline

The batch COMPLETED with OUTER_BATCH_EXIT_CODE=0. The 1B.3 proof matrix ran
end to end for the first time. All four prior halts were harness defects, now
resolved; this run's harness is trustworthy (it halts on real failure, cannot
print COMPLETED after a FAIL, distinguishes test pass from failure, and gates
1B.2 correctly). W3D independently verified the substantive proofs from the raw
inspection artifacts; findings below.

## 2. Independently verified proofs (W3D read the artifacts, not just the gates)

7.2a DETECTION OBJECT IS v1-ONLY - VERIFIED. W3D scanned
cpu_capability_detection_disasm.txt directly. No AVX/VEX/EVEX, no ymm/zmm, no
SSE3/SSSE3/SSE4 mnemonics. The object DOES contain a small SSE2 sequence
(movd, pinsrw, pand xmm0,[const], pcmpeqb, pmovmskb) that the compiler
generated for feature-flag comparison; every one of those is an SSE2/v1
baseline instruction (pinsrw is SSE2, not the SSE4 pinsrb/d/q; no pextr/insertps
present). The __xmm@ symbols are the 16-byte constant-pool operands, not code.
Conclusion: genuinely within the v1 level, verified at the mnemonic level.

7.2b XGETBV EXACTLY ONCE - VERIFIED. Exactly one XGETBV instruction
(`0F 01 D0` at 0x376, inside the xgetbv helper) and exactly one call to that
helper (0x214). One CPUID (`0F A2`). Matches the design; the earlier v1
"observed 2" was the batch counting the call-name plus the instruction, now
correctly split into two exact assertions that both pass.

7.2c OSXSAVE GUARD IN GENERATED CODE - VERIFIED. Immediately before the call:
`cmp bl,1 / je 023D`. FeatureState.detected_absent == 1, so OSXSAVE-absent
(bl==1) branches over the call; OSXSAVE-present falls through to XGETBV. The
G5/G6 safety guard is real in machine code, not merely in source.

7.3 THREE-SURFACE ABSENCE (release) - VERIFIED. In BOTH ReleaseSafe and
ReleaseFast, across BOTH the DLL and the self-test exe, on ALL THREE surfaces
(raw strings, PE exports, disassembly code-immediate), the force-down marker,
the verbose marker, the env-name string, and the code-immediates
FD00D001/DD00D001 are ALL ABSENT (every count zero). W3D re-ran these scans on
the binaries; confirmed.

POSITIVE CONTROL (Debug) - VERIFIED MEANINGFUL. The same scans against
Debug_enabled show the markers PRESENT: both gated symbols in the exports, and
the code-immediates FD00D001/DD00D001 appearing in the disassembly. So the
absence result above is a real discriminator, not a vacuous scan that would
report "absent" regardless.

FORCE-DOWN MATRIX - VERIFIED. From the self-test outputs: forced v2 ->
effective v2 (actual v3); forced v1 -> effective v1 (actual v3); invalid value
-> "construction refused", error.InvalidForceDownValue, exit 1; absent -> no
force-down, effective = actual = v3. Each active case prints the loud dual-
marker FORCE-DOWN ACTIVE announcement with actual and effective distinct. The
structural force-down-only property holds (effective never exceeds actual).

BUILD-REJECT - VERIFIED. enable_force_down and enable_verbose_detection each
rejected in ReleaseSafe, ReleaseFast, AND ReleaseSmall - six loud panics naming
the Debug requirement, each exit 1. (The consequent "configure phase ...
FileNotFound" lines in the diagnostic index are the EXPECTED downstream of a
build.zig @panic, i.e. the reject working, not a defect.)

7.4 PERTURBATION FIRES - VERIFIED. The deliberately perturbed model produced
`error: Zig 0.16 named-model capture drift: x86_64_v3 feature bmi2` and failed
the build; the clean tree builds green. The drift tripwire works on demand and
the perturbation used a temp COPY, leaving the real source untouched.

UNIT TESTS - VERIFIED. 10/10 tests passed in every mode; the benign
`failed command:` --listen artifact is now correctly classified rather than
treated as failure. 1B.2 regression green in all three modes; native -Dcpu /
-Dtarget override rejection green; one-way dependency audit green.

LLVM QUESTION - STAYS CLOSED. The diagnostic index over the full combined
stream contains no real LLVM error (no "LLVM ERROR", no internal compiler
error, no "unable to emit", no codegen error). The only error: lines are the
intentional negative controls and the expected reject-panic configure-phase
notes. No R76-class miscompile.

## 3. Nothing owed on the implementation

The nine implementation files and the XGETBV source are unchanged since the
accepted post-cx8-fix state (detection source SHA 191e85ea...). All fixes
across v1..v5 were delivery-form or harness only. W3D has no open concern about
the code.

## 4. Minor notes (non-blocking, for the record)

- The detection object's semantic root
  (deblock4_cpu_capability_detection_entry_C001) is present so the object emits
  for inspection; object-mode, not a PE export - consistent with G6.
- The compiler's SSE2 vectorization of the flag-comparison logic is harmless
  and v1-legal; if a future maintainer wants the detection object to be
  visually obvious as scalar-only, that is a cosmetic preference, not a
  requirement - the level contract is satisfied either way.
- manual_disassembly_review_required.txt correctly flags that a HUMAN should
  still eyeball the four 1B.2 within-level disassemblies; that is the standing
  1B.2 obligation, independent of 1B.3 acceptance.

## 5. R3 sign-off and the path to commit

R3 (formal approval of the named-model membership mapping and exclusion
classification) is the last gate before commit. W3D's position: the
classification (classifyModelFeature seed map + exclusions, and the three
captured expected-sets) has now been (a) verified against the primary psABI,
(b) proven internally consistent by both comptime checks compiling green on the
real toolchain, and (c) demonstrated to fail loudly on drift (7.4). W3D APPROVES
the classification for R3 on the evidence. W3X holds final ratification.

Recommended commit sequence:

```text
1. W3X records R3 approval (W3D approves; W3X ratifies).
2. Commit the nine implementation files, build.zig, dll_probe.zig, the standing
   batch (final vN), and the 1B.3 doc artifacts (analyses, this review, the
   cx8 log) into the repository, CRLF per charter v1.19.
3. Update Project Status / Roadmap: Stage 1B.3 COMPLETE; next is the
   filter-creation stage (VS entry point + scaffolding sweep + dispatch wiring
   that consumes the EFFECTIVE record).
4. Retain the inspection_1B3 evidence set with the stage record.
```

## 6. One line for W3X

Clean run, exit 0; W3D independently verified v1-only detection, one guarded
XGETBV, three-surface absence with a live positive control, the full force-down
and build-reject matrices, and the drift perturbation - implementation
ACCEPTED; approve R3 and commit.
