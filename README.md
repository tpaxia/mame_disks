# MAME regression disk images

Ready-made disk images for testing systems in current MAME. See the linked
projects for build details, provenance, and fuller operating instructions.

## Zilog System 8000 — ZEUS 3.2.1

The [`s8000`](s8000/README.md) folder contains the ZEUS 3.2.1 hard disk image.
Background and build details are in
[tpaxia/Zilog_S8000](https://github.com/tpaxia/Zilog_S8000).

```sh
mame s8000 -hard1 s8000/s8000_smd.chd
```

For `s8000`, enable **Support Segmented OS** in Machine Configuration and
restart the machine. Press numeric-keypad `+` for the front-panel **START**
button. The same image can also be run on the Series Two CPU:

```sh
mame s8000s2 -hard1 s8000/s8000_smd.chd
```

Do not open the image in both machines at the same time.

## Olivetti M20 — CP/M-8000 and PCOS 4.0

The [`m20`](m20/README.md) folder contains the CP/M-8000 hard disk image, the
CP/M-8000 boot floppy, and PCOS 4.0 system and utility floppies. Background
and build details are in [tpaxia/CPM8000](https://github.com/tpaxia/CPM8000).

Boot CP/M-8000:

```sh
mame m20 \
  -hard1 m20/m20-cpm8000.chd \
  -bios 2 -ramsize 512k \
  -flop1 m20/REL11A.IMG
```

Use working copies of the images if you want to keep these originals pristine.

## Olivetti M40 — bootable floppy media

The [`m40`](m40/README.md) folder collects the IMD images verified to boot to a
usable screen or prompt: ESE, MDOS, BCOS II 3.3, the generated BCOS LOAD/RUN
pair, Gardini utilities, and the DCOS 8.4 diagnostic set.

For example, boot ESE with:

```sh
mame m40 -ram 2m -flop1 /path/to/mame_disks/m40/ESE.IMD
```

## Olivetti M40 — BCOS

Boot the M40, open BASIC, or generate a new BCOS system from scratch.

[Windows quick start](BCOS/BCOS_WINDOWS_BASIC.md) ·
[BCOS generation](BCOS/BCOS_GENERATION.md) ·
[M40 ANK keyboard map](BCOS/M40_KEYBOARD.md) ·
[ESE keyboard overlay](BCOS/M40_ESE_KEYBOARD.md)

## Olivetti P6066 — ESE

The `P6066` folder contains verified system/application IMDs and a boot-tested,
installed 10 MB HDU system with its generated bootstrap floppy.

[P6066 media, validation notes and launch command](P6066/README.md).
