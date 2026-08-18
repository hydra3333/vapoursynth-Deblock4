# Deblock4 - New Chat Introduction for Coder (v1.31)

```text
CURRENT SUCCESSOR BOOTSTRAP - 2026-08-18 - READ THIS FIRST

IF YOU ARE REPLACING A CODER CHAT THAT DIED DURING T1, START HERE:
    Deblock4_T1_Resume_Brief (latest version) tells you where the sweep
    stopped and what the previous coder had just found. The coder chat of
    2026-08-18 reached its length limit immediately after posting verdicts on
    T1's first ledger; those verdicts are preserved in the brief and in the
    task register.

READ IN THIS ORDER FOR CURRENT STATE:

    1. Deblock4_Project_Status_v1_29.md section 0
    2. Deblock4_MPEG2_Deblocking_Investigation_and_Decided_Architecture_v1_05.md
       section 0 CURRENT ARCHITECTURE POSITION
    3. Deblock4_Standing_Task_Register_T_Series_v1_7.md - the live work queue
       and its DECISION LOG
    4. the current charter / active bounded scope when W3X issues one

YOUR CURRENT WORK IS DOCUMENT REVIEW, NOT CODE. T1 is a documentation
consolidation sweep and W3C's role in it is independent review of the
designer's adjudications, under Deblock4_T1_W3C_Review_Scope (latest). It
authorises NO source change of any kind. Read-only source inspection IS
permitted and, for classifying whether a statement is a specification the code
implements, expected.

For ALL MPEG-2 deblocking matters - block geometry, field/frame coding,
grid/source modes, chroma organisation, prior art, Deblock4 architecture,
architecture-discriminator mathematics and the D4 issue/decision registers -
the PREVAILING AUTHORITY is the W3X-ratified:

    Deblock4_MPEG2_Deblocking_Investigation_and_Decided_Architecture_v1_05.md

It SUPERSEDES Deblock4_MPEG2_Grid_Field_DCT_Knowledge and PREVAILS over every
raw GAIS response and over any MPEG-2 statement elsewhere in this documentation
set INCLUDING THIS INTRODUCTION. Where this introduction and v1.05 disagree,
v1.05 WINS.

CURRENT STATE:
 - Classic is FINISHED for the ratified integer tier set: 2C scalar oracle,
   4C SSE4.1 backend, 5C AVX2 backend, all accepted. Post-5C maintenance M1
   and M2 are complete and committed. Identity remains 0.1.0-dev+5C.
 - deblock4.Deblock4 is now the active work and STILL HAS NO FILTERING KERNEL.
   Its live dispatch arms are validated writable-copy/pass-through paths.
 - The NEXT SUBSTANTIVE ARTIFACT is the D4-Q14 architecture-discriminator
   EXPERIMENT / experiment plan, NOT filtering code. NO D4 KERNEL SCOPE MAY BE
   DRAFTED OR IMPLEMENTED BEFORE Q14 reports and W3X ratifies the architecture
   that may enter kernel/oracle development.
 - Primary candidate: Architecture B2, macroblock-anchored FRAME/FIELD/UNKNOWN
   classification followed by explicit edge topology and geometry-homogeneous
   spans. Mandatory detector-free comparator/fallback: Architecture D.
   Architecture A (old separated-field union/midpoint design) and motion-based
   Architecture C are REJECTED.
 - Q14 is not a forced binary. Ratified rule: if B2 is viable, B2 may enter
   kernel development; otherwise D may enter only if D is itself viable; if
   neither is acceptable, REOPEN THE ARCHITECTURE. Q14 never means anything
   "ships" - oracle, kernel, chroma, quality and SIMD gates still follow.

TARGET-MATERIAL FACT THAT MUST NOT BE LOST:
 - The LG VHS-to-DVD target recorder was measured with frame_pred_frame_dct=0
   in XP/SP/LP/EP, i.e. the ADAPTIVE-CAPABLE per-macroblock DCT regime is the
   normal practical target-device regime. MLS was the frame-DCT control.
 - This makes B2 a response to normal target-device operation, not a theoretical
   corner case. It does NOT by itself prove that every picture contains both
   FRAME and FIELD dct_type values; Q14 must extract per-macroblock truth.
 - `mediainfo --Details=1` is useful CHEAP PICTURE-LEVEL REGIME TRIAGE through
   picture_structure/frame_pred_frame_dct; it is NOT the per-macroblock dct_type
   truth extractor required by Q14.

CODER-SPECIFIC CONSEQUENCES:
 - Do NOT implement Deblock4 filtering mathematics under an older README/grid
   description. No kernel scope exists.
 - Treat `mpeg2_field_separated`, the old primary/midpoint union grid, and old
   midpoint-required conclusions as SUPERSEDED architecture. Current Stage-1C
   parameter/property plumbing is legacy scaffolding, not algorithm authority.
 - The current scalar Deblock4LumaStepY/midpoint property model cannot express
   mixed B2 geometry as one truthful per-frame step and is expected to change
   under a later bounded parameter/diagnostic scope.
 - Nothing is inherited from Classic: no code, thresholds, oracle or proof.
   Engineering disciplines/patterns may be re-derived, but Deblock4 gets its
   own mathematics, fixtures, oracle and differential proof chain.
 - Verify every external factual claim before it enters project knowledge.
   GAIS remains a reasoning aid only.
```

