# Deblock4 - T1 Resume Brief

**Version:** 1.9
**Date:** 2026-08-19
**Author:** W3D (designer chat 5)
**Route:** W3D -> W3X -> successor W3D
**Nature:** RECOVERY ARTIFACT. It decides nothing. Section 0a is the task list
and PREVAILS over any state summary in the chat blurb or the designer
introduction.
**Encoding:** US-ASCII; CRLF.

---

# 0a. STATE ADVANCE (v1.9) - WHAT IS OWED RIGHT NOW

## Read this first if you are a successor

```text
T1S01a5 IS NOT CLOSED AND HAS NOT BEEN REWRITTEN. It is mid-correction, with
the correction fully worked out and on paper. The next act is mechanical, not
investigative.

WHERE IT STOPPED:
  W3C reviewed a W3X-selected Tier C sample of 11 of the 33 Tier C entries.
  RESULT: 3 AGREE, 8 DISAGREE.
  W3D verified all eight against the corpus. ALL EIGHT HOLD. None resisted.
  W3X then directed a RE-SWEEP OF ALL 34 ENTRIES rather than patching eight.
  THE RE-SWEEP IS DONE. It is in T1S01a5_A_ReSweep_Evidence.
  It has been recast for the reviewer as
  T1S01a5_A_ReSweep_CrossCheck_Request_for_W3C, and issued.
  W3C HAS RESPONDED: T1S01a5_B_ReSweep_CrossCheck_Response_v1_0.

WHAT THE CROSS-CHECK RETURNED:
  POPULATION        PASS. 46 files reproduced, ONCE W3X's post-snapshot move
                    of the two root GAIS files is applied. On the raw ZIP
                    bytes alone it is 48.
  RAW PROBE COUNTS  PASS - 22 of 22 REPRODUCED EXACTLY. The searches are no
                    longer in dispute.
  CLASSIFICATIONS   FAIL. Seven concrete defects. Same failure one level in:
                    W3D opened the hits this time and still misread several.
  LED-051 (QC-5)    W3C ANSWERED THE QUESTION W3D DECLINED. The Scopes
                    derivation record IS a carrier. LED-051 becomes
                    CURRENT-DUPLICATE.
  24-of-34 FIGURE   REJECTED. Does not follow from W3D's own stated changes.
                    Correct arithmetic is 28 of 34 after LED-051.

THE NEXT ACT, IN ORDER:
  1. A BOUNDED CLASSIFICATION REPAIR - NOT another search round. W3C is
     explicit: do not rerun the searches, the counts reproduce. For every
     probe already run, record the exact candidate FILE list and assign each
     file CARRIER / APPLIES / DIFFERENT / IDENTIFIER / NOISE, with a reason
     only where the call is not self-evident.
  2. THEN the ledger rewrite: six dispositions changed, carrier lists rebuilt,
     four findings corrected, entry count 34 -> 39 or 40.
  DO NOT REWRITE THE LEDGER BEFORE STEP 1.
```

## The state table

```text
T1S00     scope manifest ............... COMPLETE, frame frozen, 90 terms
T1S01a1   header, first pass ........... CLOSED by decision (DEC-54)
T1S01a2   currency statements .......... CLOSED, reissued v1.1
T1S01a3   section 0 .................... CLOSED provisionally (DEC-42)
T1S01a4   section 23 tail .............. CLOSED provisionally (DEC-52)
T1S01a5   BODY PART 1, sections 1-8,
          authority lines 223-715 ...... IN CORRECTION. Ledger at v1.5;
                                         re-sweep issued for cross-check;
                                         rewrite to v1.6 pending W3C
T1S01a5b  BODY PART 2, sections 9-13,
          lines 716-1098 ............... NOT STARTED. THE SPLIT IS DECLARED
                                         BUT NOT RATIFIED - see Q1
T1S01a6   sections 14-22 (1099-1676)
          PLUS section 24 and
          Appendices A-D (1717-1932) ... NOT STARTED
T1S01a7   Appendix E older entries, the
          six owed items, and the
          whole-document consistency
          pass ......................... NOT STARTED. DECLARED FINAL
T1S01b    Scopes/ and the architecture
          re-decision record ........... NOT STARTED
T1S02..05 README, charter, status,
          remaining corpus ............. NOT STARTED
```

## The seven classification defects, all verified by W3D against the corpus

