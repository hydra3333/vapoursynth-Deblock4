# Deblock4 - Stage 1B.3 Coder Scope: Runtime Capability Guard

Version: v1.0
Audience: W3C (coder)
Encoding: US-ASCII only
Companion charter: AI_Charter_and_Invariants_Card v1.17 (invariants G1-G10)
Status: issue-ready coder scope. Authorises production code for the items
below and nothing else. Where this scope and the charter appear to differ, the
charter wins and the discrepancy is brought to W3X; do not resolve it in code.

---

## 0. One-paragraph statement

Stage 1B.2 migrated the four backend objects to the named x86-64 psABI levels
and CONFIRMED each object stays within its level. Stage 1B.3 IMPLEMENTS and
PROVES the runtime capability guard that Stage 1B.2 only recorded: detect the
actual CPU once, decide the highest whole psABI level it fully satisfies
(v3 -> v2 -> v1), and expose that decision as an immutable capability record
that dispatch will consume. It also establishes the project's shared config and
print/diagnostics module skeleton, and the debug-only force-down test seam built
in the ratified G10 pattern. This scope does NOT wire dispatch to call backends
(that is a later stage); it builds and proves the guard and the record.

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

The parenthetical feature lists are a READING AID; per G3 the AUTHORITATIVE
per-level set is the psABI standard, and target and detection must derive from
ONE mechanism so they cannot drift. This scope's detection contract (1.2) is
that single mechanism for the runtime side.

### 1.2 The set-A CPUID detection contract (W3C-verified, SDM cross-checked)

The following per-feature CPUID locations were produced by W3C in the Stage
1B.3 prep research and independently cross-checked against the Intel SDM. This
table is the authoritative runtime detection contract for this scope.

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
    OSFXSR  CR4.OSFXSR bit 9      - NOT a CPUID bit (OS state)
    SCE     IA32_EFER.SCE bit 0   - NOT a CPUID bit (OS state)
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

The set-A / set-B seam, quoted from the prep:

```text
    CPUID.01H:ECX.XSAVE bit 26    processor supports XSAVE/XGETBV facilities
    CPUID.01H:ECX.OSXSAVE bit 27  OS has enabled extended-state management
                                  (this is the psABI v3 membership row)
    XGETBV(ECX=0), XCR0 bits 1,2  XMM and YMM state enabled by the OS
```

For the v3 (AVX-family) tier, the usable-state test is `(XCR0 & 0x6) == 0x6`,
and it is required in ADDITION to the CPUID membership bits. The whole v3 tier
is unavailable unless this XCR0 test passes, even though BMI1/BMI2/LZCNT/MOVBE
do not individually need YMM state, because a v3-compiled object may contain
AVX anywhere.

### 1.3 Safety invariants binding on this scope

- G1: capabilities detected ONCE into an immutable process/plugin-wide record;
  the requested backend resolved once per filter instance; the hot path does no
  capability test.
- G5: a backend's instructions are never executed on an unproven machine; NO
  bypass by build flag, environment, or "known machine" assumption; unguarded
  execution paths (static initialisers, registration, import thunks, test
  calls) are execution.
- G6: safety properties rest on explicit or structural mechanisms, never on
  implicit toolchain behaviour; where a residual dependency exists it is a
  tier-3 standing loud-failing gate delivered in the same scope.
- G10: debug-only code is structurally absent from production binaries by the
  three-layer pattern (opt-in option default off; C-3 source-visible conditional
  import; gated content; three-surface proven absence). A capability-affecting
  seam may only force DOWN, never fabricate.

### 1.4 What this scope does NOT do (boundaries)

- It does NOT wire dispatch to CALL any backend. It produces the immutable
  capability record and the resolved-level decision; consuming that record to
  select and invoke a backend entry point is a later stage. G5's rule that no
  gated code executes before a proven guard is UNCHANGED and this scope does
  not create any new call into gated backends.
- It does NOT build a general diagnostics framework beyond what this scope's
  items use. It establishes the module SKELETON authoritatively; it populates
  it MINIMALLY. See section 4.
- It does NOT introduce fused float semantics or rely on FMA emission (G7/G8
  unchanged); FMA appears here only as a v3 membership bit to detect.
- It does NOT reopen the vzeroupper AVX-to-SSE transition proof, which remains
  deferred to Stage 5C.

---

## 2. Module architecture (skeleton fully now, content minimally now)

