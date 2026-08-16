
```markdown
# Deblock4 - Option Space Analysis for MPEG-2 Post-Decode Deblocking

This document outlines the architectural option space for the Deblock4 VapourSynth filter. It establishes the technical pathways, failure modes, and trade-offs of different deblocking structures operating on whole-frame inputs with a declared clip-level mode, specifically addressing the 4:2:0 luma/chroma grid divergence under MPEG-2 field coding.

---

## 1. Formal Retraction and Correction

We fully accept your correction. Our previous suggestion that a per-region classifier could "safely default to the frame path" in static regions was a logical oversight that directly contradicted our own analysis of the static field-DCT failure mode (F5). 

*   **The Reality:** In a static scene coded with field DCT, $D_{\text{frame}}$ will be approximately equal to $D_{\text{field}}$. Defaulting to frame-path deblocking in this state is mathematically incorrect. It guarantees that the actual, staggered 16-row field boundaries remain unfiltered, while the frame filter blurs non-boundary lines.
*   **The Corrected Stance:** Static regions cannot be assumed to be frame-coded. The filter must use structural artifact measurements or temporal history to determine the boundary phase, rather than relying on motion-based heuristics ($D_{\text{frame}}$ vs $D_{\text{field}}$).

---

## 2. The Core Debate: Classification vs. Direct Phase Measurement

Before evaluating specific architectures, we must analyze the two fundamental paradigms of post-decode deblocking.

### The Case FOR Region Classification (Infer Structure $\to$ Filter)
*   **Spatial and Structural Consistency [REASONING]:** By classifying an entire $16 \times 16$ or $8 \times 8$ region into a specific state (e.g., Frame-DCT or Field-DCT), the filter applies a mathematically consistent grid across that entire block. This prevents "speckled" or disjointed filtering decisions within a single coded macroblock, preserving the structural continuity of the image.
*   **Robustness in Low-Contrast / High-Noise Scenes [ESTABLISHED KNOWLEDGE]:** In dark scenes, flat surfaces, or heavily grained/textured content, the actual step-discontinuities at block boundaries may be buried near or below the noise floor. A direct phase detector will fail to find a boundary and will skip filtering, leaving visible blockiness. A classifier, backed by the global prior and spatial propagation from neighboring blocks, can confidently declare the region's coding structure and apply the appropriate filter anyway.
*   **Computational Efficiency [REASONING]:** Classifying a region once using coarse statistical metrics is computationally cheaper than running sliding-window phase-detection passes across every individual horizontal and vertical boundary line.

### The Case FOR Direct Phase Measurement (Detect Artifact $\to$ Filter)
*   **Immunity to the Static/Motion Dilemma [REASONING]:** A phase detector does not care about motion, temporal variance, or whether a region is static. It measures the physical consequence of quantization: the spatial step discontinuity. If a block has a field-staggered boundary, the step discontinuity exists at the 16-row grid lines regardless of whether the image is static or moving.
*   **Graceful Degradation under Grid Shifts [ESTABLISHED KNOWLEDGE]:** In P and B frames, motion-compensated blocks (especially those with fractional-pixel or odd-integer vertical motion vectors) can shift the actual blockiness grid relative to the nominal $8\times8$ frame coordinates. A classifier assuming a static grid will filter the nominal boundary (blurring real detail) and miss the shifted boundary. A phase detector searches for the peak of the step-discontinuity energy, automatically aligning itself to the shifted grid.
*   **Texture Protection [REASONING]:** Natural textures with periodic vertical structures (e.g., picket fences, corduroy fabric) can easily trick a classifier into declaring a "field-coded" state, leading to catastrophic blurring. A phase detector checks the exact alignment and profile of the step; if the pattern does not match the strict phase of the block grid, it leaves it unfiltered.

### The Hybrid Solution (Recommended Division of Labor)
A blind combination of these methods is inefficient. Instead, we propose a strict, mathematically defined division of labor:

1.  **The Global Prior (User Flag)** establishes the *allowable search space* (e.g., if `progressive`, search only 8-row consecutive; if `field_pictures`, search only 16-row staggered; if `interlaced_frame`, search both).
2.  **The Local Phase Detector** calculates the step-discontinuity energy *only* at the candidate grid locations permitted by the global prior.
3.  **The Local Classifier** acts as a *confidence arbiter*. In high-contrast regions, the phase detector's local measurements dictate the filtering. In low-contrast or noisy regions where phase detection is ambiguous, the classifier uses spatial neighborhood voting and the global prior to decide whether to apply the filter.

---

## 3. The Architecture Option Space

Below are three distinct architectures for the Deblock4 filter.

---

### Architecture 1: The Codec-Mimic Classifier (Structural Approach)

This architecture seeks to reconstruct a spatial map of the encoder's original macroblock-level `dct_type` decisions without bitstream access, and applies a matched grid filter based on that map.

```
                  +--------------------------------+
                  |  Decoded Frame & Global Prior  |
                  +--------------------------------+
                                  |
                                  v
                  +--------------------------------+
                  |  16x16 Macroblock Partition    |
                  +--------------------------------+
                                  |
                                  v
                  +--------------------------------+
                  |     Structural Classifier      |  <-- Uses spatial & temporal
                  |  (Output: Frame-DCT/Field-DCT) |      block-edge energy
                  +--------------------------------+
                                  |
               +------------------+------------------+
               | (Frame-DCT)                         | (Field-DCT)
               v                                     v
