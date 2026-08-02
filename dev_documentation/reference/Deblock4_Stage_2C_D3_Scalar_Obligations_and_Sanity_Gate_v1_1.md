# Deblock4 - Stage 2C Independent Scalar Obligations and Sanity Gate

**Deliverable:** W3D-2C-D3
**Version:** 1.1
**Date:** 2026-08-02
**Basis:** the ORACLE-CONSTRUCTION EXCEPTION (charter G7; V&T 20.2; D0 K9):
the Stage 2C scope that constructs the Classic ReleaseSafe scalar oracle is
accepted against THESE independently authored obligations plus the loose
whole-image sanity gate in section 9 - not against a pre-existing oracle.
**Independence statement:** every expected value below was derived by W3D
from the D2-documented formulas via hand arithmetic cross-checked by the
transparent reference model in Appendix B (authored from the D2 TEXT, not
by running HolyWu, and never shared as implementation source). The coder's
Zig oracle is written from D2 + the D4 scope; these vectors then judge it.
**Encoding:** US-ASCII; CRLF.

---

# 1. How obligations bind the delivery

```text
- Every O-item below maps to AT LEAST ONE Zig unit test in the 2C
  delivery, asserting the EXACT expected values (integer: no tolerance).
- Tests run in the standing three-mode matrix; per K10 (V&T 3.7) the
  ReleaseSafe and ReleaseFast oracle outputs must be byte-identical for
  every O-vector and for the O-4/G composite frames.
- Vectors are deliberately implementation-independent (D0 K5/G9): they
  discriminate floor-vs-truncate shifts (WP-1), strict-vs-nonstrict
  comparisons (WP-6), clamp bounds, and gating - the places a plausible
  reimplementation or a miscompile diverges.
- Notation: an edge lane is (p2,p1,p0,q0,q1,q2) -> writes (p1,p0,q0,q1),
  per D2 4.1/4.2. Every single-edge vector MUST be exercised in BOTH
  orientations: horizontal (taps across rows) and vertical (taps across
  columns); expected values are identical, footprint mapping per D2.
- Default parameters unless stated: 8-bit, quant/strength=25, offsets 0
  -> alpha=13, beta=4, c0=1, c1=1, peak=255 (O-1 V1).
```

# 2. O-1 Threshold derivation obligations

For (strength, aoffset, boffset, bits) the resolved
(alpha, beta, c0, c1, peak) must equal, after the D2 section-2 clamp
sequence and scaling:

```text
V1  (25,   0,  0,  8) -> (13,   4,    1,   1,   255)
V2  ( 0,   0,  0,  8) -> ( 0,   0,    0,   1,   255)   [see O-5c]
V3  (60,   0,  0,  8) -> (255, 27,   35,   1,   255)
V4  (30, -10, +5,  8) -> ( 7,  10,    0,   1,   255)   [c0=0 with c1=1]
V5  (50, +10,  0,  8) -> (255, 18,   35,   1,   255)   [aoffset +10 is
                                                        IN-RANGE for
                                                        strength 50
                                                        (legal -50..10);
                                                        aIndex=60]
V6  (25,   0,  0, 16) -> (3328, 1024, 256, 256, 65535) [scaled, c1=scale]
```
O-1b REJECTION (Classic resolver, not HolyWu): an offset outside
-strength..60-strength is a CREATION ERROR, never clamped (README 3.14,
error table v1_1, D0 K16). E.g. strength=25, boundary_strength_offset=40
-> "Classic: boundary_strength_offset is out of range for strength";
strength=25, side_activity_offset=-30 -> the side_activity error. These
are creation-path obligations (checked at 1C-style creation, distinct
from the pixel oracle) and they bound the differential harness domain.

V4 pins the c0-from-aIndex behaviour (D2 WP-5): c0 follows the ALPHA
index (offsets IN-RANGE: strength 30 legal -30..30). V5 pins the top of
the legal alpha range. CORRECTED per W3C F9: the earlier V5 used an
OUT-OF-RANGE aoffset importing HolyWu's clamp - Classic REJECTS
out-of-range offsets (README 3.14 + error table v1_1), it does NOT clamp.
All O-1 magnitude vectors here are Classic-LEGAL. HolyWu's clamp is an
external layer-(b) fact (D2 section 8), tested only via the differential
harness on the legal shared domain, never as a Classic obligation.

