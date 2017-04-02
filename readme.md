Banana Pi M64 Ubuntu Xenial Xerus 16.04 LXDE OS Image (firmware)
================================================================

	Update: Kernel version 3.10.105 to support Leds, see **Updating Kernel section**

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
- HDMI 1080P / HDMI 720P
- HDMI digital sound output / JACK analog stereo sound output
- GbE (Gigabit ethernet)
- LEDs (Blue and Green) - 3.10.105 only
- LCD 7" with Touch Screen (Not tested!)

This OS image is based on the works and ideas of
-------------------------------------------------

- Bpi-tools (https://github.com/BPI-SINOVOIP/bpi-tools)
- Longsleep's kernel 3.10.102 (https://github.com/longsleep/linux-pine64) - Updated to 3.10.104 / 3.10.105
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


Things you should do after flashing the OS Image
-----------------------------------------------

- Setup /etc/hostname and /etc/host, see section 7.a and 7.b
- Update the Ubuntu distro: 

Run in Shell:

	sudo apt-get update
	sudo apt-get dist-upgrade
	sync
	sudo shutdown -h now (or use Shutdown Button)
	wait for the led to turn off
	unplug the power DC
	wait a few seconds, and power the board again



Before you start downloading and flashing you should pay attention to this
--------------------------------------------------------------------------

- Read through all this document to understand the commands and the whole process,
  It may looks challenging but it is not.
- We need a linux box to flash the Image into SD CARD, i use LUbuntu 12.04 but could be any distro.
- Grab a good SD CARD (*), 80% of the issues you may have is due to counterfeit or bad sd card brand.
- SD/HC Card reader can also be a source of problems writing to a good SD CARD.
  (*) If you can be sure your SD card is fine and you still have problems, try using another SDHC card reader
- We need 8GB SD CARD, the OS Image fits in a 4GB but need more space as you will see.
- Get a good PSU with at least 2.5A (be on the safe side).
- Make sure you have HDMI (don't use HDMI to DVI if you can).
- Make sure HDMI is connected to the board very tight or you may experience some flickering or the image will not appear.

## BananaPI M64 Booting linux (click on the image to see the video)

[![Banana PI BPI-M64 Booting sequence](https://github.com/avafinger/bpi-m64-firmware/raw/master/img/0.jpg)](https://youtu.be/djdfH0kGODU)


Support for Leds (click on the image to see the video)

[![Banana PI BPI-M64 Led trigger](https://github.com/avafinger/bpi-m64-firmware/raw/master/img/0.jpg)](https://youtu.be/AWNq6apVGZQ)


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

1.  We need wget,md5sum and fdisk, install it if not already on your distro

            sudo apt-get install wget
            sudo apt-get install md5sum
            sudo apt-get install git

2.  Download the files entirely with git 

    a.  **In shell type (host PC):**

            git clone https://github.com/avafinger/bpi-m64-firmware
            cd bpi-m64-firmware


    b. Rebuild boot and rootfs and check MD5 (must match)

            cat rootfs.tar.gz.* > rootfs_m64_rc3.tar.gz
            md5sum rootfs_m64_rc3.tar.gz 
            e3d76d7f89e6150904150691031b6461  rootfs_m64_rc3.tar.gz

            wget https://github.com/avafinger/bpi-m64-firmware/raw/master/boot_m64_rc3.tar.gz
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


    Now you have SD card with kernel in it, you can now boot up bpi-m64 with this SD card and it will detect the eMMC:

  
            user: ubuntu
            pass: ubuntu



**OR**


3.  Download the files manually and check MD5

    a.  **In shell type (host PC):**

            mkdir -p m64
            cd m64
            wget https://github.com/avafinger/a64_bin/raw/master/ub-m64-sdcard.bin
            wget https://github.com/avafinger/a64_bin/raw/master/boot0.bin
            wget https://github.com/avafinger/bpi-m64-firmware/raw/master/flash_sd.sh
            wget https://github.com/avafinger/bpi-m64-firmware/raw/master/format_sd.sh



    b.  **Get the kernel and check MD5**

    Get the files using wget (wget the files in this order):


            wget https://github.com/avafinger/bpi-m64-firmware/raw/master/rootfs.tar.gz.000
            wget https://github.com/avafinger/bpi-m64-firmware/raw/master/rootfs.tar.gz.001
            wget https://github.com/avafinger/bpi-m64-firmware/raw/master/rootfs.tar.gz.002
            wget https://github.com/avafinger/bpi-m64-firmware/raw/master/rootfs.tar.gz.003
            wget https://github.com/avafinger/bpi-m64-firmware/raw/master/rootfs.tar.gz.004
            wget https://github.com/avafinger/bpi-m64-firmware/raw/master/rootfs.tar.gz.005
            wget https://github.com/avafinger/bpi-m64-firmware/raw/master/rootfs.tar.gz.006
            cat rootfs.tar.gz.* > rootfs_m64_rc3.tar.gz
            md5sum rootfs_m64_rc3.tar.gz 
            e3d76d7f89e6150904150691031b6461  rootfs_m64_rc3.tar.gz

            wget https://github.com/avafinger/bpi-m64-firmware/raw/master/boot_m64_rc3.tar.gz
            md5sum boot_m64_rc3.tar.gz 
            7867f40375fc993f10eaa21cff7843d6  boot_m64_rc3.tar.gz



    Alternatively you can use the browser to download the files and place the files in the m64 directory:


            Use the browser to download: 
            https://drive.google.com/open?id=0B7A7OPBC-aN7blVEcjk5aFppZG8
            or
            http://www.mediafire.com/file/gs3u9dq5x5jgbnf/boot_m64_rc3.tar.gz
            
            md5sum rootfs_m64_rc3.tar.gz 
            e3d76d7f89e6150904150691031b6461  rootfs_m64_rc3.tar.gz

            Use the browser to download: 
            https://drive.google.com/open?id=0B7A7OPBC-aN7RktMMHo5ekx3Znc
            or
            http://www.mediafire.com/file/88561scs78j7bq3/rootfs_m64_rc3.tar.gz

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

    Now you have SD card with kernel in it, you can now boot up bpi-m64 with this SD card and it will detect the eMMC:
  
            user: ubuntu
            pass: ubuntu

4.  Flashing eMMC (the git way)  

    a.  **In shell type (host PC):**

            git clone https://github.com/avafinger/bpi-m64-firmware
            cd bpi-m64-firmware



**OR mnually**


5.  Flashing eMMC (mannually)

    a.  **After you boot up with SD card, in shell type:**

            mkdir -p m64
            cd m64
            wget https://github.com/avafinger/a64_bin/raw/master/ub-m64-emmc.bin
            wget https://github.com/avafinger/a64_bin/raw/master/boot0.bin
            wget https://github.com/avafinger/bpi-m64-firmware/raw/master/flash_emmc.sh
            wget https://github.com/avafinger/bpi-m64-firmware/raw/master/format_emmc.sh


    b.  **Get the kernel and check MD5**

    Get the files using wget (wget the files in this order):


            wget https://github.com/avafinger/bpi-m64-firmware/raw/master/rootfs.tar.gz.000
            wget https://github.com/avafinger/bpi-m64-firmware/raw/master/rootfs.tar.gz.001
            wget https://github.com/avafinger/bpi-m64-firmware/raw/master/rootfs.tar.gz.002
            wget https://github.com/avafinger/bpi-m64-firmware/raw/master/rootfs.tar.gz.003
            wget https://github.com/avafinger/bpi-m64-firmware/raw/master/rootfs.tar.gz.004
            wget https://github.com/avafinger/bpi-m64-firmware/raw/master/rootfs.tar.gz.005
            wget https://github.com/avafinger/bpi-m64-firmware/raw/master/rootfs.tar.gz.006
            cat rootfs.tar.gz.* > rootfs_m64_rc3.tar.gz
            md5sum rootfs_m64_rc3.tar.gz 
            e3d76d7f89e6150904150691031b6461  rootfs_m64_rc3.tar.gz

            wget https://github.com/avafinger/bpi-m64-firmware/raw/master/boot_m64_rc3.tar.gz
            md5sum boot_m64_rc3.tar.gz 
            7867f40375fc993f10eaa21cff7843d6  boot_m64_rc3.tar.gz



    Alternatively you can use the browser to download the files and place the files in the m64 directory:


            Use the browser to download: 
            https://drive.google.com/open?id=0B7A7OPBC-aN7blVEcjk5aFppZG8
            or
            http://www.mediafire.com/file/gs3u9dq5x5jgbnf/boot_m64_rc3.tar.gz
            
            md5sum rootfs_m64_rc3.tar.gz 
            e3d76d7f89e6150904150691031b6461  rootfs_m64_rc3.tar.gz

            Use the browser to download: 
            https://drive.google.com/open?id=0B7A7OPBC-aN7RktMMHo5ekx3Znc
            or
            http://www.mediafire.com/file/88561scs78j7bq3/rootfs_m64_rc3.tar.gz

            md5sum boot_m64_rc3.tar.gz 
            7867f40375fc993f10eaa21cff7843d6  boot_m64_rc3.tar.gz


6.  Flash the OS Image

    a.  **Start flashing... (eMMC)**

            sudo chmod +x *.sh
            sudo ./format_emmc.sh
            sudo ./flash_emmc.sh

    If everything is OK you can now shutdown and boot up without the SD card.



If you find wrong or misleading information, please let me know and i will fix ASAP.


Updating Kernel to 3.10.104 / 3.10.105
--------------------------------------

You can update to the latest kernel with a fix for the **DIRTY COW** vulnerability
and some minor improvements on fs, overlays, camera AF, etc..

The update will be done manually as below:

1.  Update SD card with latest kernel 3.10.104 or 3.10.105

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



    c-1.  **Download the new kernel 3.10.104:**


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

    c-2.  **Download the new kernel 3.10.105:**


		mkdir -p m64
		cd m64
		wget https://github.com/avafinger/bpi-m64-firmware/raw/master/kernel_m64_rc5.tar.gz

		*check MD5SUM, must match this:*
		md5sum kernel_m64_rc5.tar.gz
		1aa7db42689cefe1324ba45797d6706d  kernel_m64_rc5.tar.gz

		*check MD5SUM, must match this:*
		wget https://github.com/avafinger/bpi-m64-firmware/raw/master/Image_kernel_3.10.105
		md5sum Image_kernel_3.10.105 
		cedde88fb3872b864c7f19e4b3eefa71  Image_kernel_3.10.105

		*check MD5SUM, must match this:*
		wget https://github.com/avafinger/bpi-m64-firmware/raw/master/a64-2GB.dtb_leds
		md5sum a64-2GB.dtb_leds
		bfda28581f2a87617fb32e1e5d9dd676  a64-2GB.dtb_leds


    d-1.  **Flash it to SD card:**

		
		Please, change the correct path to your /media/?/boot where ? may be your [USER]

		*note we need to backup Image in case something goes wrong*
		mv /media/boot/a64/Image /media/boot/a64/Image_kernel_3.10.102
		cp -vf Image_kernel_3.10.104 /media/boot/a64/Image
		sync

		sudo tar -xvpzf kernel_m64_rc3.tar.gz -C /media/rootfs/lib/modules --numeric-ow
		sync

    d-2.  **Flash it to SD card: (flashing 3.10.105 over 3.10.104)**

		
		Please, change the correct path to your /media/?/boot where ? may be your [USER]

		*note we need to backup Image in case something goes wrong*
		mv /media/boot/a64/Image /media/boot/a64/Image_kernel_3.10.104
		cp -vf Image_kernel_3.10.105 /media/boot/a64/Image
		sync

		sudo tar -xvpzf kernel_m64_rc5.tar.gz -C /media/rootfs/lib/modules --numeric-ow
		sync


    e.  **Update DTB to activate the Blue and Green Leds**

		
		Please, change the correct path to your /media/?/boot where ? may be your [USER]

		*note we need to backup in case something goes wrong*
		mv /media/boot/a64/a64-2GB.dtb /media/boot/a64/a64-2GB.dtb_old
		cp -vf a64-2GB.dtb_leds /media/boot/a64/a64-2GB.dtb
		sync



    f.  **If everything is correct, unmount your SD card and boot the bpi-m64 with the SD card**



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

**Update**: Kernel 3.10.105 has Touch already enabled

1.  Instructions (type in command from your HOST PC)

    a.  **Rename a64-2GB_LCD_TOUCH_OK.dtb to a64-2GB.dtb**


		mv /media/boot/a64/a64-2GB.dtb /media/boot/a64/a64-2GB.dtb_1080P
		cp -fv a64-2GB_LCD_TOUCH_PK.dtb /media/boot/a64/a64-2GB.dtb



    b.  **Edit and Add the Touch support**


		leafpad (or your editor) /media/rootfs/etc/modules
		add: ft5x_ts


	get ft5x_ts.ko and place it in the correct path:


 		wget https://github.com/avafinger/bpi-m64-firmware/raw/master/ft5x_ts.ko



	copy ft5x_ts.ko to your SD card:



		sudo mkdir -p /media/rootfs/lib/modules/3.10.104/kernel/drivers/input/touchscreen/ft5x
		sudo cp -vf ft5x_ts.ko /media/rootfs/lib/modules/3.10.104/kernel/drivers/input/touchscreen/ft5x/.



	update modules dep (only if kernel is not 3.10.105):


		sudo depmod



	load module ft5x_ts to make sure it is working:



		sudo modprobe ft5x_ts


        or add it to /etc/modules



	see if all modules has been loaded:
	lsmod


		Module                  Size  Used by
		ft5x_ts                76213  0
		rfcomm                 41308  12
		bnep                   18807  2
		ir_lirc_codec          13350  0
		lirc_dev               18895  1 ir_lirc_codec
		ir_mce_kbd_decoder     13330  0
		ir_sanyo_decoder       12869  0
		ir_rc6_decoder         12871  0
		ir_jvc_decoder         12811  0
		ir_sony_decoder        12786  0
		ir_rc5_decoder         12757  0
		ir_nec_decoder         12892  0
		sunxi_ir_rx            14684  0
		vfe_v4l2              773139  0
		ss                     45757  0
		cedar_ve               20392  0
		videobuf2_dma_contig    20233  1 vfe_v4l2
		videobuf2_memops       12600  1 videobuf2_dma_contig
		videobuf2_core         35245  1 vfe_v4l2
		ov5640                 55857  0
		dw9714_act             13373  0
		actuator               12412  1 dw9714_act
		vfe_io                 44013  3 vfe_v4l2,ov5640,dw9714_act
		hci_uart               31036  1
		bluetooth             217400  34 bnep,hci_uart,rfcomm
		bcmdhd                793075  0
		cfg80211              430729  1 bcmdhd


	copy ft5x_ts.ko to your eMMC:


		sudo mkdir -p /media/emmcrootfs/lib/modules/3.10.104/kernel/drivers/input/touchscreen/ft5x
		sudo cp -vf ft5x_ts.ko /media/emmcrootfs/lib/modules/3.10.104/kernel/drivers/input/touchscreen/ft5x/.



	update modules dep:


		sudo depmod



	load module ft5x_ts to make sure it is working:



		sudo modprobe ft5x_ts



	see if all modules has been loaded:
	lsmod


		Module                  Size  Used by
		ft5x_ts                76213  0
		rfcomm                 41308  12
		bnep                   18807  2
		ir_lirc_codec          13350  0
		lirc_dev               18895  1 ir_lirc_codec
		ir_mce_kbd_decoder     13330  0
		ir_sanyo_decoder       12869  0
		ir_rc6_decoder         12871  0
		ir_jvc_decoder         12811  0
		ir_sony_decoder        12786  0
		ir_rc5_decoder         12757  0
		ir_nec_decoder         12892  0
		sunxi_ir_rx            14684  0
		vfe_v4l2              773139  0
		ss                     45757  0
		cedar_ve               20392  0
		videobuf2_dma_contig    20233  1 vfe_v4l2
		videobuf2_memops       12600  1 videobuf2_dma_contig
		videobuf2_core         35245  1 vfe_v4l2
		ov5640                 55857  0
		dw9714_act             13373  0
		actuator               12412  1 dw9714_act
		vfe_io                 44013  3 vfe_v4l2,ov5640,dw9714_act
		hci_uart               31036  1
		bluetooth             217400  34 bnep,hci_uart,rfcomm
		bcmdhd                793075  0
		cfg80211              430729  1 bcmdhd


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

3.  Output mode is HDMI 1080p@60 , to change it to 720p you need to generate a new DTB
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


7.  How to play with the Leds (led1=Blue and led2=Green)

    a.  **LEDs Blue and Green are accessible in /sys/class/leds/**

            sudo cat /sys/class/leds/led1/trigger

    b.  **To disable or change the LED activity**

            sudo su (password: ubuntu)
            echo "none" > /sys/class/leds/led1/trigger

    c.  **To enable**

            echo "default-on" > /sys/class/leds/led1/trigger

    d.  **To trigger heartbeat again**

            echo "heartbeat" > /sys/class/leds/led1/trigger

8.  HDMI Digital sound output or Headphone JACK Analog stereo sound output

    a.  **Edit the file as below for JACK sound output**

            sudo leafpad /etc/asound.conf

    Write:

	pcm.!default {
	  type hw
	  card 1
	  device 0
	}
	ctl.!default {
	  type hw
	  card 1
	}
  

    b.  **Copy the file a64-2GB.dtb_analog_sound_output to /media/ubuntu/boot/a64/ a64-2GB.dtb**


    c.  **Edit the file /etc/modules and add**

		sunxi_codec
		sunxi_i2s
		sunxi_sndcodec
	

    **reboot**

    Install alsa-tools:

		sudo apt-get install alsa-tools

    Check the sound cards:

		aplay -l
	
		**** List of PLAYBACK Hardware Devices ****
		card 0: sndhdmi [sndhdmi], device 0: SUNXI-HDMIAUDIO sndhdmi-0 []
		  Subdevices: 1/1
		  Subdevice #0: subdevice #0
		card 1: audiocodec [audiocodec], device 0: SUNXI-CODEC codec-aif1-0 []
		  Subdevices: 1/1
		  Subdevice #0: subdevice #0
		card 1: audiocodec [audiocodec], device 1: bb Voice codec-aif2-1 []
		  Subdevices: 1/1
		  Subdevice #0: subdevice #0
		card 1: audiocodec [audiocodec], device 2: bb-bt-clk codec-aif2-2 []
		  Subdevices: 1/1
		  Subdevice #0: subdevice #0
		card 1: audiocodec [audiocodec], device 3: bt Voice codec-aif3-3 []
		  Subdevices: 1/1
		  Subdevice #0: subdevice #0


Troublehooting
--------------

1.  Nothing on my LCD/Monitor TV display

    a.  **Make sure the HDMI conector is well connected to the board**

    b.  **Make sure your LCD/Monitor TV is 1080P capable, the board will boot in HDMI 1080P mode only**

    c.  **Don't use DVI to HDMI**

    d.  **Press HDMI connector with your finger after boot and see you images pops up on screen**

2.  Moving windows on screen is slow

    **Install Metacity over OpenBox**

3.  Camera is not working

    a.  **Make sure you connect the sensor**

    b.  **The camera connector at the board side is really horrible, you need to make sure the FPC cable touch the contacts (They should change it on next board revision)**

    c. **Make sure you have the correct DTB (Device Tree Blob) with camera enabled, please note the a64-2GB.dtb_leds has camera disbled to allow full Leds control

4.  Board does not boot

    a.  **Watch for some signs during normal boot**

        - Wait a few seconds, BROM waits for FEL button and then proceed loading
        
        - Mouse should blink twice

        - Ethernet led connector will blink and show some activities after login

        - Your monitor will switch to HDMI 1080p

        - Led Blue will show a heartbeat activitiy and Green Led will light when eMMC is in use (kernel 3.10.105 only)


    b.  **If you don't see any of this signs during boot, you most likely have run into the following**

        - Bad SD card even if does not show bad track or errors, try with another brand and size

        - PSU Under power or under voltage, use a good PSU, at least 2.5A and 5v output guarantee (**DCIN**)


    c.  **Check for SD card integrity**

        unmount the SD CARD fisrt: 
        sudo umount /dev/sdX (where X is your SD card letter [b,c..])
        sudo fsck.vfat -a /dev/sdX1 (where X is your SD card letter [b,c..])
        sudo fsck.ext4 -f /dev/sdX2  (where X is your SD card letter [b,c..])


    d. **DO NOT** Power the board with microUSB, use the DCIN (power barrel)



**Have i missed something or you found wrong or improper information/language grammar or spelling?**

    Just let me know and i fix it ASAP

    
*** WIP ***

History Log:
===========
* initial commit (readme file)
* created on 26/01/2017
* fix readme (wip)
* readme with instructions (wip)
* Add support for LCD 7" and Touch
* support for Leds