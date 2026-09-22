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
5. Continue at `AFTER ANY KEY : GO`.

The empty interval is required so the emulated floppy controller observes the
media change. Directly replacing LOAD with RUN can produce `SYS ERR.006`.

## Images not included

- MDOSC 2.0, 3.1, and 3.2 load but stop or cycle on ERROR 172/173.
- BCOS II 5.0 reaches a system-environment page but no usable prompt.
- MOS `StarterST506.IMD` does not reach a console.
- BCOS companion, keyboard, and blank media are not independently bootable.

Detailed evidence and scripts are in
[tpaxia/l1_m40](https://github.com/tpaxia/l1_m40), particularly
`re/OS_boot_media_survey.md` and `BCOS_BOOT.md`.
