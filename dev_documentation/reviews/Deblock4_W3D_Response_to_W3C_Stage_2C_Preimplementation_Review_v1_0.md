# Deblock4 - W3D Response to the W3C Stage 2C Pre-Implementation Review

**Deliverable:** W3D-2C-RESPONSE-TO-W3C-PREIMPL-REVIEW
**Version:** 1.0
**Date:** 2026-08-05
**Author:** W3D (designer)
**Route:** W3D -> W3X (for decision) -> W3C
**Responds to:** Deblock4_Stage_2C_D4_v1_7_Formal_Preimplementation_Review_W3C_v1_0.md
**Against:** charter v1_26; D4 v1_7; D3 v1_8; Addenda A v1_2 + B v1_2; D0 v1_9;
D2 v1_6; creation-error table v1_6; the prevailing branch-main source as
attached (Stage 1C + rider 1C.1 accepted state, identity 0.1.0-dev+1C).
**Status:** W3D POSITION FOR W3X DECISION. Nothing here is ratified. Every
proposed amendment is quoted in final form so W3X can ratify or reject it
line by line. On ratification W3D issues D4 v1_8 and D0 v1_10; no
implementation is released until W3X says so.
**Encoding:** US-ASCII; CRLF.

---

# 0. Summary of W3D positions

```text
F1  BLOCKER  CONFIRMED against source, cold. W3C is right that no correct
             implementation exists inside the present authorised boundary.
             W3D proposes the seam, the precedence rule, the emission-timing
             rule and the exact extra file authority. Section 2.
F2a          CONFIRMED. C-STY-10 applies and is unmapped. Adopt as K30.
F2b          CONFIRMED. C-SIMD-03 applies to scalar code too. Adopt as K31.
F3a          CONFIRMED and wider than stated. W3D proposes the authority
             wording plus a named list of README passages that are ALREADY
             superseded for 2C - one of which bears directly on F1.
F3b          CONFIRMED. Wording fix; two-state release model made explicit.
F3c          CONFIRMED, resolved in the OPPOSITE direction to W3C's
             suggestion: amend the manifest to match how W3X actually
             packages, because the no-read rule already carries the weight.
W3D-1  NEW   D4 section 8 still demands declared base HASHES for delivery
             files. That contradicts W3X's standing prevailing-source
             anchor. Retire it - while explicitly PRESERVING the two
             load-bearing hashes (D1 SHA256SUMS, K26 reference binary).
W3D-2  NEW   Where the three new S1/K29 refusals sit in the creation order
             is unspecified and interacts with F1's emission rule. Settled
             here so N01a/b/c1/c2 cannot be implemented two ways.
```

W3C's review is accepted as sound. It found a real blocker that the design
round did not, and its D2/D3/Addenda re-derivation independently reproduces
W3D's own model results (W3D reproduced the same 46 values in orientation;
W3C's counts for C11/C12/C16/C17 extend that agreement). No arithmetic,
schedule, threshold, boundary, fixture or corpus content changes.

---

# 1. Verification performed for this response

Per P-01, every claim below about existing code was verified cold against the
attached source in this session, with file and line.

```text
cpu_capability_detection.zig:202-256  initInstanceCapabilities detects,
    applies the force-down ceiling, EMITS the summary via
    print_helpers.emitInstanceSummary, then returns EFFECTIVE.
backend_tier_selection.zig:14-27      selectForInstance calls the above and
    only THEN calls selectForEffectiveTier (29-51), which is where any
    implementation cap would have to act.
print_helper_functions.zig:10-21      SummaryReason has exactly three
    variants: none, forced_down, hardware. No capped variant exists.
classic_instance_creation.zig:77-105  clip/parameter/plane checks run
    BEFORE selectForInstance; emitUsingLine runs after it (line ~137), so
    the rider 1C.1 ordering is preserved by any fix that emits at the end
    of selection.
build_1C_v1.bat:412                   count_literal_exact "... backend=" 1
    MACHINE-ENFORCES the one-line contract. A second line fails the gate.
build_1C_v1.bat:205-225               the refusal cases assert only the
    expected-error PASS marker. NO existing gate asserts summary text on a
    refused creation.
```

Consequences: W3C's F1 is correct in every particular, including that a
second line is not merely inelegant but breaks a standing gate. The last
line above is the one new fact that unlocks the emission-timing question -
W3D has design freedom there, bounded only by "Deblock4 stays unchanged".

