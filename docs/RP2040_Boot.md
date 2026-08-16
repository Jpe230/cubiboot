# Booting from an RP2040 Pico

This guide describes how to install cubeboot as a built-in firmware for the pico.
This includes PicoBoot devices installed on the IPL.

## Install

Download the most recent `cubeboot.uf2` firmware file from the GitHub releases 
page. Optionally desolder the VCC wire from your pico to avoid over-voltage on 
your GameCube while flashing (if you have a diode installed on VCC you can skip
this step).

Hold `BOOTSEL` while plugging your pico into your computer. This cause a Drive 
to appear on the computer. Copy the `cubeboot.uf2` to the drive and wait until 
it disappears. The firmware has been successfully updated.

If you desoldered VCC you should resolder it now before booting your GameCube again.

Create a root-level `config.ini` on your SD card to customize the boot process.
See [Configuration](settings.md) for an example and the available settings.

You no longer need an `IPL.dol` file on your SD Card after installing cubeboot as
firmware.

## Issues

TBD
