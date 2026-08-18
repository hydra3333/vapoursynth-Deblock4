# Deblock4 - W3C Review Scope: the T1 Documentation Consolidation Sweep

**Deliverable:** T1-W3C-REVIEW-SCOPE
**Version:** 1.8
**Date:** 2026-08-18
**Author:** W3D (designer), issued to W3C by W3X
**Route:** W3D -> W3X -> W3C
**Status:** BOUNDED REVIEW SCOPE. Live once W3X issues it.
**Encoding:** US-ASCII; CRLF.

---

# 1. Read this first: what this scope is NOT

This is not a coding scope. Nothing in it asks you to change, build, patch or
test any source file.

```text
NO source changes.          NO build.        NO proof matrix.
NO delivery package.        NO patch.        NO restore_to_base folder.
NO apply_to_tree folder.    NO git anything.
```

If you find yourself preparing a delivery package, you have misread the scope.
Your entire output is written review, sent as ordinary documents.

One point of charter hygiene, because a bounded scope never suspends a charter
rule. No build, test or proof run happens anywhere in T1, so the standing
restriction on claiming PASS (C-DELIV-07) is simply NOT TRIGGERED here - it is
not waived, relaxed or replaced. You must not imply you executed anything. Your
outputs are review verdicts (AGREE / DISAGREE / UNSURE / MISSING), and none of
them is W3X acceptance of anything.

---

# 2. What is going on, in plain English

The project keeps its knowledge in about twenty documents. Over time the same
facts got written down in several of them, and some of those copies are now
out of date, contradict each other, or describe a design the project has since
rejected. Nobody has ever gone through the whole set systematically.

That is not a hypothetical worry. It has already cost us once, and the story
matters because it explains why this task is shaped the way it is.

```text
WHAT HAPPENED. The designer ran four rounds of external research to settle
how MPEG-2 lays out its blocks and to decide an architecture for the new
filter. That work finished and produced a decided architecture. Then, while
starting to tidy the documents, the designer opened the README - and found
that a complete, already-approved design for the same problem had been
sitting in it the whole time. Nobody in the investigation had read it.

WHY IT WAS MISSED. The designer had swept the source code thoroughly and
swept the decision records thoroughly. The README was skipped because an
index document described it as "fallback general guidance" - and that
description was believed instead of checked. It is a 2,800-line document
containing an approved architecture.

WHAT IT COST. Everything downstream reopened. The just-decided architecture
went back on the table and a full re-evaluation was needed - which you took
part in. The rediscovered design was eventually rejected, but only after
proper analysis, and that analysis produced the current primary candidate,
which is better than what the investigation had reached on its own.

So the near-miss ran BOTH ways: we nearly shipped past good work, and we
nearly missed the argument that improved the design.
```

Task T1 is the sweep that should have happened. The designer reads every
MPEG-2-related statement in every live document and records a decision about
each one: is it still true, is it a duplicate, does it contradict something
else, is it superseded. Those decisions go into a running record called the
LEDGER, one numbered entry per statement.

**Your job is to review those ledger entries.**

---

# 3. Why you specifically, and what W3X is buying

W3X's judgement, which you should take at face value: you have repeatedly
shown independent thinking when asked for it, and the three-way no-fault
review has proved its worth on this project over time. That is the reason
this review exists rather than the designer simply marking their own homework.

Be aware of the specific failure mode you are the defence against. The
designer will read several hundred statements across roughly twenty documents.
Reading attention degrades. More dangerously, PARTIAL FAMILIARITY BREEDS
SKIPPING - the original miss happened because the designer had read parts of
that README earlier in the project, and that is exactly what made skipping it
feel safe. A thin or hurried adjudication will still LOOK like a complete
ledger entry. It will have a document reference, a quoted line and a stated
reason, and it will read as reasonable.

You are being asked to notice when it is not.

**A note on how you will receive the entries.** W3X has decided you get the
ledger with the designer's reasoning already in it, rather than being given
raw document extracts and asked to work them out independently. That is a
deliberate cost decision and it is settled - do not ask to change it. But it
has a known weakness and you should hold it consciously: reading someone's
reasoning makes it easy to find that reasoning reasonable. The designer's
entries are written to be persuasive because that is what writing is. Where an
entry is in the top tier, the source text is included verbatim inside the
entry, so **check the quoted source against the conclusion drawn from it**
rather than checking whether the conclusion sounds sensible.

---

# 4. What arrives, and when

The work is split into six STEPS, not one big document. Each step is roughly
one document's worth of ledger entries. You review one step and send it back;
the next step arrives later, in a different session.

The reason for splitting it up is blunt: two designer sessions have already
died mid-task, and one died holding finished work that was never sent.
Anything not delivered is lost. The same applies to your reviews - send each
step back when you finish it, do not accumulate.

