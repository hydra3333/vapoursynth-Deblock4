# Deblock4 - Post-5C Maintenance M2 - W3C Blocking Finding M2-W3C-F2 v1.0

**From:** W3C (coder)
**Route:** W3C -> W3X -> W3D
**Date:** 2026-08-16
**Controlling scope:** `Deblock4_Scope_PostM2_Identifier_Hygiene_v1_2.md`
**Status:** BLOCKING scope/mechanism interaction found before implementation.
**Repository changes made:** NONE.

## DECISIONS/QUESTIONS FOR W3X

### Q1 - amend the S2 retired-list treatment of `tools/holywu_reference/`

**Finding**

M2 v1.2 section 4 requires the S2 retired-file list to add the
`tools/holywu_reference/` members.

One member is:

    tools/holywu_reference/README.md

The live S2 script does not scan references by full retired path. It derives:

    $names=$ret | % {[IO.Path]::GetFileName($_)}

and then fails if ANY live file in its search domain contains ANY derived
basename.

Therefore adding the member above derives the generic retired basename:

    README.md

But the current live `build.zig.zon` already contains:

    "README.md",

Consequently a literal implementation of the ratified v1.2 instruction would
make S2 fail permanently on an unrelated legitimate root README reference.

This is not hypothetical. It follows directly from the current committed S2
algorithm and current `build.zig.zon`.

**No edit has been made.**

## Recommended correction

Retire the HolyWu DIRECTORY as the S2 tripwire instead of enumerating its
members:

    'tools/holywu_reference'

(no trailing slash).

Why this preserves the intended guarantee:

1. `$ret` already checks every entry with `Test-Path -LiteralPath`.
   If the retired directory, or therefore any member at its original path,
   reappears, S2 fails immediately.

2. `GetFileName('tools/holywu_reference')` yields the distinctive basename
   `holywu_reference`, so the second half of S2 also rejects surviving live
   references to that retired directory vocabulary.

3. It avoids globally treating the generic basename `README.md` as retired.

4. No S2 algorithm change is required; only the contents of the existing
   retired list change, preserving v1.2's intended mechanism and diff
   confinement.

5. The live crosswalk is already authorised to stop naming the old HolyWu
   paths, so the distinctive `holywu_reference` reference tripwire can become
   clean after the coordinated edit.

## Proposed scope wording change

Current intent:

    Add ... tests/stage_1c_classic_passthrough.vpy and the
    tools/holywu_reference/ members.

Proposed:

    Add ... tests/stage_1c_classic_passthrough.vpy and the retired directory
    path tools/holywu_reference (no trailing slash). Do not enumerate the
    directory's README.md member in $ret, because S2 derives basenames and
    would thereby blacklist every live README.md reference. The directory
    Test-Path tripwire enforces retirement of all members at their original
    paths, and the derived basename holywu_reference enforces removal of live
    references to the retired directory.

## W3C disposition

STOP before implementation.

This is a narrow proof-mechanism correction, not a design change and not a
request to weaken retirement enforcement. W3C recommends W3D issue a v1.3
correction (or an explicit ratified addendum) and then implementation can
proceed immediately against the same accepted M1 base.
