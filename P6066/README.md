# Olivetti P6066

## Floppy boot

```sh
mame p6066 -flop1 flop\p6066\067.IMD -uimodekey F12 -window
```
With the GO011 video card:


```sh
mame p6066  -bus:dma rodma  -bus:video go011 -flop1 flop\p6066\067.IMD -uimodekey F12 -window
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