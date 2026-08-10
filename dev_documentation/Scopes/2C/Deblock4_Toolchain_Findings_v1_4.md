# Deblock4 - Toolchain Findings

**Version:** 1.4
**Date:** 2026-08-05
**Status:** Informative knowledge record; not controlling. Durable capture of
empirically established Zig/linker toolchain facts, so they are not re-derived.
**Encoding:** US-ASCII only
**Provenance:** Each finding records how it was established (build test, source
read, or inference) per the project's verify-cold discipline.

---

# F1. Zig 0.16 omits an unreferenced non-exported function entirely

**Status: established by build test (W3X Debug build, Stage 1B.1) plus dumpbin
/SYMBOLS on the resulting cache objects. Conclusive.**

Context: Stage 1B.1 needed the SSE4.1/AVX2 backend marker functions to be
present and linked in the DLL but NOT exported (charter G6) and NOT called
(charter G5). The first attempt declared them as ordinary non-exported
functions and tried to retain them with Zig's forceUndefinedSymbol (which emits
a COFF /INCLUDE-class linker requirement):

```zig
pub fn deblock4_backend_probe_sse41_marker() callconv(.c) u32 { return ...; }
```

with, in build.zig:

```zig
dll.forceUndefinedSymbol("deblock4_backend_probe_sse41_marker");
```

Result: the DLL link FAILED with "undefined symbol". dumpbin /SYMBOLS on the
gated cache objects showed:

- `.text` section length ZERO;
- no marker symbol present at all - not under the requested name, not mangled;
- only static build-metadata symbols (builtin.cpu, Target.x86.cpu.x86_64,
  anonymous constants) and the source filename in debug metadata.

Conclusion: **a top-level `pub fn ... callconv(.c)` that is never semantically
referenced (never called, never address-taken) and not declared `export` is
NOT EMITTED by Zig 0.16.** Zig's lazy analysis/codegen omits it. Therefore
forceUndefinedSymbol has nothing to retain - it correctly requests a symbol that
was never generated.

Consequences / rules of thumb:
- `callconv(.c)` sets the calling convention; it does NOT force emission and
  does NOT guarantee an unmangled external COFF symbol name.
- `export` DOES force emission and an external name - but also creates a PE
  export-table entry, which G6 forbids for gated code. So `export` is not a
  usable retention mechanism for non-exported code.
- forceUndefinedSymbol / COFF /INCLUDE can only retain a symbol that actually
  exists in an input object. It cannot cause emission.

# F2. Cross-compilation references do NOT force emission (anchor falsified)

**Status: FALSIFIED by build test (W3X Debug build of the v1.5 delivery) plus
dumpbin /SYMBOLS. Superseded by F4/F5. Retained as a recorded dead end.**

The v1.5 attempt placed an address-taking anchor in the DLL root module which
@import-ed the gated modules and took the address of each marker. Result: both
standalone gated objects STILL had .text length 0 and no marker symbol.

Root cause: each Zig compile step analyses its own module graph independently.
Reusing the same std.Build.Module in two compile steps (the DLL compilation and
a standalone addObject compilation) creates two INDEPENDENT compilations; a
semantic reference in one does not force emission in the other. An @import in
the DLL graph may compile ANOTHER INSTANCE of the gated source inside the DLL
compilation (under murky per-module-target semantics) - it does not create an
inbound reference to the standalone object. Per-module targets are themselves
slated for possible removal (ziglang/zig issue 22285), and mixing targets
across one compilation graph is unsupported territory (issue 3521).

Rule of thumb: emission is decided per compilation unit. To force emission in a
given object, the semantic root must be IN that object's own compilation:
export fn, or a reference from that unit's own graph. Cross-object references
are a LINKER-level matter and require export/@extern pairs (see F4/F5).

The original design principle below is retained for context (it remains the
right shape - address-taken, never called, internal pointers - but the
reference must be @extern at the linker level, not @import across compilations):

To make a gated function present (emitted + linker-retained) while non-exported
and non-executed, give it a genuine SEMANTIC reference that is an ADDRESS
reference, taken by retained baseline code:

