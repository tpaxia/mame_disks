# Olivetti M20 disk images

## CP/M-8000

Hard disk image with CP/M-8000 installed. Background and build details are in
[tpaxia/CPM8000](https://github.com/tpaxia/CPM8000).

Boot with the CP/M-8000 `REL11A.IMG` floppy:

```sh
mame m20 \
  -hard1 hard\m20\m20-cpm8000.chd \
  -bios 2 -ramsize 512k \
  -flop1 flop\m20\REL11A.IMG
```

Use working copies of the images if you want to keep these originals pristine.

## PCOS 4.0

- `pcos4.img` — PCOS 4.0 system floppy
- `pcos4_util.img` — PCOS 4.0 utilities floppy

## PCOS boot regression checks

These boot checks passed on the `sadie` branch at commit
`41d70eeb31f2ad86e7595703def2f31500b935df` on 2026-10-05.
Run them from `/Users/paxia/Projects/mame_latest/mame-sadie` using the executable
built from that worktree, rather than the separate MAME checkout:

```sh
make SUBTARGET=z8001reg SOURCES=src/mame/olivetti/m20.cpp,src/mame/olivetti/m24.cpp \
  OSD=sdl3 USE_LIBSDL=1 SDL_INSTALL_ROOT=/opt/homebrew REGENIE=1 -j6
```

The commands below use the ROM sets in the existing MAME checkout. With a full
MAME build from the branch under test, replace `./z8001reg` with `mame`.
Use disposable copies of the disk images for regression runs.

### M20: PCOS hard disk boot

Boot the PCOS hard disk with 512 KB RAM and no floppy attached:

```sh
./z8001reg m20 -bios 2 -ram 512k \
  -hard1 "$HOME/Projects/mame_disks/m20/m20_pcos.chd" \
  -rompath "$HOME/Projects/mame_latest/mame/roms" \
  -window -skip_gameinfo -nomouse
```

At `Select Alternate CPU (y/n)?`, answer `n` to retain the Z8001 CPU.
Check that PCOS-8000 4.1a reaches its `10>` prompt without a memory error.

### M24: PCOS floppy boot, controller disabled

The M24 fixtures are in the sibling [`m24`](../m24/) folder.
Boot with 640 KB RAM and remove the default ISA hard disk controller:

```sh
./z8001reg m24 -bios v1.43 -ram 640k -isa1 "" \
  -flop1 "$HOME/Projects/mame_disks/m24/pcos_m24.img" \
  -rompath "$HOME/Projects/mame_latest/mame/roms" \
  -window -skip_gameinfo -nomouse
```

At `Select Alternate CPU (y/n)?`, answer `y` to use the Z8000 adapter.
Check that PCOS-M24 Rev. 1.00 reaches the `0>` prompt; its configuration screen
reports 512 KB of PCOS memory with the machine configured for 640 KB.

### M24: PCOS floppy boot, controller and empty disk attached

Keep the default ISA hard disk controller enabled and attach the blank CHD:

```sh
./z8001reg m24 -bios v1.43 -ram 640k \
  -hard1 "$HOME/Projects/mame_disks/m24/m24-blank-306-4-17.chd" \
  -flop1 "$HOME/Projects/mame_disks/m24/pcos_m24.img" \
  -rompath "$HOME/Projects/mame_latest/mame/roms" \
  -window -skip_gameinfo -nomouse
```

Answer `y` at the alternate CPU prompt. Check that boot passes stage `8` and
reaches the same PCOS-M24 `0>` prompt from the floppy. This configuration passed on the `sadie` branch with the unmodified controller code.
Leaving the controller enabled with no disk attached currently stalls at
stage `8`; the empty disk exercises a different path and boots successfully.

The blank fixture has 306 cylinders, 4 heads, 17 sectors per track, and
512-byte sectors (10,653,696 bytes). It contains no installed operating system
and can be recreated with:

```sh
./chdman createhd -o m24-blank-306-4-17.chd -chs 306,4,17 -ss 512
```


### M20: CP/M-8000 boot on the same branch

```sh
./z8001reg m20 -bios 2 -ram 512k \
  -hard1 "$HOME/Projects/mame_disks/m20/m20-cpm8000.chd" \
  -flop1 "$HOME/Projects/mame_disks/m20/REL11A.IMG" \
  -rompath "$HOME/Projects/mame_latest/mame/roms" \
  -window -skip_gameinfo -nomouse
```

Answer `n` at the alternate CPU prompt. Check that CP/M-8000 Version 1.1
reaches `A>`. This boot check also passed on the commit above.

All four checks ran for 120 emulated seconds. They verify boot and the final
command prompt; they do not constitute a complete OS or disk read/write test.
