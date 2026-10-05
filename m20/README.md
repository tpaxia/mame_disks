# Olivetti M20 disk images

## Images

- `m20-cpm8000.chd`: hard disk with CP/M-8000 installed. Background and
  build details: [tpaxia/CPM8000](https://github.com/tpaxia/CPM8000).
- `REL11A.IMG`: CP/M-8000 boot floppy.
- `m20_pcos.chd`: PCOS-8000 4.1a hard disk.
- `pcos4.img`: PCOS 4.0 system floppy.
- `pcos4_util.img`: PCOS 4.0 utilities floppy.

Use working copies of the images. Set the path to this repository:

```sh
export MAME_DISKS=/absolute/path/to/mame_disks
```

## PCOS hard disk boot

Boot with 512 KB RAM and no floppy attached:

```sh
mame m20 -bios 2 -ram 512k \
  -hard1 "$MAME_DISKS/m20/m20_pcos.chd" \
  -window -skip_gameinfo -nomouse
```

At `Select Alternate CPU (y/n)?`, answer `n` to retain the Z8001 CPU.
PCOS-8000 4.1a should reach the `10>` command prompt without a memory error.

## CP/M-8000 boot

Boot with the hard disk and `REL11A.IMG` floppy:

```sh
mame m20 -bios 2 -ram 512k \
  -hard1 "$MAME_DISKS/m20/m20-cpm8000.chd" \
  -flop1 "$MAME_DISKS/m20/REL11A.IMG" \
  -window -skip_gameinfo -nomouse
```

Answer `n` at the alternate CPU prompt. CP/M-8000 Version 1.1 should reach
the `A>` command prompt.

## M24 PCOS floppy boot

See the [M24 regression instructions](../m24/README.md) for both configurations:
hard disk controller disabled, or controller enabled with an empty disk attached.
