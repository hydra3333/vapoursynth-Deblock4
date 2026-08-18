# Deblock4 - T1S01a2 Ledger: the Authority Document's Currency Statements

**Deliverable:** T1S01a2_A - LEDGER
**Version:** 1.1 - REISSUED after W3C review found a coverage defect
**Date:** 2026-08-18
**Author:** W3D
**Route:** W3D -> W3X -> W3C
**Step:** T1S01a, sub-tranche 2
**Document adjudicated:** `Deblock4_MPEG2_Deblocking_Investigation_and_Decided_Architecture_v1_05.md`
**Template:** review scope v1.8 - atomic claims, SWEPT field, corrected
CURRENT-DUPLICATE.
**Search frame:** the frozen 90-term set, manifest v1.4.

**THIS IS NOT THE FINAL SUB-TRANCHE OF THIS DOCUMENT.**

**Status:** PROPOSED ADJUDICATIONS. Nothing here is decided.
**Encoding:** US-ASCII; CRLF.

---

# 0. WHAT THIS SUB-TRANCHE COVERS - corrected, and why the correction matters

## 0.1 The defect being corrected

v1.0 of this ledger declared that it adjudicated four whole ranges - the
document header, all of section 0, all of section 23 and Appendix E - and then
logged six entries covering only the CURRENCY statements inside them. Section
0's seventeen numbered architecture items were not ledgered. Most of Appendix E
was not ledgered. Section 23's stable tail was reasoned about but not ledgered.

W3C found it and called it a method blocker. It is one, and the reason is worth
stating precisely rather than as an apology:

```text
T1's completion test is that EVERY MPEG-2-bearing statement has a recorded
disposition. If a sub-tranche may declare a range adjudicated while logging a
SELECTION from it, then the finished ledger proves nothing - it shows what was
logged, and silently reports the rest as swept. That is indistinguishable, from
the outside, from a thorough sweep. It is the "looks complete" failure the
whole ledger discipline exists to make impossible.
```

## 0.2 What this sub-tranche ACTUALLY adjudicates

Narrowed to what is genuinely covered:

```text
IN SCOPE HERE - the CURRENCY AND SEQUENCING statements only:
    header      the supersession / de-duplication paragraph (lines 25-31)
    section 0   the "STATUS AT" date-stamp and the "next substantive
                artifact" sentence (lines 51-57)
    section 23  the opening paused-T1 paragraph (1679-1681); the numbered
                development sequence (1683-1701); the 2D/3D/4D/5D shorthand
                and prerequisite statement (1703-1710)
    Appendix E  the v1.05 revision entry
```

## 0.3 What is NOT covered, and where it goes

Every omitted statement is assigned, not left implicit:

```text
DEFERRED TO T1S01a3 - "the architecture summary":
    section 0's seventeen numbered architecture/current-position items -
    whole-frame input, the three source modes, chroma organisation,
    per-macroblock luma DCT geometry, vertical-edge invariance, no hidden
    temporal state, Deblock4's own proof chain, B2 topology, Architecture D,
    rejected A and C, the Q14 gate, and the open kernel/quality/API items.
    THESE ARE THE HEART OF THE DOCUMENT and deserve a sub-tranche of their
    own rather than a footnote in a currency pass.

DEFERRED TO T1S01a3 - the header's remaining statements:
    the ratified-status declaration, the single-source boundary rule, and the
    provenance-tag discipline (H.262-VERIFIED / SPEC-VERIFIED / SOURCE-
    VERIFIED / MEASURED / DERIVED / PENDING / W3X-RATIFIED).

DEFERRED TO THE FINAL SUB-TRANCHE OF THIS DOCUMENT:
    Appendix E entries v1.04 down to v1.00. They carry MPEG-2-bearing
    historical statements - the architecture re-decision, LG regime evidence,
    H.262 provenance, 4:2:2/4:4:4 chroma, Schedule-SA/SB naming, Q14 held-out
    discipline. W3C is right that historical does not mean out of scope;
    LED-007 below is itself proof that a historical statement still needs an
    accurate disposition. They are deferred to last because their correct
    disposition depends on how the live sections they describe are
    adjudicated.
```

