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