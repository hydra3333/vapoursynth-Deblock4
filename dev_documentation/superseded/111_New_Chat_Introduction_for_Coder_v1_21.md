# Deblock4 - New Chat Introduction for Coder

**Version:** 1.21
**Date:** 2026-08-02
**Status:** Informative successor orientation; not controlling; aligned to
ratified charter v1.26 and README v1.9
**Role:** W3C successor coder
**Encoding:** US-ASCII; CRLF

---

# IMMEDIATE NEXT ACTION

Stages 1A through 1C are COMPLETE and committed, and STAGE 2C IS COMPLETE,
ACCEPTED AND COMMITTED (2026-08-12). The deblock4.Classic ReleaseSafe scalar
oracle is built, wired into the Classic integer production path, and proved
byte-exact against the pinned external HolyWu r9 scalar reference (17/17
differential cases, six Addendum A sentinels, 85/85 tests in three build
modes, RS==RF production byte identity). Tree identity: 0.1.0-dev+2C. Per
S4/K19(c) that committed scalar path IS NOW THE CLASSIC ORACLE: every later
Classic pixel/frame/copy/backend scope is accepted only by differential
against it.

THERE IS NO ACTIVE IMPLEMENTATION SCOPE RIGHT NOW. The next stage is STAGE 3C
- the Classic compatibility/quality gate (short; no open algorithm question;
the tabled WP-5 c0-from-aIndex quality question comes due there) - followed by
4C (Classic v2 / SSE4.1 backend + differential) and 5C (Classic v3 / AVX2
backend + differential + performance). DO NOT begin any implementation: wait
for W3X to issue the bounded 3C scope. This intro orients you to the project
and its standing rules; the per-stage authority set arrives with the scope.

STANDING PROCESS RULINGS (binding on every delivery; learned the hard way -
do not rediscover them):
  - NO git staging, EVER, in any delivery or validation machinery (a prior
    staging incident forbids it). Commit is a MANUAL W3X act performed only
    after W3D review and W3X acceptance.
  - THE REFINED GIT RULE (prevailing): FORBIDDEN in machinery - git stash,
    automatic staging/committing, and any proof/audit machinery whose
    CORRECTNESS depends on a particular local git index/staging/HEAD state.
    PERMITTED - non-destructive git reads (git diff --check, git status,
    git ls-files) and W3X-manual git workflows (git apply, the per-file
    backout block). W3X GUARANTEES the local repo IS the supplied base at
    patching time; backout is a MANUAL W3X per-file command block the
    delivery PROVIDES (and/or a restore_to_base/ data folder for manual
    copy-back) - never executed by any delivery script.
  - NO PowerShell machinery authored or shipped by a stage delivery. The one
    permitted script kind is a plain-CMD external-reference build driver
    (e.g. the HolyWu .cmd with certutil hash guards). A batch's pre-existing
    reviewed inline PowerShell and its calls to resident 1C audit scripts are
    retained, not rewritten.
  - HARNESS OWNERSHIP: the .vpy/.bat/.cmd harness is always the DESIGNER's
    (W3D) deliverable; the coder delivers the source patch (complete files,
    NEW/REPLACES against the attached base tree, no per-file base hashes).
  - COMMUNICATION: W3X uses the designer communication convention v1_0 -
    every decision item is self-contained plain English (question, why it
    matters, recommendation, labelled options, IDs only on a trailing refs
    line). Expect and mirror that form.

DELIVERY PACKAGE SHAPE (from the accepted 2C precedent): apply_to_tree/
mirroring the repo layout (W3X applies by one manual copy); restore_to_base/
pre-change copies; a manifest listing every file NEW/REPLACES; the D3-style
obligation tests with a mandatory O/G-to-test crosswalk; the proof runner
re-executing prior-stage gates then the new surface; C-DELIV-07 (no execution
or PASS claims by the coder - W3X runs all validation).
permanent-skeleton *_callback_router modules passing frames through unmodified)
have BOTH been delivered, reviewed, ACCEPTED (green all three modes on the real
toolchain), and COMMITTED. Phase 3 is split 3a/3b.

Phases 1, 2 AND 3a are accepted, green on the real toolchain, COMMITTED and
pushed. Phase 3b (scaffolding sweep, build_1C_v1.bat, the two .vpy harnesses
and the full proof matrix) was RELEASED, delivered, and debugged through
corrections v1_0..v1_12; repository main holds the v1_12-APPLIED state (base
artifact: designer_interaction/deliveries/
Deblock4_Stage_1C_Phase_3b_W3C_delivery_v1_12.zip). The proof matrix passes
EVERYTHING except one final gate: a REAL charter-G6 violation - the three G10
debug markers are PE-exported from the Debug DLL (root cause verified:
pub export fn means dllexport in the DLL compilation). The gate is CORRECT and
must not be relaxed; the fix is at the source layer.
Deblock4_Stage_1C_Phase_3b_Coder_Resume_Brief_v1_0.md carries the full open
finding, directed fix, and paid-for lessons; IT PREVAILS over this file on
current state.

The two load-bearing Phase 3a pins are: (a) the creation callbacks expose the
exact translated VSPublicFunction C-ABI signature, immediately rebind validated
idiomatic locals, preserve the accepted parsing/validation/tier-selection/
allocation/ownership/filter-construction logic, and add only the authorised
debug lifecycle creation-enter/successful-exit trace calls around that logic;
(b) do NOT restructure the permanent activation-reason switch - only its branch
targets/bodies carry the settled C5-order handlers. Read the whole Phase 3a
review set. Your immediate work is the bounded G6 correction directed in the
Resume Brief; make no other production change unless W3X directs it. W3X
releases phases, not W3C.

STARTING POINT (no commit id): the anchor is the PREVAILING branch-main source,
NOT a pinned HEAD SHA. W3X does not track commit ids (main also receives
unrelated document/test commits, so a SHA would drift without any code change).
If you are unsure you hold the current source, ASK W3X to upload it rather than
inferring or transcribing a commit id. Do not gate work on recording a SHA.

