# Deblock4 - T1S01a5 Classification Repair

**Deliverable:** T1S01a5_A - CLASSIFICATION REPAIR
**Version:** 1.0
**Date:** 2026-08-19
**Author:** W3D
**Route:** W3D -> W3X -> W3C
**Answers:** `T1S01a5_B_ReSweep_CrossCheck_Response_v1_0.md`, QC-3
**Encoding:** US-ASCII; CRLF.

---

# 0. WHAT THIS IS

```text
THE MINIMAL REPAIR W3C ASKED FOR, TAKEN AS WRITTEN. Not another search round -
W3C reproduced all 22 probe counts exactly and said explicitly not to rerun
them. Nothing has been rerun except one probe expansion, declared at LED-033.

For every probe: the EXACT candidate file list, every file labelled, a reason
where the call is not self-evident. Nothing summarised away.

LABELS
  CANONICAL   the home the entry proposes. Shown separately from CARRIER so
              the canonical choice is visible rather than buried.
  CARRIER     the file ASSERTS the proposition to a reader. Refutes uniqueness.
  APPLIES     uses or depends on it WITHOUT stating it. Does not refute.
  DIFFERENT   the term matched; the subject is another proposition.
  IDENTIFIER  matched source code or a project identifier, not prose.
  MIXED       one file carries more than one meaning. W3C's rule 4.

THE TABLE IS GENERATED FROM THE SEARCH, NOT TYPED. The file lists are emitted
by the same harness that ran the probes, and a completeness check fails the
build if any returned file has no label. THAT CHECK ALREADY EARNED ITSELF: it
caught D2 unclassified in LED-061 - W3D had removed it from the carrier list
after W3C's finding and then not labelled it at all. A file you reject is
still a file you must classify.
```

# 1. WHAT THE REPAIR FOUND THAT W3C HAD NOT

```text
Classifying properly - rather than counting - turned up four defects in
entries W3C had not challenged:

LED-035  THREE OF THE CARRIERS ARE NOT CARRIERS.
         Forward Roadmap    "the acceptance basis it would have set" - Stage
                            3C's DEFERRED acceptance basis
         Project Status     "separation of STATUS AND ACCEPTANCE BASIS"
         D0 index           "the acceptance basis under the oracle-
                            construction exception"
         Three different propositions sharing two words. The carrier count
         falls from the 8 W3D claimed, and the 9 W3C computed, to SIX.

LED-055  A SECOND CARRIER OF THE MECHANISM. W3C found the README. The Scopes
         ReDecision Brief also states it - "tears frame-organised blocks
         across two clips (4 rows each)". The uniqueness claim was wrong by
         two documents, not one.

LED-049  GRID KNOWLEDGE IS MIXED, not a plain carrier. It carries the triage
         route AND a separate general statement about measuring real files
         with MediaInfo/ffprobe. The Scopes evaluation only REPORTS that the
         old document records the check - APPLIES, not CARRIER.

LED-033  THE RULE-3 EXPANSION WAS NEEDED IMMEDIATELY. The declared probe
         missed the designer introduction, which writes "PREVAILING MPEG-2
         AUTHORITY" rather than the contiguous "prevailing authority". Probe
         expanded, reason recorded here, same population rerun - and the
         expansion also picked up the coder introduction on the same phrase.
         W3C's coincidence finding is confirmed and now closed.
```

# 2. THE REPAIRED TABLE

## LED-033

```text
PROBE FAMILY: single source | prevailing authority | single source of truth | PREVAILING MPEG-2 AUTHORITY
CANDIDATE FILES RETURNED: 11

  CARRIER    111_New_Chat_Introduction_for_Coder_v1_33.md
  CARRIER    111_New_Chat_Introduction_for_Designer_v1_28.md
             FOUND ONLY BY THE RULE-3 EXPANSION - writes PREVAILING MPEG-2 AUTHORITY
  CARRIER    222-INITIAL_BLURB_FOR_CODER_CHAT_v1_3.txt
  CARRIER    222-INITIAL_BLURB_FOR_DESIGNER_CHAT_v1_4.txt
  CARRIER    Deblock4_Documentation_Currency_Audit_v1_6.md
             asserts the status in a document index
  CARRIER    Deblock4_Forward_Roadmap_v1_22.md
             same index wording
  CANONICAL  Deblock4_MPEG2_Deblocking_Investigation_and_Decided_Architecture_v1_05.md
             the header's single-source rule, adjudicated at LED-021
  CARRIER    Deblock4_Project_Status_v1_32.md
  DIFFERENT  Deblock4_Scope_Stage_1B3_Runtime_Capability_Guard_v1_3.md
             a Zig comment: single source of the VERSION STRING
  CARRIER    Deblock4_Session_Bootstrap_Header_v1_3.md
  CARRIER    Scopes/Deblock4_T1_W3C_Review_Scope_v1_7.md
             but it is STRAY 1 - a T1 process artifact outside T1/
```

