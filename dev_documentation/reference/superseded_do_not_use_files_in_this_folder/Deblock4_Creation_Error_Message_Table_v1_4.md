# Deblock4 Stage 1C - Creation-Error Message Table

**Version:** 1.4
**Date:** 2026-08-02
**Author:** W3C (v1.0 draft); W3D corrections (v1.1); W3D Stage 2C additions (v1.2)
**Status:** W3X-ratified. v1.1 tables verified verbatim against the accepted
Stage 1C v1_13 source (Classic 22/22, Deblock4 31/31). v1.2 ADDS two Classic
rows for Stage 2C (section 2a) under the narrow D0 section-5 exception; no
existing row is altered, removed or reworded.
**Encoding:** US-ASCII; CRLF.

## 1. Purpose and authority

This table records the user-visible creation failures implemented by the
Classic and Deblock4 creation modules. It is RATIFIED AND CONTROLLING:
v1.1 was W3X-ratified for Stage 1C; v1.2/v1.3 add and document the two
Stage 2C Classic rows under the D0 section-5 narrow exception. (The
original P4-draft wording is superseded by ratification.)

The strings in sections 2 and 3 are exact plugin-owned messages passed to
`mapSetError`. They are stable source obligations once ratified.

Two boundaries are intentionally explicit (Toolchain Findings F6 and F7).
First, VapourSynth coerces numeric arguments to the registered type before
the plugin runs, so the plugin-owned wrong-type defence for int parameters
is unreachable through the normal Python interface; the former
error_wrong_type harness cases were retired and no host-owned diagnostic
text is asserted anywhere. Second, VapourSynth rejects empty registered
arrays before the plugin runs, so the empty-planes defence is likewise
vspipe-unreachable; that harness case was also retired. Both defensive
messages REMAIN in the tables below as retained source obligations for
low-level API callers and must not be removed as dead code.

## 2. Classic exact plugin-owned messages

| Condition | Exact message |
|---|---|
| Missing/non-node clip | `Classic: clip is required and must be a video node` |
| Video information unavailable | `Classic: source video information is unavailable` |
| Variable format or dimensions | `Classic: input clip must have constant format and dimensions` |
| Wrong type reaching callback defence | `Classic: one or more arguments have the wrong type` |
| Strength outside 0..60 | `Classic: strength must be between 0 and 60` |
| Boundary offset invalid for strength | `Classic: boundary_strength_offset is out of range for strength` |
| Side offset invalid for strength | `Classic: side_activity_offset is out of range for strength` |
| Unknown backend token | `Classic: backend is not a recognised token` |
| Empty planes array | `Classic: planes must not be empty` |
| Too many plane indices | `Classic: planes contains too many indices` |
| Negative plane index | `Classic: plane indices must be non-negative` |
| Plane index exceeds parser bound | `Classic: a plane index is too large` |
| Duplicate plane index | `Classic: planes must not contain duplicates` |
| Validation error not applicable to Classic | `Classic: an argument is not valid for this filter` |
| Invalid force-down value | `Classic: DEBLOCK4_FORCE_DOWN has an invalid value` |
| Requested backend above EFFECTIVE tier | `Classic: requested backend is above the EFFECTIVE CPU tier` |
| Unsupported input colour family | `Classic: input color family is unsupported` |
| Invalid input video metadata | `Classic: input video metadata is invalid` |
| Plane outside source format | `Classic: a plane index is outside the source format` |
| Instance allocation failure | `Classic: instance allocation failed` |
| Writable pass-through copy failure | `Classic: failed to copy the source frame` |
| Audit-property write failure | `Classic: failed to write audit frame properties` |

## 2a. Classic additions for Stage 2C (v1.2; W3X-ratified 2026-08-03)

These two rows exist because Stage 2C makes Classic PRODUCE PIXELS. Until
2C the filter passed frames through, so accepting a float clip or an
unimplemented backend token was harmless; once it filters, silently doing
neither would be a false claim to the user. Both are refusals, not
behaviour changes to any accepted path.

| Condition | Exact message |
|---|---|
| Float input (integer-only stage) | `Classic: float input is not supported` |
| Integer depth outside 8..16 | `Classic: integer input must be between 8 and 16 bits` |
| Explicit backend not implemented in this build | `Classic: requested backend is not available in this build` |

Notes:

- The float row is required because Stage 1C creation has no sample-type
  gate: a float clip (16-bit YUV444PH/GRAYH/RGBH OR 32-bit ...PS) is
  accepted today and would otherwise reach an integer-only pixel path.
- The integer-depth row is required because VapourSynth permits integer
  bitsPerSample of 8..32 (storage 1 byte at 8, 2 bytes at 9..16, 4 bytes
  above 16); a valid 17..32-bit integer clip is API-REACHABLE and is NOT
  malformed metadata - it must be refused explicitly, never via the
  "input video metadata is invalid" row which means something else. Float remains a first-class future path with its
  own ratified tolerance and activation-flip discipline (V&T 3.4-3.6); it is
  refused here rather than mistreated. The row is RETIRED when Classic float
  support lands.
