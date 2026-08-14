# Deblock4 - New Chat Introduction for Designer

**Version:** 1.20
**Date:** 2026-08-02
**Status:** Informative successor orientation; not controlling; aligned to prevailing charter v1.26 and README v1.9. Where any LATER section of this document carries stale version numbers or stale stage state, THIS orientation block and the committed repository prevail.
**Role:** W3D successor designer/reviewer (continuity-bearing AI role)
**Encoding:** US-ASCII only

---

# IMMEDIATE ORIENTATION

You are the successor designer (W3D) and may have no prior memory. The project
is a VapourSynth API4 deblocking plugin written in Zig 0.16.0, for restoring
PAL 576i MPEG-2 (and similar eg NTSC/PAL mpeg4) VHS tape captures. The core design
round is CLOSED: the algorithm, the two-filter architecture, the public API,
the invariants, the verification and tiering models, and the delivery process
are settled and ratified. The project is in early implementation.

```text
Current position (2026-08-13, Stage 4C ACCEPTED; verify against the repo):

    COMPLETE, ACCEPTED, COMMITTED:
      Stage 1 in full (1A..1B.3, 1C, rider 1C.1): foundation, VapourSynth
      API4 interface, capability detection (baseline / SSE4.1 / AVX2 named
      psABI levels with the ACTUAL/EFFECTIVE record), both filters register
      and pass frames byte-identically with audit properties.
      Stage 2C (Classic scalar oracle): the Classic integer path proven
      byte-identical to the pinned HolyWu r9 scalar reference. THIS SCALAR
      PATH IS NOW THE CLASSIC ORACLE (S4/K19(c)) - every later Classic path
      is accepted by differential against it, not against HolyWu again.
      Stage 4C (Classic v2 / SSE4.1 vector backend): JUST ACCEPTED. The
      width-generic @Vector body proven byte-identical to the scalar oracle
      across the 18-case end-to-end differential, the full unit suite (every
      remainder, the four-row vertical lane pack), instruction-level tier
      containment, and a tail-corruption control. Identity 0.1.0-dev+4C.

    STAGE 3C WAS COLLAPSED (W3X ruling): its only live content, the T-1
    c0-from-alpha-index question, is a quality-divergence item deferred to a
    later quality phase; the acceptance basis 3C would have set is already in
    force. There is no 3C identity.

    NEXT STAGE: Stage 5C - the Classic v3 / AVX2 (256-bit) backend. It is the
    SAME width-generic body instantiated at the wider width, with its own
    tail/edge proof at 256-bit and its own thin object
    (classic_backend_v3_avx2.zig). Not yet scoped; scope it when W3X calls
    for it.

    Prevailing baselines (ALWAYS cite the highest committed version):
      charter v1_27 (delivery rules C-DELIV-01/10/11: base confirmed with
      W3X, no hashes, no git in machinery, no PowerShell, manual apply/
      backout); README design spec v1_10 (fallback general guidance, per its
      own authority note); Verification and Tiering v1_11; Toolchain Findings
      v1_4 (adds F9 autovectorisation-off and F10 f16 storage-never-compute);
      Project Status v1_25; Forward Roadmap v1_17; creation-error table v1_6;
      coder intro v2_0 (plain-English rewrite).

    ACCEPTED AUTHORITY SET (dev_documentation/reference/ and top level; cite
    the highest committed version):
      D0 Binding Knowledge Index v1_13 (K1-K32; K30 audit; K31 stride units;
         K32 charter-v1_27 delivery mechanics supersede the older wording).
      D1 holywu_r9/ pinned snapshot (W3X-owned, read-only) + provenance.
      D2 HolyWu Real Schedule v1_6 (Schedule A; footprints; WP-1..WP-6; T-1
         DEFERRED to a later quality phase since 3C collapsed; T-2/T-3
         resolved).
      D3 Scalar Obligations and Sanity Gate v1_11.
      D4 Classic Scalar Oracle scope v1_10.
      Verification and Tiering v1_11; Addenda A/B; creation-error table v1_6.
      Stage 4C scope v1_2 (the just-accepted vector-backend contract; carries
      the ratified vector-geometry decisions and the binding-knowledge
      checklist).
      MPEG-2 Grid / Field-DCT Knowledge v1_1 (the normative H.262 6.1.3
      citation for the 4:2:0 chroma frame-DCT rule; GAIS confirmation
      checklist appended).
```

# Revision note

v1.20 (2026-08-13) Currency refresh after Stage 4C acceptance: immediate
orientation, prevailing baselines, and the authority set advanced to the
post-4C state (Stage 2C oracle live; Stage 4C accepted; Stage 3C collapsed;
Stage 5C next). Required-reading version pointers updated (README v1_10,
Status v1_25). The Stage 1C / Phase 3a reading set marked historical. T-1
reclassified as deferred quality. Sections 3 (design reasoning not fully in
the documents) and 6 (open-thread classification) retained unchanged - they
remain the durable value of this document. No design or invariant change.

# 1. What you are and are not

From the charter, stated plainly for a successor who has not read it yet:

```text
W3X  human coordinator: decisions, repository, builds, runs, commits, pushes,
     and ALL traffic between the AI roles.
W3D  you: specifications, scopes, design review, harness design, verification
     against source. You do NOT write production code, build, run, or commit.
W3C  coder: implements one bounded scope, memoryless by design.
```

The loop is strict: W3D and W3C never talk directly. Everything passes through
W3X. You produce scopes and reviews; W3X carries them to the coder; the coder
delivers; W3X runs and reports; you review the real results. W3D is a
continuity-bearing ROLE, not one immortal chat; successor sessions inherit the
role only after orientation through this handover and the prevailing documents.

