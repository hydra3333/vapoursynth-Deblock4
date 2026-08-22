# Deblock4 - T1 Resume Brief

**Version:** 1.17
**Date:** 2026-08-22
**Author:** W3D (successor session)
**Route:** W3D -> W3X -> successor W3D / W3C
**Nature:** RECOVERY ARTIFACT. It decides nothing. Section 0-CURRENT is the
live task-state handoff and PREVAILS over older state summaries in chat
blurbs, introductions and informative status documents where those have not
yet been refreshed; section 0a beneath it remains the a5-closure record.
**Basis:** W3C's `T1S01a5_B_Recovery_Closure_Response_v1_0.md` (review of
ledger v1.6); W3C's `T1S01a5_B_W3C_Knowledge_Capture_Response_v1_0.md` (the
seven-part debrief taken before that session became unavailable); delivered
ledger v1.6; Classification Repair v1.1; W3C's Tier C sample review
`T1S01a5_B_Coder_Response_v1_1.md`; Standing Task Register v1.31.
**Encoding:** US-ASCII; CRLF.

---

# 0-CURRENT. STATE ADVANCE (v1.17) - BATCH 1 THROUGH TWO REVIEW CYCLES;
#             THE EXTERNAL BASIS REVALIDATION GATE IS REGISTERED

## Where a5b batch 1 stands (2026-08-22)

Batch 1 (authority sections 9-10, lines 716-876) has completed TWO full
designer->coder review cycles and is out for a THIRD, bounded correction
review:

```text
Ledger of record   T1S01a5b_A_Ledger_Body_Part2_v1_3.md - 29 entries
Population         T1S01a5b_A_Population_Delta_v1_1.md - 38 files
Cycle 1            T1S01a5b_B: 13 AGREE / 11 DISAGREE (F1-F9); all
                   accepted; implemented at ledger v1.2
Cycle 2            T1S01a5b_B v2: 11 AGREE / 5 DISAGREE (F10-F14) +
                   F15 metadata; all accepted; implemented at v1.3
Open now           correction review 2: six bounded items (LED-066 +
                   new 066b, 070b, 074b, 079's REPAIR block, 081a's
                   PROPAGATION, F15 metadata); 23 entries carry
                   recorded AGREE verdicts and are NOT reopened
Dispositions       24 CURRENT-DUPLICATE, 4 CURRENT-UNIQUE (066a, 066b,
                   073a, 074), 1 SUPERSEDED/ERRONEOUS (081a);
                   28 Tier C, 1 Tier A
Response naming    T1S01a5b_B_Coder_Response_v3.zip
```

LED-081a is DEC-84's first real ERRONEOUS case: authority line 873 says
"Section 15 requires a revisit"; the requirement lives in section 16.
Mandatory propagation was executed - four actual dependencies found and
routed. The one-word authority fix (873: "Section 15" -> "Section 16") is
STAGED, ratifiable by W3X only after correction review 2 passes.

## The pending-commit queue (W3X commits tree artifacts; order matters)

```text
1. Correction review 2 returns and is adjudicated;
2. Map v1.1: Part-B amendment (738-745 -> 066/066a/066b; 762-785 ->
   070/070a/070b; 796-803 -> 073/073a; 806-817 -> 074/074a/074b) and
   Part-D routing fix (LED-081 -> section 16);
3. Orientation bump round: coder blurb (49) and designer blurb (40)
   section-15 -> section-16 fixes, PLUS the deferred Q8/Q9 intro fixes
   (designer intro "highest delivered generation" line; both intro
   title-line versions);
4. Authority v1.06: the one-word 873 fix, after ratification;
5. Standing Task Register bump: the EBR gate entry (below) and the
   register-version refresh in whatever orientation files cite it.
```

## Coder-session transport rules (learned 2026-08-22, two dead sessions)

Review rounds ship SLIM (register and resume brief withheld as routing
context; the covering note declares the withholding and instructs findings
over assumptions). One round per coder chat; never re-upload the corpus
mid-session; at the first "message stream" error, checkpoint and STOP -
retrying a failing stream re-sends the same context and makes it worse.
Fallback held in reserve on W3X ruling: split a round into two sessions
(LED-081a-class material first).

## THE EXTERNAL BASIS REVALIDATION (EBR) GATE - REGISTERED HERE, W3X-RULED

Proposed by W3X 2026-08-22; recorded here so no successor can lose it; the
Standing Task Register entry is drafted and lands at the register's next
bump (pending-commit item 5).

