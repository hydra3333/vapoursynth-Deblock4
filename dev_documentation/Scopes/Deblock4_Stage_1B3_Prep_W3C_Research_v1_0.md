# Deblock4 Stage 1B.3 Prep - W3C Research Findings

Version: v1.0
Date: 2026-07-30
Audience: W3X / W3D
Status: Research findings only; not an implementation scope
Encoding: US-ASCII only

This report answers both research tasks in
`Deblock4_Stage_1B3_Prep_Coder_Research_Tasks_v1_0.md`.

The two principal conclusions are:

1. The starting Set-A list needs several corrections before it becomes the
   Stage 1B.3 runtime detection contract.
2. Zig 0.16.0 does provide an `#ifdef`-strength binary-omission mechanism:
   a build option imported as a comptime-known constant, used in an `if`
   condition. Zig guarantees that the untaken branch is not analyzed and its
   runtime code is eliminated. For maximum structural separation, put the
   complete force-down seam in a separate module imported only inside the
   compile-time-true branch, and reject enabling it for non-Debug artifacts.

Source keys are listed in section 8.

---

# PART A - Authoritative Set-A level membership and CPUID mapping

## A.1 Authoritative psABI membership

The official x86-64 psABI microarchitecture-level table defines these
cumulative levels.

### Baseline / x86_64_v1

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

### x86_64_v2 additions

```text
CMPXCHG16B
LAHF-SAHF
POPCNT
SSE3
SSE4.1
SSE4.2
SSSE3
```

### x86_64_v3 additions

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

The psABI explicitly states that the levels are cumulative and that v3 is
available only after the complete processor-prescribed enablement sequence,
including verification of the relevant XCR0 state with XGETBV. [S1]

## A.2 Exact feature-location table

Notation:

```text
CPUID.01H means EAX input 00000001H.
CPUID.07H.0 means EAX input 00000007H, ECX subleaf 0.
CPUID.80000001H means EAX input 80000001H.
```

### Baseline / x86_64_v1

| Level | Feature | Required location | Runtime interpretation |
|---|---|---|---|
| v1 | CMOV | CPUID.01H:EDX bit 15 | CPU supports conditional-move instructions. |
| v1 | CX8 | CPUID.01H:EDX bit 8 | CPU supports CMPXCHG8B. |
| v1 | FPU | CPUID.01H:EDX bit 0 | CPU has the x87 FPU. |
| v1 | FXSR | CPUID.01H:EDX bit 24 | CPU supports FXSAVE/FXRSTOR. |
| v1 | MMX | CPUID.01H:EDX bit 23 | CPU supports MMX. |
| v1 | OSFXSR | CR4.OSFXSR, bit 9; not a CPUID membership bit | OS has enabled FXSAVE/FXRSTOR support for SSE state. Not directly readable in ordinary user mode. |
| v1 | SCE | IA32_EFER.SCE, bit 0; not a CPUID membership bit | OS has enabled SYSCALL/SYSRET. Not directly readable in ordinary user mode. |
| v1 | SSE | CPUID.01H:EDX bit 25 | CPU supports SSE. |
| v1 | SSE2 | CPUID.01H:EDX bit 26 | CPU supports SSE2. |

Important qualification:

The official psABI says that most level names correspond to CPUID bits, but
specifically identifies OSFXSR and SCE as exceptions controlled by CR4 and
IA32_EFER. Therefore the requested premise "map every v1 Set-A member to a
CPUID bit" is not literally achievable. [S1]

There is a CPUID capability advertisement for SYSCALL/SYSRET at
CPUID.80000001H:EDX bit 11, but that does not prove that IA32_EFER.SCE is
enabled. It is therefore not a substitute for the official SCE enabled-state
requirement.

For this Windows x64 plugin, the clean policy candidate is to retain x86_64_v1
as the unconditional final fallback because successful loading into a 64-bit
Windows process already establishes the operating-system baseline. This is
consistent with the settled project architecture, but it is a W3X/W3D policy
statement rather than a conclusion that should be silently inserted into the
coder scope.

