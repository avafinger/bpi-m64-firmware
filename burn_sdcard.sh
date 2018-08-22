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

mmc="mmcblk"
out="$1"

if [ -z "$out" ]; then
    pt_error "Usage: $0 <SD card> (SD CARD: /dev/sdX  where X is your sd card letter or /dev/mmcblkY  where Y your device number)"
    exit 1
fi

if [ $UID -ne 0 ]
    then
    pt_error "Please run as root."
    exit
fi

if [[ $out == *$mmc* ]]; 
then
part="p"
else
part=""
fi


pt_info "Umounting $out, please wait..."
sync
umount ${out}* >/dev/null 2>&1
sleep 1
sync

set -e
pt_info "Formating sd card $out ..."

part_position=20480   # KiB
boot_size=120          # MiB
# Create beginning of disk
pt_info "Zeroing mbr on $out ..."
dd if=/dev/zero bs=1M count=$((part_position/1024)) of="$out"
sync

pt_info "Creating partition on $out ..."
# Add partition table
cat <<EOF | fdisk "$out"
o
n
p
1
$((part_position*2))
+${boot_size}M
t
83
n
p
2
$((part_position*2 + boot_size*1024*2))

t
2
83
w
EOF

sleep 1
sync
partprobe -s ${out}
sync

pt_warn "Formating $out ..."
# Create boot file system (ext4)
dd if=/dev/zero bs=1M count=${boot_size} of=${out}1
mkfs.ext4 -F -b 4096 -E stride=2,stripe-width=1024 -L boot ${out}${part}1

# Create ext4 file system for rootfs
mkfs.ext4 -F -b 4096 -E stride=2,stripe-width=1024 -L rootfs ${out}${part}2
sync
sudo tune2fs -O ^has_journal ${out}${part}2
sync

pt_info "Geometry created and sd card '$out' formatted, now flashing... it can take some time, please wait..."
sleep 2

pt_info "Reading partition..."
sudo partprobe
sleep 2
sync
sudo partprobe ${out}
sleep 2

set -e
pt_warn "Flashing $out...."
dd if=./ub-m64-sdcard.bin conv=notrunc bs=1k seek=8 of=$out

pt_info "Decompressing rootfs to $out$part"2", please wait... (takes some time)"
mkdir -p erootfs
sudo partprobe ${out}
sleep 2
sync
sudo mount $out$part"2" erootfs
tar -xvpzf rootfs_m64_a64_rc1.tar.gz -C ./erootfs --numeric-ow
sync
sudo umount erootfs
rm -fR erootfs
sync
set +e
mkdir eboot
sudo mount $out$part"1" eboot
tar -xvpzf boot_m64_a64_rc1.tar.gz -C ./eboot --numeric-ow
sync
sudo umount eboot
rm -fR eboot
sync
pt_ok "Finished flashing $out!"
pt_ok "You can remove the SD card and boot the board with this new OS image. Enjoy!"