```text
WHAT     A terminal cross-check that the EXTERNAL evidence B2 stands on
         has not been invalidated or superseded since it was verified:
         - H.262 subclause 6.1.3 (4:2:0 chroma DCT blocks frame-
           organised) - the chroma-defect resolution;
         - H.264 clause 8.7 MBAFF concepts - the mixed-rule provenance;
         - RFC 6386 section 15 VP8 material cited in the README;
         - the section-8 external research-assessment retentions.
WHY      The sweep proves the corpus is internally consistent; it cannot
         prove the foundations. If a foundation stone fails, the sweep's
         dependency map ([SPEC-VERIFIED] tags, C-O-R records, D4
         registers, DEC-84 propagation) must trace what stood on it -
         a failure that routes cleanly is the process WORKING.
HOW      Enumerate every external-basis claim; re-verify each against
         the live primary source at execution time; classify VALID /
         INVALIDATED / SUPERSEDED / UNVERIFIABLE; DEC-84 propagation
         for anything not VALID. W3X may need to supply ITU spec PDFs
         as in the PreScope round; RFC 6386 is freely fetchable.
WHEN     After T1 completes IN FULL (remaining a5b batches, a6, T1S02)
         and BEFORE T3 edits are ratified and before Q14/kernel scope
         opens. It is the last gate before anything irreversible stands
         on the foundation. NOT executed early.
```

---

# 0a. STATE ADVANCE (v1.14) - T1S01a5 IS CLOSED

## Read this first if you are a successor

```text
T1S01a5 CLOSED ON 2026-08-21 under DEC-85 and DEC-88. Final ledger v1.10: 44
entries, ALL TIER C - 16 CURRENT-UNIQUE, 28 CURRENT-DUPLICATE, zero
CONFLICTING, zero SUPERSEDED, zero OPERATIVE-SPEC - every figure independently
reproduced by W3C.

IT CLOSED WITH KNOWN RESIDUE, DELIBERATELY. W3C's final verification found
v1.10 is not literally residue-free and recommended closing anyway. The residue
is ENUMERATED AND ROUTED at Standing Task Register section 0c as R1-R8.

DO NOT OPEN AN a5 CORRECTION GENERATION FOR ANY OF IT. There is no v1.11 and
there will not be one. DEC-85 caps the rounds; DEC-88 records the closure. If
you find yourself reasoning toward "just one more a5 fix", STOP - that is the
failure mode both decisions exist to prevent, and W3X ratified the cap after
judging that chasing residue had itself become the project risk.

WHAT CLOSURE DOES NOT MEAN: nothing in a5 is ratified into any authority
document. Every PROPOSED ACTION in the ledger is still a proposal awaiting T3.

THE WORK OWED, IN ORDER:
1. DONE 2026-08-21 - THE BOUNDED ROOT-CONTINUITY REFRESH, plus same-day
   fitness-check corrections to all four orientation files. Advanced in one
   pass: Project Status, Forward Roadmap, Documentation Currency Audit,
   Concise Project Summary, and both intro + blurb pairs - ALL AT THEIR
   HIGHEST COMMITTED GENERATIONS, deliberately not version-pinned here:
   this line pinned them once and the pins staled the same afternoon, which
   is the R7 defect class inside the sentence that reported fixing R7.
   Residue R7 corrected. Awaiting only W3X's commit.
2. DONE 2026-08-21 - a5b's PRE-ADJUDICATION OBLIGATIONS. The population
   derivation and source-coverage map are DELIVERED as
   T1/T1S01a5b_A_Population_and_Coverage_Map_v1_0.md: 40 declared files,
   full walk of 716-1098, 34 reserved entries LED-064..LED-097, seven
   split-candidate flags, two pre-identified CITED-OUTSIDE-RANGE
   obligations, four recorded no-proposition segments. CONDITIONAL on W3X
   confirming the committed tree matches its section A.3 (open question Q36).
   DO NOT REDO THE MAP; a successor's first act is the tree verification,
   with population-only re-derivation if the commit differed.
3. T1S01a5b ADJUDICATION - in map order, LED-064 onward, under Review Scope
   v1.15. W3D's standing recommendation, for W3X to ratify or amend at batch
   time: BOUNDED BATCHES, first batch sections 9-10 (LED-064..081), so
   review rounds stay cheap and a session death loses little. See 0f; it is
   HARDER than a5.
4. W3X's PROJECT-VIABILITY DECISION POINT, which W3X placed explicitly AFTER
   seeing how a5b goes. a5b is the test of whether the consolidated scope and
   the mechanical gates have actually made this cheaper. Do not pre-empt it.

STILL SETTLED, STILL NOT REOPENABLE: the Tier C sample (DEC-73), the 22-probe
round, Classification Repair v1.1, the a5/a5b split (DEC-68), DEC-67
methodology, Review Scope v1.15's substantive method, the B2/D architecture,
and everything in W3C's explicit do-not-carry list at register 0c.
```

## What a5 cost, and what it proved - read before starting a5b

