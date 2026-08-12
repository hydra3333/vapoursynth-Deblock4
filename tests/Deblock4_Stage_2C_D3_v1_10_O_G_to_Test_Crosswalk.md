# Deblock4 Stage 2C D3 v1.10 O/G-to-Test Crosswalk

**Deliverable:** W3C-2C-O-G-CROSSWALK
**Version:** 1.0
**Status:** Stage 2C delivery proof map. W3X executes all gates.
**Encoding:** US-ASCII; CRLF.

| D3 obligation | Exact test/gate identifier | Modes |
|---|---|---|
| O-1 V1-V6 | `classic_thresholds.zig`: `threshold vectors V1 through V6` | Debug, ReleaseSafe, ReleaseFast |
| O-1 exhaustive bits 8..16 | `classic_thresholds.zig`: `full legal strength and offset-corner domain` plus `bit-depth scaling is exhaustive from 8 through 16` | all three |
| O-1b legal offset rejection | `filter_call_parameters.zig`: `strength and independent offsets reject out-of-range values`; vspipe `error_boundary_offset`, `error_side_offset` | all three / vspipe |
| O-1c full tables/index binding | `classic_thresholds.zig`: `all threshold table entries remain pinned` | all three |
| O-1d 17..32 refusal | `classic_instance_creation.zig`: `Classic format validation refuses every integer depth 17 through 32`; vspipe `n01c1`, `n01c2` | all three |
| O-2 A1-A5 | `classic_scalar_kernel.zig`: `activation vectors A1 through A5`; `classic_edge_schedule.zig`: `A1-A5 and B1-B8 run in both vertical and horizontal orientations` | all three |
| O-3 B1-B8 | `classic_scalar_kernel.zig`: `single-edge vectors B1 through B8`; `classic_edge_schedule.zig`: `A1-A5 and B1-B8 run in both vertical and horizontal orientations` | all three |
| O-4 exact Schedule A | `classic_edge_schedule.zig`: `Schedule A O-4 exact matrix and order sensitivity`; vspipe `o4_gray8` | all three / RS+RF |
| O-4 order discriminator/top band | same test, including swapped-order first difference | all three |
| O-5a plane-neutral/luma-on-chroma | vspipe `o5a_yuv420_chroma_o4` asserts the exact O-4 matrix on selected U; routing cases cover other families | RS+RF |
| O-5b unselected exact copy | vspipe `o8_yuv420_subset`, `o8_yuv420p10_subset`, `o8_yuv444p16_subset`, `o8_yuv422_v`, `o8_rgb_subset`, and `o5a_yuv420_chroma_o4` | RS+RF |
| O-5c strength zero plane-byte identity + properties | vspipe `strength_zero` | RS+RF |
| O-5d literal native 16-bit matrix | `classic_edge_schedule.zig`: `native 16-bit O-5d matrix`; vspipe `o5d_gray16` | all three / RS+RF |
| O-6a write-footprint union | O-4/O-7 matrix checks and unchanged-region assertions | all three / RS+RF |
| O-6b taps outside write footprint | B-vector unit tests and kernel result contract | all three |
| O-6c no border edge | O-7 unit and vspipe cases | all three / RS+RF |
| O-6d source immutability | every `stage_2c_classic_obligations.vpy` success case calls `_assert_source_immutable` | RS+RF |
| O-6e guard/stride canaries | guarded `TestPlane` allocation/row-slack checks in every O-4/O-5d/O-7 schedule test plus `single-edge taps, surrounding samples, and guard bands remain intact`; production O-7 cases | all three / RS+RF |
| O-6f i32 bounds | `classic_scalar_kernel.zig`: `documented 16-bit arithmetic bounds fit i32` | all three |
| O-7a 10x10 | unit `O-7 10x10...`; vspipe `o7_10x10` | all three / RS+RF |
| O-7b 12x6 | unit `O-7 12x6...`; vspipe `o7_12x6` | all three / RS+RF |
| O-7c 6x6 | unit `O-7 6x6...`; vspipe `o7_6x6` | all three / RS+RF |
| O-7c2 11x7 | unit `O-7 11x7...`; vspipe `o7_11x7` | all three / RS+RF |
| O-7d no resize/crop | source inspection gate `STAGE_2C_NO_PADDING_GRAPH_PASS`; all O-7 outputs | static + RS+RF |
| O-8a omitted planes | `o8_yuv444_all` and H6 C01/C04/C07 | RS+RF / H5 |
| O-8b explicit subset | `o8_yuv420_subset`, `o8_yuv422_v`, `o8_rgb_subset`; H6 C05/C06/C08 | RS+RF / H5 |
| O-8c chroma own geometry/stride/storage | `o5a_yuv420_chroma_o4`, `o8_yuv420_subset`, `o8_yuv420p10_subset`, `o8_yuv444p16_subset`, `o8_yuv422_v`; H6 C04-C06/C16/C17 | RS+RF / H5 |
| O-8d Gray | `o4_gray8`, `o8_gray10`, `o8_gray16`; H6 Gray cases | RS+RF / H5 |
| O-8e RGB selected plane | `o8_rgb_subset`; H6 C08 | RS+RF / H5 |
| O-8f source unchanged | immutable-source checks in every success case | RS+RF |
| O-8g audit properties exact | `_check_props` in every success case; `n04` | RS+RF |
| O-8h 8/u16 intermediate/16 | `o4_gray8`, `o8_gray10`, `o8_yuv420p10_subset`, `o5d_gray16`, `o8_gray16`, `o8_yuv444p16_subset`; H6 C13-C16 | RS+RF / H5 |
| Conditional float refusal | vspipe `n01a`, `n01b` | all three; summary count 0 |
| G1 discontinuity reduction | vspipe `sanity`, `_sanity_gate` | RS+RF |
| G2 output range | vspipe `sanity` | RS+RF |
| G3 2x2 corners | vspipe `sanity` | RS+RF |
| G4 deterministic plane bytes + properties | vspipe `sanity`, frames 0/1 | RS+RF |
| G5 max change | vspipe `sanity` | RS+RF |
| G6 mean change and negative control | vspipe `sanity`; `sanity_negative_control` must reject | RS+RF |
| T-S5-1a count 1 | batch exact-count gate for success/N02a/N02b/N03/N04 and Deblock4 cases | applicable modes |
| T-S5-1b count 0 | batch exact-count gate for N01a/N01b/N01c1/N01c2 | all three |
| T-S5-2 intentionally capped auto | vspipe `n04` + exact stderr/property assertions | all three on v3 host |
| T-S5-3 byte-stable Deblock4/force-down | successor Stage 1C matrix in `build_2C_v1.bat` | all applicable modes |
| T-S5-4 precedence | `n02a`, `n02b`, `n03` exact rows | ReleaseSafe/Debug |
| T-S5-5 force-down v2 + auto cap | Debug combined case in `build_2C_v1.bat` | Debug |
| K30 audit | delivery-manifest W3C K30 evidence + independent W3D re-verification | delivery evidence (not in-tree gate) |
| K31 byte-row model | source inspection gate + stride canary/O-8 cases | static + all three/RS+RF |
| H0-H6 | `tools/holywu_reference/run_stage_2c_holywu_reference.cmd` and `stage_2c_holywu_diff.vpy` | W3X generated reference evidence |

The batch runner fails if any D3 O/G identifier above is absent from this file.