### x86_64_v2 additions

| Level | Feature | CPUID query |
|---|---|---|
| v2 | CMPXCHG16B | CPUID.01H:ECX bit 13 |
| v2 | LAHF-SAHF | CPUID.80000001H:ECX bit 0 |
| v2 | POPCNT | CPUID.01H:ECX bit 23 |
| v2 | SSE3 | CPUID.01H:ECX bit 0 |
| v2 | SSE4.1 | CPUID.01H:ECX bit 19 |
| v2 | SSE4.2 | CPUID.01H:ECX bit 20 |
| v2 | SSSE3 | CPUID.01H:ECX bit 9 |

### x86_64_v3 additions

| Level | Feature | CPUID query |
|---|---|---|
| v3 | AVX | CPUID.01H:ECX bit 28 |
| v3 | AVX2 | CPUID.07H.0:EBX bit 5 |
| v3 | BMI1 | CPUID.07H.0:EBX bit 3 |
| v3 | BMI2 | CPUID.07H.0:EBX bit 8 |
| v3 | F16C | CPUID.01H:ECX bit 29 |
| v3 | FMA | CPUID.01H:ECX bit 12 |
| v3 | LZCNT | CPUID.80000001H:ECX bit 5 |
| v3 | MOVBE | CPUID.01H:ECX bit 22 |
| v3 | OSXSAVE | CPUID.01H:ECX bit 27 |

Intel's published feature-detection material independently confirms the
principal leaf-1 and leaf-7 mappings, including AVX, AVX2, BMI1, BMI2, F16C,
FMA, POPCNT and the SSE family. [S2] [S3]

## A.3 Required leaf-availability guards

Before querying optional leaves, the detector must verify that they exist.

```text
CPUID.0:EAX             >= 7          before CPUID.07H.0
CPUID.80000000H:EAX     >= 80000001H  before CPUID.80000001H
```

If a required leaf is unavailable, every feature located in that leaf must be
treated as absent. The detector must not read a nonexistent leaf and infer
support from unspecified output.

## A.4 Discrepancies against the supplied starting list

### Remove `64bit` from Set-A level membership

`64bit` appears in Zig's resolved target feature set, but it is not a row in
the psABI microarchitecture-level table. The x86-64 architecture is the
precondition for all these levels.

If a separate environmental assertion is wanted, long-mode capability is
advertised by CPUID.80000001H:EDX bit 29. In this project, however, a loaded
64-bit DLL is already executing in a 64-bit process, so this is not a
v1/v2/v3 discriminator.

Disposition:

```text
Remove from the Set-A level-membership list.
Optionally retain as a documented architecture precondition.
```

### Add FPU

The starting v1 list omitted the psABI-required FPU row.

```text
Add FPU: CPUID.01H:EDX bit 0.
```

### Add OSFXSR

The starting v1 list omitted OSFXSR.

```text
Add as an official v1 member, but mark it as CR4.OSFXSR state rather than a
CPUID bit.
```

### Add SCE

The starting v1 list omitted SCE.

```text
Add as an official v1 member, but mark it as IA32_EFER.SCE state rather than a
CPUID bit.
```

### Retain `sahf`, but rename it

Zig's `sahf` item corresponds to the official psABI feature LAHF-SAHF.

```text
Retain the requirement as LAHF-SAHF:
CPUID.80000001H:ECX bit 0.
```

### Remove independent `crc32`

The official v2 level contains SSE4.2, not a separate CRC32 row. CRC32 is part
of the SSE4.2 instruction extension and is enumerated by the SSE4.2 CPUID bit.

```text
Do not add a second CPUID check for Zig's `crc32` target feature.
SSE4.2 at CPUID.01H:ECX bit 20 is the authoritative v2 membership check.
```

### Remove independent `xsave`

