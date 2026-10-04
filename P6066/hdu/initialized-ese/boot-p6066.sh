#!/bin/sh
# copyright-holders: Salvatore Paxia
set -eu
media_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
project_dir=${P6066_PROJECT:-"$HOME/Projects/P6066"}
boot_dir=$(mktemp -d "$media_dir/boot-run.XXXXXX")
cp "$media_dir/SYSDIS.chd" "$boot_dir/SYSDIS.chd"
cp "$media_dir/SYSBTS.imd" "$boot_dir/SYSBTS.imd"
printf 'Working media: %s\n' "$boot_dir"
cd "$boot_dir"
exec "$project_dir/mame/p6066" p6066 \
  -rompath "$project_dir/analysis/mame-p6066/roms" \
  -bus:dma rodma -bus:hdu difo -bus:console:goino:options pr6610 \
  -hard1 SYSDIS.chd -flop2 SYSBTS.imd \
  -cfg_directory cfg -nvram_directory nvram -window -skip_gameinfo "$@"