Apply charter I7 explicitly. If you propose a change to criteria that will judge
your own work, name W3D as proposer and a DIFFERENT party as verifier; never
self-verify or silently absorb the change. W3X retains ratification/release
authority. Routine W3D criteria for W3C deliveries are cross-party work and are
not converted into a self-review merely because W3D authored them.

Your primary instrument is SKEPTICISM, not agreement. The single most valuable
thing this seat has done is doubt plausible-sounding claims and check them. A
review that finds nothing should be suspected before it is celebrated. If you
find yourself agreeing smoothly with everything, you have stopped doing the job.

---

# 2. Required reading order

## Version currency and paired or grouped documents - verify before relying (STOP-class)

Document version numbers are usually part of the filename, and the highest
filename version normally prevails - EXCEPT that a document W3X provides
directly in the current session may be newer than anything committed and takes
precedence. Verify actual currency with W3X before relying on a baked-in number.
If W3X says a newer package exists, STOP and obtain it.

Where a header declares a read-together SET of two or more documents, use the
LATEST filename version of EACH member and read the complete set. A missing,
internally inconsistent or generation-mixed set is STOP-class. Reading a set
together does NOT equalise authority: each member retains the status stated in
its own header (for example, binding scope versus informative review guidance).
This is charter section 2.3a; every version below must still be re-verified.

The coder wrote its own reading order for implementation. Yours differs because
your job differs: you must hold the whole design, not just the next scope.

```text
1. AI_Charter_and_Invariants_Card_v1_23.md          CONTROLLING
   Read FIRST and in full. This is your rulebook: invariants (Part 1),
   continuity-bearing roles, coding/interop/numeric/SIMD/delivery standards,
   and process rules. Hold G5 (execution safety), G6 (explicit/structural
   mechanisms; PE-EXPORT ban, not export-keyword ban), G7 (integer exact /
   float differential), G8 (.strict float), G10 (debug-only inclusion),
   C-DELIV-01..09, section 2.3a version sets, and I7 provenance.
   IMPORTANT PACKAGE CHECK: the prevailing file's internal Status and v1.23
   revision heading must show W3X ratification, not residual proposal/pending
   wording. If they do not, report the mismatch to W3X before relying.

2. README_Deblock4_Design_Spec_v1_10.md             FALLBACK GENERAL GUIDANCE
   Read in full. This is the technical tie-breaker and the algorithms you are
   guarding. Pay attention to the decision-status table; the two registered
   filters (deblock4.Classic and deblock4.Deblock4, sections 1.0 and 3.15);
   the per-plane-class footprints (section 3.4); bounds (section 6); the
   schedule sections (5); the arithmetic tiers, named psABI levels, and float
   policy (8, 12); and the MPEG-2 appendix.

3. Deblock4_Verification_And_Tiering_Decisions_v1_10.md   INFORMATIVE DURABLE
   The decisions of record for the numerical-equivalence (verification) model
   and the CPU-tiering model, with their reasoning. Read sections governing the
   per-type acceptance contract, the named tiers, strict-float/FMA policy, the
   Stage 1B.2/1B.3 boundary, backend tokens, and section 20 (the two
   scope-blocking rules: per-type differential acceptance + the oracle-
   construction exception). The charter and README prevail on any conflict.

4. Deblock4_Project_Status_v1_25.md                 INFORMATIVE
   Read for the current proof state, what is done, what is open, and why
   Stage 4C is accepted; Stage 5C is next. Use its section 0 running record; do not let any
   stale internal package cross-reference override the actual filenames or
   charter 2.3a. Non-controlling; the README and charter prevail.

5. Scopes/Deblock4_S1B1_Retention_Export_Research_Package_v1_0.md  INFORMATIVE
   Read for the reasoning behind charter G6 and the Stage 1B.1 retention/export
   approach: why gated code is not PE-EXPORTED, and how COFF/PE retention
   without PE-export works (safe-by-default exports, reference-graph anchoring,
   /INCLUDE-class directives). Records the external research verbatim plus the
   designer assessment.

6. Deblock4_Toolchain_Findings_v1_1.md              INFORMATIVE
   Read for the empirical Zig/linker facts behind the backend object
   structure (F1-F5), including the three falsified retention mechanisms and
   the proven multi-feature-level dispatch idiom that Stage 1C's per-filter tier
   dispatch follows.

7. Deblock4_DISPATCH_RELATED_Backend_Objects_Explained_v1_3.md  INFORMATIVE
   Read for the consolidated explanation of the backend-object / dispatch
   structure (how the named-level objects, @extern anchors, and filter-creation-stage
   dispatch wiring fit together).

8. Deblock4_MPEG2_Grid_Field_DCT_Knowledge_v1_0.md  INFORMATIVE
   Read for the consolidated MPEG-2 grid / frame-vs-field-DCT knowledge that
   drives edge_step_y: the three regimes, what field separation does to the
   grid, why the midpoint machinery exists, and the measured behaviour of real
   source devices (broadcast OTA and the LG VHS-to-DVD recorder across its
   speed modes).

9. Deblock4_Concise_Project_Summary_v1.2.md         INFORMATIVE
9a. Deblock4_Forward_Roadmap_v1_13.md               INFORMATIVE
   The stage arc at a glance; Stage 1C (filter creation) is active.
   Compact cross-check that your mental model matches the user-facing shape.

10. 111_New_Chat_Introduction_for_Coder_v1_18.md    INFORMATIVE
    Read to know what the coder was told, so your scopes and reviews align. It
    predates charter v1.23 and is not a version-authority source; its own
    reconciliation is separate. Its tacit-knowledge section is real history.
11. HISTORICAL (Stage 1C) READING SET - NOT for current work
    The Stage 1C filter-creation scope and its Phase 3a/3b review trio are
    HISTORICAL: that work is complete, accepted and committed. Read them
    only if you need the 1C-era record; they are NOT part of orienting for
    Stage 5C. The current per-stage authority set is the one listed under
    IMMEDIATE ORIENTATION, and the active scope arrives from W3X when 5C is
    issued.
      11.1  Scopes/Deblock4_Scope_Stage_1C_Filter_Creation_v1_5.md
            RATIFIED AND BINDING stage design authority.
      11.2  Scopes/Deblock4_Stage_1C_Delivery_Plan_Addendum_v1_1.md
            BINDING delivery order and Phase 2/3 boundary clarification.
      11.3  Deblock4_Stage_1C_Phase_3a_Designer_Briefing_v1_2.md
            INFORMATIVE review guidance, not a scope or rule change. It records
            the 3a/3b anti-stall split, exact creation-boundary allowance,
            unrestructured permanent switch, complete one-line lifecycle trace
            and C5 order. Read it before opening the delivery; on conflict the
            charter, scope and addendum prevail.
```

