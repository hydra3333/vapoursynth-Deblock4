# Deblock4 - Stage 2C K26 Sentinel Fixtures (D4 H3(b) addendum)

**Deliverable:** W3D-2C-D4-ADDENDUM-A
**Version:** 1.0
**Date:** 2026-08-03
**Author:** W3D
**Purpose:** supply the exact plugin-level sentinel fixtures required by D4
v1_2 H3(b), so the negative-delta behavioural sentinels are reproducible
observations of ONE hashed reference binary rather than abstract six-tap
vectors two harnesses could embed differently.
**Status:** part of the D4 package; for W3C review and W3X ratification.
**Encoding:** US-ASCII; CRLF.

---

# 1. The problem these fixtures solve

D3's B2/B4/B5 are six-tap edge vectors. HolyWu exposes a FRAME FILTER, not
an edge function, and its schedule is sequential and IN PLACE (D2 section
3). Embedding a six-tap vector in a frame therefore does not by itself
determine the observed result: neighbouring edges may read the taps, may
write the cells being read back, and may run before or after the target
edge. Two reasonable harnesses could embed the same vector differently and
BOTH observe "correct" but different bytes.

These fixtures remove that freedom entirely.

# 2. Design principle: flat filler is self-neutralising

A perfectly flat region ACTIVATES (all three activation differences are 0,
which is < alpha and < beta for any non-zero threshold) but computes ZERO
deltas:

```text
delta   = ((0)*4 + v - v + 4) >> 3 = 4 >> 3 = 0
deltap1 = (v + v - 2v) >> 1 = 0        deltaq1 = 0
```

So flat filler changes nothing, whether or not an edge is applied to it.
Every fixture below is flat everywhere except the six target taps, which
makes every non-target edge inert while remaining a fully normal,
unmodified run of the real filter. Nothing is disabled or special-cased.

# 3. Common fixture parameters

```text
geometry     16 x 8  (mod-8 in both axes: no HolyWu pad/filter/crop path,
                      and the eligible candidate set is fixed and known)
format       GRAY8   (single plane; no chroma or subsampling variables)
             FALLBACK: if the reference build declines Gray, use YUV444P8
             with planes=[0] and the SAME plane-0 content; the mathematics
             is plane-agnostic (D2 section 3) and the readback is identical.
planes       omitted (all planes) for GRAY8; planes=[0] for the fallback
aoffset      0
boffset      0
opt          1        MANDATORY - forces the C/scalar oracle path (D2
                      section 1; D4 H2). opt=0 would auto-select SSE4 on a
                      capable host and the observation would be worthless.
frames       1 (a single constant frame; no temporal element)
```

Candidate edges in a 16x8 plane (README 6.2 eligibility, e-3 >= 0 and
e+2 <= extent-1): VERTICAL x = 4, 8, 12; HORIZONTAL y = 4 only.

# 4. Vertical-orientation fixtures (pattern in ROW 0, columns 1..6)

Row 0 columns 1..6 carry (p2,p1,p0,q0,q1,q2) for the vertical edge at
x = 4, whose read footprint is exactly columns 1..6 and whose write
footprint is columns 2..5. Every other sample in the frame = FILLER.

Why row 0 is the correct home:

```text
- the TOP-BAND vertical sweep (D2 section 3 step 1) applies the vertical
  edge at x=4 to rows 0..3 BEFORE any horizontal edge runs, so the target
  edge sees the pristine taps;
- with H = 8 the ONLY horizontal candidate is y = 4, whose write footprint
  is rows 2..5 - it can never write row 0 or row 1;
- the band loop re-applies vertical edges to rows 4..7 only, so the target
  edge is applied to row 0 EXACTLY ONCE;
- vertical edges at x=8 and x=12 write columns 6..9 and 10..13, never the
  readback columns 2..5.
```

READBACK: row 0, columns 2, 3, 4, 5 = (p1', p0', q0', q1').

```text
FIXTURE V-B2   quant = 25, filler = 100
  row 0 = 100 110 110 110 100 100 100 100 100 100 100 100 100 100 100 100
          (col0=100; cols1-6 = 110,110,110,100,100,100; cols7-15 = 100)
  rows 1-7 = all 100
  EXPECTED readback (row 0, cols 2..5) = 109 107 103 101

FIXTURE V-B4   quant = 25, filler = 0
  row 0 = 0 0 0 0 9 9 9 0 0 0 0 0 0 0 0 0
          (cols1-6 = 0,0,0,9,9,9; all other samples 0)
  rows 1-7 = all 0
  EXPECTED readback (row 0, cols 2..5) = 1 3 6 8

FIXTURE V-B5   quant = 60, filler = 195
  row 0 = 195 195 195 195 5 5 5 195 195 195 195 195 195 195 195 195
          (cols1-6 = 195,195,195,5,5,5; all other samples 195)
  rows 1-7 = all 195
  EXPECTED readback (row 0, cols 2..5) = 160 158 42 40
```