# 3. O-2 Activation obligations (strict comparisons, WP-6)

```text
A1  (100,100,100,113,113,113): |p0-q0| = 13 = alpha -> NOT filtered
    (all four outputs byte-identical to inputs).
A2  (100,100,100,112,112,112): |p0-q0| = 12 < alpha -> filtered;
    expected (p1,p0,q0,q1) = (101,103,109,111).
A3  (100,104,100,110,110,110): |p1-p0| = 4 = beta -> NOT filtered.
A4  strength 0 (O-1 V2): alpha = 0 -> NOTHING ever activates
    (|p0-q0| < 0 impossible); see O-5c whole-frame identity.
```

# 4. O-3 Single-edge arithmetic obligations

All at defaults (O-1 V1) unless stated; expected (p1,p0,q0,q1):

```text
B1  (100,100,100,110,110,110) -> (101,103,107,109)
      delta raw (((10)<<2)+100-110+4)>>3 = 34>>3 = 4, clamped to c=3;
      deltap1 = 5>>1 = 2 -> clamp +-c0 = 1; deltaq1 = (-5)>>1 = -3
      (FLOOR) -> clamp -1.
B2  (110,110,110,100,100,100) -> (109,107,103,101)
      delta raw = (-26)>>3 = -4 (FLOOR; truncation would give -3 and a
      DIFFERENT final answer) -> clamp -3. THE WP-1 discriminator.
      EXECUTION-PIN NOTE (W3C F2, D0 K26): the -4 expected value assumes
      floor signed-shift semantics. For the Deblock4 Zig oracle this is a
      hard OBLIGATION (signed >>, never @divTrunc). As the value the
      external HolyWu run must also produce, it inherits the K26 pin
      (opt=1 reference build, fixed compiler/flags); until that build is
      pinned, B2/B4/B5's negative-shift expectations are oracle-INTENDED,
      not yet externally reproduced.
B3  (200,100,100,110,110,110) -> (100,102,108,109)
      ap = 100 >= beta: c = 2 (not 3), delta clamped to 2, p1 NOT
      written; aq < beta still writes q1. Pins c-widening AND write
      gating sharing the same comparisons.
B4  (0,0,0,9,9,9) -> (1,3,6,8)          [low-value probe, deltas
      +3/+1/-1 with floor on (-4)>>1 = -2 -> clamp -1]
B5  quant=60 (O-1 V3): (195,195,195,5,5,5) -> (160,158,42,40)
      delta raw = (-566)>>3 = -71 (floor) -> clamp -c = -37;
      deltap1 raw = (-95)>>1 = -48 -> clamp -35; deltaq1 raw = 95>>1
      = 47 -> clamp +35. Pins large-c and +-c0 clamps at high strength.
B6  16-bit (O-1 V6): (25600,25600,25600,28160,28160,28160)
      -> (25856,26368,27392,27904). Pins scaled-threshold arithmetic
      including c1 = 256 in the c-widening.
Structural: the 0..peak result clamps (deblock.cpp:111-116/184-189)
must be present in source and asserted by code-level unit test; no
natural in-range vector reaches them at these parameters.
```

# 5. O-4 Whole-schedule composite obligation (Schedule A order)

Input: one 8x8 8-bit plane, strength 25, offsets 0:

```text
rows 0-3:  100 100 100 100 110 110 110 110
rows 4-7:  112 112 112 112 112 112 112 112
```
Applying the FULL D2 section-3 schedule (top-band vertical edges; then
per band: horizontal at x=0, then per x: horizontal THEN vertical;
sequential, in place) must yield EXACTLY:

```text
100 100 101 103 107 109 110 110
100 100 101 103 107 109 110 110
101 101 102 104 108 110 110 110
103 103 104 106 109 110 111 111
109 109 109 109 110 110 111 111
111 111 111 111 111 111 111 111
112 112 112 112 112 112 112 112
112 112 112 112 112 112 112 112
```
ORDER-SENSITIVITY obligation: with the crossing order deliberately
swapped (vertical before horizontal at each x), the output DIFFERS from
the above; first difference at (row 2, col 5): correct 110, swapped 109.
The delivery's test must demonstrate the inequality (proving the
implementation is not accidentally order-independent) and must NOT ship
the swapped order anywhere outside the test.
TOP-BAND obligation: after the schedule, rows 0-1 equal the values shown
(modified ONLY by the top-band vertical edge; no horizontal edge touches
rows 0-1).

