# US keyboard to P6066 keyboard mapping

<!-- copyright-holders: Salvatore Paxia -->

Agreed host-key mapping for the P6066 emulator. The keyboard device and host
bindings are now implemented; Shift+Insert recovery and character input have
been verified through the original ESE interrupt path.

Reference: [P6066 keyboard diagram](p6066-keyboard.png), Figure 1-3 in
P6066 Manuale Generale, printed page 1-5 (PDF page 19).
Host reference: [US 101-key layout](keyboard-101-us.svg).

Mappings select physical P6066 keys, not matching output characters. Shifted
legends and BASIC keywords may differ from those on the host keyboard.

## Alphanumeric section and main End of Line

| US host key | P6066 key |
|---|---|
| Letters A–Z | Corresponding letters, 1–1 |
| Main-row digits 0–9 | Corresponding main-row digits, 1–1 |
| Space | Space |
| Control | CONTROL |
| Left Shift | Left SHIFT |
| Right Shift | Right SHIFT |
| Backspace | DEL |
| Windows / Command | REPEAT |
| F9 | KB MODE |
| Main Enter | Main END OF LINE |
| `,` | Alphanumeric `,` / `<` |
| `.` | Alphanumeric `.` / `>` |
| `-` | Alphanumeric `-` / `=` |
| `=` | `@` key |
| `;` | `;` / `+` |
| Apostrophe (`'`) | `:` / `*` |
| `[` | `[` / `{` |
| `]` | `]` / `}` |
| Backslash | Backslash / vertical-bar key left of Z |
| Backtick | Up-arrow character key immediately right of `-` |
| `/` | `/` / `?` |
| Esc | Restart machine (updated assignment) |

The up-arrow **character** key is distinct from the direction Up key and the
numeric keypad up-arrow/E key. US `=` maps only to `@`; backtick maps to the
up-arrow character key. These are the final assignments after clarification.

## Direction and editing keys

| US host key | P6066 key |
|---|---|
| Left arrow | Direction left |
| Right arrow | Direction right |
| Up arrow | Direction up |
| Down arrow | Direction down |
| Delete | CHAR DELETE |
| Insert | CLEAR / RECALL |
| Page Down | RESULT |
| Page Up | SUM |

## Numeric keypad

| US host key | P6066 key |
|---|---|
| Numeric keypad digits 0–9 | Corresponding numeric keypad digits, 1–1 |
| Keypad decimal point | Numeric keypad `.` |
| Keypad `+` | Numeric keypad `+` |
| Keypad `-` | Numeric keypad `-` |
| Keypad `*` | Numeric keypad `*` |
| Keypad `/` | Numeric keypad `/` |
| Keypad Enter | Numeric keypad END OF LINE |

## Alt (chord prefix) combinations

Alt is a dedicated chord-prefix key, independent of Windows/Command's
REPEAT — Alt has no standalone P6066 function of its own; it only unlocks
the combinations below. Press it before the other key. The following
combinations suppress the unmodified host-key action, emitting only the
mapped P6066 key. A key already delivered before the prefix was pressed
cannot be retroactively withdrawn. Chords do not repeat.

| US combination | P6066 key |
|---|---|
| Alt + Home | OLD / LIST |
| Alt + Delete | DELETE LINE / RUN |
| Alt + Insert | FETCH / NEW |
| Alt + End | SAVE / AUTO# |
| Alt + main-keyboard `.` | Numeric keypad `,` |
| Alt + Left arrow | Numeric keypad `(` |
| Alt + Right arrow | Numeric keypad `)` |
| Alt + Down arrow | Numeric keypad `=` |
| Alt + Up arrow | Numeric keypad up-arrow / E key |

These slash-separated legends identify single physical P6066 keys; they do
not assign separate host combinations to the alternate legends.

## Function keys

US F1–F8 map to P6066 F1–F8, respectively. The diagram labels those physical
keys with F9–F16 as alternate legends (reached on the real keyboard via
Shift+F1–F8, not modeled here). Host F9 is repurposed as the KB MODE toggle
(see above); no other host F9–F16 bindings have been agreed.

## Unassigned host keys and integration work

- Unmodified Home and End.
- Num Lock, Caps Lock, and host F10–F11.
- Print Screen, Scroll Lock, and Pause/Break.
- Alt alone (it has no standalone function — only the chord combinations
  above).
- Left/right variants of Alt, Control and Windows/Command have not been
  separately specified. Both Shift keys are explicitly mapped above.

Do not infer additional mappings for unassigned keys. The agreed alphanumeric
section, editing keys, numeric keypad, command keys and F1–F8 are covered.

Console buttons are mouse-operated; their old keypad bindings are removed.
Esc replaces the old F3 restart binding, and F9 replaces Caps Lock (then Alt)
for mode. MAME defaults to full keyboard emulation. With `-uimodekey F12`,
F12 toggles MAME UI controls; when UI controls are enabled, MAME menu
shortcuts take precedence. Leave UI controls disabled while typing into ESE.

## KB Mode keyword layer

KB MODE (F9) is a toggle, not a held modifier. The keyboard-mode lamp is
**on in typewriter mode**: Shift+letter produces an uppercase letter. It is
**off in BASIC mode**: Shift+letter produces a BASIC keyword. Unshifted
letters remain lowercase. P6066 Manuale Generale PDF21 describes this polarity;
the earlier wording here incorrectly called the keyword mode “KB Mode on”.
The emulated lamp appears at the lower left of the functional console panel.

The keyword mapping is performed by the original system software using the
keyboard codes; it is not implemented as host-side keyword substitution.
The following legends come from Figure1-3 (p6066-keyboard.png).

| Shift+key (lamp off/BASIC) | Keyword | Shift+key (lamp off/BASIC) | Keyword |
|---|---|---|---|
| Q | REM | J | GOSUB |
| W | DIM | K | RETURN |
| E | DCL | L | STOP |
| R | FKEY# | Z | IF |
| T | DEF | X | THEN |
| Y | FN | C | FOR |
| U | MAT | V | TO |
| I | INPUT | B | STEP |
| O | READ | N | NEXT |
| P | DATA | M | END |
| A | PRINT | | |
| S | DISP | | |
| D | USING | | |
| F | WRITE: | | |
| G | ON | | |
| H | GOTO | | |

The keyboard device supplies physical key codes. GOINO's mode state and the
original ESE keyboard handler determine the resulting characters or keywords.
