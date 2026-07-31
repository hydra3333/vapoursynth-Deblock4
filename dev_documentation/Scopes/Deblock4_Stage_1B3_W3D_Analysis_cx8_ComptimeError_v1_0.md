# Deblock4 - Stage 1B.3 W3D Analysis: detection-object @compileError (cx8)

Version: v1.0
Date: 2026-07-31
Subject: `zig build detection-object -Doptimize=ReleaseFast` fails with
   "x86_64_v1 membership drift for feature cx8" from
   verifyNamedModelMembership().
Encoding: US-ASCII only
Status: W3D independent analysis, supplied to W3C to diff against its own.
   The corrected implementation is W3C's deliverable; the API spelling below
   is NON-NORMATIVE and must be verified against the pinned Zig 0.16.0
   library source before use.

## 1. W3D diagnosis

FALSE ALARM WITH A REAL CAUSE. This is not toolchain membership drift and not
an error in the classification table. It is a raw-vs-resolved set mismatch in
the comptime checks:

```text
std.Target.x86.cpu.<model>.features   = the model's EXPLICIT feature list.
                                        Transitive feature DEPENDENCIES are
                                        not included; they are added by
                                        dependency population when the model
                                        is used as a real compilation target.

the Stage 1B.2 zig_builtin captures   = generated FROM real compilations,
                                        i.e. the RESOLVED, post-population
                                        sets. These listed cx8 in all three
                                        models, and both the classification
                                        and the expected-capture lists were
                                        (correctly) derived from them.
```

The checks therefore compare the table against RAW sets while the table's
provenance is the POPULATED sets. cx8 (CMPXCHG8B, a genuine psABI v1 member)
is evidently not explicit in at least one raw model set - plausibly implied
via a dependency (for example cx16 -> cx8 in the v2/v3 models) - so
`in_v1 and in_v2 and in_v3` fails and the gate halts, exactly as designed.

## 2. The correct comparison basis (charter G3)

The POPULATED sets are the correct basis. G3's requirement is that detection
membership cannot drift from the models AS THE BUILD USES THEM; what the
build uses is the resolved set (which is precisely what the builtin captures
record). The raw explicit list is an internal composition detail of Zig's
model definitions.

## 3. Required fix (semantic; spelling is W3C's to verify)

Both comptime checks (verifyNamedModelMembership and verifyCapturedModelSet)
must query DEPENDENCY-POPULATED copies of the three model sets instead of the
raw `.features` fields. Non-normative candidate shape - verify the exact Zig
0.16.0 API (name, signature, comptime usability) against the pinned library
source (C:\SOFTWARE\zig\lib\std\Target.zig and Target/x86.zig) before use:

```zig
// NON-NORMATIVE - verify before use
fn populatedModelFeatures(
    comptime model: *const std.Target.Cpu.Model,
) std.Target.Cpu.Feature.Set {
    var set = model.features;
    set.populateDependencies(std.Target.x86.all_features);
    return set;
}
```

with the three call sites switching from `std.Target.x86.cpu.<m>.features`
to `populatedModelFeatures(&std.Target.x86.cpu.<m>)`. If the 0.16 API
differs (for example a Model.toCpu-style resolver being the idiomatic route),
use the verified spelling and state it in the response.

## 4. The falsifiable prediction (hold the fix to this)

Because the expected-capture lists were derived from populated sets, the fix
must require ZERO changes to the classification table or the captured
expected lists. After the correction:

```text
- verifyNamedModelMembership: expected GREEN, table untouched;
- verifyCapturedModelSet:     expected GREEN, all three lists untouched.
```

If EITHER check still fails after querying populated sets, STOP: that would
be evidence of a real discrepancy (genuine drift, or a capture error) and it
comes back to W3X/W3D for examination rather than being classified away
locally. Do not adjust the table to make the checks pass.

## 5. Silver lining, recorded

This event is a live, unplanned demonstration that the G3/G6 loud-fail gate
works on the real toolchain: it fired at comptime, named the exact feature,
and halted the build. A warning would have scrolled past; this stopped
everything - exactly the chartered behaviour. The scope 7.4 obligation (a
DELIBERATE one-feature perturbation shown to fire, then reverted) remains
owed against the CORRECTED check, and this incident does not substitute for
it - but it derisks it.

## 6. Sequence after the fix

Unchanged from the standing E-list: rebuild detection-object; capture
dumpbin /DISASM (closes the asm question and 7.2); run build_1B3_v1.bat in
full; produce the 7.4 perturbation evidence; submit the (unchanged)
classification for formal R3 approval. The fix itself is a bounded
implementation correction inside src/cpu_capability_detection.zig only - no
other file should change, and the delivery of the fix follows C-DELIV-02
(a small localised change: unified patch expected).
