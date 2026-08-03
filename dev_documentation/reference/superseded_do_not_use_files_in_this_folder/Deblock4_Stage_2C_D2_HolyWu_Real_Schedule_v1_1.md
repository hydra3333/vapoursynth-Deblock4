# Deblock4 - HolyWu Real Schedule (Stage 2C, D-CLASSIC-4 inspection)

**Deliverable:** W3D-2C-D2
**Version:** 1.1
**Date:** 2026-08-02
**Source of truth:** dev_documentation/reference/holywu_r9/ (byte-pinned,
SHA256SUMS.txt). ALL citations are file:function:line against those bytes.
**Purpose:** record what the pinned HolyWu source ACTUALLY does - schedule,
formulas, rounding, thresholds, boundaries - as the normative layer-(b)
oracle description (D0 K19). The coder independently verifies this document
against the same source before it is relied upon.
**Encoding:** US-ASCII; CRLF.

---

# 1. Identity, registration, parameters

deblock.cpp:VapourSynthPluginInit2:433-448. Plugin com.holywu.deblock,
function Deblock, signature:
`clip:vnode; quant:int:opt; aoffset:int:opt; boffset:int:opt;
planes:int[]:opt; opt:int:opt` -> `clip:vnode`.

deblock.cpp:deblockCreate:284-428:
```text
quant    default 25 (301-303: absent -> 25). Range 0..60 (328-329,
         QUANT_MAX=60 at :38, "generalized by Fizick, was max=51").
aoffset  absent -> 0 (305; mapGetIntSaturated yields 0 on err, err ignored)
boffset  absent -> 0 (307)
planes   absent/empty -> all planes (309-312: process[i] = num_planes<=0);
         out-of-range or duplicate plane -> error (317-321).
opt      0 auto / 1 forceC / 2 forceSSE4 (326,331-332,349-359). Maps to
         Deblock4 Classic's backend concept; not otherwise algorithm-
         bearing.
Formats  constant format; integer 8-16 bit OR 32-bit float (296-299).
```
Classic name mapping (established): quant->strength,
aoffset->boundary_strength_offset, boffset->side_activity_offset.

# 2. Threshold derivation (deblockCreate:334-373)

```text
aOffset = clamp(aOffset, -quant, 60 - quant)          (334)
bOffset = clamp(bOffset, -quant, 60 - quant)          (335)
aIndex  = clamp(quant + aOffset, 0, 60)               (336; second clamp
bIndex  = clamp(quant + bOffset, 0, 60)               (337;  is redundant
                                                       after 334/335 but
                                                       is the code)
alpha = alphas[aIndex]   (338)
beta  = betas [bIndex]   (339)
c0    = cs    [aIndex]   (340)   <-- NOTE: c0 is indexed by aIndex,
                                     the ALPHA-side index, not bIndex.
                                     Faithful means faithful (WP-5).
```
The three 61-entry tables are at deblock.cpp:40-79 and are REPRODUCED
VERBATIM in Appendix A of this document for obligation-vector authoring;
the appendix must match those lines byte-for-byte in value.

Bit-depth scaling, INTEGER formats (361-367):
```text
peak  = (1 << bits) - 1
scale = 1 << (bits - 8)
alpha *= scale;  beta *= scale;  c0 *= scale;  c1 = scale
```
(at 8-bit: c1 = 1). FLOAT format (368-373):
```text
alphaF = alpha/255.0f; betaF = beta/255.0f; c0F = c0/255.0f; c1F = 1/255.0f
```

# 3. The real processing schedule (filterC:231-257)

Per selected plane, IN PLACE on a copy of the source frame
(deblockGetFrame:266-269: copyFrame then d->filter(dst)); fmParallel with
rpStrictSpatial (402-403) - parallel across frames, strictly sequential
within a frame.