- The availability row is required by the implemented-tier rule: `auto`
  resolves to the highest tier that is both EFFECTIVE-supported AND
  implemented, while an EXPLICIT unimplemented tier request fails rather
  than being silently served by a lower implementation. It is distinct from
  the existing `Classic: requested backend is above the EFFECTIVE CPU tier`
  row: that one means the HARDWARE cannot run it; this one means the BUILD
  does not implement it yet. Both may be legal simultaneously; the EFFECTIVE
  check retains precedence, and Stage 2C must fix and test that precedence.
- PROOF STATUS: both rows are exercised by the Stage 2C proof surface -
  the float row via TWO otherwise-valid float-input cases - 16-bit
  (YUV444PH) and 32-bit (YUV444PS) - proving the refusal is sample-type
  based, not storage-width based (F2); the integer-depth row via an
  otherwise-valid 17-bit or 32-bit integer creation case (F1); and the
  availability row via SEPARATE explicit v2 AND explicit v3 requests on
  the 2C build (F3);
  the EFFECTIVE-tier refusal's PRECEDENCE over availability when both
  apply is a further explicit required test (D4 S5).
- The rows are Classic-only in Stage 2C. deblock4.Deblock4 remains
  pass-through and unchanged; it inherits equivalent rows when it produces
  pixels at Stage 2D.

## 3. Deblock4 exact plugin-owned messages

| Condition | Exact message |
|---|---|
| Missing/non-node clip | `Deblock4: clip is required and must be a video node` |
| Video information unavailable | `Deblock4: source video information is unavailable` |
| Variable format or dimensions | `Deblock4: input clip must have constant format and dimensions` |
| Wrong type reaching callback defence | `Deblock4: one or more arguments have the wrong type` |
| Strength outside 0..60 | `Deblock4: strength must be between 0 and 60` |
| Boundary offset invalid for strength | `Deblock4: boundary_strength_offset is out of range for strength` |
| Side offset invalid for strength | `Deblock4: side_activity_offset is out of range for strength` |
| Unknown backend token | `Deblock4: backend is not a recognised token` |
| Empty planes array | `Deblock4: planes must not be empty` |
| Too many plane indices | `Deblock4: planes contains too many indices` |
| Negative plane index | `Deblock4: plane indices must be non-negative` |
| Plane index exceeds parser bound | `Deblock4: a plane index is too large` |
| Duplicate plane index | `Deblock4: planes must not contain duplicates` |
| Missing grid mode | `Deblock4: grid_mode is required` |
| Unknown grid mode | `Deblock4: grid_mode is not recognised` |
| Reserved auto grid mode | `Deblock4: grid_mode=auto is reserved and not implemented` |
| Missing custom-grid parameter | `Deblock4: custom mode requires all custom grid parameters` |
| Custom parameter supplied with preset | `Deblock4: custom grid parameters require grid_mode=custom` |
| Custom step below 1 | `Deblock4: custom grid steps must be at least 1` |
| Invalid midpoint-enabled integer | `Deblock4: luma_midpoint_enabled must be 0 or 1` |
| Midpoint scale outside 0.0..1.0 | `Deblock4: midpoint_threshold_scale must be between 0.0 and 1.0` |
| Midpoint scale inapplicable to grid | `Deblock4: midpoint_threshold_scale is not applicable to this grid policy` |
| Invalid force-down value | `Deblock4: DEBLOCK4_FORCE_DOWN has an invalid value` |
| Requested backend above EFFECTIVE tier | `Deblock4: requested backend is above the EFFECTIVE CPU tier` |
| Unsupported input colour family | `Deblock4: input color family is unsupported` |
| Invalid input video metadata | `Deblock4: input video metadata is invalid` |
| Plane outside source format | `Deblock4: a plane index is outside the source format` |
| Custom step above relevant plane dimension | `Deblock4: a custom grid step exceeds its relevant plane dimension` |
| Instance allocation failure | `Deblock4: instance allocation failed` |
| Writable pass-through copy failure | `Deblock4: failed to copy the source frame` |
| Audit-property write failure | `Deblock4: failed to write audit frame properties` |

## 4. Phase 3b e2e subset (as accepted at Stage 1C closure)

The two Stage 1C .vpy harnesses prove these plugin-owned refusals end to end
under vspipe in ReleaseSafe and ReleaseFast, asserting the exact strings
above: both filters - strength range, duplicate planes, unknown backend,
variable format; Deblock4 additionally - custom step below one and custom
step above the relevant plane dimension. All remaining table rows are source
obligations verified by review rather than by vspipe: the wrong-type and
empty-planes rows are boundary-unreachable retained defences (section 1),
and the remaining rows (clip/metadata refusals, offset ranges, grid/midpoint
combinations, force-down and EFFECTIVE-tier refusals, allocation and copy
failures) are exercised by unit/selftest coverage or reserved for their
enabling stages.

---

Revision: v1.1 (2026-08-02) applied post-F6/F7 reality to sections 1 and 4;
tables unchanged from the v1.0 draft and verified verbatim against the
accepted Stage 1C source. v1.0 was the W3C delivery-review draft.
