# Deblock4 - W3C Review of the HELD Coder-Introduction C-DELIV-09 Delta

**Version:** 1.0
**Date:** 2026-08-01
**Author:** W3C
**Reviews:** `111_New_Chat_Introduction_for_Coder_v1_18.md`,
`Deblock4_HELD_PROPOSED_Coder_Intro_CDELIV09_Delta_v1_0.md`, charter v1.25,
the Stage 1C Phase 3a review set, and
`Deblock4_Scope_Header_CDELIV09_Reminder_Block_v1_1.md`.
**Encoding:** US-ASCII; CRLF.
**Status:** REVIEW COMPLETE. The held delta's intent is accepted, but its
literal edits are stale and it must not be applied standalone. A final coder
introduction should follow only after the binding Stage 1C scope/addendum set
is reconciled to charter v1.25.

---

# 1. Disposition

The held W3D delta made the correct process decision:

```text
- do not apply a C-DELIV-09-only edit immediately;
- fold it into the next full coder-introduction reconciliation;
- replace the superseded original recovery claim;
- advance the charter pin.
```

That intent remains correct.

Its literal instructions are now stale:

```text
held delta target:       charter v1.24
current ratified target: charter v1.25

held delta knows:        revised C-DELIV-09 body
current charter adds:    every scope and every delivery-plan addendum must
                         carry the latest reminder block verbatim
current reminder:        Deblock4_Scope_Header_CDELIV09_Reminder_Block_v1_1.md
```

The final coder introduction should therefore absorb the delta's intent, but
use charter v1.25 and reminder-block v1.1.

---

# 2. STOP-class dependency discovered during reconciliation

The current binding Stage 1C documents are not yet reconciled to charter v1.25.

## 2.1 Scope v1.5

`Deblock4_Scope_Stage_1C_Filter_Creation_v1_5.md` currently:

```text
- pins charter v1.19, Project Status v1.14, and Forward Roadmap v1.12;
- ends its header at the Encoding/EOL line;
- does not contain the current C-DELIV-09 reminder block immediately after
  that line.
```

## 2.2 Delivery-plan addendum v1.1

`Deblock4_Stage_1C_Delivery_Plan_Addendum_v1_1.md` currently:

```text
- names scope v1.5 as its companion;
- ends its header at the Encoding/EOL line;
- does not contain the current C-DELIV-09 reminder block immediately after
  that line.
```

## 2.3 Consequence

Charter v1.25 requires the latest reminder block in every scope and every
delivery-plan addendum. The charter's existing version discipline also says a
scope is re-issued when its controlling-document generation changes.

Therefore a final coder introduction must not present scope v1.5/addendum v1.1
as a fully reconciled current package while simultaneously teaching the
successor to STOP on exactly that mismatch.

The binding Stage 1C scope/addendum should first receive version-bumped,
document-only successors that:

```text
- carry the current reminder block verbatim immediately after Encoding/EOL;
- reconcile their charter/document pins to the prevailing package;
- make no design, implementation, phase-boundary, or acceptance change.
```

Because the Phase 3a Designer Briefing explicitly lists the three-member
review set, it will then need a narrow version bump to name the new scope and
addendum filenames. The latest version of each set member must be read together.

Exact successor version numbers should be assigned in that reconciliation,
not guessed inside the coder introduction.

---

# 3. Other coder-introduction corrections required

The held delta addresses only C-DELIV-09 and the charter pin. Coder
Introduction v1.18 also needs the following corrections.

## C1 - live Phase 3a state

The document still says Phase 3a is the current implementation work.

Correct state:

```text
Phases 1 and 2: accepted and committed.
Phase 3a: delivery v1.0 produced; awaiting W3D static review,
          W3X toolchain validation, and W3X acceptance.
Phase 3b: not released.
```

A successor must not begin Phase 3b or make fresh production changes unless
W3X supplies Phase 3a corrections or releases the next bounded phase.

## C2 - document currency

Update at least:

```text
Project Status:       v1.15 -> v1.16
Charter:              v1.22 -> v1.25
Phase 3a briefing:    Scopes/...v1.0 -> root-level ...v1.2
Reminder template:    add root-level ...Reminder_Block_v1_1
```

