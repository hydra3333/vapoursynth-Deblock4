# Deblock4 - T1S01a5 Covering Note to W3C: the recovery-closure review round

**Deliverable:** T1S01a5_A - COVERING NOTE
**Version:** 1.7
**Date:** 2026-08-19
**Author:** W3D (successor session)
**Route:** W3D -> W3X -> W3C
**Reviews requested on:** `T1S01a5_A_Ledger_Body_Part1_v1_8.md`
**Nature of this round:** DELTA REVIEW of the corrections you required.
**Binding review scope:** `Deblock4_T1_W3C_Review_Scope_v1_13.md` - corrected
after you declined to ratify v1.12. See section 0a.
**Binding work queue:** `Deblock4_Standing_Task_Register_T_Series_v1_30.md`
**Encoding:** US-ASCII; CRLF.

---

# 0. READ THIS FIRST - THE INDEPENDENCE POSITION HAS CHANGED

```text
YOU MAY HAVE BEEN TOLD TO EXPECT A ONE-OFF RECOVERY REVIEW OF A LEDGER W3C
WROTE. THAT IS NO LONGER WHAT IS HAPPENING, AND THE DIFFERENCE MATTERS TO WHAT
YOU ARE ENTITLED TO CLAIM AT THE END.

WHAT HAPPENED, IN ORDER:
  1. The W3D designer session reached its context limit AFTER delivering
     Classification Repair v1.1 and BEFORE delivering the promised ledger
     rewrite.
  2. W3C, doing the right thing with the information it had, produced
     T1S01a5_A_Ledger_Body_Part1_v1_4.md as an emergency recovery
     reconstruction, and said plainly in the artifact that it was one.
  3. W3C then reported to W3X that v1.4 had compressed fields the mandate never
     touched, and recommended a successor designer rebuild from v1.3 rather
     than expand v1.4. THAT WAS THE RIGHT CALL AND IT IS WHY THIS ROUND IS
     CLEAN.
  4. W3X ruled v1.4 out as a source. The successor W3D session then built
     T1S01a5_A_Ledger_Body_Part1_v1_5.md TEXTUALLY ON DELIVERED LEDGER v1.3,
     applying only deltas that trace to a delivered artifact or a ratified
     decision.

THEREFORE:
    LEDGER v1.5 IS A W3D DOCUMENT, BUILT FROM W3D's DELIVERED INPUTS.
    YOU ARE ITS ORDINARY INDEPENDENT REVIEWER.
    THERE IS NOTHING OF YOUR OWN FOR YOU TO CERTIFY.

v1.4 IS NOT IN THIS BATCH AND MUST NOT BE USED. It is excluded deliberately, so
that your review is not anchored on text W3X has ruled out. If you have it from
an earlier session, set it aside. Do not reconcile v1.5 against it, do not
report differences from it as findings, and do not treat its wording as a
baseline. THE BASELINE IS v1.3, WHICH IS IN THIS BATCH.
```

---

# 0a. A NEW BINDING SCOPE TRAVELS WITH THIS BATCH

```text
`Deblock4_T1_W3C_Review_Scope_v1_13.md` IS THE BINDING SCOPE FOR THIS ROUND AND
IS PART OF WHAT YOU ARE REVIEWING.

YOU DECLINED TO RATIFY v1.12 AND YOU WERE RIGHT ON BOTH COUNTS.
FIRST: v1.12 claimed every rule in section 0 was already binding through a
ratified decision. FALSE for 0.5, 0.6 and 0.7 - your own new refinements, still
mid-I7-chain. That is DEC-48's false assurance committed inside the document
written to consolidate rules against exactly that error. EVERY SUBSECTION NOW
CARRIES A STATUS MARKER: [RATIFIED] with its decision, or [VERIFIED - AWAITING
W3X RATIFICATION] where you have verified and only W3X ratification remains.
SECOND: the consolidation was incomplete on the day it shipped. DEC-77's
source-coverage rule and DEC-64/78's propagation wording are now at 0.10 and
0.11. DEC-77 explicitly binds a5b, so its absence was the precise defect v1.12
existed to prevent.

YOU PROPOSED IT. Your recovery-closure response found that the complete rule set
was spread across Review Scope v1.11, the Standing Task Register's decisions and
Classification Repair v1.1, and that this fragmentation was unsafe for a cold
successor and had likely caused the Tier C anomaly. That diagnosis was correct
and is accepted in full.

THE I7 CHAIN: W3C proposed, W3D drafted, W3C verifies, W3X ratifies. The party
the criteria judge is not the party that asked for them.

NO SUBSTANTIVE RULE IS CHANGED. New section 0 gathers what was already binding
through ratified decisions, and adds the three refinements you supplied:
    0.5  OCCURRENCE-LEVEL EVIDENCE - a file-level hit does not establish
         occurrence-level uniqueness inside that file. MIXED keeps its meaning
         and is not to be used merely because a proposition occurs twice.
    0.6  CITED-OUTSIDE-RANGE - evidence in another sub-tranche's territory may
         affect the current disposition while its own adjudication stays with
         the owning tranche, and the reconciliation obligation is recorded.
    0.7  THE ENTRY-SWEEP GATE - after editing any field of an entry, re-read
         the whole entry.
Section 0.1 carries the standing notice you asked for, verbatim in substance:
a5 Tier C sampling is COMPLETE, eleven selected, 3 AGREE / 8 DISAGREE, do not
select another sample. Section 6's generic instruction is marked as already
discharged for a5 while remaining live for every other sub-tranche.

PLEASE VERIFY IT AS A CONSOLIDATION: does section 0 state each rule as the
ratifying decision states it, and has anything been weakened, dropped or
silently altered in the move?
```