```text
SEVEN W3C REVIEW ROUNDS. NOT ONE MPEG-2 CONCLUSION OVERTURNED. Every round's
cost was method, framing, provenance and recovery - the same pattern DEC-52
recorded for a4. If you are tempted to read the round count as evidence the
technical work is shaky, THAT IS THE WRONG INFERENCE and the record says so.

THE FIVE FAILURES THAT RECURRED, EACH NOW WITH A COUNTERMEASURE:
1. ATOMIC-CLAIM VIOLATIONS - four times (LED-053, LED-055, LED-055a, LED-047),
   twice AFTER the rule was in the binding scope. If an entry's own CLAIM
   field says "two propositions", IT IS TWO ENTRIES. Never argue uniqueness
   from a conjunction: "no document states BOTH" proves nothing about either.
2. LEXICAL PROBES WHERE SEMANTIC IS REQUIRED - DEC-67 Rule 3. Grammatical
   permutations of the source sentence ARE NOT A PROBE FAMILY. Build the
   family from the proposition's CONCEPTS first, then add the source wording.
   W3C found real carriers in the same 46 files that W3D's lexical probes
   cleared - twice.
3. PARTIAL REPLACEMENT / ENTRY-SWEEP RESIDUE - the most persistent of all.
   Correcting the field the mandate names and leaving the rest of the entry
   contradicting it. At its worst a REMOVAL NOTE went in and the REMOVAL did
   not. Run the entry-sweep gate MECHANICALLY (scope 0.7, DEC-76/81).
4. COUNTS ASSERTED RATHER THAN DERIVED - wrong at v1.5 (40/39), v1.8 (45),
   v1.9 (0.4d 26-vs-28, Q-C 19-vs-20, Q-H nine-vs-eleven). DERIVE EVERY
   COUNT BY ENUMERATION FROM THE FINISHED FILE, EVERY TIME.
5. COVERAGE VS OVERLAP - an overlap check against prior entries is NOT a
   coverage check against the source (DEC-77, scope 0.10). a5b owes a SOURCE-
   COVERAGE MAP BEFORE adjudication, not after.

AND TWO ABOUT THE MACHINERY ITSELF (DEC-87), because both cost a round:
   (a) A FIX THAT IS NOT PERSISTED IS NOT A FIX. Run gates on the artifact
       RE-READ FROM DISK, never on in-memory text claiming to hold the repair.
   (b) A FIRING GATE IS AS LIKELY TO BE WRONG AS THE DOCUMENT. Twice at v1.10
       a gate fired falsely and the document was right. ESTABLISH WHICH SIDE
       IS WRONG BEFORE EDITING ANYTHING.
```

# 0b. THE POPULATIONS NOW IN FORCE

```text
THREE POPULATIONS EXIST. DO NOT RECONCILE THEM BY REWRITING HISTORY.
    47   frozen T1S00 survey record - what was surveyed on 2026-08-18
    41   current T1 adjudication population, after DEC-66
    46   settled a5 SEARCH snapshot - what a5's SWEPT fields ran over

THE THREE MECHANICAL EXCLUSIONS:
    superseded* / scheduled_for_deletion* folders                     DEC-60
    everything under T1/                                             DEC-63
    everything under GAIS_investigations/                             DEC-66

a5b DID NOT INHERIT THE 46-FILE SNAPSHOT - the derivation is done (map
section A). The rule remains for any re-derivation: derive a5b's own
current population. The snapshot is a5's evidence of record and later version
bumps do not retroactively rewrite it, but a search run today would not return
the same 46 files.

DEC-63 CARRIES A STANDING OBLIGATION THAT BITES ON THIS DOCUMENT: T1/ is
excluded from every search, and this brief lives there. Anything durable
written here is invisible to every future sweep unless it is PROMOTED OUT into
a real authority document. This brief is process material and its location is
correct. If you write a substantive finding into it, promote it.
```

---

# 0c. THE TRAPS - EVERY ONE OF THESE HAS ALREADY HAPPENED

