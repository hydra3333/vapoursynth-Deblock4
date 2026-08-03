# Deblock4 - Stage 2C Mandatory Differential Corpus (D4 H6 addendum)

**Deliverable:** W3D-2C-D4-ADDENDUM-B
**Version:** 1.1
**Date:** 2026-08-03
**Author:** W3D
**Purpose:** the EXACT authority-fixed invocation matrix required by D4
v1_3 H6 (W3C revised-package F7): formats including subsampled chroma,
dimensions, bit depths, plane selections, strengths/offsets, closed-form
synthetic pixel definitions (no seed needed), and per-case non-vacuity
conditions - fixed here, never coder-selected after seeing results.
**Encoding:** US-ASCII; CRLF.

---

# 1. Synthetic frame definitions (closed-form, deterministic)

```text
CB(W,H,lo,hi)  8x8-block DC checkerboard:
               sample(r,c) = lo if ((r/8)+(c/8)) mod 2 == 0 else hi
               (integer division; identical formula per plane at that
               plane's OWN dimensions).
CB-A  = CB(W,H, 100*S, 108*S)   step  8*S  (S = 1<<(bits-8))
CB-B  = CB(W,H, 100*S, 103*S)   step  3*S  (survives alpha as low as 4)
```
Every plane of a multi-plane case is filled with the SAME formula
evaluated at that plane's actual dimensions (which for subsampled chroma
differ from luma - the point of K28). All dimensions below are mod-8, so
neither implementation pads and the eligibility tests are vacuous.

# 2. The mandatory matrix (17 cases)

All cases: Classic backend="x86_64_v1_baseline"; HolyWu opt=1 (H5);
2 identical frames per clip (proves frame-loop determinism cheaply).
"NV >= 1" = non-vacuity: at least one changed sample in EVERY selected
plane (derivation-model counts shown as evidence the bound is safe).

```text
ID   format        luma WxH  bits  planes     str  aoff boff  frame  NV
C01  GRAY8         64x64      8    omitted     25    0    0   CB-A   >=1 (3028)
C02  GRAY8         64x64      8    omitted      0    0    0   CB-A   IDENTITY
C03  GRAY8         64x64      8    omitted     60    0    0   CB-A   >=1 (3287)
C04  YUV420P8      64x64      8    omitted     25    0    0   CB-A   >=1/plane
                                                                (chroma 32x32: 680)
C05  YUV420P8      64x64      8    [1]         25    0    0   CB-A   >=1 in U;
                                                                Y,V exact copy
C06  YUV422P8      64x64      8    [2]         25    0    0   CB-A   >=1 in V
                                                                (32x64: 1442);
                                                                Y,U exact copy
C07  YUV444P8      64x64      8    omitted     25    0    0   CB-A   >=1/plane
C08  RGB24         64x64      8    [1]         25    0    0   CB-A   >=1 in G;
                                                                R,B exact copy
C09  GRAY8         64x64      8    omitted     25   -9    0   CB-B   >=1 (1596)
C10  GRAY8         64x64      8    omitted     25    0   -9   CB-B   >=1 (2881)
C11  GRAY8         64x64      8    omitted     25  -9  +35   CB-B   >=1 (1596)
C12  GRAY8         64x64      8    omitted     25  +35   0   CB-B   >=1 (2881)
C13  GRAY10        64x64     10    omitted     25    0    0   CB-A   >=1 (3311)
C14  GRAY12        64x64     12    omitted     25    0    0   CB-A   >=1 (3367)
C15  GRAY16        64x64     16    omitted     25    0    0   CB-A   >=1 (3591)
C16  YUV420P10     64x64     10    omitted     25    0    0   CB-A   >=1/plane
C17  YUV420P8      48x32      8    omitted     25    0    0   CB-A   >=1/plane
                                                                (chroma 24x16)
```