# 6. O-5 Plane and format obligations

```text
a  LUMA-ON-CHROMA (D2 section 3; D0 K11): running the O-4 frame as a
   chroma plane produces the IDENTICAL output matrix - same thresholds,
   same 4-grid in the plane's own coordinates, no chroma-specific path.
b  PLANE SELECTION: an unprocessed plane is a COPY path - byte-identical
   for every format (V&T 20.1 copy/share; K19 layer (c) strictest case).
c  STRENGTH 0 IDENTITY: the whole output frame is byte-identical to the
   source for any content (O-1 V2 + O-2 A4).
d  16-BIT: O-4 rerun with all inputs and expecteds scaled x256 must hold
   with the V6 thresholds (the model derivation confirms exact x256
   correspondence for this frame; the test asserts the literal values).
```

# 7. O-6 Footprint obligations (D0 K7)

```text
a  The four 2x2 corner blocks of any processed plane are byte-identical
   to the source (no vertical edge writes cols 0,1,W-2,W-1; no
   horizontal edge writes rows 0,1,H-2,H-1; only corners escape both).
b  Single-edge tests assert bytes OUTSIDE the write footprint
   (p2/q2 taps and beyond) are unmodified.
c  Interior-only coverage per D2 section 3: no edge at x=0/y=0 or at the
   frame's far border; mod-8 input guarantees taps stay in-frame.
```

# 8. Conditional float obligations (T-2)

Deferred pending the D4 float decision (D2 section 5, register T-2). If
Classic adopts float input, this document gains a versioned float
appendix (bias-free, unclamped formulas; K22/V&T 3.8 tolerance numbers
become due). Integer obligations above are unconditional.

# 9. The loose whole-image sanity gate (exception clause companion)

Frame G: 64x64 8-bit, 8x8-block DC checkerboard of values 100/108
(inter-block step 8 < alpha 13). At strength 25, offsets 0, the oracle
must satisfy ALL of:

```text
G1  Mean absolute discontinuity across all 8-aligned block boundaries
    (both directions; source value exactly 8.000) is reduced by AT
    LEAST 40 percent. (Derivation model achieves 78.7 percent; the
    bound is deliberately loose - the SHARP external check is the D4
    HolyWu differential harness, K19 layer (b).)
G2  Every output sample is in 0..255.
G3  The four 2x2 corners are byte-identical to the source (O-6a).
G4  Two consecutive runs produce byte-identical output (determinism,
    K23).
```

# 10. Binding Knowledge Checklist (D0 v1_3)

```text
K5/G9  vectors are implementation-independent discriminators (B2, B5).
K26    B2/B4/B5 floor-shift expectations carry the external-oracle
       execution-pin dependency; the Zig-oracle floor obligation is
       unconditional (Appendix B uses Python floor >>).
K7     footprints bound by O-6; confirmed source-true in D2.
K8     this document IS the "never HolyWu-only" oracle basis.
K9     acceptance basis under the oracle-construction exception; after
       2C acceptance, layer-(c) differential discipline takes over.
K10    RS-vs-RF byte-identity duty attached to every O-test (sec 1).
K11    O-4 pins Schedule A order; no Schedule B content present.
K16    O-1b encodes the ratified Classic offset-REJECTION obligations
       (never clamp); no creation-string or using-echo surface altered.
K19    these are internal-layer obligations; the external layer-(b)
       harness is D4's; WP-1/WP-5/WP-6 pinned by B2, V4, A1/A3.
K22    float conditional per section 8 (T-2).
K24    obligations are kernel-agnostic: they bind outputs, leaving D4
       free to author the shared-kernel comptime shape.
Sweep  (D0 sec 6): W3C reviews THIS document (with D4) - feasibility,
       ambiguity, gaps, plus the independent doc-set sweep.
```

# Appendix A - consolidated vector quick table