```text
THE SIX STEPS

T1S00  The scope manifest. The list of every document in the sweep and the
       search terms used to build it. NO ledger entries - your job here is
       the fourth pre-registered item (PR-4): review the search terms and
       say what they would still miss.
T1S01  The MPEG-2 authority document. Holds PR-1 and PR-2.
T1S02  The README, part 1 - decision-status table, sections 3.11 to 6.2,
       and the F12-F17 findings series.
T1S03  The README, part 2 - Appendices A and B, section 20.
T1S04  The charter (read, never stripped; holds PR-3), plus the D0
       knowledge index and the D2 HolyWu schedule document (holds PR-4).
T1S05  Everything remaining - project status, verification and tiering,
       the old grid-knowledge document, roadmap, currency audit, the
       chat introductions and blurbs, and the smaller records.
```

## 4.0a A step may arrive in SUB-TRANCHES

A step covering a large document is delivered in parts. Each part is a
separately reviewable package with its own number, and you review each as it
lands rather than waiting for the whole document.

```text
T1S01a1   authority document, part 1   (issued; both entries rejected)
T1S01a2   authority document, part 2
T1S01a3   authority document, part 3   ...and so on until the document is done
```

**Why the work is chopped up:** a designer session that dies mid-document
loses everything not yet delivered. Sub-tranches cap that loss at one part.
The same logic applies to your side - send each response when you finish it.

**THE ONE RULE THAT DEPENDS ON THIS.** Some entries only conflict with OTHER
entries, and those may be in a part you have not seen. So:

```text
PER SUB-TRANCHE:  review the entries in front of you normally - all five
                  standard questions, plus Q-F where an entry has a DERIVED
                  field.

AT THE FINAL SUB-TRANCHE OF A DOCUMENT: the designer will say plainly that
                  it is the last one. ALSO check the document's entries
                  AGAINST EACH OTHER - contradictory dispositions, the same
                  statement adjudicated twice differently, a PREVAILS chain
                  that loops, a principle declared unique in one entry and
                  found elsewhere in another.
```

You are NOT expected to spot cross-entry contradictions against entries you
have not been shown. If you suspect one but cannot check it, say so and name
what you would need.

## 4.1 File naming

Every file carries its step number at the FRONT, so a directory listing keeps
a step and its answer together. `_A_` is what goes TO you; `_B_` is what comes
BACK from you, so the answer always sorts directly after the question.

```text
T1S01a2_A_Ledger_<subject>_v1_0.md          the ledger you review
T1S01a2_A_Designer_Batch.zip                what W3X sends you
T1S01a2_B_Coder_Response.zip                what you send back

Read the identifier as: step T1S01, part a, sub-tranche 2, `_A_` to you.

Name your response zip with the SAME step number and the _B_ marker. If a
step needs a second pass, keep the step number and bump your document
version inside the zip.
```

## 4.2 What arrives in each session

You have no memory between sessions, so every session is self-contained.

```text
AT THE START OF YOUR CHAT, AND AGAIN FROM TIME TO TIME - THE REFERENCE SET:
  - the COMPLETE dev_documentation zip. Every live project document,
    locatable by folder and filename. This is your reference library for
    the whole sweep: the task register, the MPEG-2 authority, the charter,
    the outgoing designer's evidence set, and every document any step
    adjudicates are all inside it.
  - the SOURCE tree zip. dev_documentation does NOT contain source, and
    Tier B asks questions that can only be answered by reading the code.
    See 4.2.3.
  - the current version of this scope.

W3X supplies this set at the start of your chat and MAY RE-SUPPLY IT LATER -
typically after a significant step, when a refreshed copy is likely to be
useful. That is normal, not an error signal. But it has one consequence you
must handle - see 4.2.0b.

IF YOUR CHAT IS EVER REPLACED, THE SET MUST BE SUPPLIED AGAIN. You have no
memory across chats. See 4.2.0 - do not proceed without it.

WITH EACH STEP:
  - that step's ledger;
  - the task register, IF it has been bumped since the last supply (it
    carries the decisions and method forward, so the newest version wins);
  - a statement of exactly which document and which sections that step
    adjudicates.

If you believe you are missing something you need, ASK W3X. Do not infer the
base from an earlier conversation, from the status document, or from any
recorded hash. If evidence is insufficient to answer a question honestly,
report that entry as UNSURE or as a METHOD BLOCKER and say what you need -
DO NOT infer the answer.
```

### 4.2.0 First thing in every chat: confirm you actually have the corpus

Before reviewing anything, check that the dev_documentation zip is present in
your context. If it is not:

```text
STOP. Say so plainly to W3X and ask for it. Do not begin the step.
Do not work from the ledger alone, and do not reconstruct what a document
probably says from the ledger's quotations of it.
```

This is not a formality. Working from the ledger alone makes two of your five
review questions impossible to answer honestly - see 4.2.1 - while still
producing a response that LOOKS complete. A missing corpus must fail loudly.