Tiering Decisions v1.10 is correct and remains.

Project Status v1.16 predates production of the Phase 3a delivery. The coder
introduction may identify that narrow stale point until Project Status receives
its own queued reconciliation.

## C3 - mixed-authority review set

The Phase 3a set must be described as read-together but mixed authority:

```text
scope:      controlling design authority
addendum:   binding delivery order/boundaries
briefing:   informative review guidance
```

Read-together status does not turn the briefing into a scope.

## C4 - creation-callback shorthand

Remove the over-broad "body otherwise unchanged" wording.

The settled rule is:

```text
- exact translated VSPublicFunction C-ABI boundary;
- immediate validated rebinding to idiomatic locals;
- accepted parse/validation/tier-selection/allocation/ownership/filter-
  construction logic preserved;
- required debug-only lifecycle creation-enter/successful-exit trace calls
  authorised around that logic.
```

## C5 - Stage 1C frame construction

The v1.18 blanket warning against all frame construction/copy is wrong for the
settled Phase 3a design.

Stage 1C forbids pixel arithmetic, deblocking, and algorithmic plane
construction, but expressly uses the standard API4 `copyFrame` idiom to produce
the final writable pass-through frame for properties. Plane data remains
untouched and bit-identical.

## C6 - Stage 1C backend execution

In Stage 1C every tier branch still calls the shared inert pass-through
placeholder. No real v2/v3 algorithm backend executes. Later backend calls must
also remain behind dispatch selected from the proven EFFECTIVE record.

## C7 - G10 option count

The accepted baseline has `enable_force_down` and
`enable_verbose_detection`. The Phase 3a candidate adds the third G10 option,
`enable_trace_lifecycle`, under the same Debug-only hard-reject and
three-surface absence rules.

## C8 - G6 wording

Remove the claim that gated-symbol PE-export absence is "structural" in the
current mechanism. The proven object-mode behaviour is accompanied by the
standing loud-failing `dumpbin /EXPORTS` gate; absence must not be inferred
from implicit toolchain behaviour.

## C9 - roles, I7, and version sets

Reconcile the orientation to:

```text
- W3D as a continuity-bearing designer/reviewer role;
- all W3C/W3D traffic through W3X;
- I7 different-party verification for self-affecting criteria;
- section 2.3a document sets, including incomplete-set STOP behaviour;
- each set member retaining its declared authority.
```

## C10 - handover and first-response blocks

The successor's first response and required handover package must state the
Phase 3a review state, carry the current charter/reminder/document versions,
include the Phase 3a delivery package and any review/validation results, and
explicitly say Phase 3b is not released.

---

# 4. Recommended sequence

```text
1. Reconcile the binding Stage 1C scope and delivery-plan addendum to
   charter v1.25 and reminder-block v1.1, with no design change.
2. Reconcile the Phase 3a Designer Briefing's declared review-set filenames.
3. Then issue Coder Introduction v1.19 against those final set versions.
4. Generate one unified diff from the original v1.18 in the documentation set
   to the final agreed v1.19.
5. Review Project Status v1.16 in its queued turn.
```

The held C-DELIV-09 delta is then superseded by the full v1.19 reconciliation.

---

# 5. Current W3C drafting state

W3C has worked through the complete v1.18 body and has a non-authoritative
working reconciliation containing the substantive corrections above. It is
not issued as a commit candidate because the exact successor scope/addendum/
briefing filenames are not yet settled.

No final coder-introduction diff should be distributed yet. Per W3X's earlier
instruction, the eventual diff should compare the original document-set
v1.18 directly with the final agreed v1.19, not with intermediate drafts.

---

# 6. Recommendation

Do not apply `Deblock4_HELD_PROPOSED_Coder_Intro_CDELIV09_Delta_v1_0.md`
literally.

Preserve its intent, reconcile the Stage 1C binding document set first, and
then complete Coder Introduction v1.19 as one cross-consistent update.

No project design, invariant, source-code, phase boundary, or acceptance
criterion change is proposed.