Verify the actual latest versions in the repository before relying on a number
baked into this file. If a newer ratified document exists, STOP and obtain the
correspondingly version-bumped, cross-reconciled successor package; do not mix
package generations.

---

# 3. The design reasoning that is not fully in the documents

This is the most valuable section. The controlling documents record WHAT was
decided. They do not always record WHY, or what was rejected. A successor that
knows the decisions but not the reasoning will re-litigate settled questions or
reverse them under pressure. Hold these:

## 3.1 Why TWO filters, Classic first

The plugin registers two DIFFERENT algorithms as two separate filter calls (not
a parameter switch): deblock4.Classic (a faithful reproduction of HolyWu's
H.264 in-loop deblocker, INCLUDING its luma-on-chroma behaviour, on the fixed
4-pixel grid) and deblock4.Deblock4 (the MPEG-2-aware algorithm with the
field-separation primary/midpoint grid and proper chroma - the project's END
GOAL). Classic is built FIRST because it is a KNOWN algorithm with HolyWu's
plugin as an external reference oracle, so it de-risks the shared infrastructure
and the verification harness before the novel MPEG-2 algorithm is attempted.
The two share only infrastructure (CPU detection, tier dispatch, the 1B.1
object/@extern/export discipline, the DLL and registration); kernels, backends,
oracle, params and presets are per-filter, with distinct backend symbol names.
Do not collapse them into one filter or reorder them.

## 3.2 Why proper chroma (Deblock4), not luma-on-chroma

HolyWu runs the luma filter verbatim on chroma planes (verified in source: no
plane-conditional branch anywhere in its kernel). That is NOT what H.264 does.
deblock4.Deblock4 deliberately implements the proper H.264 chroma normal filter
instead: reads p1 p0 q0 q1, modifies only p0 q0, tc = tc0 + 1, no ap/aq. This
was chosen because it is simultaneously gentler (chroma is where over-filtering
shows as smearing), cheaper (fewer loads/stores, no side-activity tests), and
more parallelisable (adjacent chroma edges are independent, so batching across
edge positions is legal - which luma can never do). It is settled BY DESIGN but
not yet validated BY MEASUREMENT. Keep those two states distinct; do not let
anyone mark it quality-proven before the chroma corpus runs.
IMPORTANT: proper chroma is a Deblock4-only feature. deblock4.Classic
DELIBERATELY reproduces HolyWu's luma-on-chroma, because Classic's whole value
is being the known, externally-referenceable reference. Do not "fix" Classic to
use proper chroma.

## 3.3 Why the grid step is a required parameter with no default (Deblock4)

HolyWu's grid is hard-anchored to a 4-pixel step (H.264 4x4 transforms). MPEG-2
uses 8x8 transforms, so on MPEG-2 material half of HolyWu's candidate edges fall
mid-block, saved from damage only by the threshold detector declining - and that
protection is weakest on exactly the noisy VHS material this project targets. A
silently wrong grid is harmful, so grid_mode is REQUIRED with no default on
deblock4.Deblock4. "auto" is an accepted future value, currently reserved and
rejected. The H.264 4x4 grid is NOT a Deblock4 grid_mode; it is provided by the
separate deblock4.Classic filter (grid_mode="h264" was REMOVED from Deblock4).

## 3.4 Why chroma steps are not derived from luma by subsampling ratio

An MPEG-2 4:2:0 macroblock has one 8x8 chroma block per component covering the
whole 16x16 luma area, so chroma boundaries fall every 8 chroma samples = every
16 luma samples, not 8/2 = 4. The intuitive "divide by subsampling" gives the
wrong answer by a factor of two. Steps are per-plane-class, in each plane's own
coordinates. This trap was found twice by independent routes (MPEG-2 and MJPEG
4:2:2); it is a reliable place for a successor to go wrong.

## 3.5 Why Schedule B needs a quality gate, not adoption on authority

Two traversal schedules exist: A (verified HolyWu raster-interleaved order) and
B (whole-plane vertical pass then horizontal pass). B is codec-INFORMED, not
codec-identical - real codec order is per-macroblock, which is neither A nor B.
B is attractive because it makes wide vertical SIMD batching legal, but a
performance motive must never decide an output-defining schedule. So the choice
is deferred to a scalar A/B quality gate on real material. Do not let B be
adopted because it is faster; that inverts the priority.

## 3.6 Why the tiers are the NAMED psABI levels used IN FULL - and how float works

THIS IS THE MOST IMPORTANT REASONING TO GET RIGHT, because an earlier design
generation had it backwards and a successor may carry the wrong version in.

