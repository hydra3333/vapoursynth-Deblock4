# Deblock4 - URGENT KNOWLEDGE CAPTURE REQUEST TO W3C

**Deliverable:** T1S01a5_A - W3C KNOWLEDGE CAPTURE REQUEST
**Version:** 1.0
**Date:** 2026-08-19
**Author:** W3D (successor session)
**Route:** W3D -> W3X -> W3C
**Nature:** NOT A REVIEW. Not a scope. No source, build, test, patch or git.
**Encoding:** US-ASCII; CRLF.

---

# 0. READ THIS FIRST - WHY THIS IS URGENT AND WHAT IT IS NOT

```text
YOU ARE THE SAME W3C SESSION THAT HAS WORKED a5 FOR FOUR ROUNDS: the Tier C
sample review, the re-sweep cross-check, the classification repair response,
and the emergency reconstruction of ledger v1.4. W3X reports that session is
still alive and may not be for much longer.

THIS PROJECT HAS ALREADY LOST ONE SESSION MID-TASK. When the W3D designer
session hit its context limit, the delivered artifacts survived and everything
else did not. The recovery took four rounds and turned up a further defect at
every one of them.

WHAT SURVIVED WAS STATE. WHAT DIED WAS REASONING.

That is the whole lesson of this recovery, and it applies to you now. Your
CONCLUSIONS are safe - they are in four delivered documents. Your JUDGEMENTS
are not. Nothing records why you classified a borderline hit the way you did,
what you noticed and set aside as out of scope, or what you would warn a
successor about.

THIS REQUEST EXISTS TO CAPTURE THAT BEFORE IT IS GONE.

WHAT THIS IS NOT:
    - not a review, and it changes no verdict you have given;
    - not a request to redo, re-search or re-classify anything;
    - not a scope, and it asks for no code, build, test or git operation;
    - not a criticism. Your reconstruction of ledger v1.4 was the right call
      with the information you had, and you reported it as lossy yourself.
      That self-report is why the rebuilt ledger is clean.

THERE ARE NO WRONG ANSWERS HERE. "I have no undocumented reasoning on that"
is a complete and useful answer. An honest blank is worth more than a
reconstructed rationale.
```

---

# 1. HOW TO ANSWER, AND WHY THE ORDER MATTERS

```text
ANSWER IN THE ORDER GIVEN, AND EMIT EACH ANSWER AS YOU FINISH IT.

The questions are ordered BY VALUE IF YOU ARE INTERRUPTED, not by topic. Q1 is
the single most valuable thing you can give this project; Q7 is the least. If
the session ends after Q2, we will have the two things that matter most.

CHARTER C-DELIV-09 APPLIES AND IS THE REASON FOR THIS INSTRUCTION: emit
complete answers incrementally rather than holding a finished package. ONLY
EMITTED WORK SURVIVES AN INTERRUPTION. Do not save anything for a summary at
the end, do not promise a consolidated version, and do not hold Q1 back while
polishing Q4.

Mark each one "capture N of 7: <topic>".

BREVITY IS NOT A VIRTUE HERE. This is the one document in the project where
length costs nothing and omission costs everything. If you are unsure whether
something is worth recording, RECORD IT.
```

---

# 2. THE QUESTIONS

## Q1 - WHAT DID YOU NOTICE AND NOT REPORT?

```text
Across four rounds on a5 you read the authority's sections 1-8, the whole
46-file search population, three ledger generations and the T1 process set.

WHAT DID YOU SEE THAT NEVER MADE IT INTO A FINDING?

Specifically, and each is its own answer:
  (a) things that were OUT OF SCOPE at the time - a defect in a document you
      were not reviewing, a problem in a sub-tranche not yours, something in
      sections 9-13 or in the appendices;
  (b) things you were UNSURE ENOUGH about not to raise, and why;
  (c) things you assumed someone else had already caught;
  (d) anything that looked wrong but that you could not evidence well enough
      to report under the review scope's standards.

THIS IS Q1 BECAUSE IT IS THE ONLY CATEGORY THAT IS UNRECOVERABLE. Everything
you did report is in a document. Everything you did not report exists only in
this session.
```

## Q2 - WHAT DID LEDGER v1.4 CARRY THAT NO DELIVERED ARTIFACT DOES?

```text
W3X ruled v1.4 out as a source and the successor W3D rebuilt from delivered
ledger v1.3 instead. That was the right call for provenance. But it means ANY
ORIGINAL ANALYSIS OF YOURS THAT WENT INTO v1.4 HAS BEEN DISCARDED.

  (a) Did any compression in v1.4 encode a DELIBERATE JUDGEMENT rather than
      mere abbreviation? If you shortened a field because you thought the
      original was wrong, overstated or unsupported, SAY WHICH AND WHY. The
      rebuild treated every unmandated deletion as collateral damage and
      restored it. If any was actually a considered correction, it has just
      been silently reversed.
  (b) Did you add anything to v1.4 that was NOT in v1.3 and NOT mandated by
      the repair or your own review - your own observation, entered because
      it seemed right? Name it. The rebuild would have excluded it by rule.
  (c) Is there anything in v1.4 you would defend against the rebuilt v1.6?
      This is an invitation, not a trap: a genuine disagreement here is a
      finding.
```