---

# 2. F1 - RESOLVED: the truthful-summary seam (W3D design proposal)

## 2.1 Root cause, stated once

The always-on summary is emitted inside a CAPABILITY DETECTION function, but
the tier it must report is not known until SELECTION has run. In Stage 1C
these coincided, because selection never lowered the effective tier. S5 makes
them diverge for the first time. The defect is structural, not cosmetic, and
it is properly fixed by moving the emission to the point where the reported
value becomes true - not by adding a second line or a local formatter.

This also improves charter compliance: C-STY-07 (one module, one
responsibility) is better served by a detection module that detects and does
not print.

## 2.2 RATIFICATION REQUESTED - D-2C-1: the emission seam

```text
The single always-on creation summary is emitted ONCE, from
backend_tier_selection, AFTER the final per-instance tier is resolved (or
its refusal determined), and BEFORE selection returns.

cpu_capability_detection STOPS emitting it and instead returns, alongside
the EFFECTIVE record, the information the summary needs (the ACTUAL tier
and the existing computed SummaryReason). Detection semantics are
UNCHANGED: Set-A/Set-B tables, the comptime membership cross-check, CPUID/
XGETBV/XCR0 logic, the ACTUAL/EFFECTIVE two-record model, the force-down
ceiling intersection and the G10 announce path are all untouched. Only the
print call moves out.

print_helper_functions remains the SOLE home of always-on formatting
(C-STY-09, extend-do-not-fork). No caller formats a summary locally.
```

## 2.3 RATIFICATION REQUESTED - D-2C-2: the implemented-tier ceiling is data

```text
selectForEffectiveTier gains an IMPLEMENTED-TIER CEILING parameter. It stays
filter-neutral: the ceiling is DATA about which backends this build actually
implements, not filter identity, and there is no per-filter branch inside
the selector. The per-filter ceiling values are declared in
deblock4_config.zig (the C-STY-09 declarations-only switchboard):

    Classic   in Stage 2C : x86_64_v1_baseline   (scalar oracle only)
    Deblock4  in Stage 2C : unchanged - no cap   (still pass-through; S5
                            scopes the rule to Classic, and Deblock4
                            inherits it at 2D)

Resolution algorithm, in this exact order (S5 precedence is normative):

    requested == auto:
        resolved = the LOWER of (effective tier, implemented ceiling)
    requested == explicit:
        if rank(requested) > rank(effective)  -> refuse:
            "<Filter>: requested backend is above the EFFECTIVE CPU tier"
        else if rank(requested) > rank(ceiling) -> refuse:
            "<Filter>: requested backend is not available in this build"
        else resolved = requested

The EFFECTIVE check is tested FIRST and therefore retains precedence when
both apply (S5; proved by Addendum B N03).
```

## 2.4 RATIFICATION REQUESTED - D-2C-3: the reason precedence rule

This rule exists to keep every Stage 1C summary line byte-stable while making
the new cap visible.

```text
reason=implementation-capped(...) is reported IF AND ONLY IF the ceiling
STRICTLY lowers the tier, i.e. rank(ceiling) < rank(effective tier).
Otherwise the EXISTING reason logic (none / forced-down / hardware) applies
completely unchanged.

Worked consequences (Classic, ceiling v1):
    v3-capable host, no force-down : effective v3, cap binds ->
        reason=implementation-capped(x86_64_v1_baseline)
        actual=x86_64_v3_with_avx2
    DEBLOCK4_FORCE_DOWN=v1 (Debug) : effective v1, ceiling v1, NOT strictly
        lower -> reason=forced-down(...) exactly as Stage 1C emits today.
        This is why the existing E3 force-down gates stay green unchanged.
    DEBLOCK4_FORCE_DOWN=v2 (Debug) : effective v2, cap binds ->
        reason=implementation-capped(x86_64_v1_baseline)
        actual=x86_64_v3_with_avx2
    v1-only host                   : effective v1, NOT strictly lower ->
        reason=hardware(...) unchanged.
    Deblock4, any host             : no ceiling -> byte-identical to 1C.

The actual= field reports the ACTUAL hardware tier, consistent with charter
G1's ACTUAL/EFFECTIVE vocabulary and with the existing forced-down field.
```

