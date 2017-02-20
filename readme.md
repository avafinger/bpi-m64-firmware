Banana Pi M64 Ubuntu Xenial Xerus 16.04 LXDE OS Image (firmware)
================================================================


	Kernel has been updated to version 3.10.104, see **Updating Kernel section**

	LCD 7" with Touch for testing, see **LCD 7" with Touch Screen section**



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
- LCD 7" with Touch Screen (Not tested!)

This OS image is based on the works and ideas of
-------------------------------------------------

- Bpi-tools (https://github.com/BPI-SINOVOIP/bpi-tools)
- Longsleep's kernel 3.10.102 (https://github.com/longsleep/linux-pine64) - Updated to 3.10.104
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
- Grab a good SD CARD (*), 80% of the issues you may have is due to counterfeit or bad sd card brand.
- SD/HC Card reader can also be a source of problems writing to a good SD CARD.
  (*) If you can be sure your SD card is fine and you still have problems, try using another SDHC card reader
- We need 8GB SD CARD, the OS Image fits in a 4GB but need more space as you will see.
- Get a good PSU with at least 2.5A (be on the safe side).
- Make sure you have HDMI (don't use HDMI to DVI if you can).
- Make sure HDMI is connected to the board very tight or you may experience some flickering or the image will not appear.


Screenshots
-----------

Kernel 3.10.104 (fix for 'Dirty COW' and camera with AF)
![New kernel version 3.10.104](https://github.com/avafinger/bpi-m64-firmware/raw/master/img/new_kernel_3.10.104.png)

Camera with AF (Auto Focus) enabled
![camera_AF](https://github.com/avafinger/bpi-m64-firmware/raw/master/img/camera_AF.png)

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

1.  We need wget,md5sum and fdisk, install it if not already

            sudo apt-get install wget
            sudo apt-get install md5sum


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


Updating Kernel to 3.10.104
---------------------------

You can update to the latest kernel with a fix for the **DIRTY COW** vulnerability
and some minor improvements on fs, overlays, camera AF, etc..

The update will be done manually as below:

1.  Update SD card with latest kernel 3.10.104

    Insert the SD CARD in SDHC card reader with the Image (kernel 3.10.102) on your **HOST PC running linux** and find the correct device number/letter

    a.  **type in command line:**

		dmesg | tail
		[23273.595102] EXT4-fs (sdc2): mounted filesystem without journal. Opts: (null)
		[24835.068927] sdc: detected capacity change from 15523119104 to 0
		[26540.804172] sd 4:0:0:0: [sdc] 30318592 512-byte logical blocks: (15.5 GB/14.4 GiB)
		[26540.814172] sd 4:0:0:0: [sdc] No Caching mode page found
		[26540.814177] sd 4:0:0:0: [sdc] Assuming drive cache: write through
		[26540.829166] sd 4:0:0:0: [sdc] No Caching mode page found
		[26540.829171] sd 4:0:0:0: [sdc] Assuming drive cache: write through
		[26540.835182]  sdc: sdc1 sdc2
		[26543.086174] EXT4-fs (sdc2): warning: mounting unchecked fs, running e2fsck is recommended
		[26544.384752] EXT4-fs (sdc2): mounted filesystem without journal. Opts: (null)	


    b.  **From the information above:**
	
	Our SD card is in the format /dev/sdX where X is a letter [b,c,d..], in my case is **c**, but if you have
	only one HDD most likely will be **b**	


		ls /media/
		boot  rootfs

		l /media/*
		/media/boot:
		a64/  BPI-M64.txt  Image.version  initrd.img  OV5640_SET.txt  uEnv.txt

		/media/rootfs:
		bin/   dev/  home/  lost+found/  mnt/  proc/  run/   srv/  tmp/  var/
		boot/  etc/  lib/   media/       opt/  root/  sbin/  sys/  usr/


		**This is my SD card device, make sure you find yours**
		/dev/sdc1        80M   24M   57M  30% /media/boot
		/dev/sdc2        15G  2.2G   12G  17% /media/rootfs


		In modern distro, you could have it as /media/[USER]/rootfs



    c.  **Download the new kernel 3.10.104:**


		mkdir -p m64
            	cd m64
		wget https://github.com/avafinger/bpi-m64-firmware/raw/master/kernel_m64_rc3.tar.gz

		*check MD5SUM, must match this:*
		md5sum kernel_m64_rc3.tar.gz
		65b77730cf820130c783557698458bd7  kernel_m64_rc3.tar.gz

		*check MD5SUM, must match this:*
		wget https://github.com/avafinger/bpi-m64-firmware/raw/master/Image_kernel_3.10.104
		md5sum Image_kernel_3.10.104 
		6c6a6d426a40224956c8ec017457f067  Image_kernel_3.10.104


    d.  **Flash it to SD card:**

		
		Please, change the correct path to your /media/?/boot where ? may be your [USER]

		*note we need to backup Image in case something goes wrong*
		mv /media/boot/a64/Image /media/boot/a64/Image_kernel_3.10.102
		cp -vf Image_kernel_3.10.104 /media/boot/a64/Image
		sync

		sudo tar -xvpzf kernel_m64_rc3.tar.gz -C /media/rootfs/lib/modules --numeric-ow
		sync



    e.  **If everything is correct, unmount your SD card and boot the bpi-m64 with the SD card**



2.  Update kernel on eMMC

    a.  **type in command line:**


		mkdir -p m64
            	cd m64
		wget https://github.com/avafinger/bpi-m64-firmware/raw/master/kernel_m64_rc3.tar.gz

		*check MD5SUM, must match this:*
		md5sum kernel_m64_rc3.tar.gz
		65b77730cf820130c783557698458bd7  kernel_m64_rc3.tar.gz

		*check MD5SUM, must match this:*
		wget https://github.com/avafinger/bpi-m64-firmware/raw/master/Image_kernel_3.10.104
		md5sum Image_kernel_3.10.104 
		6c6a6d426a40224956c8ec017457f067  Image_kernel_3.10.104



    b.  **Write it to eMMC:**


		mv /media/ubuntu/emmcboot/a64/Image /media/ubuntu/emmcboot/a64/Image_kernel_3.10.102
		cp -vf Image_kernel_3.10.104 /media/ubuntu/emmcboot/a64/Image
		sync

		sudo tar -xvpzf kernel_m64_rc3.tar.gz -C /media/ubuntu/emmcrootfs/lib/modules --numeric-ow
		sync



    c.  **Shutdown and boot without the SD card inserted:**


		sudo shutdown -h now



2.  Restoring kernel 3.10.102


    If you find bugs or any instability on kernel 3.10.104 you can always restore kernel 3.10.102

		mv /media/ubuntu/emmcboot/a64/Image /media/ubuntu/emmcboot/a64/Image_kernel_3.10.104
		cp -vf /media/ubuntu/emmcboot/a64/Image_kernel_3.10.102 /media/ubuntu/emmcboot/a64/Image
		sync

    Reboot: sudo reboot



LCD 7" with Touch Screen (not tested)
-------------------------------------

This is the instructions to work with LCD 7" (S070WV20_MIPI_RGB) and Touch Screen.
The file a64-2GB_LCD_TOUCH.dtb ( https://github.com/avafinger/bpi-m64-firmware/blob/master/a64-2GB_LCD_TOUCH.dtb )
This DTB file has supportfor LCD and Touch.

1.  Instructions (type in command from your HOST PC)

    a.  **Rename a64-2GB_LCD_TOUCH.dtb to a64-2GB.dtb**


		mv /media/boot/a64/a64-2GB.dtb /media/boot/a64/a64-2GB.dtb_1080P
		cp -fv a64-2GB_LCD_TOUCH.dtb /media/boot/a64/a64-2GB.dtb



    b.  **Edit and Add the Touch support**


		leafpad (or your editor) /media/rootfs/etc/modules
		add: ft5x_ts

     

		copy ft5x_ts.ko to your SD card:
		cp -vf ft5x_ts.ko /media/rootfs/lib/modules/3.10.102/kernel/drivers/input/touchscreen/ft5x/ft5x_ts.ko



    c.  **Add TSLIB support or evdev Support**

    In order to X11 accepts touch screen you will need TSLIB support or EVDEV support.
    You can follow this for TSLIB: https://github.com/avafinger/pine64-touchscreen
    Change the file xorg.conf for something like this:



		# Bpi M64 TS - no need for calibration with TSLIB
		# no need for uvdev
		Section "InputClass"
			Identifier "M64-Touchscreen"
		#	MatchIsTouchscreen "on"
			MatchDevicePath "/dev/input/event*"
			MatchProduct "ft5x_ts"
			Driver "tslib"
		#	Option "Mode" "Absolute"
		EndSection



    or use evdev

Initial setup
-------------

1.  DHCP is activated by default

2.  Eth0 is not managed, if you connect using Wifi and later wish to get back
    to DHCP you must issue a ifdown and ifup command to renew DHCP.

3.  Output mode is HDMI 1080p60 , to change it to 720p you need to generate a new DTB
    and set it to 720p or any other HDMI mode inside the DTB.



		There is a DTB with support for 720P:
		rename the file /media/boot/a64/a64-2GB.dtb to /media/boot/a64/a64-2GB.dtb_1080P
		copy the file a64-2GB_720P.dtb to /media/boot/a64/a64-2GB.dtb
		*boot the board with this new file




mini FAQ (Ubuntu Xenial 16.04)
------------------------------

1.  How to update the distro

    a.  **Use command line:**

            sudo apt-get update
            sudo apt-get dist-upgrade
            sync


2.  How to change keyboard layout

    a.  **Use command line:**

            sudo dpkg-reconfigure keyboard-configuration


3.  How to change timezone

    a.  **type in command line:**

            timedatectl list-timezones
            sudo timedatectl set-timezone desired_timezone
            sudo timedatectl set-timezone America/New_York


4.  How to change language

    Install your language package and generate new locale.


5.  How to play MP4 videos ( MPEG1, MPEG2, MPEG4 )

    Follow libvdpau-sunxi and install LIBVDPAU and instal mpv
    

6.  How to install Ubuntu MATE

            sudo apt-get update
            sudo apt-get dist-upgrade
            sync
            sudo apt-get install ubuntu-mate-desktop


7.  How to change Hostname

    Suppose you want to change the hostname to "myhostname":

    a.  **edit the file /etc/hostname and change the contents to: myhostname**

            sudo leafpad /etc/hostname
            change contents to: myhostname

    b.  **edit the file /etc/hosts and change or add the contents**

            sudo leafpad /etc/hosts
            change/add the following

            127.0.0.1	localhost
            127.0.1.1	myhostname

            # The following lines are desirable for IPv6 capable hosts
            ::1     ip6-localhost ip6-loopback
            fe00::0 ip6-localnet
            ff00::0 ip6-mcastprefix
            ff02::1 ip6-allnodes
            ff02::2 ip6-allrouters

    c.  **sync and reboot**

            sync
            sudo reboot



Troublehooting
--------------

1.  Nothing on my LCD/Monitor TV display

    a.  **Make sure the HDMI conector is well connected to the board**

    b.  **Make sure your LCD/Monitor TV is 1080P capable, the board will boot in HDMI 1080P mode only**

    c.  **Don't use DVI to HDMI**

2.  Moving windows on screen is slow

    **Install Metacity**

3.  Camera is not working

    a.  **Make sure you connect the sensor**

    b.  **The camera connector at the board side is really horrible, you need to make sure the FPC cable touch the contacts (They should change it on next board revision)**

4.  Board does not boot

    a.  **Watch for some signs during normal boot**

        - Wait a few seconds, BROM waits for FEL button and then proceed loading
        
        - Mouse should blink twice

        - Ethernet connector will blink and show some activities

        - Your monitor will switch to HDMI 1080p

    b.  **If you don't see any of this signs during boot, you most likely have run into the following**

        - Bad SD card even if does not show bad track or errors, try with another brand and size

        - PSU Under power or under voltage, use a good PSU, at least 2.5A and 5v output guarantee

    c.  **Check for SD card integrity**

        sudo fsck.vfat -a /dev/sdX1 (where X is your SD card letter [b,c..]

        sudo fsck.ext4 -f /dev/sdX2  (where X is your SD card letter [b,c..]


*** WIP ***

History Log:
===========
* initial commit (readme file)
* created on 26/01/2017
* fix readme (wip)
* readme with instructions (wip)