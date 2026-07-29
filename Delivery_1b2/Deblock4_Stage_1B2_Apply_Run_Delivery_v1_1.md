# Deblock4 Stage 1B.2 - Apply and Run Delivery

**Version:** 1.1  
**Date:** 2026-07-29  
**Scope:** `Deblock4_Scope_Stage_1B2_v1_7.md`  
**Status:** W3D-APPROVED IMPLEMENTATION, REISSUED FOR EXACT CRLF DELIVERY  
**Encoding:** US-ASCII only

---

# 1. Why this package supersedes the first delivery

W3D approved the implementation content of the original Stage 1B.2 patch.
The only identified delivery defect was that a normal text patch does not
reliably preserve CRLF bytes when creating the two new files in every apply
environment.

This v1.1 delivery does not change the approved implementation. It changes only
how the files are transported:

```text
Deblock4_Stage_1B2_v1_7_v2.patch
    readable text patch for the three existing repository files;

repository_root/build_1B2_v1.bat
    complete new file with exact CRLF line endings;

repository_root/docs/Deblock4_Stage_1B2_WithinLevel_Report.md
    complete new file with exact CRLF line endings.
```

Do not use `Deblock4_Stage_1B2_v1_7.patch` from the first delivery. Use this
v2 patch plus the two supplied whole files.

---

# 2. Approved content retained

The delivery still changes exactly the five scope-permitted files:

```text
build.zig
src/backend_probe_avx2.zig
src/backend_probe_sse41.zig
build_1B2_v1.bat                              new whole file
docs/Deblock4_Stage_1B2_WithinLevel_Report.md new whole file
```

No Stage 1B.1 linkage, anchor, object wiring, import, installation, or PE-export
mechanism is changed.

The two supplied whole files are byte-identical to the files reviewed and
approved by W3D, including their CRLF endings.

---

# 3. File hashes

```text
Deblock4_Stage_1B2_v1_7_v2.patch
SHA-256 1bc4ce1dddb8ec98397260f36b54646c099c4fdd5b156f1a0788239fb8b4ae9e

repository_root/build_1B2_v1.bat
SHA-256 fa47b7b4c38755fc6babf83825e45adeda61cd43787a8579a60088d712385e8d

repository_root/docs/Deblock4_Stage_1B2_WithinLevel_Report.md
SHA-256 11fb18f00e7ac35d78a01e04a74dd1758941d62a1ede919a9737f26576db9f4d
```

Input identities remain:

```text
Deblock4_Scope_Stage_1B2_v1_7.md
SHA-256 73dd6069d4ac62c2bcdfbca404d85297c76f8df11db5e93d0a961acd5896983a

src_environment.zip
SHA-256 63d76ba77d17d7df702a0a0726d4a0f25bfc014feeb2827110955dcc89164fd3
```

---

# 4. Apply sequence

Extract this delivery package outside the repository.

From the repository root:

```bat
git status --short
git apply --check "<delivery-dir>\Deblock4_Stage_1B2_v1_7_v2.patch"
git apply --check --whitespace=error "<delivery-dir>\Deblock4_Stage_1B2_v1_7_v2.patch"
git apply "<delivery-dir>\Deblock4_Stage_1B2_v1_7_v2.patch"
```

Then copy the two whole files from the package's `repository_root` directory
into the matching repository paths:

```text
repository_root/build_1B2_v1.bat
    -> <repo-root>/build_1B2_v1.bat

repository_root/docs/Deblock4_Stage_1B2_WithinLevel_Report.md
    -> <repo-root>/docs/Deblock4_Stage_1B2_WithinLevel_Report.md
```

Create the repository `docs` directory if it does not yet exist.

Then run:

```bat
git diff --check
git status --short
```

Expected status:

```text
 M build.zig
 M src/backend_probe_avx2.zig
 M src/backend_probe_sse41.zig
?? build_1B2_v1.bat
?? docs/
```

Stop if any other repository file changes.

---

# 5. Mechanical validation performed

The corrected sequence was tested against a clean extraction of the exact
supplied `src_environment.zip` using Windows-style Git line-ending behaviour.

```text
git apply --check
    PASS

git apply --check --whitespace=error
    PASS

git apply
    PASS

copy both whole CRLF files
    PASS

git diff --check
    PASS

expected changed-file status
    PASS

line-ending verification on all five changed/new files
    PASS
    CRLF only; zero bare LF; zero bare CR
```

The corrected package does not rely on `--ignore-whitespace`.

---

# 6. W3X validation

After applying and copying the files, run:

```bat
build_1B2_v1.bat
```

The Stage 1B.2 PASS still depends on W3X's Windows execution, the generated
dumpbin evidence, and the manual within-level disassembly review. The report's
`PENDING W3X` fields must be updated with actual evidence before PASS is
claimed.

---

# 7. Disposition

```text
W3D implementation review:    APPROVED
CRLF delivery correction:     COMPLETE
Mechanical apply validation:  PASS
W3X Windows execution:        PENDING
W3X manual disassembly:       PENDING
Stage 1B.2 result:            NOT YET CLAIMED
```