Line format, extending the existing forced-down shape exactly (ONE physical
line; shown wrapped here only for the page):

```text
deblock4: 0.1.0-dev+2C Classic backend=auto tier=x86_64_v1_baseline reason=implementation-capped(x86_64_v1_baseline) actual=x86_64_v3_with_avx2
```

## 2.5 RATIFICATION REQUESTED - D-2C-4: emission timing on failed creation

```text
Exactly ONE summary line per creation ATTEMPT, including attempts that then
fail at tier selection. This PRESERVES current behaviour rather than
changing it.

Decisive reason: S5 scopes 2C to Classic and requires deblock4.Deblock4 to
remain unchanged. Deblock4 today emits the summary before a selection
refusal. Suppressing it would be a behaviour change to a filter this scope
must not touch, so success-only emission is rejected.

On a REFUSED explicit request the line reports tier= the tier the instance
WOULD have resolved for backend="auto" (the lower of effective and ceiling),
with reason= per D-2C-3. It never claims the refused tier was selected. For
Deblock4 this value equals today's, so its line stays byte-identical.

Refusals that occur BEFORE tier selection emit NO summary line, exactly as
today (see W3D-2 for which refusals those are).
```

## 2.6 RATIFICATION REQUESTED - D-2C-5: the amended authorised-file boundary

D4 section 7b is amended by ADDING two narrowly bounded existing-file
authorisations. Nothing else changes.

```text
src/cpu_capability_detection.zig  NARROW: remove the summary emission from
    initInstanceCapabilities and return/expose the ACTUAL tier and the
    computed SummaryReason to the caller. FORBIDDEN in this scope: any
    change to detection logic, the Set-A/Set-B membership tables, the
    comptime cross-check, CPUID/XGETBV/XCR0 handling, the ACTUAL/EFFECTIVE
    model, the force-down ceiling intersection, or the G10 announce path.

src/print_helper_functions.zig    NARROW: EXTEND SummaryReason with the
    implementation_capped variant and its one-line formatting, mirroring the
    existing forced_down shape. The none/forced_down/hardware variants and
    their emitted bytes are UNCHANGED. No new printing home is created
    (C-STY-09).

src/deblock4_config.zig           NARROW: declare the per-filter implemented
    tier ceilings and the reason token. Declarations only, no functions
    (C-STY-09).

src/backend_tier_selection.zig    (already authorised) additionally becomes
    the single emission point and applies the D-2C-2 algorithm.

src/deblock4_selftest.zig         NARROW: extend the existing 1C pure
    section with the D-2C-2/D-2C-3 cases. Existing cases unchanged.
```

W3D notes for W3X: this necessarily touches the detection module, which the
issued bootstrap header listed as forbidden. That listing was W3D's, written
before this seam was understood; the amendment is the correct response and
the detection CONTRACT remains untouched. The bootstrap header is reissued
with D4 v1_8.

## 2.7 Additional proof obligations created by this resolution

To be added to D4 section 7 (proof surface) and the D3 7d crosswalk:

```text
T-S5-1  Summary once per creation attempt: the existing exact-count gate
        (one "deblock4: <identity> <Filter> backend=" line) passes for
        Classic AND Deblock4 in every 2C case, success and refusal.
T-S5-2  Classic auto on a v3-capable host: line reports
        tier=x86_64_v1_baseline with reason=implementation-capped and
        actual=<host actual tier>; Deblock4Tier property agrees
        (Addendum B N04).
T-S5-3  Byte-stability: every Stage 1C summary line for Deblock4, and every
        Classic force-down line under DEBLOCK4_FORCE_DOWN=v1, is
        byte-identical to the Stage 1C expectation apart from the S6
        identity marker (+1C -> +2C).
T-S5-4  Precedence: N03 (force-down v1 + explicit v3) yields the EFFECTIVE
        refusal row, not the availability row; N02a/N02b yield the
        availability row on the un-forced v3-capable host.
T-S5-5  Debug-only combined case: DEBLOCK4_FORCE_DOWN=v2 with Classic auto
        reports implementation-capped with actual=<host actual tier>.
```

---

# 3. F2 - CONFIRMED: two charter duties adopted as new K-numbers

W3D verified both against the charter text and the attached source. Both are
genuine sweep results: applicable, unmapped, and capable of producing two
divergent implementations that both pass the current obligations. Per D0
section 6 they become index entries.

