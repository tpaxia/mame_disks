# Olivetti M40 — BCOS: system generation

This guide walks through creating a BCOS II 3.3 system from the configurator
disk. The generated LOAD and RUN pair is what you boot thereafter. See
[Windows quick start](BCOS_WINDOWS_BASIC.md) for booting and opening BASIC.

## Files

| File | Use |
|---|---|
| `K02733_BCOS_II_3.3_CONFIGURATOR.imd` | Creates the system |
| `K02741_BCOS_II_3.3_JJKEYB.imd` | Supplies the keyboard files |

Download any missing images from the [BCOS folder](./) in this repository.

## 1. Prepare working disks

```bat
mkdir work\bcos
copy flop\K02733_BCOS_II_3.3_CONFIGURATOR.imd work\bcos\CONFIG.imd
copy flop\K02741_BCOS_II_3.3_JJKEYB.imd work\bcos\KEYBOARD.imd
copy flop\K02741_BCOS_II_3.3_JJKEYB.imd work\bcos\LOAD.imd
copy flop\K02741_BCOS_II_3.3_JJKEYB.imd work\bcos\RUN.imd
attrib -R work\bcos\*.imd
```

LOAD and RUN start as copies of a formatted disk. The configurator replaces
their contents. Keep the originals in `flop` unchanged.

## 2. Start the configurator

```bat
mame.exe m40 -window -ramsize 2048K -uimodekey F12 -ctrlr m40-ui -flop1 work\bcos\CONFIG.imd -flop2 work\bcos\KEYBOARD.imd
```

1. Dismiss any MAME startup warning.
2. Check the status bar. If it shows **HD**, click it to select **FLOPPY**
   and restart (F12, Shift+F3, F12).
3. Wait for **DATE YYMMDD** (about 90 seconds).
4. Type **860909** on the numeric keypad and press **keypad Enter**.
5. At **SYS**, type **sys** and press **keypad Enter**.
6. At Continue/Exit, type uppercase **C** and press **keypad Enter**.

## 3. Choose system and keyboard

1. At **SYSTEM ENVIRONMENT CHOICE**, set **COMPLETE SYSTEM = Y**. If
   **RUN-TIME ONLY WITH DEBUGGER** remains editable, set it to **N**.
2. Choose a password and write it down. Use **Shift** for uppercase letters.
3. Submit fields with **keypad Enter** and select **C** to continue.
4. If asked for system/storage type, select **M40, floppy-only / mono FDU**.
5. On the software options screens, select **all available options** for the
   complete system, not just BASIC.
6. Confirm your choices. When asked for the drive containing the keyboard
   files, enter **FD2** and press **keypad Enter**. The launch command already
   mounted the keyboard floppy in FD2.
7. Confirm the displayed volume when requested.
8. At the national keyboard list, select **13 — USA-ASCII** using keypad
   digits and press **keypad Enter**. Wait for **Firmware file copied**.
9. At **Press S bar**, press **main Enter**.

## 4. Create LOAD and RUN

Keep CONFIG in FD1 throughout generation.

1. When told to dismount the keyboard disk, eject KEYBOARD from FD2.
2. Follow the disk-change procedure: eject, wait two seconds with the drive
   empty, then load `work\bcos\LOAD.imd` in FD2. Wait three seconds.
3. For the first output disk, enter **DRIVE NAME: FD2**, **VOLUME CODE: LOAD**
   and **OWNER: TP**. Confirm and wait for writing and verification.
4. When asked for the RUN-TIME output disk, eject LOAD and load
   `work\bcos\RUN.imd` in FD2 using the same disk-change procedure.
5. Enter **DRIVE NAME: FD2**, **VOLUME CODE: RUN** and **OWNER: TP**.
6. Wait for generation to finish, then use the displayed Exit option.
7. Close the MAME window after disk writing finishes.

**Generate both disks. Do not make RUN by copying the completed LOAD disk.**
The names LOAD and RUN are BCOS volume labels; renaming the image file does
not change its label.

## 5. Boot the new system

Proceed to [Windows quick start](BCOS_WINDOWS_BASIC.md), using
`work\bcos\LOAD.imd` and `work\bcos\RUN.imd` as your LOAD/RUN pair.

## Troubleshooting

| Problem | Fix |
|---|---|
| E or KE at bottom left | Press Alt+C |
| Generator shows ERROR after lowercase c | Clear KE, press F8, enter uppercase C |
| SYS ERR.006 after disk swap | Eject, wait two seconds empty, load, wait three seconds |