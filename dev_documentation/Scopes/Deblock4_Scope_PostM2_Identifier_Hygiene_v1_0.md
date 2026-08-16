# Deblock4 - Scope - Post-5C Maintenance M2 - Identifier Hygiene Pass

**Deliverable:** W3D-M2-SCOPE (for W3X ratification)
**Version:** 1.0
**Date:** 2026-08-16
**Author:** W3D (designer)
**Route:** W3D -> W3X (ratification) -> W3C (only if W3X authorises any change)
**Base:** the committed Stage 5C tree plus accepted M1, identity 0.1.0-dev+5C.
**Authority set:** charter v1_29 or later PREVAILS (note C-STY-10); D0 Binding
Knowledge Index v1_14 (note K30, K16, K23); Documentation Currency Audit v1_4.
**Status:** DRAFT v1.0 - awaiting W3X ratification.
**Encoding:** US-ASCII; CRLF.

---

# 0. KNOWLEDGE SWEEP (standing, two-sided - D0 section 6.1, verbatim)

```text
KNOWLEDGE SWEEP (standing, two-sided): Before implementation, W3C must
independently search the committed documentation set (excluding
superseded/) for relevant non-superseded, non-withdrawn knowledge,
rules, or decisions bearing on this scope, WITHOUT starting from the
checklist below, and report as numbered findings anything relevant that
the checklist or the Stage 2C+ Binding Knowledge Index does not carry.
Withdrawn alternatives are reportable only as do-not-revisit
confirmations. W3D verifies; confirmed items become new index K-numbers;
W3X adopts any scope amendment.
```

# 1. Mission - and an honest correction to the premise

```text
This item has sat on the registered follow-up list for a long time under
the label "identifier-cleanup hygiene pass", which implies a backlog of
badly named things awaiting a sweep. W3D SURVEYED THE LIVE TREE BEFORE
WRITING THIS SCOPE, and that premise is largely FALSE. Reporting that
honestly is the first duty of this scope.

Findings from the survey (33 production modules under src/):
  - Module filenames are uniformly first-class and permanent: no stage
    numbers, no probe/smoke/scratch vocabulary, consistent
    domain_role_detail shape (classic_*, deblock4_*, common_*, plus
    named cross-cutting units).
  - No production identifier carries a stage number EXCEPT the cluster
    in deblock4_selftest.zig (section 2).
  - The words probe/smoke/scratch/tmp appear only inside COMMENTS
    describing G10 layer-3 positive controls - they are not identifiers.
  - The symbols named in the export-exclusion gates
    (deblock4_backend_probe, deblock4_dll_probe) do NOT exist in the
    current source; they are historical names the gates assert the
    ABSENCE of, which is a legitimate and deliberate tripwire.

THE MISSION IS THEREFORE: decide, on evidence, whether ANY rename is
warranted; and if the answer is "only the selftest cluster, or nothing",
say so and close the item rather than manufacture work. A hygiene pass
that invents renames to justify itself is worse than no pass at all,
because every rename in this project costs proof.
```

# 2. The only genuine candidate: the Stage 1C vocabulary in the selftest

```text
deblock4_selftest.zig carries a stage-numbered cluster:
    fn runStage1CPureContracts()
    error.Stage1CAutoSelectionFailed
    error.Stage1CExplicitSelectionFailed
    error.Stage1CAboveEffectiveWasAccepted
    error.Stage1CUnknownBackendWasAccepted
    error.Stage1CClassicValidationFailed
    error.Stage1CDeblock4ValidationFailed
    error.Stage1CInvalidCallWasAccepted
and the emitted line contains the token  stage_1c=PASS .

ARGUMENT FOR RENAMING (C-STY-10 / K30 first-class discipline): these are
permanent production contracts, not Stage 1C scaffolding. What they
actually assert is the SELECTION AND CREATION CONTRACT - auto selection,
explicit selection, above-effective refusal, unknown-token refusal, both
filters' validation, invalid-call refusal. None of that is stage-bound;
all of it is as live at 5C as it was at 1C. A reader in two years will
reasonably ask which parts are still Stage 1C's concern, and the answer
is "none - it is the standing contract", which is exactly the confusion
first-class naming exists to prevent.

ARGUMENT AGAINST RENAMING - and it is NOT weak:
  - The emitted token stage_1c=PASS is ASSERTED BY THE PROOF MATRIX in
    at least two places (build_5C_v1.bat lines 229 and 385,
    "selftest retained Stage 1C section"). Renaming the token forces a
    matching batch edit, so the change is NOT confined to source.
  - Every batch that asserts it is an ACCEPTED, COMMITTED artifact.
    Changing an accepted batch to accommodate a cosmetic rename inverts
    the usual priority: proof machinery should change for proof reasons.
  - K16 keeps creation-error strings and using-echo surfaces byte-stable;
    the selftest banner is adjacent in spirit even if not identical in
    letter.
  - The names are internally consistent and cause no ambiguity TODAY.

W3D DOES NOT RECOMMEND EITHER WAY IN THE ABSTRACT. This is a judgement
about long-term readability versus proof-surface churn, and it belongs
to W3X. Section 3 puts the choice cleanly.
```

