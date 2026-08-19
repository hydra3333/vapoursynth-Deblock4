# Deblock4 - Project Status

**Version:** 1.33
**Date:** 2026-08-19
**Status:** Current implementation and proof-state record. Informative, not controlling.
**Project:** Deblock4
**Repository:** https://github.com/hydra3333/vapoursynth-Deblock4
**Branch:** `main`
**Encoding:** US-ASCII only.

---

# 0. STATE ADVANCE (v1.33, 2026-08-19) - read this first: T1S01a5 IS IN
# CORRECTION; THE SEARCH POPULATION AND SWEEP METHOD HAVE CHANGED

```text
NO CODE HAS CHANGED. Identity remains 0.1.0-dev+5C. Classic is complete for
the ratified integer tiers; deblock4.Deblock4 still has NO FILTERING KERNEL -
all three dispatch arms are pass-through writable copies. Architecture
unchanged: B2 primary, D the mandatory detector-free comparator, Q14 decides.

T1S01a5 - authority sections 1-8, lines 223-715 - IS NOT CLOSED.
  Ledger at v1.5, 34 entries. A W3X-selected Tier C sample of 11 returned
  3 AGREE and 8 DISAGREE; all eight were verified by W3D and all eight hold.
  W3X then directed a re-sweep of all 34 rather than patching eight.
  The re-sweep was issued for cross-check. W3C reproduced the 46-file
  population and ALL 22 probe counts exactly, and then found SEVEN
  CLASSIFICATION defects plus one arithmetic defect.
  NEXT: a bounded classification repair, then the ledger rewrite. Six
  dispositions change; 28 of 34 survive.

THE SEARCH POPULATION IS NOW 46 FILES, and it is NOT the 47-document
adjudication population. Three mechanical path tests: exclude any folder whose
name begins "superseded" or "scheduled_for_deletion" (DEC-60); exclude
everything under T1/ (DEC-63); exclude GAIS_investigations/ as evidence-only
(DEC-66).

THREE SWEEP METHOD RULES NOW BIND: open every hit and classify it; normalise
whitespace on phrase searches; search the proposition, not the sentence, using
a bounded declared probe family.

ALSO RATIFIED SINCE v1.32:
  DEC-64  SUPERSEDED is split by kind - OVERTAKEN or ERRONEOUS - with a
          PROPAGATION search required for the erroneous case. W3C to verify
          the wording under I7. Not yet binding.
  DEC-65  Task T8 opened: close the provenance gaps T1 surfaces. Five are
          already named, F8 first because the whole architecture rests on it.
          T8 runs BEFORE T5 and blocks T7.
  The T1S01a5 / T1S01a5b split is ratified: sections 1-8 and 9-13.

THE FAILURE TALLY IS AT ELEVEN (DEC-41). Do not re-derive it - it was
deliberately not incremented for recurrences of an already-recorded pattern.
```

---

# 0. STATE ADVANCE (v1.32, 2026-08-18) - read this first: T1S01a3 AND
# T1S01a4 CLOSED; THE SUB-TRANCHE STRUCTURE IS RESTRUCTURED

```text
NO CODE HAS CHANGED. Identity remains 0.1.0-dev+5C. deblock4.Deblock4 still
has no kernel, and no kernel scope may be drafted before D4-Q14 reports.

THIS SECTION IS NOT THE T1 TASK LIST AND MUST NOT BE USED AS ONE.
    Deblock4_T1_Resume_Brief section 0a, HIGHEST COMMITTED VERSION, is the
    maintained record of which sub-tranche is live and what is owed. It is
    bumped whenever a sub-tranche is issued or closed; this document is not.
    IF THEY DISAGREE, THE RESUME BRIEF IS RIGHT.

WHAT CLOSED:
    T1S01a1  CLOSED BY DECISION, not by reissue (DEC-54). W3C rejected both
             entries; PR-1 and PR-2 were then resolved at register level and
             W3X-ratified (DEC-24, DEC-25). No corrected a1 ledger exists or
             is needed. Two things flow from it: DEC-24's 12.5/13.1 pointer
             remedy is RE-DERIVED at T1S01a5, and W3X still owes an explicit
             confirmation that PR-1's block on T5 is lifted.
    T1S01a2  reissued at v1.1; W3C spot-checked the reissue and PASSED it.
             NOT reopened for old-format entries; those reconcile at the
             final sub-tranche (DEC-39).
    T1S01a3  CLOSED at ledger v1.4, provisionally, on W3C's recommendation
             (DEC-42). Three ledger versions, three W3C reviews.
    T1S01a4  CLOSED at ledger v1.4, provisionally (DEC-52). Five ledger
             versions, four W3C reviews.

THE SUB-TRANCHE STRUCTURE WAS RESTRUCTURED (DEC-53), and the reason matters:
T1S01a3's coverage declaration had assigned "sections 1-22 and Appendices
A-D" to LATER SUB-TRANCHES WITHOUT NAMING THEM, and nothing picked the body
up. Declaring the next sub-tranche FINAL would have run the whole-document
consistency pass over a document most of which was never swept.
    T1S01a5  BODY PART 1 - sections 1-13. NEXT.
    T1S01a6  BODY PART 2 - sections 14-22 plus Appendices A-D.
    T1S01a7  DECLARED FINAL: the older Appendix E entries, the six owed
             corrections, and the whole-document cross-entry consistency
             pass, which happens THERE AND NOWHERE EARLIER.

THE MAIN TECHNICAL RESULT OF T1S01a4, provisionally adopted and W3C-confirmed
(DEC-45): authority section 23 builds the ReleaseSafe scalar oracle at step 8
and decides the Schedule-SA/SB winner at step 9, while line 1153 says the
winner becomes part of that oracle and the charter's oracle-construction
exception lists SCHEDULE among the obligations the oracle scope is accepted
AGAINST. Step 8 CONFLATES TWO ROLES AND TWO ACCEPTANCE STATES - a comparison
candidate, which is not an accepted oracle, and the accepted oracle itself.
What is proved is separation of STATUS AND ACCEPTANCE BASIS, not object
identity; the same implementation may evolve across both roles. NOT RATIFIED
and not to be cited as settled.

AN ACCEPTANCE GAP IS OPEN AND REGISTERED (DEC-46): the comparison candidates
produce pixels but are not the oracle, so neither the differential rule nor
the oracle-construction exception plainly covers them. It BLOCKS the
candidate-building scope, not T1. W3D deliberately did not close it - that
would be W3D authoring the criteria for W3D's own future deliverable.

THREE PROCESS RULES NOW BIND, all designer-proposed and W3C-improved:
    STAY-CANONICAL and its evidence requirement (DEC-38, DEC-43) - a copy
        that IS the canonical home stays because it is canonical, not by
        exception, and must name at least one concrete non-canonical copy.
    CHECK-EVIDENCE (DEC-50) - a claim that a check was performed must
        identify the population examined and the basis, testably. Enumerate
        for bounded checks; invent no artificial ranges; a bare assurance is
        not evidence.
    PARTIAL-REPLACEMENT (DEC-51) - after replacing a rejected formulation,
        declare the replacement scope, search by the method appropriate to
        the PROPOSITION rather than the string, and classify what is found.

THE FAILURE TALLY IS AT NINE (DEC-41), and not one instance was caught by its
author or prevented by a rule. Every one was found by the independent
reviewer reading the whole artifact rather than the part under discussion.
That is the strongest evidence this project has that the three-way process is
load-bearing rather than ceremony.

NOTHING HAS BEEN RATIFIED INTO ANY AUTHORITY DOCUMENT AND NO AUTHORITY
DOCUMENT HAS BEEN EDITED. Every ledger remedy is a PROPOSAL. The MPEG-2
authority is still v1.05 and that is deliberate.

CURRENT GENERATIONS ARE DELIBERATELY NOT LISTED HERE. Use the HIGHEST
COMMITTED VERSION of each document; a pinned list in an informative status
document is a scheduled defect and this one has staled twice.
```

---

# 0. STATE ADVANCE (v1.31, 2026-08-18) - read this first: T1S01a3 REISSUED;
# ROUTING CONTRADICTION CORRECTED

```text
NO CODE HAS CHANGED. Identity remains 0.1.0-dev+5C. deblock4.Deblock4 still
has no kernel.

ROUTING CORRECTION. The v1.30 text below says T1S01a3 includes section 23
steps 6-10 and that the ordering defect is deferred to a3. THAT IS WRONG and
is corrected here: DEC-35 split T1S01a further, and section 23's tail with its
ordering defect is T1S01a4. Task register DEC-32 carried the same stale route
and is corrected at register v1.12. W3C found the contradiction and correctly
followed DEC-35 as the later and more specific decision.

    T1S01a3   section 0's architecture items and the header's remaining
              statements. ISSUED, REVIEWED, REISSUED at v1.1.
    T1S01a4   section 23 steps 6-10, carrying the DEC-32 ordering defect. NEXT.
    T1S01a5   Appendix E, and the FINAL sub-tranche of this document, where
              whole-document cross-entry consistency is checked.

T1S01a3 WAS REISSUED because W3C found the ledger applying a rule W3X had not
ratified: it proposed a duplicate-handling exception, wrote that the exception
must not be applied retroactively, and had already applied it in seven
entries. The rule is now ratified in W3C's wording, not W3D's - see register
DEC-36 - and eleven of the reissue's twelve corrections came from W3C.

A NEW RULE NOW BINDING: RETAIN-SUMMARY (review scope v1.9 section 5.4). A
non-canonical duplicate normally becomes a pointer; the exception is an
explicitly designated summary layer INSIDE the canonical authority, which may
be retained provided each proposition's canonical source is named and the
summary adds nothing normative. This is what protects the MPEG-2 authority's
read-first section 0 from being hollowed out by the later de-duplication work.

FOURTH INSTANCE OF THE SAME DESIGNER FAILURE, recorded at register DEC-37. The
SWEPT field added after instances one to three would NOT have caught this one,
because the failure takes a different form each time. W3C caught all four, in
every case by reading the source rather than the ledger.

CURRENT GENERATIONS: charter v1.31; task register v1.12; review scope v1.9;
manifest v1.4; resume brief v1.1.
```

---

# 0. STATE ADVANCE (v1.30, 2026-08-18) - read this first: T1 IS RUNNING; TWO
# LEDGER SUB-TRANCHES REVIEWED; CONTROLLING-DOCUMENT COMPATIBILITY RECORDED

```text
NO CODE HAS CHANGED. Identity remains 0.1.0-dev+5C. deblock4.Deblock4 still
has no kernel. Everything below is documentation and process state.

CONTROLLING-DOCUMENT COMPATIBILITY, recorded per charter 2.3b because W3C
looked for this record and did not find it:

    T1 review scope v1.7  /  charter v1.31  :  COMPATIBLE

    Basis: W3C compared charter v1.31 against v1.29. The operative change is
    the neutral README wording in the embedded bootstrap template, plus
    revision history. No rule and no invariant changed, and there is no
    material effect on the T1 review scope. No scope reissue was required on
    that account. The scope has since advanced to v1.8 for UNRELATED
    process-criteria corrections - see task register DEC-33.

CHARTER GENERATION NOW IN FORCE: v1.31. v1.30 corrected a stale README
pointer inside the embedded bootstrap template; v1.31 made that block's
heading neutral, because the README's classification is under a pending
ruling and reclassifying it is sequenced behind T1 and T3. NEITHER changed a
rule or an invariant, and the clauses that operate on the controlling
specification - I2, P-09 and the scope attachment and quoting rules - were
verified intact after the edit.

T1 PROGRESS SINCE v1.29:
    T1S01a1   reviewed; both entries rejected by W3C; corrections recorded
    T1S01a2   issued, reviewed, and REISSUED at v1.1 after W3C found that a
              range had been declared adjudicated while only a selection of
              its statements was logged. Now ten entries with an explicit
              coverage declaration and every omission assigned to a named
              later sub-tranche
    T1S01a3   NEXT - section 0's architecture items, the header's remaining
              statements, and section 23's steps 6-10

A REAL DEFECT FOUND IN THE MPEG-2 AUTHORITY ITSELF, by W3C, NOT YET REPAIRED:
authority section 23 step 8 builds the ReleaseSafe scalar oracle and step 9
decides the Schedule-SA/SB winner - but authority line 1153 says that winner
"becomes part of the future Deblock4 scalar oracle". The document specifies
building an artifact before the decision that defines part of it. THE
REPAIRED ORDER IS NOT ESTABLISHED and must be derived rather than guessed,
because scalar candidate implementations may be needed to compare schedules
in the first place. Deferred to T1S01a3 with the finding attached. See task
register DEC-32.

PROCESS CORRECTIONS NOW BINDING (task register DEC-31, DEC-33):
  - a sub-tranche must declare the EXACT statements it adjudicates and assign
    every omission to a named later sub-tranche;
  - one disposition covers one proposition;
  - any claim that something is UNIQUE, INDEPENDENT or UNAFFECTED must record
    WHAT WAS SEARCHED to establish it - added after W3D made that class of
    unchecked assertion three times, twice in entries where W3D had flagged
    the risk in the same breath;
  - CURRENT-DUPLICATE must identify the canonical home.
```

