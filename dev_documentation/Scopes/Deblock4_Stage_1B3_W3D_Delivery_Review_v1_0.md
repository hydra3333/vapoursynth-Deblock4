# Deblock4 - Stage 1B.3 W3D Review of the W3C Delivery

Version: v1.0
Date: 2026-07-30
Reviewed delivery: 1B3_W3C_delivery_v1.zip
   (Deblock4_Stage_1B3_W3C_Delivery_Report_v1_0 + repo_overlay + patch +
    STATIC_VALIDATION.txt + MANIFEST_SHA256.txt)
Reviewed against: Deblock4_Scope_Stage_1B3_Runtime_Capability_Guard_v1_3.md and
   charter (G1-G10; v1.17 at delivery time, v1.18 now - see note 0).
Encoding: US-ASCII only
Status: DESIGN-COMPLETE AND STATICALLY SOUND; ACCEPTANCE PENDING THE BUILD/RUN
   EVIDENCE THE PRIOR CODER COULD NOT PRODUCE. No blocking design defect found.

This review is written for the SUCCESSOR coder (the prior coder chat died after
producing this delivery). It is W3D's independent read of the delivered source
against the scope - not a rubber stamp of the coder's own report. Where W3D
verified something directly, it says so. The successor should read this beside
the scope and the delivery, confirm W3D's findings against the actual files,
and then carry out the outstanding build/run work in section E.

---

## 0. Note on charter version

The delivery was authored against charter v1.17. Charter v1.18 has since been
ratified. v1.18 only RECORDS decisions this scope already carried (the
ACTUAL/EFFECTIVE two-record model, the G3 comptime cross-check, the Debug-only
reject, the fix-not-force rule, the single-homes and one-way-dependency
standing rules). Nothing in v1.18 changes what this delivery must satisfy. The
review proceeds against scope v1.3 unaffected.

---

## 1. Overall disposition

The delivery is structurally complete, internally consistent, and faithful to
scope v1.3. Every required file is present with an exact path; the module
architecture, the G10 gating, the detection contract, the two-record model, the
force-down semantics, and the comptime membership cross-check are all
implemented as specified, and in several places implemented BETTER than the
minimum the scope required. W3D found no blocking design defect.

The single material limitation is not a defect in the code: the prior coder's
environment could not run Zig, execute on Windows, or run dumpbin, so
STATIC_VALIDATION.txt is static-only. Therefore NONE of the section 7 runtime,
disassembly, or three-surface absence PROOFS have actually been executed yet.
The delivery is at "ready to build and prove", not "proven". Closing that is the
successor's job (section E).

W3D verified directly:
- all 25 Set-A CPUID bit locations against the scope 1.2 table (every one
  matches);
- the whole-level v2-subset-of-v3 dependency and the XCR0 gating of v3;
- the structural force-down-only property (intersection) and the exhaustive
  clamp test;
- the G3 comptime cross-check logic and its fail-closed behaviour;
- the C-3 gating shape on both debug modules and the one-way dependency
  direction;
- the summary-line format and the deterministic reason rule;
- SHA self-consistency of three sampled files against MANIFEST/STATIC_VALIDATION
  (match);
- the dll_probe.zig line-ending question (see note in section D - it is
  CORRECT, not a defect).

---

## 2. Point-by-point against the scope

### Detection contract (1.2) - PASS (verified)

`src/cpu_capability_detection.zig` reads exactly the pinned locations. W3D
checked each: v1 EDX bits (CMOV 15, CX8 8, FPU 0, FXSR 24, MMX 23, SSE 25,
SSE2 26); v2 (SSE3 ECX.0, SSSE3 ECX.9, CMPXCHG16B ECX.13, SSE4.1 ECX.19,
SSE4.2 ECX.20, POPCNT ECX.23, LAHF-SAHF 80000001H:ECX.0); v3 (FMA ECX.12,
MOVBE ECX.22, OSXSAVE ECX.27, AVX ECX.28, F16C ECX.29, AVX2 07H:EBX.5,
BMI1 EBX.3, BMI2 EBX.8, LZCNT 80000001H:ECX.5). Leaf guards present
(max_basic>=7 before leaf 7; max_extended>=0x80000001 before the extended
leaf), and features in an unavailable leaf are forced detected_absent. XGETBV
is executed ONLY when OSXSAVE is present; XCR0 test is (xcr0_raw & 0x6)==0x6.
OSFXSR/SCE are hardcoded policy_assumed_present and never read. This is exactly
the contract.

