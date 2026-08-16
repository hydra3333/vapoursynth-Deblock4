# Deblock4 - Scope: Stage 1C - Filter Creation (RATIFIED decisions incorporated)

**Version:** 1.1
**Date:** 2026-07-31
**Author:** W3D
**Against:** charter v1.19; README design spec v1.9; Project Status v1_14;
Forward Roadmap v1_12.
**Starting point:** the accepted Stage 1B.3 commit on branch main. W3X verifies
and records the exact HEAD SHA in the session bootstrap header before coding
begins.
**Encoding/EOL:** US-ASCII; CRLF for all repository files (charter v1.19
C-DELIV-06). This stage also RETIRES the remaining LF scaffolding holdouts.

---

# 1. Objective

Turn the proven Stage 1B.3 infrastructure into a loadable VapourSynth plugin:
register the plugin and its filters, create filter instances that resolve and
STORE the capability selection exactly once from the EFFECTIVE record, return
frames (pass-through placeholder), write the settled frame properties, and
retire the scaffolding under C-STY-10's sweep test.

NO pixel arithmetic, NO deblocking, NO plane writes, NO new-frame construction.
G5 continues to govern: gated (v2/v3) code is not executed; each filter's real
processing arrives only with its 2C/2D scalar oracle.

This stage makes the project a real (if inert) plugin for the first time: it
loads in vspipe, instantiates, and provably consumes the EFFECTIVE record
end-to-end.

# 2. Stage designation (D-1, for ratification)

Proposed designation: **Stage 1C**. The 1B.x arc (backend objects, within-level
confirmation, capability guard) is complete; filter creation is a sibling
infrastructure stage, not a 1B item. All artifacts use `1C` on ratification;
if W3X prefers a different label, only this token changes.

# 3. In scope

```text
3.1  VapourSynth entry point: VapourSynthPluginInit2 (API4), configPlugin,
     and registration of the filter(s) per D-2.
3.2  Filter creation function(s): argument parsing, backend-request
     resolution against the EFFECTIVE record (once, at creation), immutable
     instance data, error paths with settled messages.
3.3  getFrame/free: pass-through frame return per D-3; frame-property writes
     per D-4.
3.4  Dispatch consumption per D-5: resolve-once-and-store plus the structural
     no-per-frame-branch proof.
3.5  Scaffolding sweep per D-6: retire the probe/smoke scaffolding and the
     remaining LF holdouts; relocate any @extern anchor sites so the C-STY-10
     sweep test holds permanently.
3.6  Standing batch successor (build_1C) with the proof matrix of section 8.
3.7  Unit tests for the pure resolution logic (no VS core required).
```

# 4. Out of scope (hard exclusions)

```text
4.1  Any pixel-producing, plane-copy, new-frame-construction, or deblocking
     code (2C/2D+).
4.2  Execution of gated v2/v3 code (G5). Address-taking remains permitted.
4.3  Algorithm parameters (quant, offsets, planes, ...) - registered and
     validated at 2C/2D with their oracles (D-7).
4.4  Any change to the detection contract, the Set-A/Set-B tables, the
     comptime cross-check, or the G10 seams (all settled and chartered).
4.5  Frame-state or per-frame mutable instance state; the instance is
     immutable after creation (fmParallel).
```

# 5. Decisions (RATIFIED by W3X, 2026-07-31; D-7 as amended)

**D-1 - Stage designation `1C`.** (Section 2.) RATIFIED.

**D-2 - Register BOTH filters now, minimal signature.** Register
`deblock4.Classic` and `deblock4.Deblock4` in this stage, each with the
minimal creation signature `(clip, backend="auto")`. Rationale: the two-filter
namespace is settled design (README section 1.0); the second registration
costs one function and proves the namespace early; algorithm parameters join
per-filter at 2C/2D (D-7). Alternative (register Classic only, add Deblock4 at
2D) is workable but creates a later mini-scope for one line of registration.
RATIFIED: register BOTH. See also convention C-1C-2: the selftest
never links VapourSynth, which constrains the module graph.