SETTLED, DO NOT RE-DERIVE: the detection contract (Set-A/Set-B, whole-level, the
comptime named-model cross-check) is chartered (G1/G2/G3) and proven. A coder
IMPLEMENTS chartered invariants; if you believe one is wrong you STOP and
escalate a specific objection (H1/P-09), you do not quietly build a variant.

DEBUG-ONLY CODE USES THE G10 THREE-LAYER PATTERN (charter G10):
(1) a source-visible C-3 conditional import - `const x = if (opt)
@import("x.zig") else struct {};` - as the primary omission boundary; (2) gated
content (uses wrapped in the same comptime gate; inner gates never license an
unconditional import); (3) three-surface proven absence (strings, PE exports,
disassembly) for release builds. The accepted baseline options
enable_force_down and enable_verbose_detection are hard-rejected outside Debug;
the Phase 3a candidate adds the third option enable_trace_lifecycle under the
same rule. This pattern was empirically ratified (gate_pattern_test_v2). The
force-down seam may only force capability DOWN (effective = actual INTERSECT
ceiling), never up.

TWO FILTERS, CLASSIC FIRST: the plugin will register deblock4.Classic (H.264,
faithful to HolyWu, built first as a known de-risking algorithm) and
deblock4.Deblock4 (the end-goal MPEG-2 algorithm, second). Stage 1B.x is shared
infrastructure and precedes both; per-algorithm stages then run Classic
(2C..5C), then Deblock4 (2D..5D). Backend equivalence is per filter: integer
byte-exact across scalar/v2/v3; float same-algorithm within a measured tolerance
with exact structural results. This is NOT universal float bit-identity.

Do not introduce pixel arithmetic, deblocking, or ALGORITHMIC plane
construction in Stage 1C - that is the per-algorithm 2C/2D+ work. Stage 1C does
permit the standard API4 copyFrame idiom solely to produce the final writable
pass-through frame for audit properties; plane data remains untouched. Do not
turn that narrow metadata-level copy into a custom pixel/plane algorithm.
Stage 1C wires the entry point and per-filter tier switch but executes no gated
algorithm backend arithmetic until the per-filter scalar oracle exists; G5
continues to govern.

What Stage 1B.1 established, and on which 1B.2 built rather than revisited:

```text
- four separately compiled probe objects (generic, scalar, SSE4.1, AVX2) link
  into the one Deblock4.dll;
- generic and scalar modules are in the DLL root graph, so their export fn
  declarations genuinely PE-export (the smoke test links against them);
- SSE4.1 and AVX2 markers are export fn in their OWN single-target objects.
  That gives emission and linker visibility, and object-mode export does NOT
  create a PE export;
- the DLL root references each gated marker by @extern, address-taken and
  NEVER called, stored in internal non-exported pointers;
- neither gated marker appears in the PE export table; a standing dumpbin
  /EXPORTS gate enforces this permanently;
- the baseline target contract is fixed and -Dtarget/-Dcpu are not exposed,
  so native overrides are rejected;
- duplicate-symbol rule: a source is in the DLL root graph OR a linked
  object, never both.
```

CRITICAL and counter-intuitive: the prohibition is on PE-EXPORT, not on the
Zig export keyword. Gated backend code IS declared export fn. The prevailing
charter G6 carries the corrected corollary (introduced in v1.10);
Deblock4_Toolchain_Findings records the three mechanisms that were empirically
falsified before this one worked. Read both before proposing any change to the
backend object structure.

Before changing anything, verify you are on branch main with the prevailing
source (ask W3X to upload it if unsure - no commit id is tracked), the current
document versions, and the formal scope package.


---

# 1. Purpose and authority

You are the successor coder chat and may have no prior memory. This file orients
you; it does not define the algorithm, amend an invariant, authorise changes,
or replace a coding scope.

```text
W3X  human coordinator: decisions, repository, builds, runs, commits, pushes
W3D  continuity-bearing designer/reviewer role: specifications, design review,
     scopes, independent harness design
W3C  memoryless coder - your role: implement one supplied bounded scope
```

All traffic between W3C and W3D passes through W3X; never assume W3D has seen a
delivery or that W3C has seen a design discussion. Only W3X may claim that a
build, test, benchmark, commit, or push occurred. You provide mechanically
applicable code or patches and exact validation commands; W3X runs them and
reports the real results.

Apply charter I7: if you propose a change to criteria that will judge or accept
your own work, identify W3C as proposer and a DIFFERENT independent verifier;
do not silently absorb it. W3X retains normative adoption and release authority.

Where a charter or design ambiguity affects correctness or scope, identify it
and stop. Do not choose the most plausible interpretation.

---

# 2. Required reading order

## Version currency and paired or grouped documents - verify before relying (STOP-class)

Document version numbers are usually part of the filename, and the highest
version number in the filename normally indicates the latest prevailing
version, which should be used - EXCEPT that a document W3X provides directly in
this session may be newer than anything yet committed, and takes precedence.
Verify the actual latest versions with W3X before relying on a number baked
into a file. If W3X indicates a newer ratified package exists, STOP and obtain
it from W3X, since the latest document may not yet have been committed to the
github project repository.

