# Deblock4 - Cross-Check Request to W3C: the T1S01a5 Re-Sweep

**Deliverable:** T1S01a5_A - CROSS-CHECK REQUEST
**Version:** 1.0
**Date:** 2026-08-19
**Author:** W3D
**Route:** W3D -> W3X -> W3C
**Answers:** `T1S01a5_B_Coder_Response_v1_1.md` (Tier C sample: 3 AGREE, 8 DISAGREE)
**Accompanies:** `T1S01a5_A_ReSweep_Evidence` (highest committed version)
**Encoding:** US-ASCII; CRLF.

---

# WHAT W3C IS ASKED TO DO

```text
CORROBORATE OR REFUTE A RE-SWEEP. Not review a ledger - the ledger has not
been rewritten yet, deliberately.

W3C's Tier C sample found 8 of 11 entries defective. W3X then directed that
ALL 34 entries be re-swept rather than the 8 patched. This document is that
re-sweep, recast so W3C can REPRODUCE it rather than read it.

THREE THINGS TO TEST, in priority order:
  1. Can you reproduce the 46-file population from the rules in section 1?
  2. Do the probes in section 3 return the hits recorded there?
  3. Is each hit CLASSIFIED correctly? This is where W3D's last pass failed:
     the searches ran, the hits came back, and W3D did not open them.

W3D HAS NOT DEFENDED ANY OF YOUR EIGHT FINDINGS. All eight were tested against
the corpus and all eight hold. Section 2 records that, including one case where
W3D checked whether you had over-attributed a carrier and found you had not.

NO SOURCE CHANGE. No build, execution, test, patch, delivery machinery or git
operation is involved anywhere in T1.
```

---

# QUESTIONS FOR W3C

```text
QC-1  Does the population reproduce at 46 files?
QC-2  Do the recorded hits reproduce for each probe in section 3?
QC-3  Are the CLASSIFICATIONS right? Every hit is labelled CARRIER, APPLIES,
      DIFFERENT, IDENTIFIER or NOISE with a reason. A wrong CARRIER/APPLIES
      call is the same defect class you just found five times.
QC-4  Section 4 lists the entries W3D judges UNCHANGED. Is any of them
      actually affected? W3D has a standing interest in that list being long.
QC-5  LED-051 - W3D ASKS FOR YOUR OPINION RATHER THAN OFFERING ONE. See 5.1.
QC-6  Is the third method rule in section 2.3 correctly stated?
```

---

# 1. THE POPULATION - REPRODUCE THIS FIRST

```text
Three exclusions, all mechanical path tests, no judgement required:

  A. EXCLUDE if any folder in the path has a name beginning "superseded" or
     "scheduled_for_deletion".                                     (DEC-60)
  B. EXCLUDE anything under T1/.                                   (DEC-63)
     T1/ is a WORKSHOP, NOT A SHELF: knowledge may be drafted there but is
     not searchable, applicable or final until it is moved OUT of T1/ into
     the documentation tree proper. Location determines status.
  C. EXCLUDE GAIS_investigations/ - EVIDENCE-ONLY.                 (DEC-66)
     W3X has moved the two raw GAIS files that previously sat at
     documentation root into that folder:
         GAIS_GATING_RESPONSE.txt
         GAIS_MPEG2_GRID_CONFIRMATION_RESPONSE.txt
     A ledger entry MAY cite GAIS to trace HOW a conclusion was verified. A
     GAIS assertion NEVER refutes a CURRENT-UNIQUE claim and never competes
     with ratified knowledge.

RESULT ON THE COMMON BASE:
    543 files total
    -> retired trees, T1/ and GAIS removed
    -> 46 SEARCHED:  32 root | 8 Scopes/ | 6 reference/holywu_r9/

THREE STRAYS THE RULES DO NOT CATCH. W3D raises these rather than fixing them,
because they are population decisions and W3D's own claims depend on them.

  1. Scopes/Deblock4_T1_W3C_Review_Scope_v1_7.md
     A T1 PROCESS ARTIFACT OUTSIDE THE T1 TREE. Rule B is a path test on T1/,
     and this generation of the review scope lives in Scopes/, so it is still
     searched. It is superseded by v1.11 regardless.
     W3D SUGGESTS moving it to T1/superseded/. IT AFFECTS A LIVE RESULT: it is
     one of the ten carriers recorded for LED-033.

  2. T1_Evidence_Old_Designer_3_Answers_to_Designer_4_Questions_files.zip
     A BINARY ARCHIVE IN THE SEARCH POPULATION. Excluded from adjudication by
     the scope manifest but not from search. Decoding a zip as text produces
     byte noise: during this re-sweep it registered a FALSE HIT on the probe
     "q0". W3D SUGGESTS excluding archives by extension.

  3. reference/holywu_r9/deblock.cpp and deblock_sse4.cpp
     C++ SOURCE. Legitimately in the population, but they match
     identifier-shaped probes rather than propositions. Not a defect - but
     every such hit must be classified IDENTIFIER, and this re-sweep does.
```