```text
GRID: edges every 4 pixels in PLANE coordinates - the H.264 4x4 transform
grid (loops step x+=4, y+=4; each edge call filters a 4-pixel segment).
The SAME 4-grid applies to every plane: on 4:2:0 chroma this lands every
8 luma pixels. There are NO chroma-specific thresholds and NO H.264
chroma-path formula: chroma runs the full luma algorithm (the faithful
"luma-on-chroma" behaviour, confirmed).

ORDER (the load-bearing facts):
  1. Top band (rows 0..3): vertical edges only, left to right:
       for x = 4, 8, ... < width: deblockVerEdge(dstp + x)      (240-241)
  2. dstp += 4*stride                                            (243)
  3. For each band y = 4, 8, ... < height:                       (245-254)
       a. deblockHorEdge(dstp + 0)        (x=0 column block)     (246)
       b. for x = 4, 8, ... < width:
            deblockHorEdge(dstp + x)   THEN                      (249)
            deblockVerEdge(dstp + x)                             (250)
       c. dstp += 4*stride

SEQUENTIAL IN-PLACE DEPENDENCY (critical oracle property): every edge
reads pixels ALREADY MODIFIED by earlier edges in this order. Within a
band, the horizontal edge at (x,y) runs BEFORE the vertical edge at the
same crossing, and the vertical edge at x reads column x+1 which the
vertical edge at x-4 may not touch but the horizontal edges just might;
p2/q2 taps reach into neighbouring, possibly-already-filtered rows.
Any reordering, tiling, or parallelisation of this loop changes output.
This IS Schedule A. (README 5.2; D0 K11.)

COVERAGE: all interior vertical edges (x = 4..width-4 step 4, all rows);
all interior horizontal edges (y = 4..height-4 step 4, all columns).
No edge is processed on the frame border itself.
```

# 4. Edge mathematics, INTEGER (the oracle formulas)

## 4.1 Horizontal edge (deblockHorEdge<int>:82-119)

Edge between row (e-1) and row e; dstp points at row e, x at segment
start. Taps (88-93): sp2=e-3, sp1=e-2, sp0=e-1, sq0=e, sq1=e+1, sq2=e+2.
READ rows e-3..e+2, WRITE rows e-2..e+1 (p1,p0,q0,q1) - confirms the
README Classic oracle contract footprints (D0 K7). Per pixel i=0..3 (95):

```text
ACTIVATION (96, all strict <):
  |p0-q0| < alpha  AND  |p1-p0| < beta  AND  |q0-q1| < beta
SIDE ACTIVITY (97-104):
  ap = |p2-p0|;  aq = |q2-q0|
  c = c0 + (ap<beta ? c1 : 0) + (aq<beta ? c1 : 0)
CORE (106-116):
  avg     = (p0 + q0 + 1) >> 1
  delta   = clamp( (((q0-p0) << 2) + p1 - q1 + 4) >> 3 , -c , c )
  deltap1 = clamp( (p2 + avg - (p1 << 1)) >> 1 , -c0 , c0 )
  deltaq1 = clamp( (q2 + avg - (q1 << 1)) >> 1 , -c0 , c0 )
  p0 = clamp(p0 + delta, 0, peak)
  q0 = clamp(q0 - delta, 0, peak)
  if (ap < beta) p1 = clamp(p1 + deltap1, 0, peak)
  if (aq < beta) q1 = clamp(q1 + deltaq1, 0, peak)
```
Notes: deltap1/deltaq1 clamp to +-c0 (NOT c); p1/q1 writes are gated by
the SAME ap/aq comparisons that widened c; all four writes commit even
though later pixels of the same 4-segment re-read them only via the next
edge (within one edge call, lanes i=0..3 are independent).

## 4.2 Vertical edge (deblockVerEdge<int>:162-194)

Edge between column (e-1) and column e; dstp points at column e, row at
segment start; loop walks 4 ROWS (168, 192). Taps: dstp[-3..+2] within
the row. READ columns e-3..e+2, WRITE columns e-2..e+1. Identical
formulas with p<->dstp[-1],[-2],[-3] and q<->dstp[0],[1],[2] (179-189);
deltaq1 is computed before deltap1 (181-182) - cosmetically different
order, no dependency, identical result.

## 4.3 Integer arithmetic semantics (WATCHPOINTS - D0 K19(b))

