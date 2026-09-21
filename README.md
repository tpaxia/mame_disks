# MAME regression disk images

Ready-made disk images for testing systems in current MAME. See the linked
projects for build details, provenance, and fuller operating instructions.

## Zilog System 8000 — ZEUS 3.2.1

Image: `s8000_smd.chd`. Background and build details are in
[tpaxia/Zilog_S8000](https://github.com/tpaxia/Zilog_S8000).

```sh
mame s8000 -hard1 /path/to/mame_disks/s8000_smd.chd
```

For `s8000`, enable **Support Segmented OS** in Machine Configuration and
restart the machine. Press numeric-keypad `+` for the front-panel **START**
button. The same image can also be run on the Series Two CPU:

```sh
mame s8000s2 -hard1 /path/to/mame_disks/s8000_smd.chd
```

Press numeric-keypad `+` to start it. Do not open the image in both machines at
the same time.

## Olivetti M20 — CP/M-8000

Image: `m20-cpm8000.chd`. Background and build details are in
[tpaxia/CPM8000](https://github.com/tpaxia/CPM8000).

Boot with the CP/M-8000 `REL11A.IMG` floppy:

```sh
mame m20 \
  -hard1 /path/to/mame_disks/m20-cpm8000.chd \
  -bios 2 -ramsize 512k \
  -flop1 /path/to/flop/REL11A.IMG
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

Configure BCOS, boot the M40 and open BASIC on Windows.

[Read the BCOS Windows guide](BCOS/BCOS_WINDOWS_BASIC.md).

[PC keyboard map and keyboard diagnostic tests](BCOS/M40_KEYBOARD.md).

## Olivetti P6066 — ESE

The `P6066` folder contains verified system/application IMDs and a boot-tested,
installed 10 MB HDU system with its generated bootstrap floppy.

[P6066 media, validation notes and launch command](P6066/README.md).