### 4.2.0b When you hold two generations of the same document

Because the reference set may be supplied more than once in a chat, you can
end up holding TWO copies of the same document - an earlier one and a later
one - and they may differ.

```text
THE MOST RECENTLY SUPPLIED COPY WINS. Always.

Where a filename carries a version, the highest version wins, and if the
most recent supply contains a LOWER version than one you already hold,
that is a defect: STOP and tell W3X rather than choosing for yourself.

If you notice that an earlier and a later copy differ in a way that
affects an entry you are reviewing, SAY SO in your response.
```

This matters more here than it would elsewhere. Reasoning from a superseded
copy of a document, while believing it current, is the precise failure this
entire task exists to correct. Do not let the review method reproduce the
defect it is reviewing.

### 4.2.0a How to use the corpus - read the step, not the library

The zip is a reference library, not a reading assignment. Each step names the
document and sections it adjudicates: read THOSE in full, and consult anything
else in the corpus when a specific entry sends you there - a conflict
adjudication, a claim about what some other document says, a supersession
call. Do not attempt to read the whole corpus; you will exhaust the session
before reviewing anything.

### 4.2.1 Why you need the documents and not just the ledger

An earlier version of this scope sent you the ledger without the documents it
adjudicated. Your own review of that version found the defect, and the reason
is worth stating so nobody quietly undoes the fix later.

One of the five review questions (Q-D in section 8) asks whether the designer
walked past something without logging it. **A ledger can only show what the
designer DID log. It cannot show what the designer did NOT log.** Asking you
to find omissions while giving you only the record of what was found is asking
for something the evidence cannot support - and omission is precisely the
failure this whole task exists to correct.

The corpus fixes this completely: you read the swept sections yourself, in
full, from the original document. Note in particular that you are NOT limited
to the extracts the designer chose to quote. A designer-chosen extract cannot
reveal what the designer overlooked, so where an entry's quotation looks thin
or conveniently bounded, GO AND READ THE SURROUNDING TEXT.

### 4.2.2 The same point at the level of PR-4

PR-4 asks what the search terms would still miss. A manifest is a list
produced BY the search - it cannot show you a document the search failed to
select. You would be looking for absences inside a list of presences.

The corpus fixes this too: you can see every live document, including the ones
that matched nothing. Judge from their content, not their filenames, whether
anything bears on MPEG-2 matters without using the search terms - and remember
the whole reason this task exists is that a document's LABEL was believed
instead of its contents being checked.

### 4.2.3 Read-only source inspection is permitted and expected

Section 1 forbids source CHANGES. It does not forbid source READING, and the
previous version's phrase "do not touch source" was ambiguous. To be exact:

```text
PERMITTED and, for Tier B, REQUIRED:
    reading the source tree to establish what the code actually implements.

NOT PERMITTED, at any point, for any reason:
    modification, build, execution, patch, delivery package, git operation.
```

Tier B asks whether a statement is a specification the code implements or
background knowledge dressed as one. That is a question about the code, and it
cannot be answered honestly from documents alone.

## 4.3 You will not get feedback between steps - this matters

W3X collects your responses and reviews them TOGETHER at the END of the sweep,
against the completed ledger. That is a deliberate decision about W3X's own
reading load, not an oversight.

Two consequences you must hold consciously:

```text
- SILENCE IS NOT AGREEMENT. Nobody has accepted your step-1 findings by the
  time step 2 reaches you. Do not treat an unanswered point as settled, in
  either direction, and do not stop raising a concern because you raised it
  before. If the same problem recurs in a later step, RAISE IT AGAIN.

- IF THE PROBLEM IS THE METHOD, NOT THE ENTRY, ESCALATE IT LOUDLY AND
  IMMEDIATELY. A wrong entry costs one entry. A wrong METHOD - entries whose
  quoted extracts are too short to check, a whole outcome category being
  misapplied, a format you cannot actually review - gets repeated across
  every remaining step before anyone notices. Put that kind of finding in
  your TOP questions section, stated plainly as a method problem, not buried
  in an entry verdict. The first response you send is read promptly by W3X
  precisely so this class of problem is caught early.
```

## 4.4 How the sweep actually closes - the final three-way round

No adjudication becomes final because the designer proposed it, and none
becomes final because you agreed or disagreed with it. The closure is a
separate round after the last step:

```text
after T1S00..T1S05 are complete:

  W3X assembles the completed ledger plus all six of your responses.
  W3D answers EVERY unresolved disagreement, UNSURE, MISSING and method
      finding - in writing, item by item.
  W3C independently checks those proposed resolutions - BOUNDED to the
      entries where the designer DISAGREED WITH YOU or CHANGED an
      adjudication. Entries where you agreed and nothing moved are not
      re-reviewed.
  W3X decides and records the final adjudications.
```

