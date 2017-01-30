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

- Bpi-tools (https://github.com/BPI-SINOVOIP/bpi-tools)
- Longsleep's kernel 3.10.102 (https://github.com/longsleep/linux-pine64)
- @tkaiser's script
- @phelum's BT tools (https://github.com/phelum/CT_Bluetooth)
- FA's script ideas (http://wiki.friendlyarm.com/wiki/index.php/NanoPi_A64#Make_Your_Own_OS.28Compile_BSP.29)
- linux-sunxi (http://linux-sunxi.org)
- Jemk (https://github.com/jemk/cedrus)
- Armbian tips (https://www.armbian.com/)
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
- 2D optimization


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

    a.  **In shell type (host PC):**

            mkdir -p m64
            cd m64
            wget https://github.com/avafinger/a64_bin/raw/master/ub-m64-sdcard.bin
            wget https://github.com/avafinger/a64_bin/raw/master/boot0.bin
            wget https://github.com/avafinger/bpi-m64-firmware/raw/master/flash_sd.sh
            wget https://github.com/avafinger/bpi-m64-firmware/raw/master/format_sd.sh


    b.  **Get the kernel and check MD5**

            wget https://drive.google.com/open?id=0B7A7OPBC-aN7blVEcjk5aFppZG8
            md5sum rootfs_m64_rc3.tar.gz 
            e3d76d7f89e6150904150691031b6461  rootfs_m64_rc3.tar.gz

            wget https://drive.google.com/open?id=0B7A7OPBC-aN7RktMMHo5ekx3Znc
            md5sum boot_m64_rc3.tar.gz 
            7867f40375fc993f10eaa21cff7843d6  boot_m64_rc3.tar.gz


    c.  **Insert a new SD card (get a good one, 8 GB or > )**

    d.  **Find your SD card**

            dmesg|tail
            [97286.659006] sdc: detected capacity change from 15523119104 to 0
            [99023.137526] sd 4:0:0:0: [sdc] 30318592 512-byte logical blocks: (15.5 GB/14.4 GiB)
            [99023.147516] sd 4:0:0:0: [sdc] No Caching mode page found
            [99023.147521] sd 4:0:0:0: [sdc] Assuming drive cache: write through
            [99023.162514] sd 4:0:0:0: [sdc] No Caching mode page found
            [99023.162518] sd 4:0:0:0: [sdc] Assuming drive cache: write through
            [99023.168535]  sdc: sdc1 sdc2

        in this example our sd card is /dev/sdc if we use an SD CARD reader (USB), it could be /dev/sdb if you have only one HDD on your host PC
        so the format is something like /dev/sdX where X is [b,c,d..,g]

    e.  **Start flashing... (Warning, make sure you get the correct device or you may WIPE your HDD)**

            sudo chmod +x *.sh
            sudo ./format_sd.sh /dev/sdc
            sudo ./flash_sd.sh /dev/sdc

    Now you have SD card with Falshed kernel in it, you can now boot up bpi-m64 with this SD card and it will detect the eMMC:
  
            user: ubuntu
            pass: ubuntu
  
3.  Flashing eMMC

    a.  **After you boot up with SD card, type:**

            mkdir -p m64
            cd m64
            wget https://github.com/avafinger/a64_bin/raw/master/ub-m64-emmc.bin
            wget https://github.com/avafinger/a64_bin/raw/master/boot0.bin
            wget https://github.com/avafinger/bpi-m64-firmware/raw/master/flash_emmc.sh
            wget https://github.com/avafinger/bpi-m64-firmware/raw/master/format_emmc.sh


    b.  **Get the kernel and check MD5**

            wget https://drive.google.com/open?id=0B7A7OPBC-aN7blVEcjk5aFppZG8
            md5sum rootfs_m64_rc3.tar.gz 
            e3d76d7f89e6150904150691031b6461  rootfs_m64_rc3.tar.gz

            wget https://drive.google.com/open?id=0B7A7OPBC-aN7RktMMHo5ekx3Znc
            md5sum boot_m64_rc3.tar.gz 
            7867f40375fc993f10eaa21cff7843d6  boot_m64_rc3.tar.gz

    c.  **Start flashing... (eMMC)**

            sudo chmod +x *.sh
            sudo ./format_emmc.sh
            sudo ./flash_emmc.sh

    If everything is OK you can now shutdown and boot up without the SD card.


If you find wrong or misleading information, please let me know and i will fix ASAP.


Troublehooting
--------------

1.  Nothing on my LCD/Monitor TV display

    a.  **Make sure the HDMI conector is well connected to the board**

    b.  **Make sure your LCD/Monitor TV is 1080P capable, the board will boot in HDMI 1080P mode only**

    c.  **Don't use DVI to HDMI**

*** WIP ***

History Log:
===========
* initial commit (readme file)
* created on 26/01/2017
* fix readme (wip)
* readme with instructions (wip)