Single-edge (p2,p1,p0,q0,q1,q2) -> (p1,p0,q0,q1), defaults unless noted:
```text
A1 100,100,100,113,113,113 -> unchanged (not filtered)
A2 100,100,100,112,112,112 -> 101,103,109,111
A3 100,104,100,110,110,110 -> unchanged (not filtered)
B1 100,100,100,110,110,110 -> 101,103,107,109
B2 110,110,110,100,100,100 -> 109,107,103,101
B3 200,100,100,110,110,110 -> 100,102,108,109
B4 0,0,0,9,9,9             -> 1,3,6,8
B5 (q60) 195,195,195,5,5,5 -> 160,158,42,40
B6 (16b) 25600x3,28160x3   -> 25856,26368,27392,27904
```

# Appendix B - derivation record (transparent reference model)

Authored by W3D from the D2 text solely to derive/cross-check the
expected values above; retained verbatim as the derivation record. It is
NOT implementation source and must never be translated into the
delivery.

```python
alphas=[0]*16+[4,4,5,6,7,8,9,10,12,13,15,17,20,22,25,28,32,36,40,45,50,
56,63,71,80,90,101,113,127,144,162,182,203,226]+[255]*11
betas=[0]*16+[2,2,2,3,3,3,3,4,4,4,6,6,7,7,8,8,9,9,10,10,11,11,12,12,13,
13,14,14,15,15,16,16,17,17,18,18,19,20,21,22,23,24,25,26,27]
cs=[0]*21+[1]*10+[2,2,2,2,3,3,3,4,4,5,5,6,7,8,8,10,11,12,13,15,17,19,
21,23,25,27,29,31,33,35]
def clamp(v,lo,hi): return max(lo,min(hi,v))
def thresholds(q,ao,bo,bits=8):
    ao=clamp(ao,-q,60-q); bo=clamp(bo,-q,60-q)
    ai=clamp(q+ao,0,60); bi=clamp(q+bo,0,60); s=1<<(bits-8)
    return alphas[ai]*s,betas[bi]*s,cs[ai]*s,s,(1<<bits)-1
def edge6(p2,p1,p0,q0,q1,q2,al,be,c0,c1,pk):
    if not(abs(p0-q0)<al and abs(p1-p0)<be and abs(q0-q1)<be):
        return p1,p0,q0,q1,False
    ap,aq=abs(p2-p0),abs(q2-q0)
    c=c0+(c1 if ap<be else 0)+(c1 if aq<be else 0)
    avg=(p0+q0+1)>>1
    d=clamp((((q0-p0)<<2)+p1-q1+4)>>3,-c,c)      # Python >> is floor
    dp=clamp((p2+avg-(p1<<1))>>1,-c0,c0)
    dq=clamp((q2+avg-(q1<<1))>>1,-c0,c0)
    return (clamp(p1+dp,0,pk) if ap<be else p1, clamp(p0+d,0,pk),
            clamp(q0-d,0,pk), clamp(q1+dq,0,pk) if aq<be else q1, True)
def full(frame,q=25,ao=0,bo=0,bits=8):
    al,be,c0,c1,pk=thresholds(q,ao,bo,bits)
    f=[r[:] for r in frame]; H=len(f); W=len(f[0])
    def ver(x,y0):
        for r in range(y0,y0+4):
            a=edge6(f[r][x-3],f[r][x-2],f[r][x-1],f[r][x],f[r][x+1],
                    f[r][x+2],al,be,c0,c1,pk)
            f[r][x-2],f[r][x-1],f[r][x],f[r][x+1]=a[0],a[1],a[2],a[3]
    def hor(x0,y):
        for i in range(4):
            c=x0+i
            a=edge6(f[y-3][c],f[y-2][c],f[y-1][c],f[y][c],f[y+1][c],
                    f[y+2][c],al,be,c0,c1,pk)
            f[y-2][c],f[y-1][c],f[y][c],f[y+1][c]=a[0],a[1],a[2],a[3]
    for x in range(4,W,4): ver(x,0)
    for y in range(4,H,4):
        hor(0,y)
        for x in range(4,W,4): hor(x,y); ver(x,y)
    return f
```

---

Revision: v1.1 (2026-08-02) applied W3C D2 findings reaching D3: F9
replaced the out-of-range V5 with an in-range vector and added O-1b
(Classic REJECTS out-of-range offsets per ratified policy); F2 attached
the K26 execution-pin note to floor-shift vectors B2/B4/B5. Integer
derivations otherwise unchanged (D2 formula transcription verified PASS
by W3C). v1.0 initial authoring in parallel with D2 verification. To be
reviewed by W3C together with D4.