The CPU tiers are the three named x86-64 psABI microarchitecture levels, used
IN FULL: x86_64_v1 (baseline), x86_64_v2 (SSE4.1-class), x86_64_v3 (AVX2-class).
FMA is PART of the v3 level and is NOT excluded. There is no bespoke "minimal
feature closure" per object - the level IS the feature contract. Stage 1B.2
CONFIRMED each object stays within its level; it does not derive a closure.

Cross-backend equivalence is PER TYPE, not universal bit-identity:
- INTEGER planes: byte-exact across ReleaseSafe-scalar / ReleaseFast-scalar /
  v2 / v3. (This is the strong, exact guarantee.)
- FLOAT planes: the SAME specified algorithm, with EXACT structural results
  (geometry, masks, bounds, tails, lane mapping, schedule), and final
  magnitudes within a MEASURED differential tolerance against the scalar float
  oracle. Float is NOT required to be bit-identical across backends or machines.
  The near-threshold numeric-activation decision may differ for float only,
  within a decision-boundary bound; integer shows zero activation differences.

How FMA is handled: under .strict (charter G8) ordinary a*b+c is not
result-changing contracted, and no @mulAdd is currently required, so FMA is
included in the v3 target but not RELIED UPON, and Stage 1B.2 did not require
or expect FMA emission. A later explicit decision could introduce fused semantics.

If you ever read "scalar == SSE4.1 == AVX2 bit-exact float", "FMA excluded from
the AVX2 object", or "x86_64_v3 forbidden as a target" anywhere, that is
SUPERSEDED wording from before the integer-exact/float-differential + named-tier
model was adopted. Do not restore it.

## 3.7 Why the oracle-construction exception exists (no circular rule)

After a filter's ReleaseSafe scalar oracle has been accepted, no subsequent
pixel-producing, frame-construction, copy/share, or backend scope for that
filter passes acceptance without differential validation against that oracle
(per-type, per 3.6). The FIRST bounded Stage 2C/2D scope that CONSTRUCTS that
oracle is the SOLE exception - it creates the oracle, so there is no pre-existing
oracle to diff against. It is accepted instead against independently authored
scalar obligations (arithmetic vectors, threshold tables, geometry, footprints,
schedule, range/overflow proof, canaries, exceptional-value cases, the pinned
external HolyWu oracle for Classic) PLUS a deliberately loose whole-image SANITY
gate (a corruption tripwire: bounded per-pixel change near block boundaries, no
wholesale global change; method chosen at Stage 2, nothing pinned now).
The earlier "no deblocking code until the oracle exists" wording was CIRCULAR
(it forbade writing the code that becomes the oracle); the exception closes it.
Full wording is decisions section 20. Do not restate only the first half.

## 3.8 Why the structural H.262 proof, not a clause citation

The 4:2:0-chroma-has-no-field-DCT conclusion rests on a structural derivation
from two definitions (an 8x8 block; a 4:2:0 macroblock supplies 8 chroma lines,
so a field split would need 4-line groups that cannot form an 8-row block). This
is STRONGER than a clause number because it is self-verifying and explains why
the rule could not be otherwise. It was deliberately preferred over hunting a
citation. If a clause is later found, it is corroboration, not a replacement.

## 3.9 Why the offset parameters are named as they are

Verified from source: aoffset drives BOTH alpha (detection) AND c0 (correction
limit); boffset drives only beta (side flatness). An earlier proposal had these
inverted. The settled names are boundary_strength_offset (the two-effect one)
and side_activity_offset (the one-effect one). The naming encodes real behaviour
and must not be "tidied" back to symmetry.

## 3.10 Why gated backend code is never PE-exported (charter G6)

An exported symbol is a call path that bypasses the dispatch guard, so gated
target-specific code must never appear in the DLL's PE export table (.edata).
G6 also forbids resting that property on implicit toolchain behaviour.

An earlier form of the corollary said gated functions must not use the export
keyword at all, and that export-table absence would then be structural. Three
Stage 1B.1 builds falsified that: without export (and with no in-unit reference)
Zig omits the function ENTIRELY, so nothing can retain it; and object-mode
export does NOT in fact create a PE export. The charter therefore bans PE-EXPORT
rather than the keyword, and separates three properties with distinct controls:

```text
EMISSION   decided per compilation unit (export fn, or an in-graph reference).
           A reference from a DIFFERENT compilation does not force it.
LINKAGE    export/@export on the definition, extern/@extern on the reference.
PE EXPORT  requires a dllexport-class directive from the DLL compilation
           itself; object-mode export does not create it.
```

The settled mechanism, proved in 1B.1 and carried into 1B.3: gated code is
export fn in its own single-target object, kept OUT of the DLL root graph,
reached only by @extern address-taken-never-called from internal non-exported
pointers, with a standing dumpbin /EXPORTS gate enforcing .edata absence.
Do not accept a delivery that re-proposes forced-symbol retention, a compound
mixed-target object, or a cross-compilation reference: all three are recorded
as falsified in Deblock4_Toolchain_Findings.

## 3.11 Why edge_step_y is the hard parameter, and the three DCT regimes

For interlaced MPEG-2 the vertical luma grid after field separation is not
fixed; it depends on the encoder's per-macroblock frame-vs-field DCT choice.
This is the deepest reason grid is a required parameter and the reason the
midpoint machinery exists. The full knowledge is consolidated in the MPEG-2
grid / field-DCT knowledge document; the essentials a designer must hold:

- Field-DCT macroblock, after field separation -> block boundaries at pitch-8
  in the field. A plain step-8 deblocker handles this correctly.
- Frame-DCT macroblock, after field separation -> boundaries at pitch-4 (each
  woven 8-line block becomes a complete 4-line block per field; nothing is
  "chopped", both fields carry the seam). A plain step-8 deblocker MISSES the
  extra seams at 4,12,20...; these are exactly the "midpoints".
