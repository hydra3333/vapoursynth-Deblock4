# Deblock4 - T1S01a5b Population Delta Record

**Deliverable:** T1S01a5b_A - POPULATION DELTA
**Version:** 1.1
**Date:** 2026-08-21
**Author:** W3D
**Status:** PRE-ADJUDICATION ARTIFACT. It contains NO dispositions and
adjudicates NOTHING. It supersedes ONLY Part A (the population) of
`T1/T1S01a5b_A_Population_and_Coverage_Map_v1_0.md`. Part B of that map - the
source-coverage walk of authority lines 716-1098 - is UNTOUCHED and remains
the delivered coverage artifact.
**Binding review scope:** `Deblock4_T1_W3C_Review_Scope_v1_15.md`
**Source of record:** the W3X-supplied `dev_documentation` tree of 2026-08-21,
post-commit (635 files).
**Encoding:** US-ASCII; CRLF.

---

# 0. WHY THIS DOCUMENT EXISTS

```text
The coverage map's Part A was CONDITIONAL. Its section 0 states the condition
in its own words: the derivation ran against the working tree BEFORE the
continuity-refresh commit, and a snapshot of a tree that never existed is not
a snapshot. It instructed a successor to verify the committed tree against
section A.3 and, if the tree differed, to RE-DERIVE THE POPULATION ONLY.

THE TREE DIFFERED. This record is that re-derivation.

WHAT IT DOES NOT DO. It does not re-walk the source range, does not move a
reserved entry identifier, does not touch a split-candidate flag, and does not
reopen any settled a5 result. It changes which FILES a5b's SWEPT fields run
over, and nothing else.

WHY IT IS A SEPARATE DOCUMENT rather than a line in a covering note. A
population is a TESTABLE CLAIM under DEC-50: it must name what was examined in
a form another party can check by counting. a5's coverage failure survived
five ledger generations precisely because a completeness claim was recorded
where nobody could count it (DEC-77). W3X ruled on 2026-08-21 that this delta
is recorded here, before the first a5b batch, rather than inside it.
```

---

# 1. THE BASIS, STATED SO IT CAN BE REPRODUCED

```text
METHOD, exactly as the map's rule A.1 declares it:

    walk dev_documentation recursively;
    INCLUDE *.md and *.txt;
    EXCLUDE, by the ratified mechanical path rules:
        any folder whose name begins "superseded"
            or "scheduled_for_deletion" .................... DEC-60
        everything under T1/ ............................... DEC-63
        everything under GAIS_investigations/ .............. DEC-66

RAW MECHANICAL RESULT AGAINST THE COMMITTED TREE: 38 files.

AND THAT RAW RESULT IS THE POPULATION. This is the notable change from the
map, and it is worth stating plainly rather than leaving a reader to notice
it: at derivation time the raw walk returned 46 files and needed three
declared resolution rules to reach a population. Against the committed tree
the walk returns 38 and TWO OF THE THREE RULES HAVE NOTHING LEFT TO RESOLVE.

    R-A  LIVING-DOCUMENT RULE - NOW INERT. The root holds exactly one
         generation of each continuity document. The seven collision pairs
         R-A was written for no longer exist; every retired generation has
         been moved under superseded/.
    R-B  POINT-IN-TIME-RECORD RULE - STILL LOAD-BEARING, and the only rule
         still doing work. Both Architecture-D verification round briefs
         (v1_0 AND v1_1) remain members: they are distinct historical
         records of distinct review rounds, not two generations of one
         living document. This matches a5 precedent.
    R-C  REFRESH SUBSTITUTION - NOW SPENT. It existed to substitute
         uncommitted refresh generations for committed ones. The refresh is
         committed, so the walk returns the right generations directly.

THE POPULATION IS THEREFORE ESTABLISHED BY PATH AND FILENAME ALONE, with one
declared exception (R-B). That is a stronger position than the map had, and
it is a direct consequence of W3X's superseded/ moves rather than of any
reasoning by W3D.
```

---

# 2. THE DECLARED a5b POPULATION: 38 FILES

