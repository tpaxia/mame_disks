# Olivetti P6066 media

This directory contains 51 IMD floppy images, including a generated HDU
bootstrap, plus an installed 10 MB HDU image. `SHA256SUMS` records every image.
Use working copies: ESE writes to mounted system and bootstrap media during
ordinary startup and operation.

## HDU system

`hdu/P6066_HDU_BOOTSTRAP.IMD` and
`hdu/P6066_HDU_10MB_INSTALLED.chd` are a matched, one-HDU system generated from
the P6066 1.0 generator/master media. The CHD has 202 cylinders, four heads,
48 sectors per track and 256-byte sectors. It contains the installed operating
system; it is not a blank disk.

The CHD includes the two pre-generation compatibility preparations recovered
during emulator validation:

- CY0/ST7 contains the ESE geometry fields used by DKS.
- CY0/ST4 byte 253 is `00`; K06066-R1.0 prints
  `HDU CHECK REQUIRED-CALL OLIVETTI` when this byte remains `FF`.

The exact archived pair was cold-booted in MAME on 2026-09-21. It reached
`READY` after 483 bootstrap-sector reads and remained running through 60
emulated seconds with no DIFO error. The post-test writable copies were
discarded and the pristine pre-boot images restored here.

Example for the `tpaxia/mame` `P6066` branch:

```sh
mame p6066 \
  -bus:dma rodma -bus:hdu difo -bus:video go011 \
  -hard1 P6066/hdu/P6066_HDU_10MB_INSTALLED.chd \
  -flop2 P6066/hdu/P6066_HDU_BOOTSTRAP.IMD
```

FDU1 is intentionally empty in that command. The installed configuration may
report ERROR 154 for missing FDU1 and ERROR 173 when no user library is open;
both conditions are documented ESE messages and do not prevent `READY`.

## System and distribution floppies

`system/` contains the inspected z80ne set 064-068 and 118-123, the clean
Melandri system captures, and the three clean Marinelli conversions. Notable
runtime results include:

- `119.IMD` boots to `READY` and provides the P6066 assembler environment.
- `067.IMD`, `SYSTEM_DISK_R_3_2_GTL3.IMD`, and
  `MARINELLI_DISTRIBUZIONE1.IMD` boot to `READY`, accept numbered BASIC, and
  run a tested `DISP` program.
- `064.IMD` plus master `068.IMD` completed the tested 10 MB HDU generation
  procedure from which the archived HDU pair was produced.
- `SYSTEM_DISK_GTL_3_R4_1.IMD` boots to `READY`; its generated configuration
  does not include BASIC editing.
- `DISCO_SISTEMA_R3_2_REDECODED.IMD` is the complete 2,002-sector decode of
  its original SCP. It replaces the supplied IMD that contained 15 sectors
  marked with data errors; the recovered image has not been boot-qualified.

`066.IMD` is retained because its system datasets read completely and its
resident firmware matches master 068. Its capture contains four ambiguous
addresses late on track 73, so it is not described as a completely clean
physical capture.

## Application floppies

`applications/` preserves the verified P6060/P6066 application-library IMDs in
their descriptive source directories. Every included image has a complete,
uniquely addressed, readable standard usable area. This is media-integrity
validation; it does not claim that every application has been executed in the
emulator.

Known damaged or incomplete captures were deliberately excluded: z80ne 063,
the supplied damaged `DISCO_SISTEMA_R3_2.IMD`, and the curve-fitting
`NUM_AN~1.IMD` with two data-error sectors. Z80ne 062 is a diagnostic-format
image outside the normal system/application geometry and is also excluded.

The analysis, provenance, filesystem checks and generation logs are maintained
in [tpaxia/P6066](https://github.com/tpaxia/P6066).
