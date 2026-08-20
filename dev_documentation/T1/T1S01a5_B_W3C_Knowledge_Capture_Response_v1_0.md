# Deblock4 - W3C Knowledge Capture Response

**Deliverable:** T1S01a5_B - W3C KNOWLEDGE CAPTURE RESPONSE
**Version:** 1.0
**Date:** 2026-08-19
**Author:** W3C
**Route:** W3C -> W3X -> W3D
**Responds to:** `T1S01a5_A_W3C_Knowledge_Capture_Request_v1_0.md`
**Nature:** EVIDENCE ONLY. Not a review, scope, verdict change, source change,
build/test result, ratified rule or project-knowledge authority.
**Encoding:** US-ASCII; CRLF.

---

# DECISIONS/QUESTIONS FOR W3X

None.

These captures are evidence. Where W3D considers anything durable, it should
propose it into the appropriate rule/authority document through the normal
verification/ratification path.

---

# Capture 1 of 7 - what I noticed and did not report

I do not have a reliable hidden list of additional technical defects that I
consciously discovered in a5 and suppressed. Most things I noticed strongly
enough to evidence became findings, and several things initially set aside
later surfaced explicitly during re-sweep/recovery work. I will not
retroactively turn a vague impression into a missed finding.

OUT OF SCOPE / BRACKETED:
- While reviewing sections 1-8, I repeatedly saw sections 9-13 and Appendix A
  reuse propositions from the evidence half. I did not adjudicate those
  occurrences because the tranche boundary mattered.
- Appendix A became relevant as evidence of duplication, especially LED-053d.
  I was uneasy that file-level search results are a poor fit for a physical
  authority file split across multiple adjudication tranches: the same file can
  contain another occurrence outside the current range while the harness
  returns only one file.
- Sections 9-13 appeared intrinsically higher risk because they transform facts
  into architecture, topology, rejection reasoning and scheduler/kernel rules.
  I treated apparent repetitions there as applications until their own tranche
  could adjudicate them rather than prejudging a5b.

UNSURE / NOT RAISED:
- CARRIER versus APPLIES is sometimes genuinely borderline. My working semantic
  test was whether a cold reader could recover the proposition from the passage
  without already knowing it. If yes, lean CARRIER; if it only works by
  assuming the proposition, lean APPLIES. I did not propose this as a binding
  mechanical criterion.
- LED-049's Scopes evaluation and LED-044's designer-introduction hit were
  examples where I accepted APPLIES but would expect a reviewer to examine the
  semantic boundary.

ASSUMED OWNED LATER:
- The final a7 whole-document consistency pass would catch only items already
  routed there; that was never a valid reason to suppress a new substantive
  defect.
- a6 owned section-24 reference reconciliation. I did not identify the strong
  W3C-D4-VERIFY-1 candidate referent during the original Tier C work; that is
  genuinely later evidence.

LOOKED WRONG BUT NOT THEN EVIDENCED:
- The broader same-file intra-document duplication problem: one file-level hit
  can conceal several relevant occurrences in different sub-tranches.
- General concern about narrow exact-word searches. This became DEC-67 only
  after concrete failures supplied evidence for a bounded proposition-search
  rule.

I had no undisclosed technical objection to B2, D, F8, the row mathematics or
the 4:2:0 asymmetry that I consciously withheld. Where provenance was weak,
especially F8, I said so.

---

# Capture 2 of 7 - what ledger v1.4 uniquely carried

Most v1.4 compression was NOT deliberate judgement. It was collateral
compression from reconstructing quickly from v1.3 plus accepted repair
findings. W3X was right to rule v1.4 out as the textual preservation base.

Unmandated deletion of ASSERTS, REASON, SWEPT, DERIVED, DERIVED-BASIS,
enumerated evidence, line locations or negative results must not be read as a
deliberate rejection unless an accepted finding specifically required it.

