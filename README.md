mkxboxhd
========

This utility allows you to create Xbox hard drives using modern tooling.

Usage
-----

- Fetch dependencies with `git submodule init; git submodule update`
- Build FUSE fatxfs in `fatx` (make sure you install all of the dependencies or it won't build FUSE support!)
- Put your C and E files in the `hdm/` folder, as you would with XboxHDMaker.
- If you need to unlock and re-lock the HDD, put your `eeprom.bin` in the root directory of this tool, as you would with XboxHDMaker.
- Making sure that the `fatxfs` binary in `fatx/build/fatxfs` is in your PATH, run `./mkxboxhd.sh [path to disk]`

Troubleshooting
---------------

### HDD won't unlock

- This tool will not attempt to unlock a drive if `eeprom.bin` is missing.
- Ensure your user has `sudo` powers.
- You must use a USB adapter, and it must implement SCSI to ATA Translation.
- SCSI to ATA translation does NOT work properly with the `uas` driver.  You need to temporarily disable `uas` and use the `usb-storage` driver instead, for example by reloading it with `quirk=[VID]:[PID]:u`.

### "Error mounting disk!"

- If you are working with a real disk and not an image, you will need to make sure your user has permission to access it (for example: `sudo usermod -a -G disk user`) or run it as `root`.

### I used this tool, and now my Xbox won't boot / still won't launch unauthorized software

- Because I will not help you obtain copyrighted material, I cannot help you.
