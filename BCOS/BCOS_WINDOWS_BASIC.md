# Olivetti M40 — BCOS: Windows quick start

This guide assumes the BCOS disk images are already in your MAME `flop`
folder and the M40 ROM is installed. For system generation from scratch, see
[BCOS generation](BCOS_GENERATION.md).

## Keys

Use normal QWERTY positions. **Keypad Enter** submits fields and commands;
**main Enter** acknowledges prompts like `AFTER ANY KEY : GO`.

| PC key | Use |
|---|---|
| Keypad digits | Dates, menu numbers |
| Keypad Enter | Submit fields and commands |
| Main Enter | Acknowledge prompts |
| Shift + letter | Uppercase answers |
| Alt+C | Clear keyboard error (E or KE) |
| F12 | Toggle MAME UI controls |

See the [M40 ANK keyboard map](M40_KEYBOARD.md) and
[ESE keyboard overlay](M40_ESE_KEYBOARD.md) for the full mapping.

## Boot the system

```bat
mame.exe m40 -window -ram 2m -uimodekey F12 -ctrlr m40-ui -flop1 flop\m40\BCOS_LOAD.imd
```

1. Dismiss any MAME startup warning.
2. Check the status bar: if it shows **HD**, click it to select **FLOPPY**,
   then press F12, Shift+F3, F12 to restart.
3. Wait for **DISMOUNT LOAD-TIME DISK / MOUNT RUN-TIME DISK**.
4. Press **F12** once to enable the MAME UI controls, then **Tab** to open
   the MAME menu. Eject LOAD from FD1 and press **Tab** to close the menu.
   The emulator now runs with the drive empty; leave it for at least two
   seconds. Time spent inside the paused menu does not count.
5. The UI controls are still enabled, so press only **Tab** to re-open the
   menu, mount `flop\BCOS_RUN.imd` in FD1 and press **Tab** to close it.
   Wait about three seconds, then press **F12** to disable the UI controls
   before answering BCOS.
6. At **AFTER ANY KEY : GO**, press **main Enter**.
7. Enter the system password **SPAM** using **Shift** for the uppercase letters, then press **keypad Enter**.
8. Enter the date (e.g. **860909**) with keypad digits and **keypad Enter**.
9. Wait for **/SYS**.

## Open BASIC

1. Check **L2** on the status bar. If off, press **Ctrl+F8** to toggle TEST
   mode; L2 should light.
2. Type **basic** and press **keypad Enter**.
3. The screen shows **EDIT**.

## Troubleshooting

| Problem | Fix |
|---|---|
| Tab doesn't open menu | Press F12 first, then Tab |
| E or KE at bottom left | Press Alt+C |
| SYS ERR.163 | Clear with Alt+C, enable TEST with Ctrl+F8 |
| SYS ERR.006 after disk swap | Restart boot, use eject/wait/load procedure |