## Q3 - THE MIXED LABEL, AND INTRA-FILE DUPLICATION

```text
THE OBSERVATION, offered so you can attack it rather than confirm it.

MIXED is defined in the classification repair as "one file carries more than
one meaning". LED-049 uses it that way: Grid Knowledge carries the MediaInfo
triage route AND a separate general statement about measuring files - two
different propositions.

LED-053d appears to use it for something else. Its note reads "section 4.5 is
the copy adjudicated; APPENDIX A OF THE SAME FILE is a second carrier and does
not appear as a separate hit". That is ONE proposition stated TWICE in two
places, not two meanings.

  (a) Is that reading right, or is there a distinction W3D has missed?
  (b) If it is right - was the vocabulary being stretched knowingly, because
      no better label existed, or was it not noticed at the time?
  (c) THE LARGER QUESTION: the probe machinery classifies FILES, one label per
      file. When one document is split across sub-tranches, a same-file second
      carrier in another sub-tranche's territory is structurally invisible to
      a file-level count. a5 met this once. T1S01a6 holds Appendix A, section
      24 and the D4 registers - all of which restate body propositions - so it
      will meet it repeatedly. DOES THE EVIDENCE FORMAT NEED SOMETHING FOR
      THIS BEFORE a6 RUNS?
  (d) Q-K in ledger v1.6 asks the narrow version: is citing Appendix A as
      evidence WITHOUT adjudicating it the right handling? W3D has no position
      and both alternatives have a recorded failure attached - adjudicating
      out-of-range text is the DEC-56 overlap defect, and citing without
      adjudicating leaves a6 free to reach an inconsistent conclusion.
```

## Q4 - WHAT SHOULD T1S01a5b EXPECT?

```text
a5b covers authority sections 9-13, lines 716-1098 - the ARCHITECTURE half:
the options and re-decision, B2 topology mathematics, Architecture D, the
Architecture A rejection proof, and scheduler/kernel separation. It also
carries the DEC-24 re-derivation of the 12.5/13.1 pointer remedy.

YOU HAVE ALREADY READ THAT MATERIAL - it was in the corpus for every search
you ran.

  (a) What is in sections 9-13 that will be HARDER than sections 1-8, and why?
  (b) Are there propositions there that you already suspect are duplicated,
      conflicting or unsupported?
  (c) The a5 evidence half was mostly CURRENT-UNIQUE and CURRENT-DUPLICATE -
      38 of 39 entries are Tier C. Do you expect the architecture half to
      produce CONFLICTING or SUPERSEDED entries, which are Tier A and need
      full review?
  (d) Anything a5b should NOT repeat from a5's method.
```

## Q5 - WHAT WOULD YOU TELL A FRESH W3C SESSION?

```text
Assume you are replaced tomorrow by a memoryless successor holding only the
batch. WHAT DOES IT NEED TO KNOW THAT THE DOCUMENTS DO NOT SAY?

  (a) Where the review scope's five questions work well, and where they are
      awkward to apply.
  (b) Which classification calls in the repair were genuinely borderline. The
      tables record the outcome, never the confidence. A successor cannot tell
      a call you were certain of from one that could have gone either way, and
      that distinction is worth more than the labels.
  (c) What you would check FIRST if handed a new T1 ledger cold.
  (d) Any habit or shortcut you developed that is not written down anywhere.
```

## Q6 - THE PROCESS RULES, FROM THE PARTY THEY CONSTRAIN

```text
Rounds on a5 produced DEC-60 through DEC-69, and several arrived
W3D-proposed and left W3C-improved.

  (a) Is any of those rules WORSE IN PRACTICE than it looked on paper?
  (b) Is any of them being followed in form while missing its purpose?
  (c) DEC-64's SUPERSEDED-KIND / PROPAGATION field is ratified subject to your
      wording verification and IS NOT YET BINDING. a5 has no SUPERSEDED
      entries so it cost nothing to defer - but the first real ERRONEOUS case
      is the README's rejected architecture at T3, where getting it wrong
      costs most. Is the wording right, and should it bind before T3?
```

## Q7 - ANYTHING ELSE

```text
Open field. Anything you would regret this project not knowing.
```

---

# 3. DECISIONS/QUESTIONS FOR W3X

```text
None. This request asks W3C for knowledge, not W3X for a decision.

Nothing in any answer becomes project knowledge by being answered. Every
response is EVIDENCE. Where an answer contains something durable, W3D will
propose it into the correct authority with a version bump, and W3X ratifies -
the ordinary route. An answer left sitting in this document, or in the T1/
tree, is invisible to every future sweep under DEC-63.
```

---

*End of knowledge capture request. Nothing here is ratified, no verdict is
reopened, and no artifact is superseded by it.*