```text
ROOT (30):
    000_Instructions_to_coder_for_creating_New_Chat_Introduction_for_coder.txt
    000_Instructions_to_designer_for_creating_New_Chat_Introduction_for_designer.md
    111_New_Chat_Introduction_for_Coder_v1_37.md                       [SUB]
    111_New_Chat_Introduction_for_Designer_v1_33.md                    [SUB]
    222-INITIAL_BLURB_FOR_CODER_CHAT_v1_7.txt                          [SUB]
    222-INITIAL_BLURB_FOR_DESIGNER_CHAT_v1_9.txt                       [SUB]
    333_W3X_Coder_Communication_Convention_v1_0.md
    333_W3X_Designer_Communication_Convention_v1_1.md
    AI_Charter_and_Invariants_Card_v1_31.md
    Deblock4_Concise_Project_Summary_v1.8.md
    Deblock4_DISPATCH_RELATED_Backend_Objects_Explained_v1_4.md
    Deblock4_Debug_Module_Inclusion_Pattern_v1_1.md
    Deblock4_Documentation_Currency_Audit_v1_8.md
    Deblock4_Forward_Roadmap_v1_24.md
    Deblock4_MPEG2_Deblocking_Investigation_and_Decided_Architecture_v1_05.md
    Deblock4_MPEG2_Grid_Field_DCT_Knowledge_v1_2.md
    Deblock4_Project_Status_v1_35.md
    Deblock4_Scope_Header_CDELIV09_Reminder_Block_v1_1.md
    Deblock4_Scope_Stage_1B3_Runtime_Capability_Guard_v1_3.md
    Deblock4_Session_Bootstrap_Header_v1_4.md
    Deblock4_Session_State_Stage_1B3_v1_0.md
    Deblock4_Stage_1C_Creation_Error_Message_Table_v1_1.md
    Deblock4_Stage_1C_Phase_3a_Designer_Briefing_v1_2.md
    Deblock4_Stage_1C_Phase_3b_Coder_Resume_Brief_v1_1.md
    Deblock4_Stage_2C_D0_Preface_and_Binding_Knowledge_Index_v1_14.md
    Deblock4_Stage_2C_D2_HolyWu_Real_Schedule_v1_7.md
    Deblock4_Toolchain_Findings_F6_Addendum_for_v1_2.md
    Deblock4_Toolchain_Findings_v1_4.md
    Deblock4_Verification_And_Tiering_Decisions_v1_11.md
    README_Deblock4_Design_Spec_v1_12.md

SCOPES/ (6):
    Deblock4_D4_Architecture_ReDecision_Brief_for_W3C_v1_0.md
    Deblock4_D4_Architecture_ReDecision_W3C_Evaluation_v1_0.md
    Deblock4_D4_PreScope_Round_Brief_for_W3C_v1_2.md
    Deblock4_D4_PreScope_Round_Brief_for_W3C_v1_2_CODER_RESPONSE.md
    Deblock4_D4_Verification_Round_Brief_for_W3C_v1_0.md               [R-B]
    Deblock4_D4_Verification_Round_Brief_for_W3C_v1_1.md               [R-B]

REFERENCE/ (2):
    reference/holywu_r9/README_provenance_v1_4__replaces_holywu_r9_README_provenance.md
    reference/holywu_r9/SHA256SUMS.txt

    [SUB] marks a document whose GENERATION differs from the map's A.3 entry.
    [R-B] marks a member retained by the point-in-time-record rule.

    30 + 6 + 2 = 38. The count is derived by enumerating this list, not
    carried from the walk (a5's standing lesson: derive every count by
    enumeration from the finished file).
```

---

# 3. THE DELTA AGAINST MAP SECTION A.3, ENUMERATED

```text
FOUR GENERATION SUBSTITUTIONS - membership unchanged, CONTENT CHANGED:

    map A.3 declared                       committed tree holds
    ------------------------------------   ------------------------------------
    111_New_Chat_Introduction_for_             ..._Coder_v1_37.md
        Coder_v1_36.md
    111_New_Chat_Introduction_for_             ..._Designer_v1_33.md
        Designer_v1_32.md
    222-INITIAL_BLURB_FOR_CODER_               ..._CODER_CHAT_v1_7.txt
        CHAT_v1_6.txt
    222-INITIAL_BLURB_FOR_DESIGNER_            ..._DESIGNER_CHAT_v1_9.txt
        CHAT_v1_8.txt

    Neither v1_6 nor v1_8 exists in the committed tree. The map's rule R-C
    named the generations expected at commit time; two further refresh
    rounds landed after the map was written, and the fitness-check pass of
    2026-08-21 advanced both introductions again.

TWO REMOVALS - membership REDUCED by two:

    Scopes/Deblock4_T1_W3C_Review_Scope_v1_7.md
    Scopes/Deblock4_T1_W3C_Review_Scope_v1_1_W3C_Review_v1_0.md

    Both were declared members at map A.3. W3X moved both to
    Scopes/superseded/ on 2026-08-21, so DEC-60's path rule now excludes
    them. No judgement was applied and none was needed.

ONE FILE THAT NEVER ENTERED, RECORDED SO IT IS NOT REDISCOVERED:

    Scopes/Deblock4_T1_W3C_Review_Scope_v1_12.md

    It was present in the pre-commit tree, absent from map A.3, and would
    have been a member under the map's own mechanical rule. W3X ruled it
    ignored and has since moved it to Scopes/superseded/. It is therefore
    excluded by path and the question is closed - but it is recorded here
    because an unrecorded exclusion is indistinguishable from an
    undiscovered one (the DEC-59 lesson).

ARITHMETIC:   40 declared - 2 removed = 38.
              Four substitutions do not move the count.

WHAT IS NOT RE-DERIVED HERE, AND SAID SO RATHER THAN IMPLIED: map section
A.4 accounted the 46-to-40 step against a5's settled search snapshot. That
accounting is not re-run in this record. If W3X wants the 46-to-38 chain
closed end to end against a5's corpus record, it is a separate bounded check
and W3D will run it on request.
```

