# Deblock4 - Stage 1B.1 Retention/Export Research Package

**Version:** 1.0
**Date:** 2026-07-25
**Status:** Informative research record and designer assessment; not controlling.
**Prepared for:** W3X and W3C review
**Relates to:** Stage 1B.1 delivery (S1B1_backend_object_isolation_v1), charter v1.9 invariant G6
**Encoding:** UTF-8 (contains em dashes from the external tool's verbatim output; project sources remain US-ASCII)

---

# Purpose

During designer review of the Stage 1B.1 delivery, W3X raised a concern: the
delivered retention mechanism marks the SSE4.1/AVX2 marker functions with the
Zig export keyword and relies on the toolchain NOT adding them to the PE export
table. That is implicit toolchain behaviour. If a future toolchain release
changed it, the G5 safety property (gated code unreachable before the
capability guard) could break silently.

W3X commissioned external research (Google AI Studio, free tier) before
deciding. This document records (a) the exact research query, (b) the tool's
full thinking and findings verbatim, and (c) the designer's assessment and
recommended position. The coder is asked to review all three and respond per
the scoping query that accompanies this package.

---

# Part A - The research query as issued

```text
Research question: making CPU-feature-specific code unreachable except through a runtime guard,
inside a single shared library

I'm building a single shared library (a Windows x64 DLL, though general answers are welcome)
that contains multiple implementations of the same routines compiled for different CPU feature
levels — a baseline x86-64 version, an SSE4.1 version, and an AVX2 version — selected at runtime
after CPU capability detection. This is the standard "runtime CPU dispatch / function multi-versioning"
pattern.

My core requirement is a safety property. The feature-specific code (e.g. the AVX2 version) must
be present and linked into the single library, but it must be unreachable by any path except through
my own runtime capability guard. If feature-specific code could be reached before the guard confirms
the CPU supports it, an AVX2 instruction could execute on a CPU lacking AVX2 and fault.

I do not want to presuppose which mechanism achieves this. Exposure through the library's public export
table is one unwanted path, but I'm interested in the goal generally: any structural, linker, or
code-generation technique that makes the feature-specific code reachable ONLY after the guard,
by whatever means. Approaches that make the "export" question irrelevant altogether are equally or
more interesting — for example, reaching the code only via a guard-populated function pointer
(so there's no callable named symbol to expose), delayed linkage or resolution, or making the
code non-addressable from outside the module by construction.

I also want to avoid depending on implicit toolchain behaviour (e.g. "the linker happens not to
expose this symbol unless asked"), because implicit behaviour can change silently across toolchain
releases and break the safety property without warning. I'd prefer techniques where the safe
property is a positive, explicit declaration rather than an incidental default.

Please surface established techniques, prior art, papers, blog posts, or standard idioms
addressing any of the following, ideally naming trade-offs:

1. Patterns for runtime CPU feature dispatch inside one binary where the feature-specific code is
deliberately kept off the callable public interface. How do well-known projects — glibc IFUNC,
FFmpeg, x264/x265, dav1d, Google Highway, other SIMD libraries — structure this, and specifically
how (if at all) do they prevent feature-specific entry points from being reachable before the guard runs?

2. Techniques to retain a function in a linked binary (prevent dead-code elimination) without making
it externally callable — keeping internal code alive so it's present for linkage/inspection while
remaining non-public. Linker/compiler mechanisms are in scope (e.g. COFF/PE /include, GNU used/retain
attributes, KEEP in linker scripts, module-definition/.def files, explicit export allowlists, version
scripts, symbol visibility control). Please distinguish which make exposure a positive, explicit
declaration versus which rely on default behaviour.

3. Any discussion of the soundness angle: guaranteeing feature-specific instructions cannot execute on
an unsupporting CPU via any unguarded path (static initialisers, symbol enumeration, export tables,
import thunks, function pointers), and how that guarantee is made robust against toolchain/compiler
version changes rather than resting on incidental behaviour.

Please exclude the "ship multiple separate binaries and let the loader pick the best one at load time"
approach — I've already evaluated and rejected it; I specifically need the single-binary,
internally-dispatched case.

Toolchain context for applicability: my build uses the Zig compiler (version 0.16) producing a
Windows x64 COFF/PE DLL with the MSVC-style linker (lld-link). General C/C++/linker techniques
are exactly what I want to hear about — but where you name a specific technique, please note
whether it's ELF/GNU-specific, COFF/PE-applicable, or toolchain-agnostic, so I can judge whether
it maps onto a Zig/COFF/PE build. I'll verify actual Zig 0.16 behaviour myself by building;
I'm asking you to surface candidate techniques and their applicability, not to confirm Zig specifics.

Two requests on how to answer: (a) distinguish clearly between techniques you can point to as
established and documented versus your own inference — I'd rather have "I'm not certain, here's a
lead to verify" than a confident answer I then have to disprove; (b) if there's no well-known
standard solution to part 2 and it's genuinely a niche area, say so plainly rather than
manufacturing one — knowing it's niche is itself useful.
```


---

# Part B - Google AI Studio output, verbatim

```text
GOOGLE AI STUDIO - THINKING PROCESS:

**Defining the Objective**

I'm currently focused on defining the core objective. It's about crafting a response that addresses a safety issue or architectural concern related to CPU-feature-specific code, specifically inside a larger system. I'm aiming for a comprehensive answer, but need to be sure the objective is completely understood.


**Analyzing the Reachability**

I'm now zeroing in on the critical constraint: ensuring the feature-specific code is completely unreachable before the runtime check. The goal is explicit positive declaration, not implicit behavior. I am also investigating the impact on single shared libraries. I am also studying existing dispatch patterns, to learn from.


**Investigating Implementation Tactics**

I'm now diving into implementation details. Specifically, I'm examining how projects like x265, dav1d, and Google Highway manage access to feature-specific code. I'm also researching ways to keep internal code linked without making it publicly accessible, focusing on COFF/PE and ELF mechanisms. Furthermore, I'm looking into guarantee analysis, to avoid misoptimizations and other potential pitfalls. I'm also going to maintain epistemic honesty.


**Examining Static Linking**

I'm now investigating relocation. I see that if CPUID is checked *before* `main()` or DLL entry, it is safe. Feature-specific functions should be internal, static, hidden symbols. COFF/PE lacks IFUNC, so manual function pointers or vtables are needed. Examples like x264/x265 and dav1d use separate assembly routines or SIMD C with specific compiler flags. Internal symbols are often static or hidden. In these examples, a function pointer table is populated at runtime by an init function.


**Evaluating Dispatch Techniques**

I am now focusing on different dispatch techniques. I see that Google Highway relies on dynamic dispatch, compiling the same code multiple times with varying targets within internal namespaces, alongside a function pointer array initialized by `hwy::SupportedTargets()`. Conversely, FFmpeg employs function pointer structs like `DSPContext`, initialized by functions that overwrite pointers based on a CPUID check. Their internal functions are, as expected, internal and static.


**Addressing Linkage Issues**

Now, I'm concentrating on the problem of retaining code that's conditionally accessed via runtime pointers, without accidentally exporting it in COFF/PE. Since it's not exported by default, this means explicit declaration is needed. I'm focused on how to make sure that the feature-specific code isn't stripped out by DCE.


**Exploring Retention Strategies**

I'm now investigating explicit declaration methods to prevent DCE from removing feature-specific code in COFF/PE. Using `/INCLUDE:symbol_name` with `lld-link` or `#pragma comment(linker, "/include:symbol_name")` in C/C++ appears promising. I'm also examining the equivalents in Zig, and comparing these approaches to GNU/ELF strategies like `__attribute__((used))`, `__attribute__((retain))`, and linker scripts with `KEEP`. Furthermore, I am investigating how symbol visibility and version scripts are relevant here.


**Identifying Potential Vulnerabilities**

I'm now pinpointing ways AVX2 code could run prematurely. I've identified the risk of compiler auto-vectorization across translation units if global flags are applied. To fix this, translation units with AVX2 code must use appropriate flags, while baseline code must stick to baseline flags. Also, I'm examining inlining leaks through LTO or header inclusion, which can inject AVX2 instructions into baseline functions. The solution involves using `noinline` attributes and keeping AVX2 code isolated.


**Refining Safety Precautions**

I'm now zeroing in on specific vulnerabilities. I've identified risks in static initializers, like C++ constructors in AVX2 translation units. The current fix aims for pure C implementations, no global constructors in feature TUs. I'm also addressing symbol export leakage in COFF/PE through explicit `.def` or `/EXPORT` declarations, and avoiding "export all symbols" flags.


**Comparing Implementation Patterns**

I'm now comparing patterns across glibc IFUNC, FFmpeg, and other libraries to understand how entry points are hidden. Function pointers/vtable approaches versus resolver patterns are being assessed. I am also investigating retention strategies for COFF/PE versus ELF, focusing on directives like `/INCLUDE`, `#pragma comment(linker)`, and `.def` files for COFF/PE and `retain`, `visibility("hidden")`, and linker scripts for ELF, to understand the differences between explicit declaration versus implicit default approaches. Finally, I have begun forming a comprehensive threat model to understand potential leak vectors.


**Mapping Toolchain Behavior**

I'm now mapping mechanisms directly to a Zig 0.16 + `lld-link` context. The focus is now on explicitly labeling sections as "[Established Prior Art]", "[Documented Toolchain Behavior]", or "[Inferred Architecture / Analysis]". I acknowledge that while CPU dispatch is standard, proving the static impossibility of pre-guard execution is a niche formal-soundness concern, usually addressed via disciplined module isolation rather than single standard compiler primitives. Also, I am clarifying that for COFF/PE, DLL exports *only* occur via explicit declaration, thus defaults to safe (hidden). However, dead-code elimination might still strip internal functions even if referenced by dynamic function pointers.


**Confirming Static References**

I'm now confirming the implications of direct address assignment within an initialization routine for the Zig/`lld-link` combination. It appears that as long as the AVX2 function's address is explicitly referenced, the linker's reference graph will preserve it. This means explicit retention flags are not necessary when using direct function address assignment, but are still relevant if there is a more dynamic setup. I am exploring the applicability of this insight across various scenarios.

GOOGLE AI STUDIO - RESPONSE:

This report provides a systematic analysis of runtime CPU dispatch patterns, symbol visibility controls, code retention mechanisms, and soundness guarantees for single-binary shared libraries.

To maintain epistemic clarity, content is explicitly categorized into **[Established Prior Art]** (documented patterns in production codebases/toolchains), **[Documented Toolchain Behavior]** (formal specifications of linkers/compilers), and **[Inferred Architecture / Analysis]** (architectural synthesis applied to your target context).

---

### Epistemic Assessment: Is this a Niche Problem?

**[Inferred Architecture / Analysis]**
Yes, this is partially a niche requirement. While *runtime CPU dispatch* is ubiquitous, the specific requirement of **proving formal unreachability** (guaranteeing that feature-specific code cannot execute prior to capability validation, regardless of toolchain updates) is rarely formalized by toolchains as a single unified compiler primitive.

Instead, major projects achieve this guarantee through a combination of **strict modular boundaries, translation-unit (TU) flag isolation, and reference-graph anchoring**.

---

### 1. Real-World Dispatch Patterns & Reachability Analysis

Different open-source projects approach feature isolation and symbol reachability using specific paradigms.

```
+-----------------------------------------------------------------------------------+
|                                 PUBLIC DLL API                                    |
|                               (e.g. my_lib_process)                               |
+-----------------------------------------------------------------------------------+
                                          |
                                  [Dispatch Layer]
                     (Executes Guard / Populates Function Pointer)
                                          |
                    +---------------------+---------------------+
                    |                                           |
         (Guard: CPUID supported)                       (Fallback)
                    |                                           |
                    v                                           v
    +-------------------------------+           +-------------------------------+
    |  Internal AVX2 Implementation |           | Internal Baseline Impl        |
    |  (NOT exported in .edata)     |           | (NOT exported in .edata)      |
    +-------------------------------+           +-------------------------------+
```

#### A. glibc IFUNC (Indirect Functions)
* **Mechanism:** **[Established Prior Art]** (ELF-Specific)
  Uses GNU `__attribute__((ifunc("resolver_name")))`. The dynamic linker (`ld.so`) executes the `resolver_name` function during relocation (before `main()` or object initialization) to populate ELF relocation entries (`R_X86_64_IRELATIVE`).
* **Reachability Isolation:** The target implementation functions (e.g., `_process_avx2`) are marked static or given hidden visibility (`__attribute__((visibility("hidden")))`). They are absent from the dynamic symbol table (`.dynsym`).
* **COFF/PE Applicability:** **Not applicable.** COFF/PE lacks an equivalent loader-level dynamic relocation resolver mechanism like `IRELATIVE`.

#### B. FFmpeg / x264 / x265 / dav1d
* **Mechanism:** **[Established Prior Art]** (Toolchain-Agnostic C/ASM pattern)
  These projects compile CPU-specific implementations into standalone translation units (or NASM/YASM assembly files). They expose an internal initialization function (e.g., `ff_blockdsp_init_x86(DSPContext *c, unsigned flags)`).
* **Reachability Isolation:**
  1. **Public API Restriction:** Individual SIMD functions are **never** declared in public header files and are **never** exported from the shared library dynamic table.
  2. **Indirection via Context Tables:** Callers interact exclusively with function pointers contained in an opaque context struct (`DSPContext`).
  3. **Explicit Guard Initialization:** Context function pointers are initialized to `NULL` or baseline variants. Calling the initialization routine executes `cpuid`, validating capabilities before assigning target addresses to the struct pointers.
* **COFF/PE Applicability:** Fully applicable. This is the dominant pattern for cross-platform C projects targeting Windows DLLs.

#### C. Google Highway (`hwy`)
* **Mechanism:** **[Established Prior Art]** (C++ Header-Only / Multi-Targeting)
  Uses generic C++ templates compiled multiple times across different vector targets within distinct, anonymous/internal namespaces (`hwy::N_AVX2`, `hwy::N_SSE4`, etc.).
* **Reachability Isolation:**
  Highway utilizes dynamic target tables (`HWY_DYNAMIC_DISPATCH`).
  1. Symbols are enclosed within C++ anonymous namespaces or internal linkage units.
  2. Address acquisition occurs exclusively through `HWY_DYNAMIC_DISPATCH(func)`, which routes through `hwy::SupportedTargets()` at runtime.
  3. Because the symbols exist in anonymous namespaces within private translation units, they are structurally unaddressable outside those units.

---

### 2. Code Retention vs. Export Control (COFF/PE Context)

A core challenge when keeping feature-specific functions off the public export table is preventing **Dead Code Elimination (DCE)** or **Identical COMDAT Folding (ICF)** from removing or merging them.

#### COFF/PE Model vs. ELF Model

| Concept | ELF / GNU Linker (`ld`, `gold`, `lld`) | COFF/PE Linker (`link.exe`, `lld-link`) | Positive Declaration Status |
| :--- | :--- | :--- | :--- |
| **Default Symbol Visibility** | **Public** (`default`) — All non-static symbols enter `.dynsym` unless hidden. | **Private** — No symbol is exported in `.edata` unless explicitly declared. | **COFF is Safe-by-Default** for exports. |
| **Explicit Exporting** | Export maps, `__attribute__((visibility("default")))`. | `.def` `EXPORTS` section, `/EXPORT:` flag, or `__declspec(dllexport)`. | Positive declaration required in COFF. |
| **Dead Code Elimination (DCE)** | `--gc-sections` | `/OPT:REF` | Active by default in release builds. |
| **Force Code Retention** | `__attribute__((used))`, `__attribute__((retain))`, or Linker script `KEEP()`. | `/INCLUDE:symbol_name` or `#pragma comment(linker, "/include:...")`. | Positive declaration available in both. |

#### Detailed Retention Techniques for COFF/PE

1. **Static Reference Graph Anchoring [Documented Toolchain Behavior]**
   * *How it works:* If a library-internal dispatch initialization function (e.g., `lib_init_dispatch()`) contains an explicit conditional branch assigning `&my_avx2_impl` to an internal function pointer based on CPUID checks, `my_avx2_impl` is **statically referenced** in the call graph rooted at `lib_init_dispatch()`.
   * *DCE Safety:* `/OPT:REF` traces the root set (public exported API entry points). Because the public API calls `lib_init_dispatch()` (or `DllMain` calls it), `my_avx2_impl` is reachable in the *linker's dependency graph* and **will not be eliminated**, even though it is completely absent from the `.edata` DLL Export Directory.
   * *Export Safety:* Because `my_avx2_impl` lacks `__declspec(dllexport)` and is omitted from the `.def` file, `lld-link` will **never** place it in the exported symbol table.

2. **Explicit Linker Retention Directives (`/INCLUDE`) [Documented Toolchain Behavior]**
   * *How it works:* If functions are decoupled from a static initialization call graph (e.g., registered via self-registering section tables), you can force `lld-link` to keep them without exporting them by issuing a linker command:
     `/INCLUDE:symbol_name`
   * *Source-Level Emission:* In C/C++, this can be positively declared inside the source file containing the feature code:
     `#pragma comment(linker, "/include:my_avx2_impl")`
   * *Result:* The symbol is added to the linker's root set for code retention (`/OPT:REF`), but **is not** added to the Export Directory (`.edata`).

---

### 3. Soundness Guarantees: Preventing Pre-Guard Execution

To guarantee that AVX2 instructions cannot execute prior to capability verification, four distinct failure modes must be eliminated.

#### Failure Mode 1: Compiler Auto-Vectorization Leakage
* **Threat:** **[Inferred Architecture / Analysis]**
  If SIMD flags (e.g., `-mavx2` or `/arch:AVX2`) are applied globally across the entire compilation unit, the compiler's auto-vectorizer may inject AVX2 instructions into baseline functions—such as the CPUID detector itself or DLL entry point routines (`DllMain`).
* **Prevention Technique:** **[Documented Toolchain Behavior]**
  * **Translation Unit Flag Isolation:** Compile baseline code (including CPUID detection and runtime dispatch logic) in TUs strictly configured with baseline flags (`/arch:SSE2` or default x64).
  * **Function-Level Target Attributes:** In compilers supporting target attributes, restrict AVX2 target flags strictly to feature-specific implementation functions, leaving dispatch logic baseline-targeted.

#### Failure Mode 2: Cross-TU Inlining and Link-Time Optimization (LTO/LTCG)
* **Threat:** **[Inferred Architecture / Analysis]**
  With LTO enabled, the linker/compiler might inline an AVX2 function into a baseline function that runs *before* or *outside* the runtime guard, bypassing isolation.
* **Prevention Technique:** **[Documented Toolchain Behavior]**
  * Mark all feature-specific implementation entry points with explicit **no-inline** attributes (`__declspec(noinline)` / `__attribute__((noinline))`).
  * Enforce strict translation unit boundaries and avoid placing SIMD-dependent code in shared, non-guarded header files.

#### Failure Mode 3: Static Initializers / CRT Constructors
* **Threat:** **[Documented Toolchain Behavior]**
  C++ global object constructors or C `__attribute__((constructor))` routines execute during module load (`.CRT$XCU` sections in COFF), running *before* user library entry points. If feature-specific TUs contain global constructors, they can trigger illegal instructions before guards run.
* **Prevention Technique:** **[Established Prior Art]**
  * Ban static C++ constructors/initializers in feature-specific code units.
  * Ensure feature-specific modules are pure functions or C-style data-driven units initialized explicitly via the CPU-guarded dispatch setup function.

#### Failure Mode 4: Symbol Export and Direct Binding Leaks
* **Threat:** **[Documented Toolchain Behavior]**
  An external consumer links directly against a feature-specific symbol because it was accidentally exposed in the shared library export table.
* **Prevention Technique:** **[Documented Toolchain Behavior]**
  * **In COFF/PE:** COFF defaults to hiding symbols. Ensure build flags do not specify "export all symbols" (e.g., avoid `--export-all-symbols` if using MinGW-style flags in `lld-link`). Maintain an explicit allowlist via a module-definition file (`.def`).
  * **Symbol Address Elimination:** Maintain feature implementations as internal function pointers or static/private symbols so no named entry point exists for dynamic resolution via `GetProcAddress`.

---

### 4. Toolchain & Platform Applicability Matrix

Mapping the techniques directly to your build target: **Windows x64 COFF/PE DLL using Zig 0.16 and `lld-link`**.

| Technique | Platform Scope | COFF / `lld-link` Applicable? | Positively Declared? | Zig 0.16 Toolchain Applicability Notes |
| :--- | :--- | :--- | :--- | :--- |
| **Opaque Pointer Context Structs (FFmpeg/dav1d pattern)** | Universal | **Yes** | **Yes** | Native language design pattern. Implement via internal structs containing function pointers populated at init. |
| **Explicit Symbol Hiding (`.def` allowlist)** | COFF/PE | **Yes** | **Yes** | Use a `.def` file or pass explicit export arguments to `lld-link`. Only symbols listed in the `.def` enter `.edata`. |
| **Linker Root Retention (`/INCLUDE`)** | COFF/PE | **Yes** | **Yes** | Pass `-Wl,/include:symbol_name` to `lld-link` via Zig's link configuration, forcing symbol retention across `/OPT:REF`. |
| **Call Graph Reference Retention** | Universal | **Yes** | **Yes** | Default compiler/linker behavior. An explicit address assignment in a reachability path guarantees retention without export. |
| **TU Flag Separation** | Universal | **Yes** | **Yes** | Compile AVX2 functions in a Zig module target-configured for AVX2, and dispatch/CPUID logic in a baseline target module. |
| **No-Inline Directives** | Universal | **Yes** | **Yes** | Use `@inlineWithCall(.never)` or `callconv` attributes in Zig to prevent unwanted cross-boundary inlining during LTO. |
| **ELF IFUNC (`IRELATIVE`)** | ELF-only | **No** | N/A | **Inapplicable to COFF/PE DLLs.** Do not attempt to use GNU IFUNC primitives on PE/COFF. |

---

### Recommended Architecture Summary

To implement this safely and robustly in a Zig 0.16 + `lld-link` DLL build:

1. **Compilation Isolation:**
   * Module A (Baseline target): Contains CPUID capability check logic, public library export API, and internal function pointers initialized to `null`.
   * Module B (AVX2 target): Contains AVX2-optimized functions. Must be marked `@inlineWithCall(.never)` at entry points.
2. **Explicit Linkage Graph:**
   * Module A exposes an internal init function `initDispatch()`.
   * `initDispatch()` executes CPUID. If AVX2 is supported, it assigns addresses of Module B functions to internal pointers.
   * *Effect:* Linker `/OPT:REF` retains Module B code because it is referenced in `initDispatch()`.
3. **Strict Export Control:**
   * Manage exported symbols strictly through Zig's `export` keyword on public API wrappers or via an explicit `.def` file passed to `lld-link`.
   * Module B functions must **never** use the `export` keyword. This guarantees zero entry points in the PE `.edata` export table, rendering pre-guard invocation via external callers or external dynamic linking physically impossible.
```


---

# Part C - Designer assessment and position (W3D)

## C.1 Credibility sorting

The tool was asked to label claims by epistemic status and did so. My sorting:

TRUST AND ACT ON (documented toolchain behaviour, independently consistent
with how COFF/PE works):

- COFF/PE is SAFE-BY-DEFAULT for exports: no symbol enters the PE export
  table (.edata) unless positively declared (export keyword / .def EXPORTS /
  /EXPORT). This directly answers the implicit-behaviour concern: non-export
  in COFF/PE is the documented default, not an incidental behaviour. (Note
  the contrast with ELF, where symbols are public by default - the fragile
  case is the OTHER platform, not ours.)
- Static reference-graph anchoring: an explicit address reference (e.g. a
  guarded dispatch-init assigning &avx2_impl to an internal function pointer)
  places the function in the linker's reachability graph, so /OPT:REF retains
  it, while nothing places it in .edata. Retention and non-export are then
  BOTH explicit/structural.
- /INCLUDE:symbol (COFF) adds a symbol to the linker's retention root set
  WITHOUT adding it to the export table. This is the mechanism Zig's
  forceUndefinedSymbol maps to.
- glibc IFUNC is ELF-only and inapplicable to COFF/PE. Correctly excluded.

TRUST AS ESTABLISHED PRIOR ART:

- The FFmpeg / x264 / x265 / dav1d pattern is the dominant single-binary
  dispatch idiom: feature-specific functions are never in public headers,
  never exported; callers reach them only through function pointers in an
  opaque context struct, populated by an init routine that runs CPUID first.
  This is toolchain-agnostic and COFF/PE-applicable, and it is the shape our
  Stage 1B.3 dispatch should take.
- Google Highway achieves structural unaddressability via anonymous
  namespaces; the idiom differs (C++), but corroborates the principle that
  the strong solutions make gated symbols non-addressable rather than
  guarding addressable ones.

VERIFY BEFORE RELYING (the tool mapping general knowledge onto Zig 0.16;
exactly where it warned it was inferring):

- The exact Zig 0.16 spelling for no-inline on feature entry points (the
  tool suggested @inlineWithCall(.never); the current Zig idiom needs
  checking by W3C/W3X).
- The exact Zig 0.16 route for passing a .def file or /include: arguments to
  lld-link, if we ever need tier 2.
- Whether forceUndefinedSymbol retains a NON-exported symbol on Zig 0.16 +
  lld-link. The research strongly implies yes (INCLUDE operates on the
  retention root set independent of the export table), but this is the one
  empirical crux and W3X's build is the arbiter.

HONEST LIMITATION THE TOOL ADMITTED (and I agree):

- Formal unreachability is not a single compiler primitive anywhere; it is
  composed from modular boundaries, TU flag isolation, and reference-graph
  anchoring. Our bar being higher than a stock primitive is normal, not a
  red flag. The niche-ness that worried W3X is the PROOF discipline, not the
  dispatch technique.

## C.2 What the research changes

1. The export question DISSOLVES rather than needing management. The correct
   arrangement is: gated backend functions are never declared with the export
   keyword at all. Their retention is proven by explicit reference-graph
   anchoring or by an explicit /INCLUDE-class directive; their absence from
   .edata is then structural, because they were never export candidates.
   This is now charter invariant G6 (v1.9), tier 1.

2. The current Stage 1B.1 delivery needs ONE targeted revision, likely small:
   remove the export keyword from deblock4_backend_probe_sse41_marker and
   deblock4_backend_probe_avx2_marker, keeping forceUndefinedSymbol retention.
   The generic and scalar markers legitimately keep export (the smoke test
   calls them from outside the DLL; they are safe baseline code).
   The open empirical question for W3C/W3X: does forceUndefinedSymbol retain
   a non-exported symbol on Zig 0.16? If yes, tier 1 achieved with a
   one-keyword-per-function change. If it does not, the fallback is a minimal
   internal reference anchor (a null-initialised internal function pointer
   assigned under an impossible-at-runtime guard is NOT acceptable - the
   reference must be a real, honest reachability path or an explicit
   retention directive; W3C proposes, W3D reviews).

3. dumpbin /EXPORTS moves from load-bearing proof to corroboration, and
   becomes a STANDING gate in build_1B1.bat (and successors) that FAILS the
   run if any gated marker ever appears in .edata. Under G6 tier 1 it should
   never fire; it exists so that no toolchain change can alter the property
   silently.

4. Four soundness failure modes from the research are adopted as the
   checklist for later SIMD stages (they sharpen G5's existing clauses):
   auto-vectorization leakage (prevented by our per-object target isolation
   and the probes' comptime feature guards, already delivered); cross-TU
   inlining under LTO (prevent with no-inline on feature entry points -
   exact Zig spelling to be verified); static initialisers in feature TUs
   (already banned by G5; the research confirms the .CRT$XCU hazard
   concretely); export/binding leaks (dissolved by G6 tier 1).

## C.3 What the research does NOT change

- The one-DLL internal-dispatch architecture stands; the research confirms it
  as the dominant pattern (FFmpeg family) rather than suggesting the
  multi-binary alternative we already rejected.
- The four-object isolation structure, the baseline-target contract (scope
  v1.2 section 2A), the comptime feature guards, and the .obj installation
  for dumpbin inspection all stand unchanged.
- Stage 1B.3's dispatch design gains a confirmed reference model (opaque
  function-pointer context populated after CPUID) but that remains 1B.3
  work, not 1B.1.

## C.4 Recommended position for W3X to ratify

1. Charter v1.9 with invariant G6 as drafted (explicit/structural over
   implicit; three-tier preference; gated code never uses export).
2. Stage 1B.1 delivery revised per C.2 item 2 before acceptance: no export
   keyword on the two gated markers; forceUndefinedSymbol retained; W3X
   empirically verifies retention-without-export via the build and dumpbin
   /SYMBOLS on the installed objects plus /EXPORTS on the DLL.
3. The dumpbin /EXPORTS absence check becomes a permanent loud-failing gate
   in the stage batch, per G6 tier 3 discipline applied as corroboration.
4. The Zig-specific verification items in C.1 are W3C statements in its
   revised delivery manifest, proven by W3X's build.

W3C is asked to respond with: agreement or disagreement on each of C.2 items
1-3; the Zig 0.16 answer (or experiment plan) for the retention-without-export
crux; and the revised delivery if it agrees.
