# Olivetti P6066

## Floppy boot

```sh
mame p6066 -flop1 flop\p6066\067.IMD -uimodekey F12 -window
```

The buzzer is silent by default. To explicitly disable all MAME audio, add
`-sound none`; omit that flag to hear the emulated buzzer.

The integrated printer is optional and is not connected by default. Attach the
discard-output printer on the GOINO slot with
`-bus:console:goino:options printer`. It completes printer requests without
producing a print file or paper output. For example:

```sh
mame p6066 -bus:console:goino:options printer \
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

## HDU boot

```sh
mame p6066 \
  -bus:dma rodma -bus:hdu difo -bus:video go011 -uimodekey F12 \
  -hard1 hard\p6066\P6066_HDU_10MB_INSTALLED.chd \
  -flop2 flop\p6066\P6066_HDU_BOOTSTRAP.IMD -window
```

## Keyboard

[Composite keyboard map](keyboard/p6066-keyboard-mapping-combo.png)  ·
[US keyboard to P6066 mapping](keyboard/us-to-p6066-mapping.md)


F9 toggles keyboard mode. F12 toggles MAME UI controls. Keep UI controls
disabled while typing into ESE.