**Version:** 1.30
**Date:** 2026-08-16
**Status:** Informative successor orientation; not controlling. Current-state
orientation aligned to Project Status v1.28, W3X-ratified MPEG-2 authority
v1.05, ratified charter v1.29 and README v1.12. The charter and the MPEG-2
authority prevail in their respective domains.
**Role:** W3C successor coder
**Encoding:** US-ASCII; CRLF

---

# IMMEDIATE NEXT ACTION

There is **NO ACTIVE IMPLEMENTATION SCOPE**.

Classic is complete for the ratified integer tier set. Stage 2C established the
ReleaseSafe scalar oracle, Stage 4C added the SSE4.1 backend, and Stage 5C added
the AVX2 backend; the vector paths are accepted against the scalar oracle.
Post-5C maintenance M1 and M2 are complete and committed. The retained identity
is `0.1.0-dev+5C`.

deblock4.Deblock4 remains a pass-through shell. The active design line is the
W3X-ratified MPEG-2 authority v1.05.

**THE ACTIVE WORK IS T1, A DOCUMENTATION SWEEP - NOT T5, AND NOT CODE.** W3X
reversed the sequence on 2026-08-17: T1 runs BEFORE T5, because T5 derives
detector mathematics and the README has already proved it can hide a
fully-worked ratified apparatus that nobody swept. T5 and T6 follow T1, as
separate ratifications. Do not write a Deblock4 filtering kernel and do not
infer a kernel scope from this handover.

Resume sequence after any interruption:

```text
Deblock4_T1_Resume_Brief (latest) - if T1 is still running
    -> Project Status v1.29 section 0
    -> MPEG-2 authority v1.05 section 0
    -> Standing Task Register v1.7 and its DECISION LOG
    -> Deblock4_T1_W3C_Review_Scope (latest) - what binds you during T1
    -> the current T1 ledger tranche, or the active scope supplied by W3X
```

WHAT W3C IS DOING IN T1, in one paragraph: the designer reads every
MPEG-2-bearing statement in 47 live documents and records a decision about
each one in a LEDGER. You review those decisions. You are supplied the
complete documentation corpus and the source tree so you can read the swept
sections YOURSELF rather than relying on the designer's quotations - because
a quotation chosen by the designer cannot show you what the designer walked
past, and finding omissions is one of the five questions you are asked.

THE FIRST LEDGER'S OUTCOME, so you know the standard expected: W3C rejected
BOTH entries and found a method defect in the template. All three findings
were accepted. Disagreement is the product here; bare agreement on a
high-tier entry tells nobody whether you checked.

STANDING PROCESS RULINGS (binding on every delivery; do not rediscover them):
- NO git staging, EVER, in delivery or validation machinery. Commit/push are
  manual W3X acts after review and acceptance.
- No correctness-critical machinery may depend on a particular local git
  index/staging/HEAD state. Non-destructive git reads and W3X-manual workflows
  remain permitted under the prevailing charter.