This scope establishes the following modules. The SKELETON - module boundaries,
namespaces, gating, and the rule that these are the only homes for config and
printing - is authoritative and designed in full now. The CONTENT is only what
Stage 1B.3 needs. Later stages EXTEND these modules; they do not fork bespoke
config or printing elsewhere. (New standing rule, see section 8.)

### 2.1 deblock4_config.zig - the always-present switchboard (production code)

Declarations ONLY. No logic, no functions. It names the debug gates and other
global constants, grouped in shallow namespaces (one level, occasionally two).
It is ordinary production code, imported anywhere; it is NOT a debug module and
is NOT gated - it NAMES the gates whose gated CODE lives in the diag print
module.

Required content for 1B.3:

```zig
const deblock4_build_options = @import("deblock4_build_options");

pub const debug = struct {
    // Debug-only feature gates. Each routes to gated code elsewhere; this is
    // only the boolean switchboard. Default off is enforced in build.zig.
    pub const enable_force_down = deblock4_build_options.enable_force_down;
    pub const enable_verbose_detection = deblock4_build_options.enable_verbose_detection;
};

pub const tier = struct {
    // Public backend tokens / tier names. Single source of truth for names.
    pub const name_v1 = "x86_64_v1_baseline";
    pub const name_v2 = "x86_64_v2_with_sse41";
    pub const name_v3 = "x86_64_v3_with_avx2";
};

pub const diag = struct {
    // Always-on diagnostic presentation constants (prefixes, widths).
    pub const summary_prefix = "deblock4";
};
```

Rules for this module (encode as header comment):
- Declarations only; if you need a function, it does not belong here.
- Namespaces group; keep them shallow.
- This module is production code and must contain no gated bodies - only the
  boolean gate values that other modules branch on.

### 2.2 print_helper_functions.zig - always-on print helpers (production code)

Generic, always-present emission/formatting helpers usable from anywhere. No
build-option gate. This is the ONLY home for shared always-on printing. Seed it
with exactly the helpers 1B.3 needs and no more:

```text
- a helper to emit the once-per-instance capability summary LINE to stderr:
  prefix + resolved tier name + a compact present/absent feature indication
  at a level of detail suitable for always-on output (concise, not the full
  per-bit dump);
- a small helper to format a tier enum value to its config name string.
```

Header rule: all always-on shared printing lives here; do not grow bespoke
print routines in detection, dispatch, or backend code - add helpers here and
call them.

### 2.3 print_diag_helper_functions.zig - GATED debug diagnostics (G10 module)

The verbose, debug-only diagnostics. This module is included ONLY via the
ratified G10 C-3 conditional import and is structurally absent from production
builds. It MAY use print_helper_functions.zig internally. Seed it with exactly:

```text
- a verbose per-bit detection dump: for each set-A feature, its name and
  present/absent state, grouped by level, plus the set-B XCR0 result and the
  final whole-level decision with the fallback reason;
- the force-down announcement emitter (loud, unambiguous), reporting BOTH the
  actual detected capability AND the effective (forced-down) capability.
```

Every debug feature in this module carries at least one UNIQUE, greppable
marker (a diagnostic string) so its absence in release is individually
machine-checkable (G10 layer 3).

Header rule: this is a debug-only module; it exists in a binary only when its
gate is on; it must never be imported unconditionally.

### 2.4 The G10 inclusion shape (how 2.3 is reached)

At the single site that emits diagnostics, use the ratified C-3 form:

```zig
const deblock4_config = @import("deblock4_config.zig");

const diag_dbg = if (deblock4_config.debug.enable_verbose_detection)
    @import("print_diag_helper_functions.zig")
else
    struct {};
```

and every use is itself gated:

```zig
if (deblock4_config.debug.enable_verbose_detection) {
    diag_dbg.dumpDetection(record);
}
```

The force-down seam follows the same shape under `enable_force_down` (section
5). Inner content in the gated module is also gated where it has sub-features
(defence in depth, G10 layer 2). Inner gates never license an unconditional
import (G10, forbidden reasoning).

---

## 3. The detection core (production code)

### 3.1 Capability record

Define an immutable capability record populated ONCE. It records, for each
set-A feature, whether the CPU reports it, plus the set-B XCR0 XMM+YMM result,
plus the resolved whole level. The record is immutable after construction (G1).
Represent the resolved level as an enum with exactly the three levels; v1 is the
unconditional floor.

### 3.2 Detection procedure (whole-level, per G3)

