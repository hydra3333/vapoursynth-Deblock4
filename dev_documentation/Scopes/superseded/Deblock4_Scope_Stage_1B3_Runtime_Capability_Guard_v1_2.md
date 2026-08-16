# Deblock4 - Stage 1B.3 Coder Scope: Runtime Capability Guard

Version: v1.2
Audience: W3C (coder)
Encoding: US-ASCII only
Companion charter: AI_Charter_and_Invariants_Card v1.17 (invariants G1-G10)
Status: issue-ready coder scope. Authorises production code for the items
below and nothing else. v1.1 pinned the force-down input, the raw-inline-asm
rule, and the detection filename after external audit. v1.2 resolves the W3C
scope review (Deblock4_Stage_1B3_Scope_Review_W3C_v1_0): two-record capability
model (B1); both debug options Debug-only with the always-on emission carved
out as production per README 13.6 (B2); clamp proven by pure-function tests
(B3); module boundaries pinned (B4); integration pinned to the existing build
plus a first-class self-test executable, with a one-way dependency rule (B5);
comptime membership cross-check against Zig named models, compile-FAIL on
mismatch (B6); detection provenance enum (B7); exact file lists and external
shapes pinned (P1/P3). Where this scope and the charter appear to differ, the
charter wins and the discrepancy is brought to W3X; do not resolve it in code.

---

## 0. One-paragraph statement

Stage 1B.2 migrated the four backend objects to the named x86-64 psABI levels
and CONFIRMED each object stays within its level. Stage 1B.3 IMPLEMENTS and
PROVES the runtime capability guard that Stage 1B.2 only recorded: detect the
actual CPU once, decide the highest whole psABI level it fully satisfies
(v3 -> v2 -> v1), and expose that decision as immutable capability records
that dispatch will consume. It also establishes the project's shared config and
print/diagnostics module skeleton, a first-class self-test executable built
from the same source modules as the DLL, and the debug-only force-down test
seam built in the ratified G10 pattern. This scope does NOT wire dispatch to
call backends and does NOT create the VapourSynth plugin entry point (both are
later stages); it builds and proves the guard, the records, and the module
architecture they live in.

---

## 1. What this scope relies on (quoted, per charter 2.3)

### 1.1 Tier definitions - the authoritative standard (charter G3)

The tiers ARE the named x86-64 psABI microarchitecture levels, used in full.
Quoted from charter G3:

```text
    scalar/generic  -> x86_64_v1  (baseline: CMOV, CX8, FPU, FXSR, MMX,
                                   OSFXSR, SCE, SSE, SSE2)
    SSE4.1 backend  -> x86_64_v2  (adds SSE3, SSSE3, SSE4.1, SSE4.2,
                                   POPCNT, CMPXCHG16B, LAHF-SAHF)
    AVX2 backend    -> x86_64_v3  (adds AVX, AVX2, BMI1, BMI2, F16C,
                                   FMA, LZCNT, MOVBE, OSXSAVE)
```

Also quoted from G3, binding on this scope:

```text
    NAMED-LEVEL MEMBERSHIP vs RUNTIME SAFETY are two distinct things ...
    OSXSAVE is a MEMBER of the v3 level under the psABI definition (so it is
    part of the level contract), AND at runtime the AVX/YMM path additionally
    requires executing XGETBV and confirming XCR0 XMM+YMM state. A level-
    membership list names OSXSAVE; a runtime guard checks OSXSAVE plus XCR0.
    Do not silently substitute XSAVE for OSXSAVE.
```

```text
    WHOLE-LEVEL dispatch. Dispatch checks that the CPU satisfies the ENTIRE
    level, never the headline instruction. Selection tests v3, then v2, then
    v1, and uses the highest FULLY-satisfied level, falling back down the
    chain; v1 always succeeds. A CPU exposing AVX2 but failing any other v3
    requirement is NOT v3 - running the v3 backend on it would fault - so
    dispatch selects the highest LOWER level it fully satisfies.
```

Per G3 the AUTHORITATIVE per-level set is the psABI standard, and target and
detection must derive from ONE mechanism so they cannot drift. Section 3.6
implements that requirement mechanically for the runtime side.