## LED-035

```text
PROBE FAMILY: acceptance basis | design or acceptance
CANDIDATE FILES RETURNED: 9

  CARRIER    111_New_Chat_Introduction_for_Coder_v1_33.md
  CARRIER    111_New_Chat_Introduction_for_Designer_v1_28.md
  CARRIER    222-INITIAL_BLURB_FOR_DESIGNER_CHAT_v1_4.txt
  DIFFERENT  Deblock4_Forward_Roadmap_v1_22.md
             NEW: Stage 3C's DEFERRED acceptance basis, not the Classic rule
  CANONICAL  Deblock4_MPEG2_Deblocking_Investigation_and_Decided_Architecture_v1_05.md
             D4-D08
  DIFFERENT  Deblock4_Project_Status_v1_32.md
             NEW: separation of STATUS AND ACCEPTANCE BASIS - another proposition
  DIFFERENT  Deblock4_Stage_2C_D0_Preface_and_Binding_Knowledge_Index_v1_14.md
             NEW: the oracle-construction exception's acceptance basis
  CARRIER    Scopes/Deblock4_D4_Architecture_ReDecision_W3C_Evaluation_v1_0.md
             W3C was right - it STATES the rule while using it
  CARRIER    Scopes/Deblock4_D4_PreScope_Round_Brief_for_W3C_v1_2_CODER_RESPONSE.md
```

## LED-036

```text
PROBE FAMILY: Schedule-SA | Schedule-SB | naming collision
CANDIDATE FILES RETURNED: 3

  CARRIER    111_New_Chat_Introduction_for_Designer_v1_28.md
             states the renaming AND the collision it prevents
  CANONICAL  Deblock4_MPEG2_Deblocking_Investigation_and_Decided_Architecture_v1_05.md
             section 1.1 states the rule, its origin and its purpose
  APPLIES    Deblock4_Project_Status_v1_32.md
             uses the SA/SB spelling; does not state the rule
```

## LED-040

```text
PROBE FAMILY: chroma sample coordinates | dividing luma steps | subsampling ratio
CANDIDATE FILES RETURNED: 4

  CANONICAL  AI_Charter_and_Invariants_Card_v1_31.md
             invariant B5
  CARRIER    Deblock4_MPEG2_Deblocking_Investigation_and_Decided_Architecture_v1_05.md
             the local restatement being adjudicated
  CARRIER    Deblock4_Stage_2C_D0_Preface_and_Binding_Knowledge_Index_v1_14.md
  CARRIER    README_Deblock4_Design_Spec_v1_12.md
```

## LED-041

```text
PROBE FAMILY: 8x8 blocks of samples | plane-relative | 4 Y + 1 Cb | blocks per macroblock
CANDIDATE FILES RETURNED: 4

  CARRIER    111_New_Chat_Introduction_for_Designer_v1_28.md
             section 3.4 states plane-relative chroma geometry
  CANONICAL  Deblock4_MPEG2_Deblocking_Investigation_and_Decided_Architecture_v1_05.md
             the F-series
  CARRIER    Deblock4_MPEG2_Grid_Field_DCT_Knowledge_v1_2.md
             the named concrete non-canonical copy for STAY-CANONICAL
  CARRIER    Deblock4_Project_Status_v1_32.md
```

## LED-044

```text
PROBE FAMILY: bitstream truth are different | side data | cannot KNOW per-macroblock
CANDIDATE FILES RETURNED: 2

  APPLIES    111_New_Chat_Introduction_for_Designer_v1_28.md
             lists trusted per-MB side data as a FUTURE possibility
  CANONICAL  Deblock4_MPEG2_Deblocking_Investigation_and_Decided_Architecture_v1_05.md
             F6
```

