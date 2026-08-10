# Deblock4 - W3D Response to the W3C Stage 2C Pre-Implementation Review

**Deliverable:** W3D-2C-RESPONSE-TO-W3C-PREIMPL-REVIEW
**Version:** 1.1
**Date:** 2026-08-05
**Author:** W3D (designer)
**Route:** W3D -> W3X (for decision) -> W3C
**Responds to:** Deblock4_Stage_2C_D4_v1_7_Formal_Preimplementation_Review_W3C_v1_0.md
**Against:** charter v1_26; the W3X designer communication convention v1_0;
D4 v1_7; D3 v1_8; Addenda A v1_2 + B v1_2; D0 v1_9; D2 v1_6; creation-error
table v1_6; the prevailing branch-main source as attached (Stage 1C + rider
1C.1 accepted state, identity 0.1.0-dev+1C).
**Status:** W3D POSITION FOR W3X DECISION. Section 1 is everything W3X needs
to answer; the rest of the document is the evidence and the ratification-
ready wording, for the record and for W3C. Nothing here is ratified. On
ratification W3D issues the documents listed in section 10.
**Encoding:** US-ASCII; CRLF.

---

# 1. DECISIONS W3X NEEDS TO MAKE

Answer these nine and this review round is resolved. Each is self-contained;
the body sections give the detail only if you want it.

## Q1. Adopt my fix for the coder's blocker (the untruthful startup line)?

The coder found that our code prints its one-per-filter startup summary line
too early: inside CPU detection, before the new "Classic only implements the
scalar backend in 2C" cap is applied. On your PC that line would claim the
AVX2 tier while Classic actually runs scalar - a false line - and the rules
forbid printing a second corrected line (our own test batch fails the build
if the line appears twice). No correct implementation exists within the
files the scope currently allows the coder to touch. The coder rightly
refused to invent a fix and asked us to design one.

My fix: move the print out of the detection module into the tier-selection
module, so the line is printed once the final truthful answer is known; add
one new reason token, "implementation-capped", shown ONLY when the cap
actually lowers the tier - which is precisely what keeps every existing
Stage 1C output line byte-identical, so all standing tests stay green.

Why it matters: without this, 2C implementation cannot start; with a lesser
fix (second line, or local print formatting) we break our own gates and
charter styling rules.

One honest disclosure: the fix requires narrowly editing
cpu_capability_detection.zig - a file MY bootstrap header listed as
forbidden. That listing was my error, made before this seam was understood.
The fix moves only the print call out; every byte of actual detection logic
(tables, CPUID/XGETBV, force-down, G10) stays untouched and I have written
that prohibition into the amended scope text.

I recommend: ADOPT the fix as specified in section 2.
Decide: [Adopt]  or  [Ask me for an alternative seam design].
(refs: W3C F1; proposed D-2C-1, D-2C-2, D-2C-3, D-2C-5; charter C-STY-07,
C-STY-09; build_1C_v1.bat:412)

## Q2. When a filter REFUSES a request, does it still print its line first?

Today, if a user requests a backend the CPU can't do, the filter prints its
summary line and then refuses. The scope never said whether that stays true
under the new cap, and two coders could reasonably implement it two ways -
so it must be settled now.

Why it matters: an unsettled either-way behaviour is exactly how silent
divergence between implementations happens; also, changing it would alter
the Deblock4 filter's behaviour, which this scope is forbidden to touch.

I recommend: KEEP printing the line on refusals (one line per creation
attempt) - it preserves today's behaviour exactly; "print only on success"
would change Deblock4 and is rejected for that reason alone.
Decide: [Keep printing (recommended)]  or  [Print only on success].
(refs: proposed D-2C-4; S5 "Deblock4 unchanged"; verified: no existing gate
asserts the line on refusal, so tests constrain neither choice)

## Q3. Confirm: the two new clip-format refusals run BEFORE backend selection.

