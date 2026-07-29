# Deblock4 Stage 1B.2 - Designer Review Delivery

**Version:** 1.0  
**Date:** 2026-07-29  
**Scope:** `Deblock4_Scope_Stage_1B2_v1_7.md`  
**Delivery status:** PRE-EXECUTION PATCH FOR W3D REVIEW  
**Encoding:** US-ASCII only

---

# 1. Delivery files

```text
Deblock4_Stage_1B2_v1_7.patch
Deblock4_Stage_1B2_Designer_Review_v1_0.md
```

Patch SHA-256:

```text
e917784925f78a6381063195b7aa7b7e1a032d48c9456dbb28e70a286ae6d8fb
```

Input identity:

```text
Deblock4_Scope_Stage_1B2_v1_7.md
SHA-256 73dd6069d4ac62c2bcdfbca404d85297c76f8df11db5e93d0a961acd5896983a

src_environment.zip
SHA-256 63d76ba77d17d7df702a0a0726d4a0f25bfc014feeb2827110955dcc89164fd3
```

---

# 2. What the patch adds or changes

Expected changed files:

```text
build.zig
src/backend_probe_sse41.zig
src/backend_probe_avx2.zig
build_1B2_v1.bat
new

docs/Deblock4_Stage_1B2_WithinLevel_Report.md
new
```

No other repository file is changed.

## 2.1 build.zig

The three fixed target queries move from provisional add and subtract closures
to Zig 0.16 named CPU models:

```text
baseline_target     std.Target.x86.cpu.x86_64
sse41_probe_target  std.Target.x86.cpu.x86_64_v2
avx2_probe_target   std.Target.x86.cpu.x86_64_v3
```

The v3 FMA subtraction is removed. No target or CPU command-line override is
introduced. The Stage 1B.1 object wiring, imports, install steps, anchor, and
PE-export mechanism are untouched.

## 2.2 Probe guards

```text
backend_probe_avx2.zig
    deletes the FMA-exclusion compile error;
    retains the positive SSE4.1, AVX, and AVX2 minimum guard;
    explains that the named target plus assembly inspection proves the whole
    level.

backend_probe_sse41.zig
    retains the positive SSE4.1 guard;
    retains the narrow AVX, AVX2, and FMA negative guard;
    changes the message so it no longer claims a complete whole-level test.
```

Marker names, values, calling conventions, object-mode exports, and function
bodies remain unchanged.

## 2.3 New Stage 1B.2 batch

`build_1B2_v1.bat` is a new, factored batch rather than an edit to the historical
Stage 1B.1 batch. It preserves the existing gates and adds:

```text
per-object DISASM:BYTES output for generic, scalar, SSE41, and AVX2 objects;
Zig --show-builtin capture for x86_64, x86_64_v2, and x86_64_v3;
conservative per-level automated deny-list gates;
a mandatory manual-review notice;
no claim of exhaustive automated x86 classification.
```

The batch follows the scope's authoring rules:

```text
fixed absolute project directory;
small CALL subroutines;
plain-token call parameters;
redirection confined to routines;
no risky cmd metacharacters in comments or user-facing messages;
existing loud-fail discipline retained.
```

## 2.4 New hand-forward report

`docs/Deblock4_Stage_1B2_WithinLevel_Report.md` records sets A-H:

```text
A  authoritative psABI level membership;
B  XGETBV and XCR0 XMM plus YMM state requirement;
C  Zig resolved model set for reproducibility only;
D  four-object inspection evidence;
E  vzeroupper deferral to Stage 5C;
F  Stage 1B.3 input contract;
G  future detection diagnostics;
H  future debug-only force-down requirements.
```

The report is deliberately marked PRE-EXECUTION. It contains `PENDING W3X`
fields rather than invented build or disassembly evidence.

---

# 3. Key proof scenario

The patch is designed to prove this bounded Stage 1B.2 sequence:

```text
1. Compile all safe and gated objects against their full named psABI levels.
2. Preserve the accepted Stage 1B.1 linkage and PE-export behaviour.
3. Capture complete ReleaseFast disassembly for each of four backend objects.
4. Fail automatically on each reliably detectable forbidden encoding or
   mnemonic covered by the conservative deny lists.
5. Retain complete disassembly for W3X manual classification of the remainder.
6. Record that the constant-return v3 probe creates no YMM transition and that
   the real vzeroupper proof remains owed at Stage 5C.
7. Capture Zig model output without turning Zig tuning properties into runtime
   Stage 1B.3 CPUID obligations.
8. Preserve rejection of -Dcpu=native and -Dtarget=native.
```