## LED-045

```text
PROBE FAMILY: not a Deblock4 grid parameter | TFF/BFF | field order
CANDIDATE FILES RETURNED: 5

  CARRIER    111_New_Chat_Introduction_for_Designer_v1_28.md
  CANONICAL  Deblock4_MPEG2_Deblocking_Investigation_and_Decided_Architecture_v1_05.md
             F7
  DIFFERENT  README_Deblock4_Design_Spec_v1_12.md
             field order in a list of frame-level properties MediaInfo exposes
  CARRIER    Scopes/Deblock4_D4_Architecture_ReDecision_Brief_for_W3C_v1_0.md
             W3C was right - states F7 in terms
  CARRIER    Scopes/Deblock4_D4_PreScope_Round_Brief_for_W3C_v1_2.md
             W3C was right
```

## LED-047

```text
PROBE FAMILY: H.262 provenance re-audit | depends on GAIS
CANDIDATE FILES RETURNED: 1

  CANONICAL  Deblock4_MPEG2_Deblocking_Investigation_and_Decided_Architecture_v1_05.md
             unique - the only provenance record for the F-series
```

## LED-049

```text
PROBE FAMILY: mediainfo | --Details=1
CANDIDATE FILES RETURNED: 6

  CARRIER    111_New_Chat_Introduction_for_Coder_v1_33.md
  CARRIER    111_New_Chat_Introduction_for_Designer_v1_28.md
  CARRIER    222-INITIAL_BLURB_FOR_DESIGNER_CHAT_v1_4.txt
  CANONICAL  Deblock4_MPEG2_Deblocking_Investigation_and_Decided_Architecture_v1_05.md
             the surviving triage route
  MIXED      Deblock4_MPEG2_Grid_Field_DCT_Knowledge_v1_2.md
             carries the route AND a separate general evidence-discipline statement about MediaInfo/ffprobe measurement
  APPLIES    Scopes/Deblock4_D4_Architecture_ReDecision_W3C_Evaluation_v1_0.md
             reports that the old document records the check; does not state the route
```

## LED-053d

```text
PROBE FAMILY: row pitch 2 | pitch 2 in frame-memory
CANDIDATE FILES RETURNED: 2

  MIXED      Deblock4_MPEG2_Deblocking_Investigation_and_Decided_Architecture_v1_05.md
             section 4.5 is the copy adjudicated; APPENDIX A OF THE SAME FILE is a second carrier and does not appear as a separate hit
  CARRIER    Scopes/Deblock4_D4_PreScope_Round_Brief_for_W3C_v1_2_CODER_RESPONSE.md
             Case (b) field picture: luma/chroma field grid, row pitch 2
```

## LED-055

```text
PROBE FAMILY: four rows in each field | four-row projections | SeparateFields
CANDIDATE FILES RETURNED: 7

  CARRIER    111_New_Chat_Introduction_for_Designer_v1_28.md
             the CONCLUSION only
  CARRIER    Deblock4_Concise_Project_Summary_v1.5.md
             the conclusion only
  CANONICAL  Deblock4_MPEG2_Deblocking_Investigation_and_Decided_Architecture_v1_05.md
             the derivation; D4-D01 is canonical for the conclusion
  CARRIER    Deblock4_Project_Status_v1_32.md
             the conclusion only
  CARRIER    README_Deblock4_Design_Spec_v1_12.md
             THE MECHANISM, twice - A.9.3 and the earlier passage. This refutes the uniqueness claim
  CARRIER    Scopes/Deblock4_D4_Architecture_ReDecision_Brief_for_W3C_v1_0.md
             NEW: states the mechanism too - tears blocks across two clips, 4 rows each
  CARRIER    Scopes/Deblock4_D4_PreScope_Round_Brief_for_W3C_v1_2.md
             the conclusion with a compressed reason
```

## LED-058

```text
PROBE FAMILY: regime 3, mixed | regime-3 mix | adaptive per-MB | adaptive-capable
CANDIDATE FILES RETURNED: 6

  CARRIER    111_New_Chat_Introduction_for_Coder_v1_33.md
             the adaptive-capable proposition
  CARRIER    111_New_Chat_Introduction_for_Designer_v1_28.md
  CARRIER    222-INITIAL_BLURB_FOR_CODER_CHAT_v1_3.txt
  CARRIER    222-INITIAL_BLURB_FOR_DESIGNER_CHAT_v1_4.txt
  CANONICAL  Deblock4_MPEG2_Deblocking_Investigation_and_Decided_Architecture_v1_05.md
             section 6.2, and the unique reading rule
  CARRIER    Deblock4_MPEG2_Grid_Field_DCT_Knowledge_v1_2.md
             OF THE STALE SHORTHAND - regime 3, mixed. THIS IS THE ACTUAL EXPOSURE the reading rule exists for
```