Simple placement confirm. The new "no float clips" and "no 17-32 bit clips"
refusals are properties of the CLIP, so they should run with the existing
clip checks (like the variable-format refusal), before backend selection -
meaning those refusals print NO summary line, exactly like today's clip
refusals. The backend-availability refusal, by nature, runs inside selection
and does print one.

I recommend: CONFIRM this ordering; it makes every test case in the corpus
single-valued (which cases show a line, which don't, is then fixed).
(refs: proposed D-2C-6; S1, K29, S5; Addendum B N01a/b/c1/c2, N02a/b, N03,
N04)

## Q4. Record the two charter rules the coder's sweep caught as K30 and K31?

The coder found two existing charter rules that genuinely apply to this
scope but are not recorded in our knowledge index: (1) the new scalar
modules are permanent first-class code and must obey the first-class naming/
dependency discipline; (2) VapourSynth strides are BYTE counts, and any
conversion to sample units must be explicit and checked - even in scalar
code, where silent divide-and-assume is the classic bug.

Why it matters: unrecorded applicable rules get violated by accident later;
both can produce two structurally different implementations that pass all
current tests.

I recommend: RECORD both as new knowledge items K30 and K31 - costs nothing,
closes the gap. I verified both against the charter text and source.
Decide: [Record both (recommended)]  or  [Leave unrecorded with reason].
(refs: W3C F2a/F2b; charter C-STY-10, C-SIMD-03; proposed D0 K30/K31)

## Q5. Make the README's fallback status official, incl. two dead passages?

You directed in chat that README v1_9 is fallback guidance. The documents
still call it "controlling", and the coder rightly asked us to reconcile
that in writing for future memoryless sessions. I audited every README
passage this scope leans on: three are safe, one is silent where we needed
it, and TWO are already superseded and actively dangerous - one of them
(12.5/12.6, "auto picks the highest CPU-capable backend") is the exact text
that would have produced the false startup line in Q1. A coder following the
README there would have been wrong while believing it was right.

Why it matters: a memoryless coder given "controlling" README text that
contradicts ratified decisions will follow the README.

I recommend: RATIFY the fallback wording in section 4.1 AND the named
supersession list in 4.2 (12.5/12.6 and 8.1 superseded for 2C). The full
README currency audit stays on my task list for after 2C, as you assigned.
Decide: [Ratify wording + list (recommended)]  or  [Amend my wording].
(refs: W3C F3a; proposed authority wording; S5, S1; README 12.5/12.6, 8.1,
13.6)

## Q6. Adopt the "scope released" vs "implementation released" wording fix?

Our documents used "released" for two different acts: releasing the DESIGN
for review, and releasing the coder to WRITE CODE. The coder noticed and
behaved correctly anyway, but asked us to fix the words for the next
memoryless reader.

I recommend: ADOPT the two-state wording in section 5 - it records exactly
the process you are already running.
(refs: W3C F3b; D4 section 11 amendment)

## Q7. Packaging: bend the manifest to match your practice, not vice versa?

The coder noted the issued zips didn't match my manifest's described layout
(three zips not two, superseded folders present, browser-renamed
"src(44).zip"). Two ways to fix it: make you package exactly as the manifest
says every time, or amend the manifest to bless how you actually work. The
review itself was unharmed - the reader-side "never read superseded/, use
highest versions" rule carried all the weight, perfectly.

Why it matters: a manifest that fights your workflow will drift every
issuance and cost a review finding each time, for zero safety gain.

I recommend: AMEND THE MANIFEST (whole-tree zips fine, filenames not
pinned, base identified by content not filename). No reissue of the current
package; the coder's review stands.
Decide: [Amend manifest (recommended)]  or  [Pin exact packaging].
(refs: W3C F3c; K17; D0 section 6; manifest v1_1)

## Q8. Drop per-file "base hashes" from deliveries, keeping the two real ones?

My own finding: the scope still requires the coder's delivery manifest to
state a hash for each file's base version. That contradicts your standing
practice - recorded in the Stage 1C scope after you corrected the same
mistake once before - that the base is the prevailing source verified by
upload, never a pinned hash/SHA, because the repo receives unrelated commits
and any recorded hash drifts without a code change. You also told me
directly that hashing is no longer in vogue.

Two hashes are NOT bookkeeping and must stay: the HolyWu snapshot checksums
(they ARE the pinned oracle's identity) and the reference DLL hash (the
entire basis for trusting an external binary as an oracle).

I recommend: DROP the per-file base hashes, KEEP those two, per section 7.
Decide: [Drop + keep two (recommended)]  or  [Keep hashing everything].
(refs: W3D-1; D4 section 8; scope 1C v1_5 starting-point discipline; D1
SHA256SUMS; K26)

## Q9. Reissue D3 too, or let D0 and D4 carry the two new K-items?

Housekeeping choice. K30/K31 (Q4) get recorded in the knowledge index (D0)
and the scope (D4). D3 - the acceptance-obligations document - has its own
checklist section that could mirror them, but its actual obligations don't
change either way.

I recommend: LEAVE D3 at v1_8 - less churn, no content change to justify a
bump, and the coder re-reviews fewer documents. The checklist mirror can
ride D3's next natural revision.
Decide: [Leave D3 (recommended)]  or  [Reissue as v1_9 for the mirror].
(refs: W3D section 10 Q-G from v1.0; D3 v1_8 section 10)

---

That is everything. Sections 2-10 below are the evidence, the cold source
verification, and the exact ratification-ready wording behind each question,
for the record and for W3C's focused re-review.

---

# 2. Evidence and design for Q1/Q2/Q3 (the F1 blocker resolution)

## 2.1 Cold source verification (P-01), file and line

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
    BEFORE selectForInstance; emitUsingLine runs after it, so the rider
    1C.1 ordering is preserved by any fix that emits at the end of
    selection.
build_1C_v1.bat:412                   count_literal_exact "... backend=" 1
    MACHINE-ENFORCES the one-line contract. A second line fails the gate.
build_1C_v1.bat:205-225               the refusal cases assert only the
    expected-error PASS marker. NO existing gate asserts summary text on a
    refused creation - so Q2 is a genuinely open design choice, bounded
    only by "Deblock4 stays unchanged".
```

W3C's F1 is confirmed correct in every particular. Root cause, stated once:
the summary is emitted inside a CAPABILITY DETECTION function, but the tier
it must report is not known until SELECTION has run. In Stage 1C these
coincided because selection never lowered the effective tier; S5 makes them
diverge for the first time. The proper fix moves the emission to the point
where the reported value becomes true. This also improves C-STY-07 (one
module, one responsibility): a detection module that detects and does not
print.

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

This rule exists to keep every Stage 1C summary line byte-stable while
making the new cap visible.

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
today (see D-2C-6 for which refusals those are).
```

## 2.6 RATIFICATION REQUESTED - D-2C-5: the amended authorised-file boundary

D4 section 7b is amended by ADDING these narrowly bounded existing-file
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

The bootstrap header is reissued with the corrected forbidden list (its
blanket prohibition on the detection file was W3D's pre-understanding
error; the detection CONTRACT remains untouched, as bounded above).

## 2.7 RATIFICATION REQUESTED - D-2C-6: creation-order placement of refusals

```text
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

## 2.8 Additional proof obligations created by this resolution

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

# 3. Evidence and wording for Q4 (K30/K31)

W3D verified both against the charter text and the attached source. Both are
genuine sweep results: applicable, unmapped, and capable of producing two
divergent implementations that both pass the current obligations. Per D0
section 6 they become index entries.

## 3.1 RATIFICATION REQUESTED - K30 (from W3C F2a)

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

## 3.2 RATIFICATION REQUESTED - K31 (from W3C F2b)

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

D0 advances to v1_10 to carry K30/K31; D4's section 9 checklist gains the
two rows (D3's mirror is Q9). No obligation VALUES change.

# 4. Evidence and wording for Q5 (README authority)

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

## 4.2 The five README passages this scope touches, and their currency

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

The post-2C README currency audit remains on W3D's standing task list; the
five items above are its seed list.

# 5. Wording for Q6 (two release states)

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

The D4 v1_8 and bootstrap status lines carry the same distinction.

# 6. Wording for Q7 (packaging follows practice)

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

No reissue of the current package is required. W3C's review stands. The
review itself demonstrated the reader-side rule working: W3C excluded the
forbidden folders, used highest versions, and the review was deterministic
regardless of archive contents.

# 7. Evidence and wording for Q8 (delivery base hashes)

D4 section 8 currently requires the delivery manifest to state "declared
base hash" per file. That predates and contradicts W3X's standing anchor
discipline, recorded in Stage 1C scope v1_5: the base is the PREVAILING
source, verified by upload when the coder is unsure, NOT a pinned SHA -
because branch main receives unrelated document and test-material commits,
so any recorded hash or commit id drifts without a code change. Charter
v1.18's attached-source-tree alternative says the same.

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

TWO HASHES ARE NOT AFFECTED AND MUST BE PRESERVED EXACTLY - they are oracle
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

# 8. Assessment of the W3C review overall

W3C's review is accepted as sound. It found a real blocker that seven design
review rounds and W3D's own successor orientation both missed, refused
correctly to design the fix itself, verified D2 against the pinned snapshot,
and independently reproduced the fixture and corpus mathematics (its
C11/C12/C16/C17 counts extend the 46-value agreement W3D established at
orientation). No arithmetic, schedule, threshold, boundary, fixture or
corpus content changes anywhere in this response.

# 9. W3C re-review scope (agreed)

Per W3C's own request, the re-review after ratification is FOCUSED: the
amended scope lines, the amended file boundary, and the new K30/K31 rows.
No D2, formula, matrix, boundary, sentinel or corpus re-derivation is
needed, because none of that content changes.

# 10. What W3D issues on ratification

```text
D4 v1_8    section 7b amended per D-2C-5 + D-2C-6; section 2 S5 gains
           D-2C-1..4; section 7 gains T-S5-1..5; section 8 amended per Q8;
           section 9 checklist gains K30/K31; section 11 amended per Q6;
           header authority wording per Q5.
D0 v1_10   K30 and K31 added; the README authority paragraph recorded.
D3         per the Q9 decision (recommended: unchanged at v1_8).
Bootstrap  v1_1: forbidden-file list corrected per D-2C-5; authority
           wording per Q5; base-identification wording per Q7/Q8; the two
           release states per Q6.
Manifest   v1_1: packaging amendment per Q7.
Status     v1_22: this review round, the ratifications, and the README
           currency-audit task recorded.
```

---

*Revision history*
```text
v1.1 (2026-08-05) Restructured per the W3X designer communication
     convention v1_0: all nine W3X decisions moved to a self-contained
     plain-English section 1 (Q1-Q9), each with question, stakes,
     recommendation, options and trailing refs; evidence and ratification-
     ready wording retained in the body, renumbered. Content decisions are
     UNCHANGED from v1.0 with one exception: v1.0's Q-G (D3 reissue) now
     carries an explicit W3D recommendation (leave D3 at v1_8) instead of a
     neutral menu, per convention 2(c). Supersedes v1.0.
v1.0 (2026-08-05) Initial W3D response. F1 confirmed cold against source
     and resolved with six proposed decisions; F2a/F2b confirmed and
     proposed as K30/K31; F3a confirmed and extended with a named README
     supersession list; F3b and F3c confirmed with proposed wording; two
     new W3D findings raised (delivery base hashes vs the prevailing-source
     anchor; creation-order placement of the three new refusals).
```