---

# LED-003  Section 23 - T1 described as PAUSED

```text
DOCUMENT     authority v1.05, section 23, lines 1679-1681
CLAIM        "W3X has PAUSED T1 while the Q14 work is set up"
ASSERTS      that the consolidation sweep is not running and Q14 preparation
             proceeds ahead of it.
CLASS        W3X-RATIFIED (as at 2026-08-16)
DISPOSITION  CONFLICTING
REASON       True when written, false now. W3X reversed the sequence on
             2026-08-17 (DEC-02).
CONFLICTS    Standing Task Register DEC-02.
PREVAILS     THE TASK REGISTER, on this statement. The authority prevails on
             MPEG-2 architecture; the work queue is the register's domain and
             the register carries a later ratified decision. The newer
             document wins because it is the RIGHT AUTHORITY for the subject
             and later - not merely because it is newer.
```

**PROPOSED ACTION.** Replace the paragraph with a pointer to the register.

**W3C's qualification is adopted:** the same paragraph also says the sequencing
change "does not reopen or weaken this authority." That statement is CURRENT
and is an authority-boundary point worth keeping. It must not be deleted by a
wholesale replacement. Recorded as its own entry at LED-009 rather than as a
note here, per the atomic-claim rule.

```text
TIER     A
VERDICT  [W3C]
```

---

# LED-004  Section 23 - the numbered sequence, HEAD ONLY

```text
DOCUMENT     authority v1.05, section 23, steps 1-5 (lines 1683-1694)
CLAIM        the ordered head placing T5 first and "Resume/complete T1-T3
             documentation consolidation at W3X's chosen point" at step 5.
ASSERTS      that detector mathematics precedes the documentation sweep.
CLASS        W3X-RATIFIED (as at 2026-08-16)
DISPOSITION  CONFLICTING
REASON       Inverted against the current ratified order. More dangerous than
             the prose at LED-003 because a reader seeking "what happens next"
             reads a numbered list first.
CONFLICTS    Standing Task Register DEC-02.
PREVAILS     THE TASK REGISTER.
```

**PROPOSED ACTION, CORRECTED.** Replace the mutable head with a POINTER to the
Standing Task Register. **Do NOT write "T1-T3 first".**

W3C is right and this was a real error: DEC-02 establishes T1 before T5. It
does **not** establish where T2 and T3 sit relative to T5, T6 and Q14 once T1
completes. My v1.0 remedy would have created a development-order decision while
claiming only to reconcile stale wording - the exact thing I warned against in
the same document. If W3X wants T2 and T3 before T5, that needs its own
decision first.

```text
TIER     A
VERDICT  [W3C]
```

---

# LED-005  Section 23 step 1 - the coordinated T5+T6 packaging permission

```text
DOCUMENT     authority v1.05, section 23, step 1, lines 1684-1685
CLAIM        "T5 may be the first frozen part of one coordinated T5+T6 design
             package"
             (CLAIM NARROWED to the packaging permission alone, per the
             atomic-claim rule. The rest of the sentence is LED-006.)
ASSERTS      that a single combined T5+T6 deliverable is permitted.
CLASS        W3X-RATIFIED (as at 2026-08-16)
DISPOSITION  SUPERSEDED
REASON       W3X decided on 2026-08-17 that T5 is issued and ratified ALONE,
             with T6 following separately (DEC-03), so that "the detector
             mathematics were fixed before anyone saw held-out results" is a
             matter of record rather than of internal document structure.
CONFLICTS    Standing Task Register DEC-03.
PREVAILS     THE TASK REGISTER.
```

```text
TIER     A (all SUPERSEDED entries are Tier A)
VERDICT  [W3C]
```

---

# LED-006  Section 23 step 1 - the freeze-before-judgement requirement