## 3.1 RATIFICATION REQUESTED - K30 (from F2a)

```text
K30  FIRST-CLASS MODULE DISCIPLINE APPLIES TO THE NEW 2C MODULES
     (charter C-STY-10). classic_scalar_kernel.zig,
     classic_edge_schedule.zig and classic_thresholds.zig are FIRST-CLASS
     permanent modules: permanent names (no stage numbers, no probe/smoke
     vocabulary); the one-way dependency rule (scaffolding may import
     first-class code, never the reverse); and no first-class reference to
     any scaffolding file, symbol, marker or artifact. The textual
     first-class audit returning EMPTY for scaffolding identifiers is a
     DELIVERY OBLIGATION of this scope, not only a re-run of the Stage 1C
     retired-filename scan, and it is named in the O/G crosswalk with its
     exact domain (the section-1 new modules plus every existing module
     this scope edits).
```

## 3.2 RATIFICATION REQUESTED - K31 (from F2b)

```text
K31  STRIDE UNITS ARE EXPLICIT AND CHECKED, EVEN IN SCALAR CODE
     (charter C-SIMD-03). VapourSynth strides are BYTE counts. The
     implementation either (a) addresses samples through byte arithmetic
     with the byte unit named at the point of use, or (b) performs exactly
     ONE conversion to a typed sample stride, naming both units and
     asserting the conversion is exact for the plane's bytesPerSample.
     Silent division is forbidden. Applies to u8 and u16 storage alike.
     Proof routing: code inspection plus the conversion assertion, riding
     on the existing D3 O-6e canary and O-8c/O-8h per-plane geometry tests.
```

D0 advances to v1_10 to carry K30/K31; D4 section 9 and D3 section 10
checklists gain the two rows. No obligation VALUES change.

---

# 4. F3a - CONFIRMED and extended: the README authority question

W3C is right that the documents contradict W3X's current direction. W3D will
not resolve this unilaterally: README status is charter-level, and P-09
forbids a scope amending the charter or README without W3X ratification.

## 4.1 RATIFICATION REQUESTED - the authority wording

Proposed for the bootstrap header (replacing "Controlling specification"),
D0, and D4's header, with W3X ratifying it as a charter-2.3b compatibility
decision recorded in Project Status:

```text
CONTROLLING for this scope: the charter (prevailing per 2.3a), this scope,
and its read-together authority set (D0, D2, D3, Addenda A/B, the
creation-error table, the D1 pin + provenance).

README_Deblock4_Design_Spec_v1_9 is FALLBACK GENERAL GUIDANCE. It predates
several ratified decisions and is scheduled for a currency audit. Where it
conflicts with the charter, a ratified decision record, or this authority
set, THE LATTER PREVAIL. It is consulted only on an IDENTIFIED MATTER that
the authority set does not settle, and the consulting party names the
matter and the section in its report so the currency audit can pick it up.
```

## 4.2 README passages this scope relies on, and their currency

W3D assessed each. Three are safe to rely on; two are already superseded and
must NOT be followed as written; one is silent exactly where F1 needed it.

```text
RELIABLE (consistent with the ratified 2C set; rely on them):
  6.1-6.5   boundary eligibility, derived bounds, small planes, no
            stride-slack use.  Agrees with D3 O-7 and D4 A5/A6.
  13.2      destination initial state.  Agrees with D4 A1d / K27.
  13.3      plane iteration from ACTUAL per-plane geometry.  Agrees with
            D4 A1c / K28. (13.3 item 7 - never infer chroma from luma
            subsampling - is exactly K28.)
  15.2      "more accurate" criteria for any deviation claim.  Agrees
            with K20. Unchanged in 2C; none is proposed.

SUPERSEDED - DO NOT FOLLOW AS WRITTEN:
  12.5/12.6 "auto -> highest backend allowed by the capability record".
            SUPERSEDED by S5: auto resolves to the highest tier that is
            both EFFECTIVE-supported AND IMPLEMENTED. This is the same
            passage F1 trips over; had the coder followed it, the false
            line would have been "correct" per the README.
  8.1       "32-bit floating-point samples" as intended coverage.
            SUPERSEDED for Stage 2C by S1: float is REFUSED at creation.
            Float remains a first-class FUTURE path; the README text is
            right about the project and wrong about this stage.

SILENT WHERE IT MATTERS:
  13.5/13.6 13.5 supports S5 well ("Deblock4Tier records the named level
            actually used"). 13.6 fixes the once-per-filter-instance
            cadence but says nothing about whether a FAILED creation
            emits, which is precisely the F1 ambiguity. D-2C-4 settles it;
            13.6 should absorb that at the currency audit.
```