A METHOD-level blocker is the exception and may be acted on immediately,
because letting a broken method continue multiplies the defect across every
remaining step. Entry-level items wait for this closure round.

Two things follow from this that are worth holding on to. Your findings are
not lost by being deferred - they are held. And an entry you marked UNSURE is
not a failure to do your job; it is an open question routed to the person who
can settle it, which is better than a confident wrong answer that closes the
file.

---

# 5. What a ledger entry looks like

```text
LED-047

  --- WHAT THE DOCUMENT SAYS (findings about existing text only) ---
  DOCUMENT     which document, which section, which line
  CLAIM        the actual words in that document, quoted briefly
  ASSERTS      what that claim means, in plain English
  CLASS        what kind of evidence it is - verified against the MPEG-2
               standard / a specification / from source / measured /
               reasoned / approved by W3X
  DISPOSITION  EXACTLY ONE of the five values below. Never anything else.
               It must cover ONE proposition - see 5.2.
  REASON       why that outcome
  CONFLICTS    what it contradicts, if anything
  PREVAILS     which statement wins, and where that leaves the loser
  SWEPT        REQUIRED whenever the entry claims a statement is UNIQUE,
               INDEPENDENT of something, or UNAFFECTED by something. Record
               WHAT WAS SEARCHED to establish it: which document, which
               sections, which terms, and what was found. See 5.3.

  --- WHAT THE DESIGNER INFERRED (optional; omit when there is none) ---
  DERIVED      any proposition the designer reasoned to rather than found in
               the text. Stated separately BECAUSE IT IS NOT A FINDING ABOUT
               THE DOCUMENT - it is new reasoning, and it is reviewable on
               its own terms.
  DERIVED-BASIS  what the derivation rests on, so you can attack the
               reasoning rather than only the conclusion.

  --- ROUTING ---
  TIER         A, B or C - how hard you are being asked to look
  PROPOSED
  ACTION       what the designer proposes W3X do, if anything
  VERDICT      yours
```

## 5.2 ONE DISPOSITION COVERS ONE PROPOSITION - the atomic-claim rule

A disposition describes the status of ONE claim. If a quoted sentence contains
two propositions with DIFFERENT statuses, it gets TWO ENTRIES, or the CLAIM is
narrowed so the entry covers only the one being dispositioned.

```text
NEVER: give the whole sentence one disposition and preserve the other
       clause's status in REASON. That is a second, unrecorded disposition
       hiding in prose.
```

**Where this came from.** In the first sub-tranche of the authority document
one entry marked a whole sentence SUPERSEDED while its own reasoning said the
clause after the comma remained binding, and another marked a compound
statement CONFLICTING while noting half of it was current. You found both. The
proposed remedies were clause-selective and correct - the LEDGER RECORD was
not, and the ledger is what proves coverage.

If you see a disposition standing over text with two different outcomes, that
is a finding, not a stylistic preference.

## 5.3 THE SWEPT FIELD - claims of uniqueness, independence and unaffectedness

This field exists because of a specific repeated designer failure, and you
should know the history so you can attack the field rather than accept it.

```text
THREE TIMES the designer asserted something without searching for the
counter-evidence, and each time the counter-evidence sat in a document
already open:

  claimed a section was the UNIQUE home of a principle
        -> another section of the SAME document already stated it;
  claimed two design decisions were INDEPENDENT
        -> one shipped parameter moves both;
  claimed a list's tail was UNAFFECTED by a reordering
        -> the same document elsewhere makes one tail item depend on a
           later one.

Twice the designer had flagged the risk in that very entry and still did not
check. "More care" has now failed three times, so the check is made VISIBLE
instead of left internal.
```

So: any claim of uniqueness, independence or unaffectedness must record what
was swept to establish it. An entry that cannot fill in SWEPT has not earned
the claim.

**What this gives you:** you can attack the SEARCH rather than only the
conclusion. If SWEPT names three sections and you can think of a fourth, that
is a finding. If SWEPT is absent from an entry making such a claim, that is a
method finding.

## 5.1 Why the two halves are separated - this is a corrected defect

The first ledger this project produced did NOT separate them, and the
consequence appeared immediately. One entry dispositioned a statement as
"SUPERSEDED-IN-FORM, CURRENT-IN-SUBSTANCE" - a value that does not exist -
and thereby assumed its own conclusion: it decided the statement's substance
was live by asserting substance the text did not contain.

You found that. The rule that follows, in your own words, is worth keeping
exactly as you put it:

```text
Otherwise future entries can make a statement "current in substance" by
inventing the substance they wish it had.
```

So: DISPOSITION describes only what is on the page. Anything the designer
reasons TO goes in DERIVED, marked as inference, with its basis stated. If you
see an entry where a conclusion has migrated from DERIVED into DISPOSITION or
ASSERTS, that is a method finding and belongs at the TOP of your response.

