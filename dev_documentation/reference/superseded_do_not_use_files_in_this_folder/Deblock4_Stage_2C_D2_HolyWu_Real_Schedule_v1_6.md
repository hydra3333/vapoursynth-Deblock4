# Deblock4 - HolyWu Real Schedule (Stage 2C, D-CLASSIC-4 inspection)

**Deliverable:** W3D-2C-D2
**Version:** 1.6
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
planes   absent -> all planes (309-312: process[i] = num_planes<=0)
         is the SOURCE BRANCH. Whether a Python caller can deliver an
         explicit EMPTY registered array is a HOST-API fact, not a
         deblock.cpp fact; current project evidence (Toolchain F7, D0 K12)
         is that planes=[] is rejected at the Python boundary BEFORE the
         callback. Out-of-range or duplicate plane -> error (317-321).
opt      0 auto / 1 forceC / 2 forceSSE4 (326,331-332,349-359).
         ORACLE-PATH SELECTOR, not merely a backend label: under
         DEBLOCK_X86 the source REPLACES filterC with filterSSE4 when
         (opt==0 && iset>=5) || opt==2 (349-359). Therefore opt=0 auto
         COMMONLY SELECTS SSE4 on a capable x86 host; only opt=1 (or a
         proven no-DEBLOCK_X86 build) leaves the C/scalar path selected.
         The layer-(b) oracle is HolyWu C/scalar, so the differential
         harness MUST force opt=1; omitting opt does NOT select the
         oracle. (W3C F1; D0 K26.)
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
(deblockGetFrame:266-269: copyFrame then d->filter(dst)). fmParallel
PERMITS concurrent frame callbacks (402-403); the intra-frame loop is
sequential by source construction (section 7 nuance, W3C F5/F6).

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

SEQUENTIAL IN-PLACE DEPENDENCY (critical oracle property): edges may
read pixels already modified by earlier edges, so the SPECIFIED SEQUENCE
IS OUTPUT-DEFINING - reordering CAN change output (not "always does";
the first executed vertical edge has no predecessor). The exact
source-derived overlaps (W3C F5, filterC:240-254 with the edge
footprints 88-116/168-192):
  1. a vertical edge at x can read column x-3, written by the preceding
     vertical edge at x-4;
  2. at an interior crossing H(x,y) runs immediately before V(x,y), and
     V(x,y) reads rows y and y+1 and columns the H call just wrote;
  3. V(x,y) also reads columns written by H(x-4,y);
  4. a horizontal edge in the next row band can read rows written by both
     edge kinds in the preceding band.
Because these overlaps exist, any reordering, tiling, or intra-frame
parallelisation MAY change output; the oracle must reproduce this exact
order. This IS Schedule A. (README 5.2; D0 K11.)

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
WP-1  (x + 4) >> 3 and (x) >> 1 are applied to POSSIBLY NEGATIVE
      signed ints, and (q0-p0)<<2 left-shifts a possibly-negative value.
      SOURCE-EXPRESSION FACT (pinned): the source spells these shifts;
      the intended idiom is H.264's bias-then-floor, NOT round-half-away.
      EXECUTION FACT (NOT pinned by D1 bytes, W3C F2): the actual result
      for negatives depends on the compiler's signed-shift rule and
      language mode - the snapshot excludes build metadata. Treat "floor"
      as the INTENDED oracle semantics, to be PINNED per D0 K26 (opt=1
      reference build), not as a fact provable from deblock.cpp alone.
      SHARPER STILL (W3C revision F1): the two shift directions are
      DIFFERENT classes - right-shift of a negative is implementation-
      defined (pinnable), but (q0-p0)<<2 with q0<p0 is C++ UNDEFINED
      BEHAVIOUR in the relevant language modes; only the observed output
      of ONE exact reference binary is a fact (K26: mandatory DLL hash +
      K26 signed-shift behavioural sentinels (B2/B5 negative-LEFT-shift
      UB probes; B4 negative-RIGHT-shift side-delta probe) + rebuild
      rule).
      For the Deblock4 Zig oracle the OBLIGATION is explicit: compute the
      delta core with WELL-DEFINED arithmetic - i32 multiply by 4, never
      a negative-left-shift analogue - and floor semantics for the
      divisions (signed >>), never @divTrunc (truncates toward zero:
      DIFFERENT for negatives), symmetric rounding, or float math. D3
      vectors B2/B4/B5 assume floor and inherit the K26 pin+sentinel
      dependency until the reference binary is pinned.
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
T-2  Float support in Classic: RESOLVED by D4 S1 (W3X-ratified) - Stage
     2C is integer-only and REFUSES float at creation (16-bit and 32-bit
     float alike, sample-type based). This section's float FACTS are
     unchanged and carried forward for the later bounded Deblock4 float
     step; they describe no Stage 2C behaviour.
