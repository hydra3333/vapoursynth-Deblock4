# Deblock4 - W3C Review of Project Status v1.16

**Version:** 1.0
**Date:** 2026-08-01
**Author:** W3C
**Reviews:** `Deblock4_Project_Status_v1_16.md` against tonight's ratified and
committed documentation state through charter v1.26 and coder introduction
v1.19.
**Encoding:** US-ASCII; CRLF.
**Status:** W3C proposal for W3D verification and W3X decision.

---

# 1. Disposition

Project Status v1.16 remains a strong historical proof record, but its live
orientation and immediate-action layers are materially stale. It should not be
the current status document without revision.

W3C proposes `Deblock4_Project_Status_v1_17.md`. The proposal changes status,
process currency, and cross-references only. It does not change the Deblock4
algorithm, Stage 1C scope, phase boundary, acceptance criteria, or Part 1
invariants.

# 2. Required corrections

## C1 - Current accepted baseline is Phase 2, not Stage 1B.3

v1.16 still calls the accepted Stage 1B.3 infrastructure the current committed
baseline. Phases 1 and 2 of Stage 1C are accepted and committed. The proposed
v1.17 identifies Stage 1C Phase 2 as the current accepted baseline while
retaining Stage 1B.3 as its proven infrastructure foundation.

## C2 - Phase 3a is delivered, not future

Several live passages say Phase 3a is "about to be received" or that its frame
path and registration "arrive" later. The correct state is:

```text
Phase 1:  accepted and committed
Phase 2:  accepted and committed
Phase 3a: W3C delivery v1.0 exists; awaiting W3D static review,
          W3X toolchain validation, and W3X acceptance
Phase 3b: not released
```

The proposal applies that state consistently to the opening, milestone table,
stage map, current-work section, package list, and immediate action.

## C3 - Accepted code and candidate code must not be conflated

The Phase 3a delivery contains real plugin registration, API4 frame mechanics,
copyFrame pass-through, properties, tier-switch bodies, common error handling,
and lifecycle tracing, but none is accepted or committed yet. v1.17 therefore
uses three distinct categories:

```text
accepted/committed baseline    Stage 1C Phase 2
current candidate              Phase 3a delivery v1.0
not released                   Phase 3b
```

This avoids both understating delivered work and prematurely claiming proof.

## C4 - The Phase 3a review set is current and mixed-authority

v1.16 names briefing v1.0 and describes the set without preserving its members'
different authority. The current set is:

```text
scope v1_5       ratified and binding design authority
addendum v1_1    binding delivery-order/boundary clarification
briefing v1_2    informative review guidance at the documentation root
```

The set must be read together under charter 2.3a, but read-together status does
not make every member controlling.

## C5 - Record the charter 2.3b compatibility/grandfathering decision

Per the W3D-verified/W3X-directed decision, Project Status is the one-line record
for the first 2.3b instance:

```text
scope v1_5 + addendum v1_1 / charter v1.26: compatible, grandfathered to next issuance, W3X 2026-08-01.
```

The proposal explains the consequence: historical pins and the missing later
reminder block are not a STOP condition; the prevailing charter governs and the
reminder applies at next natural issuance.

## C6 - Cross-reference currency

The live package layer is advanced to:

```text
AI_Charter_and_Invariants_Card_v1_26.md
Deblock4_Forward_Roadmap_v1_13.md
Deblock4_Project_Status_v1_17.md
111_New_Chat_Introduction_for_Coder_v1_19.md
111_New_Chat_Introduction_for_Designer_v1_13.md
Deblock4_Stage_1C_Phase_3a_Designer_Briefing_v1_2.md
Deblock4_Scope_Header_CDELIV09_Reminder_Block_v1_1.md
```

Tiering Decisions v1.10, README v1.9, and Concise Summary v1.2 remain correct.

## C7 - Starting-base discipline is stale

v1.16 requires an exact starting commit/HEAD in several live passages. The
settled workflow uses the prevailing branch-main source or an exact source tree
supplied by W3X. The proposal removes the obsolete commit-id gate while
preserving exact-base discipline.

## C8 - The "not implemented" section is stale

v1.16 lists real plugin registration, frame path, frame properties, and
per-instance dispatch consumption as simply unimplemented. Those items now
exist in the unaccepted Phase 3a candidate. The proposal separates candidate
work, unreleased Phase 3b work, and genuinely absent algorithm work.

## C9 - Preserve the authorised copyFrame pass-through exception

v1.16 says no pixel-producing frame path, plane sharing, or copy may be accepted
before the scalar oracle. That overstates the rule and conflicts with Stage 1C's
settled inert pass-through. The proposal states:

```text
Stage 1C may use the standard API4 copyFrame idiom to produce a writable,
byte-identical pass-through frame with plane data unchanged. It performs no
deblocking or algorithmic plane construction.
```

The post-oracle differential rule remains unchanged for later work.

## C10 - G10 and G6 wording

The Phase 3a candidate adds `enable_trace_lifecycle` as the third G10 seam. The
proposal records it without rewriting the historical 1B.3 fact that only the
earlier seams existed then.

The proposal also removes the live implication that gated export-table absence
is merely structural. The operative protection is the standing loud-failing
`dumpbin /EXPORTS` gate under charter G6.

## C11 - Immediate action is review, not new implementation

v1.16 directs registration, sweep, and dispatch implementation. That would pull
Phase 3b forward and ignore the existing Phase 3a candidate. v1.17 instead
requires:

```text
W3D static review -> W3X toolchain validation -> bounded corrections if any ->
W3X acceptance -> explicit Phase 3b release
```

# 3. Deliberately unchanged

The proposal does not alter:

- any Stage 1A/1B accepted evidence;
- the Stage 1C design or 3a/3b boundary;
- Classic-first sequencing;
- named psABI tiering, G5, G6, G7, G8, G9, or G10;
- the scalar-oracle construction exception or later differential contract;
- W3X's sole authority for builds, runs, acceptance, commits, and pushes.

# 4. Files supplied for verification

```text
Deblock4_Project_Status_v1_17_W3C_PROPOSAL.md
Deblock4_Project_Status_v1_16_to_v1_17_W3C_PROPOSAL.diff
```

The diff is generated directly from the original v1.16 in tonight's
`dev_documentation(10).zip`, not from an intermediate draft.

# 5. Recommendation

W3D should verify the proposal against:

```text
AI_Charter_and_Invariants_Card_v1_26.md
111_New_Chat_Introduction_for_Coder_v1_19.md
111_New_Chat_Introduction_for_Designer_v1_13.md
Scopes/Deblock4_Scope_Stage_1C_Filter_Creation_v1_5.md
Scopes/Deblock4_Stage_1C_Delivery_Plan_Addendum_v1_1.md
Deblock4_Stage_1C_Phase_3a_Designer_Briefing_v1_2.md
Deblock4_Scope_Header_CDELIV09_Reminder_Block_v1_1.md
Deblock4_Stage_1C_Phase_3a_W3C_delivery_v1_0.zip
```

If verified and approved, rename the proposal to:

```text
Deblock4_Project_Status_v1_17.md
```

Then supersede v1.16. No design or invariant change.