# 3. THE DECISION W3X MAKES (the point of this document)

```text
OPTION A - CLOSE THE ITEM, NO CHANGE.
    Record that the tree was surveyed, that naming is already
    first-class and consistent, that the only stage-numbered cluster is
    the selftest's and it is proof-asserted, and that renaming it buys
    readability at the cost of editing accepted proof machinery. The
    registered follow-up is discharged as SURVEYED AND CLOSED, with the
    survey recorded so a successor does not re-open it blindly.
    Cost: one documentation pass. Risk: none.

OPTION B - RENAME THE SELFTEST CLUSTER, SOURCE AND GATES TOGETHER.
    fn runStage1CPureContracts -> runSelectionAndCreationContracts
    error.Stage1C* -> error.Selection*/Creation* (exact set at scope
    time), and stage_1c=PASS -> selection_contract=PASS, with the
    matching assertions updated in EVERY batch that asserts them.
    Acceptance: full retained matrix green, plus an explicit check that
    no batch still asserts a token the source no longer emits (a stale
    assertion that silently never fires is the real hazard here, and it
    is precisely the class of defect that bit Stage 5C twice).
    Cost: a coder delivery touching source AND accepted batches, plus a
    full matrix run. Risk: moderate, and concentrated in the gates, not
    the filter.

OPTION C - DEFER TO THE NEXT STAGE THAT ALREADY EDITS THE SELFTEST.
    Do nothing now; attach the rename to whichever future stage has
    legitimate cause to modify deblock4_selftest.zig and its gates, so
    the churn is absorbed by work that was going to touch those files
    anyway. Record the intent so it is not lost.
    Cost: none now. Risk: the item lingers on the list (which is what
    it has been doing).

W3D's OWN VIEW, offered as a recommendation and not as a finding: OPTION
A or C. The naming problem here is real but small, and the cost falls on
accepted proof machinery rather than on the code being clarified. If
W3X's instinct is that stage numbers in permanent contracts will
eventually mislead someone, OPTION C gets the fix for free later; OPTION
A closes it honestly now. OPTION B is defensible but is the only one
that spends proof for cosmetics.
```

# 4. If W3X chooses B: authorised surface and proof

```text
AUTHORISED (B only):
    MOD  src/deblock4_selftest.zig        (the identifier cluster and
                                           the emitted token ONLY)
    MOD  every batch asserting the old token - identified by exhaustive
         search, listed in the delivery, NONE missed

BYTE-FROZEN: every other file, including all four frozen Classic units,
    both backend objects, build.zig, all harnesses.

PROOF:
    M2-T1  Exhaustive token search across the whole repository proving
           no assertion of the OLD token remains anywhere, and that
           every NEW assertion matches a token the source actually
           emits. Both directions - a gate asserting a token nothing
           emits is a gate that can never fail.
    M2-T2  Full retained proof matrix green, OUTER_BATCH_EXIT_CODE=0,
           including the selftest sections in all three modes.
    M2-T3  Instruction-stream comparison is NOT required (this is a real
           source change, not a comments-only change) but the diff must
           be shown to be confined to the named cluster.
    M2-T4  US-ASCII / CRLF preserved.
```

# 5. Out of scope, in all options

```text
Any rename of module filenames                  -> they are already
                                                   first-class; renaming
                                                   files churns imports,
                                                   build wiring and every
                                                   audit for no gain
Any rename inside the four frozen Classic units -> frozen; a rename there
                                                   would require its own
                                                   scope and full re-proof
Removing the historical export-exclusion         -> those gates assert
tripwires (deblock4_backend_probe etc.)            ABSENCE by design and
                                                   must stay
Comment or documentation wording                -> M1 is complete; this
                                                   scope touches
                                                   identifiers only
```

---

*Revision history*
```text
v1.0 (2026-08-16) Initial M2 scope. Written AFTER surveying the live tree,
     which showed the "identifier cleanup" premise to be largely false:
     naming is already first-class and consistent across 33 modules, and
     the only stage-numbered production cluster is in deblock4_selftest.zig,
     whose emitted token is asserted by accepted proof batches. The scope is
     therefore a DECISION document (options A/B/C) rather than a rename job,
     with W3D recommending A or C.
```