```text
DOCUMENT     authority v1.05, section 23, step 1, line 1686
CLAIM        "it must be fixed before held-out experiment judgement"
ASSERTS      the anti-tuning discipline: the detector mathematics are frozen
             before held-out results are examined.
CLASS        W3X-RATIFIED
DISPOSITION  CURRENT-DUPLICATE
REASON       Current and binding. It is NOT superseded - only the packaging
             permission it shared a sentence with was withdrawn. It also
             appears in the Standing Task Register (DEC-03) and in section 15
             of this document.
CONFLICTS    none.
PREVAILS     CANONICAL HOME: this authority document, section 15, where the
             Q14 experiment integrity discipline is specified. THIS COPY (in
             section 23) is NOT the canonical home and becomes a pointer.
             The register's copy is a work-queue restatement and is properly a
             pointer too.
```

**Split out from LED-005 per the atomic-claim rule.** In v1.0 these two
propositions shared one SUPERSEDED disposition with this one's survival noted
only in prose - a second, unrecorded disposition hiding in REASON.

```text
TIER     C (CURRENT-DUPLICATE)
VERDICT  [W3C]
```

---

# LED-007  Section 0 - the "next substantive artifact" claim

```text
DOCUMENT     authority v1.05, section 0, lines 55-57
CLAIM        "The next substantive artifact is the D4-Q14 architecture-
             discriminator EXPERIMENT"
             (CLAIM NARROWED to the positive next-work claim. The contrasting
             prohibition is LED-008.)
ASSERTS      that the Q14 experiment is the immediately following work.
CLASS        W3X-RATIFIED (as at 2026-08-16)
DISPOSITION  CONFLICTING
REASON       The next artifact is now T1, then T5, then T6, then the
             experiment. This sits in the section every orientation document
             in the project directs a successor to read FIRST.
CONFLICTS    Standing Task Register DEC-02; Project Status v1.29 section 0.
PREVAILS     THE TASK REGISTER on what IS next.
```

**PROPOSED ACTION.** Replace with a pointer; also consider whether a
date-stamped `STATUS AT` block belongs in an architecture authority at all -
see the derived note at LED-011.

```text
TIER     A
VERDICT  [W3C]
```

---

# LED-008  Section 0 - the no-filtering-implementation prohibition

```text
DOCUMENT     authority v1.05, section 0, lines 53-57
CLAIM        "No Deblock4 filtering mathematics is implemented [...] No D4
             pixel-kernel scope is open [...] not a filtering implementation."
ASSERTS      that no kernel work is open or permitted at this point.
CLASS        W3X-RATIFIED
DISPOSITION  CURRENT-DUPLICATE
REASON       Fully current, and squarely in this document's own domain - it is
             an architecture-gating statement, not a work-queue statement. It
             also appears in Project Status, both chat introductions, both
             blurbs and the concise summary.
CONFLICTS    none.
PREVAILS     CANONICAL HOME: THIS DOCUMENT. The prohibition derives from the
             Q14 architecture gate, which this authority owns. This copy
             STAYS; the copies in the orientation documents are legitimate
             operational restatements for readers who will not open the
             authority, and T3 decides whether they become pointers.
```

**Split out from LED-007 per the atomic-claim rule.**

```text
TIER     C
VERDICT  [W3C]
```

---

# LED-009  Section 23 - the authority-stability statement

```text
DOCUMENT     authority v1.05, section 23, line 1681
CLAIM        "that sequencing choice does not reopen or weaken this
             authority"
ASSERTS      that changing the work-queue order leaves the ratified MPEG-2
             architecture untouched.
CLASS        W3X-RATIFIED
DISPOSITION  CURRENT-UNIQUE
REASON       Current, and correct in a way that has since been exercised: the
             sequence HAS been reversed and the architecture was indeed not
             reopened. It states the domain boundary between this authority
             and the work queue, which is exactly what makes LED-003 and
             LED-004 resolvable.
CONFLICTS    none.
PREVAILS     n/a.
SWEPT        To establish uniqueness: searched this document for
             "reopen", "weaken", "authority" and "sequencing" (all within the
             frozen frame's groups 5 and 8); searched the Standing Task
             Register v1.9 and Project Status v1.29 for an equivalent
             domain-boundary statement. The register states domain separation
             operationally in DEC-02's reasoning but does not state this
             general principle. Found nowhere else.
```

**Raised because W3C flagged it.** My v1.0 proposed replacing the whole
paragraph, which would have deleted this sentence as collateral. W3C caught it.

```text
TIER     C
VERDICT  [W3C]
```

