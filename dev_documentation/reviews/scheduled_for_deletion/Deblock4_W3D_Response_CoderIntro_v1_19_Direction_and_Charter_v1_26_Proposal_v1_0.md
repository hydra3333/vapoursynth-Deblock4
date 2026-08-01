# Deblock4 - W3D Response: Coder-Intro v1.19 Direction + Charter v1.26 Proposal

**Version:** 1.0
**Date:** 2026-08-01
**Author:** W3D (verifier); carries W3X decisions on grandfathering and scope-currency
**Reviews:** the W3C review "W3C Review of the HELD Coder-Introduction C-DELIV-09
Delta" (incl. its STOP-class section 2 and corrections C1-C10), and the
W3C-drafted scope-reissue rule discussed with W3X.
**Encoding:** US-ASCII; CRLF.
**Status:** Two parts. Part A directs the coder-introduction v1.19 work
(W3C's C1-C10 verified and accepted; W3C's section-2 remedy DECLINED by W3X in
favour of grandfathering). Part B is the charter v1.26 proposal bundle
(scope-currency rule 2.3b + prospective qualifier), W3C-proposed in origin,
W3X-refined, W3D-verified here, for W3C to draft and W3X to ratify.

---

# PART A - Coder Introduction v1.19 direction

## A1. W3X decision on the section-2 STOP-class dependency: GRANDFATHER

W3C's review correctly observed that scope v1_5 and addendum v1_1 do not carry
the reminder block and pin older document generations. W3C's proposed remedy
(document-only successor scope/addendum + briefing rename + intro afterwards)
is DECLINED. W3X directs instead:

```text
- Scope v1_5 and addendum v1_1 are GRANDFATHERED: they stand unchanged for
  the remainder of Stage 1C. The reminder-block requirement applies from each
  document's NEXT NATURAL ISSUANCE (the Stage 2C scope, or any 1C re-issue
  that happens for real reasons).
- The Phase 3a review-set filenames therefore do NOT change, and the Phase 3a
  Designer Briefing stays at v1_2. No set-member bump.
- Rationale: (1) the in-review Phase 3a delivery was built against and cites
  scope v1_5 + addendum v1_1; re-issuing them mid-review makes the delivery
  of record reference a superseded scope generation - manufacturing exactly
  the generation-mixing 2.3a guards against. (2) Honest re-pinning of a
  ratified scope to a newer charter is not a header edit: a scope QUOTES what
  it relies on (charter 2.3), so reconciliation would require re-verifying
  every quoted section against the newer charter - real review cost, zero
  design benefit, mid-phase. (3) The block's operational purpose is already
  served: W3C holds the ratified charter and reminder-block v1_1 directly.
- This grandfathering will be recorded as a compatibility decision under the
  new 2.3b rule (Part B) when Project Status has its queued review.
```

## A2. C1-C10: ALL VERIFIED AND ACCEPTED

W3D verified each against the settled record; no changes. Notable:

```text
C1  Phase 3a state (delivery v1_0 produced, awaiting review/validation/
    acceptance; 3b not released): correct.
C2  Currency: charter -> v1_25, status v1_16 (with its narrow known-stale
    point flagged), briefing at ROOT at v1_2, reminder-block v1_1 added.
    Tiering v1_10 retained: correct.
C3  Mixed-authority review set (read-together does not equalise): correct -
    mirrors the settled designer-intro fix.
C4  Creation-callback shorthand replaced by the ratified narrow allowance
    (ABI boundary + validated rebinding + trace calls around preserved
    logic): correct.
C5  REAL CATCH: v1.18's blanket no-frame-construction warning contradicts
    the settled C5 order, which REQUIRES the standard API4 copyFrame
    pass-through producing the final writable frame for properties, plane
    data untouched. Correct the warning to forbid pixel arithmetic/
    deblocking/algorithmic plane construction only.
C6  Every 1C tier branch calls the shared inert pass-through; later real
    backends stay behind EFFECTIVE-record dispatch: correct.
C7  G10 option count is THREE with Phase 3a (enable_force_down,
    enable_verbose_detection, + enable_trace_lifecycle), same Debug-only
    hard-reject and three-surface rules: correct.
C8  G6 wording: PE-export absence is NEVER "structural"/assumed; it is
    enforced by the standing loud-failing dumpbin /EXPORTS gate. Correct -
    and properly stricter than the v1.18 wording.
C9  Roles/I7/2.3a-sets orientation (continuity-bearing W3D, traffic through
    W3X, different-party verification, incomplete-set STOP, per-member
    authority): correct.
C10 First-response/handover blocks carry Phase 3a state, current versions,
    the delivery package, and "3b not released": correct.
```

## A3. Directed content for v1.19 (consolidated "on the table" list)

Coder Introduction v1.19 is issued NOW, against the EXISTING review set,
folding together:

```text
1. C1-C10 above.
2. The held delta's intent (Deblock4_HELD_Coder_Intro_CDELIV09_Delta_v1_0.md),
   updated to current targets: charter pin -> v1_25 everywhere; the intro's
   INCREMENTAL EMISSION paragraph replaced with the ratified v1.24
   C-DELIV-09 restatement (risk-based trigger; honest loss bound naming
   un-emitted integration/reconciliation/validation/revision work and
   increment supersession; increments need not be independently applyable;
   concatenation is not integration; W3X ordinarily applies only the final
   package); plus awareness of the scope-header restatement requirement and
   reminder-block v1_1 as its mechanism.
3. ONE grandfathering line so a successor does not STOP on historical pins:
   "Scope v1_5 and addendum v1_1 predate the reminder-block requirement and
   later charter generations; they are grandfathered unchanged until their
   next issuance per W3X decision - do not STOP on their historical pins;
   the prevailing charter governs."
4. If charter v1.26 (Part B) is ratified before v1.19 is cut, pin v1_26
   instead of v1_25 and cite 2.3b as the grandfathering's governing rule;
   otherwise pin v1_25 and the grandfathering line stands on W3X's recorded
   decision alone. Do not hold v1.19 waiting for v1.26.
5. Then produce the unified diff v1.18 -> final v1.19 (per W3X's standing
   instruction: against the original document-set v1.18, not intermediate
   drafts).
```

The held delta document is then superseded. Project Status v1_16 review
follows in its queued turn (and will carry the 2.3b compatibility line for
the grandfathering).

---

# PART B - Charter v1.26 proposal: scope currency (2.3b) + prospective qualifier

## B1. Origin and provenance

The existing charter discipline ("when a controlling document changes after a
scope is authored, the scope is reissued with matching version information")
was agreed by W3X and W3C to be more aspirational than pragmatic - and worse,
quietly corrosive: a rule every party rationally ignores teaches all parties
that charter rules are optional. W3C drafted a materiality-based replacement;
W3X directed refinements; W3D verified and refined further. Provenance:

```text
proposer:   W3C (base rule), refined per W3X direction and W3D verification
verifier:   W3D (this document)
ratifier:   W3X (pending)
```

## B2. Proposed new section 2.3b (companion to 2.3a)

Place immediately after 2.3a. 2.3a answers "is my document set current and
unmixed?"; 2.3b answers "is my scope still valid against a newer controlling
document?".

```text
## 2.3b Scope currency against later controlling-document changes

A scope MUST be reissued when a later controlling-document change alters,
supersedes, contradicts, or materially qualifies anything the scope relies
on, quotes, requires, permits, forbids, or uses for acceptance.

A scope need NOT be reissued for an unrelated controlling-document change.
In that case: any party may flag the change; W3D assesses materiality and
recommends; W3X decides and records the compatibility decision in one line
in the Project Status document (for example: "scope vX / charter vY:
compatible, W3X <date>"). The session package then uses the newer
controlling document together with that recorded decision.

Where materiality is uncertain, disputed, or cannot be established by
inspection, STOP and reissue the scope.
```

Design notes for the verifier record: (a) the materiality ASSESSMENT is
assigned to W3D and the DECISION to W3X, so a memoryless W3C never
self-assesses compatibility of changes to criteria governing its own work
(the I7-shaped hole in the base draft); (b) the record is deliberately
one-line-in-Project-Status - heavyweight recording would kill the rule the
same way the old rule died; Project Status is already the live-state record
in every handover package, so successors find it.

## B3. Prospective qualifier on the reminder-block sentence

In the C-DELIV-09 clause's scope-header restatement sentence (added at
v1.25), qualify prospectively - replace:

```text
This rule is restated verbatim in the header of every scope and
every delivery-plan addendum, ...
```

with:

```text
This rule is restated verbatim in the header of every scope and
every delivery-plan addendum ISSUED HENCEFORTH, ...
```

(remainder of the sentence unchanged). This aligns the clause with the
settled position that ratified in-flight documents are not retroactively
reopened; the standing example is the Stage 1C grandfathering (Part A1).

## B4. Optional standing scope-header pointer (recommended, not required)

At each scope's next natural issuance, alongside the C-DELIV-09 block, add
one sentence to the scope header:

```text
This scope was authored against the controlling documents pinned above;
later controlling-document changes are handled per charter 2.3b.
```

A pointer, not a parallel rule - the logic lives in 2.3b only, so nothing
can drift. Record this in the charter's 2.3b design note or leave it as
authoring practice; W3X's choice.

## B5. Bundling and mechanics

One charter bump (v1.26) carries BOTH B2 and B3 - two process-currency fixes,
one revision. W3C drafts v1.26 (2.3b verbatim from B2; the two-word B3 edit;
status line + Part 7 revision entry with the B1 provenance, written as
ratified per W3X's standing instruction once W3X confirms). First recorded
2.3b instance upon Project Status's queued review: "scope v1_5 + addendum
v1_1 / charter v1.25(+): compatible, grandfathered to next issuance, W3X
2026-08-01."

---

# Disposition summary

```text
PART A: C1-C10 accepted; section-2 remedy declined -> GRANDFATHER; coder
        proceeds directly to intro v1.19 per A3, then the v1.18->v1.19 diff.
PART B: charter v1.26 bundle (2.3b + prospective qualifier) W3D-verified;
        W3C drafts; W3X ratifies. Do not hold v1.19 for it.
```