---

# 0. STATE ADVANCE (v1.29, 2026-08-18) - read this first: T1 IS RUNNING AND
# ITS FIRST LEDGER WAS REJECTED; RECOVERY WRITTEN AFTER A CODER CHAT DEATH

```text
NO CODE HAS CHANGED. Identity remains 0.1.0-dev+5C. deblock4.Deblock4 still
has NO kernel - all three dispatch arms are pass-through copies, verified
cold in the supplied source tree. Everything below is DOCUMENTATION and
PROCESS state.

T1 IS NO LONGER POSTPONED. W3X reversed the sequence on 2026-08-17: T1 now
runs BEFORE T5, because T5 derives detector mathematics and the README has
already proved it can hide a fully-worked ratified apparatus that nobody
swept. Discovering that after T5 is ratified would cost T5, T6 and possibly
a Q14 re-run.

THE SWEEP IS BIGGER THAN v1.28 SAID. It is not 17 documents. The population
is 47 live documents under a FROZEN 90-term search frame, in six steps
ordered by RISK rather than size. The v1.28 figure came from a survey that
searched the dev_documentation ROOT ONLY.

PR-5 - THE FOLDER-SELECTION FINDING. That root-only survey missed two entire
live folders: Scopes/ (6 documents, 2,817 lines) holding the primary working
record of the ARCHITECTURE RE-DECISION ITSELF, and GAIS_investigations/
(6 documents, 941 lines). Twelve documents, 3,758 lines. This is the same
failure as the founding incident in a different dimension - that one missed a
document because its LABEL said it did not matter; this missed twelve because
they were in a FOLDER nobody searched. Both are SELECTION failures, not
reading failures.

T1 PROGRESS:
  T1S00   scope manifest .............. COMPLETE (v1.3, frame frozen)
  T1S01a1 first ledger tranche ........ ISSUED; BOTH ENTRIES REJECTED BY W3C
  T1S01a2 rest of the authority ....... HELD pending the ledger template fix
  T1S01b  Scopes/ + GAIS record ....... not started
  T1S02-3 README parts 1 and 2 ........ not started
  T1S04   charter, D0 index, D2 ....... not started
  T1S05   remaining documents ......... not started

NOTHING HAS BEEN RATIFIED INTO ANY AUTHORITY DOCUMENT. No authority document
has been edited. The sweep has so far produced two proposed adjudications,
both rejected.

THE TWO PRE-REGISTERED ITEMS ARE RESOLVED, BOTH AGAINST W3D:
  PR-1  W3D proposed that the in-principle false-activation limit is
        universal and that authority 12.5 is its unique but misfiled home.
        WRONG. Authority 13.1 ALREADY STATES the general principle - "Do not
        let a local edge predicate become an implicit geometry classifier" -
        outside the rejection proof, among rules retained because they are
        "still exactly right". 12.5 uniquely holds the PROOF, not the
        principle. Likely remedy is a pointer from 13.1 to 12.5, far smaller
        than the relocation proposed.
  PR-2  W3D proposed the tc0-unscaled rule as a standing kernel principle on
        the ground that evidence thresholds and correction strength are
        structurally independent. WRONG. The shipped parameter
        `boundary_strength_offset` offsets the index used for `alpha` AND
        `tc0` - one control moving both. Preserved as history; the coupling
        question opens under D4-Q02/D4-Q05.

T5 STATUS CHANGED. PR-1 was registered as BLOCKING T5. Since the constraining
principle already exists at 13.1, W3X confirmed on 2026-08-18 that the block
LIFTS once the 13.1 pointer is ratified - but the T1-before-T5 sequence is
UNCHANGED, because that ordering was decided for reasons independent of PR-1.

LEDGER TEMPLATE DEFECT, FOUND BY W3C AND BEING FIXED BEFORE T1S01a2: entries
mixed the DISPOSITION of an existing quoted statement with a NEW PROPOSITION
derived by the designer. DISPOSITION is now restricted to the five registered
values and nothing else; derived propositions go in a separate, separately
reviewable field. W3C's reason is worth keeping verbatim: otherwise future
entries can make a statement "current in substance" by inventing the
substance they wish it had.

RECOVERY EVENT. The coder chat reached its length limit immediately after
posting those verdicts. Deblock4_T1_Resume_Brief_v1_0 was written and emitted
FIRST, before any larger document refresh, because designer chat 2 died
holding an undelivered batch of eight documents and a brief exactly like it
is what saved the project then.

RECORDED W3D FAILURES FROM THIS ARC (added to the standing list below, kept
because they are cheap to repeat):
  - adjudicated a statement as the UNIQUE home of a principle without
    sweeping the SAME DOCUMENT for whether the principle already lived
    elsewhere. It did, three sections later. W3D had read that section
    earlier in the same session - prior familiarity is again what made not
    re-checking feel safe;
  - asserted that evidence thresholds and correction strength are
    structurally independent without checking the project's own parameter
    surface, where one shipped control couples them.
  Both occurred in the FIRST LEDGER T1 PRODUCED - i.e. the designer repeated
  inside T1 the exact failure T1 exists to correct. W3C found both in one
  pass. The corrective is not "more care"; it is that no adjudication is
  trustworthy because its author was careful, including one that reads well.

PENDING W3X RULING (carried forward, still open): the README's status. Its
destination is settled - it becomes USER-FACING product documentation holding
no controlling information - but it CANNOT be reclassified until T1
adjudicates it and T3 strips it, because reclassification is a promise about
content.
```

# 0. STATE ADVANCE (v1.28, 2026-08-16) - read this first: POST-5C MAINTENANCE
# COMPLETE; DEBLOCK4 ARCHITECTURE DECIDED BUT GATED ON A MEASUREMENT

```text
CLASSIC IS FINISHED for the ratified tier set (int scalar 2C oracle, int
SSE4.1 4C, int AVX2 5C, all byte-identical). Two post-5C maintenance
scopes are complete: M1 (SSE4.1 maintainer commentary reconciled to the
v3 standard, comments-only with executable inertness PROVEN) and M2
(stage-bound vocabulary retired to selection_and_creation_contract, and
the superseded build_1C/2C/4C batches plus orphaned tooling deleted with
the retirement ENFORCED in the S2 tripwire). Identity remains
0.1.0-dev+5C; M1 and M2 are maintenance commits on top of it.

DEBLOCK4 IS NOW THE ACTIVE WORK, AND IT HAS NO KERNEL. Its dispatch arms
are validated pass-throughs; the filter validates parameters, echoes
configuration and returns frames unchanged. A four-round external
investigation plus two W3C rounds settled the MPEG-2 geometry facts and
decided an architecture. THE PREVAILING AUTHORITY for all of it is:

    Deblock4_MPEG2_Deblocking_Investigation_and_Decided_Architecture
    (latest version; SECTION 0 is the read-first current position)

It supersedes Deblock4_MPEG2_Grid_Field_DCT_Knowledge and prevails over
every raw GAIS response and over MPEG-2 statements elsewhere in the set.

THE POSITION IN BRIEF (full detail in that document):
  - Input: the WHOLE interleaved frame plus a three-value declared mode
    (progressive / frame-coded-interlaced / field-pictures).
    SeparateFields is NOT supported - it tears frame-organised blocks
    across two clips. The "mpeg2_field_separated" vocabulary is retired.
  - 4:2:0 chroma is ALWAYS frame-organised even under field DCT
    (H.262-VERIFIED; this CLOSED checklist item G1, pending since 4C).
    4:2:2/4:4:4 chroma follows luma.
  - Luma is the hard part: dct_type is per macroblock and invisible in
    decoded pixels.
  - ADOPTED: Architecture B2 (classify each 16x16 macroblock
    FRAME/FIELD/UNKNOWN, then DERIVE edge topology - the mixed-neighbour
    seam becomes an explicit edge type) as primary; Architecture D
    (detector-free, conservative) as mandatory fallback and comparator.
  - REJECTED: Architecture A (the README union step-4 grid) - its
    geometry was an artefact of separated-field coordinates and its
    "let the activation test decide" premise has a proven in-principle
    false-activation floor; and Architecture C (motion classification).
  - Vertical edges are geometry-invariant at x = 8k, so SIMD is not
    impeded by any of this.

THE GATE - NEXT ARTIFACT IS AN EXPERIMENT, NOT CODE. The D4-Q14
discriminator experiment decides B2 vs D on ground truth: extract
per-macroblock dct_type from real PAL MPEG-2 bitstreams, run both legs
over the decoded pictures, and measure B2's confusion matrices,
confidence margins, UNKNOWN rate and FALSE-CONFIDENT rate, plus the
A/D leg's true-vs-false candidate feature distributions with ROC sweeps.
NO KERNEL SCOPE MAY BE DRAFTED BEFORE IT REPORTS.

PROCESS WORK POSTPONED BY W3X: T1 consolidation sweep of the 17
MPEG-2-bearing documents (only README 3.11/3.13 read so far); T2 retire
the Grid Knowledge doc with its currency-audit edit; T3 de-duplicate
MPEG-2 content into references; T4 boundary-set mathematics; T5 detector
mathematics; T6 the D4-Q14 plan; T7 commit. PENDING W3X RULING: the
README's status - it holds ratified design and is currently described as
"fallback general guidance", which is what allowed a whole architecture
to go unread through four investigation rounds.

RECORDED W3D FAILURES FROM THIS ARC (kept because they are cheap to
repeat): sweeping decisions but not SPECIFICATIONS; two wrong pro-A
arguments (threshold scaling is a hard decision, not soft confidence; it
avoids classifier flicker but not threshold flicker); a casual temporal-
hysteresis proposal that would have broken fmParallel determinism; and
an unachievable raw-byte-identity proof predicate at M1. W3C caught every
one before cost was incurred.
```

# 0. STATE ADVANCE (v1.27, 2026-08-15) - read this first: STAGE 5C ACCEPTED, COMMIT-READY; NO ACTIVE SCOPE