## LED-061

```text
PROBE FAMILY: no GAIS factual claim | independent verification
CANDIDATE FILES RETURNED: 6

  DIFFERENT  111_New_Chat_Introduction_for_Coder_v1_33.md
             I7 independent verification of self-affecting criteria - charter process
  CARRIER    111_New_Chat_Introduction_for_Designer_v1_28.md
  CARRIER    222-INITIAL_BLURB_FOR_CODER_CHAT_v1_3.txt
             OMITTED by W3D, found by W3C
  CARRIER    222-INITIAL_BLURB_FOR_DESIGNER_CHAT_v1_4.txt
  CANONICAL  Deblock4_MPEG2_Deblocking_Investigation_and_Decided_Architecture_v1_05.md
             section 8, the rule with its calibration context
  DIFFERENT  Deblock4_Stage_2C_D2_HolyWu_Real_Schedule_v1_7.md
             W3C's independent verification of THAT DOCUMENT under D0 section 6 - not the GAIS rule. W3D had listed it as a carrier without opening it
```
---

# 3. WHAT THIS DOES NOT COVER

```text
The nine probes not tabulated above - LED-034, LED-037, LED-038, LED-039,
LED-042, LED-043, LED-046, LED-048 and LED-053c - returned results already
enumerated in W3C's cross-check response or in the re-sweep evidence, and
their classifications are ACCEPTED AS W3C STATED THEM:

  LED-038  three Scopes files, not two. The ReDecision Brief's q0 is the
           substring inside D4-Q01 - IDENTIFIER. The ReDecision Evaluation
           DEFINES e = first sample on the q side - CARRIER. The PreScope
           coder response uses p0/q0 without defining them - APPLIES.
  LED-042  SIX Scopes carriers, not five.
  LED-053c README (three places) and the Scopes ReDecision Evaluation are
           CARRIERS; Concise Summary, Verification_And_Tiering and the coder
           introduction are DIFFERENT - all three are the LUMA
           primary/midpoint machinery.
  LED-034, LED-037, LED-047  one file each. Uniqueness holds.
  LED-039  the four non-authority hits use "row pitch" in the SIMD-STRIDE
           sense - DIFFERENT. The woven-parity and footprint-pitch
           definitions remain unique.
  LED-043, LED-046, LED-048  no classification dispute; the defects there are
           atomicity, a cross-reference and nothing respectively.

W3D DOES NOT RE-ARGUE ANY OF THEM. Where W3C stated a classification, it is
adopted.
```

# 4. WHAT THE LEDGER REWRITE NOW CARRIES

```text
DISPOSITIONS CHANGING - six:
  LED-043  split c1 codec fact from c2 experiment rule
  LED-051  CURRENT-UNIQUE -> CURRENT-DUPLICATE (W3C's QC-5 answer)
  LED-053  (b) unique; (c) and (d) duplicate
  LED-055  withdraw "the derivation is unique"
  LED-058  reading rule unique; evidence-precision duplicate
  LED-061  the nuanced assessment unique; three propositions duplicate

FINDINGS CHANGING - four:
  LED-034  the T3 protection-gap proposition withdrawn entirely
  LED-051  thirteen rows -> 11 for one pitch-2 edge, 12 for the parity union
  LED-052a the retired parity-split description IS still live in a Scopes
           document - upgraded from possibility to fact
  LED-058  "latent rather than actual" -> ACTUAL

CARRIER LISTS REBUILT - seven, not four as previously stated:
  LED-033, LED-035, LED-036, LED-038, LED-042, LED-049, LED-055, LED-061

THE 24-OF-34 FIGURE IS WITHDRAWN. Six dispositions change, so 28 of 34
survive. It will be ENUMERATED in the rewrite, not asserted.
```

---

*End of classification repair. Nothing here is ratified. The ledger rewrite
follows this, not the other way round.*
