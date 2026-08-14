# Deblock4 - MPEG-2 Grid and Frame/Field-DCT Knowledge

**Version:** 1.0
**Date:** 2026-07-27
**Status:** Informative knowledge record; not controlling. Consolidates findings
that drive edge_step_y and the midpoint machinery.
**Encoding:** US-ASCII only
**Provenance:** Derived from design reasoning, external research dialogues
(Google AI Studio, labelled GAIS below), and direct measurement of real source
files with MediaInfo/ffprobe. Toolchain claims and device behaviour are recorded
with their evidence status.

---

# 0. Why this document exists

The vertical luma deblocking grid for interlaced MPEG-2 is not a fixed constant.
It depends on the encoder's per-macroblock frame-vs-field DCT decision, which
after field separation changes where block boundaries fall. This document
consolidates what was learned so the knowledge is not lost, because it directly
determines edge_step_y and is the reason the midpoint machinery exists.

The single practical upshot: for the target LG VHS-to-DVD material, every
realistic recording mode uses adaptive per-macroblock DCT (the hard "regime 3"),
so the midpoint machinery is confirmed required, not hypothetical.

---

# 1. Frame-DCT vs field-DCT, plainly

An interlaced frame is two fields interleaved: field A on even lines
(0,2,4,...), field B on odd lines (1,3,5,...), captured a moment apart. Motion
makes the woven frame show comb/zipper artifacts.

The encoder codes 8x8 blocks and, per macroblock in an interlaced frame-picture,
chooses how to group the 8 lines of a block:

- FRAME-DCT: 8 consecutive woven lines (0..7). Mixes both fields. Good on still
  content, bad on motion (zipper inside the block).
- FIELD-DCT: 8 lines from one field only (e.g. even 0,2,4,...,14). Each block is
  internally consistent in time. Good on motion.

The encoder picks whichever compresses better, PER MACROBLOCK. So adjacent
macroblocks in one frame can differ.

---

# 2. What field separation does to the grid (the key geometry)

Deblock4 processes interlaced material by separating fields first. After
separation (each field is 288 lines for 576i):

- FIELD-DCT macroblock -> its 8 same-field lines are contiguous in the field, so
  block boundaries sit at PITCH-8 (field-rows 0,8,16,...). A plain step-8
  deblocker lands exactly on these. Correct.

- FRAME-DCT macroblock -> its 8 woven lines split 4 to each field. Each woven
  8-line block becomes a COMPLETE 4-line block in each field (nothing is chopped;
  both fields carry the block-to-block seam at the same position). Boundaries sit
  at PITCH-4 (field-rows 0,4,8,12,...). A plain step-8 deblocker MISSES the seams
  at 4,12,20,... - these are the "midpoints".

Critical subtlety: pitch-4 seam positions are a SUPERSET of pitch-8 positions.
The distinguishing signal for frame-DCT is the EXTRA seams at the mod-4-but-not-
mod-8 rows (4,12,20,...). A naive "count mod-8 vs mod-4 lines" test cannot
cleanly separate the two because field-DCT edges are a subset. Frequency-domain
or phase-aware pitch detection is more robust than a modulo test.

Horizontal is unaffected: field separation is a vertical operation, so
edge_step_x = 8 always for these; only edge_step_y carries the 4-vs-8 question.
Chroma is determined separately (4:2:0 chroma grid is fixed by the structural
H.262 argument); do not apply this luma 4/8 reasoning to chroma.

---

# 3. The three regimes

Distinguished by two bitstream fields, both readable without full decode:
picture_structure and frame_pred_frame_dct (in the picture coding extension).

```text
REGIME            condition                              vertical luma grid
----------------- -------------------------------------- ------------------
field-pictures    picture_structure = 1 or 2             uniform pitch-8
                  (dct_type not in bitstream;            (implicit field-DCT)
                   field DCT implicit)

frame-pictures,   picture_structure = 3 (Frame) AND      uniform pitch-4
uniform           frame_pred_frame_dct = 1               (all frame-DCT)

frame-pictures,   picture_structure = 3 (Frame) AND      MIXED pitch-4 / pitch-8
adaptive          frame_pred_frame_dct = 0               per macroblock
(REGIME 3)                                               (the hard case)
```