```text
STAGE 5C IS ACCEPTED (W3D artifact review, 2026-08-15). The Classic v3
(AVX2-class) backend is the SAME frozen width-generic vector body
instantiated at 256-bit - u8 N=32, u16 N=16 - inside a new thin object
compiled at the exact named x86-64-v3 level, and it is proven byte-for-byte
identical to the committed 2C scalar oracle. Full matrix green:
OUTER_BATCH_EXIT_CODE=0. Identity 0.1.0-dev+5C. Accepted DLL sha256
02381dfc...99628736 (the SAME binary carried the positive and the retained
4C-regression differentials).

EVIDENCE (W3D-verified from the retained summary artifacts, not from console
claims):
  5C-T1  35/35 vector tests in all three modes across two v3-target legs -
         28 frozen-body tests + 7 new tests in tests/classic_vector_backend
         _5c_tests.zig covering every u8 remainder 1..31 and u16 1..15 with
         eight seeded trials each, D3 A/B/O-4/O-5d/O-7 fixtures at the new
         widths, the exhaustive 8-bit p0/q0 lane sweep, deliberate non-16/
         32-byte base alignment and non-vector strides with prefix/row-slack/
         suffix canaries intact, and vertical bottom underfill at 1, 2, 3.
  5C-T2  Positive differential ALL_PASS: 17 cases, three-way v1/v2/v3,
         total_diff_bytes 0, region-targeted non-vacuity true on every case
         (e.g. PAL 720x576 u8 remainder-16: 35899 changed samples in the
         named tail strip; 4:2:2 738-wide chroma remainder-17: 104056).
         Remainder classes 1/15/16/17/31 forced on luma AND on the chroma
         planes of legal even-width 4:2:0/4:2:2 frames.
  4C reg Retained 18-case scalar-vs-v2 regression ALL_PASS on the same DLL.
  5C-T3  Containment: v3 object 930 YMM references and 6 vzeroupper; v2
         object ZERO YMM; the v3 object's 1197 XMM references are the
         legitimate descending-tail sub-instantiations (S5C-5 note). DLL
         export table excludes all four backend C roots.
  5C-T4  Selection: auto -> v3 (capability-derived), explicit v1/v2/v3 each
         resolve to themselves, version 5C on every leg; the retired
         intentionally-capped(v2) expectation is asserted ABSENT.
  5C-T5  Negative controls all fired correctly: named-model perturbation
         rejected for BOTH v2 and v3 guards; the one-lane V1 tail mutation
         was caught by the frozen-body tests (6 fail), by the NEW 5C tests
         (5 fail), and by the differential (6652 differing bytes) - each
         mutant run against a different DLL hash, in an out-of-repo copy.
  5C-T6  Benchmark recorded, NEVER gated (S5C-3 / 5C-RAT-4).

BENCHMARK RESULT - SETTLED KNOWLEDGE (the measurement-gated "actual AVX2
speed benefit" question is now CLOSED by evidence): synthetic 720x576
YUV420P8, strength 25, 240 frames, one discarded warm-up + three recorded
runs per backend, wall-clock around the vspipe process.
    x86_64_v1_baseline    mean 0.3182 s   (1.000x)
    x86_64_v2_with_sse41  mean 0.2853 s   (1.115x)
    x86_64_v3_with_avx2   mean 0.2770 s   (1.149x)
AVX2 buys roughly 3 percent over SSE4.1 on this workload. This is CONSISTENT
WITH THE RATIFIED DESIGN, not a disappointment: the vertical-edge path is
width-invariant by algorithm (Schedule A's four-step dependency caps vertical
lanes at 4 - 4C-RAT-3), so only horizontal batching widens; and deblocking is
substantially memory-bound. CONCLUSION FOR FUTURE TIER DECISIONS: Classic is
bandwidth- and vertical-path-bound; further width alone is not where the
remaining time is. No number here is normative (charter A3); this is a
measured record, not a target.

VALIDATION HISTORY (honest record): the v3 production source was correct at
first delivery and never changed. Two blocking findings were both in
scaffolding: W3D-5C-F1 (the batch retained the Stage 4C-era executed n02b
gate, which expected explicit v3 to be REFUSED - the very thing S5C-6 makes
false; remedied by deletion, following the 4C n02a precedent) and W3D-5C-F2
(the new test module rooted three frozen files in separate modules while the
frozen vector body also imports two of them by path, which Zig forbids;
remedied by the ratified test-only re-export shim so the frozen files stay
single-moduled and byte-frozen). Separately, a W3D benchmark-runner defect
(a generator quoting fault that emitted an invalid .vpy) was found and fixed
on the W3D side at v1.1, proven end-to-end before reissue. W3D's own delivery
review missed F1; recorded.

COMMIT-READY SET: coder delivery v1_2 as applied (new src/classic_backend_v3
_avx2.zig, src/classic_5c_frozen_reexport.zig, tests/classic_vector_backend
_5c_tests.zig, build_5C_v1.bat; modified build.zig, classic_ar_all_frames
_ready.zig, deblock4_config.zig, deblock4_selftest.zig, deblock4_version.zig)
plus the W3D harness set under tools/stage_5c/ (run_stage_5c_differential
.cmd, stage_5c_scalar_vector_diff.py, run_stage_5c_benchmark.cmd,
stage_5c_benchmark.py v1.1). Evidence retained under zig-out/inspection_5C.

NEXT: no active implementation scope. Registered follow-ups, in no forced
order: the post-5C v2-unit commentary reconciliation (5C-RAT-7); the
identifier-cleanup hygiene pass; the deferred quality phase (T-1 c0-from-
alpha); the bounded float step; Deblock4-side stages 4D/5D. W3X releases the
next stage.
```

# 0aa2. PRIOR STATE ADVANCE (v1.26, 2026-08-13) - STAGE 4C ACCEPTED, COMMITTED-READY; STAGE 5C NEXT

```text
STAGE 4C IS ACCEPTED (W3D acceptance review v1_0, 2026-08-13). The Classic
SSE4.1 vector backend is proven byte-for-byte identical to the committed 2C
scalar oracle: the full validation matrix passed with outer exit code 0 and
zero failed steps on the Windows R79 build - 85/85 obligation tests in three
modes, ReleaseSafe==ReleaseFast production identity, 28/28 vector unit tests
(every remainder + the four-row vertical lane pack), the 18-case end-to-end
scalar-vs-v2 differential (byte-identical, region-targeted non-vacuity),
instruction-level tier containment, and the tail-corruption control correctly
rejecting a one-lane mutation. Identity 0.1.0-dev+4C. Accepted DLL sha256
d907ff82...50bd7d7.

VALIDATION HISTORY (honest record): the vector production code was correct at
first delivery and never changed. Every failure met during validation was in
the test harness or the test-corpus content: three W3D differential-harness
fixes (VapourSynth environment setup transplanted from a proven script; frame
generators/comparison idioms aligned to proven forms; the blocky test pattern
softened so it triggers filtering) plus a region-targeted non-vacuity check;
then the accepted W3C validation-repair package v1.2 (whole-token instruction
matching so AVX2 pext no longer matched SSE4.1 pextrb; runner success-marker
check; a direct one-lane cleanup unit test); then a final W3D-specified,
W3X-applied two-line batch edit moving the deliberate corruption to the
final-column cleanup path the filter actually executes, made under the
no-coder-session provision (production source untouched).

COMMIT-READY SET (see the W3D acceptance review v1_0 for the file table and
the provided commit message): the 8 code files (5 replaced + 3 new), the
amended tests/stage_2c_classic_obligations.vpy, and the two W3D harness files
under tools/stage_4c/.

DOCUMENTS REFRESHED THIS PASS (post-4C currency): coder intro v1_22 (plain
English + plain-speaking instruction); designer intro v1_20; and the set
listed at the foot of this section as it is produced.

NEXT STAGE: Stage 5C - the Classic v3 / AVX2 (256-bit) backend. It reuses the
width-generic vector body (classic_vector_backend.zig) at the wider width, adds
its own thin object (classic_backend_v3_avx2.zig), and re-proves the tail/edge
behaviour at 256-bit against the same scalar oracle. There is a known AVX2
edge-corruption hazard the 5C scope must make fully explicit. Not yet scoped.
```

# 0aa. PRIOR STATE ADVANCE (v1.25, 2026-08-12) - STAGE 4C SCOPED, DESIGN ROUND COMPLETE, IMPLEMENTATION RELEASED

```text
VERSION-SYNC NOTE (fixes W3C response F3): the COMMITTED v1.24 predates
the same-day 3C-collapse ruling; the W3D working copy carried it. This
v1.25 is the reconciled record and supersedes v1.24 everywhere.

SINCE v1.24: the end-of-phase pass completed (README v1_10; F10 into
D4 v1_10 / D0 v1_12 / D3 v1_11 / V&T v1_11, closing the never-
committed-accepted-set gap; coder-intro v1_21; identifier-cleanup RULED
clean-up as a bounded future scope; charter v1_27 C-DELIV-01/10/11).
STAGE 3C COLLAPSED (W3X): its only content, T-1 (WP-5 c0-from-alpha-
index), is a K19(a)/K20 QUALITY question deferred to a dedicated
enhancement phase; the acceptance basis 3C would have ratified is
already in force (S4/K19(c)).
CHROMA-GRID FORK RESOLVED ON EVIDENCE: the suspected Classic chroma
defect dissolved - the traversal is plane-relative and MPEG-2 4:2:0
chroma DCT blocks are 8x8 in chroma coordinates and ALWAYS
frame-organised, now NORMATIVELY CITED (ISO/IEC 13818-2 subclause 6.1.3
verbatim + 3.12/3.85/6.1.1.8; knowledge doc v1_1 with a GAIS
confirmation checklist; GAIS substantively concurred). Classic remains
the faithful HolyWu clone; the subsampling-aware gated Y/UV design is
Deblock4's ratified specification (stages 3D+), and NOTHING in
Classic's vector code is a design or acceptance basis for Deblock4.
STAGE 4C SCOPED AND RELEASED: scope v1_0 -> v1_1 (naming:
classic_vector_backend.zig width-generic body + classic_backend_v2_
sse41.zig thin object; identity 0.1.0-dev+4C) -> the MANDATORY three-
way pre-implementation round: W3C response v1.1 (high quality; W3D
review v1_0) CONFIRMED P1/P3 (band-reorder proof from the frozen
source), AMENDED P2 (four-row vertical lane pack; the vertical 4-lane
cap is the ALGORITHM'S - Schedule A's 4-step dependency - not the
implementation's; compute is full-width @Vector(4,i32) at 128-bit) and
P4 (Zig vectors have NO defined byte layout: defined-coercion
loads/stores only, vector-pointer overlay on frame memory FORBIDDEN -
the round's best catch), CONFIRMED P5 (descending same-body tails,
normative tables adopted). Findings: F1 (W3D checklist omission -
BLOCKER, fixed by scope v1_2 section 3b), F2 (K17 stale -> D0 v1_13
K32), F3 (this version-sync), F4 (self-reclassification). All eight
4C-RAT items W3X-ratified 2026-08-12 incl. RAT-6: the T5 tail-
corruption control runs as a temporary OUT-OF-REPO mutated copy.
CURRENT STATE: scope v1_2 is the CONTROLLING document; W3C
IMPLEMENTATION IS RELEASED. Owed alongside: the W3D differential
harness (.vpy/.cmd) before final validation; roadmap annotation of the
3C collapse at next roadmap touch.
```

# 0a. PRIOR STATE ADVANCE (v1.24, 2026-08-12) - STAGE 2C ACCEPTED AND COMMITTED