- Do not author or ship PowerShell delivery machinery. Retained previously
  reviewed proof machinery is not an invitation to add new machinery.
- Harness ownership remains W3D's where the active scope assigns it; W3C
  delivers source under the bounded scope and never silently expands it.
- C-DELIV-07: W3C does not claim local project build/test PASS; W3X runs and
  reports authoritative execution.
- Communication to W3X follows the coder convention: plain English; expand
  abbreviations on first use; put all decisions/questions in one clearly headed
  section near the top; make each decision self-contained.
- G5/G6 continue to govern target-specific execution and PE-export containment.
  Do not weaken the proven one-DLL guarded-dispatch architecture while working
  on the novel Deblock4 algorithm.

Historical Stage-1C/2C/4C/5C scopes and their proof documents remain evidence
for the work they accepted; they are not live authority for the next Deblock4
algorithm design. The active D4 scope, when one exists, arrives from W3X.

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

## 2.1 `Deblock4_Project_Status_v1_29.md` (or later) - INFORMATIVE

Read FIRST for live state. Its newest section 0 is the running handoff record:
Classic 5C + M1/M2 are complete, Deblock4 has no kernel, and D4-Q14 is next.
Always use the highest current version supplied/confirmed by W3X.

## 2.2 `Deblock4_Concise_Project_Summary_v1.3.md` (or later) - INFORMATIVE

Read for the compact project shape, vocabulary, public surface, stage sequence,
and the per-filter integer-exact / float-tolerance backend relationship.

## 2.3 `AI_Charter_and_Invariants_Card_v1_29.md` (or later) - CONTROLLING

This is the W3X-ratified RULEBOOK. It prevails over this introduction on roles,
invariants, coding/interop/numeric/SIMD rules, version-set discipline, scope
currency and delivery mechanics. Verify filename/internal version before acting
and stop on a generation mismatch. In particular retain G5 guarded execution,
G6 explicit emission/linkage/PE-export control, I7 independent verification of
self-affecting criteria, and the prevailing C-DELIV rules.

## 2.4 `README_Deblock4_Design_Spec_v1_12.md` (or later) - GENERAL DESIGN RECORD

Read for project-wide design history, module architecture, validation and
non-MPEG-2 general technical guidance. **Do not use its older MPEG-2 field-
separated/union-grid passages as current authority.** For every MPEG-2-specific
question, v1.05 of the MPEG-2 authority below prevails.

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

## 2.6a `333_W3X_Coder_Communication_Convention_v1_0.md` (or later) - STANDING PROCESS INSTRUCTION

How you communicate with W3X, in W3X's own words: plain English, every
abbreviation expanded on first use, decision items self-contained with your
recommendation, all questions in one DECISIONS/QUESTIONS FOR W3X section near
the top, IDs only on trailing refs lines. Binding on every message and
document you produce. Its companion (v1_1) binds the designer identically.

> **HISTORICAL 1C ITEMS FOLLOW AFTER 2.7.** The Stage-1C scope/addendum/
> briefing set is retained only as the record of accepted creation work. It is
> not the active Deblock4 algorithm authority. Item 2.7, by contrast, is NOW
> REQUIRED because Deblock4 MPEG-2 work is active.

## 2.7 `Deblock4_MPEG2_Deblocking_Investigation_and_Decided_Architecture_v1_05.md` (or later version) - PREVAILING MPEG-2 AUTHORITY

Read section 0 first, then the sections named by the active Q14/design scope.
This W3X-ratified document is the single source of truth for MPEG-2 block
geometry, target measurements, B2/D architecture, rejected A/C designs,
whole-frame mathematics, analyser discipline, Q14, proper-chroma status, SIMD
consequences and the current D4 issue/decision registers. It supersedes
`Deblock4_MPEG2_Grid_Field_DCT_Knowledge_v1_2.md`; do not use that older file to
restore field-separated or midpoint machinery.

## 2.7a `Deblock4_Standing_Task_Register_T_Series_v1_7.md` (or later) - LIVE WORK QUEUE

