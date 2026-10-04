# HDI repeat after accepting canonical ID-only format

<!-- copyright-holders: Salvatore Paxia -->

2026-10-04. At the user's explicit request, rebuilt P6066 with the CHD
FORMAT correction and repeated the original HDI initialization on separately
created media. **HDI traversed cylinders 0–201 and returned READY. Every
disk command completed with status 00, including all 808 FORMAT commands.**

The user explicitly authorized this integration experiment despite the open
[preboot hardware gate](../../../mame-p6066/preboot-hardware-gate.md). It does
not establish CPU, bus or peripheral completeness. No guest instructions,
registers or RAM were patched; input used ordinary emulated keys/buttons.

## Production change and validation

`mame/src/devices/bus/p6066/hdu.cpp::record_format` accepts data marker `FF`
as well as `55` with canonical identifiers. HDI intentionally formats the
identifiers first and creates data fields with later WRITE commands. The
healthy CHD model stores payloads and supplies markers implicitly. FORMAT
still consumes its complete DMA sequence and fills actual target payloads
with FF; real host errors and invalid IDs/markers remain failures.

`implementation.patch` captures the source, documentation and disk-method
regression changes. Tests passed:

* `python3 mame/scripts/puce/test_hdu_image.py`: ID-only and complete format,
  FF fills, invalid IDs/markers, missing media, incomplete transfer and host
  failure checks, alongside existing geometry/read/write coverage.
* `python3 analysis/hardware/hdu/format-error-20/check_format_path.py`: 64
  production DIFO+HDU callback cases, both templates, all heads and units,
  ordinary and service cylinders. All 49 slots consumed, published status 00,
  real FF fills and no changes to other sectors.
* `python3 mame/scripts/puce/test_difo_transfer.py`: existing DIFO operation,
  DMA, fault and timeout suite.
* Emulator build and `git diff --check` passed.

The [diagnosis](../format-error-20/README.md) records original binary offsets
and full manual chapter/timing evidence.

## Fresh inputs and launch

Source utility floppy, read-only:
`/Users/paxia/Projects/L1_M30_M40/reference/images/hd-utilities/hduutilities.imd`.
SHA256 before/after:
`3febce41bcc5d1bada32374bc5e38a9c06e1d7e8f508f9e1e9c86a6e48038968`.
`utilities.imd` began as a fresh copy; startup wrote the disposable copy.
Created `blank.chd` with the project tool **without --ese-geometry**: all-FF,
202 cylinders × 4 heads × 48 sectors × 256 bytes. No compatibility seeds.
`input-media.json` retains initial input and rebuilt emulator hashes.
Executable SHA256:
`edc1945fc2c144ce61dc2562aca440163e786f528acd17c13b59e29868ca7276`.

From this directory:

```
../../../../mame/p6066 p6066 \
  -rompath ../../../mame-p6066/roms \
  -bus:dma rodma -bus:hdu difo -hard1 blank.chd -flop2 utilities.imd \
  -cfg_directory cfg -nvram_directory nvram -snapshot_directory snap \
  -video none -sound none -nothrottle -skip_gameinfo \
  -autoboot_delay 0 -autoboot_script observe.lua -log -seconds_to_run 1505
```

Reused the previous recorded operator queue, initially omitting EXIT. It
selected NORMAL keyboard mode, entered HDI, selected A0, pattern 000000, one
pass, rejected CHECK ONLY 0, accepted 1, and answered I to ERMAP NOT FOUND.
The previous command-entry calibration remains visible in the transcript,
including the duplicated EXE HDI,A0 entry; this is a recorded reproduction,
not a newly polished minimal operator procedure. The numeric CHECK ONLY
meaning remains unresolved, though the selected response performs formatting,
writes and verifies.

After observing all 808 formats and final READY, appended EXIT to the live
queue. The observer captured RAM, registers and a screenshot, then exited
normally at 1093.95 emulated seconds. **Do not launch with the retained final
queue unmodified**: EXIT is processed immediately when read. To repeat, create
new media in a new directory, adjust the observer's directory, remove EXIT
before launch, and append it only after completion (or use the observer's
1500-second limit). Do not overwrite the retained initialized CHD.

## Results

| Execute byte | Operation | Commands | Status |
| --- | --- | ---: | --- |
| 83 | FORMAT | 808 | All 00 |
| 13 | WRITE | 1810 | All 00 |
| 09 | VERIFY | 808 | All 00 |
| 05 | READ | 1 | 00 |

All 38,784 payload sectors changed from the initial FF pattern. CY0/ST7
byte75 is ASCII8; bytes82–90 contain `200192256`. CY0/ST5 begins ERMAP;
CY0/ST6 is spaces. CY200 holds service/check records; CY201 is the zero test
pattern. CY0/ST4 byte253 is zero because the selected pattern writes the
whole sector, not independent proof of that maintenance byte's meaning.

`sector-comparison.json` is reproduced by `summarize.py`. `after.raw` SHA256:
`f23dc2d0f25d41e5441017e7323eba115d98564001a7e91a80b8735c4f4b51df`.
The payload is byte-for-byte identical to the earlier complete run (zero
differing sectors), as recorded in `repeat-comparison.json`. The earlier
run's subsequent writes had already populated every sector despite failed
FORMAT commands; this repeat corrects those command completions.

`display-transcript.txt` and `snap/p6066/0000.png` confirm final READY. The
retained `blank.chd` is now the initialized output, not blank input. This is
physical preparation and service metadata, not a logical volume installation;
no VOL/DKS operation or subsequent OS installation was attempted.

## Comparison with boot-derived preparation

`metadata-vs-seed.json` compares this HDI payload with the exact preparation
recipe in `tools/p6066_hdu_image.py create --ese-geometry`, before any logical
generation or OS installation. All eleven seeded bytes match: CY0/ST7 byte75
ASCII8, bytes82–84 ASCII200,85–87 ASCII192,88–90 ASCII256, and CY0/ST4 byte253
00. Thus the boot-derived geometry values and offsets are directly confirmed.
The maintenance byte agrees in this zero-pattern run, but its semantic meaning
is still not established independently of the whole-sector pattern write.

The preparation seed leaves all other bytesFF. HDI additionally writes ERMAP
plus spaces in CY0/ST5, spaces in ST6, and192 service/check records in CY200.
Every CY200 record contains packed-decimal CY200/ST0–191 with C sign nibbles
in its first four bytes and a00..FB ramp in the remaining252 bytes. Their
purpose is not fully decoded. The rest of CY0/ST7 also differs: first80 bytes
are zero except byte75; bytes80–255 retain the service buffer's4C..FB ramp
except the geometry overrides. These remaining bytes are not established
additional required geometry fields. ST7 differs at246 unseeded byte positions.

HDI's zero-pattern pass changes ordinary unused payloads and CY201 to00;
these bulk pattern differences must not be classified as format metadata.
Comparing with the installed `boot-chd/SYSDIS.chd` would additionally include
later DKS filesystem/OS writes, so that is not the preparation comparison used
here. Neither this result nor the seed is a complete logical-volume label.