```text
STAGE 2C IS COMPLETE, ACCEPTED, AND COMMITTED TO main (2026-08-12).
The deblock4.Classic ReleaseSafe scalar oracle is built, wired into the
Classic integer production path, and proved against the pinned external
HolyWu r9 scalar reference. Tree identity: 0.1.0-dev+2C.

VALIDATION RESULT (W3X-run; W3D-reviewed; W3C-concurred):
OUTER_BATCH_EXIT_CODE=0. 85/85 tests in Debug/ReleaseSafe/ReleaseFast;
RS==RF production byte identity (K10); sanity gate 8.0 -> 1.703125
boundary reduction (the ratified 78.7%) with the negative control
correctly rejected; all six Addendum A sentinels equal to ratified
values; 17/17 differential cases byte-exact (first_difference null)
against the hash-pinned opt=1 HolyWu DLL under autoload-disabled
isolation; the named-model BMI2 perturbation caught at comptime.
Independently confirmed by the W3D derivation model and a native W3D
re-execution of the pure-module obligation suites (28/28). Evidence
retained by W3X under inspection_2C (not committed source, D4 7d).

DELIVERY HISTORY: after three review rounds and a no-script redelivery
(delivery v1.0 + F-1 rider retired; the auxiliary PowerShell machinery
removed by W3X ruling), the accepted package is the v2.0 redelivery
(manual copy application; K30 as delivery evidence + independent W3D
re-verification; single HolyWu .cmd build driver) PLUS five repair
deltas applied during W3X/W3C iterative fixing, all W3D-reviewed clean
in the final artifact review (2026-08-12):
  (1) classic_instance_creation.zig: 3-line explicit pointer deref
      (video_info.*.format.X) - the C-pointer field-access fix;
  (2) stage_2c_classic_obligations.vpy: R79 Python API idiom
      (frame[plane]); assertion logic unchanged;
  (3) stage_2c_holywu_diff.vpy: strengthened no-autoload
      EnvironmentPolicy isolation (K26);
  (4) run_stage_2c_holywu_reference.cmd: --info -> --python-script;
  (5) tools/run_vs.cmd (W3X-owned): VSROOT R78 -> R79 + a
      --python-script mode.
The mathematics modules (kernel/schedule/thresholds) were byte-
untouched by every repair.

ENVIRONMENTAL FACT: the portable VapourSynth RUNTIME advanced R78 ->
R79 during the repair iteration (the R79 Python API forced the harness
idiom change; the completed reference record records R79). The IN-TREE
COMPILE HEADERS are unchanged (API4 contract intact; the K31
stride-bytes verification against the R78-era header remains valid).
Documents citing R78 as the runtime gain a currency item in the
end-of-phase pass below.

ORACLE STATUS (S4 / K19(c)): the delivered scalar path IS NOW THE
CLASSIC ORACLE. Every later Classic pixel/frame/copy/backend scope
(3C, 4C, 5C) is accepted only by per-type differential against it
(integer byte-identical).

NEXT STAGE (W3X-ruled 2026-08-12): STAGE 3C IS COLLAPSED. Its only live
content was the tabled T-1 quality question (c0 derived from the alpha
index, D2 WP-5); the compatibility/acceptance basis it would have
ratified is ALREADY in force (S4/K19(c): every later Classic scope is
accepted by differential against the committed 2C scalar oracle). With
T-1 deferred there is no remaining 3C work, so the stage is recorded as
satisfied rather than run.
  T-1 DEFERRAL (registered enhancement candidate): the c0-from-alpha-
  index derivation is a K19 layer-(a)/K20 QUALITY question, NOT a
  correctness or arithmetic-accuracy one (2C is byte-faithful to
  HolyWu, the stronger K19(b) rule, and "do not fix" was deliberate).
  It is not on the path to working MPEG-2 deblocking and is DEFERRED to
  a later dedicated quality/enhancement phase, where any divergence
  must meet the K20 "more accurate must be demonstrated" bar (reduced
  block discontinuities / retained detail / fewer artifacts on
  representative 576i content), never adopted merely for being
  differently derived. Distinct from the project-wide K19(a) "slightly
  more accurate arithmetic acceptable" freedom, which Classic gave up
  for oracle purity under K19(b).
  THE NEXT STAGE IS THEREFORE STAGE 4C: the Classic v2 (SSE4.1-class)
  @Vector backend, accepted by differential (K2 / K19(c) integer
  byte-identity) against the committed 2C scalar oracle - the first
  stage where the ratified explicit-@Vector design is implemented. Then
  Stage 5C (v3 / AVX2-class + performance). The roadmap is annotated
  accordingly; 4C is scoped next.

END-OF-PHASE UPDATE PASS (now ACTIVE - registered standing W3D tasks,
one bundle):
  - README currency audit and reissue (seed list: the W3D response
    section 4.2 - README 12.5/12.6 and 8.1 superseded by S5/S1; 13.6
    absorbs D-2C-4; plus a full charter/ratified-decision reconcile);
  - coder-intro (111_...) refresh: replace the stale 1C IMMEDIATE-NEXT
    block; fold in the standing process rulings (no git staging; the
    refined git rule; no Stage-2C-shipped .ps1 machinery; the W3X
    designer communication convention v1_0);
  - F10 propagation: the ratified f16 storage-never-compute rule and
    its pin-before-K22-tolerances ordering into D4 S1-FUTURE, V&T
    3.4-3.8, and D0 K22;
  - identifier-cleanup: W3X RULED 2026-08-12 -> CLEAN UP. The accepted
    stage-numbered 1C identifiers (runStage1CPureContracts, the
    stage_1c=PASS gate token, and kin) are to be renamed to
    intent-describing names. This is REGISTERED AS ITS OWN BOUNDED
    FUTURE SCOPE, not part of any feature delivery, with these binding
    cautions: (i) it is a COORDINATED ATOMIC rename across all
    surfaces at once - source symbols, the gate-asserted PASS tokens,
    the batch assertions, and any expected-output captures - because
    the tokens are gate-asserted; (ii) it REQUIRES a full proof-matrix
    re-run afterwards to re-establish byte-identity, since the asserted
    proof surface itself changes; (iii) K30 continues to NOT rename
    during normal deliveries - this ruled cleanup IS the separate
    deliberate pass K30 always pointed at; (iv) best sequenced
    alongside another authority-doc/hygiene pass to amortise the
    matrix re-run. No 2C-accepted behaviour changes; names only.
  - refined-git-rule consolidation into the charter delivery standards
    (W3X-ratified wording), so no future memoryless session reinvents
    staging or restore scripts;
  - the R79 runtime currency item noted above.

COMMIT HYGIENE (recorded): the five temporary repair .patch files were
working aids and were excluded from the commit; zig-out/ evidence
stays uncommitted (D4 7d).
```

# 0b. PRIOR STATE ADVANCE (v1.23, 2026-08-05) - FOCUSED RE-REVIEW RESOLVED; READY FOR IMPLEMENTATION RELEASE

```text
THE W3C FOCUSED RE-REVIEW of D4 v1_8 (v1_0, 2026-08-05) is RESOLVED. It
confirmed the F1 seam design implementable and the intentionally-capped
token consistent, and returned: F1 BLOCKER (the new T-S5-1 gate
contradicted D-2C-6 - a W3D defect), F2 BLOCKER (D0 section 5 and D4
K13 still carried blanket detection prohibitions contradicting D-2C-1 -
W3D propagation misses; W3D additionally found a five-vs-four
item-count drift), F3 (K30's empty-audit not objectively defined over
the accepted base), F4 (K31 proof wording did not fit the
byte-addressing model), F5a-e (issuance cleanups + a filing note). W3D
verified every finding cold (file+line); W3X RATIFIED ALL SIX DECISIONS
2026-08-05:
 Q1 T-S5-1 split: T-S5-1a (count 1 for every attempt reaching tier
    selection, success or refusal) + T-S5-1b (count 0 for
    pre-selection refusals N01a/N01b/N01c1/N01c2).
 Q2 D0 section-5 exception relabelled (a)-(e), gains (e) the D-2C-1
    emission relocation; blanket sentences and D4 K13 reworded to
    detection LOGIC; literal counts replaced by the (a)-(e) form.
 Q3 K30 AUDIT CONTRACT, narrow non-cleanup form: new modules audited
    in full (expected EMPTY); existing edited modules audited on their
    2C CHANGES only; accepted Stage 1C regression identifiers NOT
    renamed (decisive fact: stage_1c=PASS is gate-asserted at
    build_1C_v1.bat:195 and that gate class re-runs in build_2C).
    REGISTERED post-2C hygiene-era candidate: a deliberate
    cleanup/rename of accepted stage-numbered identifiers (alongside
    the README currency audit).
 Q4 K31 per-model proof after W3X's stride-units challenge. Verified:
    stride IS bytes (R78 header; HolyWu deblock.cpp:237 divides it by
    sizeof(pixel_t)). Ecosystem survey: HolyWu divides silently;
    zsmooth has NO Deblock filter and divides silently at
    remove_grain.zig:810 while naming units by suffix (stride8/
    stride). Ratified: model (a) BYTE ROW NAVIGATION recommended
    default per W3X preference (no division exists; one named cast per
    row/plane view); model (b) typed sample stride via @divExact or
    explicit modulo assertion, ONE conversion per plane; unit-suffix
    naming idiom recommended; silent unchecked division named
    FORBIDDEN. K31 is strictly stronger than all surveyed prior art.
 Q5 F5a-d adopted (bootstrap base-hash phrase retired; D-2C-5 label
    restored on D4 7b; deblock4_* prohibition scoped to FILTER-PATH
    modules with the three shared/identity files under their narrow
    authorisations; manifest pointer fixes).
 Q6 Review-record filing corrected by W3X: review documents live under
    dev_documentation/reviews/, never scheduled_for_deletion.

DOCUMENTS ISSUED (this round): D4 v1_9; D0 v1_11; D3 v1_10 (mirror
only); bootstrap v1_2; manifest v1_2; this status v1_23. Review record:
W3C focused re-review v1_0 + W3D response v1_0 under reviews/.

NEXT: W3X issues the corrected set; W3C short confirmation of the
corrected lines (no re-derivation); then W3X's EXPLICIT IMPLEMENTATION
RELEASE; W3C authors the 2C delivery under C-DELIV-09; W3D static
review via the 7d crosswalk; W3X runs build_2C_v1.bat and generates the
K26 reference evidence; acceptance and commit. Standing W3D tasks
(the END-OF-PHASE UPDATE PASS, one bundle after 2C acceptance):
- README currency audit (seed list: response v1_1 section 4.2);
- coder-intro refresh;
- the registered identifier-cleanup candidate above;
- propagate Toolchain F10's ratified f16 rule (W3X 2026-08-05: f16 is
  a STORAGE width never a COMPUTE width at the future float step, and
  that compute-width decision is pinned BEFORE the owed K22/V&T 3.8
  tolerance numbers are derived) into every place carrying the float
  work item: D4's S1 FUTURE list (as its fifth requirement), V&T's
  float sections 3.4-3.8, and D0's K22 entry.
TOOLCHAIN WATCH (2026-08-05, Toolchain Findings v1_4): F9 autovec
disabled in Zig 0.16.0 (zsmooth #23; G8 fast-math rejection is the
companion committed decision) - the full-matrix re-run doubles as the
byte-identity proof at any toolchain bump; performance claims state
their toolchain. F10 f16 arithmetic pathology (zig #19550) - triggers
at float-step scoping: re-check issue status; pin HolyWu's FLOAT16
acceptance as an external fact.
```

# 0c. PRIOR STATE ADVANCE (v1.22, 2026-08-05) - 2C PRE-IMPLEMENTATION REVIEW RESOLVED; AWAITING FOCUSED RE-REVIEW THEN IMPLEMENTATION RELEASE

```text
THE SUCCESSOR-W3C PRE-IMPLEMENTATION REVIEW (v1_0, 2026-08-04) is
RESOLVED. W3C performed the D0 section-6 sweep, verified D2 v1_6 against
the hash-checked holywu_r9 snapshot (PASS, no correction), independently
reproduced the Addendum A sentinels and Addendum B non-vacuity counts,
and returned findings F1 (BLOCKER), F2a/F2b, F3a/F3b/F3c. W3D confirmed
every finding cold against source (file+line) and responded (v1_1, in
the plain-English decision format of the W3X designer communication
convention v1_0, adopted 2026-08-05 as standing process).

W3X RATIFIED ALL NINE DECISIONS 2026-08-05:
 Q1 F1 blocker fix adopted as D-2C-1..5: summary emission moves to
    backend_tier_selection (detection no longer prints); implemented-
    tier ceiling as a filter-neutral data parameter (Classic v1 in 2C,
    Deblock4 uncapped); reason token AMENDED BY W3X to
    "intentionally-capped", shown only when the cap STRICTLY lowers the
    tier (keeps every 1C line byte-stable); narrow file authority
    extended (cpu_capability_detection / print_helper_functions /
    deblock4_config / deblock4_selftest - the v1_0 bootstrap's blanket
    detection prohibition was a W3D pre-understanding error, corrected).
 Q2 One summary line per creation ATTEMPT incl. selection refusals
    (D-2C-4; preserves current behaviour; informative for the user).
 Q3 S1/K29 refusals run BEFORE tier selection with the clip checks, no
    summary line; the S5 refusal inside selection, one line (D-2C-6).
 Q4 K30 (C-STY-10 first-class discipline) and K31 (C-SIMD-03 explicit
    checked stride units even in scalar code) adopted into D0.
 Q5 README v1_9 ruled FALLBACK GENERAL GUIDANCE (soft/temporary until
    the post-2C W3D currency audit); 12.5/12.6 and 8.1 SUPERSEDED for
    2C (S5, S1).
 Q6 Scope-release vs implementation-release distinction adopted.
 Q7 Packaging follows W3X practice; reader-side no-read rules carry the
    weight; no reissue of the reviewed package.
 Q8 Per-file delivery base hashes RETIRED (prevailing-source anchor);
    the D1 SHA256SUMS and K26 reference-binary hashes PRESERVED.
 Q9 D3 reissued v1_9 (checklist mirror only; no obligation content
    changed).

DOCUMENTS ISSUED (this round): D4 v1_8; D0 v1_10; D3 v1_9; bootstrap
v1_1; manifest v1_1; this status v1_22. Review-round record: W3C review
v1_0 + W3D response v1_1 retained under reviews/.

NEXT: W3X issues the amended set; W3C FOCUSED RE-REVIEW (amended lines,
source boundary, K30/K31 - no re-derivation); W3X resolves, then
EXPLICITLY RELEASES IMPLEMENTATION; W3C authors the 2C delivery under
C-DELIV-09; W3D static review via the 7d crosswalk; W3X runs
build_2C_v1.bat and generates the K26 reference evidence; acceptance and
commit. Standing W3D tasks: post-2C README currency audit (seed list in
the response v1_1 section 4.2); coder-intro refresh after delivery.
```