The five possible dispositions. There are FIVE, there will only ever be five,
and an entry using a sixth is a defect rather than a wording preference:

```text
CURRENT-UNIQUE      still true, and this is the only place it is written.
                    Leave it where it is.
CURRENT-DUPLICATE   still true, and written in more than one place. The
                    entry must IDENTIFY THE CANONICAL HOME - the one place
                    the statement belongs - and then say which side this
                    copy is on:
                      this copy IS the canonical home -> it STAYS, and the
                        non-canonical copies elsewhere are what T3 reduces
                        to pointers;
                      this copy is NOT the canonical home -> it becomes a
                        pointer to the home.
                    Do NOT use CURRENT-UNIQUE for a statement that is merely
                    in its correct home while also appearing elsewhere. It is
                    a DUPLICATE; what varies is which copy survives.
CONFLICTING         it contradicts another document. A decision is needed
                    about which one wins.
SUPERSEDED          no longer true. Retire or delete it.
OPERATIVE-SPEC      it is not background knowledge, it is a specification
                    the code actually implements. It stays where it is and
                    gets a pointer added alongside.
```

---

# 6. How hard to look: the three tiers

Effort is deliberately unequal, because the cost of a wrong entry is
unequal. Getting a duplicate wrong wastes a paragraph. Getting a conflict
wrong writes a false statement into the document that the whole project
treats as authoritative.

```text
TIER A - FULL REVIEW. Every entry marked CONFLICTING; EVERY entry marked
    SUPERSEDED, whether the plan is to delete it or to replace it with a
    pointer; and all four pre-registered items in section 7.
    (An earlier version tiered only the deletion cases, which left
    pointer-replacement superseded entries with no tier at all. Retiring
    knowledge is high-risk either way - a wrongly-retired statement is
    gone whether it was deleted or merely pointed away from - so the
    whole category is Tier A.)
    The source text is included verbatim in these entries.
    For each one, answer all five questions in section 8.

TIER B - CLASSIFICATION CHECK. Every entry marked OPERATIVE-SPEC.
    One question only: is this really a specification the code
    implements, or is it background knowledge dressed as one?
    WHY THIS TIER EXISTS AT ALL: "this document is just general
    guidance" is the precise judgement that caused the original miss.
    It is the single call this project has already got wrong, so it
    gets its own tier even though it looks minor.

TIER C - SPOT CHECK. Entries marked CURRENT-UNIQUE or CURRENT-DUPLICATE.
    W3X selects a random sample - the designer does not choose which
    ones you see. Same five questions as Tier A on the sampled entries.
    You are checking whether the routine entries are as solid as the
    important ones, which is where hurried work shows up first.
```

---

# 7. The four pre-registered items - read these before anything else

These four were identified before the sweep started, and registered so they
could not get lost along the way. All four are Tier A. The first one is the
most important thing in this scope.