```text
THIS SECTION IS THE MOST VALUABLE PART OF THIS BRIEF. Each item below is a real
failure committed in a5 by W3D, W3C or both, and caught by the other party.
None was caught by its own author.

1. THE ENTRY-SWEEP GATE - THE ONE THAT KEEPS RECURRING.
   AFTER EDITING ANY FIELD OF AN ENTRY, RE-READ THE WHOLE ENTRY AND CHECK THAT
   NO OTHER FIELD CONTRADICTS THE EDIT.
   In ledger v1.6 the successor W3D corrected exactly the field each mandate
   named and left the rest of the entry stale, three times:
       LED-055  withdrew the uniqueness claim in REASON; left "the DERIVATION
                -> this section, uniquely" standing in PREVAILS, three lines
                above it.
       LED-061  rebuilt SWEPT to classify the coder introduction and D2 as
                DIFFERENT; left REASON and DUPLICATE-ACTION in the same entry
                still listing both as carriers. THE ENTRY CONTRADICTED ITSELF.
       LED-043  rebuilt the fabrication-prohibition half of SWEPT; left the
                dct_type half naming "the GAIS files" as live corpus, a
                population DEC-66 excludes.
   This is DEC-51 at entry level. It is mechanically checkable: after each
   edit, diff the entry's remaining fields for the terms the edit removed.

2. A COUNT THAT COMES OUT RIGHT CAN HAVE THE WRONG MEMBERS.
   In a5 a false candidate entered while a real carrier escaped the probe, and
   the two cancelled to give the correct total. COMPARE THE LISTS, NOT THE
   TOTALS.

3. OPENING A HIT IS NOT READING IT.
   Every hit was opened as rule 1 requires and seven files were still
   misclassified: a Zig comment about a version string counted as the MPEG-2
   single-source rule; charter I7 counted as the GAIS rule; the substring
   inside the identifier D4-Q01 counted as the edge-position convention.

4. A FILE-LEVEL HIT DOES NOT PROVE OCCURRENCE-LEVEL UNIQUENESS INSIDE THAT
   FILE. The harness returns one file even when the proposition occurs twice
   in it, in sections owned by different sub-tranches. See 0e.

5. ENUMERATE THE ROUNDS, NOT JUST THE DELTAS.
   Ledger v1.5 built its delta list from the classification-repair round alone
   and missed two of W3C's eight Tier C findings, because the Tier C round
   preceded it. The deltas were enumerated meticulously; THE ROUNDS THEY CAME
   FROM WERE NEVER ENUMERATED AT ALL. Worse, v1.5's own provenance section
   NAMED the Tier C review among artifacts used when it had not been opened -
   DEC-48's false assurance, written into the section asserting the provenance
   rule.

6. A CORRECTION CAN SURVIVE ITS OWN FIX. Ledger v1.5's entry count was
   asserted as 40, corrected to 39 by counting - and the stale figure survived
   in the document header two hundred lines away.

7. DO NOT INFER AN UNDELIVERED GENERATION FROM STATUS PROSE. DEC-60, DEC-63
   and W3D's own final post all refer to "39" entries or SWEPT fields in
   ledger generations that were never delivered. No delivered ledger ever had
   39 of anything until v1.6 arrived there by a different route. ENTRY COUNT
   IS NEVER A TARGET.
```

---

# 0d. THE LEDGER v1.7 CORRECTIONS OWED

```text
FULL SPECIFICATION IS W3C's REVIEW SECTION 17. This is the summary.

A. COVERAGE AND RANGES
   - authority line 225 project-scope/target proposition has no entry;
   - authority line 269 "Unless explicitly stated otherwise:" scopes the
     coordinate-convention block and has no entry;
   - LED-060 range is 646-673 and must be 646-674, because its own CLAIM
     includes P4's qualification at line 674;
   - minor stale line pointers: LED-038 refers to line 269 although `e` is at
     272; reconcile LED-040 similarly.

B. THE THREE PARTIAL TIER C REPLACEMENTS - see trap 1 above
   - LED-043: remove the stale GAIS/T1 applicable-population wording; keep the
     Scopes no-fabrication carrier attached to (c2); use the section-3 regime
     table as the named non-canonical copy for (a)/(b);
   - LED-055: remove the false "uniquely" from PREVAILS, and COMPLETE THE
     ATOMIC DECOMPOSITION W3C's original finding required. Three layers:
         duplicated row-projection mechanism (README A.9.3 carries it);
         POSSIBLY UNIQUE derivation qualifiers - progressive/frame-DCT
             generality, and "correctness requirement, not performance
             preference";
         duplicated D4-D01 conclusion.
     Use already-settled candidate material. NO new corpus-search round.
     THE ENTRY COUNT WILL PROBABLY MOVE. Let it.
   - LED-061: remove the coder introduction and D2 from REASON and
     DUPLICATE-ACTION; retain the designer introduction and both chat blurbs;
     keep LED-061a's split assessment.

C. LED-047 TESTED CLAIM
   The entry reports a literal search for "H.262-VERIFIED" returning seven
   lines. It returns EIGHT: line 291 is "[DERIVED FROM H.262-VERIFIED FACTS]".
   Either redefine the population as standalone tags and keep seven, or report
   eight and classify line 291 separately.

D. LED-059
   The entry proposes authority section 15 as canonical home for the
   file-level corpus composition (LG MLS, XP/SP/LP/EP, home_576i, home_576p).
   W3C READ SECTION 15: IT DOES NOT STATE THAT. Remove the duplication claim
   and the section-15 canonical-home pointer; retain section 6.3 as the
   present home unless another is established. THIS IS A REAL ADJUDICATION
   ERROR, not a framing one.

E. LED-063 - TIER A, THE ONLY ONE
   The exact filename in section 24's R8 is genuinely absent, but v1.6
   overstates it as the report possibly not existing. A strong likely referent
   survives under a different filename: the W3C-D4-VERIFY-1 coder-response
   report, "Deblock4 - D4 Pre-Scope - W3C Verification and Independent Design
   Review". Distinguish a WRONG FILENAME from MISSING CONTENT. Remove stale
   GAIS/T1S01b population language. Full Tier-A re-review is owed on this
   entry.

F. RECOVERY SELF-CHECK
   - section 0.1 split status -> RATIFIED at DEC-68;
   - 0.4c completeness claim;
   - 0.4e stale count, after the proposition count settles;
   - 0.4f LED-037 restoration wording, which currently contradicts LED-037's
     own correction;
   - Q-K2's "all eight applied" - only assert it when it is true;
   - covering note diff target and work-queue pointer.

G. CURRENT STATUS RECORDS - items 3 and 5 of the work list at 0a.

EXPLICITLY NOT REQUIRED: no Tier C resampling; no 22-probe rerun; no DEC-67
reopening; no architecture reopening; no source, build, test or git work.
```