**D-3 - Pass-through placeholder semantics.** getFrame requests the source
frame and returns it BY REFERENCE (addFrameRef-equivalent; zero new frames,
zero plane writes, zero pixel reads). This is deliberately not "copy the
frame": a copy would be plane-construction work that belongs to 2C/2D and is
excluded by 4.1. Consequence: output is bit-identical to input by
construction, giving the checksum-equality end-to-end gate in section 8.
The placeholder is replaced per-filter at 2C/2D; its removal must not require
edits outside the filter's own processing seam.
Note (frame properties): under D-4 the returned frame must carry the
Deblock4* properties. Writing properties requires making the frame writable
(VS copy-on-write via the API's frame-copy-for-props idiom); that
metadata-level operation is permitted and is NOT the plane-construction
excluded by 4.1. The coder uses the standard API4 idiom; plane data remains
untouched. RATIFIED.

**D-4 - Frame-property writes included now.** Each returned frame carries the
README 13.5 settled properties, at minimum:
```text
Deblock4Filter  = "Classic" | "Deblock4"
Deblock4Tier    = "x86_64_v3_with_avx2" | "x86_64_v2_with_sse41"
                | "x86_64_v1_baseline"   (the EFFECTIVE-resolved selection)
```
plus any further names README 13.5 settles (coder enumerates from the README;
no invented names). Rationale: the properties are metadata, not pixels, and
they make the EFFECTIVE consumption OBSERVABLE end-to-end - the core of this
stage's proof value (section 8 gates E2, E3). RATIFIED. The property set
gains Deblock4Version (section 5A).

**D-5 - Dispatch consumption in this stage = resolve-once-and-store.** At
creation, the filter:
```text
1. reads the requested backend argument ("auto" default);
2. resolves it against the EFFECTIVE record: auto -> highest effective tier;
   explicit tier <= effective -> honoured; explicit tier > effective ->
   creation REFUSED with a settled error message (mirroring the selftest's
   behaviour and the 1B.3 option-resolution semantics);
3. stores the resolved selection immutably in instance data;
4. never consults detection, the records, or the environment again for the
   lifetime of the instance (structural proof, section 8 gate S1).
```
The per-filter entry-point TABLE (function pointers to real backends) is NOT
populated in this stage, because the real backend functions do not exist yet;
the permanent dispatch-record TYPE and the resolve-once function are created
first-class now (single home, C-STY-09/10), and 2C/2D populate per-filter
slots when their backends exist. This is the honest reading of "dispatch
consumes EFFECTIVE" for a stage where the only executable behaviour is
pass-through: the CHOICE is made, stored, proven immutable, and observable
(D-4); the CALL arrives with 2C/2D. RATIFIED. All per-instance parameter
detection/validation/variable setup happens at creation into the immutable
instance config (see amended D-7); nothing parameter-related happens
per-frame.

**D-6 - Sweep: Option A (full sweep now), with anchor relocation.**
Candidates (coder enumerates the definitive list from the actual tree and
classifies each; indicative set):
```text
retire now:  dll_probe.zig; the 1A build/headers/smoke probe files; the
             backend probe objects (deblock4_backend_probe_generic/scalar/
             sse41/avx2) and their @extern anchor sites; superseded batches
             (build_1B2_v5_REDEVELOPED.bat, build_1B3_v5.bat) - archived in
             the stage record, replaced by build_1C; any probe-only build.zig
             steps; all remaining LF-holdout scaffolding files.
keep:        deblock4_selftest (first-class, README-settled);
             cpu_capability_detection / config / print modules (first-class);
             unit tests; the inspection evidence sets (committed stage
             records, not live code).
```
Consequences W3X must weigh before ratifying:
```text
(a) The 1B.2 within-level standing regression retires WITH the probe objects.
    The 1B.2 evidence remains committed (inspection sets + acceptance docs);
    the within-level proof obligation returns PER-FILTER at 3C/3D against the
    REAL backends, where it is meaningful. Keeping dead probes alive between
    now and 3C invites drift and violates the spirit of C-STY-10.
(b) Any @extern anchor sites for probe symbols currently living in first-class
    files are RELOCATED in this stage so that scaffolding deletion requires
    ZERO first-class edits - now and forever after (the C-STY-10 sweep test,
    applied literally). The coder enumerates every anchor site before deleting
    anything.
(c) After the sweep, G10 three-surface absence and the export-table gate are
    RE-PROVEN on the new binary (section 8 gates G1, G2) - the sweep must not
    silently change the release surface.
```
RATIFIED: Option A (full sweep now, anchors relocated, evidence archived).

**D-7 (AMENDED and RATIFIED) - FULL parameter signatures up-front.** W3X
prefers all DLL parameters defined, checked, and their instance variables set
up-front now rather than retro-fitted. Amended decision: each filter registers
its FULL settled signature in this stage:
```text
- parameter names, types, defaults, and ranges come from the README's settled
  definitions (Classic: the HolyWu-derived signature; Deblock4: as settled by
  README v1.9). NO coder-invented parameters or semantics.
- creation parses, TYPE/RANGE/DEFAULT-validates, and stores every parameter
  into the immutable instance config; settled error messages on violation.
- SEMANTIC validation (what the values do to pixels) necessarily waits for
  the 2C/2D oracles; this stage proves parse/validate/store only.
- GAP RULE: if the README leaves any parameter unsettled (especially for
  Deblock4), the coder STOPS and enumerates the gap in the section 9 proposal
  round; W3X settles it before coding. Gaps are settled by W3X, never
  invented by the coder.
```

# 5A. Settled conventions (binding for this scope and successors)

These conventions are RATIFIED project practice. They are stated here so a
fresh coder chat inherits them explicitly; nothing below is optional or open
to re-derivation.

**C-1C-1 - fmParallel (R78+) from the start.** Both filters register
fmParallel. Instance data is immutable after creation. getFrame runs
concurrently across frames AND across instances. No shared mutable state
exists except the settled once-init ACTUAL record (immutable after init).
Instance numbering uses a monotonic atomic counter assigned at creation
(@atomicRmw .Add) - no mutex. Frame numbering is the getFrame `n` argument.

**C-1C-2 - DLL + selftest twin (CNR3-proven).** The selftest executable never
links VapourSynth. Therefore the module graph keeps VS-API-touching modules
strictly separated from pure-logic modules. Pure modules (tier/backend
resolution, parameter validation logic, config, version identity) are
importable by the DLL, the selftest, AND the unit tests; VS-facing modules
are imported only by the DLL side. The selftest gains a 1C section exercising
the pure resolution + parameter-validation paths.

**C-1C-3 - Thin DLL root; purpose-grouped functional modules.** The root
contains the entry point, registration, and instance setup/config/teardown
only. Everything else lives in single-homed functional modules (permanent
names; coder proposes exact names against the tree in the section 9 round):
```text
- per-activation-reason modules: arInitial (source-frame requests),
  arAllFramesReady (the dispatcher home; 2C/2D processing lands here),
  arError (error-path handling), extended as needed;
- tier/backend resolution + dispatch record: its own module (D-5); the
  settled cpu_capability_detection.zig is CONSUMED, never modified;
- common utility functions: one module;
- declaration-only shared-definition modules ("include" modules) for
  global/instance/thread data as required - the deblock4_config.zig
  declarations-only switchboard pattern settled in 1B.3, EXTENDED not
  forked (C-STY-09);
- the version identity module (C-1C-7).
```

**C-1C-4 - Explicit compilation tiers.** Every first-class module (entry,
filters, activation-reason modules, dispatch, utilities, config, version)
compiles in the baseline v1 object set (G2). Only nominated backend objects
compile at v2/v3, via the per-object scheme proved in 1B.1. Nothing is
implicit; the build states every object's target.

**C-1C-5 - VS headers via the settled bridge.** All VapourSynth API access
goes through the zig_vsh_* wrapper bridge reconciled at Stage 1A.1. Extend
the bridge if a new API call is needed; never fork it or re-derive raw
@cImport alternatives.

**C-1C-6 - The G10 gating shape, applied uniformly.** Debug-only code uses
the settled three-layer pattern: (1) source-visible conditional import
`const trace = if (build_options.enable_x) @import("...") else struct {};`
(2) gated content lives in dedicated debug modules; (3) call sites go
through the import's namespace (`trace.enter(...)`) so the import IS the
namespace. Release absence is proven on three surfaces exactly as in 1B.3.
The printing split is maintained: print_helper_functions (always-on) vs
print_diag_helper_functions (gated); flush-per-line; one physical line per
record.

**C-1C-7 - Global version identity, single home.** A version string
(currently `0.1.0-dev`) already exists in the tree but is not chartered as a
single source. This stage makes it one:
```text
- ONE first-class module (extend deblock4_config.zig or a dedicated
  deblock4_version.zig - coder proposes in the section 9 round) defines:
  the semver string, the numeric components for VS makeVersion/configPlugin,
  and an optional STEP MARKER field (build-metadata style, e.g.
  "0.1.0-dev+1C") that W3X can bump per stage/step as desired.
- EVERY emission consumes it: configPlugin registration, the always-on
  summary line, the selftest banner, lifecycle-trace output (C-1C-8), and
  the Deblock4Version frame property (added to the D-4 set).
- The coder's section 9 enumeration states where the current string lives;
  duplicates are collapsed to the single home (C-STY-09).
```

**C-1C-8 - Lifecycle trace seam: `enable_trace_lifecycle` (third G10
option).** A new Debug-only build option, identical in mechanism to the two
existing G10 options (Debug-only hard-reject in release; three-surface
proven absence; loud marker string). When enabled, it emits one physical
line per event, instance-numbered (C-1C-1 atomic id) and frame-numbered
where applicable, covering at minimum:
```text
plugin init; filter creation enter/exit (exit line dumps the full resolved
immutable instance config, one line); getFrame enter/exit per activation
reason (instance id, frame n, reason); instance free.
```
Purpose: make call/enter/exit behaviour visible during 1C bring-up and stay
useful at 2C/2D. Its marker string joins the G1 absence gate; its
Debug-positive-control joins the existing controls.

# 6. Design constraints (charter bindings)

```text
G1   The instance consumes the EFFECTIVE record only; ACTUAL is never
     consulted for selection. The Debug force-down seam therefore propagates
     into filter behaviour with zero filter-side code (gate E3).
G2   The entry point, registration, creation, getFrame, free, and the
     dispatch/resolution module ALL compile in the baseline (v1) object set
     and contain NOTHING above x86_64_v1. No gated import may reach them.
G5   No gated execution. Pass-through touches no backend.
G6   VapourSynthPluginInit2 is a legitimate PE export (it is the plugin
     contract, not gated code). No gated symbol appears in the export table;
     the standing dumpbin gate continues (gate G2 below).
G10  Both debug seams stay Debug-only; release three-surface absence is
     re-proven post-sweep on the new binary (gate G1 below).
C-STY-09/10  New modules are single-homed with permanent names
     (deblock4_dispatch, deblock4_filter_shell or per-filter modules - coder
     proposes exact names against the tree, extend-don't-fork the existing
     root). The sweep test must hold AFTER this stage by construction.
C-DELIV      CRLF everywhere; repository ends this stage with ZERO LF files.
I5   Any conflict between this scope and the tree as found: state it and
     stop; no silent adaptation.
```

# 7. Deliverables

```text
7.1  Modified DLL root (actual current filename; extend, don't fork):
     probe exports removed; VapourSynthPluginInit2 added.
7.2  New first-class module(s): dispatch record type + resolve-once function;
     filter shell (creation/getFrame/free) shared by both filters; per-filter
     registration glue. Exact file names proposed by the coder against the
     tree BEFORE coding (one round, W3D reviews).
7.3  build.zig: probe steps removed; existing DLL/selftest/test steps kept.
7.4  Deleted scaffolding per the ratified D-6 list.
7.5  build_1C standing batch implementing section 8. Inherits the 1B.3
     batch's hard-won harness rules: exit-code gating primary; positive
     present-checks over absent-scans; no findstr /X or fragile multi-word
     absent-scans against captured (LF) tool output; combined stdout+stderr
     capture with a diagnostic index; child-cmd self-launch; fresh temp
     files.
7.6  A minimal .vpy pair for the e2e gates (BlankClip-based; no external
     source dependency; one per filter).
7.7  Unit tests: the resolve-once function (auto/explicit-ok/explicit-too-
     high/invalid-string cases) AND the per-filter parameter validation
     (type/range/default and settled error messages) as pure logic, no VS
     core.
7.8  The version identity module (C-1C-7) and the lifecycle trace seam
     (C-1C-8) with its build option wired per the G10 pattern.
```

# 8. Proof matrix (build_1C gates)

Modes: Debug, ReleaseSafe, ReleaseFast unless stated.

```text
B1  Build green, all modes; unit tests green, all modes (10/10 existing plus
    the new resolution tests).
B2  Selftest still green all modes (PASS actual=... effective=...).
G1  G10 three-surface absence re-proven post-sweep for ALL THREE gated
    markers (force-down, verbose-detection, and the new trace-lifecycle
    marker): absent from DLL and selftest in ReleaseSafe+ReleaseFast on all
    three surfaces; Debug positive controls present for all three. Release
    build-reject covers the new option too (N1 becomes 9/9).
G2  Export table: VapourSynthPluginInit2 PRESENT; every probe export ABSENT;
    no gated symbol present. (dumpbin standing gate, updated expectations.)
E1  vspipe end-to-end, per filter: BlankClip -> filter(backend="auto") ->
    output; run completes; output checksum EQUALS input checksum (pass-
    through bit-identity, D-3).
E2  Frame properties, per filter: Deblock4Filter correct; Deblock4Tier equals
    the machine's expected effective tier (x86_64_v3_with_avx2 on the W3X
    host); Deblock4Version equals the single-homed version identity string.
E3  Debug force-down e2e: DEBLOCK4_FORCE_DOWN=v1 -> Deblock4Tier reports
    x86_64_v1_baseline; =v2 -> x86_64_v2_with_sse41; invalid value ->
    creation refused with the settled message. (Debug build only; proves the
    filter consumes EFFECTIVE, not ACTUAL, with zero filter-side special
    code.)
E4  Explicit backend: backend="x86_64_v2_with_sse41" honoured (tier prop
    reports it); backend above effective (Debug forced-down to v1, request
    v3) -> creation refused; unknown string -> creation refused.
E5  Full-signature parameter validation e2e, per filter (D-7 amended): a
    valid full-parameter invocation creates; one out-of-range and one
    wrong-type invocation each refuse creation with the settled message.
E6  Lifecycle trace (Debug, enable_trace_lifecycle=on): the e2e run's
    captured output contains creation enter/exit (with the one-line config
    dump), getFrame enter/exit with instance id + frame n, and free - and
    the version identity string appears in the trace banner.
V1  Version identity single-home: the configPlugin-registered version, the
    always-on summary line, the selftest banner, and the Deblock4Version
    property all equal the version module's value (scripted equality check,
    not eyeball).
S1  No-per-frame-branch structural gate: the resolution function is invoked
    from the creation path only; the getFrame path contains no call to
    resolution/detection (grep gate on source + symbol-level check on the
    getFrame object; coder proposes the exact mechanical check, W3D
    reviews - same spirit as the 1B.3 disasm gates, scaled to fit).
S2  Sweep test: after deletion, a repo-wide reference scan finds ZERO
    references to retired files from first-class code; build+tests green
    post-deletion (proving zero first-class edits were needed beyond the
    anchor relocation done deliberately in 7.1/7.2).
S3  EOL: repo-wide check reports ZERO LF text files.
N1  Negative controls: -Dcpu/-Dtarget rejected; release build-reject of all
    THREE G10 options panics across the three release modes (9/9).
```

# 9. Sequencing

```text
1. W3X ratifies D-1..D-7 (or amends; scope revs to v1.1).
2. Coder enumerates: actual root filename, anchor sites, definitive sweep
   list, README 13.5 property names, the FULL settled parameter table per
   filter from the README (names/types/defaults/ranges - flagging any GAP
   for W3X per amended D-7), the current version-string home(s), and
   proposed new module names per C-1C-3/C-1C-7. One proposal round; W3D
   reviews (propose-before-transform).
3. Delivery per C-DELIV (CRLF, full-file, dual-form rules as chartered).
4. W3D delivery review; W3X runs build_1C; artifact review (W3D + coder);
   fix cycles as needed - harness defects distinguished from code defects
   per the 1B.3 discipline.
5. W3X commits. Stage complete; next is Stage 2C (Classic scalar oracle).
```

# 10. Acceptance

The stage is accepted when the full section 8 matrix passes on the W3X host,
W3D has independently reviewed the raw artifacts (export table, absence
scans, e2e outputs, sweep scan), the coder concurs, and W3X has committed.
The commit message records the retired-file list and the build_1C batch as
the new standing regression.

---

*Revision history*
```text
v1.1 (2026-07-31) Ratifications incorporated: D-1..D-6 ratified as proposed;
     D-7 AMENDED to full up-front parameter signatures with the README gap
     rule. Added section 5A settled conventions (fmParallel/atomic instance
     ids, DLL+selftest twin constraint, thin root + purpose-grouped modules
     incl. per-activation-reason modules, explicit compilation tiers, the
     zig_vsh_* bridge, the uniform G10 gating shape, the single-homed global
     version identity with step marker, and the enable_trace_lifecycle third
     G10 seam). Proof matrix extended: G1 covers three markers, E5 parameter
     validation, E6 lifecycle trace, V1 version single-home equality, N1 ->
     9/9. Enumeration round extended accordingly.
v1.0 (2026-07-31) Initial draft for W3X ratification. Seven decision points
     (D-1..D-7) explicitly separated from settled constraints; sweep
     consequences (1B.2 regression retirement, anchor relocation) stated for
     an informed ratification.
```