```text
PR-1  A LIMIT THAT MAY APPLY TO EVERY DESIGN IS CURRENTLY FILED AS AN
      ARGUMENT AGAINST ONE REJECTED DESIGN.

      The limit itself is not in dispute. Take a run of pixels that is flat
      on both sides of a step - three identical values, then three identical
      higher values. A genuine compression seam and a harmless real edge in
      the picture produce EXACTLY THE SAME NUMBERS. No threshold can tell
      them apart, because there is nothing to tell apart: the observations
      are identical. Tightening the threshold trades one kind of error for
      the other; it cannot remove the problem.

      Here is the issue. That reasoning currently sits inside the section of
      the authority document that explains why the old Architecture A was
      rejected, and it ends with a paragraph about a parameter belonging to
      that rejected design. So it reads as an argument against A.

      The previous designer's position - and it is a POSITION, not an
      approved finding - is that this limit is UNIVERSAL. It constrains how
      ANY of these designs can decide whether to filter a given edge, and
      it is the underlying reason the primary candidate classifies picture
      STRUCTURE instead of relying on what the pixels look like right at the
      edge.

      WHY THIS ONE MATTERS MORE THAN THE OTHERS: the designer's next task
      after this sweep is to derive the mathematics of that structure
      classifier. If the limit really is universal, it is a boundary
      condition on that work - it caps what any threshold can achieve and
      supplies the reason the classifier exists at all. The register
      therefore BLOCKS that next task until this item is resolved.

      WHAT YOU ARE ASKED: is the universality claim correct? Argue it
      yourself from the pixel reasoning above - do not simply agree that it
      sounds right. If you think it is narrower than claimed, say where the
      boundary actually falls.

PR-2  A DESIGN PRINCIPLE HAS QUIETLY TURNED INTO A HISTORICAL FOOTNOTE.

      The principle: you may make the EVIDENCE test stricter before deciding
      to correct a pixel, but once the test passes you correct at FULL
      strength. You do not half-correct.

      Where it now lives: the authority document mentions it only while
      describing what the REJECTED design used to do. It is not in that
      document's list of ideas kept from that design. Since the design is
      rejected, the sentence now reads as history rather than as a rule that
      still binds.

      WHAT YOU ARE ASKED: is this a standing rule for kernel work, or was it
      genuinely specific to the rejected design? If it stands, where should
      it live so a future kernel author cannot miss it?

PR-3  A LIVE RULE IS WRITTEN IN THE VOCABULARY OF A DEAD MECHANISM.

      The charter contains a rule (E3) stating that "midpoint activation"
      reads the CURRENT state of the output at that exact point in the
      processing order, and must not read the original untouched picture.
      The underlying rule is live and load-bearing - it is what makes the
      output depend on the processing order in a defined, repeatable way.
      But "midpoint activation" is part of the rejected design and no longer
      exists.

      The risk: a reader concludes the rule has no trigger any more and
      therefore does not apply. A rule that appears inapplicable stops being
      enforced.

      There is a companion rule (E4) saying the opposite for a different
      situation - a strength map reads the ORIGINAL UNTOUCHED picture in a
      pre-pass. The two are deliberate opposites and must be checked
      together; the new design's classifier is an E4-style reader.

      WHAT YOU ARE ASKED: confirm the underlying rule is still live,
      and comment on whether E3 and E4 remain correctly paired for the
      current design. NOTE: this is charter text. Neither you nor the
      designer edits it. It becomes a proposal to W3X.

PR-4  A DOCUMENT WAS INVISIBLE TO THE ORIGINAL SEARCH.

      The original survey found seventeen documents using one set of search
      terms. Re-running a WIDER set of terms surfaces documents the first
      set could not see - most trivially, but one of them
      (Deblock4_Stage_2C_D2_HolyWu_Real_Schedule_v1_7) is a member of the
      approved Stage 2C document set.

      It was not skipped. It was never on the list, so it could not even be
      skipped deliberately.

      WHAT YOU ARE ASKED: review the search terms in the scope manifest and
      say what ELSE they would still miss. Think about how MPEG-2 material
      can be discussed without using any obvious MPEG-2 word.
```

---

# 8. The five questions - what to answer for each Tier A and Tier C entry

```text
Q-A  Does the quoted source text actually support the conclusion drawn from
     it? Read the quote first and form your own view before reading the
     designer's reason. This is the question that catches a hurried entry.

Q-B  Is the outcome right? If you would have chosen a different one of the
     five outcomes, say which and why.

Q-C  Where the entry says one statement beats another, is that the right way
     round? NEWER DOES NOT AUTOMATICALLY WIN. The older README held good
     engineering that the newer investigation had lost, and one of the four
     items above (PR-2) is a case where the NEWER document made things
     WORSE. If the older statement is better, say so.

Q-D  Is anything missing? Does that document section contain something the
     designer walked past without logging? This is the highest-value thing
     you can find, because a missing entry is invisible in the ledger.

Q-E  Does the entry rely on something you know to be untrue from your own
     knowledge of this project's source, decisions or measurements?

Q-F  IF THE ENTRY HAS A DERIVED FIELD: is the derivation sound, and is it
     doing work it is not entitled to do? Three specific traps, all of which
     have already occurred once:
       - does the derived proposition ALREADY EXIST somewhere the designer
         did not check? In the first ledger the designer declared one section
         the unique home of a principle that another section of the SAME
         document already stated, more generally;
       - is a claim of independence or uniqueness checkable against the
         source or the parameter surface, and was it checked? The designer
         asserted that evidence thresholds and correction strength were
         independent while one shipped control moves both;
       - has anything from DERIVED leaked into DISPOSITION, ASSERTS or
         PREVAILS, where it would be read as a finding about the text?
```

---

# 9. Disagreement is the product

The three-way process is NO-FAULT. Nobody loses anything by being wrong, and
a disagreement is not friction - it is the output W3X is paying for.

```text
- Say plainly when you disagree, and say what would change your mind.
- "I agree" on a Tier A entry is only useful WITH your own reasoning
  attached. Bare agreement tells W3X nothing about whether you checked.
- If you are unsure, say UNSURE and say what would settle it. An honest
  "I do not know" is worth more than a confident guess - a wrong
  adjudication made confidently is worse than an open question, because
  it closes the file.
- Do not soften a finding because the designer's reasoning is coherent.
  Coherent and wrong is the normal case for a careful person working at
  speed.
- You go through W3X, never directly to the designer, and W3X decides.
  A disagreement is not routed around by anyone.
```

---

# 10. What to send back per step