---

# 0e. TWO METHOD REFINEMENTS W3C SUPPLIED - ADOPT BEFORE a6

```text
1. OCCURRENCE-LEVEL EVIDENCE, WITHOUT REDEFINING MIXED.
   MIXED MEANS ONE FILE CARRIES MORE THAN ONE MEANING. LED-049 is the clean
   example: Grid Knowledge carries the MediaInfo triage route AND a separate
   evidence-discipline statement.
   LED-053d STRETCHED IT: section 4.5 and Appendix A state the SAME
   proposition at two locations in one physical file. W3C accepted that
   pragmatically to avoid losing the second occurrence and did NOT intend a
   redefinition. DO NOT USE MIXED MERELY BECAUSE A PROPOSITION OCCURS TWICE.
   The fix is occurrence-level evidence where it matters:
       FILE:         <path>
       FILE-CLASS:   CARRIER / APPLIES / DIFFERENT / IDENTIFIER / NOISE / MIXED
       OCCURRENCES:
           <section/range>  CANONICAL occurrence of proposition P
           <section/range>  CARRIER occurrence of proposition P
   THIS MATTERS MOST AT a6, which holds Appendix A, section 24 and the D4
   registers - all of which restate body propositions.

2. CITED-OUTSIDE-RANGE, for evidence in another sub-tranche's territory.
   Q-K asked whether citing Appendix A without adjudicating it is right. W3C
   AGREED IT IS: the carrier may affect the current disposition, and the
   out-of-range occurrence remains for its owning sub-tranche. Adjudicating it
   would violate the tranche boundary. Carry it explicitly:
       CITED-OUTSIDE-RANGE:
           location
           proposition
           evidence use in the current tranche
           owning later tranche
           the later tranche must reconcile the occurrence with this use
   a7's whole-document consistency pass is where these finally reconcile.
```

---

# 0f. WHAT a5b SHOULD EXPECT - FROM W3C, WHO HAS READ SECTIONS 9-13

```text
THIS IS FREE INTELLIGENCE. It was captured from the W3C session before it
became unavailable and exists in no other artifact. It is ADVANCE WARNING, NOT
PRE-DISPOSITION - a5b adjudicates the text, not this list.

a5b IS HARDER THAN a5. Sections 1-8 are evidence; 9-13 transform facts into
architecture, topology, rejection arguments and scheduler/kernel obligations.

HIGH-RISK PATTERNS:
    1. a current principle embedded inside REJECTED architecture;
    2. derived architecture accidentally described as codec fact;
    3. decision reasoning substantially duplicated in Scopes/;
    4. rejected Architecture A described extensively elsewhere, with some
       generic principles potentially SURVIVING its rejection;
    5. PR-1/PR-2 home and pointer remedies needing faithful home adjudication
       WITHOUT reopening settled decisions;
    6. same-file duplication across section 0, body, registers and appendices.

SPECIFIC WARNINGS:
    B2-primary / D-mandatory-comparator is repeated widely;
    section-10 B2 topology mathematics has Scopes ancestry - do not presume
        uniqueness;
    Architecture D's high-level role and its detailed topology may have
        DIFFERENT canonical homes;
    the Architecture A rejection proof will likely need the most Tier-A atomic
        splitting in the whole sub-tranche;
    scheduler/kernel separation is likely duplicated but is an APPLICATION of
        the four-layer taxonomy, not a copy of it;
    old Schedule A/B vocabulary must not be confused with assertion of the
        renaming rule.

EXPECT MORE TIER A THAN a5, because the architecture half deliberately
contains rejected and superseded material. Expect few or no Tier B: Deblock4
still has no filtering kernel, and scaffolding does not make an architecture
statement an OPERATIVE-SPEC.

METHOD FOR a5b:
    population: DERIVED, 40 files (map A.3) - re-derive only if the
    committed tree differs from the map; never inherit a5's 46;
    bounded proposition probes FROM THE BEGINNING;
    exact coverage map BEFORE adjudication, not after;
    open and understand every candidate;
    record intra-file occurrence locations when material;
    atomicise rejected and surviving clauses;
    apply DEC-51 after every correction;
    W3D NEVER chooses the Tier C sample;
    no target entry count;
    carry out-of-range evidence to the owning tranche;
    preserve prior reasoning losslessly unless evidence mandates a change.
```