+-----------------------------+       +-----------------------------+
| Luma: 8-row consecutive     |       | Luma: 16-row staggered      |
| Chroma: 8-row consecutive   |       | Chroma: 8-row consecutive   |
+-----------------------------+       +-----------------------------+
```

*   **Core Mechanism [REASONING]:** 
    The frame is partitioned into a static grid of $16\times16$ regions (corresponding to luma macroblocks). For each region, a classifier calculates spatial block-edge energy at both the 8-row consecutive (frame) and 16-row staggered (field) phases. It smooths these decisions temporally (using the previous frame's classification map) and spatially (using a $3\times3$ median filter on the decision map) to generate a binary state map of the frame.
*   **What it Gets Right Cheaply:** 
    It maintains absolute structural consistency. Because filtering decisions are locked to the $16\times16$ macroblock grid, there is no risk of intra-macroblock boundary shearing or localized filtering mismatches.
*   **Failure Modes:** 
    *   *Texture Masking:* High-contrast natural textures that align with block boundaries will bias the classifier. If a static texture is misclassified as Field-DCT, the filter will apply a stride-2 vertical filter, destroying the vertical resolution of that texture. The viewer sees a localized "pop" of sudden blur.
    *   *Skipped-Block Misalignment:* If a block was motion-compensated with a vertical offset, the real boundaries shift. The classifier, bound to the rigid $16\times16$ grid, will filter the wrong pixels, leaving the real blockiness untouched while blurring the interior of the block.
*   **Computational Character:** 
    Two-pass. Pass 1 analyzes the entire frame to build and smooth the low-resolution state map. Pass 2 executes the filtering kernels using the map as a lookup table.
*   **Chroma Story (4:2:0) [SPECULATION]:** 
    When the global mode is `interlaced_frame`, the chroma planes bypass the classification map entirely. Chroma is strictly filtered on an 8-consecutive-row frame grid, matching the MPEG-2 normative constraint. If `field_pictures` is declared, both luma and chroma are forced to the 16-row field-staggered path.

---

### Architecture 2: The Phase-Driven Boundary Tracker (Artifact-Only)

This architecture abandons all attempts to infer the encoder's coding decisions. It operates on the principle that the filter should only exist where an artifact can be physically measured.

```
                  +--------------------------------+
                  |  Decoded Frame & Global Prior  |
                  +--------------------------------+
                                  |
                                  v
                  +--------------------------------+
                  |   1D Column Edge Evaluation    |
                  +--------------------------------+
                                  |
                                  v
                  +--------------------------------+
                  |      Local Phase Evaluator     |  <-- Measures step ratio at
                  |   (Boundary vs. Internal Var)  |      8-row and 16-row phases
                  +--------------------------------+
                                  |
               +------------------+------------------+
               | (Step Detected)                     | (No Step / Clean Edge)
               v                                     v
