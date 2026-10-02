# M40 ESE keyboard overlay

<!-- copyright-holders: Salvatore Paxia -->

ESE meanings layered over the
[US keyboard to M40 ANK mapping](M40_KEYBOARD.md).

## Command keys

**HOLD ALT** is an instruction for the PC keyboard. Alt itself is not an M40
key and is not sent to ESE. **SHIFT** is the real M40 Shift modifier.

| ESE operation | PC keyboard |
|---|---|
| Toggle KB MODE | F9 |
| Clear a resettable error/input lock | Shift+Alt+C |
| CLEAR | Alt+C |
| Red CLEAR | Alt+F9 |
| RUN | Alt+R |
| LIST | Alt+L |
| OLD | Alt+O |
| SAVE / EXIT | Alt+S |
| AUTO# | Alt+A |
| DRAW | Alt+D |
| ERASE / HALT PGM | Alt+H or Pause |
| SKIP | Alt+K |
| FETCH | Insert |
| DEL LINE | Delete |
| Alpha Return | Main Enter |
| Numeric end of line | Keypad Enter |

Shift+Alt+C can clear a resettable displayed condition. It cannot make a
command valid when ESE reports ERROR 190 because the command is unavailable in
the current system state.

## KB MODE keywords

Press F9 once to enter KB MODE. While it is active, Shift plus a letter enters
the keyword shown below. Press F9 again to leave KB MODE.

| Key | Keyword | Key | Keyword |
|---|---|---|---|
| Shift+A | IF | Shift+N | NEXT |
| Shift+B | STEP | Shift+O | AND |
| Shift+C | FOR | Shift+P | OR |
| Shift+D | DEF | Shift+Q | REM |
| Shift+E | DISP | Shift+R | PRINT |
| Shift+F | FN | Shift+S | THEN |
| Shift+G | CALL | Shift+T | USING |
| Shift+H | ON | Shift+U | READ |
| Shift+I | WRITE: | Shift+V | TO |
| Shift+J | GOTO | Shift+W | FKEY# |
| Shift+K | GOSUB | Shift+X | STOP |
| Shift+L | RETURN | Shift+Y | INPUT |
| Shift+M | END | Shift+Z | DATA |

The complete keyword table was verified on the current M40 ESE 3.1 image using
the normal MAME keyboard path.

## MAME UI

F12 opens and closes the MAME UI. Keep the UI closed while typing into ESE.