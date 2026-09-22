# P6060/P6066 numbered system disks

The three-digit filenames are archive/catalog numbers, not a boot sequence and
not release numbers. Some are bootable configured systems, some are generators
or master media, and one is only a user-program library. Do not assume that
consecutive numbers belong to one matched set.

The descriptions below are based on the disks' labels and decoded contents plus
current MAME tests. A caption such as “MASTER R3.1” is preserved as provenance;
it does not by itself prove that another disk is a matching generator or master.

| Image | What it is | Current MAME status |
|---|---|---|
| `MASTER_SYSTEM_FOR_COMPILATION_R1_0_GO011.IMD` | **GO011/EXD-configured derivative** of the pristine `MASTER_SYSTEM_FOR_COMPILATION_R1_0.imd` in `P6066/applications`. This is a writable guest-configured system copy, not untouched archival media. | Boots from floppy with `-bus:video go011`; displays `READY` on the GO011 framebuffer and built-in console. BASIC works, and `OPTIONS GDI` graphics have passed PLOT, selective ERASE, redraw, and full-clear tests. |
| `064.IMD` | **P6066 1.0 disk-system generator.** Contains `K0E002`, `K0E003`, `K0E001`, `WORKLB`, and the `K060661.0` identifier. It is the generator used with master `068.IMD` for the tested HDU-generation workflow. | Boots to `READY`. DKS accepts HDU and FDU definitions; the `064`/`068` workflow has generated and booted an HD system after geometry preparation. |
| `065.IMD` | **P6066 1.1 disk-system generator.** Contains the `K060661.1` family (`K0E00211`, `K0E00311`, `K0E00111`). No matching 1.1 master has been identified. | Boots to `READY`; DKS reaches `END OF GENERATION`, but the generated bootstrap tested so far cold-boots with `ERROR 181`. |
| `066.IMD` | **P6066 1.0 configured-system candidate.** Its resident firmware matches the `^P6FW0` payload on master `068.IMD`, but its firmware layout differs from generator `064.IMD`. The capture also has 53 ambiguous/error CHS entries in its late tracks. | With `068.IMD` in the other drive it loads extensively, then remains in status polling with a blank display; no `READY` in the recorded test. |
| `067.IMD` | Captioned **MASTER R3.1**, but operationally it is a **P6060 3.x system-bearing disk** containing `P6FWR3.0`. Do not confuse it with the P6066 1.0 software/firmware master `068.IMD`. | Boots to `READY`. Numbered BASIC programs have been entered and run successfully, displaying `12345` and returning to `READY`. |
| `068.IMD` | **P6066 1.0 OS software/firmware master**, not a normal CAROM boot system. Its `^P6LB0` library contains `^P6SW0` and `^P6FW0`, including the FSE/FDS function-selection and floppy-generation implementations. The volume caption `COBOL` does not make it a running COBOL system. | Use as source/master media, normally in the other floppy drive during generation. It is not intended to boot by itself. It is the matching master used with generator `064.IMD`. |
| `118.IMD` | Captioned **ASSEMBLER66 SORT**. A system-bearing/configured-system candidate containing the `K0E00501`, `K0E00601`, `K0E00401` family. Its exact relationship to `119.IMD` has not been established. | No recorded boot result yet. |
| `119.IMD` | **Assembler P6066 R1.0 configured system.** Contains `K0E00501`, `K0E00601`, `K0E00401`, and a populated `LIB` library. It is a useful standalone P6066 command environment, but it is not proven to be release-matched to master `068.IMD` or generator `064.IMD`. | Boots to `READY` on the built-in console/display. Useful as the straightforward numbered P6066 boot disk. |
| `120.IMD` | **User assembler-program library**, not a system disk. It does not contain the normal system-bearing firmware profile found on the bootable assembler disks. | Not a standalone boot disk; mount as user/application media from a running system. |
| `121.IMD` | **Assembler P6060 R1.0 configured-system candidate**, containing `P6FWR3.0`. This disk was heavily used for low-level loader, firmware, CPU, and FLODI tracing. | Loads the OS but reports `ERROR 172` in the current configuration; tracing shows probes for an interface that is not present/configured. |
| `122.IMD` | **P6060 Release 2.0 configured system**, containing `P6FWR2.0`. It belongs to the P6060 release-2 family, not the P6066 1.0 `064`/`066`/`068` candidate set. | Reports `ERROR 12 *A`, then reaches a recorded CPU stop. Not currently a recommended boot disk. |
| `123.IMD` | **P6060 Release 3.2 configured system**, containing `P6FWR3.0`. Its caption does not establish an exact match with `067.IMD`. | Boots with `ERROR 172`. `NEW` and a numbered `REM` statement are accepted afterward, but complete program execution was not established in that test. |

## Practical choices

- For verified GO011 video output, use **`MASTER_SYSTEM_FOR_COMPILATION_R1_0_GO011.IMD`** with `-bus:video go011`.
- For a simple numbered P6066 floppy boot, start with **`119.IMD`**.
- For a working P6060 3.x BASIC system, **`067.IMD`** reaches `READY` and has
  run a small BASIC program successfully.
- For P6066 HDU generation, use **`064.IMD` as the generator** and
  **`068.IMD` as the master source**; they are roles in a workflow, not two
  interchangeable boot disks.
- Do not try to boot **`068.IMD`** or **`120.IMD`** as standalone systems.

Use working copies if guest writes must not alter these reference images.
