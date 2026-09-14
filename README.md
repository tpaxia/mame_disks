# MAME regression disk images

Ready-made disk images for testing systems in current MAME. See the linked
projects for build details, provenance, and fuller operating instructions.

## Olivetti M40 — BCOS: Windows instructions

This guide takes you through creating a BCOS system, booting it and opening
BASIC. To use the supplied system without creating a new one, go to
[Boot the supplied system](#boot-the-supplied-system).

### Before you start

Use a Windows build of the
[MAME `olivetti_m40` branch](https://github.com/tpaxia/mame/tree/olivetti_m40)
from commit `0cf819193f1` or later. The distribution should have the ROMs in
`roms` and these disks in `flop`:

| File | Use |
|---|---|
| `K02733_BCOS_II_3.3_CONFIGURATOR.imd` | Creates the system |
| `K02741_BCOS_II_3.3_JJKEYB.imd` | Supplies the keyboard files |
| `BCOS_LOAD.imd` | Boots the supplied system |
| `BCOS_RUN.imd` | Runs the supplied system and BASIC |

Use a PC keyboard with a numeric keypad. Open **Command Prompt** in the
folder containing `mame.exe`. If your executable is named `m40.exe`, use
that name instead of `mame.exe` in the commands below.

### Open the MAME menu

1. Press **Scroll Lock** to enable MAME's controls.
2. Press **Tab** to open the menu. Use the arrow keys and **main Enter**.
3. When finished, close the menu with **Tab**.
4. Press **Scroll Lock** again. Check that **UI controls disabled** appears
   before typing into BCOS.

Scroll Lock is the normal Windows UI-toggle key. **F12 is not the UI toggle**:
it takes a screenshot while MAME controls are enabled, and operates BCOS RUN
while they are disabled. See [MAME's keyboard controls](https://docs.mamedev.org/usingmame/defaultkeys.html).

### Set floppy boot and read the status bar

1. Open the MAME menu and select **Machine Configuration**.
2. Set **Console IPL Switch** to **ISL2 - Floppy Disk**.
3. Leave **Key switch 1, 2 and 3** at **Normal**.
4. Close the menu. With MAME controls still enabled, press **Shift+F3** to
   restart the machine. Do not reset while it is writing a disk.
5. Disable MAME controls with **Scroll Lock**.

The bar below the screen should show **FLOPPY** and **K1/K2/K3: NORMAL**.
To select hard-disk boot, use **ISL1 - Hard Disk** in the same menu; the bar
then shows **HD**. Use FLOPPY for this guide.

The four lamps are **READY, L1, L2 and SHIFT**. BCOS controls them; READY
does not have to stay lit. **L2 lights when TEST mode is enabled.** Change
switches through the menu, not by clicking the status bar.

### Load or change a floppy

**flop1 is BCOS FD1; flop2 is BCOS FD2.**

1. Open **Tab → File Manager** and select the drive.
2. To load a disk, select its image file. Choose **Read-write** for a working
   disk if asked.
3. To change disks, first select the empty-slot/unload entry to eject it.
4. Close the menu, disable MAME controls and let the machine run for at least
   **two seconds with the drive empty**.
5. Return to File Manager and load the replacement in the same drive.
6. Close the menu, disable MAME controls and wait about **three seconds**
   before answering the BCOS prompt.

Always eject before loading the replacement. Waiting in a paused menu does
not count as the empty-drive interval.

### Keys to use in BCOS

Use the normal QWERTY letter positions on your PC. **Main Enter and keypad
Enter are different keys.**

| PC key | Use in BCOS |
|---|---|
| **Keypad digits** | Dates, menu numbers and the digit in FD2 |
| **Keypad Enter** | Submit fields and commands |
| **Main Enter** | Acknowledge `AFTER ANY KEY : GO` and `Press S bar` |
| **Shift + letter** | Uppercase answers and password |
| **Keypad `*`** | Clear the keyboard error marked E or KE |
| **F12** | RUN/retry; acknowledge the generator's `ERROR` message |
| **Left Ctrl + F12** | Toggle TEST at `/SYS`; check L2 |
| **Left / Right arrows** | Move within an input field |

Do not use Caps Lock for uppercase, right Ctrl for CONTROL, or keypad `+`
as an arithmetic plus. These keys have other functions on the emulated
keyboard. Do not assume Backspace edits numeric fields like a Windows text box.

The original keyboards have different labels. In the ANK1402 photograph,
the red **CLEAR** key corresponds to PC **keypad `*`**. In the ANK1426
photograph, that position is labelled `*`. The ANK1426 key labelled **RES**
is PC right Ctrl; it is not the error-clear key used here. The original
**F8/F16** key is mapped to PC **F12**. The separate ANK1426 **RUN** key is
not the RUN function used by BCOS in this guide.

<details>
<summary>Original keyboard photographs</summary>

ANK1426 — QWERTY, with BASIC-labelled keys:

![ANK1426](BCOS/BCOS_GUIDE_IMAGES/ANK1426.jpg)

ANK1402 — use this to identify the controls, not to rearrange your PC letters:

![ANK1402](BCOS/BCOS_GUIDE_IMAGES/ANK1402.jpeg)

</details>

### 1. Prepare working disks

Run these commands once. Use a new folder name if `work\bcos` already contains
a system you want to keep.

```bat
mkdir work\bcos
copy "flop\K02733_BCOS_II_3.3_CONFIGURATOR.imd" "work\bcos\CONFIG.imd"
copy "flop\K02741_BCOS_II_3.3_JJKEYB.imd" "work\bcos\KEYBOARD.imd"
copy "flop\K02741_BCOS_II_3.3_JJKEYB.imd" "work\bcos\LOAD.imd"
copy "flop\K02741_BCOS_II_3.3_JJKEYB.imd" "work\bcos\RUN.imd"
attrib -R "work\bcos\*.imd"
```

LOAD and RUN start as copies of a formatted disk. The configurator will
replace their contents. Keep the originals in `flop` unchanged.

### 2. Start the configurator

Enter this command on one line:

```bat
mame.exe m40 -window -ramsize 2048K -flop1 "work\bcos\CONFIG.imd" -flop2 "work\bcos\KEYBOARD.imd"
```

1. Acknowledge any MAME startup warning.
2. Set **FLOPPY** boot as described above. Disable MAME controls.
3. Wait for **DATE YYMMDD**. Startup can take about 90 seconds.
4. Type **860909** on the numeric keypad and press **keypad Enter**.
5. At **SYS**, type **sys** and press **keypad Enter**.
6. At Continue/Exit, type uppercase **C** and press **keypad Enter**.

### 3. Choose the system and keyboard

1. At **SYSTEM ENVIRONMENT CHOICE**, set **COMPLETE SYSTEM = Y**. If
   **RUN-TIME ONLY WITH DEBUGGER** remains editable, set it to **N**.
2. Set the password to **SPAM**, using Shift for the uppercase letters.
3. Submit fields with **keypad Enter** and select **C** to continue.
4. If asked for the system/storage type, select **M40, floppy-only / mono FDU**.
5. Include **BASIC** and its editor/program-preparation support. Keep the
   other default options unless you need a different configuration.
6. At the national keyboard list, select **13 — USA-ASCII** using keypad digits.
7. When asked for the drive containing the keyboard files, enter **FD2** and
   press keypad Enter. Use Shift for F and D, then release Shift for keypad2.
   If the cursor starts one space into the field, press **Left once first**.
8. Confirm the displayed volume when requested. Wait for **Firmware file copied**.
9. At **Press S bar**, press **main Enter**, not Space.

### 4. Create LOAD and RUN

Keep **CONFIG in FD1** throughout generation.

1. When told to dismount the keyboard disk, eject **KEYBOARD from FD2**.
2. Follow the disk-change procedure above and load **work\bcos\LOAD.imd** in FD2.
3. For the first output disk, enter **DRIVE NAME: FD2**, **VOLUME CODE: LOAD**
   and **OWNER: TP**. Confirm and wait for writing and verification to finish.
4. When asked for the RUN-TIME output disk, eject LOAD and load the separate
   **work\bcos\RUN.imd** in FD2, using the same disk-change procedure.
5. Enter **DRIVE NAME: FD2**, **VOLUME CODE: RUN** and **OWNER: TP**.
6. Wait for generation to finish, then use the displayed Exit option.
7. Enable MAME controls and exit MAME.

You now have two different disks. **Generate both—do not make RUN by copying
the completed LOAD disk.** The names LOAD and RUN entered in BCOS are the
volume labels; renaming an image file in Windows does not change its label.

### 5. Boot the new system

```bat
mame.exe m40 -window -ramsize 2048K -flop1 "work\bcos\LOAD.imd"
```

1. Check that the status bar shows **FLOPPY**. Disable MAME controls.
2. Wait for **DISMOUNT LOAD-TIME DISK / MOUNT RUN-TIME DISK**.
3. Eject **LOAD from FD1**, run with the drive empty for at least two seconds,
   then mount **work\bcos\RUN.imd in FD1**. Wait about three seconds.
4. At **AFTER ANY KEY : GO**, press **main Enter**.
5. Enter **SPAM** in uppercase and press **keypad Enter**.
6. Enter **860909** using keypad digits and press **keypad Enter**.
7. Wait for **/SYS**. Leave RUN mounted in FD1.

### 6. Open BASIC

1. At **/SYS**, make sure MAME controls are disabled.
2. Hold **left Ctrl**, tap **F12**, then release Ctrl.
3. Check that **L2 lights**. If it is already lit, do not repeat the chord.
4. Type **basic** and press **keypad Enter**.
5. The screen should show **EDIT**.

**This is the currently tested endpoint.** Entering and running a BASIC
program still needs a verified procedure; instructions for that step will be
added when it works. The Windows version of this walkthrough also awaits testing.

### Boot the supplied system

To skip configuration, copy the supplied LOAD/RUN pair:

```bat
mkdir work\ready
copy "flop\BCOS_LOAD.imd" "work\ready\LOAD.imd"
copy "flop\BCOS_RUN.imd" "work\ready\RUN.imd"
attrib -R "work\ready\*.imd"
mame.exe m40 -window -ramsize 2048K -flop1 "work\ready\LOAD.imd"
```

Follow **5. Boot the new system**, using `work\ready\RUN.imd` for the swap.
The supplied password is **SPAM**. Then follow **6. Open BASIC**.

### If something goes wrong

| Problem | What to do |
|---|---|
| Tab does not open the menu | Press Scroll Lock to enable MAME controls, then Tab |
| E or KE appears at the bottom left | Press keypad `*` once |
| The generator shows ERROR after lowercase c | Clear KE if present, press F12, then enter uppercase C and keypad Enter |
| BASIC reports SYS ERR.163 | Clear the error with keypad `*`; enable TEST with left Ctrl+F12 and check L2 |
| SYS ERR.006 appears after swapping LOAD for RUN | Restart the boot and use the eject/wait/load procedure |

## Zilog System 8000 — ZEUS 3.2.1

Image: `s8000_smd.chd`. Background and build details are in
[tpaxia/Zilog_S8000](https://github.com/tpaxia/Zilog_S8000).

```sh
mame s8000 -hard1 /path/to/mame_disks/s8000_smd.chd
```

For `s8000`, enable **Support Segmented OS** in Machine Configuration and
restart the machine. Press numeric-keypad `+` for the front-panel **START**
button. The same image can also be run on the Series Two CPU:

```sh
mame s8000s2 -hard1 /path/to/mame_disks/s8000_smd.chd
```

Press numeric-keypad `+` to start it. Do not open the image in both machines at
the same time.

## Olivetti M20 — CP/M-8000

Image: `m20-cpm8000.chd`. Background and build details are in
[tpaxia/CPM8000](https://github.com/tpaxia/CPM8000).

Boot with the CP/M-8000 `REL11A.IMG` floppy:

```sh
mame m20 \
  -hard1 /path/to/mame_disks/m20-cpm8000.chd \
  -bios 2 -ramsize 512k \
  -flop1 /path/to/flop/REL11A.IMG
```

Use working copies of the images if you want to keep these originals pristine.

## Olivetti M40 — DCOS 8.4 diagnostics

The `m40_diagnostics` folder contains the nine bootable field-diagnostic disks:
`A.IMD` through `H.IMD`, plus the reduced `R.IMD` set. Background and operating
details are in [tpaxia/l1_m40](https://github.com/tpaxia/l1_m40).

For example, boot disk A with:

```sh
mame m40 -flop1 /path/to/mame_disks/m40_diagnostics/A.IMD
```