DELIBERATE STRUCTURAL JUDGEMENTS IN v1.4:
- LED-055a: I deliberately isolated the possibly unique SeparateFields
  qualifiers (progressive/frame-DCT generality and "correctness requirement,
  not performance preference") from the duplicated mechanism/conclusion.
  This is the most important original v1.4 analysis that the later rebuild did
  not preserve correctly. The latest closure review independently reaches the
  same conclusion.
- LED-058a: document-local `regime-3 mix` corrective reading rule separated
  from duplicated mapping/significance/evidence-limit material.
- LED-061a: nuanced GAIS instrument assessment separated from duplicated
  standing verification/evidence/precedence rules.
- LED-043a: no-coded-residual dct_type meaningfulness separated from the
  duplicated Q14 no-fabrication project rule.

I would defend the NEED for atomic LED-055 qualifier treatment, not necessarily
the exact identifier or wording.

I would not defend v1.4 compression where v1.6 restores v1.3 reasoning/evidence.
I would not defend bundling distinct LED-053 duplicate propositions if v1.6
splits them; they have different carrier evidence.

Entry count is never a target. Matching totals can conceal different
proposition sets.

---

# Capture 3 of 7 - MIXED, intra-file duplication and cross-tranche evidence

W3D's reading is correct: MIXED means one physical file carries more than one
MEANING/classification. LED-049 is the clean example.

LED-053d is different: section 4.5 and Appendix A state the SAME proposition at
two locations in the same physical file. Calling that MIXED stretched the
defined vocabulary. I accepted it pragmatically to avoid losing the second
occurrence; I did not intend a binding redefinition.

Keep:
    MIXED = one file contains relevant occurrences of different meanings/classes.

Do not use MIXED merely because the same proposition occurs twice.

BEFORE a6, add occurrence-level evidence without inventing another main
classification:

    FILE: <path>
    FILE-CLASS: CARRIER / APPLIES / DIFFERENT / IDENTIFIER / NOISE / MIXED
    OCCURRENCES:
        <section/range> CANONICAL occurrence of proposition P
        <section/range> CARRIER occurrence of proposition P

or an equivalent OCCURRENCES note when materially needed.

Key rule:
    A file-level search hit does not establish occurrence-level uniqueness
    inside that file.

Q-K:
Citing Appendix A as evidence without adjudicating it is the right handling.
The current entry may say that Appendix A refutes uniqueness while leaving
Appendix A's own disposition to a6. Prematurely adjudicating it would violate
the tranche boundary.

Carry it forward explicitly:

    CITED-OUTSIDE-RANGE:
        location
        proposition
        evidence use in current tranche
        owning later tranche
        later tranche must reconcile the occurrence with the earlier evidence use

Then a7 can reconcile whole-document consistency.

---

# Capture 4 of 7 - what a5b should expect

a5b is technically harder because sections 9-13 transform facts into
architecture, topology, rejection arguments and scheduler/kernel obligations.

HIGH-RISK PATTERNS:
1. Current principle embedded inside rejected architecture.
2. Derived architecture being accidentally described as codec fact.
3. Decision reasoning substantially duplicated in Scopes.
4. Rejected Architecture A extensively described elsewhere, with some generic
   principles potentially surviving its rejection.
5. PR-1/PR-2 home and pointer remedies requiring faithful home adjudication,
   not decision reopening.
6. Same-file duplication across section 0, body, registers and appendices.

ADVANCE WARNINGS, NOT PRE-DISPOSITIONS:
- B2-primary / D-mandatory-comparator decisions are repeated widely.
- Section-10 B2 topology mathematics has Scopes ancestry; do not presume
  uniqueness.
- Architecture D's high-level role and detailed topology may have different
  canonical homes.
- Architecture A rejection proof is likely to require the most Tier-A atomic
  splitting.
- Scheduler/kernel separation is likely duplicated but is only an application,
  not a copy, of the complete four-layer taxonomy.
- Old Schedule A/B vocabulary must not be confused with assertion of the
  renaming rule.
- PR-1/PR-2 project decisions are settled; a5b adjudicates their source/home
  text rather than reopening them.

EXPECTATION:
More Tier A than a5 is likely because the architecture half deliberately
contains rejected/superseded material. Zero or few Tier B entries are expected
because Deblock4 still has no filtering kernel; scaffolding does not make an
architecture statement an OPERATIVE-SPEC.

DO NOT REPEAT a5:
- do not inherit the 46-file a5 snapshot; derive a5b's current population;
- use bounded proposition probes from the beginning;
- open and understand every candidate;
- hit count is not carrier count;
- record intra-file occurrence locations when material;
- atomicise rejected and surviving clauses;
- use DEC-51 after corrections;
- W3D never chooses the Tier C sample;
- no target entry count;
- exact coverage map before adjudication;
- carry out-of-range evidence to owning tranche;
- preserve prior reasoning losslessly unless evidence mandates a change.

---

# Capture 5 of 7 - what I would tell a fresh W3C session

The review scope is necessary but not sufficient by itself. Current method is
split among Review Scope v1.11, the Standing Task Register decisions and
Classification Repair v1.1.

THE FIVE QUESTIONS WORK WELL on clean propositions. They are awkward for:
- compound entries - atomicity comes first;
- uniqueness/duplication - attack SWEPT/population/probe/classification;
- method/evidence claims - DEC-50 is the right shape;
- DERIVED - review separately and prevent leakage into ASSERTS/DISPOSITION.

Q-D, "anything missing?", is disproportionately valuable.

GENUINELY BORDERLINE CLASSIFICATIONS:
- LED-049 Scopes evaluation = APPLIES;
- LED-044 designer introduction = APPLIES;
- LED-036 Project Status = APPLIES;
- LED-038 PreScope coder response = APPLIES;
- LED-053d authority = MIXED was not clean; use occurrence handling instead.

HIGH-CONFIDENCE SURPRISING CALLS:
- Stage-1B3 version-string "single source" = DIFFERENT;
- D4-Q01 substring q0 = IDENTIFIER;
- coder introduction charter-I7 independent verification = DIFFERENT from GAIS;
- D2 independent verification = DIFFERENT from GAIS;
- F7 Scopes statements are genuine CARRIERs.

COLD LEDGER CHECK ORDER:
1. exact coverage;
2. atomicity;
3. tier mechanically from disposition;
4. population/exclusions;
5. attack every UNIQUE/INDEPENDENT/UNAFFECTED SWEPT;
6. verify canonical home + real noncanonical copy for CURRENT-DUPLICATE;
7. partial-replacement check on prior corrections;
8. reproduce mechanical tests/counts;
9. record out-of-range carriers;
10. only then prose quality.

USEFUL HABITS:
- read source before REASON;
- matched words -> actual subject -> proposition stated;
- search same document too;
- separate "another occurrence exists", "canonical home", and "action for this copy";
- search rejected proposition after a correction;
- scripts enumerate; humans classify semantics;
- preserve negative results;
- compare members, not merely agreeing totals;
- agreement needs a basis;
- after a field correction, inspect headings/status/closing questions/revision
  prose for the rejected proposition.

Optimize for an attackable evidence trail, not speed to verdict.

---

# Capture 6 of 7 - process rules and DEC-64 verification

The current rules are worth their cost. Main danger: form without purpose.

PRACTICAL WARNINGS:
- DEC-50 can become bureaucratic; use the shortest independently testable
  evidence appropriate to the check.
- DEC-67 Rule 3 is necessarily judgement-heavy; bounded/transparently declared
  probe families prevent it becoming an open-ended synonym ritual.
- DEC-51 works only when replacement scope is declared first.
- DEC-63 is excellent mechanically but makes promotion-out of durable knowledge
  essential.

FORM-WITHOUT-PURPOSE FAILURES:
- OPEN EVERY HIT but semantic misclassification;
- right total with wrong membership;
- corrected field with stale framing elsewhere;
- SWEPT with a probe family that does not represent the proposition;
- STAY-CANONICAL naming a copy of the wrong clause;
- correct tier over a non-atomic entry;
- file classification hiding occurrence multiplicity.

DEC-64 POSITION:
W3C ACCEPTS IN PRINCIPLE WITH THE FOLLOWING REFINED PROPAGATION WORDING.

    SUPERSEDED-KIND
        OVERTAKEN | ERRONEOUS

    OVERTAKEN
        The statement was valid in its former context/state and has been
        replaced by a later statement. PROPAGATION is normally N/A unless
        evidence suggests dependent work may not remain valid.

    ERRONEOUS
        The statement was false, materially misleading, or otherwise invalid
        in the context in which project work may have relied on it.

    PROPAGATION - REQUIRED FOR ERRONEOUS
        1. DECLARE THE PROPAGATION SCOPE / POPULATION: identify the bounded set
           of current documents, decisions, code, mathematics, tests or other
           project objects in which reliance could materially survive.
        2. SEARCH FOR RELIANCE ON THE PROPOSITION, NOT MERELY ITS WORDING,
           using the method appropriate to the proposition.
        3. ENUMERATE AND CLASSIFY CANDIDATE DEPENDENCIES, identifying actual
           reliance and non-reliance with attackable location/basis.
        4. ROUTE EACH ACTUAL DEPENDENCY: remains valid for an independent
           reason, needs correction/re-verification, or is itself
           superseded/erroneous.
        5. If none are found, record "none found" with scope and method.
        6. Claim no exhaustiveness beyond declared scope/method.

This should bind before T3 reaches rejected Architecture-A material, after W3D
puts exact binding wording through W3X.

Do not make PROPAGATION an archaeological search for every historical mention.
It is about potentially affected current work.

---

# Capture 7 of 7 - anything else

1. CONSOLIDATE CURRENT REVIEW METHOD.
   Review Scope v1.11 alone is no longer enough. A v1.12/addendum should
   consolidate or point explicitly to later DEC-50/51/60/63/66/67 rules and
   Classification Repair labels, and say:

       T1S01a5 ONLY:
       Tier C sampling COMPLETE.
       11 selected; 3 AGREE / 8 DISAGREE.
       DO NOT SELECT OR REVIEW ANOTHER a5 TIER C SAMPLE.

2. ADD OCCURRENCE-LEVEL EVIDENCE before a6 without redefining MIXED.

3. TREAT REASONING AS PROJECT DATA.
   Preserve rationale, negative search results and semantic classification
   reasons losslessly, while still changing old prose when evidence requires.

4. DO NOT LET a5 RECOVERY BECOME THE PROJECT.
   After the bounded closure corrections are clean, close a5. Do not start
   another generic methodology round merely because recovery was painful.
   a5b is the next useful test of whether the stabilized machinery works.

5. DISTINGUISH TECHNICAL FROM DOCUMENTATION UNCERTAINTY.
   I have no undisclosed conclusion that B2/D is non-viable. Current technical
   unknowns remain explicit: provenance, detector mathematics, Q14, later
   scalar/kernel quality work. The present crisis is continuity/adjudication
   reliability, not proof that the Deblock4 algorithm cannot be built.

6. PROMOTE DURABLE CONTENT OUT OF THIS CAPTURE THROUGH NORMAL AUTHORITY ROUTES.
   Recommended durable proposals:
       A. review-scope consolidation + a5 Tier-C-complete note;
       B. occurrence-level evidence refinement through I7 before a6;
       C. DEC-64 binding propagation wording through W3D/W3X;
       D. durable reviewer habits:
              opening a hit is not reading it;
              right count can contain wrong members;
              file-level hit does not prove occurrence-level uniqueness.

No further critical judgement is intentionally being held for a later summary.
