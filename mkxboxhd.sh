#!/bin/bash

SMARTCTL="xboxhdm23usb_linuxfiles/smartctl"
TARGET_HDD="$1"

if [ ! -d "hdm/C" ] || [ ! -d "hdm/E" ]; then echo "Error: Please put C and E files in the hdm directory!"; exit 1; fi

# should we unlock HDD?
if [ -b "$TARGET_HDD" ] && [ -f "eeprom.bin" ]; then
    HDD_LOCK=1
else
    HDD_LOCK=0
fi

if [ "$HDD_LOCK" -eq "1" ]; then
    echo "Unlocking HDD..."
    sudo "$SMARTCTL" -d sat -g security "$TARGET_HDD"
    sudo "$SMARTCTL" -d sat -s security-eeprom-unlock,eeprom.bin "$TARGET_HDD"
    sudo "$SMARTCTL" -d sat -s security-eeprom-disable,eeprom.bin "$TARGET_HDD"
fi

mkdir -p PriMas/C
mkdir -p PriMas/E
fatxfs "$TARGET_HDD" dummy --format=f-takes-all --destroy-all-existing-data
if ! fatxfs "$TARGET_HDD" PriMas/C --drive=c || ! fatxfs "$TARGET_HDD" PriMas/E --drive=e; then
    echo "Error mounting disk!"
    exit 2
fi

cp -vR hdm/C/* PriMas/C/
cp -vR hdm/E/* PriMas/E/
mkdir -p PriMas/E/TDATA PriMas/E/UDATA

sync

for i in C E; do
    while ! umount PriMas/"$i"; do
        echo "retrying unmount $i..."
        sleep 1
    done
done

if [ "$HDD_LOCK" -eq "1" ]; then
     echo "Re-locking HDD..."
    sudo "$SMARTCTL" -d sat -g security "$TARGET_HDD"
    sudo "$SMARTCTL" -d sat -s security-eeprom-setpass,eeprom.bin "$TARGET_HDD"
fi

echo "Done!"
