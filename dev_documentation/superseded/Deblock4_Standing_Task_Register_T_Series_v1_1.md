# Deblock4 - Standing Task Register (T-Series) for the MPEG-2 / Deblock4 Arc

**Version:** 1.1
**Date:** 2026-08-16
**Author:** W3D (v1.0); W3C v1.1 reconciliation for W3X
**Status:** W3X-RATIFICATION CANDIDATE. On W3X acceptance this supersedes
v1.0 as the authoritative list of outstanding process and design tasks for the
Deblock4 MPEG-2 arc. It exists because the T-series was
previously carried only in conversation and in condensed form inside Project
Status section 0, which does not survive a session boundary well.
**Relationship to other documents:** the ARCHITECTURE authority is
Deblock4_MPEG2_Deblocking_Investigation_and_Decided_Architecture_v1_05
(or later; read its section 0 first). THIS document holds the WORK QUEUE, not
the decisions. Where the two touch, the authority document prevails.
**Maintenance rule:** when a task completes, mark it DONE with the date and
the artifact that discharged it - do not delete it.
**Encoding:** US-ASCII; CRLF.

---

# 0. Status at a glance

```text
  T1  Formal 17-document consolidation ..... PAUSED (W3X); still incomplete
  T2  Retire the Grid Knowledge document ... BLOCKED by T1
  T3  De-duplicate into references ......... BLOCKED by T1
  T4  Boundary-set mathematics ............. LARGELY ABSORBED by authority
                                             v1.05; confirm during T1
  T5  Detector mathematics ................. NOT STARTED; FIRST DESIGN SUBTASK
  T6  D4-Q14 experiment plan ............... FOLLOWS / MAY PACKAGE WITH T5
                                             after T5 maths is frozen
  T7  Final consolidation commit ........... BLOCKED by T1-T6; NOT the current
                                             pre-handoff documentation commit

  HARD RULE, independent of this queue: NO DEBLOCK4 KERNEL SCOPE MAY BE
  DRAFTED until the D4-Q14 architecture-discriminator experiment reports and
  W3X ratifies the architecture allowed to enter kernel/oracle development.

  CURRENT RESUME ORDER FOR A NEW W3D:
      Project Status v1.28 section 0
      -> MPEG-2 authority v1.05 section 0
      -> this task register
      -> T5 detector mathematics
      -> T6 Q14 experiment plan
  T1 remains paused by W3X while Q14 is set up.
```

# T1 - Consolidation sweep of the MPEG-2-bearing documents

```text
WHAT: Seventeen documents in dev_documentation carry MPEG-2, grid,
field-DCT or interlacing content. Read and adjudicate EVERY hit: is it
current, relevant and accurate? If consistent with the authority document,
is it duplication that should become a reference (T3)? If it CONFLICTS,
decide and RECORD which prevails and why, naming the document it came
from. Anything worth keeping is folded into the authority document at the
right place, without duplicating.

PROGRESS: the original formal T1 sweep stopped after README sections
3.11/3.13 exposed Architecture A. Subsequent W3C consolidation work for
authority v1.03-v1.05 recovered several additional load-bearing items from the
README, old Grid Knowledge and orientation material, but that TARGETED recovery
is NOT a substitute for the formal 17-document adjudication. T1 therefore
remains incomplete and must not be marked DONE by inference.

WHY IT IS PAUSED: T1 was suspended at its first finding. Reading the
README revealed a FULLY RATIFIED Deblock4 grid architecture (the union
step-4 / midpoint design, "Architecture A") that the entire four-round
external investigation had missed, because W3D had classified that
document as "fallback general guidance" and never swept it. That forced an
architecture RE-DECISION, and consolidating documents into an architecture
that was itself under reconsideration would have been consolidating into a
moving target. The re-decision is now SETTLED (A rejected; B2 primary; D
mandatory fallback), so T1 is RESUMABLE - it remains paused only by W3X
sequencing preference while the D4-Q14 work is set up.

KNOWN ITEMS T1 MUST HANDLE (already surfaced, do not rediscover):
  - the current Deblock4LumaStepY / midpoint audit-property model CANNOT
    express mixed B2 geometry as a single per-frame string;
  - 4:2:2 and 4:4:4 chroma FOLLOW luma DCT organisation and therefore
    CANNOT inherit the 4:2:0 fixed-chroma simplification;
  - the analyser rules require an unmodified-source pre-pass and per-call
    scratch under fmParallel;
  - schedule remains output-defining; proper chroma is a separate quality
    gate; grid origin / crop ordering is load-bearing;
  - the successor introductions have now been reconciled to the single MPEG-2
    authority; during T1 check the remaining documents for equivalent stale
    field-separated/midpoint or one-step-per-frame wording.

PENDING W3X RULING THAT BELONGS WITH T1: the README's status. It holds
ratified design and is currently described as "fallback general guidance",
which is precisely what allowed a whole architecture to go unread. A
document containing ratified design is not fallback anything.

STANDING LESSON: any knowledge sweep MUST include SPECIFICATION documents,
not only decision records.
```

# T2 - Retire the Grid Knowledge document

