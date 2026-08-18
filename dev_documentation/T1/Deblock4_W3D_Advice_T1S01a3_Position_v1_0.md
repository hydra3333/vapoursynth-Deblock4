# Deblock4 - Outgoing W3D Advice to Successor Designer: the T1S01a3 Position

**Deliverable:** W3D-HANDOVER-ADVICE-T1S01a3
**Version:** 1.0
**Date:** 2026-08-18
**Author:** outgoing W3D (designer chat 4)
**Route:** W3D -> W3X -> successor W3D
**Nature:** ADVICE and RECORD. It decides nothing. W3X decides; the successor
designer is not bound by any judgement here that it can check for itself - and
should check.
**Encoding:** US-ASCII; CRLF.

---

# 0. THE SHORT ANSWER

```text
T1S01a3 IS NOT FINISHED, AND IT IS NOT WAITING ON W3C.

State:  ledger v1.1 exists. It has NOT been sent to W3C. No covering note at
        v1.1 exists. The only W3C response reviews v1.0.

Owed:   1. correct the ledger's closing section  -> issue as v1.2
        2. write the v1.1/v1.2 covering note
        3. hand both to W3X for issue to W3C
        4. THEN T1S01a4

Do NOT start T1S01a4 first. The a3 corrections are small, and leaving a
half-finished sub-tranche behind while starting the next one is how a
successor two chats from now inherits an unclear position.
```

---

# 1. What the W3C response to T1S01a3 v1.0 actually found

You have the response file. This section exists so you know which parts are
already discharged and which are not, because reading it cold would suggest far
more outstanding work than there is.

## Already fixed in ledger v1.1 - do not redo these

```text
THE METHOD DEFECT (W3C Q1). v1.0 proposed a duplicate-handling exception,
    wrote that it must not be applied retroactively, and had ALREADY APPLIED
    IT in seven entries' PREVAILS fields saying "THIS COPY STAYS as summary".
    FIXED: all seven now carry DUPLICATE-ACTION: RETAIN-SUMMARY, resting on
    the rule ratified at review scope v1.9 section 5.4 and recorded at task
    register DEC-36.

CLAIM COVERAGE (W3C Q2). Three entries compressed away material propositions.
    FIXED: LED-013 now carries item 2's D4-Q16 token deferral, the
    retirement-in-principle and the TFF/BFF rule, plus item 5's plane-relative
    chroma consequence; LED-015 carries item 11's span descriptor contents and
    the no-fake-pitch2/parity rule; LED-019 carries all twelve of item 17's
    open items, where v1.0 had dropped the last six.

CANONICAL HOMES (W3C Q2). v1.0 named "the register and the body sections"
    generically. FIXED: every CURRENT-DUPLICATE entry now maps a home PER
    PROPOSITION. LED-017 additionally separates the Architecture A rejection
    DECISION (section 12) from its PROOF (Appendix C), which was W3C's point.

DISPOSITIONS (W3C Q3). LED-020 and LED-021 were CURRENT-UNIQUE on the strength
    of a "declare versus refer" distinction the designer invented and which is
    not in the definitions. FIXED: both are CURRENT-DUPLICATE with the
    authority header as canonical home. LED-021's SWEPT is marked INADEQUATE
    AND WITHDRAWN rather than quietly replaced - it had searched a superseded
    Project Status generation and skipped the orientation documents entirely.

LED-023 (W3C Q4). v1.0 proposed CURRENT-UNIQUE while admitting the claim's
    truth was unverified. FIXED: disposition WITHDRAWN, deferred to T1S01a5.
    No sixth disposition was invented.

TWO CLERICAL ERRORS. A pointer to a non-existent "LED-025", and "ten entries"
    where seven are CURRENT-DUPLICATE. FIXED, with the originals quoted rather
    than erased.

ROUTING (W3C Q5). DEC-32 said the section 23 ordering defect went to T1S01a3
    while DEC-35 said T1S01a4. FIXED at register v1.12 and Project Status
    v1.31. The route is T1S01a4.
```