### Whole-level resolution (G3) - PASS (verified)

v2 requires all seven v2 additions AND v1; v3 requires all nine v3 additions
AND v2 AND the XCR0 state. resolved_tier picks highest satisfied, v1 floor. No
headline-instruction shortcut anywhere.

### Two-record model (B1/G1) - PASS

ActualCapabilities (process-wide, immutable, via a hand-rolled atomic
once-guard) and EffectiveCapabilities (per-instance, actual INTERSECT ceiling).
Effective is computed once at initInstanceCapabilities. Dispatch is not wired
(correct: out of scope).

### Force-down seam (H / 5.x) - PASS (verified structural property)

`src/force_down_debug.zig`, C-3 gated under enable_force_down, separate module,
own gate, announcement lives here. Non-allocating GetEnvironmentVariableW into a
fixed [8]u16 buffer. Values: exactly "v1"/"v2" accepted; absent -> null;
empty -> invalid; overlong -> invalid; any other acquisition failure -> @panic;
otherwise -> InvalidForceDownValue. Ceiling enum has NO v3 value. The force-down
is structural intersection in applyCeiling: every effective bit is
`allowed_level AND isPresent(actual.bit)`, so nothing can raise capability. This
is the fix-not-force property proven by construction, not just asserted.

### Comptime membership cross-check (B6 / 3.6) - PASS, EXCEEDS SCOPE (verified)

Two independent comptime checks:
1. verifyNamedModelMembership classifies every Zig x86 model feature via
   classifyModelFeature (the scope seed map x87<->FPU, cx16<->CMPXCHG16B,
   sahf<->LAHF-SAHF, bmi<->BMI1; exclusions 64bit, crc32, xsave, and the full
   tuning-flag set) and asserts each classified member appears in exactly the
   right level set-differences; an UNCLASSIFIED model feature hits `else =>
   null` -> @compileError. Fail-closed, as required.
2. verifyCapturedModelSet additionally pins the EXACT feature set of each named
   model (14/26/38 entries) so ANY change to a model - even a tuning flag -
   fails the build loudly. This is stronger than 3.6 asked and is a genuinely
   good drift tripwire.

The completed mapping/exclusion list is thereby embodied in code and must be
APPROVED by W3X/W3D per R3 before the implementing commit. W3D's read: the
classification is correct (it matches the prior coder's capture analysis, which
W3D previously checked). Formal approval is a live checklist item (section E).

### Diagnostics split (4.1/4.2, README 13.6) - PASS (verified format)

Always-on summary in print_helper_functions.emitInstanceSummary:
`deblock4: <version> <name> backend=<requested> tier=<effective>` with the
reason clause appended only when a reason exists. Deterministic reason rule
implemented in summaryReason: force-down active -> reason=forced-down(<ceiling>)
actual=<actual> (precedence); else all missing features of the level
immediately above the resolved actual tier in table order, XCR0 failure as the
pseudo-feature "XCR0.YMM"; else no clause. Verbose per-bit dump is debug-only in
print_diag_helper_functions and renders OSFXSR/SCE as "OS baseline assumed
(Windows x64 process policy)". Correct.

### Module skeleton and single-homes (2.x, C-STY-09) - PASS (verified)

deblock4_config.zig is declarations-only (no functions), shallow namespaces
(debug/tier/diag/plugin), holds plugin.version_string. print_helper_functions
is the always-on home. The two gated modules are separate, each with its own
gate, no import between them. Import name deblock4_build_options throughout.