```text
QC3-1  LED-033  THE COUNT OF TEN IS A COINCIDENCE. One false candidate enters
                and one real carrier escapes, and they cancel out.
                FALSE: Deblock4_Scope_Stage_1B3_Runtime_Capability_Guard. Its
                  hit is a Zig comment, "Single source of the version string
                  used by the 4.1 summary line". DIFFERENT.
                ESCAPED: the designer introduction DOES assert the authority
                  prevails, but writes "PREVAILING MPEG-2 AUTHORITY", which a
                  contiguous probe for "prevailing authority" cannot match.
QC3-2  LED-035  THE SCOPES EVALUATION IS A CARRIER, NOT APPLIES. It writes
                "not a Deblock4 acceptance basis" - it STATES the rule while
                using it. And the re-sweep text was internally inconsistent:
                it called the set "corrected to nine" while classifying the
                ninth file as APPLIES.
QC3-3  LED-036  PROJECT STATUS IS APPLIES, NOT A CARRIER. It uses the
                Schedule-SA/SB spelling while discussing the a4 ordering
                defect; it does not state the renaming rule.
QC3-4  LED-038  "15 HITS, ALL CLASSIFIED" WAS FALSE. Three Scopes files, not
                two - the categories accounted for fourteen of fifteen. The
                ReDecision Brief's q0 hit is the substring inside D4-Q01;
                the ReDecision Evaluation DEFINES e = first sample on the q
                side and is a CARRIER.
QC3-5  LED-042  SIX SCOPES CARRIERS, NOT FIVE.
QC3-6  LED-045  THE TWO SCOPES HITS ARE CARRIERS. Both say in terms "TFF/BFF
                does not affect block geometry".
QC3-7  LED-061  W3D FIXED D2 AND MISSED THE SAME DEFECT NEXT DOOR. The coder
                introduction's hit is "I7 independent verification of
                self-affecting criteria" - charter process, not the GAIS
                rule. DIFFERENT. Real carriers: designer introduction, both
                chat blurbs, the authority.

ALSO, INDEPENDENT OF CLASSIFICATION:
  LED-051  THE ENTRY'S OWN HEADING CONTRADICTS ITS OWN NEXT SENTENCE. The
           heading says the field-organised footprint spans THIRTEEN frame
           rows; the following sentence says eleven. Correct: one pitch-2
           six-sample edge spans e-6..e+4 = 11 rows; the union of the two
           parity edges spans e-6..e+5 = 12 rows. THERE IS NO 13-ROW SPAN.
           The radii 6-before / 4-after are unaffected.
```

## What T1S01a5 currently owes

```text
0. THE CLASSIFICATION REPAIR, before anything else. See above.

1. THE LEDGER REWRITE. SIX dispositions change:
     LED-051  CURRENT-UNIQUE -> CURRENT-DUPLICATE. Canonical home authority
              4.2/4.3; concrete non-canonical carrier
              Scopes/Deblock4_D4_Architecture_ReDecision_W3C_Evaluation_v1_0.
              W3D DECLINED TO CALL THIS AND W3C CALLED IT: a derivation
              record that physically contains the mathematics is a carrier;
              being a working record does not exempt it.
     LED-043  c1 codec fact stays with F5; c2 experiment rule -> section 15
     LED-053  (b) unique; (c) and (d) duplicate, section 4.5 canonical
     LED-055  withdraw "the derivation is unique"
     LED-058  reading rule unique; evidence-precision proposition duplicate
     LED-061  the nuanced GAIS assessment unique; three propositions duplicate
   Four findings change:
     LED-051  the thirteen-row claim -> 11 rows one edge, 12 the parity union
     LED-058  "latent rather than actual" -> ACTUAL (Grid Knowledge line 193)
     LED-034  the T3 protection-gap proposition is WITHDRAWN ENTIRELY
     LED-052a the retired parity-split description IS still live in a Scopes
              document - new finding, upgraded from possibility to fact
   Corrections of record:
     LED-046  cross-reference LED-049 -> LED-052a
     LED-061  remove D2 as a carrier, add the coder chat blurb
     LED-033, LED-035, LED-036, LED-049  carrier lists rebuilt
     LED-037  the REASON replaced by the search that actually proves uniqueness

2. THE 24-OF-34 FIGURE IS WITHDRAWN. W3C is right that it does not follow
   from W3D's own stated changes. Six dispositions change, so 28 of 34
   survive. RECOMPUTE AND ENUMERATE after the classification repair rather
   than asserting a number.

3. THE SIX ITEMS OWED TO T1S01a7, unchanged from v1.7.
```

## The population and method rules now in force

