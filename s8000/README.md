# Zilog System 8000 disk images

## ZEUS 3.2.1

Hard disk image with ZEUS 3.2.1 installed. Background and build details are in
[tpaxia/Zilog_S8000](https://github.com/tpaxia/Zilog_S8000).

```sh
mame s8000 -hard1 s8000/s8000_smd.chd
```

Enable **Support Segmented OS** in Machine Configuration and restart the
machine. Press numeric-keypad `+` for the front-panel **START** button.

The same image can also be run on the Series Two CPU:

```sh
mame s8000s2 -hard1 s8000/s8000_smd.chd
```

Do not open the image in both machines at the same time.