## Outstanding - this is your work

```text
THE CLOSING SECTION IS STALE. The reissue rewrote the entries and the header
and left "What W3C is asked here" as it stood in v1.0. It still asks W3C:

    - whether LED-023's blanket provenance claim should stay CURRENT-UNIQUE,
      when LED-023 in the SAME document has already withdrawn that;
    - whether the designed-versus-incidental distinction is needed, calling it
      "the substance of this sub-tranche", when LED-024 records the proposal
      as CLOSED and W3C's replacement rule as ratified and binding.

As it stands the document invites the independent reviewer to REOPEN two
decisions W3X has already ratified. A reviewer answering in good faith would
produce findings that contradict a ratification, and someone then has to work
out that the reviewer answered a stale question rather than disagreeing.

FIX IT BEFORE ISSUE, as a3 v1.2, CLOSING SECTION ONLY. Say in the revision
history that no entry changed from v1.1, so W3C knows it need not re-review
them.
```

---

# 2. What the corrected closing section should ask

The point of that section is to aim the reviewer at the parts most likely to be
wrong. For v1.2 those are:

```text
1. THE SEVEN RETAIN-SUMMARY CLAIMS. This is the first use of a newly ratified
   rule, and RETAIN-SUMMARY is the easier answer - it will be reached for where
   POINTER is correct. For each: is the copy really INSIDE the canonical
   authority, is its summary function really DECLARED, and does it really add
   NOTHING NORMATIVE? A retained copy that quietly adds a qualifier its source
   lacks is not a summary.

2. THE PER-PROPOSITION CANONICAL HOMES. New in v1.1 and produced quickly. If a
   home is wrong, W3C should name the document or section that should own it.

3. IS THE EXPANDED COVERAGE NOW COMPLETE? Especially LED-019's twelve open
   items and LED-015's descriptor contents - the two worst omissions in v1.0.
   The coverage declaration at section 0 is the thing to check first, because
   coverage is what failed twice.

4. LED-020 AND LED-021 CHANGED DISPOSITION. Is CURRENT-DUPLICATE with the
   authority header as canonical home right, or does one belong elsewhere?
```

Drop the two settled questions entirely. Do not replace them with softened
versions - a settled question asked gently is still a settled question asked.

---

# 3. What the covering note must carry

W3C is memoryless and receives the reissue cold. Four things it cannot work out
for itself:

```text
1. THAT ITS OWN FINDINGS DROVE THE REISSUE. Eleven of the twelve corrections
   came from its response. Say so plainly. It is the difference between a
   reviewer checking a document and a reviewer checking whether it was heard.

2. THAT ITS WORDING WAS ADOPTED OVER THE DESIGNER'S. W3C rejected the
   DESIGNED/INCIDENTAL axis - correctly, since a stale duplicate can also be
   deliberately designed, so authorial intent is the wrong test. What matters
   is whether the copy has an APPROVED CONTINUING ROLE. W3X ratified W3C's
   narrower RETAIN-SUMMARY wording. W3C last saw this as a proposal it had
   rejected; tell it the outcome, or it will review entries against a rule it
   believes was refused.

3. THAT NO ENTRY CHANGED BETWEEN v1.1 AND v1.2. Only the closing section moved.

4. WHAT TO ATTACK - the four items in section 2 above.
```

Standing reminders the note should repeat, because they have each been needed:
the corpus and source tree must be in front of W3C before it reviews anything;
silence between sub-tranches is not agreement; a METHOD problem goes at the TOP
of the response.

---

# 4. Then, and only then, T1S01a4

