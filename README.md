# MAME regression disk images

Ready-made disk images for testing systems in current MAME. See the linked
projects for build details, provenance, and fuller operating instructions.

## Zilog System 8000 — ZEUS 3.2.1

The [`s8000`](s8000/README.md) folder contains the ZEUS 3.2.1 hard disk image.
Background and build details are in
[tpaxia/Zilog_S8000](https://github.com/tpaxia/Zilog_S8000).

```sh
mame s8000 -hard1 hard\s8000\s8000_smd.chd
```

For `s8000`, enable **Support Segmented OS** in Machine Configuration and
restart the machine. Press numeric-keypad `+` for the front-panel **START**
button. The same image can also be run on the Series Two CPU:

```sh
mame s8000s2 -hard1 hard\s8000\s8000_smd.chd
```

Do not open the image in both machines at the same time.

## Olivetti M20 — CP/M-8000 and PCOS 4.0

The [`m20`](m20/README.md) folder contains the CP/M-8000 hard disk image, the
CP/M-8000 boot floppy, and PCOS 4.0 system and utility floppies. Background
and build details are in [tpaxia/CPM8000](https://github.com/tpaxia/CPM8000).

See the [M20 boot instructions](m20/README.md) for PCOS hard disk boot and
CP/M-8000 boot, including CPU selection.

Boot CP/M-8000:

```sh
mame m20 -bios 2 -ram 512k \
  -hard1 /path/to/mame_disks/m20/m20-cpm8000.chd \
  -flop1 /path/to/mame_disks/m20/REL11A.IMG
```

Use working copies of the images if you want to keep these originals pristine.

## Olivetti M24 — PCOS-M24

The [`m24`](m24/README.md) folder contains the PCOS-M24 boot floppy and a
blank hard disk image. See the [M24 regression instructions](m24/README.md)
for floppy boot with either the hard disk controller disabled or an empty
disk attached, using 640 KB RAM and the Z8000 adapter.

## Olivetti M40

Various operating systems run on the M40: ESE, MDOS, BCOS II and MOS, along
with the DCOS diagnostics and a utility disk. See the
[M40 page](m40/README.md).

## Olivetti P6066 — ESE

Floppy boot, [HDU initialization and ESE installation](P6066/hdu/initialized-ese/README.md),
plus keyboard mapping.

[P6066 howto](P6066/README.md).