The official v3 level lists OSXSAVE, not XSAVE, as a level member.

```text
Remove XSAVE from Set-A membership.
Retain OSXSAVE: CPUID.01H:ECX bit 27.
```

A detector may defensively observe CPUID.01H:ECX bit 26 (XSAVE), but it must
not report XSAVE as an additional psABI v3 membership requirement unless W3X
explicitly adopts a project-local supplemental invariant. OSXSAVE cannot
architecturally be set without the underlying XSAVE facility and OS
enablement.

## A.5 Correct Set-A / Set-B seam

The starting document's one-line OSXSAVE wording needs refinement.

The three distinct layers are:

```text
CPUID.01H:ECX.XSAVE bit 26:
    Processor supports XSAVE/XRSTOR/XSETBV/XGETBV facilities.

CPUID.01H:ECX.OSXSAVE bit 27:
    The operating system has set CR4.OSXSAVE and enabled extended-state
    management. This is the official psABI v3 membership row.

XGETBV(ECX=0), XCR0 bits 1 and 2:
    XMM state and YMM state are enabled in the OS-managed state set.
```

For AVX-family code, the usable-state test is:

```text
(XCR0 & 0x6) == 0x6
```

The additional XCR0 test is required before executing instructions whose
usability depends on AVX state:

```text
AVX
AVX2
F16C
FMA
```

BMI1, BMI2, LZCNT and MOVBE do not individually require XMM/YMM state.
However, an object compiled for the complete x86_64_v3 target may contain AVX
instructions anywhere the compiler is permitted to generate them. Therefore
the whole v3 tier must remain unavailable unless the Set-B XMM+YMM state test
passes.

The official psABI expressly requires the full XCR0 verification sequence for
v3 rather than treating CPUID membership alone as sufficient. [S1]

## A.6 Recommended detection contract for the 1B.3 scope

The scope should express the detector in this order:

```text
1. Detect and record actual CPUID features.
2. Determine complete v2 membership from all seven v2 additions.
3. Determine complete v3 membership from:
   - complete v2 membership;
   - all nine official v3 additions, including OSXSAVE;
   - Set-B XGETBV(0) XCR0 XMM+YMM state.
4. Apply an optional debug-only force-down ceiling by intersection/minimum
   only; never manufacture capabilities.
5. Select the highest whole level:
   v3 -> v2 -> v1.
6. Keep v1 as the unconditional final fallback under the settled Windows x64
   project policy.
```

No shorthand such as "AVX2 means v3" or "SSE4.2 means v2" is sufficient.

---

# PART B - Compiling the force-down seam out of release

## B.1 Direct answer

Yes. Zig 0.16.0 has a genuine structural mechanism that meets the project's
"must not exist in the release binary" requirement.

It is not a textual preprocessor. The equivalent is:

```text
build option -> generated options module -> comptime-known `if`
```

Zig's official documentation states that build Options values imported into
source are comptime-known. It also states that when an `if` condition is
known at compile time, the compiler guarantees that the untaken branch is
not analyzed and that compile-time-only code is eliminated, including in a
Debug build. [S4] [S5]

Therefore this is not merely a runtime branch that an optimiser might remove.
The language semantics perform branch exclusion before runtime code
generation.

## B.2 Zig 0.16.0 build-system spelling

Minimal `build.zig` pattern:

```zig
const std = @import("std");

pub fn build(b: *std.Build) void {
    const optimize = b.standardOptimizeOption(.{});

    const enable_force_down =
        b.option(
            bool,
            "enable_force_down",
            "Compile the debug-only force-down test seam",
        ) orelse false;

    if (enable_force_down and optimize != .Debug) {
        @panic("-Denable_force_down=true requires -Doptimize=Debug");
    }

    const build_options = b.addOptions();
    build_options.addOption(
        bool,
        "enable_force_down",
        enable_force_down,
    );

    const lib = b.addLibrary(.{
        .name = "Deblock4",
        .linkage = .dynamic,
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/Deblock4.zig"),
            .optimize = optimize,
            // Existing fixed target is supplied here.
        }),
    });

    lib.root_module.addOptions(
        "deblock4_build_options",
        build_options,
    );

    b.installArtifact(lib);
}
```