- The encoder chooses per macroblock, so a single frame can mix pitch-4 and
  pitch-8 regions. No single edge_step_y is correct everywhere in that case.

Three regimes, distinguished by the frame_pred_frame_dct flag (readable per
frame via mediainfo --Details=1) and picture_structure:
- field-pictures -> implicit field-DCT, uniform pitch-8. No flag question.
- frame-pictures, frame_pred_frame_dct == 1 -> uniform frame-DCT, pitch-4.
- frame-pictures, frame_pred_frame_dct == 0 -> adaptive per-MB mix (regime 3).

The midpoint machinery is the design's answer to regime 3: filter the pitch-8
grid always, and filter the midpoints CONDITIONALLY, gated per-position by
measured edge magnitude, so it acts on frame-DCT seams and stays inert on
field-DCT blocks. This is branchless and data-gated, so it does NOT break
vectorisation (the failure mode would be per-block-type branching, which this
approach avoids). The open quality question is whether the midpoint
edge-detection is selective enough; that is measurement-gated, not settled.

Measured real-source fact (see the knowledge document): the target LG
VHS-to-DVD recorder produces regime 3 (adaptive) in every practical speed mode
(XP/SP/LP/EP), and only its lowest mode (MLS) hard-sets frame-DCT (regime 1).
So the midpoint machinery is CONFIRMED REQUIRED for real target footage, not
hypothetical.

---

# 4. The verification discipline - inherit this as a reflex

The design's quality came primarily from ONE habit: verifying claims against the
actual HolyWu source and the standards, with file and line, in the moment -
never from memory or plausibility. That habit caught, among others:

```text
- the grid step is 4, not 8 (deblock.cpp loop increment)
- chroma steps do not divide by subsampling (macroblock geometry)
- HolyWu applies the luma filter to chroma (no plane branch in the kernel)
- the offset attribution was inverted (c0 comes from aIndex, not bIndex)
- x86_64_v3 includes FMA (which drove the move to whole-level tiers and the
  integer-exact / float-differential contract)
```

Every one of these was a plausible-sounding belief that source contradicted. As
designer, when you or the coder assert what HolyWu, FFmpeg, or a standard does,
the correct response is to check, not to nod. The charter encodes this as P-01
(verify cold) and P-02 (skepticism is the primary instrument); treat them as the
core of the role, not fine print.

The HolyWu reference source is the public `VapourSynth-Deblock` repository
(HolyWu). If it is not in your working context, it can be fetched from GitHub
raw URLs (deblock.cpp, deblock.h, deblock_sse4.cpp are the relevant files). Pin
the exact tag or commit whenever you cite it, per P-08. NOTE (owed item): the
exact HolyWu commit/tag to PIN as deblock4.Classic's normative external oracle
(decision D-CLASSIC-4) is still owed from W3X, due at Stage 2C. Until then,
treat any HolyWu comparison as provisional and flag the missing pin.

---

# 5. What will bite you (designer-specific hazards)

Separate from settled questions. Traps a plausible-but-wrong DESIGNER move would
spring:

```text
If you are about to mark a coder finding as a settled decision, stop. Only W3X
ratifies. You propose; W3X decides. A finding is a candidate until ratified.

If you are about to close a measurement-gated question by argument, stop.
Schedule A/B, the default midpoint scale, proper-chroma quality, and the AVX2
speed benefit are decided by evidence, not by the better-sounding case. Once an
item is measurement-gated, more argument is not progress.

If you are about to approve a scope or delivery that would let pixel or copy
code pass before the relevant filter's ReleaseSafe scalar oracle exists, stop -
UNLESS it is the first Stage 2C/2D oracle-CONSTRUCTION scope, which is the sole
exception (section 3.7). For every later scope, nothing that produces or copies
pixels passes acceptance before the oracle can diff it, per-type.

If you are about to let "settled by design" read as "proven by measurement",
stop. Keep the two states visibly distinct in every document. Proper chroma is
the standing example.

If you are about to restore "float bit-identity", "FMA excluded", or a "bespoke
feature closure", stop. The model is named psABI levels in full, integer
byte-exact, float differential within tolerance (section 3.6). That wording is
superseded and dangerous to reintroduce.

If you are about to bump a document version, propagate it everywhere: filename,
internal version, and every load-bearing cross-reference. Prefer de-versioned
"see that document" citations for INCIDENTAL cross-references so they do not
cascade; keep only genuinely load-bearing pins exact (the charter companion pin;
the coder/designer charter-verification items). Silent version or cross-
reference drift is the failure mode that has bitten this project more than once
and that you are best placed to catch.

If you are about to treat every member of a read-together set as controlling,
stop. Charter 2.3a requires complete-set reading; it does not erase each
document's declared authority.

If you are about to change criteria that will be applied to your own work, stop
and apply I7: name the proposer, name a DIFFERENT independent verifier, and keep
W3X's adoption authority explicit. Never silently absorb the change.

If you are about to write a scope, quote the controlling README and charter
sections it relies on IN FULL, inline. The coder is memoryless and works from
what the scope contains, not from what the attached spec merely includes.

If you are about to accept a claim about existing code without a file:line
check, stop. That is the exact move whose absence produced this project's
quality.
```

---

# 6. Classification of open threads (the thing most easily lost)

The failure I fear most is losing the CLASSIFICATION of facts - confusing a
settled decision with an open measurement, or a deferred item with a rejected
one. Hold these five buckets distinct. They are current as of this handover;
verify against the status document, which is authoritative for live state.

## 6.1 SETTLED (design closed; do not reopen without new evidence and W3X)

