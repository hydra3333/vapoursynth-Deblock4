# HolyWu VapourSynth-Deblock r9 - Pinned Reference Snapshot (D-CLASSIC-4)

**Deliverable:** W3D-2C-D1
**Version:** 1.2
**Date:** 2026-08-02
**Status:** W3X-owned, READ-ONLY once committed (same standing as the
VapourSynth R78 headers). Never modified, reformatted, or EOL-normalised.
**Encoding of THIS file:** US-ASCII; CRLF. The snapshot files below are
preserved BYTE-EXACT as retrieved (upstream LF endings intact).

---

# 1. Provenance

```text
Upstream:   https://github.com/HolyWu/VapourSynth-Deblock
Reference:  tag r9 (latest release tag)
Retrieved:  2026-08-02 via codeload tag tarball
Verified:   r9 src/ byte-identical to branch master src/ on retrieval date
Licence:    GNU GPL v2 (upstream LICENSE included verbatim) - compatible
            with Deblock4's GPL-2.0-or-later
Pin:        ratified by W3X 2026-08-02 as D-CLASSIC-4
Integrity:  SHA256SUMS.txt in this directory pins the exact bytes; the
            hashes, not a git SHA, are the normative content identity.
```

# 2. Contents and deliberate exclusions

```text
INCLUDED
  deblock.cpp       448 lines - the scalar core; the byte-pinned SOURCE
                    IDENTITY and schedule/formula evidence for the
                    deblock4.Classic external reference (K19 layer b).
                    NOT by itself the executable-result oracle: see the
                    K26 distinction in section 5 (W3C F2).
  deblock.h          17 lines.
  deblock_sse4.cpp  169 lines - THEIR SSE4.1 path; read-only prior art
                    for Stage 4C reading. NEVER an implementation source.
  LICENSE           upstream GPLv2 text.

EXCLUDED (deliberate)
  src/vectorclass/  Agner Fog vectorclass library vendored by upstream
                    for their SSE4 path; not needed to read the scalar
                    core, never to be imported into Deblock4 (D0 section
                    5). deblock_sse4.cpp remains readable without it.
  meson.build, pyproject.toml, upstream README.md
                    build/packaging metadata; no schedule content. NOTE
                    (K26): build configuration IS result-bearing for
                    signed-shift and floating-point semantics; excluding
                    these files is why the SEPARATE K26 reference-build
                    record exists (section 5). The exclusion keeps the
                    snapshot minimal; it does not claim the build is
                    irrelevant to results.
```

# 3. Placement and EOL rationale (recorded so it is not "fixed" later)

This snapshot lives under dev_documentation/reference/ and NOT under
third_party/, deliberately: the Stage 1C S3 gate enforces ZERO LF text
files across the deliverable tree (which includes third_party/), and this
archive must stay byte-exact with upstream LF endings. Reference material
is documentation-class, never PRODUCTION build input and never copied into
the deliverable/S3 tree. SOLE EXCEPTION (D4 H0): the released Stage 2C
external-reference tool (tools/holywu_reference) may READ these exact
files after verifying SHA256SUMS.txt and compile them in an EXTERNAL
temporary workspace - never modifying or EOL-normalising them. Do not move it into the deliverable tree and do not
normalise its line endings - either action breaks the byte-exact pin.

# 4. Citation convention

All Stage 2C documents (Real Schedule W3D-2C-D2, obligations W3D-2C-D3,
scope W3D-2C-D4) cite this snapshot as file:function:line against these
exact bytes, e.g. deblock.cpp:deblockHorEdge:NNN.

# 5. Source pin vs reference-build record (K26; added v1.1, W3C F2)

```text
D1 SOURCE PIN (this directory):
    normative source identity; schedule and formula EVIDENCE; the target
    of every file:function:line citation.

K26 REFERENCE-BUILD RECORD (separate artefact, produced with the D4
differential harness):
    the executable-result oracle - pinned compiler and version, C++
    language mode, optimisation/FP flags, VapourSynth and resize/std
    plugin versions, forced opt=1 scalar path, MANDATORY SHA-256 of the
    exact reference DLL/executable run, and behavioural sentinel vectors
    (negative-delta inputs) with observed outputs. Any rebuilt reference
    binary is a NEW oracle artefact requiring fresh hash and sentinel
    revalidation. Rationale: (q0-p0)<<2 with q0<p0 is C++ undefined
    behaviour in the relevant language modes; only an exact binary's
    observed behaviour is a fact.
```

# 6. Binding Knowledge Checklist (added v1.1, W3C F7; D0 v1_5)

```text
K11  these files are Schedule-A reference material for Classic only; no
     Schedule B / grid_mode / midpoint content is drawn from them.
K17  this directory is W3X-owned and READ-ONLY: never modified, moved or
     EOL-normalised; never production build input. The D4 H0 external-
     reference tool is the SOLE authorised reader (hash-verified,
     external workspace only).
K19  the pin is layer-(b) EVIDENCE (byte-exact-target-with-investigation
     comparison basis), not an absolute cross-layer specification.
K26  source bytes do NOT pin executable arithmetic results (section 5);
     the reference-build record is a separate mandatory artefact.
D0 s2/s5  deblock_sse4.cpp and the excluded vectorclass/ are read-only
     prior art for 4C reading only, never implementation source.
```

Revision: v1.2 (2026-08-03) narrowed the no-read rule to admit the D4 H0
external-reference tool as sole authorised reader (W3C revised-package
F4); production-build and S3-tree prohibitions unchanged. v1.1
(2026-08-03) added sections 5-6 and qualified the oracle
wording per W3C revision-review F2/F7; no byte-pinned upstream file
altered (SHA256SUMS.txt unchanged and still authoritative for the four
upstream files). v1.0 (2026-08-02) initial snapshot.
