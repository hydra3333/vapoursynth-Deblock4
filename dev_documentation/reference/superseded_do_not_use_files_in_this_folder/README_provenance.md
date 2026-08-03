# HolyWu VapourSynth-Deblock r9 - Pinned Reference Snapshot (D-CLASSIC-4)

**Deliverable:** W3D-2C-D1
**Version:** 1.0
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
  deblock.cpp       448 lines - the scalar core; THE external oracle
                    reference for deblock4.Classic (K19 layer b).
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
                    build/packaging metadata; no schedule content.
```

# 3. Placement and EOL rationale (recorded so it is not "fixed" later)

This snapshot lives under dev_documentation/reference/ and NOT under
third_party/, deliberately: the Stage 1C S3 gate enforces ZERO LF text
files across the deliverable tree (which includes third_party/), and this
archive must stay byte-exact with upstream LF endings. Reference material
is documentation-class, not build input; nothing in the build may include
these files. Do not move it into the deliverable tree and do not
normalise its line endings - either action breaks the byte-exact pin.

# 4. Citation convention

All Stage 2C documents (Real Schedule W3D-2C-D2, obligations W3D-2C-D3,
scope W3D-2C-D4) cite this snapshot as file:function:line against these
exact bytes, e.g. deblock.cpp:deblockHorEdge:NNN.