T-3  Non-mod-8 geometry policy: NOT OPEN (corrected per W3C F8). Classic
     is SETTLED by README 6.1/6.3 - native complete-footprint bounds,
     leave unsupported extreme edges unchanged, no whole-frame pad/crop
     wrapper. HolyWu's pad-filter-crop stays documented as an external
     layer-(b) fact only. Retained here as a pointer, not a decision.
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
SOURCE vs EXECUTION (W3C F3, D0 K6/K26): the source spells ORDINARY
multiply/add expression trees with no fused intrinsic and no explicit FP
mode; whether the external build contracts or reassociates is an
EXECUTION fact fixed by the pinned compiler/flags (K26), not by these
bytes. Do NOT project Deblock4's own .strict rule onto an un-pinned
HolyWu build.

NON-FINITE BEHAVIOUR (W3C F4 - algorithm-bearing, previously omitted):
HolyWu has NO complete-footprint finite guard. The activation gate reads
only p1,p0,q0,q1 (136/204); p2,q2 enter later via ap,aq. So a non-finite
OUTER tap does not necessarily suppress the core p0/q0 write:
  non-finite p2 -> ap<beta false -> p-side c-widening and p1 write
    suppressed, but the core p0/q0 delta may still compute and write;
  non-finite q2 -> symmetric.
This DIFFERS MATERIALLY from Deblock4's settled canonical float policy
(README 8.6): if ANY sample in the complete read footprint is non-finite,
that edge position is left UNCHANGED with original bit patterns
preserved. Another reason the external comparison is legal-shared-domain
only, and float input (finite nominal-range video) if adopted.

Consequence for 2C: RESOLVED - D4 S1 refuses float in Stage 2C, so these
float facts describe NO 2C behaviour. They are carried forward as the
basis for the later Deblock4 float step, where the float oracle is this
bias-free unclamped variant, the K22/V&T 3.8 tolerance-numbers duty
activates, and the non-finite DIVERGENCE above is the documented
external-only fact. D3 integer obligations are unconditional.

# 6. Frame geometry: the mod-8 pad-filter-crop behaviour

deblockCreate:290-291, 375-395, 406-427. If width%8 or height%8 is
nonzero, HolyWu WRAPS ITSELF: it Point-resizes the input up to the next
multiple of 8 with src_width/src_height set to the ENLARGED size, creates
the filter on the padded clip, then invokes std.Crop to cut the result
back. (HOW the resize invents the padded samples is a host resize-plugin
contract, not asserted from these bytes - see below, W3C F3/F7.) Facts:

```text
- Padding is to mod EIGHT though the edge grid is 4 (padding size is a
  SOURCE FACT; any rationale for "why 8" is not established by these
  bytes and is not asserted here - W3C F7).
- For mod-8 input there is NO pad/crop and no resize dependency (source
  fact, 290-291).
- The Point resize's out-of-source EXTENSION rule (how it invents the
  padded samples) is a HOST resize-plugin contract, NOT a deblock.cpp
  fact; do not assert "edge replication" from these bytes (W3C F7).
- The named PAL geometries (720x576, 704x576, 352x288) are mod-8, so the
  pad path does not run FOR THEM; but the public filter can receive other
  geometries, so "never runs" is scoped to the project's stated material,
  not the filter in general (W3C F7).
- Boundary policy inside the filter is "interior edges only" (section 3
  COVERAGE).
- NOT A D4 CHOICE (corrected per W3C F8): Classic's non-mod-8 policy is
  ALREADY SETTLED by README 6.1/6.3 - process only edges whose complete
  footprint is in-plane, leave unsupported extreme edges unchanged, and
  NEVER use a whole-frame pad/resize/crop wrapper. HolyWu's pad-filter-
  crop is an EXTERNAL layer-(b) fact documented here, never a Classic
  behaviour to reproduce. See revised T-3.
```

# 7. Execution model facts

deblockGetFrame:259-276: arInitial requests n; arAllFramesReady takes
src, copyFrame, filter in place, returns dst. fmParallel +
rpStrictSpatial (402-403). Single-frame temporal footprint; no frame
properties are read or written by the filter itself.
NUANCE (W3C F6): the intra-frame loop is sequential BY SOURCE
CONSTRUCTION; fmParallel PERMITS framework scheduling ACROSS frames but
does not itself prove any run is concurrent, and rpStrictSpatial is the
declared dependency pattern, not the reason the loop is sequential.
ERRORS (W3C F10): CAUGHT plugin validation exceptions are emitted as
"Deblock: " + message (396-399). resize.Point / std.Crop invocation
failures are copied from mapGetError(ret) UNPREFIXED (383-388, 415-420).
The "Deblock: " prefix therefore covers caught validation errors only.

# 8. Correspondence to Deblock4 Classic (established naming)