---

# 0g. DEC-64 CAN NOW BIND - W3C-VERIFIED PROPAGATION WORDING

```text
DEC-64 was ratified SUBJECT TO W3C wording verification and has not been
binding. W3C has now supplied verified wording. W3D must put the exact binding
text through W3X. IT MUST BIND BEFORE T3 REACHES THE REJECTED ARCHITECTURE-A
MATERIAL, which is the first real ERRONEOUS case and where getting it wrong
costs most.

    SUPERSEDED-KIND    OVERTAKEN | ERRONEOUS

    OVERTAKEN   valid in its former context/state and replaced by a later
                statement. PROPAGATION normally N/A unless evidence suggests
                dependent work may not remain valid.

    ERRONEOUS   false, materially misleading, or otherwise invalid in the
                context in which project work may have relied on it.

    PROPAGATION - REQUIRED FOR ERRONEOUS
        1. DECLARE THE PROPAGATION SCOPE/POPULATION: the bounded set of
           current documents, decisions, code, mathematics, tests or other
           objects in which reliance could materially survive.
        2. SEARCH FOR RELIANCE ON THE PROPOSITION, NOT MERELY ITS WORDING.
        3. ENUMERATE AND CLASSIFY CANDIDATE DEPENDENCIES, identifying actual
           reliance and non-reliance with attackable location/basis.
        4. ROUTE EACH ACTUAL DEPENDENCY: valid for an independent reason;
           needs correction/re-verification; or is itself superseded/erroneous.
        5. If none are found, record "none found" with scope and method.
        6. Claim no exhaustiveness beyond the declared scope/method.

    PROPAGATION IS ABOUT POTENTIALLY AFFECTED CURRENT WORK. It is NOT an
    archaeological search for every historical mention.
```

---

# 0h. THE PROVENANCE RULE AND WHAT IT COSTS

```text
RECORDED BECAUSE A SUCCESSOR WILL MEET THE SAME TENSION AND SHOULD KNOW THE
ANSWER WAS ALREADY WEIGHED.

THE RULE (DEC-70): every change to the ledger traces to a delivered artifact
or a ratified decision. Anything the designer adds on its own judgement is
labelled a NEW W3D FINDING with its evidence, never presented as a mandate.

WHAT IT COST, EXACTLY ONCE, AND IT IS WORTH KNOWING: ledger v1.4 contained
LED-055a, in which W3C had DELIBERATELY isolated the possibly-unique
SeparateFields qualifiers from the duplicated mechanism and conclusion. The
rebuild deleted it as unmandated. W3C's later debrief calls it "the most
important original v1.4 analysis that the later rebuild did not preserve
correctly."

THE RULE WAS NOT CHANGED, AND SHOULD NOT BE. Two reasons:
    the finding CAME BACK anyway through the ordinary review - the closure
        review reached the same conclusion independently, so the cost was one
        round, not a lost finding;
    the alternative - a designer adopting unmandated material from a
        ruled-out document on judgement - is how the original mess happened.
W3C's own position: it would defend the NEED for atomic LED-055 qualifier
treatment, not the identifier or wording. That need is now in the v1.7 work
list at 0d(B) on its own evidence.
```

---

# 0i. WHAT W3C's FINAL SESSION LEFT, AND WHAT IT DID NOT

```text
THE W3C SESSION THAT WORKED ALL OF a5 IS EFFECTIVELY UNAVAILABLE - response
times of tens of minutes, and it will need re-orientation. TREAT THE NEXT W3C
AS A FRESH MEMORYLESS SESSION (charter I2). It gets the bootstrap header, the
charter, the specification, one scope and the files it touches. IT WILL NOT
REMEMBER a5.

DELIVERED AND SAFE - four documents carrying everything W3C concluded:
    T1S01a5_B_Coder_Response_v1_1.md              the Tier C sample review
    T1S01a5_B_ReSweep_CrossCheck_Response_v1_0.md the cross-check
    T1S01a5_B_Classification_Repair_Response_v1_0 the repair review
    T1S01a5_B_Recovery_Closure_Response_v1_0.md   the v1.6 review - THIS IS
                                                  THE SPEC FOR v1.7
    T1S01a5_B_W3C_Knowledge_Capture_Response_v1_0 the seven-part debrief

THE DEBRIEF IS EVIDENCE, NOT KNOWLEDGE. Its durable content has been promoted
into this brief at 0c, 0e, 0f, 0g and 0h, and belongs in Review Scope v1.12
and the register. Left only in T1/ it would be invisible to every sweep.

W3C REPORTED NO WITHHELD TECHNICAL OBJECTION: no undisclosed conclusion that
B2 or D is non-viable, and no hidden objection to F8, the row mathematics or
the 4:2:0 asymmetry. Where provenance was weak - F8 especially - it said so
openly. ITS CLOSING ASSESSMENT: the present difficulty is continuity and
adjudication reliability, NOT evidence that the Deblock4 algorithm cannot be
built.
```

