#!/bin/bash

function pt_error()
{
    echo -e "\033[1;31mERROR: $*\033[0m"
}

function pt_warn()
{
    echo -e "\033[1;31mWARN: $*\033[0m"
}

function pt_info()
{
    echo -e "\033[1;32mINFO: $*\033[0m"
}

function pt_ok()
{
    echo -e "\033[1;33mOK: $*\033[0m"
}



SDCARD="$1"

if [ -z "$SDCARD" ]; then
    pt_error "Usage: $0 <SD card> (SD CARD: /dev/sdX  where X is your sd card number or /dev/mmcblkX where X is a letter)"
    exit 1
fi

if [ $UID -ne 0 ]
    then
    pt_error "Please run as root."
    exit
fi


pt_info "Umounting $out, please wait..."
umount ${SDCARD}* >/dev/null 2>&1
sleep 1
sync

sudo partprobe
sleep 2
sync
sudo partprobe ${SDCARD}
sleep 2


set -e

pt_warn "Flashing $SDCARD...."
dd if=./boot0.bin conv=notrunc bs=1k seek=8 of=${SDCARD}
dd if=./ub-m64-sdcard.bin conv=notrunc bs=1k seek=19096 of=${SDCARD}

pt_info "Decompressing rootfs to $SDCARD"2", please wait... (takes some time)"
mkdir -p erootfs
sudo partprobe ${SDCARD}
sleep 4
sudo mount $SDCARD"2" erootfs
tar -xvpzf rootfs_m64_rc3.tar.gz -C ./erootfs --numeric-ow
sync
sudo umount erootfs
rm -fR erootfs

set +e
mkdir eboot
sudo mount $SDCARD"1" eboot
tar -xvpzf boot_m64_rc3.tar.gz -C ./eboot  --no-same-owner
sync
sudo umount eboot
rm -fR eboot

pt_ok "Finished flashing $SDCARD!"
pt_ok "You can remove the SD card and boot up on your board. Enjoy!"

