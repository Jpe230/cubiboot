# Booting from SD

This guide describes how cubeboot can be used on a system with iplboot installed
as the initial program. This includes PicoBoot devices with stock firmware as well
as Viper and Qoob devices with iplboot installed to internal flash.

## Install

To install for use with iplboot, simply rename your current `IPL.dol` to `boot.dol`,
this will usually be Swiss.
Download the most recent `cubeboot.dol` file from the GitHub releases page. Now rename 
the `cubeboot.dol` file you downloaded to `IPL.dol` and copy it to the SD Card.

Create a root-level `config.ini` and change any settings you'd like before
continuing. See [Configuration](settings.md) for a ready-to-use example and a
complete list of settings.

Once you have confirmed that the SD Card contains `IPL.dol`, `boot.dol`, and
`config.ini` (if you use one), you are ready to go!

## Troubleshooting

Some SD cards are unreliable with Cubiboot, especially when formatted as FAT32.
If the console reaches the GameCube menu unexpectedly or reports `NO DISC`, try a
different card or format the card as exFAT first. The old `force_fallback` workaround
is not supported by the current configuration parser.
