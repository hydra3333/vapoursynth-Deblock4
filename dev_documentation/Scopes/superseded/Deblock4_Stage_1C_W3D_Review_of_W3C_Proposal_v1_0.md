# Deblock4 - Stage 1C W3D Review of W3C Section 9 Proposal

Version: v1.1
Date: 2026-07-31
Reviews: Deblock4_Stage_1C_Scope_Review_and_Section_9_Proposal_W3C_v1_1.md
Against: Deblock4_Scope_Stage_1C_Filter_Creation_v1_1.md; README design spec
   v1.2; charter v1.19.
Encoding: US-ASCII; CRLF.
Status: PROPOSAL ENDORSED with amendments. W3D accepts R1-R6 (they are real
   defects I left in scope v1.1) and endorses the module graph, version
   placement, sweep list, and S1 mechanics with the notes below. Six items go
   to W3X for decision; five README gaps must be settled by W3X before coding.

## 1. Verification W3D performed independently

W3D did not rubber-stamp. What I could check against artifacts I hold, I
checked:

- Tier strings (x86_64_v3_with_avx2 / v2_with_sse41 / v1_baseline): match the
  1B.3 selftest emissions exactly. Correct.
- README parameter surfaces (section 5 of the proposal): verified against
  README design spec v1.2 - strength 0..60, the independent-offset 0..60
  resolved-index rule, grid_mode required-with-no-default and "auto"
  reserved-but-rejected, midpoint_threshold_scale range 0.0..1.0, and the
  custom luma/chroma step names. All read accurately from the README, nothing
  invented.
- The five README gaps: GAP-P1 (midpoint default - README says "empirically
  selected", no default pinned), GAP-P3 (planes validation detail), GAP-P4
  (exact error-message table - README gives "for example" wording, not a
  stable table), GAP-P5 (plugin identifier absent from README) are all REAL.
  GAP-P2 (custom-step numeric range) - README section 3.14 defines the names
  but I did not find a settled numeric range; I concur it is a gap.

CURRENT-TREE ENUMERATION - NOW INDEPENDENTLY VERIFIED (v1.1 update). W3X
supplied the real post-1B.3 tree (src.zip). W3D checked section 4 against it
directly:
- DLL root IS src/backend_retention_anchor.zig; it imports dll_probe,
  backend_probe_generic, backend_probe_scalar, and @extern-anchors
  deblock4_backend_probe_sse41_marker and deblock4_backend_probe_avx2_marker -
  exactly as the coder stated.
- All six first-class retain files (4.2) are present.
- CRITICAL retention proof: the selftest imports ONLY
  cpu_capability_detection.zig (plus std) - no probe - so retiring the probes
  leaves it functional; and cpu_capability_detection.zig imports only
  first-class modules (config, print helpers, the two gated modules) with ZERO
  probe dependencies, so it survives the sweep untouched. The detection
  inspection object is built as its own standalone target in build.zig (its
  own step + drift checks). The coder's separation of the inspection object
  from backend-probe scaffolding is therefore CORRECT and provable.
- Every one of the ten retire-candidates has ZERO first-class importers -
  each is genuinely scaffolding. (backend_retention_anchor.zig is on the list
  because it is the OLD root, replaced by the proposed deblock4_plugin.zig -
  the anchor-relocation the sweep performs.)
The section 4 enumeration is accurate in every checkable particular. The N6
caveat below is consequently LIFTED; W3X need only confirm the HEAD SHA for the
record, not re-audit the file list.

## 2. R1-R6: W3D accepts all six as genuine scope defects

These are contradictions I left in scope v1.1. The coder is right to refuse to
code against them. I will fold the corrections into scope v1.2.

- R1 (D-2 minimal vs D-7 full signature): ACCEPT. D-2's "(clip,
  backend=auto)" wording is stale; D-7-amended governs. v1.2 restates D-2 as
  "both filters register now with their full approved signatures".
- R2 (D-3 by-reference vs property writes need copyFrame): ACCEPT, and this is
  the sharpest catch. The invariant I meant is "pixel pass-through; no
  algorithmic plane construction; zero plane writes" - NOT "addFrameRef-only
  return". Writing properties requires a writable frame via copyFrame, which
  copies plane POINTERS/metadata, not pixel computation. v1.2 pins the exact
  ownership path the coder wrote (arInitial requests; arAllFramesReady obtains;
  copyFrame for the writable output; only properties change; references
  released/transferred on every path). Note this makes E1's "checksum equals
  input" still hold: copyFrame preserves plane data identically.