Read after the MPEG-2 authority. The authority says WHAT is true and decided;
the T-series register says WHAT WORK remains and in what dependency order. The
current queue keeps T1 paused by W3X, makes T5 detector mathematics the first
design subtask, and then T6 the Q14 plan. If Project Status carries an older
condensed T-series summary, the latest ratified task register is the work-queue
record; neither can override the MPEG-2 authority on architecture.

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
standing reminder template required by the charter (C-DELIV-09/25/26) in scopes and delivery-
plan addenda issued henceforth. Scope v1_5 and addendum v1_1 are expressly
grandfathered unchanged until their next issuance under section 2.3b; do not
STOP on their historical pins. Verify the latest reminder-block version per
section 2.3a and do not silently rewrite a released scope.

The starting point is the prevailing branch-main source (no commit id;
upload-if-unsure). Do not write production code from this introduction alone.
Stage 1C is historical and COMPLETE; its Phase 3a/3b review-set documents remain
useful only when a bounded task touches that accepted creation infrastructure.
They are not current implementation state and they do not authorise D4 work.

---

# 3. Where the project is

**Classic is complete for the ratified integer tier set; Deblock4 is now active.**

Accepted shared/Classic baseline:

```text
Stage 1 / 1C      shared foundation, API4 creation/frame plumbing, guarded tier
                  selection and diagnostics: COMPLETE
Stage 2C          Classic ReleaseSafe scalar oracle: COMPLETE
Stage 3C          collapsed; deferred Classic quality question only
Stage 4C          Classic x86-64-v2/SSE4.1 vector backend: COMPLETE
Stage 5C          Classic x86-64-v3/AVX2 vector backend: COMPLETE
Post-5C M1        v2/v3 maintainer-commentary reconciliation: COMPLETE
Post-5C M2        identifier + historical-batch retirement hygiene: COMPLETE
Identity          0.1.0-dev+5C
```

The Classic scalar/v2/v3 integer paths are accepted byte-identical under their
proof chain. The old 4C/5C vector source may provide engineering experience,
but by ratified D4-D08 **nothing in Classic is a design or acceptance basis for
deblock4.Deblock4**.

deblock4.Deblock4 currently validates/records creation state and returns
writable-copy/pass-through frames; no D4 filtering mathematics exists. The
current algorithm candidate is B2, with D as mandatory detector-free comparator,
gated by the D4-Q14 ground-truth experiment in MPEG-2 authority v1.05.

Environmental note: the portable VapourSynth runtime is R79; the in-tree API4
compile-header contract remains the accepted one unless a later status/source
package says otherwise.

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
T1-SPECIFIC, WHILE THE SWEEP IS RUNNING:

IF THE DOCUMENTATION CORPUS OR THE SOURCE TREE IS NOT IN FRONT OF YOU, STOP
AND ASK. Do not review a ledger from the ledger alone. A ledger shows what the
designer DID log; it cannot show what the designer did NOT log, and omission
is one of the five things you are asked to find. W3C itself identified this as
a blocking defect in an earlier version of the review scope - do not let it
quietly return.

THERE ARE FIVE DISPOSITION VALUES AND ONLY FIVE. If a ledger entry uses a
sixth, that is a method finding, not a wording quibble - it lets an entry
assume its own conclusion. This has already happened once.

SILENCE BETWEEN TRANCHES IS NOT AGREEMENT. W3X collects responses and
adjudicates them together at closure. If you raised something and it recurs,
RAISE IT AGAIN.

IF THE PROBLEM IS THE METHOD RATHER THAN AN ENTRY, put it at the TOP of your
response, stated as a method problem. A wrong entry costs one entry; a wrong
method is repeated across every remaining tranche before anyone notices.
```

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
bounded scope you were given, do not. The Stage-1C scaffolding sweep is
historical evidence of why cleanup must be explicitly scoped; it is COMPLETE,
not pending work. Current MPEG-2 documentation consolidation is governed by the
T-series register and W3X sequencing, not by old Phase-3a/3b boundaries.

If you are about to claim PASS without W3X's actual output, do not.

If a patch does not match its stated base and anchors, do not hand-edit it into
place. Issue a corrected delivery.
```

---

# 6. What may not be fully written down

Verify rather than assume:

```text
1. That you hold the PREVAILING branch-main source; ask W3X to upload it if
   unsure. Do not invent or require a commit SHA.
2. That the current charter is the W3X-ratified v1.29 or later and that any
   supplied read-together set is generation-consistent.
3. That Project Status v1.28 or later is the current live-state record.
4. That MPEG-2 authority v1.05 is W3X-ratified. Its historical draft header may
   still describe the pre-ratification state; W3X's ratification decision is the
   status fact until the document next naturally reissues.
5. That NO D4 kernel scope exists unless W3X explicitly supplies one after Q14.
6. T5 detector/feature mathematics and the exact D4-Q14 experiment-plan
   generation/ground-truth extraction method. `mediainfo --Details=1` is
   picture-level regime triage, not per-MB dct_type truth. Do not let the
   experiment define the detector after seeing held-out results.
7. The target LG measurement means adaptive-capable operation is normal in
   XP/SP/LP/EP; do not upgrade that measurement into proof that every picture
   actually mixes FRAME and FIELD macroblocks.
8. B2/D viability criteria must be predeclared and evaluated on held-out data;
   if both are inadequate the architecture reopens.
9. Existing `mpeg2_field_separated`, midpoint, scalar-step and related audit
   properties are legacy Stage-1C plumbing awaiting later bounded reconciliation.
10. The named v1/v2/v3 psABI tier contracts, G5 guard and G6 object/export
    mechanism remain settled infrastructure and are not reopened by D4 work.
11. VapourSynth strides are bytes; footprint, row-pitch and bounds semantics are
    explicit in the MPEG-2 authority and future D4 scope.
12. Any fact not supported by the current authority/source is a question, not a
    gap to fill from memory or GAIS.
```

These are verification items, not invitations to redesign settled material.

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
1. Exact current filenames/internal versions received and their authority.
2. Confirmation that Project Status v1.28 (or later) is the live state and
   MPEG-2 authority v1.05 (or later) is the W3X-ratified MPEG-2 source of truth.
3. Current milestone: Classic 2C/4C/5C + M1/M2 COMPLETE; identity +5C;
   deblock4.Deblock4 has NO kernel and is the active workstream.
4. Immediate action: Q14 experiment plan/experiment, NOT kernel implementation.
   State that no D4 kernel scope may be inferred from this introduction.
5. Architecture: B2 primary candidate, D mandatory comparator/fallback, A/C
   rejected; no-forced-fallback rule if both B2 and D are inadequate.
6. Target-material significance: LG XP/SP/LP/EP are measured adaptive-capable
   (`frame_pred_frame_dct=0`); actual per-MB mixture remains Q14 ground truth.
7. Confirm the standing G5/G6 guarded-dispatch/export discipline, no git staging,
   W3X execution ownership, and bounded-scope/no-scope-bleed rules.
8. Confirm prevailing branch-main source or ask W3X to supply it.
9. Report any mismatch, stale pointer, missing input or ambiguity before change.
```

Do not re-summarise every historical document. Demonstrate that you know where
the project is, what governs MPEG-2 work, and what the next evidence must decide.

# 9. Required handover package

Supply this introduction together with the highest current versions of:

```text
Deblock4_Project_Status_v1_28.md   (or later)
Deblock4_MPEG2_Deblocking_Investigation_and_Decided_Architecture_v1_05.md
    (or later; PREVAILING MPEG-2 authority)
AI_Charter_and_Invariants_Card_v1_29.md   (or later)
README_Deblock4_Design_Spec_v1_12.md   (or later; general design/history)
Deblock4_Verification_And_Tiering_Decisions_v1_11.md   (or later)
Deblock4_Toolchain_Findings_v1_4.md   (or later)
Deblock4_Concise_Project_Summary_v1.3.md   (or later)
Deblock4_Forward_Roadmap_v1_19.md   (or later, if still current)
333_W3X_Coder_Communication_Convention_v1_0.md   (or later)
Deblock4_Session_Bootstrap_Header   (latest, when W3X supplies an active scope)
```

Do **not** include `Deblock4_MPEG2_Grid_Field_DCT_Knowledge` as a current
algorithm authority; v1.05 supersedes it. Historical Classic/Stage-1C proof
packages are supplied only when a bounded task genuinely needs their evidence.
The active stage-specific authority set and scope arrive from W3X.

If only this introduction is present, implementation must not begin.

# 10. Revision note

```text
v1.31 (2026-08-18) Reoriented for T1, the documentation consolidation sweep,
which is the ACTIVE work and comes BEFORE T5 - v1.30 told a successor the
opposite. Added a recovery entry point for a coder chat replaced mid-sweep,
since the 2026-08-18 coder chat hit its length limit immediately after posting
verdicts on the first ledger. Stated plainly that W3C's T1 role is document
review authorising no source change, while read-only source inspection is
permitted and expected for specification classification. Added four
T1-specific hazards: stop if the corpus or source is missing, five disposition
values only, silence between tranches is not agreement, and method problems go
at the TOP of a response. Advanced the Project Status and task register
pointers. No technical or ratified content is changed here.