---

# 1. PROJECT POSITION - UNCHANGED BY THE a5 PROCESS CORRECTIONS

```text
CLASSIC:
    complete for the ratified integer tiers:
        2C scalar oracle
        4C SSE4.1
        5C AVX2
        post-5C M1/M2 maintenance
    retained identity: 0.1.0-dev+5C unless W3X supplies a later base.

deblock4.Deblock4:
    NO FILTERING KERNEL.
    Live dispatch remains pass-through writable-copy infrastructure.

MPEG-2 ARCHITECTURE:
    B2 primary candidate;
    D mandatory detector-free comparator/fallback;
    A and C rejected;
    Q14 rule:
        B2 if viable;
        otherwise D if viable;
        otherwise reopen architecture.
    Nothing ships at Q14.

NO KERNEL SCOPE:
    no Deblock4 kernel scope may be drafted before Q14 reports and W3X
    ratifies the architecture allowed to enter kernel/oracle development.

CURRENT WORK:
    T1 documentation consolidation remains active.

DOWNSTREAM:
    T8 must close named provenance gaps before T5.
    T5 detector mathematics then precedes separately-ratified T6/Q14 planning.

TARGET-MATERIAL FACT:
    LG XP/SP/LP/EP measured frame_pred_frame_dct=0.
    This establishes adaptive-capable per-macroblock DCT operation as normal
    target-device operation.
    It does NOT establish that any particular picture actually contains both
    FRAME and FIELD dct_type macroblocks; Q14 must obtain per-macroblock truth.
```

---

# 2. SUCCESSOR DISCIPLINE

```text
1. Do not treat T1/ as project knowledge merely because it contains a statement.
2. Do not use GAIS_investigations/ to prove, refute or adjudicate a current
   proposition.
3. Do not restart the settled a5 search round.
4. Do not trust a hit count as a carrier count.
5. Do not trust an "opened" file as a correctly read file.
6. Do not infer an undelivered ledger generation from status prose.
7. Every W3D remedy remains a proposal until W3X ratifies the resulting change
   to the applicable project knowledge set.
8. Preserve W3C's independent-review role; do not use it as confirmation.
9. Keep the immediate work bounded. a5 needs the bounded corrections at 0d,
   NOT a new process framework. W3C's closing advice: do not let a5 recovery
   become the project.
10. After editing any field of an entry, RE-READ THE WHOLE ENTRY. A correction
    reported complete from the edited location is the failure that has recurred
    most. See 0c trap 1.
11. Enumerate the ROUNDS an instruction came from, not only the deltas. Two
    rounds fed a5 and building from one missed two findings. See 0c trap 5.
12. Never claim a document was used unless it was opened.
```

---

# 3. HOW THIS BRIEF CAME TO BE

v1.11 existed because the W3D designer session reached its context limit after
delivering Classification Repair v1.1 but before delivering the promised ledger
rewrite. W3C wrote it as a recovery reconstruction.

v1.12 is written by the successor W3D session after that recovery completed, and
its purpose is different: it is a HANDOVER ARTIFACT WRITTEN WHILE THE DESIGNER
IS STILL AVAILABLE, rather than a reconstruction attempted after one is gone.
Both a designer and a coder session have now been lost mid-task on this
sub-tranche. This brief assumes a third loss is likely and is written to make it
survivable.

IT SEPARATES, DELIBERATELY:

```text
DELIVERED ARTIFACTS
    from
CAPTURED REASONING, which is evidence and not knowledge
    from
OLDER CONTINUITY SUMMARIES, several of which are still a generation behind.
```

WHAT IT DOES NOT DO. It decides nothing. It promotes nothing inside `T1/` into
applicable project knowledge - the durable content at 0c to 0h must reach Review
Scope v1.12 and the register to count. It manufactures no ledger generation that
was not physically delivered. And it does not restate the technical adjudication
of sections 1-8, which is in the ledger and has survived every review round
without a single MPEG-2 conclusion being overturned.

A NOTE ON WHERE THE COST HAS ACTUALLY GONE, because a successor should not
misread five rounds as technical difficulty. DEC-52 recorded it for a4: "The
TECHNICAL result was substantially right at v1.0 and survived every round.
Rounds two, three and four were spent on W3D's own method and framing defects."
a5 repeated it. The classification content held throughout; the rounds went on
method, framing, provenance and recovery. Review Scope v1.12 and the entry-sweep
gate exist to make a5b cost less, and a5b is the test of whether they work.

---

*Revision history*