```text
WP-1  (x + 4) >> 3 and (x) >> 1 are applied to POSSIBLY NEGATIVE ints:
      C++ arithmetic right shift == floor division by 8 / 2 AFTER the
      +4 bias. This is H.264's exact idiom (bias then floor), NOT
      round-half-away. Zig: signed >> is also arithmetic; replicate
      EXACTLY - do not "improve" with symmetric rounding, @divTrunc
      (truncates toward zero: DIFFERENT for negatives), or float math.
WP-2  avg = (p0+q0+1)>>1 rounds UP on odd sums; the float variant has
      no such bias (section 5). Do not cross-pollinate.
WP-3  >8-bit: thresholds are SCALED 8-bit table values (section 2),
      not re-derived tables; c1 = scale. Replicate the scaling, not a
      "better" table.
WP-4  All intermediates fit i32 comfortably at <=16-bit samples
      ((q0-p0)<<2 bounded by ~2^18); no widening subtleties, but Zig
      code must compute in i32, not the pixel type.
WP-5  c0 comes from the ALPHA index (aIndex), not bIndex (section 2).
      Possibly an upstream historical accident; it is the pinned
      behaviour. FAITHFUL, DO NOT FIX. Any "fix" proposal is a K19
      layer-(a)/K20 quality-validated change, out of 2C scope.
WP-6  Activation comparisons are all STRICT (<). Off-by-one here
      changes activation sets; obligation vectors must pin boundary
      equality cases (|p0-q0| == alpha etc. -> NOT filtered).
```

# 4.4 Tabled decisions register (W3X-directed; future actions)

```text
T-1  WP-5 c0-from-aIndex: 2C stays FAITHFUL. Whether a bIndex-based c0
     would be "better than HolyWu" is TABLED for the Stage 3C quality
     gate, assessed under K20's criteria on W3D+W3C advice; any change
     is a K19 layer-(a) documented deviation, never silent.
T-2  Float support in Classic: D4 SCOPE DECISION on W3D+W3C advice
     (section 5). Integer obligations mandatory in D3; float
     conditional.
T-3  Non-mod-8 geometry policy (pad-filter-crop vs reject vs native
     boundary): D4 SCOPE DECISION on W3D+W3C advice (section 6).
     Edge-replication behaviour was previously discussed in the README
     section 6 frame-boundary work (D0 K3); that discussion plus this
     document's facts are the assessment inputs. Never fires for the
     project's real mod-8 material.
```

# 5. Float path (K22 fact established)

The pinned source SUPPORTS 32-bit float input, via full template
specialisations deblockHorEdge<float>:121-159 and
deblockVerEdge<float>:196-229 and thresholds at 368-373. The float
algorithm is NUMERICALLY DIFFERENT from integer, not merely re-typed:

```text
avg   = (p0 + q0) * 0.5f            (146: NO +1 rounding bias)
delta = clamp(((q0-p0)*4.0f + p1 - q1) * 0.125f, -c, c)   (147: NO +4)
delta*1 = clamp((s2 + avg - s1*2.0f) * 0.5f, -c0, c0)     (148-149)
writes: p0 += delta etc. WITH NO 0..peak CLAMP (151-156).
```
Consequence for 2C: IF Classic accepts float input, the float oracle is
this bias-free unclamped variant and the K22/V&T 3.8 tolerance-numbers
duty activates at D4. Whether Classic accepts float is a D4 SCOPE
DECISION (Deblock4's Stage 1C creation currently accepts what its
validation accepts; alignment is a D4 item). D3 writes obligations for
the integer paths as mandatory and the float path as conditional on that
decision.

# 6. Frame geometry: the mod-8 pad-filter-crop behaviour

deblockCreate:290-291, 375-395, 406-427. If width%8 or height%8 is
nonzero, HolyWu WRAPS ITSELF: it Point-resizes the input up to the next
multiple of 8 with src_width/src_height set to the ENLARGED size (edge
replication of the right/bottom border), creates the filter on the
padded clip, then invokes std.Crop to cut the result back. Facts:

```text
- Padding is to mod EIGHT, although the edge grid is 4 (history: the
  original plugin's block size / SSE4 path convenience).
- For mod-8 input there is NO pad/crop and no resize dependency.
- PAL 720x576 and all Deblock4 target geometries (704x576, 352x288 etc.)
  are mod-8: the pad path NEVER runs for the project's real material.
- Boundary policy inside the filter is simply "interior edges only"
  (section 3 COVERAGE); padding exists so the 4-grid divides evenly and
  edge taps (e-3..e+2) never leave the padded frame.
- D4 DECISION: whether Classic replicates pad-filter-crop for non-mod-8
  input, restricts input to mod-8 with a creation error, or handles the
  boundary natively. Faithfulness argues pad-equivalent behaviour;
  README section 6 (corrected frame-boundary policy, D0 K3) governs the
  discussion. Deferred to D4 with this section as the factual base.
```

# 7. Execution model facts

deblockGetFrame:259-276: arInitial requests n; arAllFramesReady takes
src, copyFrame, filter in place, returns dst. fmParallel +
rpStrictSpatial (402-403). Single-frame temporal footprint; no frame
properties are read or written by the filter itself. Errors are
"Deblock: " + message via mapSetError (396-399).

# 8. Correspondence to Deblock4 Classic (established naming)

```text
quant   -> strength (default 25 matches, range 0..60 matches)
aoffset -> boundary_strength_offset (alpha side; also selects c0, WP-5)
boffset -> side_activity_offset (beta side)
planes  -> planes (default all matches; duplicate -> error matches 1C)
opt     -> superseded by Classic's backend token machinery
pad     -> no Classic equivalent yet (D4, section 6)
Offset CLAMP semantics (section 2, lines 334-337) are part of the
oracle: Classic must clamp offsets the same way BEFORE indexing. The 1C
creation-error table (K16) validates strength range only; offset
clamping is resolver behaviour, not an error - D4 confirms alignment.
```

# 9. Binding Knowledge Checklist (D0 v1_3)

```text
K7  footprints CONFIRMED against source (sections 4.1/4.2).
K11 Schedule A documented as the real loop order incl. sequential
    in-place dependency (section 3); no Schedule B content imported.
K19 this whole document is the layer-(b) baseline; WP-1..WP-6 flag the
    "more accurate" temptations explicitly.
K20 any deviation proposal (e.g. WP-5 "fix") must meet the 15.2
    criteria; none proposed in 2C.
K22 float-existence fact established (section 5): float path EXISTS;
    tolerance-numbers duty is conditional on the D4 float decision.
K23 fmParallel/rpStrictSpatial and determinism facts recorded (sec 7).
K1/K3/K24/K25: no vector semantics, no batch tails, no kernel
    instantiation, and no detection logic appear in this document by
    design; they bind D4, not D2.
Sweep (D0 6): W3C's independent verification of THIS document against
    the pinned source is the two-sided sweep for D2.
```

# Appendix A - threshold tables, reproduced from deblock.cpp:40-79

alphas[61] (deblock.cpp:40-52):
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4,4,5,6,7,8,9,10,12,13,15,17,20,22,25,
28,32,36,40,45,50,56,63,71,80,90,101,113,127,144,162,182,203,226,255,
255,255,255,255,255,255,255,255,255,255

betas[61] (deblock.cpp:54-66):
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,2,2,3,3,3,3,4,4,4,6,6,7,7,8,8,9,9,
10,10,11,11,12,12,13,13,14,14,15,15,16,16,17,17,18,18,19,20,21,22,23,
24,25,26,27

cs[61] (deblock.cpp:68-79):
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,2,2,2,
2,3,3,3,4,4,5,5,6,7,8,8,10,11,12,13,15,17,19,21,23,25,27,29,31,33,35

---

Revision: v1.1 (2026-08-02) added 4.4 tabled-decisions register (T-1..T-3)
per W3X direction. v1.0 (2026-08-02) initial inspection of the pinned r9
source.
Coder independent verification pending (D0 section 6 two-sided sweep).
