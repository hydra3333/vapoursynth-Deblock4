# Deblock4 - Stage 1C Phase 2 W3D Finding: v1.1 compile errors (C-interop)

Version: v1.0
Date: 2026-08-01
Reviews: build_1c2.log (delivery v1.1 validation run)
Encoding: US-ASCII; CRLF.
Status: The v1.1 harness fix WORKED (module collision gone; 28/28 unit tests
   passed). Eight REAL compile errors remain, all C-interop type mismatches in
   the two instance_creation modules, all mirrored Classic/Deblock4. These are
   code defects for W3C to fix; narrow and mechanical. Production source needs a
   corrected re-delivery; the harness and the accepted Phase 1 modules are fine.

## 1. Good news first

```text
- The single-root validation graph compiles far enough to run the unit tests:
  28/28 tests passed.
- The module-collision error from the previous run is GONE. The Option-B
  harness fix is confirmed working.
- The 8 errors are all in classic_instance_creation.zig and
  deblock4_instance_creation.zig, in IDENTICAL pairs (4 distinct defects x 2
  filters). Nothing in Phase 1, the routers, or backend_tier_selection.
```

These surfaced only now because they are interop mismatches against the REAL
translate-c'd VapourSynth headers - exactly what the validation harness exists
to catch. The harness is doing its job.

## 2. The four distinct defects (each appears once per filter)

DEFECT A - callback pointer type mismatch (classic L114 / deblock4 L88).
The createVideoFilter bridge wrapper expects callback function pointers whose
parameters use the C-ABI forms translate-c produced:
```text
    [*c]?*anyopaque      (not *?*anyopaque)
    ?*VSFrameContext     (not *VSFrameContext)
    ?*VSCore             (not *VSCore)
    [*c]const VSAPI      (not *const VSAPI)
```
But classic_callback_router.getFrame / .free are declared with idiomatic Zig
pointers (*?*anyopaque, *vs.VSFrameContext, *const vs.VSAPI). Zig will not
implicitly cast between *T and [*c]T inside a function-pointer type, so passing
&getFrame to createVideoFilter fails.
FIX (W3C's call on exact form): declare getFrame/free in BOTH routers with the
exact parameter types the bridge's createVideoFilter signature requires (the
[*c]/optional forms above), matching what translate-c generated for
VSFilterGetFrame / VSFilterFree. This is a router-signature change; the router
BODIES and the permanent-switch structure do not change. Keep it consistent
across classic and deblock4.

DEFECT B - optional-unwrap on a [*c] pointer, int array (classic L162 /
deblock4 L156). zig_vs_map_get_int_array returns [*c]const i64. The code does
`values.?[0..count]`, but [*c] is not an optional, so `.?` is rejected
("expected optional type, found [*c]const i64"). The `values == null` compare is
fine for [*c]; only the `.?` unwrap is wrong.
FIX: take the slice from the [*c] pointer without optional-unwrap, e.g. after
the null check use `values[0..@intCast(count)]` (a [*c] pointer indexes/slices
directly), or convert to a many-item pointer first. W3C picks the idiom;
the point is: no `.?` on a [*c].

DEFECT C - optional-unwrap on a [*c] pointer, data (classic L174 / deblock4
L167). Same as B for zig_vs_map_get_data returning [*c]const u8: `value.?[0..
size]` -> "expected optional type, found [*c]const u8".
FIX: same as B - slice the [*c] directly after the null check, no `.?`.

DEFECT D - integer width u5 vs u8 (classic L205 / deblock4 L191).
video_info.format's subsampling fields are u5 (translate-c typed the small
bitfields that way); the target expects u8 (or the reverse). "unsigned 5-bit int
cannot represent all possible unsigned 8-bit values."
FIX: an explicit @intCast at the assignment to reconcile the widths (u5 -> u8 is
always safe; if the struct field is u5 and the source is u8, verify the value
range or widen the field). W3C confirms the direction from the actual types.

## 3. Scope of the fix

```text
- Only classic_instance_creation.zig, deblock4_instance_creation.zig, and the
  two *_callback_router.zig (for the getFrame/free signature in Defect A) are
  touched.
- Phase 1 modules are UNCHANGED (filter_call_parameters.CallValue etc. are
  correct; the mismatch is on the creation side consuming the bridge).
- The harness (build_phase2_validation.zig, the temp-root approach) is
  UNCHANGED and working.
- No design or scope change. These are interop-type corrections only.
```

## 4. Re-delivery and re-validation

W3C re-delivers the corrected instance_creation modules (and the two routers if
Defect A is fixed there), production patch re-cut. W3X re-runs
build_1c2_phase2_validation.bat. Expect: 0 compile errors, tests green in all
three modes, no leftover src/__phase2_validation_plugin_root.zig in git status.

## 5. One line for W3X

The harness fix worked (collision gone, 28/28 tests passed); 8 real interop
type-mismatch errors remain in the two instance_creation modules (callback
pointer [*c] forms, [*c] slices without `.?`, and a u5/u8 cast), all mirrored
Classic/Deblock4 - W3C corrects the interop types and re-delivers; no design
change.
