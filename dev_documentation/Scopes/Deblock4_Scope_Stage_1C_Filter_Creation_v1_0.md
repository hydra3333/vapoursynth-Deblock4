# Deblock4 - Scope: Stage 1C - Filter Creation (DRAFT for W3X ratification)

**Version:** 1.0 (DRAFT)
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

# 5. Decisions for W3X ratification

**D-1 - Stage designation `1C`.** (Section 2.)

**D-2 - Register BOTH filters now, minimal signature.** Register
`deblock4.Classic` and `deblock4.Deblock4` in this stage, each with the
minimal creation signature `(clip, backend="auto")`. Rationale: the two-filter
namespace is settled design (README section 1.0); the second registration
costs one function and proves the namespace early; algorithm parameters join
per-filter at 2C/2D (D-7). Alternative (register Classic only, add Deblock4 at
2D) is workable but creates a later mini-scope for one line of registration.
W3D recommends BOTH.

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
untouched.

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
stage's proof value (section 8 gates E2, E3).

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
(D-4); the CALL arrives with 2C/2D.

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
Option B (keep backend probes until 3C) is available if W3X wants the 1B.2
regression alive continuously; W3D recommends Option A.

**D-7 - Minimal creation signature now.** `(clip, backend="auto")` only.
Algorithm parameters arrive per-filter at 2C/2D with their oracles, where
their semantics can be validated against real behaviour. Registering unused
parameters now would encode semantics this stage cannot test.

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
     high/invalid-string cases) as pure logic, no VS core.
```

# 8. Proof matrix (build_1C gates)

Modes: Debug, ReleaseSafe, ReleaseFast unless stated.

```text
B1  Build green, all modes; unit tests green, all modes (10/10 existing plus
    the new resolution tests).
B2  Selftest still green all modes (PASS actual=... effective=...).
G1  G10 three-surface absence re-proven post-sweep: both gated markers absent
    from DLL and selftest in ReleaseSafe+ReleaseFast on all three surfaces;
    Debug positive control still present. (Same scans as 1B.3, new binary.)
G2  Export table: VapourSynthPluginInit2 PRESENT; every probe export ABSENT;
    no gated symbol present. (dumpbin standing gate, updated expectations.)
E1  vspipe end-to-end, per filter: BlankClip -> filter(backend="auto") ->
    output; run completes; output checksum EQUALS input checksum (pass-
    through bit-identity, D-3).
E2  Frame properties, per filter: Deblock4Filter correct; Deblock4Tier equals
    the machine's expected effective tier (x86_64_v3_with_avx2 on the W3X
    host).
E3  Debug force-down e2e: DEBLOCK4_FORCE_DOWN=v1 -> Deblock4Tier reports
    x86_64_v1_baseline; =v2 -> x86_64_v2_with_sse41; invalid value ->
    creation refused with the settled message. (Debug build only; proves the
    filter consumes EFFECTIVE, not ACTUAL, with zero filter-side special
    code.)
E4  Explicit backend: backend="x86_64_v2_with_sse41" honoured (tier prop
    reports it); backend above effective (Debug forced-down to v1, request
    v3) -> creation refused; unknown string -> creation refused.
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
N1  Negative controls unchanged: -Dcpu/-Dtarget rejected; release build-
    reject of both G10 options still panics (6/6).
```

# 9. Sequencing

```text
1. W3X ratifies D-1..D-7 (or amends; scope revs to v1.1).
2. Coder enumerates: actual root filename, anchor sites, definitive sweep
   list, README 13.5 property names, proposed new module names. One
   proposal round; W3D reviews (propose-before-transform).
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
v1.0 (2026-07-31) Initial draft for W3X ratification. Seven decision points
     (D-1..D-7) explicitly separated from settled constraints; sweep
     consequences (1B.2 regression retirement, anchor relocation) stated for
     an informed ratification.
```
