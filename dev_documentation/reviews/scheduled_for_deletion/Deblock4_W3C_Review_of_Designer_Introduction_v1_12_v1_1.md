# W3C Review - 111_New_Chat_Introduction_for_Designer_v1_12

## Disposition

The document remains an excellent continuity handover in substance, especially its preserved design reasoning, source-verification discipline, fact classifications, and designer-specific hazards.

However, v1.12 should not be used as the new designer's live bootstrap without revision. Its orientation layer is stale in several load-bearing places, and one authority classification is materially wrong.

W3C proposes v1.13. No algorithm, architecture, invariant, or Phase 3a design change is proposed.

## Required corrections

### C1 - Prevailing document currency (Tiering v1.10 now confirmed)

After accounting for the newly supplied Tiering Decisions v1.10, the v1.12 reading path contains these stale live references:

```text
AI_Charter_and_Invariants_Card_v1_22.md
Deblock4_Project_Status_v1_15.md
Scopes/Deblock4_Stage_1C_Phase_3a_Designer_Briefing_v1_0.md
111_New_Chat_Introduction_for_Coder_v1_13.md   (later section 7)
```

The corrected prevailing set contains:

```text
AI_Charter_and_Invariants_Card_v1_23.md
Deblock4_Verification_And_Tiering_Decisions_v1_10.md
Deblock4_Project_Status_v1_16.md
Deblock4_Stage_1C_Phase_3a_Designer_Briefing_v1_2.md
111_New_Chat_Introduction_for_Coder_v1_18.md
```

The Phase 3a briefing is at the documentation root, not under `Scopes/`.

The newly supplied Tiering Decisions v1.10 resolves the earlier package omission; the introduction's v1.10 pin was correct and is retained.


### C2 - Phase 3a status

v1.12 says W3X is "about to provide" the Phase 3a delivery. That is now stale.

The correct state is:

```text
Phase 1: accepted and committed
Phase 2: accepted and committed
Phase 3a: W3C delivery v1.0 produced; awaiting W3D static review,
          W3X toolchain validation, and W3X acceptance
Phase 3b: not released
```

### C3 - The Phase 3a review set has mixed authority

v1.12 labels the complete three-document set `CONTROLLING` and calls all three documents "the authority".

That is incorrect. Charter 2.3a requires the declared set to be read together, but does not erase each member's declared status:

```text
scope v1.5       ratified and binding design authority
addendum v1.1    binding delivery-order/boundary clarification
briefing v1.2    informative review guidance; not a scope or rule change
```

The revised wording says `MIXED AUTHORITY` and preserves the hierarchy stated by the members themselves.

### C4 - Creation-callback "body unchanged" shorthand is superseded

v1.12 repeats the over-broad instruction that the creation body is otherwise unchanged.

The Phase 3a Designer Briefing v1.2 settled the precise rule:

```text
- exact translated VSPublicFunction C-ABI signature;
- immediate validated rebinding to idiomatic locals;
- accepted parsing, validation, tier-selection, allocation, ownership-transfer,
  and filter-construction logic preserved;
- required debug-only lifecycle enter/successful-exit trace calls authorised.
```

The complete function is therefore not byte-identical. The computational and ownership logic is preserved.

### C5 - Charter v1.23 continuity and I7 are absent

The successor introduction must now orient W3D to:

```text
- W3D as a continuity-bearing AI role, not one immortal chat;
- I7 proposer/different-party-verifier provenance for self-affecting criteria;
- W3X retaining normative adoption and phase-release authority;
- W3X's current instruction that the first several successor-W3D scopes and
  findings receive heightened W3C continuity scrutiny.
```

The heightened review is a transition risk-control measure, not a transfer of W3D authority to W3C.

### C6 - Version-set wording needs one important qualification

The v1.12 version-currency section discusses pairs but does not clearly state the consequence relevant to this review:

```text
Read-together status does not equalise authority.
```

The v1.13 proposal adds that explicitly.

### C7 - Later status and first-response blocks were stale

Sections 6.3, 7 and 8 still described Phase 3a as not yet delivered, pinned charter v1.22, and referenced coder introduction v1.13.

Those passages are reconciled to the current package and the first response now requires the successor to identify the complete mixed-authority review set and the exact Phase 3a state.

### C8 - Document-review handoff preference

W3X has requested that reviewed documentation be returned as:

```text
1. a complete revised .md file; and
2. a unified diff from the original document-set version to the final agreed version.
```

The proposal records this as a current W3X preference to re-confirm if the workflow changes.

## Separate package inconsistency - charter v1.23 metadata

The file named `AI_Charter_and_Invariants_Card_v1_23.md` in the updated ZIP still says in its internal Status and v1.23 revision heading that it is a proposal with W3X ratification pending.

W3X has stated that the charter was renamed, committed and pushed after verification. Those internal pending/proposal statements therefore appear stale and should be corrected separately. The proposed designer introduction does not silently hide this: its reading order instructs the successor to STOP and report the mismatch if the prevailing charter still contains pending wording.

## Known follow-on reconciliation, not folded into this file

The latest package members below also contain stale internal cross-references and should be reviewed in their own turns:

```text
Deblock4_Project_Status_v1_16.md
111_New_Chat_Introduction_for_Coder_v1_18.md
```

The v1.13 proposal identifies their current limitations without attempting to rewrite them indirectly.

## Recommendation

W3D should verify the v1.13 proposal against:

```text
AI_Charter_and_Invariants_Card_v1_23.md
Scopes/Deblock4_Scope_Stage_1C_Filter_Creation_v1_5.md
Scopes/Deblock4_Stage_1C_Delivery_Plan_Addendum_v1_1.md
Deblock4_Stage_1C_Phase_3a_Designer_Briefing_v1_2.md
Deblock4_Project_Status_v1_16.md
```

Subject to W3D verification and W3X approval, rename the proposal to:

```text
111_New_Chat_Introduction_for_Designer_v1_13.md
```

Then supersede v1.12. No design change.