### 1.2 The set-A CPUID detection contract (W3C-verified, SDM cross-checked)

The per-feature CPUID locations below were produced by W3C in the Stage 1B.3
prep research and independently cross-checked against the Intel SDM. This
table is the authoritative runtime LOCATION contract. (Per-level MEMBERSHIP is
additionally cross-checked at comptime against Zig's named models; see 3.6.)

Notation: CPUID.01H = EAX input 00000001H; CPUID.07H.0 = EAX input 00000007H,
ECX subleaf 0; CPUID.80000001H = EAX input 80000001H.

x86_64_v1 baseline:

```text
    CMOV    CPUID.01H:EDX bit 15
    CX8     CPUID.01H:EDX bit 8
    FPU     CPUID.01H:EDX bit 0
    FXSR    CPUID.01H:EDX bit 24
    MMX     CPUID.01H:EDX bit 23
    SSE     CPUID.01H:EDX bit 25
    SSE2    CPUID.01H:EDX bit 26
    OSFXSR  CR4.OSFXSR bit 9      - NOT a CPUID bit (OS state; see 3.3)
    SCE     IA32_EFER.SCE bit 0   - NOT a CPUID bit (OS state; see 3.3)
```

x86_64_v2 additions:

```text
    CMPXCHG16B  CPUID.01H:ECX bit 13
    LAHF-SAHF   CPUID.80000001H:ECX bit 0
    POPCNT      CPUID.01H:ECX bit 23
    SSE3        CPUID.01H:ECX bit 0
    SSE4.1      CPUID.01H:ECX bit 19
    SSE4.2      CPUID.01H:ECX bit 20
    SSSE3       CPUID.01H:ECX bit 9
```

x86_64_v3 additions:

```text
    AVX      CPUID.01H:ECX bit 28
    AVX2     CPUID.07H.0:EBX bit 5
    BMI1     CPUID.07H.0:EBX bit 3
    BMI2     CPUID.07H.0:EBX bit 8
    F16C     CPUID.01H:ECX bit 29
    FMA      CPUID.01H:ECX bit 12
    LZCNT    CPUID.80000001H:ECX bit 5
    MOVBE    CPUID.01H:ECX bit 22
    OSXSAVE  CPUID.01H:ECX bit 27
```

Leaf-availability guards (query before reading optional leaves):

```text
    CPUID.0:EAX          >= 7          before CPUID.07H.0
    CPUID.80000000H:EAX  >= 80000001H  before CPUID.80000001H
```

If a required leaf is unavailable, every feature located in that leaf is
treated as ABSENT. The detector must not read a nonexistent leaf and infer
support from unspecified output.

The set-A / set-B seam:

```text
    CPUID.01H:ECX.XSAVE bit 26    processor supports XSAVE/XGETBV facilities
    CPUID.01H:ECX.OSXSAVE bit 27  OS has enabled extended-state management
                                  (this is the psABI v3 membership row)
    XGETBV(ECX=0), XCR0 bits 1,2  XMM and YMM state enabled by the OS
```

For the v3 (AVX-family) tier, the usable-state test is `(XCR0 & 0x6) == 0x6`,
required in ADDITION to the CPUID membership bits. The whole v3 tier is
unavailable unless this XCR0 test passes, even though BMI1/BMI2/LZCNT/MOVBE do
not individually need YMM state, because a v3-compiled object may contain AVX
anywhere.

### 1.3 Safety invariants binding on this scope

- G1: capabilities detected ONCE into an immutable process-wide record; per-
  instance resolution once at construction; the hot path does no capability
  test.
- G2/G5: detection contains no v2/v3 instructions; no gated code executes
  before a proven guard; NO bypass by build flag, environment, or "known
  machine" assumption; unguarded execution paths are execution.
- G6: safety properties rest on explicit or structural mechanisms; residual
  toolchain dependencies are tier-3 standing loud-failing gates delivered in
  the same scope.
- G10: debug-only code is structurally absent from production binaries by the
  three-layer pattern; a capability-affecting seam may only force DOWN, never
  fabricate.
- README 13.6 (settled v1.3): the version/tier stderr emission is ALWAYS-ON
  production behaviour, once per instance, ffmpeg-style, "not behind a debug
  flag". It is NOT debug output and is unaffected by any debug-option gating.

### 1.4 What this scope does NOT do (boundaries)

- It does NOT wire dispatch to CALL any backend. No new call into gated
  backend code is introduced (G5 unchanged).
- It does NOT create the VapourSynth plugin entry point or any filter. The
  per-instance API is delivered and proven here (7.1); its VapourSynth wiring
  is the filter-creation stage's job, reduced to calling the pinned contract
  (5A).
- It does NOT rename, move, or modify the Stage-1 scaffolding (probe files,
  smoke tests, the 1B.2 batch) beyond the minimal build.zig additions in
  section 6. Scaffolding cleanup happens at the filter-creation stage in one
  deliberate sweep (see 2.6).
- It does NOT build a general diagnostics framework beyond what this scope's
  items use (skeleton fully, content minimally; section 2).
- It does NOT introduce fused float semantics or rely on FMA emission (G7/G8
  unchanged); FMA appears only as a v3 membership bit to detect.
- It does NOT reopen the vzeroupper transition proof (deferred to Stage 5C).

---

## 2. Module architecture (skeleton fully now, content minimally now)

This scope establishes the modules below. The SKELETON - boundaries,
namespaces, gating, naming, and the dependency rules - is authoritative and
designed in full now. The CONTENT is only what Stage 1B.3 needs. Later stages
EXTEND these modules; they do not fork bespoke config or printing elsewhere.

### 2.1 File inventory (P1: exact, exhaustive)

New first-class production modules:

```text
    src/deblock4_config.zig               declarations-only switchboard
    src/print_helper_functions.zig        always-on print helpers
    src/cpu_capability_detection.zig      detection core (pinned v1.1)
```

New first-class debug modules (each G10-gated, structurally absent from
production builds):

```text
    src/print_diag_helper_functions.zig   verbose per-bit diagnostics
                                          gate: enable_verbose_detection
    src/force_down_debug.zig              force-down seam
                                          gate: enable_force_down
```

New first-class self-test root:

```text
    src/deblock4_selftest.zig             self-test executable root
```

Files this scope MAY MODIFY (and no others):

```text
    build.zig                             options module, Debug-only rejection,
                                          selftest artifact/steps, wiring the
                                          new modules into the DLL root graph
    src/dll_probe.zig                     MINIMAL addition only: cause the DLL
                                          root graph to import/initialise the
                                          new production modules so the release
                                          DLL genuinely contains them and the
                                          absence proofs are meaningful.
                                          No other change; no renaming.
```

ALL other existing files are FORBIDDEN to this scope: backend_probe_*.zig,
backend_retention_anchor.zig, backend_isolation_smoke_test.zig,
dll_smoke_test.zig, build_probe.zig, vapoursynth_header_probe.zig,
build.zig.zon, third-party headers, the 1B.2 batch. If a change to a forbidden
file appears necessary, STOP and bring it to W3X.

### 2.2 src/deblock4_config.zig - the always-present switchboard (production)

Declarations ONLY. No logic, no functions. Shallow namespaces (one level,
occasionally two). Production code, never gated; it NAMES the gates whose
gated CODE lives in the gated modules.

Required content:

```zig
const deblock4_build_options = @import("deblock4_build_options");

pub const debug = struct {
    pub const enable_force_down = deblock4_build_options.enable_force_down;
    pub const enable_verbose_detection = deblock4_build_options.enable_verbose_detection;
};

pub const tier = struct {
    pub const name_v1 = "x86_64_v1_baseline";
    pub const name_v2 = "x86_64_v2_with_sse41";
    pub const name_v3 = "x86_64_v3_with_avx2";
};

pub const diag = struct {
    pub const summary_prefix = "deblock4";
};
```

Header rules (encode as comment): declarations only; namespaces shallow; this
module is production code and contains no gated bodies.

### 2.3 src/print_helper_functions.zig - always-on print helpers (production)

Generic, always-present emission/formatting helpers. No build-option gate.
The ONLY home for shared always-on printing. Seed exactly:

```text
- emitInstanceSummary(...): the README 13.6 always-on stderr line (see 4.1
  for the pinned format);
- tierName(...): map the resolved-tier enum to its deblock4_config.tier
  string.
```

All output to stderr, flushed (charter C-STY discipline). Header rule: all
always-on shared printing lives here; feature code calls helpers, never grows
bespoke print routines.

### 2.4 The two gated debug modules (G10; B4 boundaries pinned)

Two SEPARATE modules, two SEPARATE gates, no import in either direction
between them. Each may call print_helper_functions.zig for formatting. Each
carries unique greppable marker strings for the three-surface absence proof.

src/print_diag_helper_functions.zig - gate: enable_verbose_detection ONLY.
Content: the verbose per-bit detection dump (4.2).

src/force_down_debug.zig - gate: enable_force_down ONLY. Content: the
DEBLOCK4_FORCE_DOWN env-var reader/parser, the ceiling computation input, and
the force-down ANNOUNCEMENT emitter (the announcement is force-down content
and lives here, not in the diag module).

Inclusion shape at each use site (the ratified C-3 form), one per gate:

```zig
const deblock4_config = @import("deblock4_config.zig");

const diag_dbg = if (deblock4_config.debug.enable_verbose_detection)
    @import("print_diag_helper_functions.zig")
else
    struct {};

const force_down_dbg = if (deblock4_config.debug.enable_force_down)
    @import("force_down_debug.zig")
else
    struct {};
```

with every use itself gated by the SAME option as its import (G10 layer 2).
Inner sub-features inside each module are individually gated where present.
Inner gates never license an unconditional import.

### 2.5 src/deblock4_selftest.zig - the first-class self-test executable

A real program (the CNR3 model: DLL-aimed code plus a self-test executable
compiled from the SAME source modules). It imports the same production modules
the DLL does and, in Debug builds with the gates on, the same gated modules.
It is a permanent first-class artifact, not stage scaffolding, and is named
accordingly. What it does is defined in 7.1.

### 2.6 Naming and the ONE-WAY DEPENDENCY RULE (the "sweep test")

Recorded as binding for this scope and as a standing rule for W3X to ratify
(section 8):

```text
    NAMING. New first-class files, symbols, and artifacts carry PERMANENT
    names: no stage numbers, no "probe"/"smoke" vocabulary. Stage-numbered
    and probe/smoke vocabulary is reserved for disposable scaffolding.

    DEPENDENCY DIRECTION (one-way). Scaffolding (probe files, smoke tests,
    dll_probe.zig, the validation batch) MAY import and call the new
    first-class modules. The new first-class modules MUST NOT import,
    reference, or name ANY scaffolding file, symbol, marker, or artifact
    name. Zero references, new -> old.

    RESIDENCE. Shared functions never reside in scaffolding files. Anything
    shared lives in the first-class homes.

    THE SWEEP TEST (verifiable criterion). At the filter-creation stage,
    deleting every scaffolding file must require ZERO edits to first-class
    modules. Review check: a textual audit of the first-class files for
    scaffolding identifiers returns EMPTY. This audit is a 7.5 obligation.
```

---

## 3. The detection core (production code)

File: `src/cpu_capability_detection.zig` (pinned v1.1).

### 3.1 The TWO capability records (B1)

```text
    ACTUAL   - process-wide, detected ONCE, immutable after construction.
               The hardware/OS truth: per-feature detection states (3.3),
               the set-B XCR0 result, and the resolved actual tier.
               Never modified by any seam.

    EFFECTIVE - per-instance, computed ONCE at instance construction,
               immutable for that instance's lifetime:
                   effective = actual  INTERSECT  force-down ceiling
               When the force-down seam is absent (release) or inert (env var
               unset), effective is identical to actual. The per-instance
               resolved tier is computed FROM effective.
```

Dispatch (a later stage) consumes EFFECTIVE. Diagnostics report as pinned in
section 4: the always-on line reports the EFFECTIVE tier (what will actually
run); the verbose dump reports ACTUAL per-bit truth plus both resolved tiers;
the force-down announcement reports BOTH, distinctly labelled.

### 3.2 Detection procedure (whole-level, per G3)

1. Execute CPUID for the required leaves, honouring the leaf-availability
   guards in 1.2. A missing optional leaf makes its features absent.
2. Record each set-A feature per the 1.2 contract with its provenance (3.3).
3. For the AVX-family (v3) path, execute XGETBV(ECX=0) only on the OSXSAVE-
   confirmed path, and record whether `(XCR0 & 0x6) == 0x6` (set-B).
4. Compute whole-level membership:
   - v2 satisfied iff ALL v2-addition bits are present AND v1 is satisfied.
   - v3 satisfied iff ALL v3-addition bits are present (including OSXSAVE)
     AND v2 is satisfied AND the set-B XCR0 test passes.
5. Resolve the ACTUAL tier as the highest satisfied level, testing v3 then v2
   then v1; v1 always succeeds.

No shorthand ("AVX2 means v3", "SSE4.2 means v2") is permitted.

### 3.3 Detection provenance; v1 baseline policy (B7; W3X decision, stated)

Every feature state in the ACTUAL record carries a provenance:

```text
    detected_present         CPUID (or XGETBV) was executed and the bit is set
    detected_absent          CPUID (or XGETBV) was executed and the bit is clear
    policy_assumed_present   NOT read; assumed by the stated Windows x64
                             process policy
```

OSFXSR and SCE are OS-enabled state, not user-mode-readable CPUID bits; a
successfully loaded 64-bit Windows process already establishes the OS baseline.
They carry `policy_assumed_present`, and diagnostics must render them as
"OS baseline assumed (Windows x64 process policy)" - NEVER as detected/CPU-
present. x86_64_v1 is the UNCONDITIONAL final fallback; the detector does not
attempt to read CR4 or IA32_EFER. This is a stated policy (G6 spirit: explicit,
documented), not an unremarked assumption.

### 3.4 Detection safety (G2/G5)

Detection uses only CPUID and XGETBV (XGETBV only after OSXSAVE is confirmed).
The detection object contains NO v2 or v3 instructions - it decides whether
those are safe and cannot require what it detects. Detection runs before any
capability-gated code and never enters a gated backend.

### 3.5 CPUID/XGETBV implementation rule (v1.1)

CPUID and XGETBV are read via RAW INLINE ASSEMBLY written in this scope's
detection unit. Do NOT invent or assume a standard-library wrapper; the
detection contract must rest on explicit, visible instructions (G6 spirit).

The following is a NON-NORMATIVE reference shape only (NOT compiled or
verified by W3D; a candidate form, not canon). The coder MUST verify the
constraint semantics against Zig 0.16.0 - in particular the handling of EBX as
an output register (RBX is callee-saved on Win64 and historically special in
inline asm) and the EAX/ECX registers appearing as both inputs and outputs -
and the verified implementation is the coder's deliverable, proven by this
scope's section 7 gates:

```zig
// NON-NORMATIVE reference shape - verify before use
pub inline fn cpuid(eax_in: u32, ecx_in: u32) struct { eax: u32, ebx: u32, ecx: u32, edx: u32 } {
    var eax: u32 = undefined;
    var ebx: u32 = undefined;
    var ecx: u32 = undefined;
    var edx: u32 = undefined;
    asm volatile ("cpuid"
        : [eax] "={eax}" (eax),
          [ebx] "={ebx}" (ebx),
          [ecx] "={ecx}" (ecx),
          [edx] "={edx}" (edx),
        : [eax_in] "{eax}" (eax_in),
          [ecx_in] "{ecx}" (ecx_in),
        : "cc"
    );
    return .{ .eax = eax, .ebx = ebx, .ecx = ecx, .edx = edx };
}

pub inline fn xgetbv(ecx_in: u32) u64 {
    var eax: u32 = undefined;
    var edx: u32 = undefined;
    asm volatile ("xgetbv"
        : [eax] "={eax}" (eax),
          [edx] "={edx}" (edx),
        : [ecx_in] "{ecx}" (ecx_in),
        : "cc"
    );
    return (@as(u64, edx) << 32) | eax;
}
```

If verification finds the reference shape defective, the corrected form is
used and the defect is reported back to W3X/W3D.

### 3.6 Comptime membership cross-check (B6; charter G3 "one mechanism")

The runtime table has two components. LOCATIONS (leaf/register/bit) are Intel
SDM facts that do not exist in Zig's target model and are fixed by 1.2.
MEMBERSHIP (which features belong to which level) CAN drift against the
toolchain's own level definitions, and G3 requires one mechanism so target and
detection cannot drift. Therefore:

`src/cpu_capability_detection.zig` contains a COMPTIME assertion that this
scope's per-level membership sets exactly equal the feature-set DIFFERENCES of
Zig's own named models `std.Target.x86.cpu.x86_64` / `x86_64_v2` / `x86_64_v3`
(the same models build.zig compiles the backends with), mapped through an
explicit name table, with an explicit commented EXCLUSION list for items that
are not runtime-CPUID-checkable or not ISA membership (the OS-state rows
OSFXSR/SCE, and any compiler tuning flags present in the model sets).

On ANY mismatch the assertion raises `@compileError` naming the offending
feature(s). FAIL, not complain: a Zig upgrade that changes the named-model
definitions must HALT the build for human reconciliation (W3X decision;
G6 tier-3 loud-failure posture - a warning in scrollback is the silent drift
G6 forbids). The exclusion list is part of the reviewed contract: additions to
it require W3X approval, not silent growth.

---

## 4. Diagnostics (requirement G), split per README 13.6

### 4.1 Always-on instance summary (PRODUCTION; not debug; B2 carve-out)

Per README 13.6 (settled, "not behind a debug flag"): once per instance
construction, `print_helper_functions.zig` emits ONE stderr line, well-
formatted for an END USER, pinned format (P3):

```text
    deblock4: <version> <instance-name> backend=<requested> tier=<effective-tier-name>
```

and, ONLY when the effective tier is below the highest headline the hardware
suggests or below the requested backend, a single appended reason clause:

```text
    deblock4: <version> <instance-name> backend=auto tier=x86_64_v2_with_sse41 reason=BMI2 absent, not v3
```

The FALLBACK REASON is part of THIS always-on line (v1.2 correction; it was
previously mis-placed in the debug dump). In this stage, "instance" is the
self-test's construction and any DLL probe path that constructs a record; the
filter stage inherits this exact format. This line is present in ALL builds
including release and is unaffected by section 6's debug-option rejection.

### 4.2 Verbose per-bit dump (DEBUG-ONLY; G10)

Under `enable_verbose_detection` (Debug builds only, section 6): the forensic
dump - every set-A feature with its PROVENANCE (3.3) grouped by level, the
set-B XCR0 raw result, the resolved ACTUAL tier, the force-down ceiling if
any, and the resolved EFFECTIVE tier. Support-engineer material; structurally
absent from production per G10. Carries a unique marker string.

---

## 5. Requirement H - debug-only force-down seam

Module: `src/force_down_debug.zig` (B4), gate `enable_force_down`, included
only via the C-3 form (2.4).

### 5.1 Behaviour and pinned input (v1.1)

Under `enable_force_down`, the seam computes a CEILING from the environment
variable `DEBLOCK4_FORCE_DOWN`, read ONCE at instance initialization, inside
the gated module only. Semantics:

```text
    Accepted values:  the short tier forms "v1" and "v2" exactly (lower case).
                      There is no "v3" value: forcing to the top tier is not
                      forcing, and a detection miss on known-v3 hardware is a
                      DETECTOR DEFECT TO FIX, never a case for forcing up.
    Absent:           no forcing; the seam is inert even though compiled in.
    Present, invalid: LOUD failure at instance construction (creation error /
                      unmistakable stderr and refusal to proceed as if
                      unforced). A mis-typed test intent must never silently
                      do nothing.
    At/above actual:  clamps to actual with a LOUD notice; the structural
                      intersection rule guarantees the result can never exceed
                      actual.
```

No other input mechanism (file probe, registry, command line) is permitted.

### 5.2 Hard safety rules (G5/G10)

- FORCE-DOWN ONLY, STRUCTURALLY: `effective = actual INTERSECT ceiling`. A
  request for a higher tier can only ever yield actual or lower, never higher;
  fabricating a bit the CPU lacks is impossible by construction.
- ANNOUNCED LOUDLY when active, by the announcement emitter in this module,
  reporting BOTH actual and effective, distinctly labelled; the forced value
  is never presented as hardware truth.
- NO BYPASS (G5): the seam only lowers a correctly detected capability; it is
  never a route around the guard and creates no unguarded call.

### 5.3 Build gating (B2: option A, W3X-ratified)

- BOTH debug options - `enable_force_down` AND `enable_verbose_detection` -
  are explicit opt-in `b.option` booleans, DEFAULT OFF.
- build.zig HARD-REJECTS either option set true with any optimize mode other
  than Debug (build-time failure). The gated modules are therefore
  structurally impossible in ReleaseSafe / ReleaseFast / ReleaseSmall, closing
  the B2 hole (previously only force-down was fenced).
- The README 13.6 always-on summary (4.1) is production behaviour and is NOT
  affected by this rejection.

## 5A. The forward integration contract (B5; binding on the filter stage)

The per-instance construction API is delivered and proven NOW; the filter-
creation stage's job is reduced to CALLING it. Pinned external shape (P3):

```text
    pub const ResolvedTier = enum { x86_64_v1, x86_64_v2, x86_64_v3 };

    pub const ActualCapabilities   (immutable; fields per 3.1/3.3)
    pub const EffectiveCapabilities (immutable; fields per 3.1)

    pub fn detectActualOnce() *const ActualCapabilities;
        Process-wide, first call detects, later calls return the same record.
        Thread-safe once-semantics (std.once-class mechanism; coder's choice
        of exact construct, stated in the response).

    pub const InstanceInitError = error{ InvalidForceDownValue };

    pub fn initInstanceCapabilities(instance_name: []const u8)
            InstanceInitError!EffectiveCapabilities;
        Computes effective (3.1), applies the seam when compiled+enabled (5.1),
        emits the 4.1 always-on summary line, emits the 4.2 dump when
        compiled+enabled, and returns the immutable effective record.
        InvalidForceDownValue is returned on the 5.1 invalid case; the future
        filter stage maps it to a creation error (map_set_error path).
```

Internal spellings beyond these are the coder's choice; these names, the enum,
the error, and the emission behaviour are pinned so the filter stage and the
self-test call one identical contract.

---

## 6. build.zig changes (exhaustive)

- Add `enable_force_down` and `enable_verbose_detection` (bool, default
  false) as `b.option` values; feed both via `b.addOptions` / `addOption` /
  `root_module.addOptions("deblock4_build_options", options)` into EVERY
  artifact that imports the new modules (the DLL and the selftest). The
  imported module name is `deblock4_build_options`.
- HARD-REJECT either option true unless optimize mode is Debug (5.3).
- Add the selftest artifact: executable `deblock4_selftest` from
  `src/deblock4_selftest.zig`, plus named steps `selftest` (build) and
  `selftest-run` (build+run). The DLL and the selftest are independently
  buildable and buildable together (the existing multi-artifact pattern).
- Wire the new production modules into the DLL root graph (via the minimal
  dll_probe.zig addition, 2.1) so the release DLL genuinely contains them.
- No `-Dcpu` / `-Dtarget` override is introduced or accepted; named psABI
  level targets for the backend objects are unchanged from 1B.2.

---

## 7. Proof obligations (Definition of Done)

All must pass; the scope is a PASS only when W3C review of the actual output
confirms them.

### 7.1 Self-test executable (Debug and release variants)

`deblock4_selftest.exe` exercises the pinned contract (5A) end to end:

```text
    In every build:
    - calls detectActualOnce() and initInstanceCapabilities();
    - on the W3X dev host (x86_64_v3): actual tier is v3, all detected bits
      present, XCR0 test passing; the 4.1 summary line is emitted with the
      pinned format and the EFFECTIVE tier;
    - calling detectActualOnce() twice returns the same record (once-
      semantics).

    Debug build, gates ON:
    - DEBLOCK4_FORCE_DOWN=v2 -> effective v2, actual v3, announcement shows
      both; =v1 -> effective v1;
    - DEBLOCK4_FORCE_DOWN=<invalid> -> LOUD failure with
      InvalidForceDownValue;
    - env var absent -> effective == actual, seam silent;
    - the 4.2 verbose dump appears and shows provenance labels, with
      OSFXSR/SCE rendered as policy-assumed, never detected.

    Unit tests (zig build test), pure-function, fabricated ACTUAL records
    (B3):
    - fabricated v1-actual with ceiling v2 -> effective v1 (clamp, loud
      notice path exercised);
    - fabricated v2-actual with ceiling v2 -> effective v2;
    - fabricated v3-actual with ceiling v1/v2 -> effective v1/v2;
    - intersection can never yield a tier above actual (exhaustive over the
      nine actual x ceiling combinations).
    No synthetic-input seam exists in production paths; fabrication is
    test-code-only construction of ActualCapabilities values.
```

### 7.2 Detection safety (G2/G5)

- The detection unit's compiled object contains NO v2 or v3 instructions
  (dumpbin /DISASM inspection, the 1B.2 method and deny families). Detection
  is v1-only.
- XGETBV appears only on the OSXSAVE-confirmed path (source review + the
  disassembly's single guarded occurrence).

### 7.3 G10 absence proof (layer 3 / G6 tier 3) - STANDING gate, delivered here

A standing, loud-failing validation that in RELEASE builds (ReleaseSafe AND
ReleaseFast, options necessarily off) BOTH artifacts - the production DLL AND
the release selftest exe - are ABSENT of debug content on all THREE surfaces,
using module-unique markers for EACH gated module separately:

```text
    - raw binary strings: no print_diag marker, no force_down marker (incl.
      the literal "DEBLOCK4_FORCE_DOWN" env-var name string);
    - PE export table: no gated-module symbol;
    - disassembly: no gated-module unique code marker.
```

Positive control: a Debug build with gates ON shows the markers PRESENT on the
applicable surfaces. Negative build control: `enable_force_down=true` or
`enable_verbose_detection=true` with a non-Debug optimize mode FAILS the
build. This gate ships in THIS scope (G6 tier-3), follows the
gate_pattern_test_v2 method, and applies it to the real artifacts.

### 7.4 Comptime cross-check (B6)

- The 3.6 assertion is present and the build compiles (membership matches the
  named models through the mapping + exclusion list).
- A demonstration that it FIRES: a deliberate one-feature perturbation
  (comment-toggled or patch-demonstrated in the response, not committed
  enabled) produces the named @compileError. Evidence in the delivery, then
  reverted.

### 7.5 Architecture and no-regression

- ONE-WAY DEPENDENCY AUDIT (2.6): the first-class modules contain zero
  references to scaffolding files, symbols, markers, or artifact names
  (textual audit in the delivery; must be empty).
- Stage 1B.2's gates still pass (export table, within-level, native-override
  rejection); the 1B.2 batch (or its successor) runs green with the new
  modules present in the DLL.
- No new call into gated backend code exists (G5).

---

## 8. Standing rules to record (W3X to ratify)

1. Single homes: `deblock4_config.zig` (declarations-only switchboard),
   `print_helper_functions.zig` (always-on printing),
   `print_diag_helper_functions.zig` + `force_down_debug.zig` (gated debug).
   Later stages EXTEND these; no bespoke config constants or print routines in
   feature code ("skeleton fully, content minimally, extend-do-not-fork").
2. The naming + one-way dependency rule and the sweep test (2.6): first-class
   modules never reference scaffolding; scaffolding dies at the filter stage
   in one sweep requiring zero first-class edits.

---

## 9. Deliverables

```text
- src/deblock4_config.zig                 (new)
- src/print_helper_functions.zig          (new)
- src/cpu_capability_detection.zig        (new; raw asm, records, whole-level
                                           resolve, comptime cross-check)
- src/print_diag_helper_functions.zig     (new; gated)
- src/force_down_debug.zig                (new; gated)
- src/deblock4_selftest.zig               (new; first-class self-test root)
- build.zig                               (options, rejection, selftest steps,
                                           DLL wiring)
- src/dll_probe.zig                       (minimal addition per 2.1 only)
- the G10 absence-proof standing gate     (three-surface, both artifacts,
                                           positive control, build-reject
                                           checks)
- .bat harness as required to run the proofs (W3C deliverable per charter 2.4)
```

Session package (P2): assembled by W3X at handoff - exact commit/branch, the
charter v1.17, and the current source files named in 2.1. This scope's file
lists are written against the current main tree (post-1B.2 commit).

No production code beyond these items is authorised. Bring any gap or
ambiguity to W3X rather than resolving it in code.