---

# 4. WHAT DID NOT CHANGE

```text
Part B of the coverage map stands in full and is unaffected by tree state:

    the walk of authority lines 716-1098, tiling the range with no gap
        and no overlap;
    the 34 reserved entry identifiers LED-064 through LED-097;
    the seven SPLIT-CANDIDATE flags (LED-070, 074, 078, 082, 091, 097 and
        the LED-067 Appendix-C mapping question);
    the two pre-identified CITED-OUTSIDE-RANGE obligations
        (LED-067 -> Appendix C; LED-081 -> section 16, both a6's);
    the four recorded no-proposition segments.

A COVERAGE WALK IS A WALK OF THE SOURCE. It does not depend on which other
documents exist, which is exactly why the map's section 0 instructed a
population-only re-derivation.

Also unchanged: every settled a5 result, DEC-67's methodology, the a5 Tier C
sample, Classification Repair v1.1, Review Scope v1.15's substantive method,
and the B2/D architecture position.
```

---

# 5. TWO CAUTIONS FOR WHOEVER READS THIS NEXT

```text
1. FIVE POPULATION NUMBERS NOW EXIST, AND FOUR OF THEM ARE NOT THIS ONE.
   DO NOT RECONCILE THEM BY REWRITING HISTORY.

       47   frozen T1S00 survey record, 2026-08-18
       46   settled a5 SEARCH snapshot - a5's evidence of record
       41   current T1 ADJUDICATION population, after DEC-66
       40   the a5b population AS DECLARED at map A.3 - now superseded
            by this record
       38   the a5b SEARCH population in force

   The 41 and the 38 are different objects arrived at by different rules,
   and any resemblance between any two of these figures is coincidence -
   a5's raw walk coincidentally equalled its settled 46 in the same way.

2. A REFRESHED CONTINUITY DOCUMENT IS UNSWEPT TEXT.
   The map's A.4 states it and it applies with more force now, because four
   generations moved rather than none: R-C and its successors substitute
   MEMBERSHIP, never content equivalence. Any a5b probe touching one of the
   four substituted documents runs against text that no a5 probe ever saw.
   An a5 conclusion about which files carry which proposition is not
   inherited; it is re-established on this population or not claimed.
```

---

# 6. TREE-INTEGRITY EVIDENCE, RECORDED BECAUSE IT WAS CHECKED

```text
The pre-commit and committed trees were compared mechanically rather than
accepted on description. Results, testable by repeating the comparison:

    files, pre-commit tree ................................. 658
    files, committed tree .................................. 635
    files present in both, byte-identical .................. 626
    files present in both with content changed in place ....   0

    ZERO SILENT IN-PLACE EDITS. This matters because the charter records
    the in-place edit that leaves a version string untouched as the one
    case its revision-matching discipline does NOT catch. For this commit
    the residual risk did not materialise.

    Of the 32 files removed from their old paths, 31 survive under a
    superseded/ path. ONE DOES NOT EXIST ANYWHERE IN THE COMMITTED TREE:

        T1/Deblock4_Standing_Task_Register_T_Series_v1_31a.md

    It is T1 process material, excluded from every population by DEC-63, so
    NO ADJUDICATION CONSEQUENCE FOLLOWS. It is recorded because it is the
    only artifact in this commit that was deleted rather than retired, and
    W3X may want it restored to superseded/ for the record.

    Review Scope v1.15 is now committed as a loose file at
    T1/Deblock4_T1_W3C_Review_Scope_v1_15.md. It is byte-identical
    (SHA-256 38a521f302228f6151731321f7c0afe2d18d226515a4a4d4376d7f5b74130f03)
    to both the copy W3X supplied directly and the copy inside
    T1/T1S01a5_A_Recovery_Closure_Batch_v6.zip. The three agree; there is no
    ambiguity about which text binds.
```

---

*Revision history*

```text
v1.1 (2026-08-21) DEC-84 PROPAGATION CORRECTION (LED-081a, ERRONEOUS):
     the pre-identified LED-081 out-of-range routing said "section 15";
     the revisit requirement lives in SECTION 16 (authority 1261-1284).
     One word changed at the routing line; nothing else. Basis: ledger
     Part2 v1.2 LED-081a and W3C findings T1S01a5b_B F9.3.
v1.0 (2026-08-21) First issue. Re-derives the a5b population against the
     committed tree after the tree verification required by the coverage
     map's section 0 found a difference. Population moves from the declared
     40 to 38 by two removals, with four generation substitutions that do
     not move the count. Part B of the map is untouched. Issued as a
     standalone record at W3X's ruling of 2026-08-21 rather than inside the
     first a5b batch, because a population is a testable claim under DEC-50.
```

---

*End of record. Nothing here is ratified by this document, and nothing here
adjudicates a proposition.*