# 0d. PRIOR STATE ADVANCE (v1.21, 2026-08-03) - STAGE 2C DESIGN RELEASED; IMPLEMENTATION READY TO ISSUE

```text
STAGE 2C (Classic scalar oracle + HolyWu external differential): the
DESIGN ARC IS COMPLETE AND RELEASED. Seven W3C review rounds resolved
(D2 F1-F12; revision F1-F7; D3 F1-F8; D3-followup F1; combined F1-F9 +
Q4/Q5; revised-package F1-F8; updated-package F1-F6; v1.4-package F1-F6;
v1.5-package convergence F1-F3). W3X called the v1.5-package review FINAL
and RATIFIED AND RELEASED the scope 2026-08-03.

RELEASED AUTHORITY SET (dev_documentation/reference/; always the highest
committed version of each per charter 2.3a):
  D0 Preface + Binding Knowledge Index      v1_9 (living; K1-K29)
  D1 holywu_r9/ byte-pinned r9 snapshot     + provenance v1_4
     (D-CLASSIC-4 PINNED: HolyWu tag r9, W3X-ratified 2026-08-02;
      SHA256SUMS.txt is the normative content identity)
  D2 HolyWu Real Schedule                   v1_6
  D3 Scalar Obligations + Sanity Gate       v1_8 (THE acceptance basis)
  D4 Classic Scalar Oracle coder scope      v1_7 (see reissue note below)
  Addendum A K26 Sentinel Fixtures          v1_2
  Addendum B Mandatory Differential Corpus  v1_2
  Creation-Error Message Table              v1_6 (ratified/controlling;
      THREE 2C Classic rows under the D0 section-5 narrow exception)

RATIFIED SCOPE DECISIONS (recorded in D4): S1 integer-only 2C + explicit
float refusal (both storage widths); S2 retain explicit final clamps
(resolves register Q1); S3 legal-shared-domain differential; S4 oracle-
construction-exception acceptance, delivered path BECOMES the oracle;
S5 implemented-tier availability cap + EFFECTIVE-precedence + always-on
reason= line; S6 identity advance 0.1.0-dev+1C -> +2C; S7 testable K24
kernel form. K29 integer-depth refusal (17..32-bit) ratified with the
three-part proof.

OPEN RULE QUESTIONS REGISTER (D3 9b / D4 section 10): Q1 RESOLVED (S2);
T-2 RESOLVED (S1); Q4 RESOLVED (S5); Q5 RESOLVED (S7); Q2 review-loop
termination OPEN (trigger: a round returning only additions); Q3 sweep-
scope narrowing WATCH (trigger: two consecutive clean sweeps). T-1
(WP-5 c0-from-aIndex) TABLED to the Stage 3C quality gate.

D4 v1_7 HYGIENE REISSUE (W3D-proposed 2026-08-03; W3X ratifies at
issuance; no technical change): released status recorded in the header
(the v1_6 status line predated the release call); the charter C-DELIV-09
reminder block added verbatim per charter v1.25/v1.26 (its omission from
v1_6 survived seven review rounds and was caught in the W3D successor
orientation review); section-9 checklist heading pointer D0 v1_8 -> v1_9.

W3C STATE: the prior coder context closed after the review rounds; a NEW
memoryless W3C session is issued the released scope via the Stage 2C
session bootstrap header + issuance bundle
(Deblock4_Stage_2C_Issuance_Bundle_Manifest_v1_0.md). Its first actions
are the D0 section-6 independent knowledge sweep and the D4 section-11
mandatory pre-implementation review; implementation follows W3X release
of that review round. 111_New_Chat_Introduction_for_Coder_v1_20's
IMMEDIATE NEXT ACTION block is stale (1C era) and is superseded by the
bootstrap header; its refresh is deferred until the 2C delivery lands.

W3D STATE: successor designer chat oriented 2026-08-03 (charter v1_26 +
full 2C reference set + root knowledge documents read in full; holywu_r9
hashes re-verified; D3 Appendix B/C derivation models independently
re-created and 46 ratified expected values reproduced exactly, including
O-4 order-sensitivity, O-5d, O-7 a/b/c/c2, sanity-gate G1/G5/G6 +
negative control, Addendum A V-B2/H-B5 whole-frame exactness, and nine
Addendum B non-vacuity counts).

HOUSEKEEPING (W3X, 2026-08-03): the stale root-level
Deblock4_Stage_2C_Preface_and_Binding_Knowledge_Index_v1_3.md moved to
superseded/ (it was inside the knowledge-sweep domain); the stale plain
holywu_r9/README_provenance.md (v1.0) moved aside - the v1_4 sidecar
prevails.

NEXT: W3X issues the bundle; W3C sweep + review round; W3X releases
implementation; W3C authors the 2C delivery under C-DELIV-09; W3D static
review against D3 v1_8 via the mandatory 7d crosswalk; W3X runs the
build_2C_v1.bat matrix and generates the K26 reference evidence
(Addendum A sentinel mismatch = HARD STOP); W3X accepts and commits.
```

# 0e. PRIOR STATE ADVANCE (v1.20, 2026-08-02) - STAGE 1C + RIDER 1C.1 COMPLETE

```text
CLOSURE (v1.19): Delivery v1_13 (three-line source correction: pub export fn
-> pub fn on the three G10 markers) passed W3D static review and W3X's
authoritative run: full fifteen-gate proof matrix green, 40/40 tests x three
modes, Debug positive controls live, Debug DLL export table restored to
VapourSynthPluginInit2 + _DllMainCRTStartup only, OUTER_BATCH_EXIT_CODE=0.
W3X ACCEPTED Phase 3b and STAGE 1C, and committed the v1_13-applied tree.
STAGE 1C IS COMPLETE. The G6 finding below is retained as history. Next
RIDER 1C.1 (using echo) ACCEPTED AND COMMITTED (delivery v1_1): each filter
now emits a resolved-invocation "deblock4: using Classic(...)/Deblock4(...)"
line at creation and a matching Deblock4Using frame property from the same
stored bytes; the F6 coercion motivation is proven live (strength=1.5 -> a
reported strength=1). Full 1C proof matrix green in all three modes, 53/53
tests. STAGE 1C AND RIDER 1C.1 ARE COMPLETE. Remaining
doc items: P4 creation-error message-table review; scope S3-wording amendment
at next issuance.
```

This revision advances ONLY the live state; the detailed body below is
retained from v1.17 and is superseded WHERE IT DESCRIBES PHASE 3a AS A
CANDIDATE. Current facts:

```text
- Phase 3a: W3D-reviewed (15 checks), W3X toolchain-validated, ACCEPTED and
  COMMITTED.
- Phase 3b: released; delivered and debugged through corrections v1_0..v1_12
  (repository main = the v1_12-applied state; base artifact
  designer_interaction/deliveries/
  Deblock4_Stage_1C_Phase_3b_W3C_delivery_v1_12.zip).
- Proof matrix: passes ALL gates and both release modes end-to-end EXCEPT the
  final Debug export-exclusion gate, which caught a REAL G6 violation: the
  three G10 debug markers are PE-exported from the Debug DLL (root cause
  verified: pub export fn = dllexport in the DLL compilation; correct in the
  1B.1 object-mode context, wrong in the DLL). Gate verdict CORRECT; never
  relax it; fix is source-side.
- The W3C coder chat that produced v1_0..v1_12 reached maximum length and
  died; a successor coder resumes from
  Deblock4_Stage_1C_Phase_3b_Coder_Resume_Brief_v1_0.md, which PREVAILS on
  current state and carries the directed fix, per-marker retention
  verification obligations, and the paid-for harness lessons.
- Toolchain findings recorded en route: F6 (VapourSynth coerces numeric args
  to registered type pre-plugin; wrong-type rejection unreachable) and the
  empty-planes boundary interception (harness case retired; plugin empty-
  array validation RETAINED as low-level-API defence). S3's proof domain was
  W3X-ratified as the Stage 1C deliverable tree (allowlist).
- After the G6 fix and a fully green matrix: W3X accepts Phase 3b, commits,
  and Stage 1C is complete; the released-next small step is rider 1C.1
  (Deblock4_Scope_Stage_1C1_Rider_Using_Echo_v1_0.md), released ONLY after
  1C acceptance.
```

# 1. Purpose and authority

This document records where Deblock4 implementation currently stands, what has
been proved, what remains open, and the next bounded review or development
step.

It does not define the algorithm, amend an invariant, or replace an active
coding scope.

Document authority and current orientation are:

```text
README_Deblock4_Design_Spec_v1_9.md
    controlling technical and algorithmic design specification

AI_Charter_and_Invariants_Card_v1_26.md
    controlling invariants, roles, coding standards, delivery rules, version-
    set discipline (2.3a), and scope-currency decisions (2.3b)

Deblock4_Verification_And_Tiering_Decisions_v1_10.md
    informative durable record of the verification / tiering / two-filter
    decisions and their reasoning; charter and README prevail on conflict

Deblock4_Concise_Project_Summary_v1.2.md
    concise orientation and user-facing companion

Deblock4_Forward_Roadmap_v1_13.md
    informative forward stage sequence; its narrow Phase 3a status line predates
    production of the delivery candidate and is queued for a separate currency
    check

111_New_Chat_Introduction_for_Coder_v1_19.md
    current informative W3C successor orientation

111_New_Chat_Introduction_for_Designer_v1_13.md
    current informative W3D successor orientation

Scopes/Deblock4_Scope_Stage_1C_Filter_Creation_v1_5.md
    ratified and binding Stage 1C design authority

Scopes/Deblock4_Stage_1C_Delivery_Plan_Addendum_v1_1.md
    binding Stage 1C delivery order and phase-boundary clarification

Deblock4_Stage_1C_Phase_3a_Designer_Briefing_v1_2.md
    informative Phase 3a review guidance; one member of the mixed-authority
    Phase 3a review set

Deblock4_Scope_Header_CDELIV09_Reminder_Block_v1_1.md
    current verbatim C-DELIV-09 reminder block for scopes and delivery-plan
    addenda issued henceforth

Scopes/Deblock4_S1B1_Retention_Export_Research_Package_v1_0.md
    informative research record behind the G6 retention/export decision

Deblock4_Toolchain_Findings_v1_1.md
    informative durable record of empirical Zig/linker facts (F1-F5)

Deblock4_MPEG2_Grid_Field_DCT_Knowledge_v1_0.md
    informative consolidated MPEG-2 grid / frame-vs-field-DCT knowledge

Deblock4_Project_Status_v1_17.md
    this informative implementation/proof-state and next-action record
```

The Phase 3a review set is a declared read-together set under charter 2.3a but
has MIXED AUTHORITY: scope v1_5 is the binding design authority, addendum v1_1
governs delivery order and boundaries, and briefing v1_2 is informative review
guidance. Read-together status does not equalise authority.

Charter 2.3b compatibility decision:

```text
scope v1_5 + addendum v1_1 / charter v1.26: compatible, grandfathered to next issuance, W3X 2026-08-01.
```

Scope v1_5 and addendum v1_1 therefore stand unchanged for the remainder of
Stage 1C unless a real material reason requires reissue. Their historical
charter pins and absence of the later C-DELIV-09 reminder block are not a STOP
condition. The prevailing charter governs; the reminder-block requirement
applies at their next natural issuance.

Where this status document conflicts with the README specification, charter,
or binding scope/addendum, those documents prevail.

Before a W3C or W3D session relies on a package, W3X verifies document currency
and any declared version set under charter 2.3a, and applies recorded scope-
currency decisions under charter 2.3b.

# 2. Evidence basis

The status below records builds, tests, repository actions, document decisions,
and delivery state reported by W3X from the initial Zig 0.16.0 scaffold through
the accepted Stage 1C Phase 2 commit and production of the Phase 3a delivery
candidate.

It does not claim that W3D or W3C independently executed the repository. Under
the charter, W3X remains the authority for builds, runs, measurements, commits,
pushes, and acceptance.