```text
- baseline (generic-target) code takes the address of each gated marker and
  stores it into an internal, non-exported pointer or pointer table;
- taking the address forces Zig to EMIT the function (it is now referenced);
- the address reference puts the function in the linker reachability graph, so
  /OPT:REF RETAINS it;
- the address is TAKEN, never CALLED - so no execution path exists (G5 holds);
- nothing is declared export, and the pointer table is internal - so nothing
  enters the PE export table (G6 holds, structurally).
```

The G5-critical distinction: ADDRESS-TAKEN retains code without creating an
execution path; a CALL would create one and is forbidden until the Stage 1B.3
capability guard exists. The anchor must achieve emission + retention +
non-export + non-execution simultaneously.

This is also the shape of the eventual real dispatch mechanism (a
capability-populated function-pointer table, the FFmpeg/dav1d idiom identified
in the retention/export research), so the anchor is a step toward the real
architecture, not a throwaway.

Verification the anchor works (contrast with F1's failure):
- DLL links successfully;
- dumpbin /SYMBOLS on the gated objects shows each marker present with
  NON-ZERO .text;
- dumpbin /EXPORTS on the DLL shows NEITHER gated marker.

# F3. Windows binary inspection tooling

**Status: established by environment inspection (W3X machine).**

- Zig 0.16 ships only a flagless objdump passthrough (lib/compiler/objdump.zig);
  no standalone llvm-objdump or llvm-nm is bundled. `zig objdump --help` shows
  only -h/--help. Inadequate for targeted symbol/export inspection.
- The usable inspector is MSVC `dumpbin`, present in the VS 2026 install under
  `C:\Program Files\Microsoft Visual Studio\18\Community\VC\Tools\MSVC\<ver>\
  bin\Hostx64\x64\dumpbin.exe` (VS product year 2026 = internal version 18;
  two toolsets seen, 14.44.x and 14.51.x).
- dumpbin is reached WITHOUT hard-coding the MSVC version by calling VsDevCmd to
  set the environment, then relying on PATH:
  `CALL "C:\Program Files\Microsoft Visual Studio\18\Community\Common7\Tools\VsDevCmd.bat" -arch=amd64 -host_arch=amd64`
  (note: VsDevCmd changes directory, so restore the working directory after).
- Commands in use: `dumpbin /EXPORTS <dll>` (export-table check),
  `dumpbin /SYMBOLS <obj>` (symbol/emission check),
  `dumpbin /DISASM <dll>` (supplementary only - shows instructions PRESENT, not
  whether any path REACHES them, so never the load-bearing non-execution proof).

# F4. export fn in an addObject-ed object does NOT enter the PE export table

**Status: established by build test (W3X Debug build of the v1.5 delivery) plus
dumpbin /EXPORTS on the built DLL and /LINKERMEMBER on the import library.
Conclusive.**

Evidence: the generic and scalar markers are declared `export fn` in their own
separately compiled objects, added to the DLL with addObject. The built
Deblock4.dll exported ONLY the root-graph export (deblock4_build_probe_value);
neither addObject-ed export fn appeared in the export table or in Deblock4.lib.

Conclusion: on Zig 0.16 + lld-link (COFF/PE), `export` in an OBJECT-mode
compilation grants EMISSION and EXTERNAL LINKAGE but does NOT by itself create
PE export candidacy. A symbol enters .edata only via a dllexport-class directive
from the DLL compilation itself. Three separate properties, three controls:

```text
EMISSION   in-unit semantic root (export fn, or in-graph reference)
LINKAGE    export/@export (definition) + extern/@extern (reference)
PE EXPORT  dllexport-class directive from the DLL compilation only
```

Two consequences:
- An export fn that must be REACHABLE FROM OUTSIDE the DLL (e.g. smoke-test
  targets like the generic/scalar markers) must be part of the DLL root
  compilation graph (import its module into the root), or it will not export
  and the consumer will not link.
- An export fn in an addObject-ed unit is exactly "linkable but not
  PE-exported" - the property needed for gated backend code. Its absence from
  .edata is corroborated by the standing dumpbin /EXPORTS gate (charter G6
  tier 3; tier 2 if an explicit export-list mechanism is available).

This finding motivated the charter v1.10 refinement of the G6 corollary: the
ban is on PE-EXPORT of gated code, not on the export keyword, which is Zig's
only linkage mechanism and is required for emission and cross-object reference.

# F5. The proven Zig idiom for multi-feature-level code in one binary

**Status: established community practice (worked showcase, Ziggit
"Dispatching SIMD functions at runtime", Nov 2024; consistent with accepted
Zig proposal 1018 - function multi-versioning - which is NOT yet implemented,
so manual dispatch is required).**

The pattern:
- Compile the feature code as SEPARATE COMPILATION UNITS, one per feature
  level, each with its own target/-mcpu. One target contract per unit.
- Each unit SELF-EMITS its functions: export fn (or @export) under a unique
  linker-visible name, so emission and linkage are rooted in the unit itself.
- Consumers in the baseline unit reference other units' functions via @extern
  BY NAME, resolved at link time - a genuine cross-object reference edge that
  also retains the code and fails the link loudly if a unit is missing.
- Runtime dispatch: detect the CPU (std.zig.system.resolveTargetQuery with
  .cpu_model = .native; std.Target.x86.featureSetHasAll), then populate
  internal function pointers with the @extern addresses. Address-taken at
  init; called only after the capability check passes.
- Do NOT @import feature modules across target boundaries; the seam between
  target contracts is the LINKER (extern/export), not the module graph.

Deblock4 mapping: gated markers/kernels are export fn in their own
single-target addObject units (F4: linkable, not PE-exported); the DLL-root
baseline anchor (and later the 1B.3 dispatch table) references them with
@extern + address-taken-never-called; generic/scalar modules are imported into
the DLL root graph so their exports genuinely PE-export for the smoke test;
duplicate-symbol rule: a given source is either in the root graph OR a linked
object, never both.

# F6.VAPOURSYNTH COERCES NUMERIC ARGUMENTS    
### To the registered parameter type before the plugin sees them    
### Plugin-side wrong-type detection for int parameters is unreachable    

Observed (Stage 1C, VapourSynth R78): with Classic's strength registered
as int:opt, a Python call supplying strength=1.5 reaches the plugin's
creation callback as an INTEGER (value 1). The Python binding converts
supplied arguments to the registered type when building the VSMap;
mapGetType at the plugin boundary reports ptInt, and the original Python
float identity is not observable. A genuinely ptFloat entry supplied via
the low-level API is rejected by VapourSynth's own invocation boundary
before the plugin runs.

Consequences:
- The plugin CANNOT distinguish a user's 1.5 from 1 for an int parameter.
  Silent truncation at the boundary is a VapourSynth property, not a
  Deblock4 defect, and cannot be fixed plugin-side.
- Proof harnesses must not assert plugin-level wrong-type rejection for
  int parameters (the Stage 1C error_wrong_type case was retired for this
  reason); Deblock4's own validation is proven via range cases instead.
- DESIGN RULE for later stages (2C/2D+): if an integer-registered
  parameter ever exists where silent float truncation would be a
  MEANINGFUL wrong result (the way a wrong grid is), register it as
  float with explicit plugin-side range/step validation instead of
  relying on int coercion. strength's truncation is tolerable; apply
  this test per-parameter when the real algorithms land.

RATIFIED MITIGATION (specified as rider Stage 1C.1): since coercion
cannot be detected, it is made VISIBLE - each filter emits, at creation,
a second stderr line and a matching frame property echoing the RESOLVED
invocation in call syntax with a plain "using" prefix, including
defaulted parameters, so a user who supplied 1.5 sees strength=1
reported back. See the Stage 1C.1 rider scope for the binding
specification.

---

# F7. VapourSynth rejects empty registered-array arguments before the plugin

Observed (Stage 1C, VapourSynth R78): a Python call supplying planes=[] to a
registered int[]:opt parameter is rejected at the VapourSynth invocation
boundary; the plugin creation callback is never entered, so Deblock4's own
"planes must not be empty" diagnostic is unreachable through the normal
Python interface.

Distinction from F6: here the plugin-side check is NOT impossible - the
low-level C API can deliver a zero-element property - so Deblock4's empty-
array validation is RETAINED as low-level-API defence. It is simply not
provable via vspipe.

Consequences:
- The Stage 1C error_empty_planes harness cases were retired (both filters);
  inline comments in both .vpy files record the reason.
- Do NOT delete the production empty-array validation as dead code; it is
  deliberate defence for low-level callers.
- Proof harnesses must not assert VapourSynth's own boundary error text for
  such cases (framework behaviour, VS-version-dependent string).

---

# F8. export fn: object-mode vs DLL-root compilation are DIFFERENT properties

Proven live (Stage 1C Phase 3b, delivery v1_13):

- In a separately compiled OBJECT added via addObject, `export fn` creates an
  external COFF symbol for linkage and dumpbin evidence. Object files have no
  PE export table; no public doorway is created (F4 remains correct).
- In the DLL ROOT compilation graph, the same `export fn` keyword is a
  dllexport-class instruction: the symbol enters the DLL .edata PUBLIC export
  table. For gated debug code this is a charter-G6 violation - a public
  doorway bypassing conditional-import and guarded dispatch.

Observed: the three G10 Debug markers, declared pub export fn in DLL-root
modules, appeared as real export rows (ordinals 3-5) in the Debug DLL. The
standing dumpbin /EXPORTS gate caught it; the fix (delivery v1_13) removed
`export` from the three declarations. Retention and observability survived
unchanged through the existing enabled-path calls and address-taken anchors:
all Debug raw-string and disassembly positive controls stayed live, and the
Debug DLL export table returned to VapourSynthPluginInit2 +
_DllMainCRTStartup only.

Rule: never carry the object-mode export idiom into the DLL root graph.
Emission, linkage, and PE-export are three distinct properties (charter G6
corollary); choose the mechanism per property, and keep the loud-failing
export-table gate standing in all modes.

---

# F9. Zig 0.16.0 ships with LLVM loop autovectorization DISABLED

**Status: established by source read of the Zig 0.16.0 release notes
("Loop Vectorization Disabled to Work Around Regression") and the upstream
reports; W3D-verified 2026-08-05, W3X-adopted. Conclusive for the pinned
toolchain.**

References (attribution of the issue and its resolutions):
- Surfaced by adworacz/zsmooth issue #23, "Zig 0.16.0 update heavily
  impacts performance" (github.com/adworacz/zsmooth/issues/23, opened
  2026-04-14, OPEN at capture): zsmooth's RemoveGrain-family filters rely
  on LLVM loop autovectorization and slowed heavily on 0.16.0.
