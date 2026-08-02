# Toolchain Findings addendum - F6: VapourSynth int-parameter coercion (for Deblock4_Toolchain_Findings v1_2)

**Date:** 2026-08-02
**Provenance:** surfaced by the Stage 1C proof matrix E-series (error_wrong_type
case); diagnosed by W3C, verified by W3D, ruling ratified by W3X 2026-08-02.
**Encoding:** US-ASCII; CRLF. Text below is drop-in for the Findings document
at its next revision (v1_2), continuing the F-numbering.

---8<--- BEGIN F6 (append after F5) ---8<---

F6  VAPOURSYNTH COERCES NUMERIC ARGUMENTS TO THE REGISTERED PARAMETER TYPE
    BEFORE THE PLUGIN SEES THEM; PLUGIN-SIDE WRONG-TYPE DETECTION FOR INT
    PARAMETERS IS UNREACHABLE.

    Observed (Stage 1C, VapourSynth R78): with Classic's strength registered
    as int:opt, a Python call supplying strength=1.5 reaches the plugin's
    creation callback as an INTEGER (value 1). The Python binding converts
    supplied arguments to the registered type when building the VSMap;
    mapGetType at the plugin boundary reports ptInt, and the original Python
    float identity is not observable. A genuinely ptFloat entry supplied via
    the low-level API is rejected by VapourSynth's own invocation boundary
    before the plugin runs.

    Consequences:
    - The plugin CANNOT distinguish a user's 1.5 from 1 for an int parameter.
      Silent truncation at the boundary is a VapourSynth property, not a
      Deblock4 defect, and cannot be fixed plugin-side.
    - Proof harnesses must not assert plugin-level wrong-type rejection for
      int parameters (the Stage 1C error_wrong_type case was retired for this
      reason); Deblock4's own validation is proven via range cases instead.
    - DESIGN RULE for later stages (2C/2D+): if an integer-registered
      parameter ever exists where silent float truncation would be a
      MEANINGFUL wrong result (the way a wrong grid is), register it as
      float with explicit plugin-side range/step validation instead of
      relying on int coercion. strength's truncation is tolerable; apply
      this test per-parameter when the real algorithms land.

    RATIFIED MITIGATION (specified as rider Stage 1C.1): since coercion
    cannot be detected, it is made VISIBLE - each filter emits, at creation,
    a second stderr line and a matching frame property echoing the RESOLVED
    invocation in call syntax with a plain "using" prefix, including
    defaulted parameters, so a user who supplied 1.5 sees strength=1
    reported back. See the Stage 1C.1 rider scope for the binding
    specification.

---8<--- END F6 ---8<---