---

# LED-010  Section 23 - the 2D/3D/4D/5D shorthand and prerequisite statement

```text
DOCUMENT     authority v1.05, section 23, lines 1703-1710
CLAIM        the 2D/3D/4D/5D stage shorthand, followed by "Q14 and the
             architecture/API reconciliation are now prerequisites before 2D's
             pixel mathematics can be responsibly scoped."
ASSERTS      a stage naming scheme, and that Q14 plus the API reconciliation
             gate stage 2D.
CLASS        W3X-RATIFIED
DISPOSITION  CURRENT-DUPLICATE
REASON       The prerequisite statement is current and correct. The shorthand
             is a naming convention also carried in the Forward Roadmap and
             the concise summary.
CONFLICTS    none directly. NOTE for the final sub-tranche: the roadmap's
             version of the 2D line still describes it as "schedules A/B,
             midpoint, proper chroma" - naming the REJECTED midpoint
             machinery. That is a roadmap defect already registered under
             T1-KNOWN, not a defect here.
PREVAILS     CANONICAL HOME: this document for the PREREQUISITE statement,
             since Q14 gating is its domain. The stage-name shorthand's home
             is the Forward Roadmap once T1 repairs it. This copy of the
             shorthand becomes a pointer; the prerequisite statement stays.
```

```text
TIER     C
VERDICT  [W3C]
```

---

# LED-011  Header - the supersession and de-duplication paragraph

```text
DOCUMENT     authority v1.05, header block, lines 25-31
CLAIM        this document supersedes the Grid Knowledge document; MPEG-2
             content in the README, concise summary, roadmap,
             status/orientation files and Stage-1C parameter descriptions
             "should then be reduced to references to this document".
ASSERTS      a supersession, and the de-duplication work T3 performs.
CLASS        W3X-RATIFIED
DISPOSITION  CURRENT-DUPLICATE
REASON       CORRECTED FROM v1.0, WHERE I MARKED THIS CURRENT-UNIQUE. It is
             not unique. The Grid Knowledge supersession also appears in
             Project Status v1.29 and in the register's T2 description; the
             de-duplication instruction also appears in the register's T3
             description. W3C found this and it is what exposed the
             CURRENT-DUPLICATE canonical-home gap now fixed in scope v1.8.
CONFLICTS    none.
PREVAILS     CANONICAL HOME: THIS DOCUMENT for the MPEG-2 supersession - a
             document declaring what it supersedes belongs in that document.
             The register's T2/T3 entries are work-queue restatements and
             stay as such; they are instructions to DO something, not
             duplicate knowledge.
             STILL OWED, NOT DISCHARGED: neither the concise summary nor the
             roadmap has been reduced to pointers. Corrective treatment
             (summary v1.4, roadmap v1.21 banner) is not the same as the
             de-duplication this sentence specifies. T3 still owes it.
```

## WHAT THE DESIGNER INFERRED

```text
DERIVED        Section 23 is work-queue content living inside an architecture
               authority, and that structural mismatch generated most of the
               currency findings in this sub-tranche. Section 0 is DIFFERENT
               and NARROWER: only its short date-stamped status opening and
               its next-work sentence are mutable project state. The rest of
               section 0 - the seventeen numbered architecture items - is
               exactly where it belongs.

DERIVED-BASIS  Every conflicting statement in this sub-tranche is a sequencing
               or status claim; none is an MPEG-2 claim. The document's own
               single-source rule already draws the line, saying non-MPEG-2
               project rules "remain in their existing authorities and are
               referenced rather than duplicated here."
               CORRECTED FROM v1.0: I wrote that "sections 0 and 23 are
               work-queue content". W3C is right that this over-generalised
               from section 0's header to the whole of section 0, which is
               overwhelmingly the read-first architecture summary. The
               narrower claim above is what the evidence supports.
               ALSO CORRECTED: v1.0 said "four conflicts". Three entries were
               CONFLICTING and one SUPERSEDED. The correct collective term is
               "stale status and sequence findings" - the disposition words
               have strict meanings and must not be used loosely even in
               prose.
               LIMIT: still a structural proposal, and W3D still recommends
               NOT acting on it until the document is fully swept.
```