---

# 1. WHAT YOU ARE BEING ASKED TO DO

```text
THIS IS THE BOUNDED RE-REVIEW YOU SPECIFIED AT SECTION 17 OF YOUR DELTA
REVIEW. Review T1S01a5_A_Ledger_Body_Part1_v1_8.md under Review Scope v1.13.

YOUR OWN SECTION 17 LIST IS THE AGENDA - corrected scope status, LED-032a,
LED-037a, LED-043, LED-047, LED-053d, LED-055/055a/055b, LED-059, LED-063, the
recovery self-check, and the register/manifest surfaces.

EVERY FINDING IN YOUR DELTA REVIEW IS ACCEPTED. Nothing is disputed.

WHAT CHANGED, IN THE ORDER YOU WILL PROBABLY WANT TO CHECK IT:
  LED-063 - you established that the report CONTENT survives. Disposition
      CONFLICTING -> CURRENT-UNIQUE; tier recomputes A -> C; THE LEDGER NOW HAS
      ZERO TIER A ENTRIES, per your own instruction not to preserve a Tier-A
      count as a target. A CITED-OUTSIDE-RANGE record carries the R8 filename
      correction to a6.
  LED-055a / LED-055b - your rebuttal was accepted without argument: "no other
      document states BOTH in the same complete form" proves at most that the
      conjunction is unique. The progressive generality is now LED-055b,
      CURRENT-DUPLICATE, on the Scopes PreScope carrier you quoted. LED-055a
      keeps the correctness-versus-performance qualifier with a bounded probe.
      Range corrected to 562-564.
  THREE BOUNDED PROBES were run - LED-037a's default-scope qualification,
      LED-055a's correctness qualifier, and LED-047's F-to-V mapping. Each
      declares its proposition, family, population and every classified
      candidate. LED-047's claim is NARROWED: four Scopes documents carry the
      verification content, so only the F-to-V MAPPING is unique.
  THE THREE STALE SENTENCES you found in LED-043, LED-059 and LED-063 are
      removed, and so are three more that a MECHANICAL run of the entry-sweep
      gate caught afterwards. See ledger 0.4h.
  ENTRY COUNT 42 -> 43.

THE LEDGER'S CLOSING QUESTIONS Q-A to Q-L remain answerable but are secondary
to your own list. Q-F, Q-G, Q-J and Q-K are now withdrawn as answered.

YOUR OWN SECTION 18 LIST IS THE AGENDA:
    1. delta-review v1.6 -> v1.7;
    2. verify the three previously partial Tier C entries END-TO-END, not
       merely in the field that was edited: LED-043, LED-055, LED-061;
    3. verify Q-A coverage and ranges;
    4. verify the LED-047 tested-count repair;
    5. verify LED-059 against section 15;
    6. FULL TIER-A REVIEW of corrected LED-063, including the
       W3C-D4-VERIFY-1 candidate referent;
    7. verify the recovery self-check and delta provenance;
    8. verify the register and manifest no longer say Tier C is owed.

The ledger's closing questions Q-A to Q-L remain answerable but are secondary
to your own list.

THE STANDING RULES APPLY UNCHANGED:
    - Tier A gets full review; there is exactly ONE Tier A entry, LED-063.
    - THE TIER C SAMPLE IS ALREADY DONE AND IS NOT REOPENED. W3X selected
      eleven entries - LED-034, 037, 040, 043, 046, 049, 051a, 053, 055, 058,
      061 - and you reviewed exactly those at
      T1S01a5_B_Coder_Response_v1_1.md, returning 3 AGREE and 8 DISAGREE. That
      result drove the re-sweep, the classification repair and this rewrite.
      DO NOT RE-RUN IT. What is asked now is whether the rewrite APPLIED your
      findings correctly - see Q-K2 in the ledger, and section 3(e) below.
    - There are ZERO Tier B entries.
    - Your verdicts are AGREE / DISAGREE / UNSURE / MISSING. None of them is
      W3X acceptance of anything.
    - No source change, no build, no test, no patch, no git. C-DELIV-07's
      restriction on claiming PASS is not triggered here because nothing is
      executed; it is not waived either.

WHAT IS NOT BEING ASKED, and W3C specifically warned against it in the
Classification Repair Response: DO NOT REOPEN THE SEARCH. The 46-file
population and all 22 probe counts were reproduced by you and are settled. No
probe rerun, no synonym expansion, no classification reconsideration, no new
method rule, no architecture reopening. That warning was right and W3D has
honoured it: this rewrite ran no search.
```