- Root cause per the Zig 0.16.0 release notes: autovectorization disabled
  to work around an LLVM regression
  (ziglang.org/download/0.16.0/release-notes.html
  #Loop-Vectorization-Disabled-to-Work-Around-Regression).
- Upstream LLVM fix: llvm/llvm-project PR #187023; possible backport to
  LLVM 22 (Zig 0.17), otherwise expected with 0.18.

Deblock4 is IMMUNE BY DESIGN. The project's already-committed resolutions
of this risk class, ratified before the fact surfaced (this discussion was
held at project inception; the prior designer chat "Deblock4 using Zig",
2026-08-01, records the design decision verbatim: "Do not rely on LLVM
auto-vectorization of scalar loops ... Zig currently has LLVM auto
vectorization turned off"):
- charter K1/K24 + D4 S7: explicit @Vector per-tier backends behind one
  canonical formula body; auto-vectorized scalar loops are never the SIMD
  plan.
- the one-DLL per-CPU-level object + load-time function-pointer dispatch
  architecture (README backend design; V&T sections 4/11).
- charter G8 + V&T 3.6/4.4 (the companion guarantee from the same
  discussion, anchored on zsmooth's math build option): zsmooth's
  build.zig:28 defines -Doptimize-float ("Enables 'fast-math'
  optimizations for floating point arithmetic, at the expense of
  accuracy. Defaults to enabled/true."), which sets every float kernel
  to FloatMode .optimized BY DEFAULT (per-filter: float_mode =
  if (config.optimize_float) .optimized else .strict). This is the
  "documented precision/perf trade-off" recorded in V&T 11.4. Deblock4's
  ratified counter-decision: @setFloatMode(.strict) stated explicitly at
  kernel scope, UNCONDITIONALLY - no build knob can enable fast-math;
  .strict and ReleaseFast are INDEPENDENT controls; ReleaseFast does NOT
  imply fast-math; and, verbatim from charter G8: "General fast-math
  (.optimized) is rejected as a default." Compiler transformation of our
  arithmetic is thereby locked out on BOTH axes zsmooth leans on: loops
  (explicit @Vector, never autovec) and float expressions (.strict,
  never .optimized). Issue #23 is the failure mode of the first leg;
  the second leg was rejected at charter v1.11.

Corollaries and standing TRIGGERS:
- (a) ORACLE-PURITY BONUS: on 0.16.0 the 2C ReleaseFast scalar oracle is
  GENUINELY scalar - the compiler cannot silently vectorize it.
- (b) TOOLCHAIN-BUMP TRIGGER (0.17/0.18+): autovectorization may
  re-enable and vectorize the scalar path. The mandatory full-matrix
  re-run at any toolchain change IS the byte-identity proof (the D3
  permanent vectors and the K10 RS-vs-RF gate); integer outputs must
  remain byte-identical regardless of vectorization (charter K2).
- (c) PERFORMANCE-BASELINE CAVEAT: any speedup measured against a scalar
  baseline built on 0.16.0 is inflated by the artificially slow
  baseline. Every recorded performance claim states its exact toolchain
  and is re-baselined on toolchain change (bears on 3C measurements and
  4C/5C speedup evidence).

---

# F10. Zig/LLVM f16 ARITHMETIC is pathologically slow; f16<->f32 casts are fast

**Status: established by source read of ziglang/zig issue #19550 (OPEN,
milestone "upcoming" at capture 2026-08-05); W3D-verified, W3X-adopted.
Re-check owed at float-step scoping.**

References (attribution):
- ziglang/zig issue #19550, "f16 performance is abysmal, u8, u16, f32 and
  casting f16 to f32 performance is excellent"
  (github.com/ziglang/zig/issues/19550, opened 2024-04-05 by adworacz
  from a video-processing workload; labels enhancement/optimization;
  milestone upcoming; OPEN at capture). Reported magnitude: several
  hundred fps at 1080p for u8/u16/f32 vs 5-10 fps for f16 (~100x), due
  to per-element soft promotion in the lowering; hardware f16<->f32
  conversion (F16C, part of x86-64-v3) is fast.

Consequence for the FUTURE Classic float step (carried in D4 S1's FUTURE
list; float is REFUSED in 2C):
- f16 (VapourSynth 16-bit float) is a STORAGE width, never a COMPUTE
  width: widen to f32 on load, perform ALL arithmetic in f32 under the
  ratified float discipline (V&T 3.4-3.6; charter G8 .strict; K6 no
  @mulAdd), narrow on store.
- ORDERING RULE: this compute-width decision is pinned BEFORE the owed
  K22/V&T 3.8 float tolerance NUMBERS are derived, because tolerances
  are semantics-dependent - numbers derived against f16 arithmetic would
  be invalid for f32-arithmetic-with-f16-storage and vice versa.

IMPLEMENTATION GUIDANCE for the float step (from an external research
memo - Google AI Studio, supplied by W3X 2026-08-06 - W3D-verified and
annotated; ADOPTED as guidance, with the float scope settling the
binding form):
- F16C FACTS (W3D-verified against the x86-64-v3 definition): neither
  test CPU (Ryzen 3900X Zen 2; i5-4670 Haswell) has native f16
  arithmetic; BOTH have F16C conversion (vcvtph2ps/vcvtps2ph). F16C is
  a defining x86-64-v3 feature, so this maps onto the existing tier
  model: v3 backends use hardware conversions; the v1 scalar path uses
  soft conversion - still one conversion per sample, not per op.
- GRANULARITY RULE (corrected 2026-08-06 per the W3C contribution;
  supersedes the earlier register/row wording): whole-plane widening is
  NEVER used (a 4K f32 staging plane ~32MB thrashes every cache level;
  the i5-4670 has 6MB L3 total; the 3900X's 64MB aggregate L3 does not
  make it free). But row-level f32 RETENTION is not automatically safe
  either, because deblocking is NOT pointwise: edges read multi-sample
  footprints, write several samples, and LATER EDGES CONSUME EARLIER
  EDGES' STORED RESULTS - retaining unrounded f32 across dependent
  edges lets a later edge read what would have been an f16-rounded
  store, changing output. In-house proof that this dependency is
  load-bearing IN THIS ALGORITHM: the integer O-4 order-sensitivity
  obligation (swapped crossing order first differs at (2,5)) exists
  precisely because later edges consume earlier writes. SAFE DEFAULT:
  per-edge (or dependency-safe vector group) widen -> complete edge
  formula in f32 -> narrow each written result to f16 IMMEDIATELY ->
  store -> dependent edges RELOAD the f16. Row or tile scratch
  RETENTION is permitted only after proving no required f16 write/read
  boundary is bypassed. Cache sizing is necessary-not-sufficient:
  kernels need several source/destination rows at once, vertical
  passes have different locality, per-thread scratch multiplies the
  footprint, and a ~15KB stack allocation per active call may be
  undesirable - VapourSynth worker threads may run with modest stack
  sizes, so large automatic stack buffers risk overflow (third-review
  rationale, 2026-08-06). A preallocated scratch area or small
  dependency-safe tile may beat a stack row, BUT the naive
  "allocate per thread at clip init" pattern does not map onto the VS
  threading model (the core owns the thread pool; a filter does not
  know worker count at instance init) - pooled scratch or per-frame
  temporaries are the real candidates (fmParallel allocation doctrine
  applies; float-scope design item).
- ACCEPTANCE-MODEL CLARIFICATION (pinned so it is not re-asked):
  B-semantics does NOT conflict with reference comparison, because the
  ratified acceptance doctrine makes the FLOAT differential
  TOLERANCE-BASED (K19 layer (b); V&T 3.8); bit-identity is an
  INTEGER-domain requirement only (K19 layer (c)). Choosing B is
  therefore compatible with the acceptance model by construction.
- SOURCE-AUTHORSHIP NOTE (this dissolves the #19550 trap without any
  charter concession): the float kernel is AUTHORED in f32 with
  explicit @floatCast at the load/store boundaries. The compiler then
  never sees f16 arithmetic to per-op round; G8 .strict governs the
  f32 math unchanged. The memo's suggestion to reach for
  @setFloatMode(.optimized) is REJECTED on two grounds: (1) it is the
  fast-math default charter G8 rejects verbatim and is unnecessary
  under f32 authorship; (2) per the Zig 0.16.0 documentation
  (W3C-verified), .optimized may reassociate, contract, disregard
  signed zero and leave NaN/Inf results UNDEFINED - which is
  INCOMPATIBLE with the ratified non-finite policy (V&T 3.4), not
  merely disfavoured.
- SEMANTICS NOTE (A/B framing per the W3C contribution): two distinct
  algorithms exist - (A) true binary16 semantics, every intermediate
  rounds to f16; (B) f16-storage/f32-computation, widen once per edge
  computation, narrow only at the defined write boundary. They are NOT
  numerically equivalent; B must be RATIFIED AS THE SEMANTICS at the
  float step (per the ordering rule above, before the K22/V&T 3.8
  tolerance numbers are derived) and must never be introduced merely
  as an "optimisation" of A. Double-rounding at the f32->f16 store is
  acknowledged and part of B's definition.
- F16C TIER-CONFINEMENT OBLIGATION (seed; extends the 1B.x leakage
  discipline): v1/v2 compiled objects must contain NO F16C
  instructions (F16C is x86-64-v3 per the psABI, verified from two
  sides); v3 uses F16C only through guarded v3 dispatch. Provable the
  same way the existing per-object target isolation is proved.
- CAUTION on the memo's example code: it indexes a typed f16 slice
  with an ELEMENT-unit stride - the K31 silent-unit trap (VapourSynth
  strides are BYTES). The memo is concept guidance, NOT pattern code;
  K31's models govern the real implementation.

SEED INVESTIGATION LIST for the float scope (W3C-contributed
2026-08-06, adopted as the checklist the float scope must schedule):
  F16-1 define f16 semantics explicitly (A vs B above);
  F16-2 inspect Zig assembly for scalar+vector f16 formulas in
        ReleaseSafe and ReleaseFast on the then-current toolchain
        (zig build-obj emitted binaries or Compiler Explorer; confirm
        clean F16C, no hidden emulation calls);
  F16-3 prove v1/v2 objects contain no F16C; v3 only via guarded
        dispatch;
  F16-4 compare direct f16 arithmetic, per-edge widen/compute/narrow,
        row scratch, small-tile scratch, whole-plane f32;
  F16-5 test SEQUENTIAL DEPENDENCY equivalence, not merely independent
        pixel formulas;
  F16-6 benchmark both test CPUs incl. multiple concurrent VapourSynth
        frames;
  F16-7 inspect code size, conversion count, cache misses, memory
        traffic and actual output differences;
  F16-8 keep non-finite, signed-zero, FMA and tolerance policy
        explicit; never use .optimized merely for code generation.

Standing TRIGGERS at float-step scoping:
- re-check #19550 status on the then-current toolchain before assuming
  the storage-only rule is still load-bearing (it remains CORRECT for
  accuracy either way; the issue only decides how much it also matters
  for speed);
- pin HolyWu's actual float input domain as an external layer-(b) fact:
  its float specialisation computes in 32-bit float (deblock.cpp); its
  FLOAT16 acceptance is UNVERIFIED and must be established before any
  f16 differential is contemplated.

---

*This file is informative knowledge capture so hard-won toolchain facts are not
re-derived in a later chat. The charter and README prevail for any controlling
rule.*

Revision: v1.4 addendum 3 (2026-08-06) Third independent review
(W3X-supplied) confirmed the recorded position with no corrections;
folded in: the VS worker-stack-size rationale with the caution that
per-thread-at-init allocation does not map onto the VS thread model
(pooled/per-frame scratch are the candidates); the acceptance-model
clarification (B-semantics compatible by construction - float
differential is tolerance-based per K19(b)/V&T 3.8, bit-identity is
integer-only per K19(c)); the F16-2 assembly-inspection tooling hint.
Revision: v1.4 addendum 2 (2026-08-06) F10 corrected and extended per
the W3C contribution on the same memo (W3D-verified): the granularity
rule gains the dependency-semantics correction (deblocking is not
pointwise; per-edge widen/narrow with f16 reload is the safe default;
row/tile retention only after boundary proof; in-house O-4
order-sensitivity cited as proof the dependency is load-bearing); the
A/B semantics framing added (B ratified as THE semantics, never an
optimisation of A); the .optimized rejection upgraded to INCOMPATIBLE
with the V&T 3.4 non-finite policy per the Zig docs; the F16C
tier-confinement obligation seeded; cache necessary-not-sufficient
nuances recorded; the W3C F16-1..F16-8 checklist adopted as the float
scope's seed investigation list. Provenance: memo W3X-supplied;
analysis W3C; verification W3D; adoption W3X.
Revision: v1.4 addendum (2026-08-06) F10 extended with W3X-supplied
external research, W3D-verified/annotated: F16C facts mapped to the
tier model; register/row widening granularity rule (never whole-plane;
cache-bandwidth rationale); f32 source-authorship note dissolving the
per-op f16 rounding trap with NO fast-math (the memo's .optimized
suggestion REJECTED per charter G8's verbatim fast-math rejection);
single-rounding semantics pinned per the ordering rule; caution that
the memo's example code carries the K31 element-unit stride trap and
is concept guidance only.
Revision: v1.4 (2026-08-05) Added F9 (Zig 0.16.0 autovectorization
disabled; zsmooth #23 attribution; immunity-by-design record naming the
committed resolutions charter K1/K24 + D4 S7, the one-DLL dispatch
architecture, and the companion charter G8 / V&T 3.6/4.4 .strict
guarantee with its anchor: zsmooth build.zig -Doptimize-float fast-math
default, rejected verbatim by G8; toolchain-bump and performance-
baseline triggers) and F10
(zig #19550 f16 arithmetic pathology; f16-storage-never-compute rule for
the future Classic float step; tolerance-ordering rule; float-step
re-check triggers). Proposer W3D on W3X's question; W3X-adopted
2026-08-05. v1.3 and earlier: see prior revisions.