W3X action requested: confirm this reading of 12.5/12.6 and 8.1 as
superseded, so the coder is not later told it should have followed them.

## 4.3 The scheduled currency audit

W3D records the standing task: after the 2C delivery is accepted, audit
README v1_9 end-to-end against the charter and every ratified decision
record, and reissue it. The five items above are the seed list.

---

# 5. F3b - CONFIRMED: two release states, named

```text
SCOPE RELEASED      the design is stable and IS the review authority. W3C
                    may read, verify, sweep, review and plan against it.
IMPLEMENTATION      W3X's separate, explicit authorisation to write code,
RELEASED            given only after the section-0/section-11 review round
                    is resolved by W3D/W3X.
```

D4 section 11's closing sentence is amended in v1_8 from "Do not begin
implementation until W3X releases the scope" to:

```text
This scope is RELEASED as the review authority. Do NOT begin implementation
until W3X EXPLICITLY RELEASES IMPLEMENTATION after this review round is
resolved. Scope release and implementation release are separate W3X acts.
```

The D4 v1_8 and bootstrap status lines will carry the same distinction.

---

# 6. F3c - CONFIRMED, resolved by amending the manifest

W3C proposes either packaging exactly as the manifest says or updating the
manifest. W3D recommends the SECOND, and more strongly than W3C frames it.

Reasoning: W3X works live in the tree and zips folders; a manifest that
requires hand-pruned archives will drift from practice every time, and each
drift costs a review finding (as it just did). The no-read rule is the real
control and it held perfectly here - W3C excluded superseded/,
superseded_do_not_use_.../ and reviews/scheduled_for_deletion/ and used the
highest versions, and the review was deterministic regardless of what the
archive contained.

```text
MANIFEST AMENDMENT (for the v1_1 manifest issued with D4 v1_8):
- The documentation archive MAY be the whole dev_documentation tree,
  including superseded folders. The binding rule is the READER's: never
  read, cite, move or delete anything under superseded/,
  superseded_do_not_use_files_in_this_folder/ or
  reviews/scheduled_for_deletion/ (K17, D0 section 6), and always use the
  highest non-superseded version of each document.
- Archive FILE NAMES are not pinned. Browsers rename downloads
  ("src(44).zip"); the bootstrap identifies the base by CONTENT (the Stage
  1C + rider 1C.1 accepted tree at identity 0.1.0-dev+1C), not by filename.
- Superseded generations of a document MAY be present in the same folder
  during a transition; the highest version prevails (2.3a). W3X moves them
  under superseded/ at his convenience, not as an issuance precondition.
- The number of archives is not pinned. The bootstrap header may travel
  inside an archive.
```

No reissue of the current package is required. W3C's review stands.

---

# 7. W3D-1 - NEW FINDING: retire delivery base hashes; keep the two real ones

D4 section 8 currently requires the delivery manifest to state "declared base
hash" per file, and to hash the files the delivery touches. That predates and
now contradicts W3X's standing anchor discipline, recorded in Stage 1C scope
v1_5: the base is the PREVAILING source, verified by upload when the coder is
unsure, NOT a pinned SHA - because branch main receives unrelated document and
test-material commits, so any recorded hash or commit id drifts without a
code change. Charter v1.18's attached-source-tree alternative says the same.

```text
D4 SECTION 8 AMENDMENT (proposed):
- REMOVE the per-file "declared base hash" requirement and the
  precondition-hashing sentence.
- REPLACE with: the manifest states every file, its role, and whether it is
  NEW or REPLACES an existing file in the attached base tree. The base is
  the attached tree itself. If W3C is unsure it holds the current source, it
  ASKS W3X to re-upload rather than inferring, transcribing or hashing.
- KEEP UNCHANGED: the scoped restore-to-base block, self-containment, and
  the never-touch-superseded rule.
```

TWO HASHES ARE NOT AFFECTED AND MUST BE PRESERVED EXACTLY. They are oracle
identity, not source bookkeeping:

```text
D1 snapshot   SHA256SUMS.txt verification before the H0 tool reads or
              compiles those bytes. Normative CONTENT identity of the
              pinned reference (provenance v1_4).
K26 binary    the mandatory SHA-256 of the exact reference DLL in the
              reference-build record, plus the rebuild rule (a rebuilt
              binary is a NEW oracle artefact needing fresh hash AND full
              sentinel revalidation). This is the entire basis on which an
              undefined-behaviour-bearing external binary can be trusted as
              a layer-(b) oracle at all.
```

W3C's own review correctly hashed the attached archives; that was diligence,
not a requirement, and after this amendment it is not expected of future
deliveries.

---

# 8. W3D-2 - NEW FINDING: where the three new refusals sit in creation order

D4 authorises the three refusal rows but does not say WHERE in the creation
sequence they run. That interacts with D-2C-4 (does a refused creation emit a
summary?) and could be implemented two ways. Settled here.

```text
RATIFICATION REQUESTED - D-2C-6:

The S1 float refusal and the K29 integer-depth refusal are CLIP-FORMAT
checks. They run with the other clip-dependent checks, BEFORE
backend_tier_selection.selectForInstance - i.e. alongside the existing
constant-format check - and therefore emit NO summary line, exactly as
today's clip refusals do.

The S5 availability refusal is a BACKEND check and necessarily runs inside
selection, which does emit (D-2C-4).

Consequences fixed for the corpus: Addendum B N01a, N01b, N01c1 and N01c2
produce their exact error row with NO summary line. N02a, N02b and N03
produce their exact error row WITH one summary line. N04 succeeds with one
summary line carrying the implementation-capped reason.
```

---

# 9. What W3D will issue on ratification

```text
D4 v1_8    section 7b amended per D-2C-5; section 2 S5 gains D-2C-1..4;
           section 7 gains T-S5-1..5; section 8 amended per W3D-1; section
           9 checklist gains K30/K31; section 11 amended per F3b; header
           authority wording per F3a; D-2C-6 recorded in section 7b.
D0 v1_10   K30 and K31 added; the README authority paragraph recorded.
D3 v1_9    ONLY if W3X wants K30/K31 mirrored in its section-10 checklist
           and the 7d crosswalk domain named there. Obligation VALUES are
           untouched either way - no re-derivation, no re-review of
           vectors, matrices, fixtures or corpus.
Bootstrap  v1_1: forbidden-file list corrected per D-2C-5; authority
           wording per F3a; base-identification wording per F3c/W3D-1;
           the two release states per F3b.
Manifest   v1_1: packaging amendment per F3c.
Status     v1_22: this review round, the ratifications, and the README
           currency-audit task recorded.
```

W3C's requested focused re-review is agreed: only the amended lines and the
source boundary need re-reading. W3D confirms no D2, formula, matrix,
boundary, sentinel or corpus content changes in any of the above.

---

# 10. Questions returned to W3X for decision

```text
Q-A  Ratify D-2C-1..D-2C-6 (section 2 and section 8) as the F1 resolution?
     These are design decisions W3C correctly refused to make alone.
Q-B  Adopt K30 and K31 (section 3)?
Q-C  Confirm the README authority wording AND the supersession list in
     4.2 - specifically that 12.5/12.6 and 8.1 are superseded for 2C?
Q-D  Adopt the F3b two-release-state wording?
Q-E  Adopt the F3c manifest amendment (packaging follows practice; the
     no-read rule carries the weight)?
Q-F  Adopt W3D-1 (retire delivery base hashes; preserve the D1 and K26
     hashes explicitly)?
Q-G  Should D3 be reissued at v1_9 for the checklist mirror, or left at
     v1_8 with K30/K31 carried by D0/D4 only?
```

---

*Revision history*
```text
v1.0 (2026-08-05) Initial W3D response to the W3C Stage 2C section-0/
     section-11 pre-implementation review v1.0. F1 confirmed cold against
     source and resolved with six proposed decisions; F2a/F2b confirmed and
     proposed as K30/K31; F3a confirmed and extended with a named README
     supersession list; F3b and F3c confirmed with proposed wording; two new
     W3D findings raised (delivery base hashes vs the prevailing-source
     anchor; creation-order placement of the three new refusals). No
     algorithm, schedule, threshold, boundary, fixture or corpus content is
     changed by any proposal in this document.
```