```text
THE DEFECT (task register DEC-32), which is real and sits in the ratified
authority itself:

    section 23 step 8 -> BUILD the independent ReleaseSafe scalar oracle
    section 23 step 9 -> PERFORM the Schedule-SA/SB quality decision and
                         freeze the canonical scalar algorithm
    BUT authority line 1153 -> "The winner becomes part of the future
                         Deblock4 scalar oracle."

So the document specifies building an artifact BEFORE the decision that defines
one of its constituent properties. The Verification and Tiering record
independently requires the schedule as an obligation of the oracle-construction
scope.

A SECOND WARNING IN THE SAME TAIL, from W3C: step 7 says to FREEZE thresholds
before the later quality-decision step, while the authority's own open-items
list still has final threshold and strength behaviour UNRESOLVED.

THE REPAIR IS NOT ESTABLISHED AND MUST BE DERIVED, NOT GUESSED. W3C
deliberately declined to propose swapping steps 8 and 9, because scalar
candidate implementations may be needed in order to COMPARE schedules in the
first place. What IS established is narrower: the canonical schedule and
quality decisions that define the accepted algorithm must be settled before the
final accepted scalar oracle can serve as the reference for later backends.

WHAT THE DERIVATION MUST SWEEP: authority sections 14.4 and 21, Appendix D,
and Verification and Tiering Decisions section 20.2. RECORD THE SWEEP in the
SWEPT field. This is exactly the class of claim that has now gone wrong five
times.
```

---

# 5. The failure pattern, stated as a prediction rather than history

You will read task register DEC-37 and see four instances recorded. There are
now more, and the later ones are the instructive part because they happened
AFTER the countermeasures were adopted.

```text
1. claimed a section was the UNIQUE home of a principle
      -> section 13.1 of the SAME document already stated it;
2. claimed two design decisions were INDEPENDENT
      -> the shipped `boundary_strength_offset` moves both;
3. claimed a list's tail was UNAFFECTED by a reordering
      -> line 1153 of the same document contradicts the order;
4. proposed a rule, wrote that it must not be applied yet, and had already
      applied it seven times;
5. reissued a ledger and left its closing section arguing the pre-reissue
      position;
6. fixed two stale sections of the designer introduction and left a third,
      having personally written the line "the defect is rarely alone" into the
      handover in between.

THE SWEPT FIELD WAS ADDED AFTER 1-3 AND WOULD NOT HAVE CAUGHT 4, 5 OR 6. Those
are not failures to search. They are the same underlying thing in different
clothes: FIXING OR ASSERTING WHAT IS IN FRONT OF YOU AND NOT SWEEPING THE
ARTIFACT.

WHAT ACTUALLY CAUGHT ALL SIX: an independent party reading the whole document
rather than the part under discussion. W3C caught 1-4. You caught 5 and 6.
Not one was caught by the author, and not one was prevented by a rule.

EXPECT TO COMMIT THIS CLASS OF ERROR YOURSELF. The useful defence is not more
care - it is finishing an edit by sweeping the whole file, and treating "I
found one" as a reason to keep looking rather than to close the item.
```

---

# 6. Two small things worth knowing

```text
LED-022 IS THE ONLY ENTRY W3C AGREED WITH OUTRIGHT in T1S01a3 v1.0 - the
provenance-tag discipline being defined only in the authority header. It is
unchanged in v1.1 and needs nothing.

THE MPEG-2 AUTHORITY IS STILL v1.05 AND DELIBERATELY SO. Every ledger remedy
across every sub-tranche is a PROPOSAL. Nothing has been applied to it. If you
ever see a higher generation, stop and ask W3X what was ratified.
```

---

*Revision history*
```text
v1.0 (2026-08-18) Written at W3X's request because the successor designer had
     the T1S01a3 material but not the assessment of what in the W3C response
     was already discharged and what was still owed. States the position, the
     two outstanding items, what the corrected closing section should ask, what
     the covering note must carry, and what T1S01a4 then requires. Records the
     failure pattern at six instances rather than four, with the observation
     that instances four to six post-date the countermeasures and would not
     have been caught by them.
```
