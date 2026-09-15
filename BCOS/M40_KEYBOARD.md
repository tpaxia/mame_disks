# M40 keyboard on a US/ANSI PC keyboard

This map requires MAME's `olivetti_m40` branch at commit **a421751bf44** or
later. Older builds use different bindings.

## MAME controls

Use **F12** for MAME on both Windows and macOS. Copy [m40-ui.cfg](m40-ui.cfg)
to MAME's `ctrlr` directory and add `-uimodekey F12 -ctrlr m40-ui` to your
launch command. The profile removes the F12 screenshot conflict.
F12 alone enables MAME controls; Tab opens the menu. Close the menu, then
press F12 again to disable MAME controls before typing into the M40.
Neither F12 nor Scroll Lock sends an M40 key.

If custom input settings override these bindings, correct the affected entries
in MAME's Input Settings. Do not erase unrelated settings. On macOS, system
shortcuts can intercept combinations such as Ctrl+F8 before MAME receives them.

## How modifiers work

- Both Shift keys send M40 SHIFT; both Ctrl keys send M40 CONTROL.
- Caps Lock sends M40 LOCK. Use Shift for uppercase BCOS answers.
- Either Alt key selects an extra M40 key; Alt itself is not sent to the M40.
- For **Shift+LIST**, hold Shift and Alt, tap L, then release them.
  Ctrl+Alt+L similarly sends CONTROL+LIST. Shift+Ctrl+Alt+L sends both modifiers.
- Hold Alt before pressing the target key. Unlisted Alt combinations send no
  ordinary key; Shift and Ctrl still pass through.

These are physical key mappings, not text macros. BCOS's national keyboard
file determines characters and functions. A keycap saying LIST or RUN does not
guarantee that every program assigns that function to it.

## Everyday keys

| PC key | M40 key / position | Hex code |
|---|---|---|
| Letters | Same QWERTY letter | See diagnostic rows below |
| Main digits | Alphanumeric row, not keypad digits | See diagnostic rows below |
| Main Enter | RETURN / S bar | 35 |
| Keypad Enter | ENTER, submit BCOS fields | 61 |
| Backspace | BS | 31 |
| Tab | Alpha TAB | 05 |
| Space | SPACE | 12 |
| Left / Right | Left / Right | 4A / 3E |
| Up / Down | Up / Down | 4E / 3C |
| Insert | IC/IL / FETCH | 5C |
| Delete | DC/DL / DEL LINE | 3B |
| Home | HOME / PR ALL–NO PR | 3F |
| End | END / RES | 51 |
| Page Up | Back-tab | 4C |
| Page Down | Forward-tab | 3A |
| Alt+H (or Pause where available) | HALT PGM / ERASE | 48 |
| Escape | Top-right EXIT / F17–F18 position | 39 |
| Caps Lock | LOCK, press/release | 6F / 77 |
| Either Shift | SHIFT, press/release | 6E / 76 |
| Either Ctrl | CONTROL, press/release | 70 / 78 |

## Function keys

| PC key | M40 key / position | Hex code |
|---|---|---|
| F1 | F1/F9 | 44 |
| F2 | F2/F10 | 46 |
| F3 | F3/F11 | 63 |
| F4 | F4/F12 | 5B |
| F5 | F5/F13 | 53 |
| F6 | F6/F14 | 4B |
| F7 | F7/F15 | 56 |
| F8 | F8/F16; BCOS RUN/retry | 5A |
| F9 | Alpha CLEAR position | 37 |
| F11 | Additional KB MODE matrix position; not LOCK | 02 |

F10 and F12 have no M40 binding; F12 is reserved for MAME's UI. Windows/Menu, Print Screen and Num Lock
also have no M40 binding. MAME can use function keys for its own shortcuts
while UI controls are enabled.

## Alt layer

| PC combination | M40 key / position | Hex code |
|---|---|---|
| Alt+L | LIST / F19–F20 | 54 |
| Alt+S | SAVE / EXIT | 3D |
| Alt+O | OLD / S4 | 66 |
| Alt+R | RUN / S5 | 64 |
| Alt+D | DRAW / H.COPY | 40 |
| Alt+A | AUTO# / S3 | 5E |
| Alt+K | SKIP bar | 52 |
| Alt+C | Red CLEAR / keypad `*` position; clears BCOS E/KE | 49 |
| Alt+H | HALT PGM / ERASE | 48 |
| Alt+Backspace | Alpha ESC / DEL position | 06 |
| Alt+keypad minus | Keypad comma / minus position | 59 |
| Alt+keypad 0 | 00 | 68 |
| Alt+keypad decimal | 000 | 65 |

**BCOS TEST is Ctrl+F8, not Ctrl+Alt+R.** Check the L2 lamp.
**BCOS error clear is Alt+C, not keypad `*`, F9 or End.**

## Numeric keypad

| PC keypad keys, in order | Hex codes, in the same order |
|---|---|
| 7, 8, 9 | 4F, 50, 4D |
| 4, 5, 6 | 57, 58, 55 |
| 1, 2, 3 | 5F, 60, 5D |
| 0, decimal, Enter | 67, 62, 61 |
| divide, multiply, minus, plus | 42, 43, 41, 47 |

Use these digits for BCOS dates and menu numbers. The main number row is
a separate group of M40 keys.

## Punctuation positions

The labels below identify the emulated positions, not guaranteed output in
every national keyboard file. In particular, shifted digits need not match
US Windows punctuation.

