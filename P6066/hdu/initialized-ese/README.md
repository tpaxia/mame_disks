# P6066 HDU initialization and ESE system installation

<!-- copyright-holders: Salvatore Paxia -->

This directory preserves the original-media inputs and two HDU stages. The
physical geometry is 202 cylinders, four heads, 48 sectors per head and
256-byte payloads. CHD supplies healthy sector markers and CRCs implicitly.

| File | Purpose |
| --- | --- |
| `HDU2110-initialized.chd` | Clean output of original HDI physical preparation; no installed ESE system |
| `SYSDIS.chd` | HDU after DKS logical initialization and system installation |
| `SYSBTS.imd` | Matching bootstrap floppy produced by that installation |
| `inputs/hduutilities.imd` | Original HD utilities disk containing HDI E9 |
| `inputs/generator-064.imd` | Original P6066 disk generator |
| `inputs/master-068.imd` | Original system master |

Always use copies of preserved media for emulation. Startup and generation
can write the mounted floppies and HDU. `SHA256SUMS` and `manifest.json` identify
the saved inputs and outputs; verify them from this directory with
`shasum -a 256 -c SHA256SUMS`.

## Emulator versions

Physical HDI preparation used the current `mame/p6066`, based on commit
`cd00a82cf84`, with the ID-only FORMAT correction retained in
`evidence/hdi-implementation.patch`. Apply that patch only to the matching
unmodified source, or use the current project tree where it is already applied.
Build from the emulator checkout:

```
make SUBTARGET=p6066 SOURCES=src/mame/olivetti/p6066.cpp \
  OSD=sdl USE_LIBSDL=1 SDL_INSTALL_ROOT=/opt/homebrew IGNORE_GIT=1 REGENIE=1 -j4
```

These are the tested macOS/Homebrew SDL build options. ROMs reside in
`analysis/mame-p6066/roms` relative to the project root.

DKS installation also uses the current `mame/p6066`, with the PR 6610 printer
card attached. The system master is configured to use the integrated printer;
an empty printer slot is not a printer-free software configuration. The older
emulator supplied a printer implicitly, so attributing its successful input
solely to the older keyboard was incorrect. The current keyboard works with
the supported printer card and the input sequence below. Earlier historical
installation outputs are archived in `historical/`; they are not required.

## 1. Create a new HDU and run HDI

Set the emulator project and this media directory first (adjust their locations
if needed), then create a new working directory and an entirely FF disk:

```sh
project_dir="$HOME/Projects/P6066"
media_dir="$HOME/Projects/mame_disks/P6066/hdu/initialized-ese"
```

```
mkdir -p "$media_dir"/reproduce-hdi
cp "$media_dir"/inputs/hduutilities.imd "$media_dir"/reproduce-hdi/utilities.imd
python3 "$project_dir/tools/p6066_hdu_image.py" create "$media_dir"/reproduce-hdi/HDU.chd
cd "$media_dir"/reproduce-hdi
"$project_dir/mame/p6066" p6066 -rompath "$project_dir/analysis/mame-p6066/roms" \
  -bus:dma rodma -bus:hdu difo -hard1 HDU.chd -flop2 utilities.imd \
  -cfg_directory cfg -nvram_directory nvram -window -skip_gameinfo
```

Do not add `--ese-geometry`: HDI itself writes the original preparation
records. FD1 is empty; the utility boot disk is in FD2. Wait for startup.
The recorded run displayed ERROR154 ON UNIT USR, then ERROR173 after Continue.
Select NORMAL/typewriter keyboard mode with F9 (KB MODE lamp on), so Shift
plus letters enters uppercase instead of BASIC keywords. Leave MAME UI controls
disabled; F12 toggles them in the current project.

The exact verified current-emulator entry sequence is archived in
`evidence/hdi-recorded-queue.txt` and its display transcript. It presses
Continue, switches mode, types `EXE HDI,A0`, presses Continue twice, then
re-enters `EXE HDI,A0` and presses Continue. The first entry returned READY;
the display contains duplicated command text before HDI's own prompts. This
is an observed emulator entry sequence, not a claim that the historical
operator needed to type the command twice. Follow the prompts once HDI starts:

| Prompt | Enter | Submit |
| --- | --- | --- |
| PU NAME | `A0` | Continue |
| PATTERN | `000000` | Continue |
| N. OF PASSES | `1` | Continue |
| CHECK ONLY | `0` is rejected; then enter `1` | Continue after each |
| ERMAP NOT FOUND | `I` | Continue |

The recorded automation also presses main END OF LINE after each typed string.
The numeric CHECK ONLY semantics are not fully decoded; the verified response
`1` performs formatting, writes and verifies. Wait for cylinders 0–201 and
final READY. Do not interrupt during the pass. Exit MAME normally, then save a
copy of `HDU.chd` as the clean initialized stage before logical installation.
To skip only this physical-preparation pass, start the next stage with a copy
of the preserved `HDU2110-initialized.chd`.