The current Zig build-system idiom is exactly:

```text
b.option(...)
b.addOptions()
options.addOption(...)
artifact.root_module.addOptions("module_name", options)
@import("module_name")
```

The module name is chosen by the project; `build_options` is a convention, not
a magic mandatory spelling. [S4]

## B.3 Source-side structural gate

Recommended source shape:

```zig
const build_options = @import("deblock4_build_options");

fn selectTier(actual: CapabilitySet) Tier {
    var effective = actual;

    if (build_options.enable_force_down) {
        const force_down = @import("force_down_debug.zig");
        effective = force_down.applyMaskOnly(actual);
    }

    return selectHighestWholeLevel(effective);
}
```

Because `build_options.enable_force_down` is a comptime-known constant:

```text
false:
    the branch is not analyzed;
    `force_down_debug.zig` is not semantically imported;
    its referenced functions, strings and symbols are not emitted.

true:
    the debug module is imported and the seam exists.
```

Putting the seam in a separate module is not required for omission, but it is
the clearest `#ifdef`-like structure and makes binary inspection easier.

Every force-down-only item should live inside that separate module or inside
the compile-time-true branch:

```text
override parser
environment-variable or command-line token names
diagnostic strings
test-only enums and masks
helper functions
extern/export declarations
```

Do not leave force-down strings or declarations outside the gate and then
assume the branch exclusion removes them.

## B.4 Strength relative to C/C++ `#ifdef`

### C/C++ preprocessor

```c
#ifdef ENABLE_FORCE_DOWN
    apply_force_down();
#endif
```

The preprocessor removes the disabled token sequence before C/C++ parsing and
semantic analysis.

### Zig

```zig
if (build_options.enable_force_down) {
    const force_down = @import("force_down_debug.zig");
    effective = force_down.applyMaskOnly(actual);
}
```

The containing Zig file is parsed, but because the condition is comptime-known
false, Zig guarantees that the untaken branch is not semantically analyzed and
its runtime code is eliminated.

For the project's binary-omission requirement, the Zig mechanism is
equivalent in strength:

```text
disabled seam has no emitted code;
disabled seam has no referenced symbol;
disabled separate module is not analyzed through that branch;
the result does not depend on ReleaseFast dead-code optimisation.
```

The difference is phase and mechanism, not safety outcome:

```text
C/C++: textual exclusion before parsing.
Zig:   semantic compile-time exclusion before runtime code generation.
```

## B.5 Comparison of gate choices

### Option A - explicit build-option boolean

```text
TRUE OMISSION: yes, when used as a comptime-known source condition.
Advantages:
- explicit tester opt-in;
- not silently present in every Debug build;
- easy to prove enabled/disabled variants;
- clear generated configuration record.
Risk:
- must reject true for non-Debug production artifacts.
```

### Option B - `@import("builtin").mode`

```text
TRUE OMISSION: yes, optimize mode is comptime-known.
Advantages:
- simple;
- no build option.
Disadvantages:
- seam exists in every Debug build;
- testing policy is coupled to optimisation policy;
- cannot independently request a Debug build without the seam.
```

This is not recommended as the sole gate.

### Option C - separate build target/step

```text
TRUE OMISSION: yes, if the production artifact is built without the seam
module and the test artifact is a separate Debug-only graph path.
Advantages:
- strongest operational separation;
- production install step can never select the seam artifact accidentally.
Disadvantages:
- more build-graph code;
- may duplicate artifact configuration unless factored carefully.
```

## B.6 Recommendation

Use a hybrid of A and C:

```text
1. An explicit `enable_force_down` boolean, default false.
2. A hard build-time rejection unless optimize mode is Debug.
3. A comptime-known `if` around the entire seam.
4. The complete seam in `force_down_debug.zig`, imported only inside that
   branch.
5. Prefer a named debug/test build step that sets the option true for the
   proof artifact; the ordinary install/release artifact always receives
   false.
6. ReleaseSafe and ReleaseFast validation must prove absence by inspecting
   symbols, strings and disassembly.
```

This gives the desired `#ifdef`-strength omission while avoiding the policy
problem of silently compiling the seam into every Debug build.

## B.7 Why this is a guarantee rather than ordinary DCE

The guarantee does not rest on LLVM deciding that a runtime branch is dead.

It rests on two Zig language/build facts:

```text
The generated Options value is comptime-known.
An `if` with a comptime-known condition skips analysis of the untaken branch.
```

Zig's language reference further notes that this compile-time specialization
occurs even in Debug builds. [S4] [S5]

`runtime_safety` does not control this. Runtime-safety settings change inserted
safety checks; they do not determine whether the force-down branch exists.

## B.8 Required proof in Stage 1B.3

The later scope should require both positive and negative evidence.

### Debug seam-enabled artifact

```text
Build succeeds only with Debug.
Activation is loudly reported.
Force-down can lower v3 to v2 or v1.
Force-down can lower v2 to v1.
No request can raise the detected tier.
Actual and effective capabilities are both reported.
```

### Debug seam-disabled artifact

```text
Normal Debug build has no force-down symbols or strings.
Normal selection uses actual capabilities.
```

### ReleaseSafe and ReleaseFast artifacts

```text
Passing -Denable_force_down=true fails the build.
Normal release builds contain:
- no force-down function symbol;
- no override token string;
- no force-down diagnostic string;
- no reference to the debug module;
- no override branch in disassembly.
```

The proof should use exact markers unique to the seam so absence is
machine-checkable.

---

# 7. Final research disposition

```text
PART A:
Official level membership verified:       YES
Exact CPUID locations recorded:           YES
v1 non-CPUID exceptions identified:       YES
crc32 over-list corrected:                YES
sahf renamed LAHF-SAHF:                   YES
xsave over-list corrected:                YES
64bit removed as level member:            YES
Set-A / Set-B seam refined:               YES

PART B:
Zig 0.16 current build idiom confirmed:   YES
True omission available:                  YES
Equivalent binary safety to #ifdef:       YES
Sole optimize-mode gate recommended:      NO
Explicit opt-in + Debug rejection:        YES
Separate gated module recommended:        YES
Release binary absence proof required:    YES
```

No production code is authorised by this report.

---

# 8. Sources

[S1] System V Application Binary Interface, AMD64 Architecture Processor
Supplement, source file `x86-64-ABI/low-level-sys-info.tex`, table
"Micro-Architecture Levels" and the following XCR0-enablement paragraph.
Official x86 psABIs GitLab repository.

[S2] Intel 64 and IA-32 Architectures Software Developer's Manual,
Volume 2A, CPUID instruction reference, current downloadable manual set
version 092 as listed by Intel on 2026-06-22.

[S3] Intel, "Trusted CPU Feature Detection Library for Intel Software Guard
Extensions", Supported Features table. This independently lists the CPUID
locations for AVX, AVX2, BMI1, BMI2, F16C, FMA, MMX, POPCNT, SSE, SSE2,
SSE3, SSSE3, SSE4.1 and SSE4.2.

[S4] Zig Build System guide for Zig 0.16.0, section
"Options for Conditional Compilation". It shows `b.addOptions`,
`addOption`, `root_module.addOptions`, source-side `@import`, and states that
the imported data is comptime-known.

[S5] Zig 0.16.0 Language Reference, `comptime` section. It states that an
`if` whose condition is known at compile time is implicitly inlined, that the
compiler guarantees the untaken branch is not analyzed, and that only the
necessary runtime code remains, even in Debug builds.
