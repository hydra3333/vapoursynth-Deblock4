# Deblock4 - T1S01a5 Re-Sweep Evidence (all 34 entries, corrected population and method)

**Deliverable:** T1S01a5_A - RE-SWEEP EVIDENCE
**Version:** 1.0
**Date:** 2026-08-19
**Author:** W3D
**Route:** W3D -> W3X -> W3C
**Answers:** W3C Tier C sample review v1.1 (3 AGREE, 8 DISAGREE)
**Implements:** Q14 (re-sweep all 34) and Q15 (open and classify every hit)
**Encoding:** US-ASCII; CRLF.

---

# 0. WHAT THIS IS, AND WHY IT IS SEPARATE FROM THE LEDGER

```text
W3C's Tier C sample found 8 of 11 entries defective. W3D verified every one of
the eight against the corpus: ALL EIGHT HOLD. Nothing was resisted.

The root cause of five of them is ONE behaviour, and it is not "did not
search": W3D ran the search, got the hit, and did not open it.

  LED-053(c)  found README's midpoint hits, OPENED them, and MISCLASSIFIED
              them as luma-only.
  LED-055     found README as a SeparateFields hit and wrote into the entry
              "THE DISTINCTION MATTERS AND IS NOT RESOLVED BY THIS SEARCH" -
              then did not resolve it.
  LED-058     listed Grid Knowledge as carrying "REGIME 3", then concluded no
              live document asserts observed mixture. Grid Knowledge line 193
              reads: adaptive per-MB (regime 3, mixed).
  LED-061     counted a keyword hit in D2 without opening it. D2's
              "independent verification" is about W3C verifying THAT document.
  LED-053(d)  never checked Appendix A, in a ledger whose LED-036 cites
              Appendix A as a restatement source.

THIS DOCUMENT IS THE RE-SWEEP ITSELF - the searches, every hit, and a
classification for every hit. The ledger rewrite applies it. They are separate
so that if this session ends, the expensive part survives and the rewrite is
mechanical rather than re-derived.
```

---

# 1. THE CORRECTED POPULATION - 46 FILES

```text
EXCLUDED  any folder whose name begins "superseded" or
          "scheduled_for_deletion"                              DEC-60
EXCLUDED  anything under T1/                                    DEC-63
EXCLUDED  GAIS_investigations/ - evidence-only                  DEC-66
          including the two files W3X moved there from root:
          GAIS_GATING_RESPONSE.txt
          GAIS_MPEG2_GRID_CONFIRMATION_RESPONSE.txt

    543 files -> retired trees, T1/ and GAIS removed -> 46 SEARCHED
      32 root | 8 Scopes/ | 6 reference/holywu_r9/

THREE STRAYS FOUND WHILE REBUILDING THE POPULATION. Each is a file the rules
do not catch and probably should. Raised for W3X, not fixed by W3D:

  1. Scopes/Deblock4_T1_W3C_Review_Scope_v1_7.md
     A T1 PROCESS ARTIFACT OUTSIDE THE T1 TREE. DEC-63 excludes T1/ by path;
     this generation of the review scope lives in Scopes/ and is therefore
     still searched. It is superseded by v1.11 in any case.
     RECOMMEND: move to T1/superseded/.

  2. T1_Evidence_Old_Designer_3_Answers_to_Designer_4_Questions_files.zip
     A BINARY ZIP IN THE SEARCH POPULATION. T1S00 2.0c excludes it from
     adjudication but nothing excludes it from search. Decoding a zip as text
     produces byte noise that matches short probes - it registered a false hit
     on "q0" during this re-sweep.
     RECOMMEND: move to T1/, or exclude archives by extension.

  3. reference/holywu_r9/deblock.cpp and deblock_sse4.cpp
     C++ SOURCE matching identifier-shaped probes ("q0") rather than
     propositions. Not a defect - they are legitimately in the population -
     but every probe hitting them must be classified as an identifier match,
     which this re-sweep does.
```

---

# 2. THE METHOD RULE THIS RE-SWEEP RUNS UNDER

