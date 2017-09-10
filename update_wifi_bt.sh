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
set -e
pt_info "Updating Wifi, please wait..."
dest="/lib/firmware/ap6212/"
bt_fw="/lib/firmware/ap6212/fw_bcm43438a1.bin"
if [ ! -f "$bt_fw" ]
then
  pt_warn "Downloading fw wifi file..."
  wget -q -O ${bt_fw} https://github.com/BPI-SINOVOIP/BPI_WiFi_Firmware/raw/master/ap6212/fw_bcm43438a1.bin
fi
bt_hcd="/lib/firmware/ap6212/bcm43438a1.hcd"
if [ ! -f "$bt_hcd" ]
then
  pt_warn "Donwloading hcd wifi file..."
  wget -q -O ${bt_hcd} https://github.com/BPI-SINOVOIP/BPI_WiFi_Firmware/raw/master/ap6212/bcm43438a1.hcd
fi

pt_info "Updating Wifi services..."
sed -i -e 's/bcm43438a0/bcm43438a1/g' /usr/local/bin/bpi-bt-patch
sync
sed -i -e 's/bcm43438a0/bcm43438a1/g' /usr/local/bin/bpi-bt-on
sync
if [ ! -f "$bt_hcd" ]
then
pt_error "Could not download files, you have to do this manually!"
else
pt_ok "Wifi is now updated for the A1 chip!"
pt_ok "Now you should reboot, type: sudo reboot"
fi