| PC key | M40 position label | Hex code |
|---|---|---|
| Minus | `- =` | 2C |
| Equals | `~ ^` | 2B |
| Backtick | `@ '` | 2A |
| Left bracket | `[ {` | 36 |
| Right bracket | `] }` | 38 |
| Semicolon | `; +` | 2F |
| Apostrophe | `* :` | 34 |
| Backslash | Left-of-Z backslash position | 0A |
| Comma | Comma | 23 |
| Period | Period | 2D |
| Slash | Question-mark position | 29 |

## Original keyboards

Legends differ between variants. Use the photographs to identify positions;
do not rearrange your PC letter keys into QZERTY.

![ANK1426 QWERTY keyboard](BCOS_GUIDE_IMAGES/ANK1426.jpg)

![ANK1402 keyboard](BCOS_GUIDE_IMAGES/ANK1402.jpeg)

## Test with KEYTE1

Copy diagnostic disk [B.IMD](../m40_diagnostics/B.IMD) to your MAME `flop`
folder. Start it with:

```bat
mame.exe m40 -window -ramsize 2048K -uimodekey F12 -ctrlr m40-ui -flop1 "flop\B.IMD"
```

1. Dismiss MAME's startup warning. Check **FLOPPY** on the status bar;
   if you change it, restart the emulated machine.
2. At **HIT ENTER**, press **keypad Enter**.
3. Choose **keypad 1**, then **keypad Enter**.
4. Enter program **013** with keypad digits, then **keypad Enter**.
5. At the keyboard jumper/national-table screen, press **keypad Enter**.
6. At **KEYBOARD LAYOUT SELECT**, choose **keypad 0**, then **keypad Enter**
   (default 105-key layout including three key switches).

### TEST 1 — alphanumeric keys

First operate each status-bar switch K1, K2 and K3: select **Right**, check
that the diagnostic reports RIGHT, then select **Normal** and check NORMAL.
The initial `??????` fields are not a request to type question marks.

Follow the flashing key, left to right and top to bottom. Tap and release
each key separately. Names below mean PC keys; **main** means not the keypad.

```text
Row 1: Alt+Backspace, main 1 2 3 4 5 6 7 8 9 0, minus, equals, Backspace
Row 2: Tab, Q W E R T Y U I O P, backtick, left bracket, F9
Row 3: Caps Lock, A S D F G H J K L, semicolon, apostrophe, right bracket
Row 4: left Shift, backslash, Z X C V B N M, comma, period, slash,
       right Shift, main Enter
Row 5: Ctrl, Space, RP (see limitation below)
```

For cross-checking the displayed codes:

```text
Row 1: 06 01 04 07 17 1D 1E 13 21 24 2E 2C 2B 31
Row 2: 05 03 0C 08 1F 11 14 19 25 26 30 2A 36 37
Row 3: 77 09 0F 0D 18 15 1B 1A 28 22 2F 34 38
Row 4: 76 0A 0B 0E 10 20 1C 16 27 23 2D 29 76 35
Row 5: 78 12 RP
```

LOCK, SHIFT and CONTROL checks include releasing the key. Do not hold Shift
while typing an entire test row. Press the double-height main Enter only
when the fourth row requests it.

### TEST 2 — function and numeric keys

When TEST 2 is displayed, use these rows. **KP** means numeric keypad.
Press the tall SKIP and ENTER bars again on each row where they appear.

```text
Row 1: F1 F2 F3 F4 F5 F6 F7 F8, Escape
Row 2: KP divide, KP multiply, KP minus, KP plus, Alt+H,
       Alt+S, Alt+L, Insert, Delete
Row 3: Alt+C, KP 7 8 9, Alt+K, End, Page Up, Page Down
Row 4: Alt+KP minus, KP 4 5 6, Alt+K, Alt+A, Up, Down
Row 5: KP decimal, KP 1 2 3, KP Enter, Alt+O, Left, Right
Row 6: KP 0, Alt+KP 0, Alt+KP decimal, KP Enter, Alt+R, Alt+D, Home
```

```text
Row 1: 44 46 63 5B 53 4B 56 5A 39
Row 2: 42 43 41 47 48 3D 54 5C 3B
Row 3: 49 4F 50 4D 52 51 4C 3A
Row 4: 59 57 58 55 52 5E 4E 3C
Row 5: 62 5F 60 5D 61 66 4A 3E
Row 6: 67 68 65 61 64 40 3F
```

If the diagnostic reports **RECEIVED: XX — HIT ENTER TO RETRY**, press
**keypad Enter** and retry the requested key. The manual also describes
using SKIP (**Alt+K**) after Enter to continue with the remaining keys.

### TEST 3 — modifiers and lamps

When TEST 3 is displayed, check READY, L1, L2 and SHIFT turning on and off.
Press and release each modifier at least four times:

| PC key | Press / release codes |
|---|---|
| Caps Lock | 6F / 77 |
| Shift (test each side separately) | 6E / 76 |
| Ctrl (test each side separately) | 70 / 78 |

The documented TEST 3 exit sequence is **F1, Escape, Home**, pressed
separately (44, 39, 3F).

### Current limits

The physical **RP/REPEAT** key is not yet implemented. The diagnostic's
simultaneous-ordinary-key **FE** rollover check is also not implemented.
Do not expect a complete keyboard diagnostic pass yet. The sequences above
cover the mapped keys; advancing through every test, including TEST 4's
shifted-character checks, has not been verified end to end on this build.

The current automated check passes 210 logical-input cases, including the
Alt layer and modifier combinations. It does not replace this physical
PC keyboard test.

In the interactive test on macOS, the user completed the alphanumeric and
right-hand key sequences and reported that only **Pause (48)** did not work.
The subsequent host-input check received A but no events for physical Scroll
Lock or Pause on that Mac setup. Use F12 for UI and Alt+H for code 48.
This does not establish a full REPEAT,
rollover, modifier or LED diagnostic pass.