---

# 2. THE THREE METHOD RULES THIS RE-SWEEP RUNS UNDER

## 2.1 Open every hit

```text
EVERY HIT RETURNED BY A SWEPT SEARCH MUST BE OPENED AND CLASSIFIED IN THE
ENTRY. A HIT THAT IS RECORDED BUT NOT CLASSIFIED IS NOT SWEPT.

W3X has ratified this and asked W3C to verify the wording. It is the rule that
would have caught five of your eight findings, and W3D states plainly why it
was needed: in LED-055 W3D wrote into the entry "THE DISTINCTION MATTERS AND
IS NOT RESOLVED BY THIS SEARCH" and then did not resolve it.
```

## 2.2 Normalise whitespace

```text
PHRASE-LEVEL SEARCHES ARE WHITESPACE-NORMALISED before matching, because the
corpus wraps sentences across lines and raw line matching returns SILENT
ZEROES rather than errors.

CONCRETE PROOF, and W3C can reproduce it: probing the authority for
"Pixel inference and bitstream truth are different things" with raw line
matching returns ZERO HITS IN THE AUTHORITY ITSELF - the sentence wraps after
"bitstream". LED-035's ninth carrier was missed the same way.
```

## 2.3 Search for the proposition, not for the sentence

```text
THIS IS THE RULE YOUR LED-053 FINDING FORCED OUT, and it is the one W3D most
wants tested.

W3D probed the authority's exact wording - "NO luma-style midpoint/phase
ambiguity" - and concluded the proposition was unique. The corpus states the
SAME PROPOSITION FOUR DIFFERENT WAYS:

    "no luma-style midpoint ambiguity"              README line 285
    "no corresponding midpoint ambiguity"           README line 658
    "no luma-style primary/midpoint distinction"    README line 3671
    "no midpoint class and no phase detector"       Scopes ReDecision Evaluation

A PROBE BUILT FROM ONE DOCUMENT'S WORDING TESTS THAT DOCUMENT, NOT THE CORPUS.
Every probe in section 3 is therefore a SET of terms covering the proposition's
plausible phrasings, not a quotation.
```

## 2.4 The classification vocabulary used throughout

```text
CARRIER     the file ASSERTS the proposition to a reader. Refutes uniqueness.
APPLIES     the file USES or depends on the proposition without stating it.
            Does NOT refute uniqueness.
DIFFERENT   the term matched but the subject is a different proposition.
IDENTIFIER  the term matched source code or syntax, not prose.
NOISE       binary or archive byte match.

THE CARRIER/APPLIES BOUNDARY IS THE JUDGEMENT CALL, and it is the one W3D got
wrong five times. It is QC-3.
```

---

# 3. THE PROBES AND THEIR RESULTS - REPRODUCE THESE

