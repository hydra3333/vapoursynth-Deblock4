# Deblock4 - W3C Review of Charter C-DELIV-09

**Version:** 1.0  
**Date:** 2026-08-01  
**Author:** W3C  
**Status:** W3C proposal for independent W3D verification and W3X ratification.  
**Reviews:** `C-DELIV-09` in `AI_Charter_and_Invariants_Card_v1_23.md`.  
**Encoding:** US-ASCII; CRLF.

---

# 1. Disposition

The purpose of C-DELIV-09 is sound, useful, and operationally workable for W3C.
Incremental emission is a practical safeguard against losing an entire large
delivery when a chat, tool run, or working context is interrupted. It also gives
W3X and W3D reviewable intermediate artifacts without changing the requirement
for one integrated final delivery.

W3C does **not** recommend retaining the current wording unchanged. The rule is
close, but two statements are more absolute than W3C can honestly guarantee:

1. the trigger based mechanically on "more than one module" can require
   unnecessary checkpointing for two very small modules while failing to capture
   one unusually large or integration-heavy module; and
2. "at most the module in flight is lost" understates the possible loss, because
   un-emitted integration, reconciliation, validation, or revisions to earlier
   emitted modules may also exist when an interruption occurs.

The narrow replacement below preserves the settled intent while describing the
actual recoverable state accurately. It remains a governance rule rather than a
detailed delivery procedure.

# 2. What W3C can reliably do

For a sufficiently substantial delivery, W3C can:

- complete one module or small coherent group;
- emit the complete artifact or increment package immediately with the required
  `increment N of ~M: <what>` marker;
- continue from the last emitted increment;
- make later increments supersede or reconcile earlier ones where integration
  requires it; and
- rebuild and validate the whole result against the authoritative base as the
  normal final C-DELIV-01..08 package.

The emitted artifacts are genuine recovery and review checkpoints. They are
available to W3X and can orient a successor chat. They are not a copy of W3C's
internal reasoning, and they do not preserve partial work that has not been
emitted.

# 3. Honest recovery boundary

The strongest accurate statement is:

```text
The recoverable state is the last complete emitted increment or set of
increments. The current incomplete increment and any later un-emitted
integration, reconciliation, validation, or revision work may be lost.
```

This is slightly broader than "at most the module in flight is lost", but it is
still a useful and tight loss bound. It prevents W3C from implying that internal
working state, partial edits, or un-emitted cross-module integration can be
resumed after interruption.

An earlier emitted increment may also become stale after later integration. It
remains valuable as a recovery baseline, but it is not automatically the final
or independently applyable form.

# 4. Recommended replacement for C-DELIV-09

```text
C-DELIV-09  INCREMENTAL EMISSION FOR INTERRUPT-SAFETY AND REVIEW CONTINUITY.

            When a scope or phase is large enough that withholding all output
            creates a material interruption or review-continuity risk - normally
            multiple modules or more than a few files - W3C EMITS complete
            modules or small coherent groups as they are finished rather than
            waiting for one final package. Each increment carries a one-line
            marker of the form "increment N of ~M: <what>"; ~M is an estimate
            and may be revised as the bounded work becomes clearer.

            Each increment is a COMPLETE, self-identifying recovery and review
            artifact against the stated base. It need not be independently
            applyable or accepted unless W3C explicitly says so.

            PURPOSE AND HONEST LIMIT: emitted increments provide a recoverable
            baseline if the session is interrupted and running review
            checkpoints for W3X. ONLY EMITTED ARTIFACTS SURVIVE an interruption.
            W3C must NOT claim to preserve, checkpoint, or resume un-emitted
            internal reasoning, partial work, or integration changes. The
            recoverable state is exactly the last complete emitted increment or
            set of increments. The current incomplete increment and any later
            un-emitted integration, reconciliation, validation, or revision work
            may be lost. Earlier increments may be superseded by later
            integration and are not the final delivery of record.

            THE FINAL DELIVERABLE IS UNCHANGED. Incremental emission is for
            continuity, interrupt-safety, and review only; it does NOT replace
            the properly packaged final deliverable. At the end of the scope or
            phase, W3C rebuilds and re-packages the complete integrated work
            against the authoritative base as one final deliverable meeting
            C-DELIV-01..08 in full. The final result is validated as a whole;
            merely concatenating increments is not proof of integration. The
            packaged final deliverable is the artifact of record that W3X
            applies unless W3X explicitly directs otherwise.
```

# 5. Why this remains appropriately general

The replacement does not prescribe:

- a fixed number of files per increment;
- a fixed checkpoint interval;
- a mandatory ZIP, patch, or whole-file form for every increment;
- a separate validation matrix for each increment; or
- a requirement that W3X apply intermediate work.

Those decisions depend on the phase and remain with W3C under the ordinary
C-DELIV rules and the active scope. The rule states only the trigger, the
observable marker, the honest recovery boundary, and the unchanged status of the
final integrated package.

# 6. Application examples

A suitable Phase 3b sequence could be:

```text
increment 1 of ~4: permanent build graph and build_1C_v1.bat
increment 2 of ~4: Classic pass-through harness
increment 3 of ~4: Deblock4 pass-through harness
increment 4 of ~4: proof-matrix and integrated delivery support
```

The estimate may change if integration reveals a more sensible grouping. Each
emitted increment must be complete as an artifact, but W3X should ordinarily
apply only the final integrated delivery.

For two tiny modules that can be completed and packaged safely as one short
operation, the rule need not force artificial intermediate emission. Conversely,
a single very large integration module may justify an increment even though the
literal module count is one.

# 7. Provenance under charter I7

This is a change to delivery criteria that will be applied to W3C's own work.
Accordingly:

```text
proposer:   W3C
verifier:   W3D (required independent verifier)
ratifier:   W3X
```

The replacement must not be silently absorbed. It becomes normative only after
independent W3D verification and W3X ratification.

# 8. Recommendation

W3D should endorse the purpose of C-DELIV-09 but verify the replacement wording
above instead of the current text. The replacement is more faithful to W3C's
actual capabilities, removes two misleading absolutes, and remains concise
enough to serve as a standing charter rule rather than an implementation manual.