```text
TIER     A (carries a derived proposition)
VERDICT  [W3C]
```

---

# LED-012  Appendix E - the v1.05 revision entry

```text
DOCUMENT     authority v1.05, Appendix E, v1.05 entry
CLAIM        "reconciles section 23 to the current W3X sequencing: T1 remains
             paused while T5 detector mathematics and T6 Q14 planning
             proceed."
ASSERTS      what the v1.05 revision DID when it was made.
CLASS        RECORD OF AN EDITORIAL ACT
             (v1.0 said DERIVED; W3C noted that was awkward. CLASS has no
             fixed vocabulary, so it is stated plainly instead.)
DISPOSITION  CURRENT-UNIQUE
REASON       A revision-history entry is a statement about the PAST. This one
             accurately records what v1.05 did on 2026-08-16, and remains true
             however many times the sequence is later reversed. Superseding it
             would falsify the record: the correct treatment of a superseded
             DECISION is to supersede it, and of an accurate record OF that
             decision is to leave it alone.
CONFLICTS    none. It reports a past edit; it does not assert a current
             sequence.
PREVAILS     n/a.
SWEPT        To establish uniqueness: searched Appendix E for other entries
             restating the paused-T1 sequence as CURRENT - v1.04 through v1.00
             do not; searched sections 0 and 23 for the live claims, which are
             ledgered separately at LED-003, LED-004 and LED-007.
```

**PROPOSED ACTION. NONE - DO NOT TOUCH.** Flagged so a later sweep does not
pattern-match "T1 remains paused" and rewrite history. W3C independently
reached the same conclusion.

```text
TIER     C
VERDICT  [W3C]
```

---

# What W3C is asked here

```text
1. THE COVERAGE ACCOUNTING AT SECTION 0 IS THE THING TO CHECK FIRST. Is the
   narrowed scope honest, and is every omitted statement now assigned to a
   named later sub-tranche? If anything is still unassigned, that is the same
   method finding again.

2. LED-004's REMEDY IS NOW A POINTER, not a new order. Confirm it no longer
   creates a decision W3X has not made.

3. THE STEPS 6-10 CLAIM IS GONE. v1.0 asserted they were unaffected; the
   authority's own line 1153 - "The winner becomes part of the future Deblock4
   scalar oracle" - contradicts the order of steps 8 and 9. That tail is NOT
   ledgered here and is NOT claimed to be checked. It is assigned to T1S01a3
   with the ordering problem attached as a known finding.

4. TWO ENTRIES NOW CARRY A SWEPT FIELD (LED-009, LED-012). Attack the SEARCH,
   not only the conclusion. If you can name a section I did not look in, that
   is a finding.

5. THE CANONICAL-HOME CALLS AT LED-006, LED-008, LED-010 and LED-011 are the
   first use of the corrected CURRENT-DUPLICATE rule. If a home is wrong, say
   which document should own it.
```

---

*Revision history*
```text
v1.1 (2026-08-18) Reissued after W3C found a coverage defect: v1.0 declared
     four whole ranges adjudicated while logging only currency statements.
     Scope narrowed to what is genuinely covered and every omitted statement
     assigned to a named later sub-tranche. LED-005/006 and LED-007/008 split
     per the new atomic-claim rule. LED-011 corrected from CURRENT-UNIQUE to
     CURRENT-DUPLICATE with a canonical home. LED-004's remedy corrected from
     "place T1-T3 first" - an order DEC-02 does not establish - to a pointer.
     The claim that section 23 steps 6-10 were unaffected is WITHDRAWN; the
     authority's own line 1153 contradicts the order of steps 8 and 9, and
     that tail is deferred with the finding attached. LED-009 added, covering
     an authority-boundary statement the v1.0 remedy would have deleted as
     collateral. LED-012's CLASS reworded. Derived proposition narrowed:
     section 0 is not work-queue content, only its status header is.
     Six of the seven corrections came from W3C.
v1.0 (2026-08-18) First issue. Both a coverage defect and four entry defects;
     retained in the record rather than discarded, per W3C's assessment that
     it was reviewable as-is.
```
