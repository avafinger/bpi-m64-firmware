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

function do_720p()
{
if [ ! -d "/media/ubuntu/${BOOT_DEVICE}boot/a64" ]
then
  pt_error "Directory missing!"
  exit  
fi
cd /media/ubuntu/${BOOT_DEVICE}boot/a64
if [ ! -f "m64.dtb_720p" ]
then
   pt_error "There is no 720p file mode for your board!"
   exit
fi
if [ ! -f "m64.dtb" ]
then
   pt_error "There is no n64.dtb on your board!"
   exit
fi
sudo rm -f m64.dtb
sudo ln -s m64.dtb_720p m64.dtb
sync

whiptail --msgbox "HDMI resolution is set up to boot with 720p mode." 20 40 2
pt_info "Please, reboot"
}

function do_1080p()
{
if [ ! -d "/media/ubuntu/${BOOT_DEVICE}boot/a64" ]
then
  pt_error "Directory missing!"
  exit  
fi
cd /media/ubuntu/${BOOT_DEVICE}boot/a64
if [ ! -f "m64.dtb_1080p" ]
then
   pt_error "There is no 1080p file mode for your board!"
   exit
fi
if [ ! -f "m64.dtb" ]
then
   pt_error "There is no n64.dtb on your board!"
   exit
fi

sudo rm -f m64.dtb
sudo ln -s m64.dtb_1080p m64.dtb
sync
whiptail --msgbox "HDMI resolution is set up to boot with 1080p mode." 20 40 2
pt_info "Please, reboot"
}


if [ $UID -ne 0 ]
    then
    pt_error "Please run as root."
    exit
fi
set -e

  BOOT_DEVICE="emmc" 
  boot_dev=$(whiptail --menu "Chose Boot device to change HDMI resolution (eMMC or SD CARD)" 20 60 10 \
      "SDCARD" "Changes will be visible when booting from SD card" \
      "EMMC" "Changes will be visible when booting from eMMC card" \
    3>&1 1>&2 2>&3)
  if [ $? -eq 0 ]; then
    case "$boot_dev" in
      SDCARD*) BOOT_DEVICE="" ;;
      EMMC*) BOOT_DEVICE="emmc" ;;
      *)
        whiptail --msgbox "Please, choose one of the option" 20 50 2
        return 1
        ;;
    esac

  fi


  hdmi_res=$(whiptail --menu "Chose HDMI Resolution for the next boot" 20 50 10 \
      "720p" "HD Resolution ( 1280 x 720 )" \
      "1080p" "Full HD Resolution ( 1920 x 1080 )" \
    3>&1 1>&2 2>&3)
  if [ $? -eq 0 ]; then
    case "$hdmi_res" in
      720p*) do_720p ;;
      1080p*) do_1080p ;;
      *)
        whiptail --msgbox "Please, choose one of the option" 20 50 2
        return 1
        ;;
    esac

  fi
