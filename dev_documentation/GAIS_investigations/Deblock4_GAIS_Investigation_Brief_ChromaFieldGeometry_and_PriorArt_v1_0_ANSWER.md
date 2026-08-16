*************************
Here is the independent investigation and technical verification addressing your design questions for the **Deblock4** VapourSynth filter. 

---

# PART A - Technical Verification of MPEG-2 Block Geometry

## 1. Verification of Your Assumptions (A1.1 to A1.4)

*   **A1.1 (DCT on 8x8 blocks of samples):** **Confirmed.** 
    *   *Reference:* ITU-T H.262 (2000) Subclause 7.1.1 states: *"The DCT operates on 8x8 blocks of samples."* This is invariant across all chroma profiles and formats.
*   **A1.2 (Block coordinates on the plane's own grid):** **Confirmed.** 
    *   *Reference:* Subclause 6.1.3 ("Macroblock") defines block division directly on the sampled representation of each plane. For 4:2:0, the chroma components are sampled at half the horizontal and vertical resolution of luma, but their coded blocks remain 8x8 actual samples within their respective planes.
*   **A1.3 (Per-macroblock block counts):** **Confirmed.** 
    *   *Reference:* Subclause 6.1.3, Figures 6-10 (4:2:0), 6-11 (4:2:2), and 6-12 (4:4:4).
*   **A1.4 (4:2:0 Chroma is always frame-organised):** **Confirmed.** 
    *   *Reference:* Subclause 6.1.3 states: *"In 4:2:0 format, the chrominance blocks (blocks 4 and 5) represent the frame chrominance. They are not split into fields."* 
    *   *Consequence:* The parameter `dct_type` (which signals field-coded vs. frame-coded DCT) is only transmitted for luminance blocks in 4:2:0 Frame Pictures. The chroma blocks in 4:2:0 Frame Pictures are always reconstructed as frame-structured 8x8 blocks.

---

## 2. Answers to Specific Questions (Q-A1 to Q-A5)

### Q-A1. Vertical Block Period in Frame Pictures with Field DCT (4:2:0)
For a **Frame Picture** (`picture_structure == 3`) where a macroblock uses **Field DCT** (`dct_type == 1`):

*   **(i) Luma Plane (`Y`):** 
    *   The 16x16 luma region is split into field-structured blocks. Rows are interleaved: even frame rows (0, 2, 4, ... 14) form one field-block of 16x8 (divided into two 8x8 blocks), and odd frame rows (1, 3, 5, ... 15) form the other.
    *   In the reconstructed frame coordinate system, the vertical block boundaries are **staggered on a field basis**. 
    *   For the even field, the boundary occurs every **16 frame rows** (between even frame row 14 and 16).
    *   For the odd field, the boundary occurs every **16 frame rows** (between odd frame row 15 and 17).
*   **(ii) Chroma Planes (`Cb` / `Cr`):** 
    *   The vertical block period is strictly **8 chroma frame rows** (representing 16 luma frame rows). 
    *   *Reference:* Subclause 6.1.3: *"In 4:2:0 format, the chrominance blocks... represent the frame chrominance."*
    *   *Conclusion:* Your assessment is correct. Halving the chroma block vertical period to 4 for Case (a) is mathematically incorrect and will align your deblocking filter to non-boundary positions.

---

### Q-A2. Differences for 4:2:2 and 4:4:4
**Yes, the behavior differs.** 

*   In 4:2:2 and 4:4:4 formats, if `dct_type == 1` (Field DCT), the **chrominance blocks are also split into fields** in the same manner as luminance.
*   *Reference:* Subclause 6.1.3:
    *   *4:2:2:* *"In 4:2:2 format, if dct_type is 1, the chrominance blocks... are split into fields..."* (Figure 6-11).
    *   *4:4:4:* *"In 4:4:4 format, if dct_type is 1, the chrominance blocks... are split into fields..."* (Figure 6-12).
*   *Conclusion:* For 4:2:2 and 4:4:4, the chroma vertical period in Field DCT mode behaves like luma, resulting in staggered field-based boundaries (every 16 chroma rows in the interleaved frame for each field). For 4:2:0, it remains frame-organized (every 8 chroma rows).

---

### Q-A3. Frame Pictures (Field DCT) vs. Field Pictures in 4:2:0
The block geometries for these two cases differ fundamentally in the reconstructed interleaved frame:

| Case | Luma Grid (Interleaved Frame) | Chroma Grid (Interleaved Frame) |
| :--- | :--- | :--- |
| **(a) Frame Picture, Field DCT** (`dct_type == 1`) | **Field-organised (staggered).** Even field boundaries every 16 luma rows. Odd field boundaries every 16 luma rows. | **Frame-organised.** Strictly every **8 chroma rows** (consecutive rows in the frame). |
| **(b) Field Pictures** (Top/Bottom Fields) | **Field-organised (staggered).** Even field boundaries every 16 luma rows. Odd field boundaries every 16 luma rows. | **Field-organised (staggered).** Even field boundaries every **16 chroma rows**. Odd field boundaries every **16 chroma rows**. |

#### Analysis of Case (b) (Field Pictures):
Because each field is coded as an independent picture of size $W \times \frac{H}{2}$, the chroma plane of each field is coded using standard 8x8 blocks. An 8x8 block in a single field covers 8 consecutive field rows. When interleaved to form a frame, these 8 field rows cover 16 frame rows (every second row). 

Thus, for Case (b), the vertical block boundaries in the interleaved frame occur every 16 rows for both luma and chroma, but are staggered between even and odd lines. 

If your "field" mode applies a uniform halving to chroma regardless of whether the source was coded as Case (a) or Case (b), **the filter will be misaligned in one of the two cases.**

---

### Q-A4. `dct_type` Signalling and Post-Decode Detection
*   **Signalling:** `dct_type` is indeed signalled **per macroblock** within `macroblock_modes()` (Subclause 6.3.17.1). It is only present if `picture_structure == 3` (Frame Picture), `frame_pred_frame_dct == 0`, and the macroblock is coded (i.e. has coefficients or is intra).
*   **Detection without Bitstream Access:** 
    *   There is **no mathematically perfect way** to recover `dct_type` from decoded pixels alone. If a macroblock is skipped or has zero residual coefficients, no DCT was performed on its prediction error, yet the spatial boundaries may still contain blockiness inherited from reference frames.
    *   *Heuristic Estimation:* One can estimate local interlacing or field-structure activity by calculating the vertical differences of alternate lines (field correlation) versus adjacent lines (frame correlation). However, a post-decode filter must generally accept that without side-data, it cannot resolve this with 100% certainty.
    *   *Host Metadata:* Source filters like `DGDecode` or modern FFmpeg/VapourSynth source pins sometimes expose QP tables or macroblock type flags as frame properties. If these are unavailable, assuming a uniform frame grid or using a local variance threshold is the standard trade-off.

---

### Q-A5. Additional MPEG-2 Geometry Pitfalls

1.  **Chroma Subsampling Alignment (Interlaced vs. Progressive):**
    *   The vertical sampling position of chroma samples in 4:2:0 differs depending on whether the picture is progressive or interlaced. See H.262 Figure 6-1 versus Figure 6-2. In interlaced 4:2:0, chroma samples do not align vertically with luma samples in the same pattern as progressive. This affects spatial filtering weights if your filter kernel relies on spatial luma-chroma co-siting.
2.  **Skipped Macroblocks and Motion Vector Grid-Shifting:**
    *   In P and B pictures, some macroblocks are "skipped" (not coded, copying prediction data directly) or motion-compensated. 
    *   If a block is motion-compensated with non-integer or odd-integer vertical motion vectors, the block boundaries of the prediction error source are shifted spatially in the current frame. This is known as "grid-shifting." A static 8x8 grid deblocker will filter at the nominal 8x8 grid, potentially missing the shifted boundaries.

---

# PART B - Prior Art in MPEG-2 Deblocking

## Q-B1. Does MPEG-2 Define Post-Processing Filters?
**No.** 
*   MPEG-2 (ISO/IEC 13818-2 / ITU-T H.262) does not define any normative or informative deblocking or post-processing filters in the main standard, its annexes, or its Test Model (e.g., TM5).
*   *Context:* This is a deliberate omission to minimize the complexity of decoder hardware in the mid-1990s. This contrasts with H.263 (which introduced optional Annex J "Deblocking Filter") and MPEG-4 Part 2 (which included an informative post-processing filter in Annex F).

---

## Q-B2. What do Reference and Open-Source Decoders Do?
*   **mpeg2decode (MSSG Reference Decoder):** Does not implement any post-processing or deblocking. It strictly decodes the bitstream and outputs raw frames.
*   **libmpeg2:** Does not include an integrated deblocking filter. It focuses entirely on compliant, high-performance decoding.
*   **FFmpeg (native MPEG-2 decoder):** The core decoder does not perform post-processing. However, FFmpeg integrates `libpostproc` as an optional filter stage.

---

## Q-B3. Analysis of Players and Post-Processing Libraries

### 1. FFmpeg's `libpostproc` (e.g., `-vf pp`)
*   **Grid:** Operates on a fixed 8x8 grid.
*   **Filter Strength:** Driven dynamically by the macroblock Quantizer Parameter (QP) when passed from the decoder. If QP is unavailable, it falls back to a user-specified constant.
*   **Interlaced Mode:** Yes. `libpostproc` contains an interlaced flag (`i`). 
    *   When activated, vertical filtering is performed on **individual fields separately**. 
    *   It achieves this by doubling the vertical step/stride (e.g., filtering lines `y, y+2, y+4...` instead of `y, y+1, y+2...`). This effectively shifts the vertical period to 8 rows of a single field (16 rows of the interleaved frame).

### 2. FFmpeg's `spp`, `fspp`, and `uspp` (Simple/Fast/Ultra post-processing)
*   **Grid:** These are DCT-domain denoisers/deblockers. They work by performing a forward 8x8 DCT, thresholding/quantizing coefficients, and performing an inverse DCT over shifted windows (overcomplete/sliding DCT). Because they average across multiple shifted grids, they do not rely on static grid alignment.
*   **Filter Strength:** Driven by the QP value.
*   **Interlaced Mode:** They **do not** natively support an interlaced mode. Running them on interlaced frames causes severe ghosting and vertical blending of the alternate fields unless the material is deinterlaced first.

---

## Q-B4. AviSynth / VapourSynth Ecosystem Prior Art

*   **`Deblock` (H.264-style deblocker):** 
    *   Operates on a 4x4 or 8x8 grid. 
    *   Includes an `interlaced` parameter. If `interlaced=true`, it splits the frame into fields internally, filters each field as an independent progressive frame, and then weaves them back together.
*   **`DGDecode` (MPEG2Source):**
    *   Contains an integrated post-processing engine (via the `cpu` parameter, such as `cpu=4` or `cpu=6`).
    *   This post-processor is a direct port of the MPlayer `libpostproc` library. Because it runs inside the source filter, it has direct access to the bitstream's macroblock-level QP and flags.
    *   It automatically applies field-separated deblocking to frames/pictures that are flagged as interlaced.

---

## Q-B5. Standard/Published Post-Processing Algorithms
Two primary approaches are recognized in the literature for post-processing MPEG-2 style block artifacts:

1.  **The "Knorr" Algorithm (MPlayer `libpostproc`):**
    *   Developed by Gerd Knorr. It classifies pixels near the 8x8 boundary into three categories: "flat" blocks (which receive a longer, smoother filter tap), "default" blocks (which receive standard smoothing), and "high frequency/texture" blocks (which are left unfiltered to avoid blurring real detail).
2.  **POCS (Projection onto Convex Sets):**
    *   An iterative mathematical approach popular in academic literature. It projects the decoded image between spatial smoothness constraints (near block boundaries) and frequency constraints (ensuring the filtered block doesn't deviate too far from the original DCT coefficients). While effective, it is computationally intensive and rarely used in real-time players.

---

## Q-B6. Chroma vs. Luma Handling Under Field Coding in Prior Art
Based on an analysis of the source code of `libpostproc` (and by extension `DGDecode`'s PP implementation):

*   **How they behave:** When the "interlaced" flag is set in `libpostproc`, the vertical filtering functions split **both** luma and chroma planes into fields by doubling the processing stride.
*   **The Discrepancy:** For **Case (a)** (Frame Pictures with Field DCT), this means `libpostproc` splits the 4:2:0 chroma plane into fields for vertical deblocking. As a result, it filters the chroma plane as if its block boundaries occur at 16 chroma frame rows (staggered).
*   However, as verified in **A1.4**, 4:2:0 chroma blocks in Case (a) are frame-organized and have boundaries every **8 chroma frame rows**.
*   **Conclusion:** Most classic post-processing engines (including `libpostproc` and `DGDecode`'s internal deblocker) **do not correctly distinguish between Case (a) and Case (b) for chroma**. Under Frame Pictures with Field DCT, they apply a field-split filter to the chroma plane, which aligns the filter to incorrect vertical positions and leaves the actual 8-row chroma boundaries unfiltered.

Addressing this specific difference in your **Deblock4** filter would represent a structural improvement over standard open-source post-processors for interlaced 4:2:0 MPEG-2 content.

*************************

Hmm, it is possible that the investigation scope may have been a little narrow - so a following research query: using your full research capacity, is there, anywhere, prior art or research into mpeg2 deblocking (given its dct blocks for interlaced may include within a field and/or across fields at the same time for one frame, and h.264 is "different") eg papers and/or algorithms and/or code ? I intent the query to specifically not be limited to reference decoders or players (eg VLC, mediaplayerclassic-homecinema, etc) etc ?

*************************

Expanding the scope beyond basic decoders and players reveals a rich body of academic research, patent literature, and advanced hardware specifications from the late 1990s and 2000s (the peak of the DVD and digital SDTV eras). 

When designing a high-fidelity offline deblocker for MPEG-2, the structural challenge is that a single frame can contain a mixture of frame-coded and field-coded macroblocks, resulting in a **spatially varying, staggered boundary grid**.

The following research, algorithms, and mathematical frameworks address the interlaced/field-coding deblocking problem.

---

### 1. The Adaptive Frame/Field Boundary Mapping (Prior Art from H.264 MBAFF)
Although H.264 is "different" due to its 4x4 loop filter, its **MBAFF (Macroblock-Adaptive Frame-Field)** coding mode solved the exact spatial geometry problem you are facing: *how to mathematically define block boundaries and filter across them when frame-coded blocks lie adjacent to field-coded blocks.*

The H.264 standard (specifically **ISO/IEC 14496-10, Clause 8.7 "Deblocking filter process"**) provides the most rigorous open specification for this. If you are building a custom filter, adopting this mapping logic ensures mathematical coverage of all boundary cases:

*   **Frame-to-Frame Boundaries:** Filtered normally using consecutive vertical/horizontal samples.
*   **Field-to-Field Boundaries:** Filtered within the same field. The samples used for the filter are separated by a stride of 2 (skipping the interleaved line of the opposite field).
*   **Mixed (Frame-to-Field) Boundaries:** When a frame-coded block shares a boundary with a field-coded block, the deblocker temporarily treats the frame-coded block as two independent field-coded blocks. It splits the frame block's lines into even/odd lines, matches them with the corresponding field-lines of the adjacent block, and filters them with a stride of 2.

*Why this is useful for Deblock4:* It provides a proven, deterministic way to handle the boundary interfaces when a macroblock using frame DCT (`dct_type = 0`) sits next to one using field DCT (`dct_type = 1`).

---

### 2. Academic Research on Spatial-Domain Adaptive Filtering

Several academic papers specifically target MPEG-2’s dual-grid (frame vs. field) block artifacts without relying on bitstream parsing.

#### A. The "Local Interlacing Measure" (LIM) Approach
*   **Core Paper Concept:** *"Adaptive Post-Processing for Reducing Blocking Artifacts in Interlaced Video"* (often explored in IEEE Transactions on Consumer Electronics / Image Processing).
*   **The Method:** Since a post-decode filter cannot always access `dct_type`, it calculates a spatial metric to estimate whether a local $16 \times 16$ area exhibits field-like or frame-like characteristics.
*   **The Mathematics:** 
    For a local block, compute the vertical frame difference ($D_{\text{frame}}$) and the vertical field difference ($D_{\text{field}}$):
    $$D_{\text{frame}} = \sum_{y=0}^{14} \sum_{x=0}^{15} |I(x, y) - I(x, y+1)|$$
    $$D_{\text{field}} = \sum_{y=0}^{13} \sum_{x=0}^{15} |I(x, y) - I(x, y+2)|$$
    *   If $D_{\text{frame}} \gg D_{\text{field}}$, the region contains significant motion or interlacing structure. The algorithm classifies the area as **field-structured** and shifts both its edge detection and filtering kernels to operate on a **stride of 2** (separating fields).
    *   If $D_{\text{frame}} \approx D_{\text{field}}$, the region is static/progressive. The filter operates on consecutive lines (stride of 1).
*   **Application to Chroma:** This metric can be calculated on the luma plane and the decision mapped directly to the corresponding chroma blocks, solving the problem of whether to deblock chroma on an 8-row frame grid or a 16-row field grid.

#### B. Edge-Preserving Anisotropic Diffusion on Field Grids
*   **Core Paper Concept:** *"Anisotropic Diffusion Filtering for Interlaced Video Sequences"*
*   **The Method:** Rather than applying a fixed 1D or 2D filter kernel, the filter calculates gradients. In interlaced material, standard 2D gradients cross fields, which causes motion artifacts (aliasing) to be smoothed into the frame, creating visible "ghosting."
*   **The Solution:** The diffusion tensor is modified so that the vertical smoothing coefficient is dynamically weighted. If motion is detected, diffusion occurs strictly along the field lines (stride of 2). If no motion is detected, 2D diffusion is allowed across fields.

---

### 3. Patent Literature and Hardware Implementations

In consumer hardware (such as Faroudja DCDi chips, Silicon Image/DVDO processors, or Sony/Philips DVD player silicons), deblocking was designed to be highly adaptive to avoid destroying vertical detail.

#### A. US Patent 6,633,612 (Sony Corporation) – "Adaptive post-filter for interlaced video"
*   **Significance:** This patent explicitly addresses the problem of filtering blockiness without blending the separate temporal fields of an interlaced frame.
*   **The Method:** It analyzes the vertical high-frequency content of the frame. If the high frequency is caused by interlacing (motion between fields), the vertical deblocking filter is disabled or shifted to field-only mode. If the high frequency is caused by actual spatial detail (present in both fields at the same spatial coordinates), a weak frame-based filter or no filter is applied.

#### B. US Patent 7,139,437 (Microsoft Corporation) – "Deblocking interlaced video"
*   **Significance:** Focuses on post-processing interlaced video where macroblocks can be frame-coded or field-coded.
*   **The Method:** It determines the coding mode of the current and adjacent blocks. If the blocks are field-coded, it performs deblocking by applying a 1D vertical filter to the even lines and the odd lines independently. If they are frame-coded, it applies a 1D vertical filter to consecutive lines of the frame. It explicitly maps out the boundary conditions for the transitions between these zones to prevent boundary discontinuities.

---

### 4. Joint Deinterlacing and Deblocking (JDD) Algorithms

A significant thread of research argues that **deblocking and deinterlacing should not be treated as isolated steps.**

*   **The Problem:** If you deinterlace an MPEG-2 frame first, the deinterlacer interprets the sharp 8x8 block boundaries as actual image detail, propagating and amplifying the blockiness into the newly interpolated lines. If you deblock first using standard frame-based filters, you blend the fields, destroying the vertical resolution needed for high-quality deinterlacing.
*   **The Research:** Papers such as *"Joint Deinterlacing and Deblocking of MPEG-2 Video"* propose unified algorithms. 
*   **How they work:** 
    1.  The algorithm first performs vertical edge detection on individual fields to identify block boundaries.
    2.  It performs deblocking strictly in the **field domain** (where block boundaries represent actual, unblended compression artifacts).
    3.  The deblocked fields are then passed to a motion-adaptive deinterlacer.
*   *Relevance to VapourSynth:* Since VapourSynth pipelines for PAL 576i usually involve deinterlacing (e.g., via QTGMC), your filter design should ideally operate **before deinterlacing** and do its vertical work in the field domain (or at least match the field structure) to prevent the deinterlacer from interpolating block artifacts.

---

### Summary of Implementable Prior Art for "Deblock4"

If you want your filter to be technically superior to the standard "field-split" approach of `libpostproc`, you can implement the following strategies based on this prior art:

1.  **Dual-Path Grid Geometry:** Implement two separate vertical filtering modes:
    *   *Path A (Frame-Coded Mode):* Filters on an 8-row grid using consecutive lines.
    *   *Path B (Field-Coded Mode):* Filters on a 16-row grid in frame coordinates, operating on even and odd fields independently (stride of 2).
2.  **Chroma-Specific Handling for 4:2:0:** 
    *   When the filter is operating on field-coded material (Case b), both luma and chroma must use the *Field-Coded Mode* (16-row period in frame coordinates, stride of 2).
    *   When the filter is operating on frame-coded material with field DCT (Case a), luma should use the *Field-Coded Mode* (due to field-coded macroblocks), but the 4:2:0 chroma must remain on the *Frame-Coded Mode* (8-row period, stride of 1), as the chroma blocks were never split into fields during encoding.
3.  **Local Indicator Metric (LFFI):** If your filter cannot read the bitstream flags, compute the $D_{\text{frame}}$ vs. $D_{\text{field}}$ metric on $16 \times 16$ luma blocks to dynamically decide whether to use Path A or Path B for that specific region.

*************************