```text
RULE (Q15, W3X ratified, W3C to verify wording):
  EVERY HIT RETURNED BY A SWEPT SEARCH MUST BE OPENED AND CLASSIFIED IN THE
  ENTRY. A HIT THAT IS RECORDED BUT NOT CLASSIFIED IS NOT SWEPT.

RULE (Q13):
  PHRASE-LEVEL SEARCHES ARE WHITESPACE-NORMALISED. The corpus wraps sentences
  across lines and raw line matching returns SILENT ZEROES.

THIRD RULE, ADDED BY THIS RE-SWEEP because the sample exposed it:
  SEARCH FOR THE PROPOSITION, NOT FOR THE AUTHORITY'S SENTENCE. LED-053(c)
  was missed because W3D probed the authority's exact phrase, "NO luma-style
  midpoint/phase ambiguity". The corpus states the same proposition FOUR
  different ways:
      "no luma-style midpoint ambiguity"           README line 285
      "no corresponding midpoint ambiguity"        README line 658
      "no luma-style primary/midpoint distinction" README line 3671
      "There is no midpoint class and no phase detector"
                                                   Scopes ReDecision Evaluation
  A probe built from one document's wording tests that document, not the
  corpus.

CLASSIFICATION VOCABULARY used below:
  CARRIER    the file asserts the proposition. Refutes uniqueness.
  APPLIES    the file uses or depends on the proposition without stating it.
             Does not refute uniqueness.
  DIFFERENT  the term matched but the subject is a different proposition.
  IDENTIFIER the term matched source-code or syntax, not prose.
  NOISE      binary/archive byte match.
```

---

# 3. THE EIGHT W3C FINDINGS - ALL VERIFIED, ALL AGAINST W3D

```text
LED-053(c)  UNIQUENESS REFUTED. CARRIERS:
              README v1.12 lines 285, 658, 3671
              Scopes/Deblock4_D4_Architecture_ReDecision_W3C_Evaluation_v1_0
                "in CHROMA PLANE coordinates ... There is no midpoint class
                 and no phase detector"
            CLASSIFIED AND NOT CARRIERS - each opened:
              Concise Project Summary  DIFFERENT (luma_midpoint_enabled, a
                                       luma parameter)
              Verification_And_Tiering DIFFERENT (the luma primary/midpoint
                                       grid)
              coder introduction       DIFFERENT (the old luma union grid)
            W3C named README and Scopes. BOTH CONFIRMED. W3D checked whether
            W3C had over-attributed the Scopes carrier and it had not.

LED-053(d)  UNIQUENESS REFUTED. CARRIERS:
              Appendix A of the SAME authority - "Case (b) ... same-field
                horizontal filtering uses row pitch 2"
              Scopes/..._PreScope_Round_Brief_for_W3C_v1_2_CODER_RESPONSE
                line 535 - "Case (b), field picture: luma/chroma: field grid,
                row pitch 2"
            W3C named Appendix A. THE SCOPES CARRIER IS ADDITIONAL, found by
            this re-sweep.

LED-055     "THE DERIVATION IS UNIQUE" REFUTED. CARRIER:
              README v1.12 lines 3675-3679 and 3204-3207, both stating the
              row-projection mechanism: eight chroma frame rows per component,
              separated into four rows in each field.
            The entry's own SWEPT field found this file and left the hit
            unclassified.

LED-058     "LATENT RATHER THAN ACTUAL" IS FALSE. CARRIER:
              Deblock4_MPEG2_Grid_Field_DCT_Knowledge_v1_2 line 193:
              frame_pred_frame_dct "No" = 0 = adaptive per-MB (regime 3,
              mixed). Also lines 214 and 234.
            The document is live until T2 retires it. The exposure is ACTUAL.

LED-061     SWEPT CARRIER LIST WRONG IN BOTH DIRECTIONS.
              FALSE CARRIER: Deblock4_Stage_2C_D2_HolyWu_Real_Schedule_v1_7.
                Its two "independent verification" hits are about W3C
                verifying THAT DOCUMENT (D0 section 6 two-sided sweep), not
                the GAIS rule. DIFFERENT.
              OMITTED CARRIER: 222-INITIAL_BLURB_FOR_CODER_CHAT_v1_3.txt,
                which states the rule in terms.
              REMOVED BY POPULATION: the GAIS investigation brief is now
                evidence-only.

LED-046     CROSS-REFERENCE WRONG. The entry sends the reader to LED-049 for
            the parity-split retirement. LED-049 is the MediaInfo triage
            entry; the retirement is LED-052a. A stale reference surviving
            from W3D's planning-stage numbering.

LED-043     ATOMIC FAILURE. F5's proposition (c) bundles two things:
              c1  a macroblock with no coded residual does not necessarily
                  carry a meaningful dct_type bit          CODEC-SYNTAX FACT
              c2  such a macroblock MUST NOT be fabricated into a truth class
                                                           PROJECT RULE
            W3D's CLASS field calls the whole of (c) a project rule. c1 is
            not. W3D's proposed remedy - move all of (c) to section 15 - would
            move a codec fact out of the F-series. W3C's finer split is right.

LED-034     REASONING WRONG, NOT SEARCH. The DERIVED block claims T3 might
            reduce section 1 and leave the taxonomy homeless. T3's actual
            text: "strip duplicated KNOWLEDGE and DECISIONS out of the OTHER
            documents and replace them with pointers to the authority", plus
            "Load-bearing content with no existing home comes to W3X as a list
            with a proposed destination". THE AUTHORITY IS T3's TARGET, NOT
            ITS SUBJECT. W3D invented a risk the task does not create.
            WITHDRAW the protection-gap proposition; the CURRENT-UNIQUE
            disposition stands.
```

