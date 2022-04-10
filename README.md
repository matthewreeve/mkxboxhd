mkxboxhd
========

This utility allows you to create Xbox hard drives using modern tooling.

Usage
-----

- Fetch dependencies with `git submodule init; git submodule update`
- Build FUSE fatxfs in `fatx` (make sure you install all of the dependencies or it won't build FUSE support!)
- Put your C and E files in the hdm/ folder, as you would with XBoxHDMaker.
- If you need to unlock and re-lock the HDD, put your `eeprom.bin` in the root directory of this tool, as you would with XBoxHDMaker.
- Making sure that the `fatxfs` binary in `fatx/build/fatxfs` is in your PATH, run `./mkxboxhd.sh [path to disk]`

If you need to lock/unlock the HDD, you will need to use a USB-to-SATA adapter that implements SCSI to ATA Translation and ensure that your user has `sudo` powers.  If you are working with real disks and not images, you will need to make sure your user has permission to access it (for example: `sudo usermod -a -G disk user`) or run it as `root`.