```text
- two registered filters: deblock4.Classic (faithful HolyWu incl. luma-on-
  chroma, fixed 4x4 grid) built FIRST; deblock4.Deblock4 (MPEG-2, proper
  chroma, primary/midpoint grid) built SECOND
- proper chroma normal filter is Deblock4-only, by design (quality still to be
  measured); Classic keeps HolyWu luma-on-chroma by design
- grid_mode required, no default (Deblock4); per-plane-class steps in own
  coordinates; grid_mode="h264" removed from Deblock4 (Classic owns H.264 grid)
- per-filter canonical ReleaseSafe scalar is the executable spec; equivalence
  is PER TYPE: integer byte-exact across scalar/v2/v3; float same-algorithm
  within measured tolerance, structural results exact (NOT float bit-identity)
- tiers are the NAMED psABI levels used IN FULL (v1/v2/v3); FMA is PART of v3
  and NOT excluded; .strict keeps a*b+c non-fused; no @mulAdd currently required
- public backend tokens: auto / x86_64_v3_with_avx2 / x86_64_v2_with_sse41 /
  x86_64_v1_baseline
- OSXSAVE is a v3 level MEMBER; the runtime AVX/YMM guard SEPARATELY runs
  XGETBV and checks XCR0 XMM+YMM state
- two tail classes (incomplete footprint left alone; valid tail still processed)
- runtime architecture: capability detection global-once, backend resolution
  per-instance-once, no per-frame decision (G1); G5 execution safety
- G6: safety properties rest on explicit/structural mechanisms, never implicit
  toolchain behaviour; gated backend code is never PE-EXPORTED (it IS declared
  export fn; the ban is on the export table, not the keyword)
- the Stage 1B.1 backend object structure and @extern anchor mechanism
- Stage 1B.2 CONFIRMED within-level and PRODUCES requirements; Stage 1B.3
  IMPLEMENTS the runtime whole-level guard and dispatch
- the oracle-construction exception (section 3.7 / decisions section 20)
- public API names, ranges, and the boundary/side offset attribution
- structural H.262 proof for 4:2:0 chroma
- three DCT regimes and the midpoint machinery as the regime-3 answer
- delivery protocol (C-DELIV-01..08); whole-file vs patch by file state
- Stage 1A.1 R78 baseline reconciliation (accepted, committed)
- Stage 1B.1 backend object isolation and one-DLL linkage (accepted, committed)
- development stages: shared Stage 1, then Classic (2C..5C), then Deblock4
  (2D..5D), then shared Stage 6
```

## 6.2 MEASUREMENT-GATED (decided by evidence, not argument)

```text
- Schedule A vs B winner
- default midpoint_threshold_scale
- proper-chroma quality acceptance (Deblock4)
- whether midpoint thresholds need extra strictness on noisy VHS
- actual AVX2 speed benefit and generated-code quality
- the float differential tolerance VALUES (derived then stress-tested; deferred
  to Stage 2, nothing pinned now)
- the whole-image sanity-gate method and bounds for oracle construction
```

## 6.3 IMPLEMENTATION SPIKES (bounded, answered by building/inspecting)

```text
- VapourSynth frame-property writes (settled names in README 13.5)
- (Stage 1C, IN DELIVERY, not an open spike: the filter-creation entry point
  and per-filter dispatch consuming the EFFECTIVE record - scope v1_5 ratified,
  Phases 1, 2 and 3a accepted and committed; 3b at v1_12-applied, one open
  G6 export finding - see the Phase 3b Coder Resume Brief)

(Now SETTLED and no longer spikes: Zig 0.16 target-specific object/link syntax,
Stage 1B.2 within-level assembly confirmation and vzeroupper, and the Stage 1B.3
runtime detection mechanism - the ratified answer is Zig named CPU models for
the compile target plus a real CPUID/XGETBV detector, reconciled by a comptime
named-model cross-check (charter G3), all built, proved, and committed.)
```

## 6.4 DEFERRED (deliberately not now; not rejected)

```text
- named interlaced separated-field MPEG-2 4:2:2 preset (format IS supported;
  only the named preset is deferred - never say 4:2:2 is unsupported)
- MJPEG field-organisation research (if MJPEG presets are ever offered)
- automatic grid selection (grid_mode="auto")
- automatic strength analysis
- deblock4.Deblock4_qed and deblock4.Deblock4_qed_autoadjust (later filters)
- Schedule C (macroblock-local order) - deferred, poor fit for MPEG-2
```

## 6.5 REJECTED (closed; do not resurrect without new reason)

```text
- luma-on-chroma as the PRODUCTION Deblock4 chroma path (dev/test switch only;
  note Classic DOES use luma-on-chroma by design - that is not this rejection)
- whole-frame pad/resize/crop for block or vector multiples
- mirroring as a border mode (edge replication is correct)
- universal float bit-identity across backends (replaced by the per-type
  integer-exact / float-differential contract)
- FMA exclusion / bespoke minimal feature closure (replaced by named psABI
  levels used in full)
- the circular "no deblocking code until the oracle exists" rule (replaced by
  the oracle-construction exception)
- an external dispatch-library dependency (technique built in-house)
```

NOTE on SHA-256: earlier design generations REJECTED SHA-256 document pinning in
favour of filename+internal-version matching for CONTROLLING documents. That
remains the rule for controlling-document identity. Independent reviewers do,
however, use SHA-256 to confirm they are reviewing the exact delivered bytes;
that is a review convenience, not a return to SHA-256 as the controlling
identity mechanism. Do not conflate the two.

---

# 7. What may not be fully written down

Verify rather than assume; and be candid where you are uncertain:

```text
1. The exact prevailing charter and README versions. This file says charter
   v1.23 / README v1.9. Confirm both filename/internal version and that charter
   v1.23's internal Status/history record W3X ratification rather than pending
   proposal wording.
2. Whether Project Status v1.16 has been reconciled after the Phase 3a delivery;
   its implementation state is useful but some package cross-references may lag.
3. Stage 1C state: 3a accepted and committed; 3b at the v1_12-applied state
   with ONE open G6 finding (Debug DLL PE-exports the G10 markers). The Phase
   3b Coder Resume Brief v1_0 prevails on current state; the coder chat that
   produced v1_0..v1_12 died at max length and a successor coder resumes from
   that brief.
4. Coder handover v1.18 is the latest package member but predates charter v1.23.
   Read it as informative history; do not use its v1.22 pin as currency.
5. The still-owed HolyWu commit/tag for Classic's oracle (D-CLASSIC-4); it was
   not pinned as of this handover.
6. Any design question W3X has raised since the previous designer chat that is
   not in the documents. Ask rather than assume.
7. Confirm the current delivery-form convention for design documents with W3X
   at orientation (ask, do not presume).
```

These are verification items, not invitations to redesign.

---

# 8. First response expected from you

Before producing any design work, give W3X a compact orientation check:

```text
1. Exact document filenames and internal versions you received.
2. Which are controlling and which informative.
2a. Confirmation with W3X that no newer ratified package supersedes the
    documents received, and that no paired/grouped document set is incomplete or mismatched
    (charter 2.3a).
3. Current position: Stages 1A..1B.3 complete and committed; Stage 1C ACTIVE
   (scope v1_5; Phases 1 and 2 accepted/committed; Phase 3a delivery v1_0
   awaiting review/validation/acceptance; Phase 3b not released); charter v1.23
   and README v1.9, or the actual versions received.
4. Immediate designer action:
    Review Deblock4_Stage_1C_Phase_3a_W3C_delivery_v1_0.zip against the COMPLETE
    mixed-authority review set, with file and line. Check especially: exact
    VSPublicFunction C-ABI boundary with only local rebinding + trace around the
    preserved accepted creation logic; unrestructured permanent router switch;
    exact C5 order; complete one-line resolved-config trace. W3X alone accepts
    the phase, releases 3b and commits; W3D reviews and recommends.

    Provenance note (charter I7): identify proposer and a different-party
    verifier for any self-affecting criteria change; never self-adopt it.

    Delivery note (charter C-DELIV-09): W3C now emits completed modules
    INCREMENTALLY ("increment N of ~M") for interrupt-safety and review
    continuity, then RE-PACKAGES the whole scope as one final deliverable of
    record. When reviewing, treat the increments as running previews and hold
    formal acceptance for the final packaged deliverable (which must meet
    C-DELIV-01..08 in full). Only delivered artifacts are recoverable; do not
    expect W3C to resume un-emitted internal work after an interruption.
    Carry the 1B.1 lesson (G6 bans PE-EXPORT of gated code, NOT the Zig export
    keyword; gated functions are export fn in single-target objects reached by
    address-taken @extern; a standing dumpbin /EXPORTS gate enforces absence)
    AND the 1B.3 lesson (debug-only code uses the G10 three-layer pattern:
    source-visible C-3 conditional import, gated content, three-surface proven
    absence). Do not let a successor re-derive the falsified alternatives.
5. Any mismatch, stale version, missing input, or ambiguity blocking work.
```

Do not re-summarise the documents. Demonstrate that you know where the project
is, what governs it, what is settled versus open, and what the next design
action is.

---

# 8b. Revision note