The current accepted and committed implementation baseline is Stage 1C Phase 2:
the proven Stage 1B.3 capability infrastructure plus the accepted Phase 1 pure
foundation and Phase 2 tier-selection, instance-creation, and permanent-router
modules. Phase 3a delivery v1.0 exists as a candidate against that baseline but
is not yet accepted or committed.

For any Phase 3a review, correction, or re-integration, W3X supplies the
prevailing branch-main source or an exact attached source tree together with
the delivery artifacts and review findings. Do not infer or require an old HEAD
SHA merely because earlier status text did so.

# 3. Current position

Deblock4 has completed Stages 1A, 1A.1, 1B.1, 1B.2 and 1B.3 and is well into
Stage 1C (filter creation). Phases 1 and 2 are accepted and committed. W3C has
produced Phase 3a delivery v1.0 (frame path plus real plugin registration); it
awaits W3D static review, W3X toolchain validation, and W3X acceptance. Phase
3b has not been released. Stage 1 as a whole is not complete.

Milestone:

```text
Stage 1A complete   - Zig build, Windows DLL, VapourSynth API4 interop scaffold.
Stage 1A.1 complete - helper-bridge names reconciled (zig_vsh_* wrappers,
                      deblock4_vsh_bridge_self_test), stale R76 wording
                      corrected, genuine R78 build baseline re-established.
Stage 1B.1 complete - isolated per-level backend objects and one-DLL linkage
                      (@extern address anchors; no PE export of gated code).
Stage 1B.2 complete - within-level assembly confirmation (each object inside
                      its named psABI level; vzeroupper settled).
Stage 1B.3 complete - runtime capability guard: ACTUAL/EFFECTIVE records,
                      CPUID/XGETBV detection, comptime named-model cross-check,
                      G10 debug seams, first-class selftest; fully proved and
                      committed.
Stage 1C ACTIVE     - filter creation, phased delivery (scope v1_5, addendum
                      v1_1; both grandfathered under charter 2.3b). Phase 1
                      (pure foundation) and Phase 2 (tier selection + instance
                      creation + permanent-skeleton callback routers) are
                      accepted and committed, green all three modes. Phase 3a
                      delivery v1.0 exists and awaits W3D static review, W3X
                      toolchain validation, and W3X acceptance. Phase 3b
                      (scaffolding sweep, build_1C batch, .vpy harnesses, full
                      proof matrix) is not released.
```

The accepted committed tree is not yet a functional VapourSynth deblocking
filter: no deblocking arithmetic exists. The unaccepted Phase 3a candidate adds
the real plugin entry/registration path, the API4 frame path, writable
copyFrame pass-through, frame properties, tier-switch bodies that all target
the same inert pass-through placeholder, common error handling, and the third
G10 lifecycle-trace seam. It does not add real Classic or Deblock4 algorithm
backends and does not execute gated v2/v3 arithmetic.

Stage 1B.1 complete - isolated backend objects and one-DLL linkage proved.
Four separately compiled probe objects (generic, scalar, SSE4.1, AVX2) link
into the one Deblock4.dll; the gated SSE4.1/AVX2 markers are emitted with
non-zero .text and externally linkable, retained by internal @extern address
anchors, never called, and absent from the PE export table. Their export-table
absence is enforced by the standing loud-failing dumpbin /EXPORTS gate, not
assumed from implicit toolchain behaviour. Debug, ReleaseSafe and ReleaseFast
all pass, all existing scaffold regressions pass, and both -Dcpu=native and
-Dtarget=native are rejected. Scope of record: v1.7.

Three retention mechanisms were empirically FALSIFIED before the working one
was found, and the evidence is preserved (see Deblock4_Toolchain_Findings):
(a) forceUndefinedSymbol / INCLUDE-class retention of a non-exported pub fn -
Zig omits an unreferenced non-export function entirely (.text length 0);
(b) a compound object welding baseline and gated code into one unit -
withdrawn as unverifiable and unproven for retention;
(c) a cross-compilation address reference from the DLL root - emission is
decided per compilation unit, so a reference in one compilation does not force
emission in a separately compiled object.
The working mechanism is object-mode export fn (emission + linkage, and NOT a
PE export) referenced from the DLL root by @extern, address-taken and never
called before guarded dispatch. Charter G6 carries the controlling rule.

# 4. Completed and proved

| Area | Current status |
|---|---|
| Zig 0.16.0 toolchain | Proven by local build and test runs |
| ZLS 0.16.0 and VS Code | Workspace established |
| Git repository and GitHub workflow | Established; scaffold reported committed and pushed |
| `build.zig` and `build.zig.zon` | Working for the current scaffold |
| Debug build | Passed for the settled scaffold |
| ReleaseSafe build | Passed for the settled scaffold and final helper-bridge architecture |
| ReleaseFast build | Passed for the settled scaffold |
| Zig tests | Working |
| Build/run probe executable | Passed |
| Windows x64 DLL construction | Proven with `Deblock4.dll` probe |
| DLL export/import-library/client linkage | Proven by smoke-test executable |
| VapourSynth API selection | API 4.2 explicitly pinned via VS_USE_API_42 |
| `VapourSynth4.h` | Translated into a Zig module |
| `VSConstants4.h` | Translated into a Zig module |
| `VSHelper4.h` | Compiled as C through a narrow tested C-ABI bridge |
| Vendored headers | Updated to VapourSynth R78; API 4.2 pin survives; bridge decision confirmed still needed |
| Stage 1A.1 name reconciliation | Accepted: zig_vsh_isConstantVideoFormat, zig_vsh_areValidDimensions, deblock4_vsh_bridge_self_test; C-INT-04 comments added |
| R78 build baseline | Debug/ReleaseSafe/ReleaseFast + build probe + header probe (API 4.2) + DLL smoke (0x44423401) + tests, accepted |
| Stage 1B.1 backend isolation/linkage | Accepted and committed; one DLL, separately targeted objects, gated markers absent from PE exports |
| Stage 1B.2 within-level confirmation | Accepted and committed; generated instructions confirmed within named v1/v2/v3 levels |
| Stage 1B.3 capability guard | Accepted and committed; ACTUAL/EFFECTIVE records, CPUID/XGETBV, drift check, G10 seams, selftest |
| Stage 1C Phase 1 | Accepted and committed; pure foundation green in Debug/ReleaseSafe/ReleaseFast |
| Stage 1C Phase 2 | Accepted and committed; tier selection, instance creation, permanent routers green in all three modes |
| Zig-facing helper naming | Settled as `zig_vsh_originalName` for direct compatibility wrappers |
| Zig/C ownership and lifetime policy | Recorded in prevailing charter v1.26 |
| Numeric and SIMD helper policy | Recorded in prevailing charter v1.26 |
| External-source provenance policy | Recorded in prevailing charter v1.26 |

Important translation result:

```text
VapourSynth4.h + VSConstants4.h
    translated into Zig

VSHelper4.h
    compiled as C
    exposed through narrow Zig-facing C-ABI wrappers
```

This architecture avoids the Zig 0.16.0 ReleaseSafe translation failure caused
by Windows CRT declarations reached through `VSHelper4.h`.

---

# 5. Not implemented, not accepted, or not yet proved

The distinction between the accepted committed baseline and the Phase 3a
delivery candidate is load-bearing.

Present in Phase 3a delivery v1.0 but NOT YET W3D-reviewed, W3X-validated,
accepted, or committed:

- real VapourSynth plugin entry and registration for both filters;
- `arInitial` / `arAllFramesReady` frame mechanics and common error handling;
- standard API4 copyFrame writable pass-through with plane data unchanged;
- Deblock4Filter, Deblock4Tier, Deblock4Version, and related frame properties;
- per-filter tier-switch bodies in the settled C5 order, with every tier branch
  calling the shared inert pass-through placeholder;
- debug-only `enable_trace_lifecycle`, the third G10 seam.

Still not delivered because Phase 3b is not released:

- C-STY-10 scaffolding sweep;
- `build_1C_v1.bat`;
- the two `tests/stage_1c_*_passthrough.vpy` harnesses;
- the full Stage 1C proof matrix, including release-absence and end-to-end gates.

Still not implemented in any accepted or candidate algorithm path:

Shared / infrastructure:
- callable real Classic/Deblock4 backend tables and execution of algorithmic
  backend arithmetic;
- frozen production vector widths or lane organisations;
- the independent full differential-correctness and safety harness.

deblock4.Classic (H.264, built FIRST):
- the Classic scalar oracle (faithful HolyWu, including luma-on-chroma);
- the Classic v2 and v3 backends and their differential proof;
- the HolyWu external-reference cross-check harness.

deblock4.Deblock4 (MPEG-2, built SECOND):
- the canonical scalar deblocking implementation (grids, schedules, midpoint,
  proper chroma), threshold tables/expansion, and scalar range proofs;
- the Deblock4 ReleaseSafe scalar oracle;
- the Deblock4 v2 and v3 backends and their differential proof;
- quality decisions for Schedule A versus B, midpoint scale, and proper chroma.

The Stage 1C copyFrame path is a pure identity pass-through, not algorithmic
pixel construction. It must remain byte-identical to the source and must not
mutate it. After a filter's ReleaseSafe scalar oracle has been accepted, later
pixel-producing, frame-construction, copy/share, ReleaseFast-scalar, v2, and v3
work is validated against that oracle under the charter's per-output-type
contract.

The first bounded Stage 2C/2D scope that CONSTRUCTS an oracle is the sole oracle-
comparison exception: it is accepted against independently authored scalar
obligations and the corruption-sanity gate in the charter and
Deblock4_Verification_And_Tiering_Decisions section 20.

# 6. Stage map

```text
Stage 1 - Zig project / build / dispatch / tiering scaffold and spikes (SHARED)
    PASS  Zig project scaffold
    PASS  VS Code and ZLS integration
    PASS  Windows DLL construction and client linkage
    PASS  VapourSynth API4 core/constants translation
    PASS  VSHelper4 C-ABI bridge architecture
    PASS  Stage 1A.1 R78 baseline reconciliation (accepted, committed)
    PASS  Stage 1B.1 backend object isolation and one-DLL linkage (scope
          v1.7; accepted and committed)
    PASS  Stage 1B.2 within-level confirmation and assembly inspection (each
          object stays inside its named psABI level; whole-level requirements
          recorded; standing batch build_1B2_v5_REDEVELOPED.bat) - accepted
          and committed
    PASS  Stage 1B.3 runtime capability guard: CPUID/XGETBV detection over the
          verified Set-A table + Set-B XCR0, whole-level v3->v2->v1 into
          immutable ACTUAL and EFFECTIVE records, the shared config/print
          module skeleton, a first-class self-test exe, and the debug-only
          force-down seam (G10 pattern) - built, fully proved (v1-only detection
          object, one guarded XGETBV, three-surface G10 absence with live
          positive control, force-down and build-reject matrices, drift
          perturbation), and committed. No dispatch wiring or VS entry point yet
          (deferred to the filter stage, by design).
    PASS  Stage 1C Phase 1 (pure foundation: version identity, common instance
          fields, per-filter instance records, pure parameter validation) -
          accepted and committed, green all three modes.
    PASS  Stage 1C Phase 2 (backend tier selection consuming the EFFECTIVE
          record; per-filter instance creation with constant-format refusal;
          permanent-skeleton callback routers passing frames through
          unmodified) - accepted and committed, green all three modes, bridge
          extended not forked.
    ACTIVE Stage 1C Phase 3a: W3C delivery v1.0 (frame mechanics, property
          modules, tier-switch bodies, error handler, lifecycle trace, and real
          deblock4_plugin registration) exists and awaits W3D static review, W3X
          toolchain validation, and W3X acceptance. Review uses the complete
          mixed-authority set: scope v1_5 + addendum v1_1 + root-level Phase 3a
          Designer Briefing v1_2. Scope/addendum are grandfathered under charter
          2.3b. Phase 3b is not released.

Per-filter algorithm stages run Classic first, then Deblock4:

Stage 2C..5C - Classic (H.264, faithful to HolyWu): scalar oracle + HolyWu
    external-reference harness, compatibility gate, v2 backend, v3 backend
    NOT STARTED

Stage 2D..5D - Deblock4 (MPEG-2): scalar core + differential harness, quality
    decisions (Schedule A/B, midpoint, proper chroma), v2 backend, v3 backend
    NOT STARTED

Stage 6 - VapourSynth integration and release readiness (BOTH filters)
    API header/interop groundwork proved; inert integration candidate exists at
    Stage 1C Phase 3a, but algorithmic integration and release work remain
```