1. Execute CPUID for the required leaves, honouring the leaf-availability
   guards in 1.2. A missing optional leaf makes its features absent.
2. Record each set-A feature per the 1.2 contract. OSFXSR and SCE are OS-state,
   not CPUID bits; see 3.3.
3. For the AVX-family (v3) path, execute XGETBV(ECX=0) and record whether
   `(XCR0 & 0x6) == 0x6`. This is set-B and is separate from OSXSAVE (set-A).
4. Compute whole-level membership:
   - v2 satisfied iff ALL v2-addition bits are present AND v1 is satisfied.
   - v3 satisfied iff ALL v3-addition bits are present (including OSXSAVE) AND
     v2 is satisfied AND the set-B XCR0 test passes.
5. Resolve the tier as the highest satisfied level, testing v3 then v2 then v1.
   v1 always succeeds.

No shorthand ("AVX2 means v3", "SSE4.2 means v2") is permitted; membership is
the full set per level.

### 3.3 v1 baseline / OS-state policy (W3X decision, stated not silent)

Per the prep and charter architecture: x86_64_v1 is the UNCONDITIONAL final
fallback. OSFXSR and SCE are OS-enabled state, not user-mode-readable CPUID
bits; a successfully loaded 64-bit Windows DLL already establishes the OS
baseline (the process is executing 64-bit with SSE state managed). Therefore v1
is treated as always satisfied and the detector does NOT attempt to read CR4 or
IA32_EFER. This is a stated policy, recorded here so it is explicit rather than
an unremarked assumption (G6 spirit: the property is established by an explicit,
documented argument).

### 3.4 Detection safety (G5)

Detection uses only CPUID and XGETBV, which are baseline-safe instructions
(CPUID is universally available; XGETBV is executed only after OSXSAVE is
confirmed present, since OSXSAVE indicates XGETBV is usable). Detection itself
must contain NO v2 or v3 instructions (it is the code that decides whether those
are safe; per G2 it cannot require what it detects). Detection runs before any
capability-gated code and never itself enters a gated backend.

---

## 4. Requirement G - detection diagnostics

Two tiers of diagnostic output, split across the two print modules:

### 4.1 Always-on summary (production, print_helper_functions.zig)

Once per relevant construction, emit a single concise stderr line: the prefix,
the resolved tier name, and a compact capability indication. This is always
present (it is not debug-only) and extends the once-per-instance emission
already established in earlier stages. Keep it to one line; it is not the
per-bit dump.

### 4.2 Verbose per-bit dump (debug-only, print_diag_helper_functions.zig)

