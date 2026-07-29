# Deblock4 Stage 1B.2 Within-Level Report

**Status:** EXECUTED - TECHNICAL EVIDENCE PASS; FINAL REPOSITORY-STATE RERUN PENDING  
**Scope:** Deblock4_Scope_Stage_1B2_v1_7.md  
**Purpose:** Stage 1B.3 hand-forward record  
**W3X execution platform:** Ryzen 3900X, Windows 11, Visual Studio 2026 Developer Command Prompt v18.8.1, Zig 0.16.0  
**W3C manual inspection:** Completed 2026-07-30  
**Encoding:** US-ASCII only

This report records the actual Stage 1B.2 build, export, symbol, disassembly and
Zig named-model evidence supplied by W3X.

The technical evidence passes. Overall Stage 1B.2 PASS is not yet claimed
because the execution log showed a forbidden deletion of the historical
`build_1B1_v7_3.bat`, unrelated untracked delivery/review files, and the
evolved batch had not yet been placed under its final authorised repository
name `build_1B2_v1.bat`. Those repository-state matters require correction and
one final exact-state rerun.

---

# 1. Chosen target-definition mechanism

The implementation uses Zig 0.16 named x86 CPU models directly:

```text
x86_64_v1 -> std.Target.x86.cpu.x86_64
x86_64_v2 -> std.Target.x86.cpu.x86_64_v2
x86_64_v3 -> std.Target.x86.cpu.x86_64_v3
```

Each target remains fixed to Windows x86-64 with the MSVC ABI. No
`standardTargetOptions` call, `-mcpu=native`, or user `-Dcpu` or `-Dtarget`
override was introduced.

The previous feature add/subtract closures were removed. In particular, FMA
is not subtracted from `x86_64_v3`.

Actual Zig 0.16.0 confirmation:

```text
x86_64 model:    COMPILED AND REPORTED
x86_64_v2 model: COMPILED AND REPORTED
x86_64_v3 model: COMPILED AND REPORTED
```

Result:

```text
PASS
```

---

# 2. Set A - authoritative psABI level membership

The named x86-64 psABI level is the complete feature contract. Levels are
cumulative.

## x86_64_v1

```text
CMOV
CX8
FPU
FXSR
MMX
OSFXSR
SCE
SSE
SSE2
```

## x86_64_v2 additions

```text
CMPXCHG16B
LAHF-SAHF
POPCNT
SSE3
SSSE3
SSE4.1
SSE4.2
```

## x86_64_v3 additions

```text
AVX
AVX2
BMI1
BMI2
F16C
FMA
LZCNT
MOVBE
OSXSAVE
```

Stage 1B.3 must verify every required member of the selected level. A CPU with
AVX2 but without another required v3 member, such as BMI2, is not
`x86_64_v3`.

---

# 3. Set B - separate AVX/YMM OS-state requirement

After complete level membership has been established, Stage 1B.3 must perform
the additional runtime state check before any v3 code can execute:

```text
OSXSAVE is present as a v3 level member in Set A.
Execute XGETBV for XCR0.
Require the XMM state bit.
Require the YMM state bit.
```

The XCR0 result is not another psABI feature-level member. It proves that the
operating system is actually preserving the required extended state.

---

# 4. Set C - Zig resolved target/model feature sets

The Stage 1B.2 batch captured Zig 0.16.0 `--show-builtin` output for each named
model.

## 4.1 x86_64_v1 resolved set

```text
64bit
cmov
cx8
fxsr
idivq_to_divl
macrofusion
mmx
nopl
slow_3ops_lea
slow_incdec
sse
sse2
vzeroupper
x87
```

## 4.2 x86_64_v2 resolved set

```text
64bit
cmov
crc32
cx16
cx8
false_deps_popcnt
fast_15bytenop
fast_scalar_fsqrt
fast_shld_rotate
fxsr
idivq_to_divl
macrofusion
mmx
nopl
popcnt
sahf
slow_3ops_lea
slow_unaligned_mem_32
sse
sse2
sse3
sse4_1
sse4_2
ssse3
vzeroupper
x87
```

## 4.3 x86_64_v3 resolved set