### One-way dependency / sweep test (2.6, C-STY-10) - PASS (verified)

W3D checked: the first-class modules import only each other and std/builtin;
none reference the probe/smoke/scaffolding files. The coder's static audit
reports the same. (The successor should re-run this textual audit after any
change, per 7.5.)

### Self-test executable (2.5, B5) - PASS (design)

`deblock4_selftest.zig` builds from the same modules as the DLL; exercises
once-pointer identity, the v3-host positive case (all features present, XCR0
present), and requested-backend-does-not-alter-capability. This is the CNR3
model realised. Whether it PASSES is a run item (section E).

### build.zig (6) - PASS (verified structure)

Options enable_force_down / enable_verbose_detection (default false); hard
`@panic` if either is true and optimize != Debug; both fed via addOptions as
deblock4_build_options into every module that imports them (DLL root, selftest,
detection object, capability tests, dll_probe tests). Steps present: selftest,
selftest-run, detection-object (an addObject of the detection unit at the
BASELINE v1 target, installed to detection-objects/, exactly what 7.2 needs),
and test (wiring the capability unit tests). The DLL still links the 1B.2
backend objects unchanged.

### Clamp unit tests (B3 / 7.1) - PASS (verified)

Two tests over fabricatedActual: an exhaustive nine-combination actual x ceiling
matrix asserting effective never exceeds actual, the per-feature intersection
property, and the XCR0 constraint; plus an at-or-above-actual case asserting the
loud forced-down summary reason. Pure functions; no synthetic seam in production
paths. Exactly the B3 design.

### dll_probe.zig minimal addition (2.1) - PASS (verified)

One added call to initInstanceCapabilities("dll-probe", .auto) so the release
DLL genuinely constructs a capability record and imports the modules (absence
proof stays meaningful). No other change. Line endings preserved (see D).

### Standing gate batch (R5 / 7.3) - PASS (design; unrun)

`build_1B3_v1.bat` is the single root-level runner. By inspection it covers: the
1B.2 regression batch; ReleaseSafe and ReleaseFast production builds with
three-surface absence scans (strings, dumpbin /EXPORTS, dumpbin /DISASM) over
BOTH the DLL and the release selftest exe for BOTH gated modules' markers; the
Debug positive control proving markers PRESENT; the force-down behaviour matrix
(absent / v1 / v2 / invalid); and the non-Debug build-reject checks. Structure
is correct and consistent with the markers actually present in the source.
Whether it PASSES end-to-end is the central run item.

---

## 3. Things done better than required (worth keeping)

- The second comptime check (verifyCapturedModelSet) pins whole model sets, not
  just membership deltas - a stronger drift guard than 3.6 required.
- Dual markers per gated module: a unique STRING and a unique CODE IMMEDIATE
  (0xFD00D001 / 0xDD00D001), each with a retained probe export, giving the
  three-surface proof a real target on all three surfaces including a positive
  control that needs no runtime call.
- The object-mode semantic root (standalone_mode_root) so the detection object
  emits fully for the 7.2 baseline-v1 disassembly, while noting object-mode
  export is not a PE-export doorway (correct G6 reasoning).

---

## 4. Minor observations (NOT blockers; for the successor to note, not fix blindly)

- D1 (line endings). dll_probe.zig is delivered as LF; every new file is CRLF.
  W3D checked the repository: the ORIGINAL dll_probe.zig is LF, so preserving LF
  on the modified existing file is CORRECT per C-DELIV-04 (replacement is not a
  licence for unrelated reformatting). Do not "fix" it to CRLF. The static
  validator flagged bare-LF=23 for that file as information, not error.

- D2 (once-mechanism). detectActualOnce is a hand-rolled atomic CAS spin rather
  than std.once. This is within the coder's stated latitude (5A). It looks
  correct (idle->running->complete with acquire/release; the running branch
  spins on the acquire load). The successor and W3X should confirm it behaves
  under the actual fmParallel construction pattern when the filter stage wires
  it; for 1B.3 the selftest's twice-called pointer-identity check is the proof.

