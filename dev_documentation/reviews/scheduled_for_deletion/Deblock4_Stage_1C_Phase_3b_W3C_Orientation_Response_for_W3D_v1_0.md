# Deblock4 - Stage 1C Phase 3b W3C Orientation Response for W3D

**Version:** 1.0  
**Date:** 2026-08-02  
**Author:** W3C (coder)  
**Route:** W3C -> W3X -> W3D  
**Status:** Orientation response only. No correction delivery or other implementation work has begun.  
**Encoding:** US-ASCII; CRLF.

---

# 1. Purpose

This note records W3C's considered orientation after reading the supplied
Deblock4 package and inspecting the exact Phase 3b v1_12-applied source and
evidence base.

It responds to section 6 of
`Deblock4_Stage_1C_Phase_3b_Coder_Resume_Brief_v1_1.md` and additionally states
the level and limits of W3C's orientation, especially in relation to the
charter and the single current correction.

This is not a correction delivery, a scope amendment, a proposed criterion
change, or authority to begin later work.

# 2. Documents and artifacts held

## 2.1 Controlling and binding authorities

W3C holds and has oriented to:

```text
AI_Charter_and_Invariants_Card_v1_26.md
    filename version: 1.26
    internal version: 1.26
    status: W3X-ratified controlling charter

README_Deblock4_Design_Spec_v1_9.md
    filename revision: 1.9
    internal design revision: 1.9
    status: controlling technical specification

Deblock4_Scope_Stage_1C_Filter_Creation_v1_5.md
    filename version: 1.5
    internal version: 1.5
    status: ratified and binding Stage 1C design authority

Deblock4_Stage_1C_Delivery_Plan_Addendum_v1_1.md
    filename version: 1.1
    internal version: 1.1
    status: binding delivery order and phase-boundary authority
```

`Deblock4_Project_Status_v1_18.md` records the charter section 2.3b
compatibility decision that Stage 1C scope v1.5 and addendum v1.1 remain
compatible with charter v1.26 and are grandfathered until their next issuance.
I therefore do not treat their historical charter pins as a package mismatch.

## 2.2 Prevailing current-state direction

```text
Deblock4_Stage_1C_Phase_3b_Coder_Resume_Brief_v1_1.md
    filename version: 1.1
    internal version: 1.1
    author: W3D, issued by W3X
    authority here: prevailing volatile current-state and directed-correction
                    brief
```

I understand that this Resume Brief prevails over older or broader orientation
material wherever current Phase 3b state differs.

## 2.3 Complete Phase 3a read-together review set

The complete charter-2.3a set is held:

```text
Deblock4_Scope_Stage_1C_Filter_Creation_v1_5.md
Deblock4_Stage_1C_Delivery_Plan_Addendum_v1_1.md
Deblock4_Stage_1C_Phase_3a_Designer_Briefing_v1_2.md
```

I understand that read-together status does not equalise authority: the scope
is the design authority, the addendum governs delivery order and boundaries,
and the briefing is informative review guidance.

## 2.4 Durable orientation and supporting records

W3C also holds and has used as applicable:

```text
111_New_Chat_Introduction_for_Coder_v1_20.md
Deblock4_Project_Status_v1_18.md
Deblock4_Concise_Project_Summary_v1.2.md
Deblock4_Verification_And_Tiering_Decisions_v1_10.md
Deblock4_S1B1_Retention_Export_Research_Package_v1_0.md
Deblock4_Toolchain_Findings_v1_2.md
Deblock4_Debug_Module_Inclusion_Pattern_v1_1.md
Deblock4_DISPATCH_RELATED_Backend_Objects_Explained_v1_3.md
Deblock4_Forward_Roadmap_v1_15.md
Deblock4_Scope_Header_CDELIV09_Reminder_Block_v1_1.md
```

The grid/field-DCT knowledge document is held but deliberately deferred because
the current correction contains no pixel, grid, field-DCT, or deblocking work.

## 2.5 Exact source, delivery, runner, harness, and evidence base

W3C holds:

```text
src(43).zip
    W3X-supplied repository-main production source at the Phase 3b
    v1_12-applied state

Deblock4_Stage_1C_Phase_3b_W3C_delivery_v1_12.zip
Deblock4_Stage_1C_Phase_3b_W3C_Delivery_Manifest_v1_12.md
Deblock4_Stage_1C_Phase_3b_v1_12_CURRENT_RESUME_INSTRUCTIONS.md

build_1C_v1.bat
tests/stage_1c_classic_passthrough.vpy
tests/stage_1c_deblock4_passthrough.vpy
```

The separately supplied copies of the standing runner and both `.vpy` harnesses
were checked byte-for-byte against the copies in delivery v1_12 and are
identical. The earlier package-completeness concern is therefore resolved.

The source package also contains the preserved v1_12 inspection outputs,
including the Debug DLL export table and the other partial evidence identified
by the Resume Brief.

# 3. Considered level of W3C orientation

I consider myself **fully oriented and ready for the single bounded Phase 3b
v1_13 correction described by Resume Brief v1.1**, subject to W3X confirming
this orientation and directing me to proceed.

That assessment means:

```text
- I know which documents control, which bind delivery order, which are
  informative, and which brief prevails on current state.
- I understand the W3X/W3D/W3C role separation and will not cross it.
- I understand the applicable charter invariants, coding boundaries, proof
  obligations, and mechanical delivery discipline.
- I have inspected the actual marker declarations and preserved export-table
  evidence in the supplied v1_12 base.
- I understand exactly why the present failure is a source defect rather than
  a harness defect.
- I understand the smallest directed source correction and the proof that must
  follow it.
```

This orientation is intentionally bounded. It does **not** claim that I am
released or oriented to implement rider Stage 1C.1, Stage 2C/2D algorithmic
work, or any other later task. A future task requires its own W3X release and
the applicable complete package.

# 4. Charter understanding relevant to the current step

I have read the charter as the governing process and invariant source. The
following provisions are load-bearing for this correction.

## 4.1 Roles, authority, and STOP discipline

- W3C implements one supplied bounded scope or correction; W3C does not invent
  design, choose unstated defaults, alter invariants, or release later work.
- All W3C/W3D traffic passes through W3X.
- W3X alone owns the repository, authoritative builds and runs, acceptance,
  commits, pushes, and release of the next step.
- A material ambiguity, base mismatch, authority conflict, or apparent need to
  violate an invariant is STOP-class. W3C reports it rather than selecting a
  plausible interpretation.
- Under I7, W3C cannot silently weaken or alter a criterion that judges W3C's
  own work. Any proposed change would have to name W3C as proposer, use a
  different independent verifier, and receive the required W3X normative
  adoption.

## 4.2 G5 remains intact

The current Stage 1C work executes no real gated v2/v3 algorithm backend.
Gated instructions may be present only behind the already proved complete
capability guard. No environment variable, debug option, registration path,
test path, import thunk, static initialiser, or known-capable-host assumption
may bypass that guard.

The present correction does not change the ACTUAL/EFFECTIVE capability model,
feature contracts, tier selection, or any backend object.

## 4.3 G6 is the decisive invariant

G6 requires safety properties to rest on explicit or structural mechanisms,
not on unrequested implicit toolchain behaviour.

I understand and will preserve the charter's three distinct properties:

```text
EMISSION
    code exists in a compilation unit

LINKAGE
    a symbol is visible across the linker seam

PE EXPORT
    a symbol appears in the DLL .edata public export table
```

They must not be conflated.

For the separately compiled Stage 1B.1 gated backend objects, object-mode
`export fn` remains the settled and correct emission/linkage mechanism.
Object-mode use does not itself create a PE export, and the DLL root reaches
those objects through internal `@extern` address anchors behind guarded
dispatch.

That settled object mechanism does not justify `export fn` for a function
compiled in the DLL root graph. In DLL compilation, the keyword supplies the
dllexport-class instruction and creates a public PE-export doorway.

## 4.4 G10 remains a three-layer obligation

The three debug seams remain governed by all three G10 layers:

```text
1. source-visible conditional import as the primary omission boundary;
2. same-gate protected uses and inner feature gates as defence in depth;
3. standing loud-failing proof over raw strings, PE exports, and disassembly.
```