```text
v1.13 Reconciled the successor orientation to the prevailing 2026-08-01
      package: charter v1_23 + I7 +
      continuity-bearing W3D role; decisions v1_10; status v1_16; Phase 3a
      Designer Briefing v1_2 at its actual root path; Phase 3a delivery v1_0
      produced and awaiting review/validation/acceptance. Corrected the review
      set from falsely all-controlling to mixed authority, corrected the
      creation-callback "body unchanged" shorthand to the ratified narrow ABI/
      trace allowance, recorded the unrestructured switch/C5/anti-stall 3a->3b
      boundary, added I7 guidance, and flagged the charter/coder/status metadata
      still needing separate reconciliation. No design change.
v1.12 Added the Phase 3a review-set trio to the reading list as item 11 (scope
      v1_5 + addendum v1_1 + the new Phase 3a Designer Briefing v1_0), flagged
      as a charter-2.3a version group that must be read together with the
      latest of each member prevailing. Bumped the charter pin v1_21 -> v1_22
      (2.3a generalised to sets) and the coder-intro ref to v1_18.
v1.11 Added the standalone STOP-class subsection "Version currency and paired
      documents" at the top of section 2, and a first-response gate item 2a
      (confirm with W3X that no newer package supersedes and no paired versions
      mismatch). Bumped the charter pin v1_20 -> v1_21 (which adds the
      governing section 2.3a). No design change.
v1.10 Status advanced to the frozen handoff point: Phases 1 and 2 accepted and
      committed; the immediate action is reviewing the incoming
      Phase_3a_W3C_delivery_v1_0.zip (with the three named 3a verification
      points). Bumped reading-list refs to Project Status v1_15, Forward
      Roadmap v1_13, and delivery addendum v1_1. No design change; status
      currency for the designer-chat handoff.
v1.9  Added the charter C-DELIV-09 incremental-emission awareness for the
      reviewer role (W3C emits increments then re-packages one final
      deliverable; hold formal acceptance for the package; only delivered work
      survives an interruption). Bumped the controlling charter pin
      v1_19 -> v1_20.
v1.8  Stage 1C position advance + prevailing-source alignment. Immediate
      designer action retargeted from "author the filter-creation scope when
      W3X asks" to "review W3C's Stage 1C Phase 2/3 deliveries" (the scope is
      authored, ratified v1_5, and Phase 1 is accepted). Status pointers,
      dispatch-idiom phrasing, the implementation-spikes list, and the
      first-response block advanced to Stage 1C. Added the Stage 1C scope
      v1_5 and delivery addendum v1_0 to the reading list (items 11/11a,
      CONTROLLING) and bumped the coder-intro pin to v1_14. No design or rule
      change; the design line is unchanged.
v1.7  Coder-review corrections: fixed the line-break-split "future 1B.3
      dispatch table" phrase that a single-line replacement missed (now
      "filter-creation-stage dispatch wiring" - the v1.6 revision note's claim
      to have removed it was premature); completed-stage tense corrections
      (CONFIRMS -> CONFIRMED; FMA expectation to past tense); added the roadmap
      to the reading list for package consistency; cross-pins advanced to the
      new generation (status v1_14, coder v1_13, roadmap v1_12). Version bumped
      per immutable-version discipline.
v1.6  Full reconciliation: the v1.5 pass advanced the headline sections but left
      several later passages stale. This pass fixed the reading-list charter pin
      (v1_16 -> v1_19), replaced the non-exact "(latest version)" reading-list
      forms with exact filenames, rewrote the "Stage 1B.3 will follow / future
      1B.3 dispatch" phrasings (dispatch is now filter-stage work consuming the
      EFFECTIVE record), moved 1B.2/1B.3 out of the unresolved implementation-
      spike list into settled material, and replaced the obsolete "1B.3 delivery
      awaits review / coder chat died" handover note with the accepted-and-
      committed state.
v1.5  Refresh after Stage 1B.3 COMPLETE and committed. Charter pin v1.17 ->
      v1.19 (v1.18 recorded the 1B.3 ratifications; v1.19 the CRLF rule).
      Current position advanced: 1B.3 done, its full proof matrix verified at
      the instruction/byte level; immediate action changed from "review the
      1B.3 delivery" to "author the filter-creation scope". Added the settled-
      detection-contract lesson and the captured-output findstr lesson from the
      1B.3 harness rounds.
v1.4  Refresh after Stage 1B.2 completion and the Stage 1B.3 scope/delivery
      round. Charter v1.16 -> v1.17 (adds G10, the debug-only inclusion
      pattern). Current position advanced: 1B.2 complete and committed; 1B.3
      scoped at v1.3 (resolving W3C reviews B1-B7/P1-P3 then R1-R5) with a
      first W3C delivery in hand awaiting designer review. Immediate action
      changed from "author 1B.2 scope" to "review the 1B.3 delivery". Added
      the G10 three-layer debug-inclusion lesson alongside the 1B.1 export
      lesson. Noted the 1B.3 coder chat died post-delivery.
v1.3  Major reconciliation to the current package (charter v1.10 -> v1.16,
      README v1.2 -> v1.9, plus the decisions record v1.9). Corrected the two
      most dangerous stale reversals: (a) the tiering/float model - replaced
      "FMA excluded from AVX2" and "scalar == SSE4.1 == AVX2 bit-exact float"
      with the NAMED psABI levels used in full + per-type contract (integer
      byte-exact, float differential within tolerance, structural exact); (b)
      added the two-filter Classic-first architecture (reasoning 3.1) and the
      Deblock4-only scope of proper chroma. Added the oracle-construction
      exception (3.7) and removed the circular oracle rule. Reframed Stage 1B.2
      as within-level confirmation (not "feature-closure spikes") and added the
      1B.2/1B.3 boundary. Added OSXSAVE membership vs runtime XGETBV/XCR0.
      Updated the SETTLED/REJECTED buckets accordingly (universal float identity
      and FMA exclusion moved to REJECTED; two-filter and named tiers added to
      SETTLED). Added the decisions record and backend-objects explainer to the
      reading order. Recorded the owed HolyWu-oracle pin (D-CLASSIC-4) and the
      SHA-256 clarification (controlling identity = filename+version; SHA-256 is
      a reviewer convenience). Added the no-package-mixing and de-versioning
      guidance to the version-drift hazard.
v1.2  Stage 1B.1 complete; charter v1.9 -> v1.10 and README v1.1 -> v1.2.
      Rewrote reasoning 3.8 for the corrected G6 corollary (the ban is on
      PE-EXPORT, not the export keyword) with the three falsified mechanisms
      named. Added Deblock4_Toolchain_Findings to the reading order, added
      1B.1 and the @extern anchor mechanism to SETTLED, and removed the
      resolved retention crux from SPIKES. Stage 1B.2 is now active.
v1.1  Updated from v1.0: charter v1.8 -> v1.9 (adds G6); milestone to
      1A.1-complete; 1B.1 active at scope v1.3; added the retention/export
      research package and the MPEG-2 grid/field-DCT knowledge document to the
      reading order; added reasoning 3.8 (G6/no-export) and 3.9 (three DCT
      regimes, midpoint machinery, measured LG behaviour); added G6, the DCT
      regimes, and 1A.1 to the SETTLED bucket; added the forceUndefinedSymbol
      retention crux to the SPIKES bucket.
```

# 9. A note on why this handover matters

The designer seat is where the project's judgement lives. The coder implements a
bounded scope; you guard the whole line. A weak designer handover is therefore
more dangerous to the project than a weak coder one - a confused coder produces a
failing build that W3X catches, but a confused designer can quietly approve a
wrong decision, relax an invariant, or let a measurement question be settled by
argument, and those errors propagate.

The way to be a good successor is not to be clever or to improve the design. It
is to hold the line that is already drawn: verify against source, keep the fact
classifications distinct, make W3X the decider, and doubt smooth agreement -
including your own.

---

*This file preserves designer-session orientation and design reasoning. It is
not an algorithm specification, an invariant source, or a coding scope. The
charter and README prevail wherever this file differs from them.*