```text
1. A plain-English summary first - three to six sentences. What you
   reviewed, what you found, what worried you.

2. Any decisions or questions for W3X, in ONE section near the TOP,
   numbered Q1, Q2, Q3. Each one self-contained: the question in plain
   words, why it matters, YOUR RECOMMENDATION, the options if there is a
   real choice, and any ID tags LAST on a refs line. If you have none,
   say so in one line - silence is not "no questions".
   (This is the standing coder communication convention, v1_0 or later.
   It applies to everything you send W3X.)

3. Entry-by-entry verdicts. For each: AGREE / DISAGREE / UNSURE / MISSING,
   with your reasoning. Keep the detailed technical argument here - this is
   the part written for the designer and the record.

4. Anything you noticed that was not part of the question.

Deliver it as a zip named for the sub-tranche with the _B_ marker - for
example T1S01a2_B_Coder_Response.zip - so it sorts directly after the package
it answers.
```

---

# 11. What you must not do

```text
- Do not confirm. Being asked to review is not being asked to approve.
- Do not accept a conclusion because the reasoning around it is fluent.
- Do not treat the previous designer's judgement documents as findings.
  Two of the four evidence documents are explicitly positions to test.
- Do not treat a document's LABEL as a fact about its contents. That is
  the exact mistake this whole task exists to correct.
- Do not accept a DERIVED proposition because the entry's findings are
  sound. They are separate claims and they fail separately: an entry can
  quote its source correctly and still reason wrongly from it. Both of the
  first ledger's entries were like that.
- Do not MODIFY source, do not build, do not execute, do not produce a
  delivery package. Reading the source is permitted and, for Tier B,
  expected - see 4.2.3.
- Do not fix the documents. The designer writes; W3X decides and commits.
```

---

# 12. Authority set for this scope

```text
The charter (AI_Charter_and_Invariants_Card, highest committed version)
    PREVAILS over this scope and everything else.
The MPEG-2 authority (Deblock4_MPEG2_Deblocking_Investigation_and_Decided_
    Architecture, v1_05 or later) is the approved single source of truth for
    MPEG-2 and architecture matters. Read its section 0 first.
The task register (Deblock4_Standing_Task_Register_T_Series, v1_3 or later)
    holds the work queue and the decisions behind this task.
The coder communication convention (333_W3X_Coder_Communication_Convention,
    v1_0 or later) binds everything you send W3X.
The outgoing designer's evidence set - two documents record, two judgement.

Current project position, so you are not working from memory: the Classic
filter is complete for its approved integer backends (scalar, SSE4.1, AVX2)
at identity 0.1.0-dev+5C. The Deblock4 filter has NO filtering kernel at all -
every dispatch path is a pass-through copy.

Two candidate architectures remain live. B2 is the ADOPTED PRIMARY CANDIDATE,
and classifies macroblock structure; D is the mandatory detector-free
COMPARATOR AND FALLBACK, and must meet its own separate viability bar rather
than winning by default if B2 fails. NEITHER has passed the Q14 experiment, and
neither has been selected to enter kernel or oracle development. The experiment
that decides between them has not been designed yet.

No Deblock4 kernel scope may be opened, and NO NEW kernel mathematics may be
derived, until Q14 reports and W3X ratifies the architecture allowed to enter
development. T1 itself is explicitly permitted to adjudicate kernel-related
principles that ALREADY EXIST - PR-2 asks exactly that, and the mathematical
inventory running inside T1 catalogues existing mathematics without deriving
any.
```

---