The saved clean image came from a zero-pattern pass: all 808 FORMAT commands,
1,810 WRITE commands, 808 VERIFY commands and one READ returned status00.
CY0/ST7 byte75 is ASCII8 and bytes82–90 are `200192256`. CY0/ST5–6 contain
ERMAP/spaces, and CY200 holds service/check records. This is not yet a volume
installation. The CY0/ST4 maintenance byte is zero because the selected pattern
wrote the entire sector; its separate service meaning remains unresolved.

## 2. Logically initialize the HDU and install ESE with DKS

With `project_dir` and `media_dir` set as above, use fresh copies. `master.imd` will become the output
bootstrap floppy after the master has been copied to the HDU.

```
mkdir -p "$media_dir"/reproduce-install
cp "$media_dir"/HDU2110-initialized.chd "$media_dir"/reproduce-install/SYSDIS.chd
cp "$media_dir"/inputs/generator-064.imd "$media_dir"/reproduce-install/generator.imd
cp "$media_dir"/inputs/master-068.imd "$media_dir"/reproduce-install/master.imd
cd "$media_dir"/reproduce-install
"$project_dir/mame/p6066" p6066 \
  -rompath "$project_dir/analysis/mame-p6066/roms" \
  -bus:dma rodma -bus:hdu difo -bus:console:goino:options pr6610 \
  -hard1 SYSDIS.chd \
  -flop1 master.imd -flop2 generator.imd \
  -cfg_directory cfg -nvram_directory nvram -window -skip_gameinfo
```

Use reset BASIC keyboard mode (KB MODE lamp off). Press alphabetic keys
**without Shift** to enter uppercase letters; Shift+letters enters BASIC
keywords in this mode. Submit each line with main END OF LINE. Use Shift
with the physical minus key for `=` and with the colon key for `*`.
Wait for READY, then enter the following, waiting for each new prompt:

```
EXE DKS,IN=FDU1
HDU,A0,HD
FDU,C0,FDU1
FDU,C1,FDU2
*
TEST
L
```

The three device declarations answer consecutive UNIT? prompts. `*` ends the
device list. `TEST` answers SYSTEM PASSWORD? and is the chosen system password.
`L` answers INIT HD? and performs logical initialization of the already
physically prepared HDU.

At DISK FOR SYSTEM ON HD, press Continue. Wait for LOAD DISK ON FDU1; the
fresh master is already in FD1, so press Continue then. Wait for copying to
finish and BOOTSTRAP?. Stay in reset BASIC mode, press the **unshifted Y key**
and END OF LINE. This displays uppercase `Y`. At LOAD DISK FOR
BTSTRAP ON FDU1, retain the disposable working
master and press Continue: its needed contents are already on the HDU, and
this run reuses it as the output bootstrap disk. Wait for END OF GENERATION.

Exit MAME normally before copying the outputs. Save `SYSDIS.chd` and rename a
copy of the now-written `master.imd` to `SYSBTS.imd`. Keep this pair together.
Do not seed geometry after generation or repair generated files; HDI supplies
the preparation before DKS performs its allocation and bootstrap construction.

## 3. Cold boot the generated pair

Use the current emulator with copies of the installed HDU and SYSBTS in FD2.
FD1 is empty; neither generator nor original master is mounted.

```
mkdir -p "$media_dir"/reproduce-boot
cp "$media_dir"/SYSDIS.chd "$media_dir"/reproduce-boot/SYSDIS.chd
cp "$media_dir"/SYSBTS.imd "$media_dir"/reproduce-boot/SYSBTS.imd
cd "$media_dir"/reproduce-boot
"$project_dir/mame/p6066" p6066 -rompath "$project_dir/analysis/mame-p6066/roms" \
  -bus:dma rodma -bus:hdu difo -bus:console:goino:options pr6610 \
  -hard1 SYSDIS.chd -flop2 SYSBTS.imd \
  -cfg_directory cfg -nvram_directory nvram -window -skip_gameinfo
```

With PR 6610 attached, wait for READY; no console acknowledgment is needed.
The printer still reports ERROR154 ON UNIT FDU1 and ERROR173 with FD1 empty,
but READY appears without input.
The earlier printer-absent test reported `ERROR154 ON UNIT FDU1` and then
`ERROR173`, requiring Continue after each. That is retained as historical
evidence, not the normal boot sequence of the configuration above.

## Scope and evidence

These are explicitly user-authorized original-software integration runs.
They do not close the project's CPU/bus/peripheral hardware acceptance gate.
No guest-code, register, RAM or post-generation image repair is involved.
HDI preparation evidence is retained under `evidence/`; installation and
cold-boot evidence are retained there with the saved outputs. DKS reached END
OF GENERATION with 101 reads, 422 writes and 422 verifies on the HDU, all
status00. The current-emulator cold boot read 483 floppy sectors and completed
14 HD reads, one write and one verify, all status00; READY remained displayed
through60 emulated seconds with PR 6610 attached. The three
bootstrap datasets K0E001/K0E002/K0E003 exactly match the previously successful
boot-derived installation's firmware. This validates generation and cold boot,
not every application or disk operation. See `evidence/boot-verification.json`,
`evidence/boot-ready.png` and `manifest.json`. Reproduction means
the same preparation, installed system and boot result; unused bytes and
container encoding can vary if operator timing or floppy reuse differs.