```text
SEARCH POPULATION - three mechanical path tests, no judgement:
    EXCLUDE  any folder whose name begins "superseded" or
             "scheduled_for_deletion"                              DEC-60
    EXCLUDE  anything under T1/ - a WORKSHOP, NOT A SHELF          DEC-63
    EXCLUDE  GAIS_investigations/ - EVIDENCE-ONLY                  DEC-66
    RESULT on the common base: 543 files -> 46 SEARCHED
             32 root | 8 Scopes/ | 6 reference/holywu_r9/

METHOD RULES, all three earned the hard way:
    1. OPEN EVERY HIT. A hit recorded but not classified is NOT SWEPT.
    2. NORMALISE WHITESPACE. The corpus wraps sentences; raw line matching
       returns SILENT ZEROES. Probing the authority for F6's own sentence
       returns zero hits IN THE AUTHORITY.
    3. SEARCH THE PROPOSITION, NOT THE SENTENCE - IN W3C's BOUNDED FORM.
       W3D's "plausible phrasings" was too discretionary to be a criterion.
       W3C's refinement, accepted: declare the proposition; declare a BOUNDED
       probe family covering its material concepts; normalise whitespace;
       OPEN EVERY CANDIDATE FILE and classify each occurrence, recording a
       MIXED classification where one file carries different meanings; if
       opening a genuine carrier exposes an equivalent phrasing the family
       missed, add it, RECORD WHY, and rerun the same population; claim no
       exhaustiveness beyond the declared population and probe family.
       LED-033 is the worked example of why the bound matters in both
       directions: a contiguous probe missed "PREVAILING MPEG-2 AUTHORITY"
       while admitting a Zig comment about a version string.

THREE POPULATION STRAYS, raised with W3X, not fixed:
    Scopes/Deblock4_T1_W3C_Review_Scope_v1_7.md - a T1 artifact outside T1/,
        and a live carrier for LED-033
    T1_Evidence_..._files.zip - a binary archive in the search population
    reference/holywu_r9/*.cpp - match identifier-shaped probes
```

## Open questions, and when each is due

```text
  Q1   ratify the a5/a5b split               -> before a5b is scoped
  Q5   LED-059's conditional disposition      -> before a6
  --   T1S00 bumped, or amended by decision?  -> before T1 closure
  Q3   coordinate keys: pointer, or
       pointer-with-restatement               -> at T3
  Q2   Schedule collision routing             -> at T1S02/S03
  Q6   generalise the GAIS rule to any
       research instrument                    -> after T1 closes
  Q9   retire superseded T1 generations       -> hygiene, anytime
  --   the three population strays above      -> anytime
ANSWERED: Q7 withdrawn. Q8 sample selected. Q10 -> task T8. Q11 -> DEC-64.
Q12 -> DEC-66. Q13/Q15 -> the method rules above. Q14 -> re-sweep all 34.
```

---

# 0b. THE THING A SUCCESSOR MOST NEEDS TO KNOW

```text
THE TECHNICAL FINDINGS IN a5 HAVE LARGELY SURVIVED. The disposition results
were substantially right from ledger v1.0 and 24 of 34 still stand untouched.

EIGHT LEDGER VERSIONS AND TWO FULL REVIEW ROUNDS WENT ALMOST ENTIRELY ON
DESIGNER METHOD, NOT ON CONTENT: tier labels used as importance markers, a
search population defined two different ways, counts of the wrong object,
stale cross-references, a cited basis never opened, and five searches whose
hits were returned and not read.

W3C FOUND EVERY ONE. Not one was caught by its author. The cross-check then
found SEVEN MORE, one level deeper: W3D opened the hits as the new rule
requires and still misread several of them. THE PATTERN IS NOT "DID NOT
LOOK". IT IS "LOOKED AND SAW WHAT WAS EXPECTED".

DO NOT READ THAT AS A REASON TO TRUST THE PROCESS AND RELAX. Read it as the
measured cost of this method: on this sub-tranche, correcting the designer
cost several times more than adjudicating the document. That is a fact W3X is
entitled to weigh when deciding whether to continue.
```

---

# 1. PROJECT POSITION - UNCHANGED BY ANY OF THIS

```text
CLASSIC IS COMPLETE for the ratified integer tiers: scalar 2C, SSE4.1 4C,
AVX2 5C, plus M1/M2 maintenance. Identity 0.1.0-dev+5C. It builds, it runs,
it passes its differential gate.

deblock4.Deblock4 HAS NO FILTERING KERNEL. All three dispatch arms are
pass-through writable copies. Verified cold in the supplied source.

ARCHITECTURE: B2 primary candidate; D the mandatory detector-free comparator
and fallback; A and C rejected. Q14 decides: B2 if viable, else D if viable,
else reopen. Nothing ships at Q14.

NO KERNEL SCOPE MAY BE DRAFTED before Q14 reports and W3X ratifies.

SEQUENCE: T1 -> T5 -> T6/Q14, with T8 (provenance gaps) before T5.

THE TARGET-DEVICE FACT: the LG recorder was measured with
frame_pred_frame_dct=0 in XP/SP/LP/EP. That makes the adaptive-capable
per-macroblock regime NORMAL TARGET OPERATION. It does NOT prove any picture
actually mixes FRAME and FIELD macroblocks. Q14 must obtain per-macroblock
truth.
```

---

*End of resume brief. Nothing here is ratified.*
