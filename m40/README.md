# Olivetti M40 bootable IMD media

These images reached a usable screen or prompt on the M40 in MAME. Run them
from disposable copies if the guest may write to the floppy.

## Operating systems and utilities

| Image | Verified result |
|---|---|
| `ESE.IMD` | ESE 3.1 boots to `READY` |
| `MDOS30.IMD` | German ESE/MDOS 3.0 boots to `READY` |
| `MDOSUTIL.IMD` | MDOS 3.1 utility system boots to `READY` |
| `BCOS_II_3.3_FD_ALL_RESIDENT.imd` | BCOS II 3.3 reaches its mono-user environment |
| `K02733_BCOS_II_3.3_CONFIGURATOR.imd` | BCOS II 3.3 reaches `DATE YYMMDD` and the SYS generator |
| `BCOS_LOAD.imd` | Generated BCOS load-time disk; first half of the verified generated-system boot |
| `BCOS_RUN.imd` | Generated BCOS run-time disk; second half of the verified generated-system boot |
| `Gardini_Utilities.imd` | Boots to the Gardini NLS3000 utility menu |

The `diagnostics` directory contains the boot-tested DCOS 8.4 diagnostic set:
`A.IMD` through `H.IMD`, plus `R.IMD`.

## Basic launch

Use ROM 6.0, 2 MB RAM, and the floppy IPL setting:

```sh
mame m40 -ram 2m -flop1 flop\m40\ESE.IMD
```

K02733 may require the BCOS FD1/controller-unit arrangement documented in the
L1 M40 project. The project launch scripts should be preferred for BCOS work.

## Generated BCOS LOAD/RUN boot

1. Boot `BCOS_LOAD.imd` with the console IPL switch set to floppy.
2. At `DISMOUNT LOAD-TIME DISK / MOUNT RUN-TIME DISK`, eject LOAD.
3. Let emulation run with the drive empty for at least two emulated seconds.
4. Insert `BCOS_RUN.imd` in the same drive.
5. Continue at `AFTER ANY KEY : GO`; the supplied system password is **SPAM** (uppercase), confirmed with keypad Enter.

The empty interval is required so the emulated floppy controller observes the
media change. Directly replacing LOAD with RUN can produce `SYS ERR.006`.

## BCOS II on the hard disk (WREN2, GO363)

`m40-bcos-hd-kusa.chd` is a 65 MB WREN2 image (1024 cylinders, 9 heads, 32
sectors of 256 bytes) holding the BCOS II multi-user system that the Olivetti
restore procedure installs (JX24, MX24, TOC£, DKC£ of data sets FF and 80).
The only change from that install is the keyboard map: the system was booted
and its configuration changed from `KITA` to `KUSA` with the OSLEM `COS#`
utility (`VARM KUSA` on the keyboard record), so a US keyboard types QWERTY.

It boots to `PASSWORD :` (password **A**, uppercase), then `DATE YYMMDD` and
`TIME HHMMSS` (keypad digits and keypad Enter), then `/SYS`.

Two things it needs that stock MAME does not have:

- The Z8001 and GO252 fixes on the `m40_z8010_sup_test` branch of
  [tpaxia/mame](https://github.com/tpaxia/mame) (PC-segment bit 15, keyboard
  port reset).
- A ROM that can boot from the GO363. ROM 6.0 cannot. The image was tested
  with the experimental `m40rom-6.0-hd65` ROM built by `tools/mkrom_hd65.py`
  in the L1 M40 project (ROM 6.0 plus a GO363 boot routine); that ROM is not
  an Olivetti release and is not in MAME.

```sh
mame m40 -ram 2m -slot5 go363 -hard1 hard\m40\m40-bcos-hd-kusa.chd
```

Set the console IPL switch to **ISL1 - Hard Disk**. Work on a copy: the
system writes to the disk.

## Images not included

- MDOSC 2.0, 3.1, and 3.2 load but stop or cycle on ERROR 172/173.
- BCOS II 5.0 reaches a system-environment page but no usable prompt.
- MOS `StarterST506.IMD` does not reach a console.
- BCOS companion, keyboard, and blank media are not independently bootable.

Detailed evidence and scripts are in
[tpaxia/l1_m40](https://github.com/tpaxia/l1_m40), particularly
`re/OS_boot_media_survey.md` and `BCOS_BOOT.md`.