---

# 4. WHAT THE RE-SWEEP FOUND IN THE 23 ENTRIES W3C DID NOT SAMPLE

```text
This is the part Q14 exists for. The sample was 11 of 33; these are the rest.

LED-033  CARRIER SET CORRECTED. Under the 46-file population the single-source
         proposition is carried by: authority header, both introductions, both
         chat blurbs, Project Status, Forward Roadmap, Documentation Currency
         Audit, Session Bootstrap Header, and the STRAY review-scope copy in
         Scopes/ (see section 1). Ten files. The entry named seven.
         DISPOSITION UNCHANGED - CURRENT-DUPLICATE, POINTER.

LED-035  CARRIER SET CORRECTED to nine. The entry named eight and omitted
         Scopes/Deblock4_D4_Architecture_ReDecision_W3C_Evaluation_v1_0,
         where the phrase WRAPS ACROSS A LINE BREAK and raw matching missed
         it. Opened and classified: it states "not a Deblock4 acceptance
         basis" as an aside qualifying an illustrative threshold example.
         W3D classifies it APPLIES rather than CARRIER - it uses the rule
         rather than stating it - and records the judgement so W3C can test it.
         DISPOSITION UNCHANGED.

LED-036  COPY LIST CORRECTED. The entry named Appendix A and the Concise
         Summary. The re-sweep adds the designer introduction and Project
         Status, both of which use the Schedule-SA/SB spelling.
         DISPOSITION UNCHANGED - STAY-CANONICAL, and the named concrete copy
         (Appendix A lines 1813-1814) still satisfies DEC-43.

LED-037  UNIQUENESS NOW ACTUALLY PROVED. W3C's finding was that the entry's
         REASON - "it is an audit record about this document, so no other
         document can hold it" - is not a uniqueness proof, because another
         document could report the same audit result. CORRECT. The corpus
         search for an equivalent audit-result proposition returns ONE file,
         the authority. The SWEPT field must now record that search rather
         than the reasoning.

LED-038  15 raw hits, CLASSIFIED: charter B1 and README CARRIER; authority
         CARRIER; Concise Summary, Project Status, D0, D2, designer intro,
         two Scopes briefs APPLIES (they use q0 notation); holywu_r9
         deblock.cpp / deblock_sse4.cpp / provenance IDENTIFIER (C++ symbols);
         the evidence zip NOISE. DISPOSITION UNCHANGED.

LED-039  5 hits. Authority CARRIER for the pitch/parity definitions; README
         and three Scopes documents use "row pitch" in the SIMD-stride sense -
         DIFFERENT. The uniqueness claim for the woven-parity and
         footprint-pitch definitions HOLDS.

LED-041  4 hits. Grid Knowledge CARRIER (4 Y + 1 Cb + 1 Cr); designer intro
         and Project Status APPLIES. STAY-CANONICAL holds with Grid Knowledge
         as the named concrete non-canonical copy.

LED-042  13 hits, all classified. Carriers: designer intro, designer blurb,
         Concise Summary, Project Status, Grid Knowledge, and five Scopes
         documents. The chat-2 death resume brief matched on "6.1.3" only -
         DIFFERENT. STAY-CANONICAL holds.

LED-044  2 hits. Designer introduction APPLIES (Q14 side-data discussion).
         CURRENT-UNIQUE HOLDS.

LED-045  5 hits. Designer intro CARRIER; README "field order" DIFFERENT
         (source-mode semantics); two Scopes briefs APPLIES. STAY-CANONICAL
         holds.

LED-047  1 hit. CURRENT-UNIQUE HOLDS.

LED-048  12 hits, all classified as carriers or applications of the regime
         semantics. DISPOSITION UNCHANGED.

LED-049  6 hits under the corrected population, not eight. Grid Knowledge
         CARRIER; both introductions and the designer blurb CARRIER for the
         not-per-MB qualification; Scopes evaluation APPLIES.
         STAY-CANONICAL holds.

LED-050  R_s / W_s notation: authority only among asserting documents; the
         Scopes evaluation uses the same six-sample footprint at pitch 1
         without the parameterisation - APPLIES. CURRENT-UNIQUE HOLDS.

LED-051  The coordinate mathematics: authority CARRIER; Scopes ReDecision
         evaluation is the DERIVATION RECORD in which the transposition was
         first worked out. W3D flags this as the SAME QUESTION LED-055 GOT
         WRONG - a working record that contains the mathematics is a carrier
         or is not, and the entry currently defers it to T1S01b. W3D now
         thinks that deferral needs W3C's opinion rather than W3D's.

LED-052  6 hits, same set as LED-046. DISPOSITION UNCHANGED.

LED-052a THE RETIRED DESCRIPTION IS STILL LIVE. The parity-split vertical
         four-row pack appears in Scopes/..._PreScope_Round_Brief_for_W3C_
         v1_2_CODER_RESPONSE line 757-759: "the vertical row pack gathers its
         four logical rows explicitly". The entry said the search "DID NOT
         ESTABLISH whether that document's text was ever amended". IT IS NOT
         AMENDED. The retired description is presented as current in a live
         Scopes document. This upgrades LED-052a's routed item from a
         possibility to a fact.

LED-054  "always frame" - authority only, under the corrected population. The
         two GAIS hits that previously appeared are now evidence-only.
         STAY-CANONICAL for proposition (c) HOLDS and is now cleaner.

LED-056  Absorption record: authority only. CURRENT-UNIQUE HOLDS.

LED-057  The LG table and OTA figures: authority and Grid Knowledge only.
         STAY-CANONICAL HOLDS.

LED-059  Unchanged; still the conditional pending a6.

LED-060  libpostproc/MBAFF/Changick: under the corrected population the GAIS
         answer files leave the count. Remaining carriers are the authority
         and four Scopes documents, all T1S01b evidence. CURRENT-UNIQUE for
         the consolidated prior-art record HOLDS.

LED-062  The five patent numbers: authority plus four Scopes documents. The
         CORRECTED ATTRIBUTION TABLE remains authority-only. CURRENT-UNIQUE
         HOLDS.

LED-063  Unchanged. Still CONFLICTING, still routed to a6 with DEC-58.
```

