# Deblock4 - Forward Roadmap

**Version:** 1.23
**Date:** 2026-08-19
**Status:** Orientation only; not controlling; not a coding scope. Current recovery/sequencing route, still subject to T1 adjudication.
**Author:** W3C recovery rewrite after W3D session limit
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
    a5 .............................. recovery verification/closure pending.
    a5b/a6/a7 ....................... not started.
    T8 .............................. after T1, before T5.
    T5 .............................. after T8.
    T6/Q14 .......................... after T5, separate ratification.

CURRENT ARCHITECTURE:
    B2 primary candidate; D mandatory detector-free comparator/fallback;
    A/C rejected; Q14 may advance B2 or D only if viable and may reopen the
    architecture if neither is adequate.

RECOVERY BOUNDARY:
    W3D delivered Classification Repair v1.1 and then its session died.
    W3C recovery ledger v1.4 is a W3C-authored reconstruction; successor W3D
    must independently verify/adopt/correct it before W3X closes a5 and before
    a5b begins.

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
        Current gate: finish a5 recovery verification/closure.
        Then a5b -> a6 -> a7 and remaining T1 steps.

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
    - start a5b before W3X closes a5 recovery;
    - ask W3C to call its own recovery ledger independently reviewed;
    - use T1/ as applicable project knowledge merely because a statement is
      written there;
    - use GAIS_investigations/ as T1 search/adjudication evidence;
    - draft a Deblock4 kernel scope before Q14 reports and W3X ratifies entry;
    - resurrect the old field-separated/midpoint Architecture-A model from
      older README/roadmap material.
```

# Next bounded milestones

1. Successor W3D independently verify/adopt/correct a5 recovery ledger v1.4.
2. W3X close the one-off a5 recovery path.
3. Begin T1S01a5b.
4. Complete T1 through its declared final consistency pass.
5. T8 provenance-gap closure.
6. T5 detector mathematics.
7. Separately ratified T6/Q14 plan and experiment.

---

*Revision note*
```text
v1.23 (2026-08-19) Current-orientation rewrite after T1 designer-session loss.
      Removes the v1.22 stale Stage-1C-active / Stage-5C-next / old 2D
      midpoint/schedule arc from live roadmap guidance. Records the a5 recovery
      gate, W3C-authorship independence boundary, T1 -> T8 -> T5 -> T6/Q14
      sequence, current B2/D architecture, and 47/41/46 population distinction.
      Remains informative and still in scope for T1S05 adjudication; no scope,
      architecture decision or authority change is made here.
```
