# Deblock4 - Standing Task Register (T-Series) for the MPEG-2 / Deblock4 Arc

**Version:** 1.0
**Date:** 2026-08-16
**Author:** W3D
**Status:** LIVE. This is the authoritative list of outstanding process and
design tasks for the Deblock4 MPEG-2 arc. It exists because the T-series was
previously carried only in conversation and in condensed form inside Project
Status section 0, which does not survive a session boundary well.
**Relationship to other documents:** the ARCHITECTURE authority is
Deblock4_MPEG2_Deblocking_Investigation_and_Decided_Architecture (latest
version; read its section 0 first). THIS document holds the WORK QUEUE, not
the decisions. Where the two touch, the authority document prevails.
**Maintenance rule:** when a task completes, mark it DONE with the date and
the artifact that discharged it - do not delete it.
**Encoding:** US-ASCII; CRLF.

---

# 0. Status at a glance

```text
  T1  Consolidation sweep .................. PAUSED (W3X); resumable now
  T2  Retire the Grid Knowledge document ... BLOCKED by T1
  T3  De-duplicate into references ......... BLOCKED by T1
  T4  Boundary-set mathematics ............. LARGELY ABSORBED by authority
                                             doc v1.03; confirm during T1
  T5  Detector mathematics ................. NOT STARTED; blocks T6
  T6  D4-Q14 experiment plan ............... NOT STARTED; THE NEXT ARTIFACT
                                             once T5 exists
  T7  Commit the consolidated set .......... BLOCKED by the above

  HARD RULE, independent of this queue: NO DEBLOCK4 KERNEL SCOPE MAY BE
  DRAFTED until the D4-Q14 architecture-discriminator experiment reports.
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

PROGRESS: only README_Deblock4_Design_Spec sections 3.11/3.13 and its
settled-decisions table have been read - a fraction of a 2800-line
document that alone carries 137 hits. Sixteen further documents untouched.

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
  - designer intro section 3.11 is already marked SUPERSEDED IN MECHANISM
    with its three still-true items preserved - check the rest of that
    document for the same treatment.

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

STATUS: LARGELY ABSORBED. Authority document v1.03 sections 4 (whole-frame
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

WHY IT BLOCKS T6: the experiment measures THIS SPECIFIC DETECTOR. A
detector that has not been defined cannot be measured, and defining it
during the experiment would be tuning to the test - exactly what the
calibration/held-out discipline exists to prevent.

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
    FRAME/FRAME, FIELD/FIELD and MIXED boundaries; A/D: true-boundary
    versus false-candidate feature distributions with ROC sweeps);
  - NO_DCT / skipped / motion-only macroblocks as their OWN truth class,
    never fabricated into FRAME or FIELD;
  - the CALIBRATION and HELD-OUT subsets, with primary metrics and
    viability criteria PREDECLARED before held-out results are examined;
  - the decision rule: B2 if viable; else D if viable; else REOPEN the
    architecture - never force D merely because it is the fallback.

WHY IT MATTERS MORE THAN IT LOOKS: the measured LG VHS-to-DVD recorder
fact says the adaptive per-macroblock regime is the NORMAL case for this
project's target footage in every practical speed mode (XP/SP/LP/EP; only
MLS hard-sets frame-DCT). Mixed material is therefore not a hypothetical
edge case, and this experiment decides whether a per-macroblock
architecture is warranted or whether the conservative fallback is the
honest answer.

DEPENDS ON: T5. IS THE NEXT ARTIFACT once T5 exists.
```

# T7 - Commit the consolidated set

```text
WHAT: commit the consolidated documentation, the retirements, and the
experiment plan together, with a message recording what moved, what was
retired and why, so a successor is not left doing git archaeology.
```

---

*Revision history*
```text
v1.0 (2026-08-16) First issue. Captures the T1-T7 queue that previously
     existed only in conversation and in condensed form in Project Status
     section 0, with the T1 pause reason recorded in full so the sequencing
     decision is not mistaken for neglect.
```