```text
quant   -> strength (default 25 matches, range 0..60 matches)
aoffset -> boundary_strength_offset (alpha side; also selects c0, WP-5)
boffset -> side_activity_offset (beta side)
planes  -> planes (default all matches; duplicate -> error matches 1C)
opt     -> superseded by Classic's backend token machinery
pad     -> HolyWu EXTERNAL-ONLY wrapper; NO Classic equivalent BY
           SETTLED POLICY (README 6.1/6.3; D0 section 5) - not a future
           decision (W3C F4)
Offset handling - CORRECTED per W3C F9 (my v1.1 text reversed ratified
policy). Two DISTINCT things:
  HolyWu EXTERNAL (layer-b fact): clamps aoffset/boffset to
    -quant..60-quant BEFORE table indexing (334-337).
  deblock4.Classic PUBLIC RESOLVER (ratified, README 3.14 + creation-
    error table v1_6 - rows unchanged since v1_1, D0 K16): out-of-range
    offset is a CREATION ERROR
    ("Classic: boundary_strength_offset is out of range for strength" /
    "...side_activity_offset..."), NEVER silently clamped. Legal range
    -strength..60-strength.
  The two are NOT to be reconciled by making Classic clamp. The external
  differential harness compares only the LEGAL SHARED DOMAIN (in-range
  offsets), where both resolvers agree on the resulting indices.
```

# 9. Binding Knowledge Checklist (D0 v1_8)

```text
K7  footprints CONFIRMED against source (sections 4.1/4.2).
K11 Schedule A documented as the real loop order incl. sequential
    in-place dependency (section 3); no Schedule B content imported.
K19 this whole document is the layer-(b) baseline; WP-1..WP-6 flag the
    "more accurate" temptations explicitly.
K20 any deviation proposal (e.g. WP-5 "fix") must meet the 15.2
    criteria; none proposed in 2C.
K22 float-existence fact established (section 5): float path EXISTS; its
    non-finite behaviour is documented (W3C F4). Stage 2C REFUSES float
    (D4 S1); the tolerance-numbers duty is carried forward to the later
    float step, not a 2C obligation.
K23 fmParallel/rpStrictSpatial and determinism facts recorded (sec 7).
K3  APPLIES to D2 (corrected per W3C F11): D2 documents HolyWu's real
    frame-boundary behaviour (section 6) AND records that Classic's
    non-mod-8 policy is SETTLED, not open (T-3). Not deferred to D4.
K6  APPLIES to D2 (added per W3C F11): float account separates the
    source-EXPRESSION fact from the external-EXECUTION fact (section 5).
K12 relevant (W3C F11): planes=[] reachable-Python behaviour is a host
    fact (Toolchain F7), distinguished from the num_planes<=0 source
    branch (section 1).
K16 relevant (W3C F11): section 8 offset handling defers to the ratified
    Classic offset-error obligations, not HolyWu's clamp.
K26 APPLIES to D2: WP-1 floor semantics and float contraction are
    EXECUTION facts to be pinned by the reference build, not proved by
    D1 bytes (sections 4.3, 5); opt=1 forces the C/scalar oracle
    (section 1).
K1/K24/K25: no vector semantics, no kernel instantiation, and no
    detection logic appear here by design; they bind D4, not D2.
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

Revision: v1.6 (2026-08-03) W3C v1.5-package review F1: offset-error
citation points at the current table v1_6 (rows unchanged since v1_1).
v1.5 (2026-08-03) W3C v1.4-package review: F5 WP-1 summary line
corrected to the K26 signed-shift wording with B4 distinguished; F6.3
checklist heading updated to D0 v1_8. v1.4 (2026-08-03) W3C
updated-package F6: T-2, the 2C-
consequence paragraph and K22 marked RESOLVED by D4 S1 (float refused in
2C); float source-facts unchanged and carried forward, not presented as
open. v1.3 (2026-08-03) applied W3C revision-review local edits: F3
removed the unsupported edge-replication assertion from the section-6
opening; F4 corrected the section-8 pad mapping row to settled-policy
wording; F5 fixed the residual fmParallel overstatement in section 3;
WP-1 aligned with the K26 rewrite (negative-left-shift UB class; Zig
multiply-by-4 corollary). v1.2 (2026-08-02) resolved W3C D2 verification
findings
F1-F11: F1 opt oracle-path selector; F2/F3 source-expression vs
execution-semantics split (K26); F4 HolyWu non-finite behaviour
documented; F5 dependency prose made precise; F6 host-API vs source-
branch distinctions; F7 pad extension/history/"never runs" scoped; F8
T-3 collapsed to SETTLED (README 6.1/6.3); F9 offset policy corrected
(Classic rejects, does not clamp); F10 error-prefix scope; F11 checklist
corrected. v1.1 added 4.4 tabled-decisions register. v1.0 initial
inspection of the pinned r9 source.
Coder independent verification pending (D0 section 6 two-sided sweep).