- R3 (section 6 still says "both debug seams"): ACCEPT. v1.2 says all three
  (force-down, verbose-detection, lifecycle-trace).
- R4 (section 9 must state W3X approval is required before transformation):
  ACCEPT and REINFORCE. This is exactly W3X's standing instruction: "at this
  stage all proposed module filenames [and the version-module placement] are
  subject to W3X approval." W3D review is necessary but NOT sufficient
  authority to transform the tree; only W3X approval authorises create/rename/
  relocate/delete. v1.2 makes the five-step sequence binding.
- R5 (B1 understates test inventory): ACCEPT. v1.2: all existing tests plus all
  approved 1C resolution AND parameter-validation tests; report the observed
  total rather than pinning a number in advance.
- R6 (permanent dispatch-record type lacks a settled callable ABI): ACCEPT, and
  the coder's interpretation is the correct one. Inventing a "permanent"
  function-pointer ABI now - before any backend function signature exists -
  would violate the spirit of C-STY-09/10 (a permanent name over a provisional
  shape). The right permanent artifact today is the pure data record
  (BackendSelection: requested_backend, selected_tier, plus whatever
  provenance diagnostics/properties need). Per-filter callable DispatchTable
  types arrive at 2C/2D when the processing-function ABI is settled. This
  matches D-5's true intent: the CHOICE is made/stored/proven now; the CALL is
  wired later. v1.2 restates D-5 in these terms.

## 3. Module graph: ENDORSED, with notes

The proposed graph is clean, single-homed, and respects the pure/VS-facing
split (C-1C-2) and the thin-root rule (C-1C-3). W3D endorses it to W3X with
these notes:

- N-3a (endorse): the DLL/VS-facing/pure three-layer split is correct. Pure
  modules (backend_resolution, *_parameters, filter_parameter_common,
  deblock4_version) import no VapourSynth and are selftest/test-reachable -
  this is exactly C-1C-2 and is what makes the selftest able to exercise
  resolution and parameter validation without a VS core.
- N-3b (endorse dedicated version module): deblock4_version.zig as a dedicated
  pure module (NOT an extension of deblock4_config.zig) is the better call.
  Version identity is independent of generated debug build options; build.zig,
  DLL, selftest, tests, properties, and trace can all consume it without
  pulling in the config switchboard. This honours C-1C-7's single-home intent.
  Endorsed to W3X.
- N-3c (endorse activation-reason modules): filter_ar_initial /
  filter_ar_all_frames_ready / filter_ar_error match C-1C-3's named set, and
  placing future 2C/2D processing dispatch in all_frames_ready is correct.
- N-3d (watch item, not a blocker): vapoursynth_filter_helpers.zig risks
  becoming a dumping ground; the coder already flagged this. v1.2 keeps it but
  requires each helper added to it to have a stated reason - a soft C-STY-09
  guard.
- N-3e (dependency direction): the forbidden-direction list (cpu_capability_
  detection imports no filter module; pure modules import no VS; frame-path
  modules import neither backend_resolution nor cpu_capability_detection) IS
  the S1 no-per-frame-branch invariant expressed structurally. Endorsed, and it
  strengthens S1 (section 4).

## 4. S1 proof mechanics: ENDORSED, strengthened

The coder's three-part S1 (source-dependency scan + object/symbol proof +
runtime-trace proof) is stronger than what scope v1.1 sketched, and W3D
endorses it. Notes:

- The object/symbol proof (dumpbin /SYMBOLS + disasm on filter_callbacks and
  the three ar_* objects showing zero reference to detection/resolution/
  DEBLOCK4_FORCE_DOWN symbols) is the right mechanical, non-eyeball gate -
  same spirit as the 1B.3 disasm gates, correctly scaled.
- The noinline offer for the creation-side resolution function is ACCEPTABLE as
  a proof aid (it runs once per instance; performance is irrelevant). W3D
  approves it as an option the coder may use to make the symbol proof crisp;
  not mandatory if the proof is clean without it.