v1.30 (2026-08-16) Loss/currency audit after v1.29. Removed the two surviving
      stale Stage-1C Phase-3a/3b "awaiting/not released" statements; added the
      live T-series register to the reading order; reconciled immediate work to
      T5 detector mathematics -> T6 Q14 plan (or one coordinated package with
      T5 frozen first); and advanced the MPEG-2 pointer to ratification-recording
      v1.05. No project design change.
v1.29 (2026-08-16) Current-state/MPEG-2 authority reconciliation after W3X
      ratified MPEG-2 architecture authority v1.05 and Project Status v1.28.
      Fixed the filename/internal-version mismatch; replaced stale Stage-5C-next
      and field-separated/midpoint-required guidance; made the resume path
      Status v1.28 section 0 -> MPEG-2 v1.05 section 0 -> Q14/active scope;
      updated reading order, current project state, verification list, first
      response and handover package. Records LG adaptive-capable target-device
      significance without overstating it as observed per-MB mixture. No
      algorithm/invariant change; this intro follows the ratified authorities.
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

v1.29 (2026-08-16) Reconciled successor orientation to Project Status v1.28
and W3X-ratified MPEG-2 authority v1.05; see section 10 for the detailed note.

v1.27 (2026-08-14) Second currency pass (W3C second orientation review Q2 +
W3D review): header alignment line advanced to charter v1.29 / README
v1.12; section 9 handover pins advanced (charter v1_29, README v1_12,
MPEG-2 knowledge v1_2, bootstrap v1_1), the missing roadmap added (v1_19)
and the duplicate Toolchain Findings line removed; the orphaned Stage
1C-era handover tail (roadmap v1_13, 1C scope/addendum/briefs, Phase 3a
delivery zip) excised - it contradicted the note directly above it; the
incidental "required by charter v1.26" attribution de-versioned. No
current-state content changed.
v1.26 (2026-08-14) Residual-staleness pass (W3C orientation Q3 + W3D
review): the leftover Stage 1C Phase 3a/3b narrative (including an orphaned
sentence fragment and the "immediate work is the G6 correction" instruction)
replaced with a clearly-marked historical note; the Phase 3a pins paragraph
retitled historical; first-response item 8 no longer asks for Phase 3a
delivery artifacts. No current-state content changed.
v1.25 (2026-08-13) Currency + communication update after Stage 4C
acceptance, BASED ON v1.21 IN FULL (the v1.22-v1.24 plain-English rewrite
line is WITHDRAWN: it lost the tacit-knowledge, what-will-bite-you, and
critical counter-intuitive content that a memoryless coder cannot
rediscover - W3X catch). Changes over v1.21: IMMEDIATE NEXT ACTION and
section 3 advanced to the post-4C state (2C oracle + 4C vector backend
accepted; 3C collapsed; 5C next with the AVX2 hazard flagged); the
communication ruling now binds via the new coder communication convention
(new reading item 2.6a); reading-list and handover pointers advanced
(Status v1_26, charter v1_27 with the rulebook framing, README v1_11,
Concise Summary v1.3, MPEG-2 knowledge v1_1, plus the coder convention and
the stage-agnostic Session Bootstrap Header v1_0); section 8
first-response items updated. ALL v1.21 content retained.
v1.21 (2026-08-12) End-of-phase refresh after Stage 2C acceptance (see body).