```text
WHAT: Deblock4_MPEG2_Grid_Field_DCT_Knowledge_v1_2 is superseded by the
authority document but still sits in the main dev_documentation directory
looking current, carrying possibly-misleading load-bearing content. Move it
to superseded/, and edit the Documentation Currency Audit in the SAME pass
so nothing references it as live.

WHY AFTER T1: it is the file most likely to hold content the sweep still
needs to check (its G-series checklist, the Fig 6-1/6-2 chroma-siting
material behind D4-Q10). Retiring a referenced document is a COORDINATED
edit, not a drag-and-drop - the M2 lesson, where deleting a batch without
amending the two audit scripts that named it would have silently disabled
two gates.
```

# T3 - De-duplicate MPEG-2 content into references

```text
WHAT: once T1 establishes what is duplicated, strip duplicated KNOWLEDGE
and DECISIONS out of the other documents and replace them with pointers to
the authority document. One home per fact.

TWO CARVE-OUTS, both deliberate:
  - operative SPECIFICATIONS stay where they are used. The README
    describing parameter behaviour the filter implements is specification,
    not knowledge; it gets a pointer, not a hollowing-out.
  - the charter's MPEG-2 mentions are rule-context and are NOT touched.
```

# T4 - Boundary-set mathematics

```text
WHAT: formal definition of exactly which rows and columns are block
boundaries, per plane, per geometry, in frame coordinates, with the six-tap
footprints written out - what turns B2's edge topology from prose into
something implementable and provable.

STATUS: LARGELY ABSORBED. Authority document v1.05 sections 4 (whole-frame
pitch mathematics) and 10 (B2 macroblock-topology table) appear to cover
this. T4 is therefore probably a REVIEW task, not a derivation task -
confirm during T1 and either mark DONE by absorption or list what remains.
```

# T5 - Detector mathematics

```text
WHAT: the formal specification of the B2 classifier - which features are
computed per macroblock, how the FRAME and FIELD hypotheses are scored,
how confidence is derived, and where the UNKNOWN threshold sits. Also the
equivalent statement for Architecture D's single uncertain internal
candidate.

WHY IT PRECEDES T6: the experiment measures THIS SPECIFIC DETECTOR. A
detector that has not been defined cannot be measured, and defining it after
seeing held-out results would be tuning to the test. T5 may be issued as the
first frozen/ratified section of one coordinated T5+T6 design package, but the
mathematics and decision criteria must be fixed before held-out judgement.

OWNERSHIP: W3D derives; W3C cross-checks the derivation and its SIMD
consequences; W3X ratifies (D4-D11).
```

# T6 - The D4-Q14 architecture-discriminator experiment plan

```text
WHAT: the written plan for the experiment that decides B2 versus D:
  - how per-macroblock dct_type GROUND TRUTH is extracted from real PAL
    MPEG-2 bitstreams (note: frame_pred_frame_dct is readable per frame
    via mediainfo --Details=1, which gives cheap regime triage);
  - how both legs are scored (B2: confusion matrices, confidence margins,
    UNKNOWN rate, FALSE-CONFIDENT rate, reported separately for
    FRAME/FRAME, FIELD/FIELD and MIXED boundaries; D leg: true-boundary
    versus false-candidate feature distributions with ROC sweeps);
  - NO_DCT / skipped / motion-only macroblocks as their OWN truth class,
    never fabricated into FRAME or FIELD;
  - the CALIBRATION and HELD-OUT subsets, with primary metrics and
    viability criteria PREDECLARED before held-out results are examined;
  - the decision rule: B2 if viable; else D if viable; else REOPEN the
    architecture - never force D merely because it is the fallback.

WHY IT MATTERS MORE THAN IT LOOKS: the target LG VHS-to-DVD recorder was
measured with `frame_pred_frame_dct=0` in every practical restoration speed
mode (XP/SP/LP/EP; MLS is the frame-DCT control). Therefore the
ADAPTIVE-CAPABLE per-macroblock regime is normal target-device operation and
B2 is not engineering for a merely theoretical regime. This picture-level
fact does NOT prove that every recording/picture actually contains both FRAME
and FIELD macroblocks; Q14's per-MB truth extraction measures that prevalence.

DEPENDS ON: T5 mathematics fixed first, or frozen/ratified as the first part of
one coordinated T5+T6 package. T6 is the next PLAN after that prerequisite.
```

# T7 - Commit the consolidated set

```text
WHAT: the eventual commit that closes the FORMAL consolidation/retirement
arc and records the ratified experiment-plan set. This is NOT a prohibition on
W3X committing the current authority/orientation/task-register handoff before a
new designer is started. Record what moved, what was retired and why, so a
successor is not left doing git archaeology.
```

---

*Revision history*
```text
v1.1 (2026-08-16) W3C handoff reconciliation for W3X: authority pointer
     advanced to ratification-recording v1.05; T1 progress corrected so the
     targeted v1.03-v1.05 recovery is not mistaken for the formal 17-document
     sweep; T5->T6 sequencing made explicit (or one coordinated package with
     T5 frozen first); LG evidence tightened to adaptive-capable rather than
     assumed observed mixture; T7 clarified as the eventual consolidation
     commit, not the current pre-handoff documentation commit.
v1.0 (2026-08-16) First issue. Captures the T1-T7 queue that previously
     existed only in conversation and in condensed form in Project Status
     section 0, with the T1 pause reason recorded in full so the sequencing
     decision is not mistaken for neglect.
```