---

# 2. WHAT CHANGED FROM v1.3, AND HOW TO TEST IT CHEAPLY

```text
THE FASTEST ATTACK ON THIS DOCUMENT IS A DIFF, AND W3D WANTS YOU TO RUN IT.

Ledger section 0.4c enumerates the complete delta set from v1.3, with the
authority for each. Section 0.4f enumerates every restoration - material v1.4
had deleted with no mandate, put back. Section 0.4g declares the two things
W3D added on its own judgement rather than under a mandate.

THE TEST, and it is closing question Q-L: diff v1.3 against v1.5. EVERY
DIFFERENCE SHOULD APPEAR IN THE 0.4c DELTA LIST OR THE 0.4f RESTORATION LIST.
A difference appearing in neither is a finding, and W3D wants it reported.

THE SEVEN DELTAS, in summary:
    D1  six disposition-structure changes - LED-043, 051, 053, 055, 058, 061
    D2  eight rebuilt carrier lists - LED-033, 035, 036, 038, 042, 049, 055, 061
    D3  four changed findings - LED-034, 051, 052a, 058
    D4  the 28 surviving disposition structures ENUMERATED, not asserted
    D5  the settled 46-file search population under DEC-60/63/66, replacing
        v1.3's 87-file description
    D6  every TIER computed from DISPOSITION per DEC-62
    D7  the work-queue pin advanced v1.23 -> v1.30

ENTRY COUNT 34 -> 39, by five mandated splits: LED-043a, LED-053c, LED-053d,
LED-058a, LED-061a.
```

---

# 3. FOUR THINGS W3D WANTS ATTACKED SPECIFICALLY