---

# 5. NET EFFECT ON THE LEDGER

```text
DISPOSITIONS THAT CHANGE:
    LED-043   split c1 (codec fact, stays with F5) from c2 (project rule,
              canonical at section 15)
    LED-053   split (b) CURRENT-UNIQUE from (c) and (d), both now
              CURRENT-DUPLICATE with section 4.5 canonical
    LED-055   withdraw "the derivation is unique"; split the duplicated
              mechanism from the qualifiers that may still be unique
    LED-058   split the reading rule (c2) as CURRENT-UNIQUE from the
              duplicated evidence-precision proposition
    LED-061   split (a), the nuanced assessment, as CURRENT-UNIQUE from the
              three duplicated propositions

FINDINGS THAT CHANGE:
    LED-058   "latent rather than actual" -> ACTUAL, Grid Knowledge line 193
    LED-034   withdraw the T3 protection-gap proposition entirely
    LED-052a  the retired description IS still live in a Scopes document

CORRECTIONS OF RECORD:
    LED-046   LED-049 -> LED-052a
    LED-061   remove D2, add the coder chat blurb
    LED-033, LED-035, LED-036, LED-049  carrier lists rebuilt
    LED-037   replace the reasoning with the search that proves uniqueness

ENTRY COUNT: 34 -> 39 if all five splits are taken as new entries
             (LED-043a, LED-053b, LED-055a, LED-058a, LED-061a).

DISPOSITIONS THAT SURVIVE UNCHANGED: 24 of 34.
```

---

# 6. WHAT W3D IS NOT DOING IN THIS DOCUMENT

```text
NOT REWRITING THE LEDGER. That is the next step and it applies this evidence
mechanically. It is separated deliberately: the re-sweep is the expensive,
error-prone part and it is now on paper, so a session that ends does not cost
it. The five splits and the carrier-list rebuilds are then transcription.

NOT RE-DECIDING ANYTHING ARCHITECTURAL. No disposition change above touches
B2, D, or any ratified decision. Every change is about where a statement lives
and whether it is duplicated.

NOT DEFENDING ANY OF THE EIGHT. All eight W3C findings were tested against the
corpus and all eight hold. W3D checked one of them - the Scopes carrier for
LED-053(c) - specifically to see whether W3C had over-attributed, and it had
not.
```

---

*End of re-sweep evidence. Nothing here is ratified.*