# 5. Horizontal-orientation fixtures (pattern in COLUMN 0, rows 1..6)

Column 0 rows 1..6 carry (p2,p1,p0,q0,q1,q2) for the horizontal edge at
y = 4, whose read footprint is exactly rows 1..6 and whose write footprint
is rows 2..5. Every other sample = FILLER.

Why column 0 is the correct home:

```text
- vertical edges write columns 2..13 only; column 0 is never written, and
  column 0 is never even READ (the leftmost vertical edge x=4 reads from
  column 1);
- within the band at y=4 the horizontal call at x0=0 runs FIRST (D2
  section 3 step 3a), before any vertical edge of that band;
- the horizontal edge at y=4 is the only horizontal candidate, so column 0
  rows 2..5 are written exactly once.
```

READBACK: column 0, rows 2, 3, 4, 5 = (p1', p0', q0', q1').

```text
FIXTURE H-B2   quant = 25, filler = 100
  column 0 rows 0..7 = 100, 110, 110, 110, 100, 100, 100, 100
  (rows 1-6 of col 0 = the taps; every other sample in the frame = 100)
  EXPECTED readback (col 0, rows 2..5) = 109 107 103 101

FIXTURE H-B4   quant = 25, filler = 0
  column 0 rows 0..7 = 0, 0, 0, 0, 9, 9, 9, 0
  (every other sample = 0)
  EXPECTED readback (col 0, rows 2..5) = 1 3 6 8

FIXTURE H-B5   quant = 60, filler = 195
  column 0 rows 0..7 = 195, 195, 195, 195, 5, 5, 5, 195
  (every other sample = 195)
  EXPECTED readback (col 0, rows 2..5) = 160 158 42 40
```

# 6. The whole-frame exactness self-check (mandatory)

For EVERY fixture above, W3D verified with the derivation model that the
output frame differs from the source frame in EXACTLY the four readback
cells and NOWHERE ELSE - 0 other changed samples in all six fixtures.

The harness MUST assert this, not merely read the four cells:

```text
1. the four readback cells equal the expected values EXACTLY; AND
2. every other sample in the 16x8 plane is byte-identical to the source.
```

Condition 2 is the neutralisation PROOF. If any other sample changed, the
fixture assumption has been violated (wrong geometry, wrong parameters,
wrong opt, a different reference build, or a misunderstanding of the
schedule) and the observation must NOT be recorded as a sentinel. This
converts "we believe only one edge acted" from an assumption into a
checked fact on every run.

Note the neighbouring vertical edge at x=8 is inert in all three vertical
fixtures, for two different reasons worth recording: in V-B2 it activates
but computes zero deltas (the filler equals the q-side value); in V-B4 and
V-B5 it does not activate at all (|p1-p0| exceeds beta across the
pattern/filler transition). Either way condition 2 holds - and the check
does not care which reason applies.

# 7. What each sentinel proves (D4 H3(a) classification)

```text
V-B2 / H-B2   q0-p0 = -10 (NEGATIVE) -> the C++ core expression
              left-shifts a negative signed value: the UNDEFINED-BEHAVIOUR
              region. Also the floor-vs-truncate discriminator: the delta
              core is -26, and -26>>3 = -4 under floor but -3 under
              truncation, which changes the final bytes.
V-B5 / H-B5   q0-p0 = -190 (NEGATIVE) -> same UB region at quant 60, with
              the large-c and +/-c0 clamps engaged.
V-B4 / H-B4   q0-p0 = +9 (POSITIVE) -> does NOT exercise the
              negative-left-shift UB. It exercises a negative signed RIGHT
              shift in the side-delta ((-4)>>1 = -2 under floor) and the
              low-value region. Recorded accurately as such.
```

# 8. Recording and gate (D4 H3(c)/(d))

```text
- Run all six fixtures against the exact SHA-256-hashed reference binary
  with opt=1, and record the OBSERVED four bytes per fixture in the
  reference-build record alongside the build identity.
- The binary is usable for H5 comparison ONLY if all six observations
  equal the expected values above AND all six whole-frame checks pass.
- On ANY mismatch: HARD STOP. No H5 comparison is trusted. Report the
  build identity and observed bytes to W3X/W3D. NEVER silently rewrite
  D3 or this addendum to match the binary - that is a material oracle
  change requiring three-way ratification.
- A rebuilt reference binary is a NEW oracle artefact: fresh hash AND
  full sentinel revalidation before use.
```

# 9. Independence note

The expected values in sections 4-5 are D3's B2/B4/B5 results (hand-derived
from the D2 formulas, independently reconfirmed by W3C), placed in frames
whose schedule behaviour W3D verified with the Appendix B/C derivation
models. They are the INTENDED oracle values. The reference binary's
observed values become the recorded layer-(b) facts. If the two ever
disagree, that disagreement is the finding - it is not resolved by
changing this document.

---

Revision: v1.0 (2026-08-03) initial fixtures, six in total (three vectors
x two orientations), each whole-frame verified against the derivation
model with zero unintended changed samples.