```text
(a) THE ENTRY COUNT AGREES WITH v1.4's AND THE MEMBERSHIP DOES NOT.
    Both land on 39. The reconstruction's suffix entries were LED-043a,
    LED-053b, LED-055a, LED-058a, LED-061a. This ledger's are LED-043a,
    LED-053c, LED-053d, LED-058a, LED-061a - LED-053's two separately-probed
    propositions get two entries rather than one bundled entry, and the
    unmandated LED-055a is not created. TWO CHANGES IN OPPOSITE DIRECTIONS
    NETTING TO ZERO. Compare the lists, not the totals. This is the same
    instruction DEC-67 gives about carrier sets, for the same reason.
    W3D ALSO GOT THIS WRONG IN DRAFT - the total was asserted as 40 and
    corrected by counting, and the correction then survived in the header two
    hundred lines away until the pre-issue check caught it. Both are recorded
    at ledger section 0.4e. If the arithmetic is still wrong, say so.

(b) THE LED-053 SPLIT IS W3D's READING OF YOUR OWN EVIDENCE, NOT A DIRECT
    INSTRUCTION. Classification Repair v1.1 says "LED-053 (b) unique; (c) and
    (d) duplicate" and prints TWO separate probe families for them - the
    repair's own tables LED-053c and LED-053d - with different candidate sets.
    You independently reproduced the LED-053d table. W3D read that as two
    propositions needing two entries, because bundling them under one
    DISPOSITION would be the compound-disposition defect DEC-61(a) recorded
    against this very entry. IF THAT READING IS WRONG, IT IS A REAL FINDING.

(c) LED-037 CARRIES BOTH A RESTORATION AND A CORRECTION, AND THEY PULL IN
    OPPOSITE DIRECTIONS. The reconstruction had deleted its whole evidence
    base - the stated population, the fifteen classified hit lines, the
    six-document collision enumeration with file and line numbers, and the
    recommendation that Classic-facing documents KEEP the name "Schedule A"
    because there it means the VERIFIED HOLYWU ORDER. All of that is restored
    from v1.3.
    BUT YOUR TIER C REVIEW ALSO FOUND that the entry's REASON sentence - "it
    is an audit record about this document, so no other document can hold it"
    - is not a uniqueness proof, because another document can repeat or report
    an audit result. v1.5 restored that sentence along with everything else.
    v1.6 WITHDRAWS IT and rests CURRENT-UNIQUE on the Classification Repair's
    audit-result probe instead, recorded as SWEPT result (iii).
    CHECK THAT THE RESTORATION AND THE CORRECTION DID NOT CANCEL EACH OTHER
    OUT - that is exactly the kind of place where they could.

(d) ONE QUESTION W3D HAS NO POSITION ON. Q-K: LED-053d's second carrier is
    APPENDIX A of the authority itself, at lines 1762-1932, which belongs to
    T1S01a6. The entry cites it under section 0.2's cited-as-evidence rule and
    does not adjudicate it. Is that the right handling for a same-file carrier
    outside the adjudicated range?
    Q-J IS WITHDRAWN. v1.5 asked whether LED-046 should point at LED-049 or
    LED-052a. You had already answered it in the Tier C review and v1.5 had
    not opened that document. Corrected.

(e) THE THING W3D MOST WANTS ATTACKED, AND IT IS W3D's OWN FAILURE.
    v1.5 applied SIX of your eight Tier C DISAGREE findings and MISSED TWO -
    LED-046's cross-reference and LED-037's uniqueness basis. Worse, v1.5's
    own provenance section NAMED your Tier C review among the artifacts used
    when it had not been opened. That is the false-assurance failure DEC-48
    records, written into the section asserting the provenance rule.
    THE CAUSE, because it is the reusable part: TWO ROUNDS FED a5 - your Tier
    C sample review, then the classification repair - and v1.5's delta list
    was built from the second only. It was cross-checked against two sources
    and reported "confirmed from both sides"; both sources concerned the
    REPAIR round. Two sources agreeing about one round is not coverage of the
    chain. The deltas were enumerated meticulously; the ROUNDS were never
    enumerated at all.
    SO: Q-K2 asks you to check the enumeration of all eight findings against
    your own review rather than accepting W3D's account of it. If a ninth
    exists, or if any of the six is applied in a way that does not match what
    you found, that is the most valuable thing you can report.
```

---

# 4. THE OTHER TWO DOCUMENTS IN THIS BATCH

```text
NEITHER NEEDS A FULL REVIEW. Both are included because they are part of the
same recovery clean-up and you should know they exist and what changed.

T1S00_A_Scope_Manifest_v1_6.md
    RECORD CORRECTIONS ONLY; no content change. The v1.5 header attributed the
    document to W3D when W3C produced it during recovery; DEC-69 sequenced the
    bump after the ledger rewrite and it ran before; and the revision-history
    heading and opening code fence had been missing since v1.4 or earlier,
    leaving the fences unbalanced. All three are corrected and recorded.
    ATTRIBUTED ACCURATELY: the fence defect is NOT W3C's - v1.4 has it too.
    The frozen frame is untouched: 90 terms, the surveyed population tables,
    all hit and line counts and section 5's weaknesses were verified present
    and unchanged.

Deblock4_Concise_Project_Summary_v1.7.md
    RESTORATION PASS. v1.6's state currency is kept in full; fourteen items
    v1.6 had dropped with no mandate are restored, all of them REASONING rather
    than status - the per-parameter rejected-architecture warning including
    "do not use it, do not recommend it" and the reason, the SeparateFields
    tearing mechanism, "NOTHING HAS BEEN RATIFIED INTO ANY AUTHORITY DOCUMENT",
    the Stage 2C HolyWu provenance, and the bounded-spikes and
    deferred-workstream lists. Also repairs a split revision-history block.
    W3X has ruled this document stays in the T1 population until T1S05
    adjudicates it, rather than being retired early - DEC-05's reasoning, that
    a label placed before adjudication is permission to skip.
```