```text
v1.17 (2026-08-22) Adds section 0-CURRENT (which now PREVAILS as the live
      state handoff): a5b batch 1 through two review cycles with ledger
      v1.3 out for bounded correction review 2; the pending-commit queue;
      the coder-session transport rules; and the W3X-ruled External Basis
      Revalidation gate, registered durably in the project record for the
      first time (previously it existed only in the designer chat's own
      memory - a gap W3X caught). Header prevail note updated. No other
      section changed.
v1.16 (2026-08-21) De-pins the orientation-file versions in work-order step
      1: v1.15 pinned them and three staled within hours when the fitness
      checks advanced the intros and coder blurb. Orientation files are
      referenced as highest-committed-generation, per the project's standing
      lesson that a pinned version in an orientation document is a scheduled
      defect. No other change.
v1.15 (2026-08-21) Same-day currentisation after the refresh and the a5b map
      were delivered: work-order steps 1 and 2 marked DONE with the map's
      location and its Q36 tree-confirmation condition, step 3 becomes
      adjudication in map order with the bounded-batch recommendation, and
      the 0f population lines now say DERIVED rather than derive. Found in
      the same W3X-requested fitness check that caught the blurb staling on
      delivery day - the brief had the identical defect, and the brief is
      the document that PREVAILS, so its staleness was the more dangerous.
v1.14 (2026-08-21) T1S01a5 CLOSURE. Records a5 CLOSED under DEC-85/DEC-88
      with final ledger v1.10 (44 entries, all Tier C, W3C-reproduced), the
      residue routed at register 0c as R1-R8, and the explicit instruction
      that no a5 correction generation may be opened for any of it. Sets the
      work order: bounded continuity refresh, then a5b under Review Scope
      v1.15, then W3X's viability decision point. Adds the five recurring
      failures with their countermeasures and DEC-87's two rules about the
      gate machinery, all before a5b rather than after.
v1.13 (2026-08-20) POST-v1.9 STATE ADVANCE, written immediately after the
      third correction generation and W3X's DEC-85 closure cap, and across a
      mid-conversation model handover (context carried; recorded so a
      successor reading chat exports is not confused by the model change).
      Section 0a now carries: ledger v1.9 delivered (44 entries, all Tier C);
      scope v1.14 RATIFIED (DEC-83/84); the DEC-85 cap - at most one further
      generation, then a5 closes with residue carried to a7 - stated as a
      W3X ruling a successor must not argue around; the two method lessons
      v1.9 cost (lexical-vs-semantic probes, the fourth atomic-claim
      recurrence); and the full mechanical gate list, specified by what can
      be wrong rather than what the author remembers changing.
v1.12 (2026-08-19) SUCCESSOR-W3D HANDOVER REWRITE, written while the designer
      session is still available rather than reconstructed after a loss.
      Advances the state past W3C's recovery-closure review of ledger v1.6:
      records that the reissue is REQUIRED and a5 is NOT closed, and carries
      W3C's section-17 A-G correction list at 0d as the specification for
      ledger v1.7. Sets the work order at 0a on the principle DO THE
      UNRECOVERABLE THINGS FIRST - this brief, then Review Scope v1.12, then
      register v1.32, then the ledger, because the ledger corrections are fully
      specified in W3C's review and the rest exist nowhere.
      PROMOTES THE DURABLE CONTENT OF W3C's SEVEN-PART KNOWLEDGE CAPTURE, taken
      before that session became unavailable: the traps at 0c, the
      occurrence-level evidence and CITED-OUTSIDE-RANGE refinements at 0e, the
      a5b advance warnings at 0f, DEC-64's now-verified propagation wording at
      0g, and at 0h the one recorded cost of the DEC-70 provenance rule.
      Records that the Tier C sample is COMPLETE and must not be reopened -
      the stale generic instruction in Review Scope v1.11 caused a successor to
      believe it was still owed.
      Adds successor-discipline items 10 to 12, including the ENTRY-SWEEP GATE.
      Notes that the long-lived W3C session is effectively unavailable and the
      next W3C must be treated as fresh and memoryless.
v1.11 (2026-08-19) W3C reconstruction after W3D designer-chat session limit.
      Advances the live state past Classification Repair v1.1: confirms the
      three mechanical v1.0 review defects are visibly repaired and sets the
      next act to the T1S01a5 ledger rewrite. Records DEC-68 split ratification,
      DEC-66's 41-document adjudication population / GAIS ignore rule, DEC-67
      sweep rules, DEC-69's later T1S00 delivery-only bump, the six a5
      disposition-structure changes, eight rebuilt carrier lists, four changed
      findings, and the corrected 28-of-34 figure. Removes the stale
      "classification repair next", "split not ratified" and 24-of-34 state.
      Explicitly records that the supplied live T1 tree contains ledger v1.3,
      not the working v1.5/v1.6 generations mentioned in older continuity prose,
      so no undelivered generation is invented.
v1.10 (2026-08-19) Last W3D-authored resume brief before the designer session
      ended; state stopped immediately before Classification Repair v1.1.
```

---

*End of resume brief. Nothing here is ratified by this document.*
