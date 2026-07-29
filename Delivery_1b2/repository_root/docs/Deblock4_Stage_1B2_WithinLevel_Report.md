# Deblock4 Stage 1B.2 Within-Level Report

**Status:** PRE-EXECUTION REVIEW DRAFT
**Scope:** Deblock4_Scope_Stage_1B2_v1_7.md
**Purpose:** Stage 1B.3 hand-forward record
**Encoding:** US-ASCII only

This report is included in the Stage 1B.2 implementation patch for W3D review.
It does not claim that W3X has run the Windows Zig, dumpbin, or batch gates.
Items marked PENDING must be replaced with the actual W3X output before Stage
1B.2 can pass.

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
override is introduced.

The previous feature add and subtract closures are removed. In particular, FMA
is not subtracted from x86_64_v3.

W3X confirmation from the actual Zig 0.16.0 installation:

```text
PENDING: confirm all three named model identifiers compile successfully.
```

---

# 2. Set A - authoritative psABI level membership

The named x86-64 psABI level is the complete feature contract. Levels are
cumulative.

Authority:

```text
System V x86-64 psABI
x86-64-ABI/low-level-sys-info.tex
Micro-Architecture Levels table
https://gitlab.com/x86-psABIs/x86-64-ABI/-/blob/master/x86-64-ABI/low-level-sys-info.tex
```

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

Stage 1B.3 must verify every required member of the selected level. A CPU that
has AVX2 but lacks another v3 member such as BMI2 is not x86_64_v3.

---

# 3. Set B - separate AVX and YMM OS-state requirement

After complete level membership has been established, Stage 1B.3 must perform
the additional runtime state check before any v3 code can execute:

```text
OSXSAVE is present as a v3 level member in set A.
Execute XGETBV for XCR0.
Require the XMM state bit.
Require the YMM state bit.
```

The XCR0 register result is not another psABI feature-level member. It proves
that the operating system is actually preserving the required extended state.

---

# 4. Set C - Zig resolved target and model feature sets

The Stage 1B.2 batch captures Zig 0.16.0 `--show-builtin` output for each named
model:

```text
zig-out/inspection/zig_builtin_x86_64_v1.txt
zig-out/inspection/zig_builtin_x86_64_v2.txt
zig-out/inspection/zig_builtin_x86_64_v3.txt
```

These files are reproducibility evidence. They may include code-generation or
tuning properties that are not runtime CPUID requirements. Stage 1B.3 must not
impose the complete Zig-resolved set as its runtime guard.

Actual resolved model summaries:

```text
x86_64_v1: PENDING W3X execution
x86_64_v2: PENDING W3X execution
x86_64_v3: PENDING W3X execution
```

Any set-C item beyond authoritative set A must be listed here after W3X runs the
batch:

```text
PENDING W3X inspection
```

---

# 5. Set D - per-object within-level inspection

The batch emits complete ReleaseFast disassembly for four objects:

```text
zig-out/inspection/deblock4_backend_probe_generic_disasm.txt
zig-out/inspection/deblock4_backend_probe_scalar_disasm.txt
zig-out/inspection/deblock4_backend_probe_sse41_disasm.txt
zig-out/inspection/deblock4_backend_probe_avx2_disasm.txt
```

Required classification:

```text
generic -> x86_64_v1
scalar  -> x86_64_v1
sse41   -> x86_64_v2
avx2    -> x86_64_v3
```

The automated gate is deliberately conservative:

```text
v1 objects:
    reject VEX and EVEX encodings;
    reject listed v2 and v3 legacy instruction mnemonics;
    reject common optional extensions outside the named levels.

v2 object:
    reject VEX and EVEX encodings;
    reject listed v3 legacy instruction mnemonics;
    reject common optional extensions outside the named levels.

v3 object:
    reject EVEX encodings and common AVX-512 or AMX mnemonic families;
    reject common optional extensions outside the named levels.
```

This automated gate is not claimed to be an exhaustive x86 instruction
classifier. Complete disassembly is retained for W3X manual review. Any
out-of-level instruction found by either path is an overall scope failure.

Results:

```text
generic x86_64_v1 automated gate: PENDING
scalar  x86_64_v1 automated gate: PENDING
sse41   x86_64_v2 automated gate: PENDING
avx2    x86_64_v3 automated gate: PENDING

W3X manual review generic: PENDING
W3X manual review scalar:  PENDING
W3X manual review sse41:   PENDING
W3X manual review avx2:    PENDING
```

Evidence excerpts:

```text
PENDING W3X execution and review
```

---

# 6. Set E - vzeroupper finding

The current v3 probe emits no AVX or YMM instruction because it only returns a
constant `u32`. Therefore no AVX-to-SSE transition exists in the inspected
object and `vzeroupper` is not applicable.

The compiler AVX-transition and `vzeroupper` proof is deferred to Stage 5C,
when the first real Classic v3 function actually uses YMM state. The Deblock4
v3 path may be checked again at Stage 5D.

This is a recorded owed item, not a transition-proof pass.

Actual disassembly confirmation:

```text
PENDING W3X execution and review
```

---

# 7. Set F - Stage 1B.3 input contract

Stage 1B.3 must implement and prove the runtime guard against:

```text
set A - complete authoritative psABI level membership;
set B - the additional XGETBV and XCR0 XMM plus YMM state requirement.
```

Stage 1B.3 must not treat set C as its runtime checklist.

Stage 1B.2 produces these requirements. It does not implement or execute a
runtime capability guard.

---

# 8. Set G - Stage 1B.3 detection diagnostics obligation

Stage 1B.3 must provide diagnostic output capable of reporting:

```text
actual present and absent set-A level members;
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
actual detected set-A members and XCR0 state;
force-down request or mask;
effective post-mask capability and maximum tier;
selected tier and fallback reason.
```

A deliberately masked capability must never be reported as genuinely absent
from the CPU.

---

# 10. Stage 1B.1 regression evidence

The Stage 1B.2 batch preserves and reruns the Stage 1B.1 proof gates:

```text
Debug, ReleaseSafe, and ReleaseFast build and test loop;
required root exports present;
gated markers absent from the PE export table;
anchor names absent from the PE export table;
gated marker symbols defined in their objects;
gated object text sections nonzero;
-Dcpu=native rejected;
-Dtarget=native rejected;
git diff --check;
git status --short.
```

Results:

```text
PENDING W3X execution
```

---

# 11. Final Stage 1B.2 disposition

```text
Implementation review: PENDING W3D
Windows validation:     PENDING W3X
Manual disassembly:     PENDING W3X
Stage result:           NOT YET CLAIMED
```