- D3 (asm operand names). The cpuid/xgetbv wrappers use the anonymous `[_]`
  operand-name form. This is the item the scope explicitly said the coder must
  VERIFY by compilation (3.5 non-normative reference). It has NOT been compiled
  in the coder's environment. The successor must confirm it assembles under Zig
  0.16.0 and that EBX/RBX are handled correctly (the dumpbin /DISASM of the
  baseline detection object in 7.2 is the direct evidence).

- D4 (the one `unreachable`). In initInstanceCapabilities the switch arm
  `.x86_64_v3 => unreachable` is provably safe: the ceiling local is built only
  from Ceiling{v1,v2}, so v3 cannot occur. Correct, but the successor should
  keep it that way if refactoring.

---

## 5. What has NOT been proven yet (the acceptance gap)

Because the delivery is static-only, EVERY runtime and binary-inspection proof
in scope section 7 is still OPEN:

```text
7.1  self-test PASS on the v3 host; force-down v2/v1/invalid/absent behaviour;
     unit-test clamp matrix green under `zig build test`
7.2  baseline-v1 detection object contains NO v2/v3 instructions (dumpbin
     /DISASM); XGETBV only on the OSXSAVE path
7.3  three-surface ABSENCE of both gated modules' markers in ReleaseSafe AND
     ReleaseFast, on BOTH the DLL and the release selftest exe; the Debug
     positive control showing markers PRESENT; the non-Debug build-reject
     failing as required
7.4  the comptime cross-check compiles clean, AND a demonstrated-then-reverted
     one-feature perturbation produces the named @compileError
7.5  the one-way dependency textual audit returns empty (coder ran it
     statically; keep it green)
7.x  1B.2 regression still green with the new modules present
```

None of these is a design change; they are the build-and-run closure the prior
coder could not perform.

---

## E. Actions for the successor coder (in order)

1. Confirm the exact base: apply the delivered patch (or use the repo_overlay)
   onto the current main tree; verify the nine changed files match and nothing
   else changed. The delivery is a whole set of new files plus a minimal
   build.zig and dll_probe.zig edit.

2. FIRST verify the inline asm (D3) in an isolated compile, per the coder's own
   stated sequence and scope 3.5: build the baseline detection object
   (`zig build detection-object`) and read its dumpbin /DISASM. This closes both
   the asm-correctness question and 7.2 (v1-only) at once. If the `[_]` operand
   form or the EBX handling is wrong, fix it and report the corrected form back
   to W3X/W3D - do not silently adopt.

3. Run `build_1B3_v1.bat` and capture the full output. It is designed to be the
   single standing runner for the whole section-7 matrix. Paste the complete
   result to W3X.

4. Produce the 7.4 evidence: show the cross-check compiling clean, then a
   deliberately perturbed one-feature classification producing the named
   @compileError, then reverted. This is required evidence, not optional.

5. Submit the completed mapping/exclusion classification (it is embodied in
   classifyModelFeature + the three captured sets) for explicit W3X/W3D approval
   per R3 BEFORE the implementing commit is accepted. W3D's provisional read is
   that it is correct; formal sign-off is still required.

6. If anything above fails or is ambiguous, state it and stop (charter H1); do
   not resolve a scope/charter tension in code. Route design-level questions
   back through W3X to W3D.

Do NOT treat this review as acceptance. Acceptance is W3X building and running
the delivery and W3D reviewing that evidence. This review establishes only that
the delivered SOURCE is design-complete and scope-faithful, with the specific
run-time closures above still owed.

---

## F. One-line summary for W3X

Design-complete, scope-faithful, no blocking defect; static-only, so the entire
section-7 build/run/disassembly/absence proof set is still owed - have the
successor verify the asm via the baseline detection object first, then run
build_1B3_v1.bat, then produce the @compileError-fires evidence, then bring the
membership classification for formal R3 approval before commit.