Under `enable_verbose_detection`, emit the full diagnostic: each set-A feature
present/absent grouped by level, the set-B XCR0 result, the resolved level, and
the FALLBACK REASON when the resolved level is below the highest the headline
bits might suggest (for example: "AVX2 present but BMI2 absent -> not v3 ->
selected v2"). This is the G-requirement detail. It is structurally absent from
production per G10.

---

## 5. Requirement H - debug-only force-down seam

### 5.1 Behaviour

Under `enable_force_down`, the seam may lower the effective capability record to
a requested lower tier (v3 host forced to v2 or v1; v2 forced to v1), by MASKING
OFF real capability bits. The forcing input mechanism (for example an
environment variable read at construction) is defined inside the gated module.

### 5.2 Hard safety rules (G5 / G10)

- FORCE-DOWN ONLY. The seam may only clear capability bits the CPU genuinely
  has. It must be STRUCTURALLY unable to set a bit the CPU lacks - forcing a
  HIGHER or phantom tier must be impossible by construction, not merely
  unreached. (For example: the mask is applied by intersection with actual
  capability, so a request for a higher tier can only ever yield the actual or
  a lower tier, never higher.)
- The seam is announced LOUDLY when active, reporting BOTH actual and effective
  capability distinctly (never presenting the forced value as if it were the
  hardware truth).
- NO BYPASS (G5): the seam is never a route around the guard; it only lowers a
  correctly detected capability. Frame processing and dispatch still consume the
  (now lowered) immutable record; the seam does not create an unguarded call.

### 5.3 Build gating (settled W3X decision)

- Enabling is an EXPLICIT opt-in build option, `enable_force_down`, default OFF.
- build.zig must HARD-REJECT the combination of `enable_force_down=true` with
  any optimize mode other than Debug (a build-time `@panic` / compile error in
  build.zig; force-down is Debug-only). This makes the seam structurally
  impossible in ReleaseSafe / ReleaseFast / ReleaseSmall.
- The seam code lives in the gated diag module (or its own gated module),
  reached only via the C-3 conditional import; it is structurally absent from
  any release build both by the optimize-mode rejection AND by the C-3 gate.

---

## 6. build.zig changes

- Add `enable_force_down` (bool, default false) and `enable_verbose_detection`
  (bool, default false) as `b.option` values.
- Feed both into the generated options module via `b.addOptions` /
  `addOption` / `root_module.addOptions("deblock4_build_options", options)`.
  The imported module name is `deblock4_build_options` (not the bare
  `build_options`).
- Hard-reject `enable_force_down=true` unless optimize mode is Debug (5.3).
- No `-Dcpu` / `-Dtarget` override is introduced or accepted (charter G3 /
  Stage 1B.2 rejection gates remain).
- Named psABI level targets for the backend objects are unchanged from 1B.2.

---

## 7. Proof obligations (Definition of Done)

All must pass; the scope is a PASS only when W3C review of the actual output
confirms them.

### 7.1 Detection correctness

- On the W3X dev host (x86_64_v3), the resolved tier is v3, and the verbose
  dump shows all three levels' bits present and the XCR0 test passing.
- Using the force-down seam (Debug build), forcing v2 yields effective tier v2
  with actual reported as v3; forcing v1 yields v1; a request for a tier ABOVE
  actual yields at most actual (never higher) - demonstrating the structural
  force-down-only property.
- The always-on summary line reports the resolved tier correctly in all builds.

### 7.2 Detection safety (G5 / G2)

- The detection object contains NO v2 or v3 instructions (assembly inspection,
  same method as Stage 1B.2: dumpbin /DISASM of the detection object, checked
  against the level's forbidden-instruction families). Detection is v1-only.
- XGETBV is executed only on the OSXSAVE-present path.

### 7.3 G10 absence proof (layer 3 / G6 tier 3) - STANDING gate, delivered here

A standing, loud-failing validation that in RELEASE builds (ReleaseSafe AND
ReleaseFast), with the debug options OFF, the debug diagnostics and force-down
seam are ABSENT on all THREE surfaces, using seam-unique markers:

```text
- raw binary strings: no diagnostic marker string present;
- PE export table: no seam probe/export name present (if the shape exports one);
- disassembly: no seam-unique machine-code marker present.
```

And the positive control: a Debug build with the options ON shows the markers
PRESENT on the applicable surfaces (so the absence test is meaningful). Also:
`enable_force_down=true` with a non-Debug optimize mode FAILS the build.

This gate is delivered in THIS scope (G6 tier-3 requires the standing gate to
ship with the mechanism it guards). It follows the method proven by
gate_pattern_test_v2; it applies it to the real production DLL.

### 7.4 No regression

- Stage 1B.2's gates still pass (export table, within-level, native-override
  rejection). The 1B.2 validation batch (or its successor) still runs green.
- The whole-level dispatch decision is available as an immutable record but no
  new call into a gated backend is introduced (G5).

---

## 8. New standing rule to record (charter / style)

Add (W3X to ratify, likely a C-STY entry or a note under G10): shared config and
printing have single homes - `deblock4_config.zig` (declarations-only
switchboard), `print_helper_functions.zig` (always-on printing), and
`print_diag_helper_functions.zig` (gated debug diagnostics, G10). Later stages
EXTEND these modules; they must not grow bespoke config constants or print
routines in feature code. This is the "skeleton fully, content minimally,
extend-do-not-fork" rule agreed at 1B.3 scope time.

---

## 9. Deliverables

```text
- deblock4_config.zig                    (new; declarations-only switchboard)
- print_helper_functions.zig             (new; always-on print helpers, seeded)
- print_diag_helper_functions.zig        (new; gated G10 diag module, seeded)
- the detection core                     (new; CPUID/XGETBV, capability record,
                                          whole-level resolve) in an appropriately
                                          named source unit
- the force-down seam                    (gated, Debug-only)
- build.zig                              (options, addOptions, Debug-only reject)
- the G10 absence-proof standing gate    (script/harness, three-surface, with
                                          positive control and build-reject check)
- .vpy / .bat harness as required to run the proofs (W3C deliverable per
  charter 2.4)
```

No production code beyond these items is authorised by this scope. Bring any
gap or ambiguity to W3X rather than resolving it in code.