- Addition W3D requires: the source-dependency scan must be whitespace/multi-
  line tolerant (the lesson from the doc-audit rounds - a wrapped import or a
  line-split reference must not slip past a single-line grep). State the scan
  as substring/symbol based, not findstr /X.

## 5. Items W3D refers to W3X for decision

W3D has a recommendation on each; W3X decides.

```text
N1  All module filenames in section 7. W3D endorses the set as proposed.
N2  deblock4_version.zig as a dedicated module. W3D endorses (N-3b).
N3  Version values: semantic 0.1.0-dev, stage marker 1C, identity
    0.1.0-dev+1C, VS packed 0.1. W3D endorses; these match C-1C-7 and the
    existing 0.1.0-dev string. W3X confirms the packed-version scheme.
N4  Plugin identifier com.hydra3333.deblock4. W3D endorses (reverse-DNS,
    matches the repo owner); this resolves GAP-P5. W3X confirms.
N5  build_1C_v1.bat and the two .vpy filenames. W3D endorses.
N6  The full retirement list (section 4.3/4.4). W3D ENDORSES - now verified
    against the real tree (section 1): all ten candidates have zero
    first-class importers, and the detection inspection object + drift checks
    are provably RETAINED (separate standalone build target, no probe
    dependency). W3X confirms the HEAD SHA for the record.
N7  BackendSelection now / callable DispatchTable at 2C/2D. W3D endorses
    (R6).
N8  S1 proof mechanics incl. optional noinline. W3D endorses (section 4).
```

## 6. README gaps W3X must settle BEFORE coding (D-7 gap rule)

These block D-7 and must be settled by W3X (not invented by the coder). W3D
offers a starting recommendation on each to speed settlement; these are
suggestions for W3X, not decisions:

```text
GAP-P1  midpoint_threshold_scale default. README says "empirically selected".
        W3D suggestion: since 1C does no pixel work, register it OPTIONAL with
        NO default and defer the empirical default to 2D where the oracle can
        justify it; OR pin a placeholder default W3X is comfortable stating
        now. W3X chooses.
GAP-P2  custom luma/chroma step numeric range and zero/negative rule.
        W3D suggestion: require >= 1 (a zero/negative grid step is
        meaningless), upper bound = frame dimension at creation if cheaply
        checkable, else a settled constant. W3X pins the exact rule.
GAP-P3  planes validation: accepted indices by format, duplicates, ordering,
        empty array, invalid-plane behaviour. W3D suggestion: accept indices
        valid for the clip's format; reject out-of-range with the README
        "state the permitted range" message; treat empty as "no planes
        selected" error OR as default-all (W3X picks one); reject duplicates.
GAP-P4  exact creation-error message table. W3D suggestion: the coder drafts
        the full table from the README's required MEANINGS as part of the
        delivery, W3D reviews it, W3X ratifies - i.e. settle the table at
        delivery review rather than blocking now, since the messages are
        derived from already-settled semantics. W3X confirms this approach or
        asks for the table up front.
GAP-P5  plugin identifier: resolved by N4 (com.hydra3333.deblock4) on W3X
        approval.
```

W3D note on sequencing: GAP-P1/P2/P3 genuinely gate parameter VALIDATION code
and should be settled before coding. GAP-P4 (messages) can reasonably settle at
delivery review without blocking, IF W3X agrees. GAP-P5 is a one-line approval.

## 7. What W3D will do next

On W3X's decisions, W3D issues scope v1.2 folding in:

```text
- R1-R6 corrections (section 2);
- the endorsed module graph, version placement, sweep list, and S1 mechanics
  as ratified names/decisions (replacing the "proposed" placeholders with
  W3X-approved values);
- the settled GAP-P1..P5 resolutions;
- the reinforced R4 authority sequence (W3X approval required before any tree
  transformation);
- the multi-line-tolerant scan requirement for S1.
```

Then the coder is cleared to produce the Stage 1C delivery against v1.2.

## 8. One line for W3X

The coder's proposal is strong and honest - it caught six real contradictions I
left in the scope, read the README accurately, invented nothing, and surfaced
five genuine gaps; W3D endorses the module graph/version/sweep/S1 and needs
from you: approval of N1-N8 and settlement of GAP-P1..P5 (P4 optionally at
delivery), the section-4 tree enumeration is now W3D-verified against the real tree
(all retirements safe; the detection inspection object provably retained), so
only the HEAD SHA needs recording.