The current failure occurred in layer 3 and is valid evidence that the source
does not yet satisfy G6. A passing ReleaseSafe/ReleaseFast omission proof does
not excuse a Debug DLL public export.

## 4.5 Coding and delivery boundaries

I will preserve:

- Stage 1C's inert byte-identical pass-through behaviour;
- the accepted creation, frame, property, lifecycle, and tier-selection logic;
- the completed C-STY-10 sweep and one-way dependency result;
- all W3X-owned files unless W3X expressly authorises a change;
- US-ASCII and repository CRLF;
- C-DELIV-01 through C-DELIV-09, including exact base, mechanical application,
  byte verification, manifest, hashes, diff, validation instructions, and an
  honest distinction between sandbox inspection and W3X's authoritative run.

This correction is expected to be small enough for one final integrated
delivery; no incremental emission is presently necessary.

# 5. Current Phase 3b state

I understand the current state as follows:

```text
Stage 1C Phases 1, 2, and 3a:
    accepted and committed

Stage 1C Phase 3b:
    released and applied through delivery v1_12

v1_12 matrix:
    end-to-end proof surface operational
    every gate passes except one final Debug DLL export-exclusion check

next delivery number:
    Deblock4_Stage_1C_Phase_3b_W3C_delivery_v1_13.zip
```

The supplied Debug `Deblock4_exports.txt` proves that the production DLL
currently exports five names:

```text
VapourSynthPluginInit2
_DllMainCRTStartup
deblock4_force_down_marker_FD00D001
deblock4_lifecycle_trace_marker_1C71FE01
deblock4_verbose_detection_marker_DD00D001
```

The last three are genuine PE exports from the Debug DLL.

# 6. Understanding of the open G6 finding

The verified source declarations are:

```text
src/force_down_debug.zig
    pub export fn deblock4_force_down_marker_FD00D001() u32

src/print_diag_helper_functions.zig
    pub export fn deblock4_verbose_detection_marker_DD00D001() u32

src/lifecycle_trace_debug.zig
    pub export fn deblock4_lifecycle_trace_marker_1C71FE01() u32
```

Because these functions are compiled as part of a Windows DLL compilation,
`export fn` makes them dllexport candidates and places them in the DLL public
export table.

This is a real G6 violation because a public export is an externally callable
doorway to gated debug code. It is outside the intended conditional-import,
enabled-path, and guarded-dispatch structure.

The failing gate must not be relaxed, suppressed, renamed around, converted
into a warning, or taught to accept these exports because:

1. the export rows are real, not a false positive;
2. the gate enforces the exact G6 property it was designed to enforce;
3. weakening the gate would preserve the unsafe public doorway;
4. a toolchain-sensitive safety property requires continuous loud-failing
   verification;
5. W3C has no authority to alter its own acceptance criterion, and I7 would
   independently prohibit silent self-verification of such a change.

The correction belongs at the source layer.

# 7. Planned bounded correction

Subject to W3X confirming orientation, I will first make only these three
production transformations:

```text
src/force_down_debug.zig
    pub export fn deblock4_force_down_marker_FD00D001()
    ->
    pub fn deblock4_force_down_marker_FD00D001()

src/print_diag_helper_functions.zig
    pub export fn deblock4_verbose_detection_marker_DD00D001()
    ->
    pub fn deblock4_verbose_detection_marker_DD00D001()

src/lifecycle_trace_debug.zig
    pub export fn deblock4_lifecycle_trace_marker_1C71FE01()
    ->
    pub fn deblock4_lifecycle_trace_marker_1C71FE01()
```

No marker value, diagnostic text, conditional import, debug option, capability
logic, tier logic, frame path, property path, lifecycle ordering, test case,
or release gate will be changed merely to obtain a pass.

No runner change is expected.

# 8. Per-marker retention and observability verification

De-exporting is necessary but is not by itself sufficient. I will verify each
marker independently after the change.

## 8.1 Force-down marker `FD00D001`

Required Debug evidence:

```text
- `DEBLOCK4_FORCE_DOWN_DEBUG_MARKER_FD00D001` remains present on the applicable
  enabled runtime path and raw-string surface;
- the marker function or an equivalent explicit retained anchor remains
  observable in the required Debug symbol evidence;
- immediate `0xFD00D001` remains observable in the applicable Debug
  disassembly evidence;
- `deblock4_force_down_marker_FD00D001` is absent from the DLL PE export table.
```

## 8.2 Verbose-detection marker `DD00D001`

Required Debug evidence:

```text
- `DEBLOCK4_VERBOSE_DETECTION_MARKER_DD00D001` remains present on the enabled
  runtime path and raw-string surface;
- the marker function or an equivalent explicit retained anchor remains
  observable in the required Debug symbol evidence;
- immediate `0xDD00D001` remains observable in the applicable Debug
  disassembly evidence;
- `deblock4_verbose_detection_marker_DD00D001` is absent from the DLL PE
  export table.
```

## 8.3 Lifecycle marker `1C71FE01`

Required Debug evidence:

```text
- `DEBLOCK4_LIFECYCLE_TRACE_DEBUG_MARKER_1C71FE01` remains present on the
  enabled runtime path and raw-string surface;
- the existing direct self-test call remains valid;
- the marker function or an equivalent explicit retained anchor remains
  observable in the required Debug symbol evidence;
- immediate `0x1C71FE01` remains observable in the applicable Debug
  disassembly evidence;
- `deblock4_lifecycle_trace_marker_1C71FE01` is absent from the DLL PE export
  table.
```

If any marker loses required retention after `export` is removed, I will use
the narrowest explicit call or address-taken anchor on that marker's already
enabled path. I will not restore `export` in the DLL compilation and will not
create an unconditional import or call.

Any consequential change beyond the three declaration edits will be justified
by the observed per-marker evidence and identified explicitly in delivery
v1.13.

# 9. Expected correction result

The Debug DLL export table must contain only:

```text
VapourSynthPluginInit2
_DllMainCRTStartup
```

At the same time:

```text
- all three Debug G10 positive controls remain live;
- ReleaseSafe remains unchanged and clean on all G10 absence surfaces;
- ReleaseFast remains unchanged and clean on all G10 absence surfaces;
- all standing unit, selftest, vspipe, structure, sweep, EOL, version, negative,
  and export gates remain green;
- the complete matrix reaches:
  B1 B2 G1 G2 E1 E2 E3 E4 E5 E6 V1 S1 S2 S3 N1 PASS
- the runner reaches:
  STAGE 1C_v1 FULL PROOF MATRIX COMPLETED SUCCESSFULLY
```

Only W3X's real toolchain run and reported outputs may establish project PASS.
W3C may inspect and package the correction but will not claim authoritative
execution or acceptance.

Delivery v1.13 will follow the established v1_12 conventions: exact changed
files, fail-closed applied-state preconditions, byte verification, CR-at-EOL
diff gate, manifest, SHA256SUMS, diff from the v1_12-applied state, and the
resume helper.

The manifest will identify the DLL-compilation `export fn` versus object-mode
`export fn` result as a candidate for W3D's later Toolchain Findings update.
That documentation follow-up is not part of this production correction.

# 10. Hold point and later work

I confirm that I will not begin:

```text
- rider Stage 1C.1;
- Stage 2C or Stage 2D;
- any pixel, grid, DCT, plane-construction, or deblocking work;
- documentation reconciliation;
- unrelated cleanup, refactoring, or proof-criterion changes;
- any other project work.
```

I will remain on the Phase 3b correction until:

1. W3X confirms this orientation and directs preparation of delivery v1.13;
2. W3D reviews the resulting correction;
3. W3X performs the authoritative run and reports the results;
4. the correction and Phase 3b are accepted;
5. W3X explicitly directs the next bounded step.

# 11. Questions for W3D

**None.**

The previously identified document-set and runner/harness questions were
resolved by the additional supplied files and byte-for-byte comparison against
delivery v1_12. I see no remaining design ambiguity or package mismatch that
requires W3D clarification before W3X decides whether to authorise the bounded
v1.13 correction.

---

*End of W3C orientation response.*