```text
64bit
allow_light_256_bit
avx
avx2
bmi
bmi2
cmov
crc32
cx16
cx8
f16c
false_deps_lzcnt_tzcnt
false_deps_popcnt
fast_15bytenop
fast_scalar_fsqrt
fast_shld_rotate
fast_variable_crosslane_shuffle
fast_variable_perlane_shuffle
fma
fxsr
idivq_to_divl
lzcnt
macrofusion
mmx
movbe
nopl
popcnt
sahf
slow_3ops_lea
sse
sse2
sse3
sse4_1
sse4_2
ssse3
vzeroupper
x87
xsave
```

Set C is reproducibility evidence, not a one-to-one Stage 1B.3 runtime CPUID
checklist.

Examples of compiler code-generation or tuning properties in Set C include:

```text
allow_light_256_bit
false_deps_lzcnt_tzcnt
false_deps_popcnt
fast_15bytenop
fast_scalar_fsqrt
fast_shld_rotate
fast_variable_crosslane_shuffle
fast_variable_perlane_shuffle
idivq_to_divl
macrofusion
nopl
slow_3ops_lea
slow_incdec
slow_unaligned_mem_32
vzeroupper
```

Important observed distinction:

```text
Zig x86_64_v3 Set C contains `xsave`.
The resolved model output does not expose an `osxsave` model feature.
```

This does not alter the settled psABI contract. Stage 1B.3 must use
authoritative Set A, including the required OSXSAVE CPUID bit, and then
separately perform the Set B XGETBV/XCR0 state check.

Result:

```text
PASS - named model evidence captured and Set C kept distinct from Set A/B
```

---

# 5. Set D - per-object within-level inspection

The batch emitted complete ReleaseFast disassembly for four objects:

```text
zig-out\inspection\deblock4_backend_probe_generic_disasm.txt
zig-out\inspection\deblock4_backend_probe_scalar_disasm.txt
zig-out\inspection\deblock4_backend_probe_sse41_disasm.txt
zig-out\inspection\deblock4_backend_probe_avx2_disasm.txt
```

Required classification:

```text
generic -> x86_64_v1
scalar  -> x86_64_v1
sse41   -> x86_64_v2
avx2    -> x86_64_v3
```

The automated deny-list gates passed for all four objects.

W3C manually reviewed every emitted instruction.

## 5.1 Generic object - x86_64_v1

```text
55                 push rbp
48 89 E5           mov  rbp,rsp
B8 10 34 42 44     mov  eax,44423410h
5D                 pop  rbp
C3                 ret
```

Every instruction is valid at x86_64_v1.

```text
Automated gate: PASS
Manual review:  PASS
```

## 5.2 Scalar object - x86_64_v1

```text
55                 push rbp
48 89 E5           mov  rbp,rsp
B8 11 34 42 44     mov  eax,44423411h
5D                 pop  rbp
C3                 ret
```

Every instruction is valid at x86_64_v1.

```text
Automated gate: PASS
Manual review:  PASS
```

## 5.3 SSE4.1 object - within x86_64_v2

```text
55                 push rbp
48 89 E5           mov  rbp,rsp
B8 12 34 42 44     mov  eax,44423412h
5D                 pop  rbp
C3                 ret
```

Every instruction is valid at x86_64_v1 and therefore within x86_64_v2. No
instruction requires x86_64_v3 or later.

```text
Automated gate: PASS
Manual review:  PASS
```

## 5.4 AVX2 object - within x86_64_v3

```text
55                 push rbp
48 89 E5           mov  rbp,rsp
B8 13 34 42 44     mov  eax,44423413h
5D                 pop  rbp
C3                 ret
```

Every instruction is valid at x86_64_v1 and therefore within x86_64_v3. No
AVX-512, EVEX, AMX, or other instruction requiring a level above v3 is present.

```text
Automated gate: PASS
Manual review:  PASS
```

Overall Set D result:

```text
PASS
```

The v2 and v3 objects are permitted to emit only lower-level instructions. The
named target is a maximum allowed contract, not a requirement that trivial
marker code exercise every feature in the level.

---

# 6. Set E - vzeroupper finding

The current v3 probe emits no AVX or YMM instruction because it only returns a
constant `u32`.

No AVX-to-SSE transition exists in the inspected object, so no `vzeroupper`
instruction is applicable. Its absence is correct and is not a failure.

```text
Stage 1B.2 observation: PASS
Real AVX/YMM transition proof: DEFERRED to Stage 5C
```

The real compiler transition proof remains owed for the first actual Classic
v3/YMM-using kernel. The Deblock4 v3 path may be checked again at Stage 5D.

---

# 7. Set F - Stage 1B.3 input contract

