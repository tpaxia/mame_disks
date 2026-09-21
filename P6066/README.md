# Olivetti P6066

## Floppy boot

```sh
mame p6066 -flop1 067.IMD
```

Replace `067.IMD` with any system floppy.

## HDU boot

```sh
mame p6066 \
  -bus:dma rodma -bus:hdu difo -bus:video go011 \
  -hard1 P6066_HDU_10MB_INSTALLED.chd \
  -flop2 P6066_HDU_BOOTSTRAP.IMD
```

## Keyboard

[US keyboard to P6066 mapping](keyboard/us-to-p6066-mapping.md) ·
[Composite keyboard map](keyboard/p6066-keyboard-mapping-combo.png)

F9 toggles keyboard mode. F12 toggles MAME UI controls. Keep UI controls
disabled while typing into ESE.