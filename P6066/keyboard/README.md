# P6066 keyboard mapping for MAME

<!-- copyright-holders: Salvatore Paxia -->

The agreed host-key mapping implemented by the P6066 MAME driver is documented
in [US keyboard to P6066 mapping](us-to-p6066-mapping.md).

[Final composite keyboard map](p6066-keyboard-mapping-combo.png) shows the US
101-key host layout followed by the primary, Shift, Alt chord-prefix, and F9
KB MODE layers. The underlying references are the
[P6066 keyboard diagram](p6066-keyboard.png), rendered from Figure 1-3 of
P6066 Manuale Generale, and the [US 101-key layout](keyboard-101-us.svg).

F9 toggles P6066 keyboard mode. F12 toggles MAME UI controls when MAME is
started with `-uimodekey F12`; leave UI controls disabled while entering ESE
commands. Console buttons are operated with the mouse.
