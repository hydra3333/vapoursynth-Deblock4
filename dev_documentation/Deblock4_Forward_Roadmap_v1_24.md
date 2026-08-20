# Deblock4 - Forward Roadmap

**Version:** 1.24
**Date:** 2026-08-21
**Status:** Orientation only; not controlling; not a coding scope. Subject to T1 adjudication.
**Author:** W3D continuity refresh after T1S01a5 closure (base: W3C's v1.23 recovery rewrite)
**Encoding:** US-ASCII only

---

# CURRENT ORIENTATION - STILL IN SCOPE FOR T1 ADJUDICATION

```text
THIS v1.23 REMOVES THE KNOWN-STALE SEQUENCING/ARCHITECTURE GUIDANCE FROM THE
PREVIOUS ROADMAP. It remains informative only and T1S05 must still adjudicate
its statements rather than trusting this label.

CURRENT STATE:
    Classic integer tier arc ........ COMPLETE at 0.1.0-dev+5C + M1/M2.
    Deblock4 filtering kernel ....... DOES NOT EXIST.
    T1 .............................. ACTIVE.
    a5 .............................. CLOSED (DEC-85/DEC-88, 2026-08-21).
                                      Final ledger v1.10, 44 entries, all
                                      Tier C, W3C-reproduced. Residue R1-R8
                                      routed at register v1.36 section 0c.
    a5b ............................. NEXT: sections 9-13, lines 716-1098,
                                      under RATIFIED Review Scope v1.15;
                                      derives its own population; owes a
                                      source-coverage map BEFORE adjudication
                                      (DEC-77).
    a6/a7 ........................... not started. a6 owes the section-24 R8
                                      filename fix (LED-063 CITED record);
                                      a7 owes the consistency pass incl.
                                      residue R1-R6.
    T8 .............................. after T1, before T5.
    T5 .............................. after T8.
    T6/Q14 .......................... after T5, separate ratification.

CURRENT ARCHITECTURE:
    B2 primary candidate; D mandatory detector-free comparator/fallback;
    A/C rejected; Q14 may advance B2 or D only if viable and may reopen the
    architecture if neither is adequate.

RECOVERY BOUNDARY - RESOLVED AND CLOSED:
    The W3C recovery reconstruction (ledger v1.4) was RULED OUT as a source
    at DEC-70; the successor W3D rebuilt textually on delivered v1.3 and
    closure took seven W3C review rounds under the DEC-85 cap. NOT ONE MPEG-2
    conclusion was overturned in any round. The recovery route below in
    "Next bounded milestones" is DONE and recorded here as history only.

CURRENT POPULATION/APPLICABILITY RULES:
    47-document T1S00 survey is historical/frozen;
    current adjudication = 41 documents;
    settled a5 search snapshot = 46 files;
    T1/ is process/workshop, GAIS_investigations/ is ignored for T1
    search/adjudication.

FOR PRECISE LIVE STATE, Resume Brief section 0a prevails over this roadmap.
```

---

# Purpose

This roadmap shows the current high-level dependency arc. It is **orientation
only**. It does not create a scope, decide an algorithm, or override the
charter, the ratified MPEG-2 authority, the task-register decision log, or the
live T1 Resume Brief.

Only one bounded implementation scope is released at a time. There is currently
**no Deblock4 implementation scope** because the project is still in T1 and the
kernel is gated by Q14.

TWO FILTERS, CLASSIC FIRST: the plugin registers two core filters -
deblock4.Classic (H.264, faithful to HolyWu, built FIRST as a known/de-risking
algorithm with an external reference oracle) and deblock4.Deblock4 (the end-goal
MPEG-2 algorithm, built SECOND on proven infrastructure). The Stage 1
infrastructure work is filter-agnostic. Classic's 2C/4C/5C arc is complete.
The old `2D..5D` Deblock4 shorthand is historical and is NOT a current scope
sequence; post-Q14 Deblock4 kernel/oracle/backend stages must be re-derived from
the architecture W3X permits to advance. The MPEG-2 filter remains the end goal;
Classic-first was a sequencing choice only.

---

# The arc

```text
COMPLETED FOUNDATION / CLASSIC
    Stage 1A / 1A.1 / 1B.1 / 1B.2 / 1B.3 ...... COMPLETE
    Stage 1C shared filter creation/integration ........... COMPLETE
    Stage 2C Classic scalar oracle ....................... COMPLETE
    Stage 3C .............................................. COLLAPSED
    Stage 4C Classic SSE4.1 ............................... COMPLETE
    Stage 5C Classic AVX2 ................................ COMPLETE
    Post-5C M1/M2 ........................................ COMPLETE
    Identity .............................................. 0.1.0-dev+5C

CURRENT DOCUMENT/DESIGN ARC
    T1  Consolidate/adjudicate project documentation.
        Current gate: NONE - a5 is closed. a5b is next, then a6 -> a7 and
        remaining T1 steps. After a5b: W3X's explicit project-viability
        decision point.

    T8  Close provenance gaps T1 surfaces.
        Runs AFTER T1 and BEFORE T5.
        Highest-priority recorded gap: F8 vertical-geometry-invariance basis.

    T5  Derive/freeze detector/features/confidence/UNKNOWN mathematics.
        Must precede held-out Q14 judgement.

    T6  Separately-ratified D4-Q14 experiment plan.

    Q14 Run the architecture discriminator against predeclared criteria and
        per-macroblock ground truth.
        B2 may advance only if viable.
        Otherwise D may advance only if viable.
        If neither is adequate, REOPEN ARCHITECTURE.
        Nothing ships at Q14.

FUTURE DEBLOCK4 KERNEL ARC - ONLY AFTER Q14/W3X RATIFICATION
    reconcile public parameters/properties (D4-Q16 as applicable)
    -> derive/freeze scalar kernel mathematics
    -> build independent ReleaseSafe scalar oracle
    -> compare any still-open scalar schedule/quality alternatives under the
       same frozen mathematics/geometry
    -> freeze canonical scalar behaviour
    -> vector backends + differential proof
    -> integration/release validation.

The exact post-Q14 stage names/scopes are NOT authorised by this roadmap and
must be written against the then-current source/authority state.
```

# Stop conditions

```text
DO NOT:
    - open any a5 correction generation for residue R1-R8 (DEC-85: no v1.11);
    - ask W3C to call its own recovery ledger independently reviewed;
    - use T1/ as applicable project knowledge merely because a statement is
      written there;
    - use GAIS_investigations/ as T1 search/adjudication evidence;
    - draft a Deblock4 kernel scope before Q14 reports and W3X ratifies entry;
    - resurrect the old field-separated/midpoint Architecture-A model from
      older README/roadmap material.
```

# Next bounded milestones

1. DONE (differently than v1.23 planned): a5 closed at DEC-88 after the
   DEC-70 textual rebuild and seven review rounds under the DEC-85 cap.
2. Bounded root-continuity refresh (this pass).
3. Begin T1S01a5b under Review Scope v1.15.
4. W3X project-viability decision point (after a5b, by W3X's own placement).
5. Complete T1 through a6 and the a7 consistency pass (incl. residue R1-R6).
6. T8 provenance-gap closure (note: LED-063 CLOSED the suspected V4-report
   hole - content survives; only a6's R8 filename fix remains from that
   thread. F8's vertical-geometry-invariance basis remains T8's headline gap).
7. T5 detector mathematics; then separately ratified T6/Q14.

---

*Revision note*
```text
v1.24 (2026-08-21) Continuity refresh after T1S01a5 closure: a5 CLOSED
     (DEC-85/88), recovery boundary marked resolved (DEC-70 route), stop
     conditions and milestones currentised, T8 note updated for LED-063's
     closure of the V4-report provenance question.
v1.23 (2026-08-19) Current-orientation rewrite after T1 designer-session loss.
      Removes the v1.22 stale Stage-1C-active / Stage-5C-next / old 2D
      midpoint/schedule arc from live roadmap guidance. Records the a5 recovery
      gate, W3C-authorship independence boundary, T1 -> T8 -> T5 -> T6/Q14
      sequence, current B2/D architecture, and 47/41/46 population distinction.
      Remains informative and still in scope for T1S05 adjudication; no scope,
      architecture decision or authority change is made here.
```