GAIS/ISO confirmation (ISO/IEC 13818-2 section 6.3.17.1, macroblock_modes):
the dct_type bit is parsed only when picture_structure == FRAME_PICTURE(3) AND
frame_pred_frame_dct == 0 AND the macroblock is intra or has a coded pattern.
So:
- frame_pred_frame_dct == 1 -> no dct_type bit anywhere -> all frame-DCT by
  construction (regime 1).
- frame_pred_frame_dct == 0 -> per-MB choice possible (regime 3), but only
  coded macroblocks carry the bit (skipped/motion-only MBs have no DCT).

---

# 4. The midpoint machinery (the regime-3 answer)

Regime 3 has no single correct edge_step_y: one macroblock wants pitch-4, its
neighbour wants pitch-8. The design's answer is NOT to decide 4-vs-8 per block.
Instead:

- Filter the pitch-8 grid ALWAYS (every real seam in both cases sits on or is a
  superset of pitch-8).
- Filter the MIDPOINTS (the pitch-4-only rows 4,12,20,...) CONDITIONALLY, gated
  per-position by measured edge magnitude.

In a field-DCT block the midpoint has no real seam, so the edge detector sees
nothing and the midpoint filter is inert. In a frame-DCT block the midpoint has a
real seam and the filter acts. The PIXELS gate it, per position; no per-block
classification is needed.

Vectorisation note: this is branchless and data-gated (a proportional strength
driven by edge magnitude, i.e. a multiply, not a branch), so it does NOT break
SIMD. The cost is inspecting roughly twice as many vertical positions - uniform,
regular work. The failure mode that WOULD break SIMD - per-block type branching
at 16-pixel granularity - is exactly what this approach avoids. This is a reason
the midpoint-conditional approach was preferred.

Open quality question (measurement-gated, NOT settled): whether the midpoint
edge-detection is selective enough to stay inert on field-DCT blocks without
missing weak frame-DCT seams. This is why the midpoint work sits behind a quality
gate rather than being assumed correct.

---

# 5. Why bitstream dct_type extraction was investigated and abandoned

To know the per-MB frame/field-DCT map as ground truth, one would read the
bitstream dct_type. Findings (GAIS, cross-checked):

- No standard free tool reports per-macroblock dct_type in a labelled,
  aggregatable form. ffprobe reports container/stream and per-picture fields but
  not dct_type. "ffmpeg -debug mb_type" reports macroblock PREDICTION type
  (intra/forward/backward), NOT dct_type. Confirmed by direct test.
- Bitstream extraction would require a decoder modification: either the MSSG
  reference decoder (public domain, but ~30-year-old K&R C, needs elementary
  stream not program stream, no error resilience - a liability on noisy VHS
  captures) or a 3-line patch to FFmpeg's mpeg12dec.c at the dct_type parse site
  (better: handles .mpg natively, error-resilient, but needs an FFmpeg build).
- DECISION: abandoned as not worth it for a one-time need. The pixel-domain
  measurement (below) answers the operative question directly, and the cheap
  flag check (section 6) answers the regime question without any decode.

Residual value if ever revisited: a patched-FFmpeg dct_type dump would serve as
a one-time GROUND-TRUTH oracle to validate the pixel analyser (prove the cheap
method once, then trust it). This is a validation cross-check, not a pipeline
component. If built, validate DISTRIBUTIONS (agreement rate across many frames),
not single-frame verdicts, because the two measures differ where quantisation
smears edges or a frame is a per-MB mix.

---

# 6. The cheap regime check (proven, use this)

Reading frame_pred_frame_dct and picture_structure needs NO decode - MediaInfo's
detailed trace exposes them per picture. Proven working on the project toolchain:

```text
mediainfo --Details=1 <file.mpg> | findstr /C:"frame_pred_frame_dct" /C:"picture_structure"
```

Interpretation per picture:
- picture_structure 3 = Frame picture (MediaInfo prints "3 (0x3) ... F").
- frame_pred_frame_dct "Yes" = 1 = uniform frame-DCT (regime 1, pitch-4).
- frame_pred_frame_dct "No"  = 0 = adaptive per-MB (regime 3, mixed).

