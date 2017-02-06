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

if [ $UID -ne 0 ]
    then
    pt_error "Please run as root."
    exit
fi


out=/dev/mmcblk0

pt_info "Umounting $out (eMMC), please wait..."
sync
umount ${out}* >/dev/null 2>&1
sleep 1
sync

set -e
pt_info "Formating eMMC $out ..."

part_position=20480   # KiB
boot_size=80          # MiB
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
c
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
# Create boot file system (VFAT)
dd if=/dev/zero bs=1M count=${boot_size} of=${out}p1
mkfs.vfat -n emmcboot -I ${out}p1

# Create ext4 file system for rootfs
mkfs.ext4 -F -b 4096 -E stride=2,stripe-width=1024 -L emmcrootfs ${out}p2
sync
sudo tune2fs -O ^has_journal ${out}p2
sync

pt_ok "Done - Geometry created and eMMC '$out' formatted, now flash the image with ./flash_emmc.sh"