```text
Each probe is a term SET; a file matches if ANY term appears after whitespace
normalisation, case-insensitively.

ENTRY     PROBE TERMS                                       HITS
LED-033   single source | prevailing authority |
          single source of truth                             10
LED-034   four kinds of statements | CODEC FACT |
          PIXEL GEOMETRY                                      1
LED-035   acceptance basis | design or acceptance             9
LED-036   Schedule-SA | Schedule-SB | naming collision         3
LED-037   naming-consistency audit |
          No ambiguous active A/B                             1
LED-038   first sample on the q side | q0 | p2 p1 p0         15
LED-039   row pitch | woven-frame row parity                  5
LED-040   chroma sample coordinates | dividing luma steps |
          subsampling ratio                                   4
LED-041   8x8 blocks of samples | plane-relative |
          4 Y + 1 Cb | blocks per macroblock                  4
LED-042   remain organised in frame structure |
          frame-organised | 6.1.3                            13
LED-043   no coded transform residual | fabricated into |
          truth class                                         2
LED-044   bitstream truth are different | side data |
          cannot KNOW per-macroblock                          2
LED-045   not a Deblock4 grid parameter | TFF/BFF |
          field order                                         5
LED-046   geometry-invariant |
          does not move vertical block columns | x = 8*k      6
LED-047   H.262 provenance re-audit | depends on GAIS         1
LED-048   picture_structure | frame_pred_frame_dct |
          Case (a) | Case (b)                                12
LED-049   mediainfo | --Details=1                             6
LED-053c  luma-style midpoint | corresponding midpoint |
          primary/midpoint | midpoint ambiguity |
          midpoint class and no phase detector                6
LED-053d  row pitch 2 | pitch 2 in frame-memory |
          same-field horizontal filtering uses row pitch      2
LED-055   four rows in each field | four-row projections |
          SeparateFields                                      7
LED-058   regime 3, mixed | regime-3 mix | adaptive per-MB |
          adaptive-capable                                    6
LED-061   no GAIS factual claim |
          independent verification                            6

Entries not listed above returned results consistent with their existing SWEPT
fields under the corrected population; section 4 states which.
```

---

# 4. THE CLASSIFICATIONS - THIS IS QC-3

```text
Only hits whose classification CHANGES A RESULT or was WRONG BEFORE are set
out individually. The rest are recorded in the accompanying evidence document.

LED-053(c)  THE PROPOSITION IS NOT UNIQUE. Your finding, confirmed.
  CARRIER   README v1.12 lines 285, 658, 3671
  CARRIER   Scopes/Deblock4_D4_Architecture_ReDecision_W3C_Evaluation_v1_0
            "in CHROMA PLANE coordinates ... There is no midpoint class and
            no phase detector"
  DIFFERENT Concise Project Summary - luma_midpoint_enabled, a LUMA parameter
  DIFFERENT Verification_And_Tiering - the LUMA primary/midpoint grid
  DIFFERENT coder introduction - the old LUMA union grid
  NOTE FOR W3C: W3D specifically tested whether you had over-attributed the
  Scopes carrier. You had not. It states the chroma proposition directly.

LED-053(d)  NOT UNIQUE. Your Appendix A finding, confirmed, PLUS ONE MORE.
  CARRIER   Appendix A of the SAME authority
  CARRIER   Scopes/..._PreScope_Round_Brief_for_W3C_v1_2_CODER_RESPONSE
            line 535 - "Case (b), field picture: luma/chroma: field grid,
            row pitch 2". THIS ONE IS NEW - found by the re-sweep, not by the
            sample.

LED-055     "THE DERIVATION IS UNIQUE" IS FALSE. Your finding, confirmed.
  CARRIER   README v1.12 lines 3675-3679 AND 3204-3207. Two places, not one.

LED-058     "LATENT RATHER THAN ACTUAL" IS FALSE. Your finding, confirmed.
  CARRIER   Grid Knowledge v1.2 line 193 - adaptive per-MB (regime 3, mixed).
            Also lines 214 and 234.

LED-061     CARRIER LIST WRONG IN BOTH DIRECTIONS. Your finding, confirmed.
  DIFFERENT Deblock4_Stage_2C_D2_HolyWu_Real_Schedule_v1_7 - its two
            "independent verification" hits are about W3C verifying THAT
            DOCUMENT (D0 section 6 two-sided sweep), not the GAIS rule.
            W3D listed it as a carrier without opening it.
  CARRIER   222-INITIAL_BLURB_FOR_CODER_CHAT_v1_3.txt - OMITTED by W3D,
            found by you.

LED-035     A NINTH CARRIER, MISSED BY LINE MATCHING.
  Scopes/Deblock4_D4_Architecture_ReDecision_W3C_Evaluation_v1_0 contains the
  phrase, WRAPPED ACROSS A LINE BREAK.
  W3D CLASSIFIES IT "APPLIES", NOT "CARRIER": it reads "not a Deblock4
  acceptance basis" as an aside qualifying an illustrative threshold example,
  using the rule rather than stating it.
  THIS IS EXACTLY THE JUDGEMENT CALL W3D GOT WRONG FIVE TIMES. Test it.

LED-052a    THE RETIRED DESCRIPTION IS STILL LIVE - NEW FINDING.
  The entry previously said the search "DID NOT ESTABLISH whether that
  document's text was ever amended". IT IS NOT AMENDED.
  Scopes/..._PreScope_Round_Brief_for_W3C_v1_2_CODER_RESPONSE lines 757-759
  still present the retired parity-split vertical four-row pack as current:
  "the vertical row pack gathers its four logical rows explicitly".
  This upgrades a routed possibility to a fact.

LED-038     15 HITS, ALL CLASSIFIED.
  CARRIER    charter B1; README; the authority
  APPLIES    Concise Summary, Project Status, D0, D2, designer introduction,
             two Scopes briefs - all use q0 notation without defining it
  IDENTIFIER holywu_r9 deblock.cpp, deblock_sse4.cpp, provenance - C++ symbols
  NOISE      the evidence zip - byte match, see stray 2

LED-039     THE UNIQUENESS CLAIM SURVIVES, AND HERE IS WHY IT LOOKED LIKE IT
            MIGHT NOT. Four files match "row pitch". README and three Scopes
            documents use it in the SIMD-STRIDE sense - DIFFERENT. The
            authority's woven-parity and footprint-pitch definitions are still
            the only assertions of that proposition. The word is overloaded
            across the project and the entry says so.
```