---

# 4. Automated classifier design

The batch does not pretend to implement a complete x86 decoder.

Automated checks include:

```text
all objects
    common optional extensions outside the named levels;

v1 objects
    VEX and EVEX first-byte encodings;
    listed v2 and v3 legacy mnemonics;

v2 object
    VEX and EVEX first-byte encodings;
    listed v3 legacy mnemonics;

v3 object
    EVEX first-byte encodings;
    common AVX-512 opmask and AMX mnemonic families.
```

The batch emits all four complete disassembly files and a manual-review notice.
Any out-of-level instruction found by automation or W3X manual review is an
overall scope failure.

Designer review should particularly assess whether the deny lists are an
acceptable conservative first gate under scope section 3.1. They are not
presented as exhaustive.

---

# 5. Sandbox validation performed

The patch was generated from a clean extraction of the supplied
`src_environment.zip`.

Passed locally:

```text
git apply --check
    PASS

git apply --check --whitespace=error
    PASS

git apply
    PASS in an isolated clean tree

git diff --check after apply
    PASS

ASCII check on all five changed or new files
    PASS

CRLF consistency on all five changed or new files
    PASS

batch structural static check
    PASS
    all CALL arguments are plain tokens
    no redirection or pipe appears in CALL lines
    labels use simple names
    no risky cmd metacharacters appear in echo or REM text
    raw command-block parentheses are balanced
```

Not executable in the Linux sandbox and therefore honestly not claimed:

```text
Zig 0.16 Windows compilation
VsDevCmd setup
MSVC dumpbin gates
Windows smoke-test executables
actual named-model resolution by W3X's installed Zig
actual object instruction classification
actual vzeroupper disassembly finding
```

---

# 6. Designer review points

W3D should review these specific implementation choices before W3X applies the
patch:

```text
1. Direct use of std.Target.x86.cpu.x86_64_v2 and x86_64_v3.
2. Minimal probe-guard edits rather than ad-hoc whole-level guard lists.
3. The factored replacement batch and preservation of every Stage 1B.1 gate.
4. The conservative deny-list plus explicit manual-review design.
5. The --show-builtin capture commands used to populate set C.
6. The PRE-EXECUTION report structure and PENDING evidence fields.
7. The exact Stage 5C vzeroupper deferral wording.
8. The A-H Stage 1B.3 hand-forward obligations.
```

If Zig 0.16 rejects either named model identifier or the `--show-builtin`
command form, stop and report the exact compiler output. Do not replace the
named psABI contract with an ad-hoc feature closure.

---

# 7. Apply sequence for W3X after designer approval

Run from the repository root on the supplied Stage 1B.1 base:

```bat
git status --short
git apply --check Deblock4_Stage_1B2_v1_7.patch
git apply Deblock4_Stage_1B2_v1_7.patch
git diff --check
git status --short
```

Expected status:

```text
 M build.zig
 M src/backend_probe_avx2.zig
 M src/backend_probe_sse41.zig
?? build_1B2_v1.bat
?? docs/Deblock4_Stage_1B2_WithinLevel_Report.md
```

Stop if any other file changes.

---

# 8. W3X validation command

Run the new batch in the normal Windows development environment:

```bat
build_1B2_v1.bat
```

The batch uses its fixed project directory and configures VS 2026 itself.

Expected high-level result:

```text
Debug, ReleaseSafe, and ReleaseFast build and test loops pass;
required root exports remain present;
gated marker and anchor names remain absent from PE exports;
SSE41 and AVX2 object marker symbols remain defined with nonzero text;
all four per-object disassembly files are produced;
automated deny-list gates pass;
manual disassembly review remains explicitly required;
Zig named-model builtin files are produced;
-Dcpu=native and -Dtarget=native remain rejected;
git diff --check passes;
only the five permitted files are changed or new.
```

The report must then be updated with actual W3X output and evidence before a
Stage 1B.2 PASS can be claimed.

---

# 9. Deferred obligations

This patch deliberately does not:

```text
implement Stage 1B.3 detection or dispatch;
execute any gated backend;
add pixel, copy, frame, Classic, or Deblock4 algorithm code;
prove vzeroupper on a real YMM-using kernel;
claim an exhaustive automated instruction classifier;
claim Windows validation that W3C did not run.
```

---

# 10. Review disposition

```text
Patch construction:           COMPLETE
Mechanical sandbox checks:    PASS
W3D design review:            PENDING
W3X Windows execution:        PENDING
W3X manual disassembly:       PENDING
Stage 1B.2 result:            NOT YET CLAIMED
```