+-----------------------------+       +-----------------------------+
| Apply adaptive 1D smoothing |       | Bypass Filtering            |
| along the identified phase  |       | (Preserve original pixels)  |
+-----------------------------+       +-----------------------------+
```

*   **Core Mechanism [REASONING]:** 
    The filter operates line-by-line. For each column of pixels, it evaluates the local gradient. At each potential boundary line (as defined by the global prior), it calculates a local "blockiness metric" ($B_{\text{metric}}$):
    $$B_{\text{metric}} = \frac{|p_0 - q_0|}{|p_1 - p_0| + |q_0 - q_1| + \epsilon}$$
    where $p_0$ and $q_0$ are pixels directly adjacent to the boundary, and $p_1, q_1$ are internal pixels. If $B_{\text{metric}}$ exceeds a threshold tuned to the noise floor, a 1D vertical deblocking filter is applied locally centered on that boundary.
*   **What it Gets Right Cheaply:** 
    It is immune to the static/motion classifier failure. If a boundary exists, it is filtered; if it does not, it is bypassed. It handles skipped blocks and grid-shifting naturally because it evaluates the physical step, not the coordinate grid.
*   **Failure Modes:** 
    *   *Noise Masking:* High levels of film grain or camera noise will inflate the denominator ($|p_1 - p_0| + |q_0 - q_1|$), causing the blockiness metric to drop below the threshold. The viewer will see the blocky boundaries "flicker" back into visibility in noisy or dark scenes.
    *   *Geometric Edge Degradation:* Real horizontal edges in the source content (e.g., the horizon, a table edge, or text) that happen to align with the 8-row or 16-row grid lines will produce a massive $B_{\text{metric}}$ spike. The filter will mistake these for blockiness and blur them, causing visible edge softening.
*   **Computational Character:** 
    Single-pass. Local operators are calculated on-the-fly using a vertical sliding window. It is highly friendly to cache locality and SIMD execution.
*   **Chroma Story (4:2:0) [REASONING]:** 
    For `interlaced_frame`, the chroma search space is mathematically restricted to the 8-row consecutive frame grid. The phase evaluator only calculates $B_{\text{metric}}$ at $y \pmod 8 == 0$ in consecutive frame coordinates. For luma, it evaluates both the 8-row consecutive and 16-row staggered phases.

---

### Architecture 3: Overcomplete Sliding-DCT Filter (NOT Recommended)

A frequency-domain approach that filters blockiness by transforming, thresholding, and reconstruction.

*   **Core Mechanism [ESTABLISHED KNOWLEDGE]:** 
    The filter slides an $8\times8$ window across every pixel coordinate of the frame. For each step, it performs a forward 2D DCT, scales down or zeroes out the high-frequency AC coefficients (which contain the block-edge transitions), performs an inverse 2D DCT, and accumulates the result in an image buffer. The final frame is the average of all overlapping reconstructed blocks (typically 64 reconstructions per pixel).
*   **Why We Strongly Recommend AGAINST It [REASONING]:**
    1.  **Destruction of Interlacing Structure:** It is completely blind to field structure. Performing an $8\times8$ 2D DCT on an interleaved frame with motion causes severe vertical aliasing. It permanently smears the temporal fields together, creating unrecoverable ghosting artifacts on moving edges.
    2.  **Chroma Tearing:** If you attempt to solve the interlacing problem by splitting the fields first, you run into the exact "chroma tearing" issue established in your analysis. The frame-coded chroma in Case (a) is torn apart, and the DCT filter reconstructs invalid spatial frequencies.
    3.  **Prohibitive Computational Cost:** Performing 64 forward and inverse 2D DCTs per pixel is computationally expensive, making it entirely unsuitable for high-throughput VapourSynth processing.
*   **Failure Modes:** 
    The viewer will see severe, permanent horizontal smearing on moving objects (interlacing ghosting) and a global loss of high-frequency texture (e.g., skin texture or fabric patterns turn into plastic-like surfaces).

---

## 4. The Case Against Your Leaning

Your current design leaning is: **per-decided region classification seeded by the declared mode.** We advise against this approach for three reasons:

### 1. Hard Decision-Boundary Shearing (The "Seam" Artifact) [REASONING]
If Region A (classified as Field-DCT) sits directly adjacent to Region B (classified as Frame-DCT), the filter will apply a stride-2 vertical filter on the left side of the boundary and a stride-1 vertical filter on the right. 

At the spatial boundary between Region A and Region B, the transition between these two completely different filtering strides will create a visible geometric discontinuity. Under motion, the viewer will see a visible "seam" or vertical tear where the two filtering regimes meet.

### 2. Temporal Decision Flickering [ESTABLISHED KNOWLEDGE]
In video sequences, a region's local characteristics often hover right on the threshold of a classifier's decision boundary. From frame to frame, a region may flip-flop between Frame-DCT and Field-DCT classification due to minor noise fluctuations. 

This leads to temporal "flickering" or "shimmering," where blockiness visibly flashes on and off across frames. This is highly objectionable to the viewer, more so than static blockiness.

### 3. The Skipped-Block Blind Spot [REASONING]
Seeded region classification assumes that the artifacts align perfectly with the nominal macroblock grid of the current frame. However, in heavily compressed MPEG-2 streams, many macroblocks are skipped or motion-compensated with fractional or odd-pixel vectors. 

The physical blockiness in these regions is inherited from the reference frame and is spatially shifted. A region-bound classifier will apply the filter to the nominal grid, completely missing the actual shifted blockiness while blurring clean, non-boundary pixels inside the block.
```