Rationale for the pairings (pairwise, not Cartesian - W3C F7): C01-C03
pin the strength axis on the simplest format; C04-C08 pin colour
families and plane routing including BOTH subsampled chroma shapes
(420: halved both axes; 422: halved width only - together they
discriminate any luma-dimension reuse, K28) and an explicit-subset case
per family group; C09-C12 pin the four asymmetric-offset behaviours
including c0-from-alpha and its mirror plus a boundary-legal +35;
C13-C16 pin the u16-storage depths 10/12/16 with bitsPerSample-driven
scaling and one subsampled 10-bit case; C17 pins a second geometry so
64x64 is not hard-coded anywhere.

# 3. Per-case gate conditions

```text
1. H4 domain assertions pass on the ACTUAL inputs of every case.
2. Plane-byte equality Deblock4-vs-HolyWu per H5 (byte-exact target;
   any difference is an investigated finding).
3. NV condition of section 2 holds for the DEBLOCK4 output (computed
   against the source), proving the case exercised the filter; C02 is
   the explicit identity exception (zero changed samples required).
4. UNSELECTED planes are exact plane-byte copies of the source.
5. The exact invocation line of every case is recorded in the run log;
   outputs and the machine-readable difference summary are retained
   under the inspection output area (D4 7d).
```

# 4. Precedence and refusal cases (invocation-level negative controls)

Run through Classic ONLY (HolyWu not involved); these prove the three
S1/S5/K29 refusal rows and the ratified precedence:

```text
N01a YUV444PH (16-bit float)         -> "Classic: float input is not
                                        supported"
N01b YUV444PS (32-bit float)         -> "Classic: float input is not
                                        supported"
     (F2: BOTH float storage widths - proves the refusal is sample-type
      based, not storage-width based; a bug refusing only 32-bit float
      would pass N01b but fail N01a.)
N01c GRAY17 or GRAY32 (integer)      -> "Classic: integer input must be
                                        between 8 and 16 bits"
     (F1: valid 17..32-bit integer is API-reachable and is NOT malformed
      metadata; distinct row from float and from metadata-invalid.)
N02a backend="x86_64_v2_with_sse41"  -> "Classic: requested backend is
     (on the v3-capable host)           not available in this build"
N02b backend="x86_64_v3_with_avx2"   -> "Classic: requested backend is
     (normal v3-capable host, no        not available in this build"
      force-down)                       (F3: proves the explicit-v3
                                        availability branch separately
                                        from precedence; a bug handling
                                        v2 but not v3 would pass N02a
                                        alone.)
N03  backend="x86_64_v3_with_avx2"
     under DEBLOCK4_FORCE_DOWN=v1
     (Debug build only)              -> "Classic: requested backend is
                                        above the EFFECTIVE CPU tier"
                                        (EFFECTIVE precedence OVER
                                        availability - D4 S5)
N04  auto (any case above C01-C17)   -> creation SUCCEEDS; always-on line
                                        + Deblock4Tier report v1 with the
                                        implementation-capped reason.
```

# 5. Verification note

Every NV count in section 2 was computed with the D3 Appendix B/C
derivation model on the exact CB frames defined here (chroma at chroma
dimensions); counts are recorded as evidence that ">= 1 per selected
plane" is comfortably non-vacuous, not as expected values - the expected
values for H5 are HolyWu's bytes, and for the D3 gate the model matrices
already ratified. The CB-B step of 3 was chosen because the C09/C11
offset -9 drives alpha down to 4 (index 16), below which CB-A's step 8
would deactivate everything and the case would be vacuous.

---

Revision: v1.1 (2026-08-03) W3C updated-package: added N01a/N01b (both
float storage widths - F2), N01c (17..32-bit integer refusal - F1/K29),
and N02b (explicit-v3 availability separate from precedence - F3). 17
mandatory comparison cases + refusal/precedence cases; all NV bounds
model-verified. v1.0 (2026-08-03) initial.