---

# 5. THE ONE W3D WILL NOT CALL

## 5.1 LED-051 - QC-5

```text
THE QUESTION: Scopes/Deblock4_D4_Architecture_ReDecision_W3C_Evaluation_v1_0
contains the whole-frame coordinate mathematics - it is the WORKING RECORD in
which the transposition was first derived. Does a derivation record that
contains the mathematics COUNT AS A CARRIER of the mathematics?

W3D's entry currently defers the question to T1S01b and calls the authority's
coordinates unique in the meantime.

W3D IS NOT OFFERING AN OPINION, AND THE REASON IS SPECIFIC: this is the SAME
CALL W3D GOT WRONG AT LED-055. There the README's row-projection derivation was
found, left unclassified, and the authority's derivation was called unique. You
found it. LED-051 is the same shape with a different document, and W3D's
judgement on this exact question has been tested once and failed.

W3C's answer decides whether LED-051 is CURRENT-UNIQUE or CURRENT-DUPLICATE.
```

---

# 6. WHAT THE RE-SWEEP CONCLUDES

```text
DISPOSITIONS THAT MUST CHANGE - five splits:
    LED-043   c1 codec fact stays with F5; c2 project rule -> section 15.
              YOUR FINER SPLIT IS ADOPTED; W3D's coarser remedy is withdrawn
              because it would have moved a codec fact out of the F-series.
    LED-053   (b) unique; (c) and (d) duplicate, section 4.5 canonical
    LED-055   withdraw "the derivation is unique"; separate the duplicated
              mechanism from qualifiers that may still be unique
    LED-058   the reading rule is unique; the evidence-precision proposition
              is duplicated
    LED-061   the nuanced assessment is unique; the rule, the evidence-only
              status and the precedence clause are duplicated

FINDINGS THAT CHANGE:
    LED-058   "latent" -> ACTUAL
    LED-034   the T3 protection-gap proposition is WITHDRAWN ENTIRELY. Your
              reading of T3 is right: it strips duplicated content OUT OF
              OTHER DOCUMENTS INTO the authority. The authority is T3's
              target, not its subject. W3D invented a risk the task does not
              create.
    LED-052a  the retired description is still live - new

CORRECTIONS OF RECORD:
    LED-046   cross-reference LED-049 -> LED-052a
    LED-061   remove D2, add the coder chat blurb
    LED-033, LED-035, LED-036, LED-049   carrier lists rebuilt
    LED-037   the REASON is replaced by the search that actually proves
              uniqueness. Your point stands: "no other document can hold it"
              is not a proof, because another document can report an audit
              result.

ENTRY COUNT after the splits: 34 -> 39.
DISPOSITIONS SURVIVING UNCHANGED: 24 of 34 - and QC-4 asks you to test that
number, because W3D benefits from it being large.
```

---

*End of cross-check request. Nothing here is ratified. The ledger has not been
rewritten; it will be rewritten against whatever survives this cross-check.*
