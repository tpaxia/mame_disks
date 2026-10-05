# Olivetti M24 — PCOS floppy boot

These images exercise the M24 Z8000 adapter:

- `pcos_m24.img`: PCOS-M24 Rev. 1.00 boot floppy.
- `m24-blank-306-4-17.chd`: blank 10 MB hard disk, with no installed OS.

Both configurations below passed boot regression testing on the MAME `sadie`
branch. Use working copies of the images. Run the commands from your MAME
build directory, with the M24 ROM set installed in its ROM search path.
Set the path to your copy of this disk-image repository:

```sh
export MAME_DISKS=/absolute/path/to/mame_disks
```

## Controller disabled

Boot the PCOS floppy with 640 KB RAM and remove the default hard disk
controller from ISA slot 1:

```sh
./mame m24 -bios v1.43 -ram 640k -isa1 "" \
  -flop1 "$MAME_DISKS/m24/pcos_m24.img" \
  -window -skip_gameinfo -nomouse
```

## Controller enabled with an empty disk

Keep the default controller and attach the blank CHD:

```sh
./mame m24 -bios v1.43 -ram 640k \
  -hard1 "$MAME_DISKS/m24/m24-blank-306-4-17.chd" \
  -flop1 "$MAME_DISKS/m24/pcos_m24.img" \
  -window -skip_gameinfo -nomouse
```

For a build containing only M20/M24 named `z8001reg`, replace `./mame` with
`./z8001reg`.

## Expected result

At `Select Alternate CPU (y/n)?`, answer `y` to select the Z8000 adapter.
Both configurations should reach the PCOS-M24 Rev. 1.00 `0>` command prompt.
The configuration screen reports 512 KB of PCOS memory with 640 KB configured.
With the blank disk attached, boot should pass stage `8` and load PCOS from
the floppy.

The tested controller code stalls at stage `8` if the controller is enabled
without a disk attached. Disabling the controller or attaching the blank
disk avoids that missing-drive error path.

The blank disk has 306 cylinders, 4 heads, 17 sectors per track, and 512-byte
sectors (10,653,696 bytes). Recreate it with:

```sh
./chdman createhd -o m24-blank-306-4-17.chd -chs 306,4,17 -ss 512
```