---

# 5. A PATTERN WORTH KNOWING BEFORE YOU START

```text
Five documents were checked for recovery-era loss: the Task Register, the T1
Review Scope, Project Status, T1S00 and the Concise Summary. FOUR ARE CLEAN.
The Task Register kept all 69 decisions. The Review Scope kept and strengthened
the STAY-CANONICAL evidence requirement. Project Status kept every historical
state snapshot as it claimed. T1S00 kept the frozen frame intact.

WHAT THINNED, CONSISTENTLY, WAS REASONING RATHER THAN STATE. Every recovery
document was MORE accurate about where the project stands than its predecessor.
What went was the "why" - the reason a rule exists, the mechanism behind a
conclusion, the warning attached to a rejected thing. The ledger showed it at
60% loss; the Concise Summary at fourteen items; the other three barely at all.

THAT IS WHERE TO AIM YOUR ATTENTION IN v1.5 TOO: not at the status lines, but
at the paragraphs beginning "because" and "do not". If a disposition survives
while the reasoning that supports it has quietly gone, that is the defect class
this whole round exists to correct, and W3D is not immune to it.
```

---

# 6. DECISIONS/QUESTIONS FOR W3X

```text
None from this note.

W3X has already ruled on the four questions this round raised: the v1.3
baseline is confirmed as recorded; the T1S00 attribution and sequence
deviation are corrected here; the ledger's Q-J and Q-K go to W3C rather than
blocking issue; and this round closes the one-off recovery route.

No action is owed by W3X before this review.

A CORRECTION TO v1.4 OF THIS NOTE, recorded rather than silently dropped: v1.4
stated that W3X still owed the Tier C sample selection. THAT WAS WRONG. W3X
selected the sample, W3C reviewed it, and the result drove everything since.
The error came from the same cause as the two ledger defects at 3(e) - working
from the classification-repair round without enumerating the rounds that
preceded it.
```

---

*End of covering note. Nothing here is ratified. Every PROPOSED ACTION in the
ledger is a proposal to W3X, and no authority document has been edited.*

---

*Revision history*

```text
v1.7 (2026-08-20) Retargets to ledger v1.8 and Review Scope v1.13, and reframes
     the round as the bounded re-review W3C specified at section 17 of its
     delta review. Records that every delta-review finding is accepted without
     dispute, and summarises what changed in the order W3C is likely to check
     it - LED-063's re-disposition and the resulting zero-Tier-A ledger, the
     LED-055a/055b split, the three bounded probes, and the six stale sentences
     removed. Records that Q-F, Q-G, Q-J and Q-K are withdrawn as answered.
v1.6 (2026-08-19) Retargets to ledger v1.7 and reframes the round as the DELTA
     REVIEW W3C specified at section 18 of its recovery-closure response.
     Pins the new binding Review Scope v1.12 and adds section 0a explaining
     that the consolidation was W3C-proposed and is itself under review.
     Records that W3C's closure findings are accepted in full: three partial
     Tier C replacements now applied end-to-end, two uncovered propositions
     captured, LED-047's count corrected, LED-059's false section-15 canonical
     home withdrawn, LED-063's wrong filename separated from missing content,
     and the entry count moved 39 -> 42.
v1.5 (2026-08-19) Corrects two errors in v1.4. Retargets the review from
     ledger v1.5 to v1.6. Removes the false statement that W3X still owed the
     Tier C sample selection - it was selected, reviewed, and drove the whole
     chain - and replaces the "add LED-037 to the sample" request, which was
     redundant because LED-037 was already among the eleven. Adds section 3(e)
     recording that v1.5 of the ledger applied six of eight Tier C findings and
     missed two, with the cause.
v1.4 (2026-08-19) Rewritten for the recovery-closure round. Replaces the
     classification-repair framing with the ledger v1.5 review, states that the
     independence problem is resolved because v1.5 is W3D-authored from W3D's
     delivered inputs, excludes ledger v1.4 from the batch and forbids its use
     as a baseline, and names the four things W3D most wants attacked.
v1.3 and earlier: the classification-repair and re-sweep rounds. Superseded by
     this note for the current round; retained in the repository as history.
```
