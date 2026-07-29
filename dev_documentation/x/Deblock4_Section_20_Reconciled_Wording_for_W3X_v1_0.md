# 20. Unified wording for the two scope-blocking rules (proposed)

This wording reconciles the charter, roadmap, status, and future scopes. It
resolves audit blockers C1 (bootstrap reinstating universal byte-identity) and
C2 (circular oracle sequencing).

## 20.1 Per-type differential acceptance

For any scope that MODIFIES an established pixel-producing or frame-construction
path, acceptance is per output TYPE, compared against the applicable ReleaseSafe
scalar oracle (the same oracle; the comparison differs by type):

```text
INTEGER planes:
    every affected plane must be BYTE-IDENTICAL to the ReleaseSafe scalar
    oracle. There is no tolerance; any difference is a defect.

FLOAT planes:
    every affected plane must implement the SAME specified algorithm, preserve
    every EXACT structural result (geometry, masks, bounds, tails, lane
    mapping, schedule), and satisfy the approved differential contract against
    the ReleaseSafe scalar oracle: final magnitudes within the measured
    magnitude tolerance, and the near-threshold numeric-activation decision
    within its decision-boundary bound. In plain terms: each float plane's
    pixels must lie within the tolerances the designer specifies (derived then
    stress-tested per the verification methodology; values fixed at Stage 2),
    when compared to the scalar float oracle.
```

Pure copy/share paths are a stricter case, not a looser one:

```text
COPY / SHARE / PASSTHROUGH (a path whose SPECIFIED result is the source pixels
unchanged - an unprocessed plane, a shared or reused source plane):
    output must be BYTE-IDENTICAL to the source for EVERY format, integer and
    float alike. Float tolerance does NOT apply, because a copy that alters a
    pixel is corruption, not rounding. The source itself must never be mutated
    (in particular, plane sharing/reuse must not corrupt the original).
```

## 20.2 Oracle-construction exception

```text
The FIRST bounded Stage 2C or 2D scope that constructs a filter's ReleaseSafe
scalar oracle is EXEMPT from comparison against a pre-existing whole-plane
oracle - because it CREATES that oracle, so no prior oracle exists to diff
against. This exception exists solely to break the otherwise-circular rule
("no deblocking code until the oracle exists" vs "this scope writes the code
that becomes the oracle").

That scope is instead accepted against INDEPENDENTLY AUTHORED scalar
obligations: arithmetic vectors, threshold tables, geometry, footprints,
schedule, range/overflow proof, memory canaries, exceptional-value cases, and
the pinned external reference oracle where applicable (HolyWu C/scalar for
Classic; there is no external oracle for Deblock4).

ADDITIONALLY, the oracle-construction scope must pass a whole-image SANITY
gate (a corruption tripwire, NOT a quality metric): the oracle's output must
differ from the source only in ways consistent with edge-local deblocking -
bounded per-pixel change, differences concentrated at/near block boundaries,
and no wholesale global shift or gross image change - given that the algorithm's
purpose is to REDUCE blocking, not to substantially alter the picture. This
catches a class of gross wiring error that per-edge unit proofs can miss (an
algorithm arithmetically correct per edge but mangling the image globally).
The exact sanity method and its loose bounds are selected at Stage 2C/2D and
must remain deliberately permissive - it is a safety net, not an acceptance
criterion, and nothing untested becomes normative (charter A3). Candidate
tooling to investigate at that time includes block-boundary discontinuity
measures and full-reference change-magnitude proxies against the source; none
is pinned now.

After the ReleaseSafe scalar oracle is accepted, EVERY subsequent
pixel-producing, frame-construction, copy/share, ReleaseFast scalar, v2, or v3
scope must be differentially MEASURED and VALIDATED against it under 20.1.
```
