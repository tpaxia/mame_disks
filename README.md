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