Stage 1 does not block source review, scalar algorithm design, test-vector
authoring, or corpus assembly. It does gate accepted code integration,
executable scalar testing, and backend object/link work.

---

# 7. Current candidate and most recently completed bounded scope

## Stage 1C Phase 3a - frame path + real plugin registration (DELIVERED CANDIDATE; NOT YET ACCEPTED)

W3C delivery v1.0 has been produced. It is now the current review candidate, not
an accepted milestone. It adds the real plugin registration and inert API4 frame
path bounded by the Phase 3a review set. W3D static review, W3X toolchain
validation, and W3X acceptance remain outstanding; Phase 3b is not released.

The most recently accepted and committed bounded scope remains Phase 2 below.

## Stage 1C Phase 2 - tier selection + instance creation (PASS, committed)

Phase 2 delivered backend_tier_selection (the startup tier choice consuming
the proven 1B.3 EFFECTIVE record: auto->highest, explicit<=effective honoured,
explicit>effective and unknown-token refused), the two per-filter
instance_creation modules (full-signature VSMap extraction, constant-format/
dimension refusal per README v1_9 s11.3, consumer-side plane-bound check,
immutable instance records), and the two permanent-skeleton callback routers
(real getFrame/free + the permanent activation-reason switch, with minimal
pass-through bodies that return the source frame unmodified). Validated via a
single-root smoke harness mirroring the future plugin topology. Two review
rounds resolved a validation-harness module-collision (harness-only fix, source
byte-identical) and eight C-interop type mismatches (callback [*c] signatures,
[*c] slice handling, u5/u8 cast). Green all three modes; bridge extended not
forked; accepted and committed.

## Stage 1C Phase 1 - pure foundation (PASS, committed)

Phase 1 delivered the pure, VapourSynth-free foundation: deblock4_version
(single-homed identity 0.1.0-dev+1C, separate packed version), CommonInstance
Fields, the two per-filter instance-data records (C3 option B, no tagged
union), and filter_call_parameters (sectioned pure module: self-contained
type/range/default validation, P1 midpoint no-default, P2 steps>=1, P3 plane
rules). Immutable instance_id from a monotonic atomic counter (C4). Green all
three modes with no VS core; accepted and committed.

## Stage 1B.3 - runtime capability guard (PASS)

Stage 1B.3 built and proved the runtime capability guard: raw CPUID/XGETBV
detection over the Set-A table plus the Set-B XCR0 check, whole-level
v3->v2->v1 resolution into an immutable ACTUAL (process-wide) and EFFECTIVE
(per-instance) record, the shared config/print module skeleton, the first-class
deblock4_selftest.exe, and the debug-only G10 force-down seam. The full proof
matrix ran and was independently verified at the instruction/byte level: the
baseline detection object is v1-only, XGETBV occurs exactly once behind the
OSXSAVE guard, the two gated markers are absent from both release artifacts on
all three surfaces (with a live Debug positive control), the force-down and
build-reject matrices behave, and the named-model drift perturbation fires on
demand. Accepted and committed; standing batch build_1B3_v5.bat. It
does NOT wire dispatch or create the VapourSynth entry point - those are the
filter-creation stage, by design. The 1B.2 entry below is retained as the
preceding milestone.

## Stage 1B.2 - within-level confirmation and assembly inspection (PASS)

Stage 1B.2 confirmed, by generated-assembly inspection, that each backend
object emits nothing outside its named psABI level (x86_64_v1/v2/v3), settled
the vzeroupper question by inspection, and recorded the whole-level feature
requirements that Stage 1B.3 detects at runtime. Accepted and committed; the
standing validation batch is build_1B2_v5_REDEVELOPED.bat. The 1B.1 detail
below is retained as the immediately preceding milestone.

## Stage 1B.1 - backend object isolation and one-DLL linkage (scope v1.7, PASS)

Objective:

```text
Prove that generic, scalar, SSE4.1, and AVX2 probe modules can be compiled under
separate intended target contracts and linked into one Windows x64 DLL without
pixel-producing code or contamination of the generic baseline.
```

The scope should use non-pixel backend identity probes only.

Expected structure:

```text
one Deblock4 DLL
    generic/dispatch probe object
    scalar probe object
    SSE4.1 probe object
    AVX2 probe object

one smoke-test executable
    loads or links the DLL
    calls each permitted probe
    verifies exact backend identity markers
```

Proof obligations, all met (per scope v1.7):

1. Generic and scalar code contain no SSE4.1, AVX, AVX2, or FMA assumption; the
   DLL root, generic, scalar, and smoke-test units are on a fixed provisional
   x86-64 baseline target, with -Dtarget/-Dcpu overrides rejected (section 2A).
2. The SSE4.1 and AVX2 probes are isolated from generic/dispatch code.
3. All four objects coexist in the one existing Deblock4.dll.
4. The gated SSE4.1/AVX2 markers ARE declared export fn in their own
   single-target objects (emission and linker visibility) and are NOT present
   in the PE export table (charter G6 v1.10: the ban is on PE-export, not the
   export keyword). Retention is by internal @extern address anchors in the
   DLL root, address-taken and never called.
5. (Historical, SUPERSEDED: earlier 1B.1 detail said "the AVX2 object excludes
   FMA". Under the named x86_64_v3-in-full contract, FMA is a member of the v3
   level and is included in the target; .strict (G8) prevents contraction so it
   is not relied upon. The exclusion no longer applies.)
6. No pixel, frame, copy, or deblocking path is introduced.
7. Debug, ReleaseSafe, and ReleaseFast build/test expectations are stated and
   run by W3X, including the existing scaffold regression checks.
8. A standing dumpbin /EXPORTS gate fails the run if any gated marker appears
   in the export table.
9. Changed and forbidden files are explicitly bounded; the phase patch and
   build_1B1.bat are the permitted retained non-source artifacts.

Implementation acceptance:

```text
The intended multi-object DLL structure builds and links in every required
mode, its non-pixel identity smoke test passes, and generic code remains free
of unsupported feature assumptions.
```

This Stage 1B.1 scope did not freeze production vector widths or code-generation
choices. Those remain measurement and assembly-inspection questions for Stage
1B.2. The feature contracts themselves are the already-settled named full
v1/v2/v3 levels.

---

# 8. Active and following Stage 1 work

## Stage 1C Phase 3a - delivery candidate awaiting review and validation

W3C delivery v1.0 contains the Phase 3a frame path and real plugin registration
bounded by the existing mixed-authority review set:

```text
Scopes/Deblock4_Scope_Stage_1C_Filter_Creation_v1_5.md
Scopes/Deblock4_Stage_1C_Delivery_Plan_Addendum_v1_1.md
Deblock4_Stage_1C_Phase_3a_Designer_Briefing_v1_2.md
```

The principal review points are:

- creation callbacks expose the exact translated VSPublicFunction C-ABI
  signature, immediately rebind validated idiomatic locals, preserve the
  accepted parsing/validation/tier-selection/allocation/ownership/filter-
  construction logic, and add only the authorised lifecycle trace around it;
- the permanent activation-reason switch is not restructured;
- C5 order is obtain source -> frozen-tier switch -> property annotate -> return;
- the lifecycle trace is one physical line per event and creation successful-
  exit carries the complete resolved configuration;
- every tier branch remains the shared inert pass-through; no real v2/v3
  algorithm backend executes.

Phase 3a stops for W3D review, W3X toolchain validation, and W3X acceptance. Do
not begin Phase 3b or make unrelated production changes unless W3X releases a
bounded correction or the next phase.

## Stage 1C Phase 3b - not released

After Phase 3a acceptance and explicit W3X release, Phase 3b performs the
C-STY-10 scaffolding sweep, supplies build_1C_v1.bat and the two .vpy harnesses,
and runs the full Stage 1C proof matrix. It must not be silently recombined with
Phase 3a.

## Stage 1B.3 - runtime capability guard (COMPLETED; retained for reference)

Stage 1B.3 implemented CPUID/XGETBV detection over the verified Set-A bit table
plus the Set-B XCR0 check, whole-level v3->v2->v1 resolution into immutable
ACTUAL and EFFECTIVE records, the shared module skeleton, a first-class
`deblock4_selftest.exe`, and the original debug-only G10 seams. It deliberately
did not create the VapourSynth entry point or frame path; those are Phase 3a
candidate work. See
Deblock4_Scope_Stage_1B3_Runtime_Capability_Guard_v1_3.md.

## Stage 1B.2 - within-level confirmation and assembly inspection (COMPLETED; retained for reference)

Stage 1B.2 confirmed that each object's emitted instructions stay within its
named psABI level, inspected relevant vector/code-generation forms, settled the
AVX/SSE `vzeroupper` question, and produced the whole-level requirements later
enforced by Stage 1B.3. The tier is the named level, not a bespoke closure; FMA
is part of v3 but is not relied upon under `.strict`.

# 9. Stage 2 entry sequence

The recommended scalar sequence is:

```text
small synthetic sample neighbourhoods
    -> single-edge scalar arithmetic
    -> threshold tables and range proofs
    -> named luma/chroma footprints and eligibility
    -> canonical traversal schedules
    -> whole-plane scalar oracle and safety harness
```

The same canonical scalar source must instantiate both:

```text
ReleaseSafe scalar oracle
ReleaseFast production scalar backend
```

There must never be a second independent scalar implementation.

Stage 1C may establish a byte-identical inert pass-through using the standard
API4 copyFrame idiom before an algorithmic scalar oracle exists. It must not
perform deblocking or algorithmic plane construction. Once a filter's oracle
exists, subsequent pixel/frame/copy/backend work is accepted only under the
charter's oracle-based per-output-type validation contract.

# 10. Documentation package readiness

The current controlling/orientation/review package is:

```text
README_Deblock4_Design_Spec_v1_9.md
AI_Charter_and_Invariants_Card_v1_26.md
Deblock4_Verification_And_Tiering_Decisions_v1_10.md
Deblock4_Concise_Project_Summary_v1.2.md
Deblock4_Forward_Roadmap_v1_13.md
Deblock4_Project_Status_v1_17.md
Deblock4_Toolchain_Findings_v1_1.md
Deblock4_DISPATCH_RELATED_Backend_Objects_Explained_v1_3.md
111_New_Chat_Introduction_for_Coder_v1_19.md
111_New_Chat_Introduction_for_Designer_v1_13.md
Deblock4_Scope_Header_CDELIV09_Reminder_Block_v1_1.md
Scopes/Deblock4_Scope_Stage_1C_Filter_Creation_v1_5.md
Scopes/Deblock4_Stage_1C_Delivery_Plan_Addendum_v1_1.md
Deblock4_Stage_1C_Phase_3a_Designer_Briefing_v1_2.md
Deblock4_Stage_1C_Phase_3a_W3C_delivery_v1_0.zip
```

Scope v1_5 and addendum v1_1 remain the controlling Stage 1C documents despite
their historical pins. Their compatibility with charter v1.26 is recorded in
section 1 under charter 2.3b; they are grandfathered until next issuance. The
reminder block is supplied directly and applies to scopes/addenda issued
henceforth.

The Phase 3a review set must be complete and read together, while retaining its
mixed authority. The delivery ZIP is a candidate artifact, not proof of W3D
review, W3X validation, acceptance, or commit.

Before Phase 3a can be accepted, W3X should confirm:

1. the prevailing charter filename and internal version are v1.26;
2. the README filename and internal design revision are v1.9;
3. Project Status filename and internal version are v1.17;
4. the charter 2.3b compatibility line for scope v1_5/addendum v1_1 is present;
5. all three Phase 3a review-set members are present at the stated versions;
6. the Phase 3a delivery v1.0 artifact and its checksum/manifest are the exact
   candidate being reviewed;
7. W3D's static findings and W3X's actual validation outputs are recorded before
   any PASS recommendation;
8. Phase 3b remains unreleased until Phase 3a acceptance and explicit W3X
   release;
9. any correction is prepared against the prevailing branch-main source or an
   exact source tree supplied by W3X, not an inferred stale commit.

With those checks complete, the project has enough design, process,
orientation, and current-state material to review Phase 3a safely.