Stage 1B.3 must implement and prove the runtime guard against:

```text
Set A - complete authoritative psABI level membership;
Set B - additional XGETBV/XCR0 XMM plus YMM state requirement.
```

Stage 1B.3 must not treat Set C as its runtime checklist.

Stage 1B.2 produces these requirements. It does not implement or execute a
runtime capability guard.

---

# 8. Set G - Stage 1B.3 detection diagnostics obligation

Stage 1B.3 must provide diagnostic output capable of reporting:

```text
actual present and absent Set-A level members;
selected tier name;
requested backend token;
fallback reason when a higher tier is not selected;
plugin and filter version information required by the controlling documents.
```

Per-bit detail is a debug diagnostic and remains quiet on normal runs. The
standing version, requested-token, selected-tier, and fallback output remains
once per filter-instance creation.

---

# 9. Set H - Stage 1B.3 debug-only force-down obligation

Stage 1B.3 may provide a debug-only force-down seam for fallback testing.

It must satisfy all of these conditions:

```text
It may only mask real capabilities and select a lower tier.
It must never manufacture a missing capability.
A forced higher tier must be structurally impossible.
The seam and its code must be compiled out of release binaries.
Activation must be loudly announced.
```

When active, diagnostics must distinguish:

```text
actual detected Set-A members and XCR0 state;
force-down request or mask;
effective post-mask capability and maximum tier;
selected tier and fallback reason.
```

A deliberately masked capability must never be reported as genuinely absent
from the CPU.

---

# 10. Stage 1B.1 regression evidence

The Stage 1B.2 batch reran the Stage 1B.1 proof gates.

## 10.1 Build and runtime loop

Debug, ReleaseSafe and ReleaseFast each completed:

```text
zig build
zig build run
zig build vs-header-run
zig build test
deblock4_dll_smoke_test.exe
zig build backend-isolation-run
```

Result:

```text
PASS in all three modes
```

## 10.2 PE export table

Required exports present:

```text
deblock4_build_probe_value
deblock4_backend_probe_generic_marker
deblock4_backend_probe_scalar_marker
```

Gated markers absent:

```text
deblock4_backend_probe_sse41_marker
deblock4_backend_probe_avx2_marker
```

Anchor names absent.

Result:

```text
PASS
```

## 10.3 Gated object symbols and text

SSE4.1 object:

```text
marker defined on SECT1
.text length B
```

AVX2 object:

```text
marker defined on SECT1
.text length B
```

Result:

```text
PASS
```

## 10.4 Retention in linked DLL

The whole-DLL disassembly contains both gated marker functions and their
expected constants:

```text
SSE4.1 marker -> 44423412h
AVX2 marker   -> 44423413h
```

Result:

```text
PASS
```

## 10.5 Override rejection

```text
-Dcpu=native:    rejected with exit code 1
-Dtarget=native: rejected with exit code 1
```

Result:

```text
PASS
```

## 10.6 Whitespace gate

```text
git diff --check: PASS
```

---

# 11. Remaining repository-state actions

The execution log showed this forbidden deletion:

```text
D build_1B1_v7_3.bat
```

Restore it before final acceptance:

```bat
git restore -- build_1B1_v7_3.bat
```

Place the final evolved batch under the authorised scope filename:

```text
build_1B2_v1.bat
```

Move unrelated delivery/review files outside the coding-scope working tree.

The final permitted status must be exactly:

```text
M  build.zig
M  src/backend_probe_avx2.zig
M  src/backend_probe_sse41.zig
?? build_1B2_v1.bat
?? docs/Deblock4_Stage_1B2_WithinLevel_Report.md
```

Then rerun:

```bat
build_1B2_v1.bat
```

and confirm the final exact status.

---

# 12. Current Stage 1B.2 disposition

```text
Named target models:                PASS
Windows build/test loop:            PASS
Stage 1B.1 export regression:       PASS
Stage 1B.1 symbol/text regression:  PASS
Gated object retention:             PASS
Automated within-level gates:       PASS
W3C manual four-object review:      PASS
Set C evidence review:              PASS
vzeroupper Stage 1B.2 observation:  PASS with Stage 5C deferral
Completed A-H report:               PASS
Final repository-state gate:        PENDING CORRECTION AND RERUN
Overall Stage 1B.2 result:           NOT YET CLAIMED
```

No code-generation or tiering defect was found in the Stage 1B.2 evidence.