Some documents declare a read-together version SET of two or more members. For
such a set, use the LATEST filename version of EACH member and read the complete
set together. If a member is missing or the set is internally inconsistent,
STOP and report it to W3X; do not rely on a partial set. Read-together status
does NOT equalise authority: each member retains its own declared controlling,
binding, or informative status. Never mix generations against a header that
ties members to specific versions. (Charter section 2.3a; all version numbers
below are current only as of this file's writing and must be re-verified.)

A later controlling-document change does not automatically invalidate an
existing scope. Under charter 2.3b, W3D assesses materiality and recommends;
W3X decides and records compatibility in Project Status. If materiality is
uncertain, disputed, or cannot be established by inspection, STOP and reissue
the scope.

Read in this order. Establish the map first; return to detailed controlling
sections when the active scope quotes or requires them.

## 2.1 `Deblock4_Project_Status_v1_24.md` (or later) - INFORMATIVE

Read first for current state. Its section 0 is the authoritative running
record: Stage 2C accepted and committed, the oracle status, Stage 3C as next,
and the standing task register. Always use the HIGHEST committed version;
verify the exact filename and internal version and stop on any package
mismatch.

## 2.2 `Deblock4_Concise_Project_Summary_v1.2.md` - INFORMATIVE

Read for the compact project shape, vocabulary, public surface, stage sequence,
and the per-filter integer-exact / float-tolerance backend relationship.

## 2.3 `AI_Charter_and_Invariants_Card_v1_26.md` - CONTROLLING

This is the W3X-ratified charter baseline, internal version 1.26. In addition
to the earlier G10/Stage-1B.3/CRLF rules, v1.23 adds I7 independent verification
for self-affecting criteria and continuity-bearing AI roles; v1.24 replaces
C-DELIV-09 with the risk-based, honest-recoverability form; v1.25 introduced
the C-DELIV-09 reminder-block requirement; v1.26 limits it to scopes and
delivery-plan addenda issued henceforth and adds section 2.3b for materiality-
based scope currency. Verify filename and internal version before acting and
STOP on any package-generation mismatch.

Before proposing code, read the bootstrap header, Part 1 in full, W3C role,
coding/interop/numeric/SIMD/delivery rules, and process rules. Pay particular
attention to G5 (no execution before the guard), G6 (safety properties rest on
explicit/structural mechanisms, never implicit toolchain behaviour; the ban is
on PE-EXPORT of gated code, NOT on the Zig export keyword - gated backend code
IS declared export fn in its own object), I7, sections 2.3a and 2.3b, and
C-DELIV-01 through C-DELIV-09.

## 2.4 `README_Deblock4_Design_Spec_v1_10.md` (or later) - FALLBACK GENERAL GUIDANCE

Read its metadata, executive summary, and decision-status table. For the filter-creation
stage, focus first on:

```text
section 11  proposed source/module architecture
section 12  compilation and one-DLL runtime dispatch
section 14  validation specification
section 20  proposed development stages
```

The README is the technical tie-breaker. Later scopes will quote the detailed
algorithmic sections they require.

## 2.4a `Deblock4_Verification_And_Tiering_Decisions_v1_11.md` (or later) - INFORMATIVE DURABLE RECORD

Read the sections governing named tiers, strict float / FMA policy, the Stage
1B.2/1B.3 boundary, backend tokens, and the two-filter sequence. It is the
durable record of the verification/tiering/two-filter decisions and their
reasoning. The charter and README prevail if any conflict is found.

## 2.5 `Scopes/Deblock4_S1B1_Retention_Export_Research_Package_v1_0.md` - INFORMATIVE

Read for the (now-completed) Stage 1B.1 retention/export decision. It records the
research query, the external findings verbatim, and the designer assessment that
led to charter G6. It explains WHY gated backend code is not PE-EXPORTED (though
it IS declared export fn) and how retention without PE-export works in COFF/PE
(reference-graph anchoring; /INCLUDE-class directives; COFF safe-by-default
exports). Stage 1B.1 is COMPLETE; read this as background for any change that
touches the backend object structure, not as an open task.

## 2.6 `Deblock4_Toolchain_Findings_v1_4.md` (or later) - INFORMATIVE

Read for the empirical Zig/linker facts that determine how backend objects are
built and retained (F1-F5): emission is decided per compilation unit; a
cross-compilation reference does NOT force emission; object-mode `export fn`
grants emission and linkage but does NOT create a PE export; and the proven
idiom for multiple CPU-feature levels in one binary (separate single-target
units, self-emitting via export, referenced across the linker seam by @extern,
with dispatch populating function pointers after CPU detection). This explains
why the Stage 1B.1 structure is what it is, and it is the pattern the
filter-creation dispatch wiring follows when consuming the proven EFFECTIVE
record. Later findings extend this record: F6 (earlier addendum), and F9/F10
(v1_4) - F9: Zig 0.16.0 ships with LLVM loop autovectorization DISABLED
(zsmooth #23), which Deblock4 is immune to by design (explicit @Vector, one-DLL
dispatch) and which makes the 2C scalar oracle genuinely scalar; F10: f16
arithmetic is pathological (zig #19550) so f16 is STORAGE-never-COMPUTE at the
future float step. Read v1_4 before any toolchain-bump or float work.

> **HISTORICAL (1C-era) READING ITEMS BELOW.** Items 2.8, 2.8a, 2.8b and 2.8c
> are the STAGE 1C review/delivery set and are NOT part of a 3C (or later)
> handover - they are retained here only as the historical authority record for
> the now-committed 1C work. A 3C coder is handed the 3C scope and its own
> authority set instead (see IMMEDIATE NEXT ACTION). Item 2.7 (MPEG-2 grid/DCT
> knowledge) remains DEFERRED background for the eventual grid/pixel stages.
> Phase 3a/3b references in this and the following sections describe the
> completed 1C delivery phases and are historical.

## 2.7 `Deblock4_MPEG2_Grid_Field_DCT_Knowledge_v1_0.md` - INFORMATIVE, DEFERRED

Do NOT read this for Phase 3a review or correction. Phase 3a performs no grid
algorithm, field-DCT analysis, pixel arithmetic, or deblocking; reading it now
risks scope bleed.

Read it ONLY when an active scope involves grid handling, field separation,
DCT, or pixel processing (Stage 2 entry and later). At that point it is
essential background: it explains why edge_step_y is the hard parameter, the
three DCT regimes, what field separation does to the block grid (pitch-4 vs
pitch-8), why the midpoint machinery exists and why it does not break
vectorisation, and the measured fact that the target LG footage is regime-3
(adaptive per-MB DCT) in every practical mode - so the midpoint machinery is
required, not optional. Until a grid/pixel scope is active, leave it deferred.

## 2.8 `Scopes/Deblock4_Scope_Stage_1C_Filter_Creation_v1_5.md` - CONTROLLING DESIGN AUTHORITY
## 2.8a `Scopes/Deblock4_Stage_1C_Delivery_Plan_Addendum_v1_1.md` - BINDING DELIVERY ORDER
## 2.8b `Deblock4_Stage_1C_Phase_3a_Designer_Briefing_v1_2.md` - INFORMATIVE REVIEW GUIDANCE
## 2.8c `Deblock4_Scope_Header_CDELIV09_Reminder_Block_v1_1.md` - INFORMATIVE STANDING TEMPLATE

Read 2.8, 2.8a and 2.8b last, together. They form the Phase 3a REVIEW SET
(charter 2.3a version group; use the LATEST filename version of EACH), but they
are MIXED AUTHORITY. The scope is the Stage 1C design authority (module map,
dispatch architecture, proof matrix, gap resolutions C1-C9/P1-P5); the
addendum governs phase delivery order and boundaries; the briefing consolidates
informative Phase 3a review clarifications. Read-together status does not turn
the briefing into a scope or equalise their authority.

The briefing's load-bearing checks include: exact translated VSPublicFunction
C-ABI creation signatures; immediate validated rebinding to idiomatic locals;
preservation of the accepted parsing/validation/tier-selection/allocation/
ownership/filter-construction logic while permitting the required lifecycle
trace calls; no restructuring of the permanent activation-reason switch; a
complete one-line lifecycle trace; and the settled C5 order.

Item 2.8c is not a fourth Phase 3a review-set authority. It is the current
standing reminder template required by charter v1.26 in scopes and delivery-
plan addenda issued henceforth. Scope v1_5 and addendum v1_1 are expressly
grandfathered unchanged until their next issuance under section 2.3b; do not
STOP on their historical pins. Verify the latest reminder-block version per
section 2.3a and do not silently rewrite a released scope.

The starting point is the prevailing branch-main source (no commit id;
upload-if-unsure). Do not write production code from this introduction alone.
Phases 1 and 2 are accepted and committed. Phase 3a delivery v1.0 exists and
awaits W3D review, W3X validation and W3X acceptance; Phase 3b is not released.

---

# 3. Where the project is

**Stages 1A through 1C and Stage 2C are COMPLETE, ACCEPTED and COMMITTED.**

The foundation (1A..1B.3) proved: the Zig 0.16.0 scaffold and Windows DLL/
client linkage; VapourSynth API4 core/constants translation; the settled
VSHelper4.h C-ABI bridge; isolated per-level backend objects in one DLL with
assembly-confirmed level containment; and the runtime capability guard
(CPUID/XGETBV over Set-A + the Set-B XCR0 check, whole-level v3->v2->v1
resolution into the immutable ACTUAL/EFFECTIVE record, the shared config/print
skeleton, the selftest executable, the debug-only force-down seam).

Stage 1C (filter creation) is COMPLETE and committed: both filters registered,
each instance's validated parameters and selected tier frozen at creation,
pass-through frames with audit properties, the probe/smoke scaffolding retired
under the C-STY-10 sweep, the using-echo rider (1C.1) accepted.

Stage 2C (Classic scalar oracle) is COMPLETE, ACCEPTED and committed. Now
present in the baseline: a real deblock4.Classic integer deblocking path
(8..16-bit; float and 17..32-bit refused at creation), the canonical scalar
kernel/schedule/thresholds modules, the sanity gate, and the external HolyWu
differential harness. deblock4.Deblock4 remains pass-through (its algorithm is
the later 2D+ work). The committed scalar path is the Classic ORACLE (S4/
K19(c)).

Environmental note: the portable VapourSynth RUNTIME is R79 (advanced from R78
during 2C validation); the in-tree COMPILE headers are unchanged and the API4
contract holds. Documents still citing R78 as the runtime are a known currency
item, not an error in the code.

---

# 4. Tacit knowledge and closed dead ends

Repository-sensitive items below are historical reports. Verify current source.

## 4.1 Last reported environment

```text
repository:
    E:\SOFTWARE-Win11\MULTIMEDIA\vapoursynth-Deblock4\github\vapoursynth-Deblock4
branch:
    main
Zig:
    C:\SOFTWARE\zig\zig.exe
ZLS:
    C:\SOFTWARE\zig\zls.exe
headers:
    third_party\vapoursynth\include\
```

Reported `build.zig.zon` fingerprint:

```text
0x7f9af282a5ce8d76
```

Do not copy a fingerprint from a disposable `zig init` project; it belongs to
that package, not Deblock4.

## 4.2 `VSHelper4.h` bridge decision

The attempted all-header translation gave:

```text
Debug       passed
ReleaseFast passed
ReleaseSafe failed
```

ReleaseSafe failed in generated Zig after Windows CRT declarations were reached
through `VSHelper4.h`, including secure wide-string declarations associated
with `wcscat_s` and `wcscpy_s`. Macro workarounds were not satisfactory.

Settled architecture:

```text
VapourSynth4.h + VSConstants4.h
    translated into Zig

VSHelper4.h
    compiled as C through the Zig build graph
    exposed through narrow project-authored C-ABI wrappers
```

This final arrangement was reported passing ReleaseSafe. Do not casually
reopen all-header translation.

Direct wrappers preserve the external name after `zig_`:

```text
vsh_areValidDimensions -> zig_vsh_areValidDimensions
```

Deblock4 policy/composition/test functions use `deblock4_` instead.

## 4.3 Existing scaffold proof

Reported proof already includes:

```text
Windows x64 DLL built
expected export present
separate smoke-test executable linked or loaded it
C-ABI probe called
expected identity marker returned
```

Stage 1B.1 extended this proof (COMPLETE); Stage 1B.2 inspected those objects'
generated assembly and must not replace the structure with an unrelated
experiment.

Reported historical files included:

```text
build.zig
build.zig.zon
src/build_probe.zig
src/dll_probe.zig
src/dll_smoke_test.zig
src/vapoursynth_api4.h
src/vapoursynth_helper_bridge.c
src/vapoursynth_header_probe.zig
```

Inspect the repository; this is not an authoritative current inventory.

## 4.4 External helper review

`zsmooth` string, copy, math, and vector helpers were reviewed. No reviewed
function is approved merely because it is reusable or already Zig code. Apply
the charter's function-specific safety, codegen, and provenance rules.

Closed shortcuts:

```text
translate VSHelper4.h with the core headers
copy a zig init fingerprint
import an external common module wholesale
treat @Vector or load/store/gather naming as SIMD proof
```

Reopen one only through a bounded scope justified by new evidence or a concrete
need.

---

# 5. What will bite you

```text
If you are about to add pixel arithmetic, algorithmic plane construction, or
real deblocking in Stage 1C, do not - that is per-algorithm 2C/2D work. The
narrow exception already authorised in 1C is the standard API4 copyFrame
writable pass-through used so properties can be attached; its plane data must
remain untouched. Do not replace it with a custom copy/filter algorithm.
(General rule, from Stage 2C/2D onward: pixel/backend code is validated against
the filter's ReleaseSafe scalar oracle once it exists; the FIRST Stage 2C/2D
scope that CONSTRUCTS that oracle is the sole exception - it is accepted
against independent scalar obligations plus a sanity gate. See decisions
section 20.)

If you are about to CALL a real v2 (SSE4.1) or v3 (AVX2) algorithm backend in
Stage 1C, do not: every 1C tier branch still targets the shared inert
pass-through placeholder. In later backend scopes, target-specific calls are
permitted only through dispatch selected from the proven EFFECTIVE record.
G5 permits compile/link/presence proof but forbids execution before a proven
in-process capability guard confirms the complete feature contract. There is
no command-line, environment-variable, build-flag, manual, or 'known capable
machine' bypass. Static initialisers, registration paths, import thunks, and
test calls all count as execution.

If you are about to PE-EXPORT a gated (v2/SSE4.1 or v3/AVX2) function - i.e. make
it appear in the DLL's export table - do not. Charter G6 bans PE-EXPORT of gated
code, NOT the `export` keyword. The proven Stage 1B.1 mechanism is the opposite
of "never use export": gated backend code IS declared `export fn` in its own
single-target object (that is what forces emission and gives it a linker-visible
name), and object-mode `export fn` does NOT by itself create a PE export. The
gated modules stay OUTSIDE the DLL root graph; the root reaches their exact
symbols by `@extern` (address-taken, called only through dispatch selected
from the proven EFFECTIVE capability record);
their absence from the export table is enforced by the standing loud-failing
dumpbin /EXPORTS gate, not inferred from implicit toolchain behaviour or a
one-time look. Do NOT "correct" this back into a
non-export form - that was empirically FALSIFIED (see Deblock4_Toolchain_Findings
F1/F4). A PE-exported gated symbol would be a call path bypassing the dispatch
guard; that is the thing forbidden, not the keyword.

If you are about to compile generic or dispatch code under AVX2, do not.
Dispatch must run on machines lacking the feature it detects.

If you are about to freeze vector widths, lane layouts, load/store forms,
gather strategy, or assumptions about emitted instructions from intuition, do
not. Those require compile-and-assembly evidence (the within-level assembly
confirmation done in Stage 1B.2). The named v1/v2/v3 feature contracts
themselves are already settled.

If you are about to use a VapourSynth stride as a typed-sample offset, stop.
VapourSynth strides are byte counts.

> **NOTE.** The specific Phase 3a/3b framing in this section is 1C-historical
> (that work is committed). The PRINCIPLES below stand for all stages: respect
> output-defining schedule/dependency rules, stay inside the bounded scope, do
> not pull unrelated cleanup into a delivery, and never claim PASS without W3X's
> actual output.

If you are about to batch adjacent luma edges or merge vertical and horizontal
passes, stop. Schedule and dependency rules are output-defining.

If you are about to perform broad cleanup or import utilities OUTSIDE the
bounded scope you were given, do not. Stage 1C's scaffolding SWEEP is an
authorised, scoped cleanup only in Phase 3b (retiring the probe/smoke/dll_probe
files per C-STY-10's sweep test). Phase 3b is not released, so the sweep must not
be pulled into Phase 3a review corrections.

If you are about to claim PASS without W3X's actual output, do not.

If a patch does not match its stated base and anchors, do not hand-edit it into
place. Issue a corrected delivery.
```

---

# 6. What may not be fully written down

Verify rather than assume:

```text
1. That you hold the PREVAILING branch-main source (ask W3X to upload if
   unsure); no commit id is tracked or required. Clean/dirty working-tree state.
2. Whether the attached charter filename and internal version both identify
   ratified v1.25; stop on any mismatch.
3. Whether every declared read-together document set is complete and internally
   consistent, while retaining each member's declared authority.
4. Exact committed scaffold inventory after W3X's adjustments.
5. Exact final build commands and console markers for Debug, ReleaseSafe, and
   ReleaseFast bridge validation.
6. Exact DLL smoke-test and helper-bridge result markers.
7. Whether .vscode/extensions.json and .vscode/tasks.json are committed.
8. Whether temporary placeholder or disposable probe files remain.
9. The coordinator machine's actual CPU features.
10. Confirm Project Status v1.16 is the current package member and recognise
    that it predates the Phase 3a delivery candidate; do not treat its narrow
    Phase 3a wording as the live review state.
11. The formal Stage 1C permitted/forbidden file set and the exact released
    phase boundary; Phase 3b's sweep is not currently released.
12. The tier contracts are the NAMED full v1/v2/v3 psABI levels (settled, not
    open closures); Stage 1B.2 confirmed each object stays within its level.
13. The Stage 1B.1 retention/export mechanism is SETTLED and committed (gated
    code is export fn in its own object, @extern-anchored, not PE-exported;
    Deblock4_Toolchain_Findings F1-F5). Do not reopen it; read it as background
    only if a change touches the backend object structure.
14. Every scope and delivery-plan addendum issued henceforth carries the latest
    Deblock4_Scope_Header_CDELIV09_Reminder_Block verbatim; the charter governs
    on any difference. Scope v1_5 and addendum v1_1 are grandfathered under
    section 2.3b until their next issuance.
```

These are verification items, not invitations to redesign the project.

---

# 7. Working with W3X and delivering code

Use this style:

```text
one bounded objective
exact changed-file set
minimal unrelated change
clear comments at invariant-enforcement points
ASCII-only artifacts
mechanical delivery under C-DELIV
exact commands and expected results
actual W3X outputs before PASS
```

Do not compress safety-critical comments about ownership, lifetime, alignment,
target features, numeric range, or schedule dependencies.

Delivery form is selected per file:

```text
new file
    -> complete whole file
existing file, small localised change
    -> anchor-verifiable unified diff patch
existing file, roughly more than 30 percent changed or several regions
    -> complete replacement file
```

One scope may mix forms. Every delivery identifies its exact base, application
order, validation, expected results, and deliberate SKIPs. W3X applies, runs,
and reports. After W3X reports PASS, provide a commit message unless asked not
to.

The following is the current standing C-DELIV-09 reminder. Every scope and
delivery-plan addendum issued henceforth carries the latest
Deblock4_Scope_Header_CDELIV09_Reminder_Block verbatim; the charter governs on
any difference. Existing scope v1_5 and addendum v1_1 are grandfathered under
section 2.3b until their next issuance.

**Incremental emission (charter C-DELIV-09) - standing reminder:** When this
scope/phase is large enough that withholding all output creates a material
interruption or review-continuity risk - normally multiple modules or more
than a few files - W3C EMITS complete modules or small coherent groups as they
are finished, each marked "increment N of ~M: <what>" (~M is an estimate and
may be revised). Each increment is a complete, self-identifying recovery and
review artifact against the stated base; it need not be independently
applyable. ONLY EMITTED ARTIFACTS SURVIVE an interruption: the recoverable
state is the last complete emitted increment(s); the current incomplete
increment AND any later un-emitted integration, reconciliation, validation, or
revision work may be lost, and earlier increments may be superseded by later
integration. W3C does not claim to preserve or resume un-emitted internal
work. The increments do NOT replace the final deliverable: at scope/phase end
W3C rebuilds and re-packages the complete integrated work against the
authoritative base as one deliverable of record meeting C-DELIV-01..08 in
full, validated as a whole - merely concatenating increments is not proof of
integration. W3X ordinarily applies only the final package, unless W3X
explicitly directs otherwise.

---

# 8. First response expected from the successor

Before proposing implementation, give W3X a compact orientation check:

```text
1. Exact document filenames and internal versions received.
2. Which documents are controlling, binding, or informative; read-together
   status does not equalise authority.
2a. Confirmation with W3X that no newer ratified package supersedes the
    documents received and every declared document set is complete and
    generation-consistent (charter 2.3a).
3. Current milestone: Stages 1A..1C and 2C COMPLETE, ACCEPTED and committed;
   the Classic scalar oracle is live and is the acceptance reference for all
   later Classic work (S4/K19(c)). No implementation scope is active; Stage 3C
   is next but not yet issued.
4. Immediate obligation: do NOT begin any implementation. Wait for W3X to issue
   the bounded 3C scope. Acknowledge the standing process rulings (no git
   staging; the refined git rule; no shipped PowerShell machinery; harness
   ownership; communication convention v1_0).
5. Phase 3a pins: exact VSPublicFunction C-ABI boundary plus validated local
   rebinding and authorised lifecycle trace around preserved accepted logic;
   unrestructured permanent activation-reason switch; complete one-line trace;
   settled C5 order.
6. G5 consequence: generic/scalar may run; v2/v3 backends are called ONLY
   through dispatch selected from the proven EFFECTIVE record - the Stage 1B.3
   guard now exists and is proved. No bypass; unguarded initialisers,
   registration, thunks, and tests still count as execution.
7. G6 consequence: gated code is NOT PE-EXPORTED (it IS declared export fn in
   its own object; object-mode export does not create a PE export); it is
   @extern-anchored from the root and its export-table absence is enforced by
   a standing loud-failing dumpbin /EXPORTS gate, not assumed from implicit
   toolchain behaviour. State that you have read the
   research package and toolchain findings and will preserve that mechanism.
8. That you hold the prevailing branch-main source and the Phase 3a delivery
   artifacts/review inputs supplied by W3X (upload-if-unsure; no commit id).
9. Any mismatch, stale version, missing input, or ambiguity blocking changes.
```

Do not re-summarise every document. Demonstrate that you know where the project
is, what governs it, and what the next proof must do.

---

# 9. Required handover package

Supply this introduction together with:

```text
Deblock4_Project_Status_v1_24.md   (or later)
Deblock4_Concise_Project_Summary_v1.2.md
AI_Charter_and_Invariants_Card_v1_26.md
README_Deblock4_Design_Spec_v1_10.md   (or later)
Deblock4_Verification_And_Tiering_Decisions_v1_11.md   (or later)
Scopes/Deblock4_S1B1_Retention_Export_Research_Package_v1_0.md
Deblock4_Toolchain_Findings_v1_4.md   (or later)
Deblock4_MPEG2_Grid_Field_DCT_Knowledge_v1_0.md   (deferred; grid/pixel stages only)
Deblock4_Toolchain_Findings_v1_4.md   (or later; F9/F10)

NOTE: the STAGE-SPECIFIC authority set (the active scope and its read-together
documents - for a Classic stage: D0/D2/D3/D4, Addenda A/B, the creation-error
table) is supplied WITH the bounded scope when W3X issues it, not from this
list. The 1C review/delivery documents (Stage 1C scope v1_5, delivery addendum,
Phase 3a/3b briefs) are NOT handed to a 3C+ coder; they are the historical
record of the committed 1C work.
Deblock4_Forward_Roadmap_v1_13.md
Scopes/Deblock4_Scope_Stage_1C_Filter_Creation_v1_5.md
Scopes/Deblock4_Stage_1C_Delivery_Plan_Addendum_v1_1.md
    (both grandfathered unchanged under charter 2.3b until next issuance)
Deblock4_Stage_1C_Phase_3a_Designer_Briefing_v1_2.md
Deblock4_Scope_Header_CDELIV09_Reminder_Block_v1_1.md
Deblock4_Stage_1C_Phase_3a_W3C_delivery_v1_0.zip
any W3D review and W3X validation report supplied for that delivery
the prevailing branch-main source if correction or re-integration is required
all source files and test contracts touched by the released correction/phase
```

If only this introduction is present, implementation must not begin.

---

# 10. Revision note

```text
v1.19 Full coder-orientation reconciliation after production of the Phase 3a
      delivery candidate and ratification of charter v1.26. Advanced Project
      Status v1_15 -> v1_16 and charter v1_22 -> v1_26; corrected the Phase 3a
      briefing to root-level v1_2; classified the Phase 3a review set as mixed
      authority; replaced the over-broad "creation body unchanged" shorthand
      with the settled ABI-rebinding/preserved-logic/lifecycle-trace rule.
      Status now says Phase 3a delivery v1_0 awaits W3D review, W3X validation
      and W3X acceptance, with Phase 3b unreleased. Absorbed the valid intent of
      Deblock4_HELD_PROPOSED_Coder_Intro_CDELIV09_Delta_v1_0 using the ratified
      risk-based reminder block: honest loss boundary, possible supersession,
      whole-integration proof, and final-package authority. Adopted charter
      2.3b and the W3X grandfathering decision: scope v1_5 and addendum v1_1
      remain unchanged until their next issuance; the reminder-block requirement
      applies prospectively. Corrected two further stale hazards: Stage 1C
      permits only the standard copyFrame writable pass-through (not a ban on
      all frame construction), and no real v2/v3 algorithm backend executes in
      1C. Updated G10 to include the Phase 3a lifecycle option, removed the old
      claim that PE-export absence is structural, and updated roles/I7, first-
      response and handover sections. No design or invariant change.
v1.18 Added the Phase 3a Designer Briefing (2.8b) to the reading list as
      INFORMATIVE project context, framed for the coder as W3D's review mirror
      (what W3D will check) rather than a separate build requirement; noted
      that 2.8/2.8a/2.8b form the charter-2.3a Phase 3a review set with the
      latest of each prevailing. Bumped the charter pin v1_21 -> v1_22.
v1.17 Added the standalone STOP-class subsection "Version currency and paired
      documents" at the top of section 2, and a first-response gate item 2a
      (confirm with W3X that no newer package supersedes and no paired versions
      mismatch). Bumped the charter pin v1_20 -> v1_21 (governing section
      2.3a). No rule change beyond adopting the charter clause.
v1.16 Status advanced to the frozen handoff point: Phases 1 and 2 accepted and
      committed; Phase 3a (frame path + real plugin registration) is the current
      bounded work, with the 3a/3b split and the two 3a pins (VSPublicFunction
      creation-callback signature; unrestructured permanent switch). Bumped
      reading-list refs to Project Status v1_15, Forward Roadmap v1_13, and
      delivery addendum v1_1. No rule change; status currency.
v1.15 Added the charter C-DELIV-09 incremental-emission rule (emit completed
      modules with an "increment N of ~M" marker for interrupt-safety and
      review continuity; only delivered artifacts survive; the final packaged
      deliverable is unchanged and re-packaged at scope end). Bumped the
      controlling charter pin v1_19 -> v1_20.
v1.14 Stage 1C position advance + prevailing-source correction. Immediate
      action retargeted from "filter-creation stage is next / obtain scope +
      committed base" to "Stage 1C ACTIVE, Phase 1 accepted, deliver Phase 2";
      added the phase-status block and the W3X-releases-phases note. Replaced
      all HEAD-SHA / starting-commit / "verify exact HEAD" language with the
      prevailing-branch-main-source discipline (upload-if-unsure; no commit id
      tracked) per W3X's standing preference, in the immediate-action block,
      the pre-code checklist, section 2.8, the verify-list, and first-response
      item 7. Added the Stage 1C scope v1_5 and delivery addendum v1_0 to the
      reading list (2.8/2.8a, both CONTROLLING) and the handover package.
      Section 3 and first-response milestone advanced to Stage 1C. No rule or
      architecture change.
v1.13 Coder-review corrections: fixed two multi-line stale phrases that
      single-line replacement missed ("For Stage 1B.2, focus first on" ->
      filter-creation stage; the broken "Stage 1B.3 dispatch consumes" splice
      -> "the pattern the filter-creation dispatch wiring follows when
      consuming the proven EFFECTIVE record"); handover-package scope line ->
      the formal filter-creation scope; roadmap pin -> v1_12 and status pin ->
      v1_14 (new-generation cascade); completed-stage tense corrections
      (inspects/confirms -> inspected/confirmed). Version bumped per immutable-
      version discipline (v1.12 was already exchanged).
v1.12 Full reconciliation: the v1.11 pass retargeted the opening and section 3
      but left later sections on the old 1B.2 briefing. This pass fixed the
      package/reading-list pins (status v1_10 -> v1_13, decisions v1_9 -> v1_10,
      summary v1.1 -> v1.2, roadmap v1_8 -> v1_10, charter -> v1_19), rewrote
      the "1B.3 will follow / until the guard exists" phrasings (the guard now
      exists), reconciled the broad-cleanup warning with the authorised
      scaffolding sweep, and updated the verification checklist and the first-
      response block for the filter-creation scope.
v1.11 Refresh after Stage 1B.3 COMPLETE and committed; retargeted from 1B.3 to
      the filter-creation stage. Charter pin v1.17 -> v1.19 (v1.18 recorded the
      1B.3 ratifications; v1.19 the CRLF rule). Added the settled-detection-
      contract do-not-re-derive note. Section 3 and 2.1/2.3 advanced.
v1.10 Refresh after Stage 1B.2 completion; retargeted from 1B.2 to Stage 1B.3.
      Charter v1.16 -> v1.17 (adds G10, the debug-only three-layer inclusion
      pattern; both debug options Debug-only; force-down is force-DOWN-only).
      IMMEDIATE NEXT ACTION rewritten for the 1B.3 capability guard, the shared
      config/print module skeleton, the first-class self-test exe, and the
      note that a first 1B.3 delivery exists and is under review (the prior
      coder chat died after producing it). Section 3 advanced accordingly.
v1.9  Cross-reference sync after the companion-pin cascade: charter v1.15 ->
      v1.16 (exact verification pin and reading-list/handover entries), decisions
      v1.8 -> v1.9, roadmap v1.7 -> v1.8. No body change beyond these pins.
v1.8  Mechanical review corrections: exact-version discipline made consistent
      (M1) - the "prevails over the number"/"or newer"/"or latest" instructions
      replaced by a stop-and-obtain-the-reconciled-package rule; handover list
      uses exact versions (status v1.9, README v1.9). Stage 1B.2 no longer
      described as an isolation/linkage proof (M2; that was 1B.1) - it is a
      within-level code-generation and assembly-inspection proof. Removed the
      duplicated Toolchain Findings entry from the 2.5 heading (P1; it has its
      own 2.6). Corrected this document's own v1.7 revision note to name
      decisions v1.8, not v1.7 (P2).
v1.7  Mechanical review corrections: README reading focus and the cleanup
      warning retargeted from Stage 1B.1 to 1B.2; "final feature closures" ->
      within-level confirmation / recorded whole-level requirements; the
      "freeze feature contracts" warning reworded so the named v1/v2/v3
      contracts read as already settled (1B.2 gathers vector/codegen evidence,
      not the contracts); exact charter pin v1.15 (no "or newer"); handover
      decisions ref v1.5 -> v1.8; added a required-reading entry (2.4a) for the
      decisions record.
v1.6  Regenerated the STALE BODY the coder flagged (both the first re-audit and
      the final package review): the falsified G6 "never use export keyword"
      block replaced with the proven mechanism (gated code IS export fn, not
      PE-exported); handover checks 9/11/12 updated (tiers are named levels, not
      open closures; 1B.1 retention settled); the no-pixel rule notes the Stage
      2C/2D oracle-construction exception; first-response G6 consequence
      corrected; later sections no longer frame Stage 1B.1 as active; later sections no longer
      frame Stage 1B.1 as the active/immediate scope (they name Stage 1B.2 and
      treat 1B.1 as complete); the "first response" milestone reports 1B.2 as
      the immediate scope; the "export fn forbidden" reading removed (gated code
      IS export fn, not PE-exported); retention/closure described as settled, not
      open. Version references advanced to charter v1.15 / README v1.8 /
      decisions v1.7.
v1.5  Aligned to the reconciled package: charter v1.10 -> v1.14, README
      v1.2 -> v1.7, concise summary v1.0 -> v1.1, roadmap -> v1.6, plus the
      decisions record v1.5. Stage 1B.2 reframed from "feature-closure spikes"
      to within-level confirmation that PRODUCES requirements for 1B.3 (which
      implements the guard). Added the two-filter/Classic-first architecture and
      the per-filter integer-exact/float-tolerance backend relationship (not
      universal float bit-identity). G6 phrasing corrected in the reading list
      (ban is on PE-export, not the export keyword). Named psABI tiers; FMA part
      of v3, not excluded.
v1.4  Stage 1B.1 complete; retargeted to Stage 1B.2. Charter v1.9 -> v1.10
      (G6 corollary corrected: the ban is on PE-EXPORT, not the export
      keyword; gated backend code IS export fn). README v1.1 -> v1.2. Added
      Deblock4_Toolchain_Findings to the reading order and handover package,
      and recorded what 1B.1 established.
v1.3  added the MPEG-2 grid / field-DCT knowledge document to the reading order
      as INFORMATIVE but DEFERRED - not for Stage 1B.1 (pure isolation), only
      for grid/pixel stages (Stage 2 entry and later), to avoid scope bleed.
      Renumbered the formal-scope reading entry to 2.7.
v1.2  re-aligned to ratified charter v1.10 (adds G6: explicit/structural
      mechanisms over implicit toolchain behaviour; gated code never exported).
      Updated milestone to 1A.1-complete, added the retention/export research
      package to the reading order, flagged the superseded export-based 1B.1
      delivery, and added the retention-without-export empirical crux. The
      active 1B.1 scope now requires research-package assessment before coding.
v1.1  aligned the handover to W3X-ratified charter v1.8 and carried the
      complete G5 no-bypass, unguarded-execution, and SKIP consequences.
```

---

*This file preserves coder-session orientation and tacit history. It is not an
algorithm specification, invariant source, coding scope, or proof that the
current repository still matches the last reported scaffold.*

# Revision history

v1.21 (2026-08-12) End-of-phase refresh after Stage 2C acceptance (see body).