# 11. Status update discipline

This file should be updated only when a material implementation, delivery,
review, acceptance, or proof milestone changes the current state.

Examples:

- Stage 1B.1 accepted;
- within-level confirmation completed at Stage 1B.2;
- capability/dispatch harness accepted;
- scalar oracle established;
- Schedule A/B quality decision settled;
- a filter's v2 or v3 backend differential contract proved (integer-exact / float-tolerance);
- a bounded delivery candidate enters or leaves formal review;
- functional VapourSynth integration accepted.

For each material update:

1. bump the status document version;
2. update the date;
3. state the newly accepted evidence;
4. move items between completed and open sections;
5. identify the next bounded review, correction, or coding action;
6. do not amend the charter or controlling design specification implicitly.

---

# 12. Immediate next action

Do not begin fresh implementation or Phase 3b.

The immediate bounded action is the Phase 3a review/validation/acceptance loop:

1. W3D reviews W3C delivery v1.0 statically against the complete mixed-authority
   Phase 3a review set, with file-and-line evidence.
2. W3X applies or stages the exact candidate against the prevailing source and
   runs the required toolchain validation.
3. W3C responds only to bounded findings or correction instructions supplied by
   W3X; no unrelated cleanup or Phase 3b work is pulled forward.
4. W3X decides acceptance. Only after Phase 3a acceptance may W3X release Phase
   3b.

Phase 3b, when released, performs the scaffolding sweep, supplies the build batch
and two .vpy harnesses, and closes the full Stage 1C proof matrix.

No gated backend arithmetic executes in Stage 1C. Each tier branch remains the
same inert pass-through until the per-filter scalar-oracle stages. Classic is
built first; Deblock4 remains the end goal.

Starting point for any correction: the prevailing branch-main source or exact
source tree supplied by W3X together with the reviewed Phase 3a artifact. Do not
infer or transcribe a commit id.

# 13. Revision history

```text
v1.26 (2026-08-13) State advance: STAGE 4C ACCEPTED. Full validation matrix
      green (exit 0); byte-identity to the scalar oracle proven end to end;
      tail-corruption control fires. Records the validation history (all
      failures harness/corpus, never the backend), the accepted W3C repair
      package v1.2, and the emergency W3D-specified/W3X-applied batch edit.
      Commit-ready set named. Stage 5C (AVX2) is next, not yet scoped.
v1.25 (2026-08-12) State advance: end-of-phase pass complete; 3C
      collapsed (T-1 deferred); chroma-grid fork resolved with the
      normative H.262 citation; 4C scoped, pre-implementation round
      complete (scope v1_2, D0 v1_13/K32), implementation released.
      Supersedes the committed v1.24 (version-sync note).
v1.24 (2026-08-12) State advance: STAGE 2C ACCEPTED AND COMMITTED to
      main. Records the passing validation (OUTER_BATCH_EXIT_CODE=0;
      85/85 x3; RS==RF; 6/6 sentinels; 17/17 byte-exact differential;
      comptime perturbation catch; W3D 28/28 native re-execution), the
      v2.0 no-script redelivery plus the five W3D-reviewed repair
      deltas, the R79 runtime fact (in-tree API4 headers unchanged),
      the oracle status under S4/K19(c), Stage 3C as next, and the
      activated end-of-phase update pass. Prior section-0 retitled 0b;
      0b->0c; 0c->0d; 0d->0e.
v1.23 (2026-08-05) State advance: focused re-review resolved; six W3X
      ratifications recorded (T-S5-1a/1b; D0 (a)-(e) exception form +
      detection-LOGIC rewording; narrow non-cleanup K30 audit contract
      with the gate-assertion rationale; K31 per-model proof with the
      byte-row default per W3X preference and the HolyWu/zsmooth
      silent-division survey; F5a-d cleanups; F5e filing). Post-2C
      identifier-cleanup candidate registered. Corrected set issued
      (D4 v1_9, D0 v1_11, D3 v1_10, bootstrap v1_2, manifest v1_2).
      Same-day addendum: Toolchain Findings v1_4 issued (F9 zig-0.16.0
      autovec-disabled / zsmooth #23 with the G8 fast-math-rejection
      companion record; F10 zig #19550 f16 storage-never-compute rule
      with the pin-before-K22-tolerances ordering); the end-of-phase
      update pass registered in section 0 (README audit, coder-intro,
      identifier-cleanup candidate, F10 propagation into D4-S1-FUTURE /
      V&T 3.4-3.8 / D0-K22). Prior section-0 retitled 0b; prior 0b ->
      0c; prior 0c -> 0d.
v1.22 (2026-08-05) State advance: successor-W3C pre-implementation review
      resolved; all nine W3X ratifications recorded (D-2C-1..6 with the
      intentionally-capped token, K30/K31, README fallback ruling with
      12.5/12.6 + 8.1 superseded, two release states, packaging-follows-
      practice, base hashes retired except D1/K26, D3 v1_9 mirror);
      designer communication convention v1_0 adopted as standing process;
      amended document set issued (D4 v1_8, D0 v1_10, D3 v1_9, bootstrap
      v1_1, manifest v1_1). Prior section-0 retitled 0b, prior 0b -> 0c.
v1.21 (2026-08-03) State advance: Stage 2C design arc COMPLETE AND
      RELEASED (W3X 2026-08-03 after the v1.5-package convergence
      review). Recorded the released authority set (D0 v1_9, D1+prov
      v1_4, D2 v1_6, D3 v1_8, D4 v1_7, Addenda A/B v1_2, error table
      v1_6), the S1-S7 ratifications and K29, the register state
      (Q1/T-2/Q4/Q5 resolved; Q2 open; Q3 watch; T-1 tabled to 3C),
      D-CLASSIC-4 pinned at r9, the D4 v1_7 hygiene reissue (released
      status; C-DELIV-09 reminder block per charter v1.25/v1.26;
      pointer refresh), the successor-W3C issuance plan, the successor-
      W3D orientation with 46/46 model verification, and the 2026-08-03
      housekeeping moves. Prior section-0 retitled 0b; body below
      retained and superseded where it describes pre-2C-release state.
```

```text
v1.17 Full status reconciliation after production of Stage 1C Phase 3a W3C
      delivery v1.0 and ratification of charter v1.26. Current accepted baseline
      advanced from Stage 1B.3 to Stage 1C Phase 2; Phase 3a is recorded as a
      delivered candidate awaiting W3D static review, W3X toolchain validation,
      and W3X acceptance; Phase 3b is explicitly unreleased. Updated live pins
      (charter v1.26, roadmap v1.13, coder intro v1.19, designer intro v1.13,
      briefing v1.2, self v1.17, reminder block v1.1), classified the Phase 3a
      review set as mixed authority, and recorded the charter-2.3b compatibility
      decision grandfathering scope v1_5 and addendum v1_1 to next issuance.
      Corrected the stale exact-commit/HEAD rule to prevailing-source or exact
      supplied-tree discipline. Distinguished candidate Phase 3a components from
      accepted code, preserved the permitted byte-identical API4 copyFrame
      pass-through exception, recorded the third G10 lifecycle seam, and changed
      the immediate action from implementation to the Phase 3a review/validation/
      acceptance loop. No design or Part 1 invariant change.
v1.14 Coder-review corrections: scaffold-era wording advanced (evidence basis
      now spans through 1B.3; committed baseline = the 1B.3 infrastructure, not
      merely the scaffold; current-position milestone table now lists
      1B.1/1B.2/1B.3; the DLL/executables description includes the real
      capability detector and selftest); the v1.13 revision entry's self-ref
      transition corrected to v1_13; cross-pins advanced to the new generation
      (roadmap v1_12, coder intro v1_13, designer intro v1_7, self-ref v1_14).
      Version bumped per immutable-version discipline (v1.13 was already
      exchanged).
v1.13 Full reconciliation after Stage 1B.3 COMPLETE and committed. Corrected all
      stale body layers a prior surgical edit missed: package/authority pins
      (charter v1_16 -> v1_19, roadmap v1_8 -> v1_10, self-ref -> v1_13,
      decisions/summary/coder-intro pins, added the designer intro); removed the
      three now-DONE shared items from "Not implemented" (capability detection,
      backend resolution, within-level assembly confirmation); marked the
      historical "AVX2 object excludes FMA" claim SUPERSEDED; batch name made
      exact (build_1B3_v5.bat); replaced the obsolete duplicate "Stage 1B.3 -
      Implement and prove" section and the obsolete "Immediate next action:
      Stage 1B.2" section with the filter-creation stage; readiness-check pin
      -> v1.19. (v1.11 and v1.12 were interim surgical passes; this entry
      supersedes them.)
v1.12 Interim: position table advanced (1B.3 -> PASS, filter stage ACTIVE) and
      sections 7/8 headline-updated. Body pins/lists not yet reconciled.
v1.11 Interim: charter pin and current-position headline advanced for the 1B.3
      scope/delivery round.
v1.10 Cross-reference sync after the companion-pin cascade: charter v1.15 ->
      v1.16, decisions v1.8 -> v1.9, roadmap v1.7 -> v1.8, coder intro -> v1.9.
      No content change beyond pointers.
v1.9  Mechanical review corrections: the standing oracle-precedence paragraph
      (H1) restated with the Stage 2C/2D oracle-construction exception, so this
      informative record no longer carries the half-rule that would forbid the
      scope that builds the first oracle; the "final feature closures" scope
      note (M3) reworded - the named v1/v2/v3 contracts are already settled and
      1B.2 confirms vector/codegen details, it does not freeze closures.
v1.8  Mechanical review corrections: the authority block and documentation
      package list now name decisions v1.8 and coder intro v1.7 (were still
      v1.5 / v1.6 despite the v1.7 note claiming they were synced);
      completed-table charter references advanced from v1.14 to current v1.15.
v1.7  Cross-reference sync to the post-re-audit package (incl. final package
      review: evidence-basis concise ref -> v1.1; package-list coder intro ->
      v1.6; FMA wording aligned) (charter v1.15, README
      v1.8, decisions v1.7, coder intro v1.6). No content change beyond pointers.
v1.6  Independent re-audit corrections (H1/H2): authority block, evidence basis,
      documentation-package list, and readiness checks updated to the current
      set (charter v1.15, README v1.8, decisions v1.5, roadmap v1.7, concise
      summary v1.1, this doc v1.6); the coder intro is named with its exact
      filename/revision (111_New_Chat_Introduction_for_Coder_v1_4.md), not
      "(current)". Stage 1B.2 wording corrected: it PRODUCES the whole-level
      feature requirements that 1B.3 dispatch enforces (dispatch does not
      produce them; the guard is a 1B.3 artifact). Completed-table charter
      references updated to v1.14.
v1.5  Second audit pass regeneration of the stale sections W3C flagged: stage
      map (section 6) and Stage 1B.2/1B.3 (section 8) rewritten (within-level
      confirmation; 1B.2 produces requirements, 1B.3 implements/checks the
      guard; FMA-exclusion removed; named-level tokens; Classic/Deblock4
      2C..5C / 2D..5D split). Evidence-basis and section 9 examples updated
      off stale roadmap/status/backend references.
v1.4  Consistency reconciliation after the document audit (two passes). Authority
      block, evidence basis, and documentation-package section updated to charter
      v1.12 / README v1.6 / decisions v1.4 / roadmap v1.5 (were stale at
      v1.9/v1.1/v1.2 and listed a "four-document package" of eight files). Stage
      map (section 6), Stage 1B.2/1B.3 (section 8), and the section 9 examples
      regenerated: "feature-closure spikes" -> within-level confirmation;
      Stage 1B.2 PRODUCES requirements while Stage 1B.3 IMPLEMENTS/CHECKS the
      guard; FMA-exclusion language removed (FMA is part of v3, present-but-
      unused under .strict); old backend tokens -> the named-level tokens;
      generic Stage 4/5 "identity proof" -> the Classic/Deblock4 (2C..5C /
      2D..5D) split with the integer-exact / float-tolerance contract. The "Not
      implemented" list is split into shared / Classic / Deblock4 entries.
v1.3  Two-filter / Classic-first note and 1B.2 named-level correction.
```

---

*This document is informative and non-controlling. The charter and README
prevail. It records the current proof state; each stage becomes real only as a
formal coding scope against the actual repository at that time.*