*Revision history*
```text
v1.8 (2026-08-18) Three process-criteria corrections, all found by W3C in its
     review of the first authority-document sub-tranche, all applying to
     criteria that judge W3D's own ledger. Charter I7 provenance: W3C found
     them and drafted the substance, W3D drafted the exact wording, W3C
     verifies, W3X ratifies.
     5.2 ATOMIC-CLAIM RULE: one disposition covers one proposition; a sentence
     whose clauses have different statuses is split or narrowed, never given
     one disposition with the other status preserved in REASON.
     5.3 SWEPT FIELD, now required for any claim of uniqueness, independence
     or unaffectedness, recording what was actually searched. Added after the
     designer made that class of unchecked assertion three times, twice in
     entries where the designer had flagged the risk in the same breath.
     CURRENT-DUPLICATE redefined: it must identify the CANONICAL HOME and say
     which side this copy is on. The old wording told the reader to replace
     "this copy" with a pointer, which is wrong when the copy being
     adjudicated IS the home - a gap W3C hit immediately.
     No tier boundary, disposition VALUE, evidence-supply rule or
     pre-registered item changed.
v1.7 (2026-08-18) Records sub-tranche delivery for steps covering large
     documents (4.0a): each part is separately reviewable and reviewed as it
     lands, so a designer session death costs one part rather than a whole
     document. Added the rule that depends on it - cross-entry consistency
     within a document is checked at the FINAL sub-tranche, which the designer
     must identify as the last, because a reviewer cannot be asked to spot
     contradictions against entries it has not been shown. Naming examples
     updated to the sub-tranche form. No tier boundary, disposition value,
     review question, evidence-supply rule or pre-registered item changed.
v1.6 (2026-08-18) Ledger template corrected after W3C's review of the first
     ledger tranche found it defective, and both of that tranche's entries
     were rejected. The entry is now split into two explicitly labelled
     halves: findings about existing text, where DISPOSITION is exactly one
     of the five registered values and nothing else; and a separate DERIVED /
     DERIVED-BASIS pair for anything the designer reasoned to rather than
     found. Section 5.1 records why, keeping W3C's own statement of the
     danger verbatim. Added review question Q-F covering derived
     propositions, naming the three traps that have already occurred: a
     derived proposition that already exists elsewhere unchecked, an
     unchecked claim of independence or uniqueness, and derived material
     leaking into the findings half. Added a matching entry to the
     what-not-to-do list, since findings and derivations fail separately.
     No tier boundary, disposition value, evidence-supply rule or
     pre-registered item changed.
v1.5 (2026-08-18) Section 12 corrected after W3C's focused re-review (finding
     M1), which was right on both counts. "Neither is chosen" flattened two
     different things: B2's adoption as primary candidate is a ratified
     decision, while passing Q14 is not, and the old wording could be read as
     no decision having been taken about either. Separately, "nothing about
     the kernel may be designed" contradicted this scope's own instructions
     two sections earlier - PR-2 asks W3C whether an existing kernel principle
     still stands, and the mathematical inventory catalogues existing kernel
     mathematics. The constraint is narrower than the old wording: no kernel
     SCOPE and no NEW kernel mathematics before Q14. No review obligation,
     tier, question or pre-registered item changed.
v1.4 (2026-08-18) Two mechanical corrections following W3X's supply
     decisions. The SOURCE tree now travels routinely with the reference
     set rather than only with steps containing Tier-B entries, so Tier-B
     questions are always answerable without a round trip. Added 4.2.0b:
     because the reference set may be re-supplied mid-chat, the coder can
     hold two generations of the same document - the most recent supply
     wins, a lower version arriving later is a defect to report rather
     than resolve, and any difference affecting an entry under review must
     be stated. No review obligation, tier boundary, question or
     pre-registered item changed.
v1.3 (2026-08-18) W3X decisions on the evidence package. The COMPLETE
     dev_documentation corpus is now supplied once at the start of the coder
     chat, replacing the per-step document extracts and the separate file
     inventory of v1.2 - a simpler and cheaper mechanism that discharges the
     same two obligations more completely. Added 4.2.0 (stop and ask if the
     corpus is absent - a missing corpus must fail loudly rather than produce
     a response that merely looks complete) and 4.2.0a (read the step's
     documents in full; the corpus is a reference library, not a reading
     assignment). Recorded that the corpus must be re-supplied if the coder
     chat is ever replaced. The source tree remains a separate supply for
     Tier-B steps, since dev_documentation does not contain source. The
     second coder pass in the closure round is confirmed BOUNDED to disputed
     and changed entries (4.4, unchanged from v1.2 and ratified by W3X).
     No review obligation, tier boundary, question or pre-registered item
     changed.
v1.2 (2026-08-18) Issued after W3C's independent review of v1.1, which found
     that the evidence package could not support several of the review
     obligations the scope assigned. Corrected: the complete swept document
     now travels with every ledger step, because a ledger cannot reveal what
     the designer failed to log (4.2.1); T1S00 receives a complete file
     inventory rather than only the search-derived manifest, because a list
     produced by the search cannot reveal what the search excluded (4.2.2);
     read-only source inspection is stated as permitted and, for Tier B,
     expected (4.2.3, section 11); ALL superseded entries are Tier A, closing
     a category that previously had no tier at all (section 6); the final
     three-way closure round is written down explicitly, with the second
     coder pass bounded to disputed and changed entries (4.4); and the
     charter-hygiene wording in section 1 no longer says a charter rule
     "does not apply" - the PASS restriction is not triggered, not waived.
     The standing pack is trimmed on cost grounds: the authority travels
     every session, the charter only with the step that sweeps it, the
     source tree only with steps containing Tier-B entries.
     No review obligation, tier boundary, question or pre-registered item was
     weakened; two were made dischargeable that previously were not.
v1.1 (2026-08-18) W3X decisions absorbed: the six named steps T1S00-T1S05
     listed explicitly; the step-number-first file naming scheme with _A_ to
     the coder and _B_ back from the coder; what arrives in the first session
     versus later sessions; and a new subsection 4.3 stating that responses
     are reviewed together at the END of the sweep - silence between steps is
     not agreement, and a fault in the METHOD rather than in an entry must be
     escalated at the top of the response rather than buried in a verdict.
     No review obligation, tier, question or pre-registered item changed.
v1.0 (2026-08-18) First issue. Bounded review scope for the T1 consolidation
     sweep: three-tier effort model, five review questions, four
     pre-registered items, batch delivery, no source work of any kind.
```
