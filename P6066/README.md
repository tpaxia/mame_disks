# Olivetti P6066

## Floppy boot

```sh
mame p6066 -flop1 flop\p6066\067.IMD -uimodekey F12 -window
```

MAME audio is enabled by default (CoreAudio on macOS). Do not use `-sound
none` if you want to hear audio; you can explicitly select CoreAudio with
`-sound coreaudio`. The P6066 console buzzer itself is disabled by default:
press Tab, open **Machine Configuration**, and set **Console buzzer** to
**Enabled**. Audio output must also be enabled in MAME for the buzzer to be
audible.

The integrated printer is optional and is not connected by default. Attach the
discard-output printer on the GOINO slot with
`-bus:console:goino:options printer`. It completes printer requests without
producing a print file or paper output. For example:

```sh
mame p6066 -bus:console:goino:options printer \
  -flop1 flop\p6066\067.IMD -uimodekey F12 -window
```

To see the printout, attach the PR 6610 thermal printer instead with
`-bus:console:goino:options pr6610`. It adds a second screen that shows the
paper roll as it is printed. If the paper is not visible, press Tab and pick a
view that includes it under **Video Options**.

```sh
mame p6066 -bus:console:goino:options pr6610 \
  -flop1 flop\p6066\067.IMD -uimodekey F12 -window
```

To run with the printer absent, leave out the `-bus:console:goino:options`
argument. The slot then reports no installed printer.

With the GO011 video card, use the verified EXD-configured compilation system:

```sh
mame p6066 -bus:video go011 \
  -flop1 flop\p6066\MASTER_SYSTEM_FOR_COMPILATION_R1_0_GO011.IMD \
  -uimodekey F12 -window
```

Replace `067.IMD` with any system floppy.

## HDU preparation, installation and boot

The [HDU package](hdu/initialized-ese/README.md) contains the clean HDI-initialized image,
the newly installed ESE HDU and its matching bootstrap floppy, original input
media, checksums, and complete reproduction instructions. It was generated
and cold-booted with the current keyboard implementation and PR 6610 attached.

Work on copies of `SYSDIS.chd` and `SYSBTS.imd`: the system writes to both.

```sh
mame p6066 -bus:dma rodma -bus:hdu difo -bus:console:goino:options pr6610 \
  -hard1 hard\p6066\SYSDIS.chd -flop2 flop\p6066\SYSBTS.imd \
  -uimodekey F12 -window
```

The HDU is on `-hard1` and the bootstrap floppy is in FD2; FD1 stays empty.
Wait for `READY`. See the package instructions for the observed startup
messages.

## Keyboard

[Composite keyboard map](keyboard/p6066-keyboard-mapping-combo.png)  ·
[US keyboard to P6066 mapping](keyboard/us-to-p6066-mapping.md)


F9 toggles keyboard mode. F12 toggles MAME UI controls. Keep UI controls
disabled while typing into ESE.
