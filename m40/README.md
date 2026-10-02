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

### What it needs

- MAME built from the `m40_z8010_sup_test` branch of
  [tpaxia/mame](https://github.com/tpaxia/mame), which has the Z8001 and
  keyboard-port fixes this system depends on.
- A ROM that can boot from the GO363. ROM 6.0 cannot. Use the experimental
  `m40rom-6.0-hd65` ROM built by `tools/mkrom_hd65.py` in the L1 M40 project
  (ROM 6.0 plus a GO363 boot routine; not an Olivetti release, not in MAME).
  Put it in its own folder as `roms-hd65\m40\m40rom-6.0.bin` and pass that
  folder with `-rompath`. MAME warns that the checksum does not match.
- The M40 control profile: copy [m40-ui.cfg](../BCOS/m40-ui.cfg) into MAME's
  `ctrlr` folder.

### Run BCOS from the hard disk

Work on a copy of the image: the system writes to the disk.

```bat
mame.exe m40 -window -ram 2m -uimodekey F12 -ctrlr m40-ui -rompath roms-hd65 -slot5 go363 -hard1 hard\m40\m40-bcos-hd-kusa.chd
```

1. Dismiss the MAME startup warning.
2. Check the status bar: it must show **HD**. If it shows **FLOPPY**, click it
   to select **HD**, then press F12, Shift+F3, F12 to restart.
3. Wait for the **B.C.O.S. II** banner and `PASSWORD :` (about three minutes
   of machine time).
4. Enter the password **A** (Shift+A), then **keypad Enter**.
5. At `DATE YYMMDD`, type the date with keypad digits (e.g. **860909**) and
   press **keypad Enter**.
6. At `TIME HHMMSS`, type the time with keypad digits (e.g. **120000**) and
   press **keypad Enter**.
7. Wait for **/SYS**.

**F12** toggles the MAME UI controls. Keep them off while typing to BCOS:
press F12 before using Tab or other MAME keys, and F12 again afterwards.
**Alt+C** clears a keyboard error (`E` or `KE` at the bottom left).

## Images not included

- MDOSC 2.0, 3.1, and 3.2 load but stop or cycle on ERROR 172/173.
- BCOS II 5.0 reaches a system-environment page but no usable prompt.
- MOS `StarterST506.IMD` does not reach a console.
- BCOS companion, keyboard, and blank media are not independently bootable.

Detailed evidence and scripts are in
[tpaxia/l1_m40](https://github.com/tpaxia/l1_m40), particularly
`re/OS_boot_media_survey.md` and `BCOS_BOOT.md`.
