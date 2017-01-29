Banana Pi M64 Ubuntu Xenial Xerus 16.04 LXDE OS Image (firmware)
================================================================

LXDE (Lightweight X11 Desktop Environment) is a desktop environment which is lightweight 
and fast and uses less RAM and less CPU while being a feature rich desktop environment.

If you want a richer desktop environment (but slower) you can install 
Ubuntu MATE on top of this Image and later de-install LXDE.

I use LXDE just because it is very fast, snappy  and responsive!
You can always improve, tweak and tune the way you want at any time.
This is a very LEAN and MEAN OS image to play and learn how to extend it.

This is a preliminary LXDE OS image for the Banana Pi M64 with fully working
----------------------------------------------------------------------------

- eMMC
- Wifi
- BT (bluetooth)
- OV5640 (camera)
- HDMI 1080P
- GbE (Gigabit ethernet)

This OS image is based on the works and ideas of
-------------------------------------------------

- Bpi-tools
- Longsleep's kernel 3.10.102 (https://github.com/longsleep/linux-pine64)
- @tkaiser's script
- @phelum's BT tools (https://github.com/phelum/CT_Bluetooth)
- FA's script ideas
- linux-sunxi (http://linux-sunxi.org)
- Jemk (https://github.com/jemk/cedrus)
- Armbian tips
- @lex (Alexander Finger)



Things that works with this Image
--------------------------------

- Firefox (64 bit) - stock version
- Guvcview
- MJPG-streamer (unstable - removed)
- ffmepg 3.14 with cedrus (H264 encoding)

Things you will not find in this image
--------------------------------------

- 3D Mali acceleration
- Firefox with HW acceleration
- ssh not installed (it is a Desktop Image, if you need it just install it)


Before you start downloading and flashing you should pay attention to this
--------------------------------------------------------------------------

- We need a linux box to flash the Image into SD CARD, i use LUbuntu 12.04 but could be any distro.
- Grab a good SD CARD, 80% of the issues you may have is due to counterfeit or bad sd card brand.
- We need 8GB SD CARD, the OS Image fits in a 4GB but need more space as you will see.
- Get a good PSU with at least 2.5A (be on the safe side).
- Make sure you have HDMI (don't use HDMI to DVI if you can).
- Make sure HDMI is connected to the board very tight or you may experience some flickering or the image will not appear.


Screenshots
-----------

Bluetooth
![bluetooth](https://github.com/avafinger/bpi-m64-firmware/raw/master/img/bluetooth.png)

Wifi
![bluetooth](https://github.com/avafinger/bpi-m64-firmware/raw/master/img/wifi.png)

Firefox
![bluetooth](https://github.com/avafinger/bpi-m64-firmware/raw/master/img/firefox.png)

Guvcview
![bluetooth](https://github.com/avafinger/bpi-m64-firmware/raw/master/img/guvcview.png)

Sound (ALSA)
![bluetooth](https://github.com/avafinger/bpi-m64-firmware/raw/master/img/sound.png)

MJPG-streamer (not working - investigating..)
![bluetooth](https://github.com/avafinger/bpi-m64-firmware/raw/master/img/mjpg-streamer.png)

Installation
------------

This is a non orthodox way of flashing the image onto SD card and eMMC.
We will do the following steps:

  1. Download firmware
  2. Format SD card, and unzip kernel
  3. Boot from SD card to detect the eMMC
  4. Format eMMC and unzip kernel

There will be no need for requesting unused space on SD card or eMMC, we don't use '.img' file.

### Manual installation (download the binaries)

1.  Install wget and fdisk for your distro

2.  Download the files and check MD5

    a.  In shell type:

	wget https://github.com/avafinger/a64_bin/raw/master/ub-m64-emmc.bin
	wget https://github.com/avafinger/a64_bin/raw/master/ub-m64-sdcard.bin
	wget https://github.com/avafinger/a64_bin/raw/master/boot0.bin


    b.  Get the kernel and check MD5

 	wget https://drive.google.com/open?id=0B7A7OPBC-aN7blVEcjk5aFppZG8
	md5sum rootfs_m64_rc3.tar.gz 
	e3d76d7f89e6150904150691031b6461  rootfs_m64_rc3.tar.gz

	wget https://drive.google.com/open?id=0B7A7OPBC-aN7RktMMHo5ekx3Znc
	md5sum boot_m64_rc3.tar.gz 
	7867f40375fc993f10eaa21cff7843d6  boot_m64_rc3.tar.gz


  
*** WIP ***

History Log:
===========
* initial commit (readme file)
* created on 26/01/2017
* fix readme (wip)