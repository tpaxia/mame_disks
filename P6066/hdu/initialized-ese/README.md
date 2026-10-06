# P6066 hard disk (HDU) with ESE

<!-- copyright-holders: Salvatore Paxia -->

Commands are for a Windows command prompt opened in the MAME folder, with a
MAME build that includes the `p6066` driver and its ROM set in `roms`.

| File | What it is |
| --- | --- |
| `SYSDIS.chd` | Hard disk with ESE installed, ready to boot |
| `SYSBTS.imd` | Bootstrap floppy that belongs to `SYSDIS.chd` |
| `HDU2110-initialized.chd` | Formatted hard disk with no system on it |
| `inputs/master-068.imd` | System master floppy |
| `inputs/generator-064.imd` | Disk generator floppy |
| `inputs/hduutilities.imd` | HD utilities floppy with the HDI format program |

Copy the `.chd` files you need into MAME's `hard\p6066` folder and the `.imd`
files into `flop\p6066`, creating the folders if needed. The system writes to
every mounted disk, so keep the files here as the originals.

END OF LINE is the main **Enter** key; the other keys are on the
[US keyboard to P6066 mapping](../../keyboard/us-to-p6066-mapping.md).
**Continue** is a console button: click it with the mouse. **F9** toggles the
keyboard mode and **F12** toggles the MAME UI controls; keep the UI controls
off while typing.

## Boot ESE from the hard disk

Copy `SYSDIS.chd` to `hard\p6066` and `SYSBTS.imd` to `flop\p6066`.

```bat
mame p6066 -bus:dma rodma -bus:hdu difo -bus:console:goino:options pr6610 -hard1 hard\p6066\SYSDIS.chd -flop2 flop\p6066\SYSBTS.imd -uimodekey F12 -window
```

The bootstrap floppy is in FD2 and FD1 is empty. `ERROR154 ON UNIT FDU1` and
`ERROR173` appear because FD1 is empty; wait for `READY`, no key is needed.

Without `-bus:console:goino:options pr6610` each of the two errors stops and
needs a click on Continue.

## Install ESE on the formatted hard disk

This rebuilds `SYSDIS.chd` and `SYSBTS.imd` from the formatted disk and the two
original floppies. Copy and rename:

| From | To |
| --- | --- |
| `HDU2110-initialized.chd` | `hard\p6066\NEWSYS.chd` |
| `inputs\master-068.imd` | `flop\p6066\master.imd` |
| `inputs\generator-064.imd` | `flop\p6066\generator.imd` |

```bat
mame p6066 -bus:dma rodma -bus:hdu difo -bus:console:goino:options pr6610 -hard1 hard\p6066\NEWSYS.chd -flop1 flop\p6066\master.imd -flop2 flop\p6066\generator.imd -uimodekey F12 -window
```

The printer must be attached: the system master is configured to use it.

Stay in BASIC keyboard mode (KB MODE lamp off, the state after reset). In this
mode letters typed **without Shift** are uppercase, and Shift+letter enters a
BASIC keyword. `=` is Shift+minus and `*` is Shift+colon. End every line with
END OF LINE.

1. Wait for `READY`.
2. Type the following lines, waiting for the next prompt after each:

   ```
   EXE DKS,IN=FDU1
   HDU,A0,HD
   FDU,C0,FDU1
   FDU,C1,FDU2
   *
   TEST
   L
   ```

   The three device lines answer the `UNIT?` prompts and `*` ends the list.
   `TEST` answers `SYSTEM PASSWORD?` and becomes the system password. `L`
   answers `INIT HD?`.
3. At `DISK FOR SYSTEM ON HD`, click Continue.
4. At `LOAD DISK ON FDU1`, click Continue (the master is already in FD1).
5. Wait for the copy to finish. At `BOOTSTRAP?`, type **Y** (no Shift) and END
   OF LINE.
6. At `LOAD DISK FOR BTSTRAP ON FDU1`, click Continue. The master floppy is
   overwritten and becomes the bootstrap floppy.
7. Wait for `END OF GENERATION`, then exit MAME.

`hard\p6066\NEWSYS.chd` is now the installed hard disk and
`flop\p6066\master.imd` is its bootstrap floppy. Keep the pair together and
boot it with the command in the previous section, using these two file names.

## Format a hard disk with HDI

Only needed for a new, blank hard disk image; `HDU2110-initialized.chd` is the
result of this step. No blank image is included here. With a blank image as
`hard\p6066\HDU.chd`, copy `inputs\hduutilities.imd` to `flop\p6066`.

```bat
mame p6066 -bus:dma rodma -bus:hdu difo -hard1 hard\p6066\HDU.chd -flop2 flop\p6066\hduutilities.imd -uimodekey F12 -window
```

1. Wait for startup. At `ERROR154 ON UNIT USR` click Continue, and again at
   `ERROR173`.
2. Press **F9** for typewriter keyboard mode (KB MODE lamp on), so that
   Shift+letter types an uppercase letter.
3. Type `EXE HDI,A0` and click Continue. If it only returns `READY`, type it
   again and click Continue.
4. Answer the prompts:

   | Prompt | Type | Then |
   | --- | --- | --- |
   | `PU NAME` | `A0` | Continue |
   | `PATTERN` | `000000` | Continue |
   | `N. OF PASSES` | `1` | Continue |
   | `CHECK ONLY` | `1` | Continue |
   | `ERMAP NOT FOUND` | `I` | Continue |

5. Wait while it goes through cylinders 0 to 201 and returns to `READY`. Do
   not interrupt it. Exit MAME.

`hard\p6066\HDU.chd` is now formatted and can be used in place of
`HDU2110-initialized.chd` in the installation above.