Tally across the trace (exclude the echoed command line) to confirm uniformity.
This is the authoritative, per-device answer and needs no research or decode.

Gotchas (GAIS, all correct):
1. The flag is per-picture and CAN change frame to frame; check the first N, do
   not assume from frame 1.
2. Even at frame_pred_frame_dct == 0, only coded (intra/pattern) macroblocks
   carry a dct_type bit; skipped/motion-only MBs have none.
3. Field-pictures (picture_structure 1/2) escape the flag entirely - implicit
   field-DCT, pitch-8.

---

# 7. Measured real-source behaviour (direct measurement, this project)

## 7.1 Broadcast OTA capture (home_576i.mpg)

720x576, 4:2:0, TFF, interlaced frame-pictures, ~5.2 Mb/s. All 317 sampled
pictures: picture_structure = Frame, frame_pred_frame_dct = No. => REGIME 3
(adaptive per-MB). A good hard-case test asset.

home_576p.mpg is progressive (field_order progressive) => simple 8x8, no field
separation, clean control.

## 7.2 LG VHS-to-DVD recorder, all speed modes (the target device)

All modes 4:2:0, TFF, interlaced, picture_structure = Frame. Measured:

```text
mode   nominal   resolution   ~bitrate    frame_pred_frame_dct   regime
------ --------- ------------ ----------- ---------------------- --------
XP     1 hour    720x576      ~2.8 Mb/s   No  (0)                regime 3
SP     2 hour    720x576      ~2.8 Mb/s   No  (0)                regime 3
LP     4 hour    720x576      ~2.6 Mb/s   No  (0)                regime 3
EP     6 hour    352x576      ~1.8 Mb/s   No  (0)                regime 3
MLS    ~14 hour  352x288      ~0.7 Mb/s   Yes (1)                regime 1
```

Findings:
- Every PRACTICAL restoration mode (XP/SP/LP/EP) is REGIME 3 (adaptive per-MB).
  => The midpoint machinery is CONFIRMED REQUIRED for real target footage.
- Only MLS (lowest quality, quarter resolution) hard-sets frame-DCT (regime 1,
  uniform pitch-4). Nobody restores treasured tapes at MLS, but it is a useful
  regime-1 CONTROL asset from the same device.
- Resolution steps DOWN at EP (720 -> 352 wide) and again at MLS (-> 352x288).
  edge_step_x = 8 holds throughout (both 720 and 352 are clean multiples of 16).
  Lower modes are blockier (heavier quantisation) but the grid STRUCTURE is
  unchanged; they are escalating-severity test assets, not different grids.
- The bitrates of XP/SP/LP are near-identical here only because the test clips
  were short and VBR did not stress; do not read a quality ranking into that.
  Resolution and DCT regime are the stable structural facts.

## 7.3 Resulting graded test corpus (same device where noted)

```text
regime 1 control : LG MLS (uniform frame-DCT, pitch-4)          easy case
regime 3 assets  : LG XP/SP/LP (720x576) -> EP (352x576)        the real target
                   broadcast OTA home_576i (720x576, cleanest)
progressive ctrl : home_576p (no field separation, plain 8x8)
```

A natural experiment: MLS (regime 1) should show clean uniform pitch-4; the
others should show the mixed regime-3 signal. Good for validating both the
analyser and the midpoint machinery's selectivity.

---

# 8. What remains open

- The pixel-domain block-pitch analyser (project's "v4 analyser") measures the
  actual vertical pitch present in separated fields. It is the operative tool
  for choosing edge_step_y and is stronger for a restoration decision than the
  bitstream dct_type would be (it measures the artifact, not the encoder's
  intent). Its precise validation against any ground truth is future work.
- Midpoint edge-detection selectivity (section 4) is measurement-gated.
- Whether any source will present FIELD-pictures (regime by picture_structure)
  rather than frame-pictures: none seen so far (all measured sources are
  frame-pictures), but the fork must exist in grid-determination logic.

---

*This document is informative knowledge capture. The charter and README prevail
for any controlling rule. Device measurements are specific to the units tested
and are evidence for those files, not universal encoder facts - grid remains a
required parameter precisely because it cannot be safely inferred in general.*
