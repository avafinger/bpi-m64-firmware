Banana Pi M64 Ubuntu Xenial Xerus 16.04 LXDE OS Image (firmware)
================================================================

LXDE (Lightweight X11 Desktop Environment) is a desktop environment which is lightweight 
and fast and uses less RAM and less CPU while being a feature rich desktop environment.

If you want a richer desktop environment (but slower) you can install 
Ubuntu MATE on top of this Image and later de-install LXDE.

I use LXDE just because it is very fast, snappy  and responsive!
You can always improve, tweak and tune the way you want at any time.
This is a very LEAN and MEAN OS image to play and learn how to extend it.


     **NEW KERNEL and Better HW configuration**

This is a preliminary LXDE OS image for the Banana Pi M64 with fully working
----------------------------------------------------------------------------

- eMMC
- Wifi
- BT (bluetooth)
- OV5640 (camera)
- HDMI 1080P / HDMI 720P
- HDMI digital sound output / JACK analog stereo sound output (fixed)
- GbE (Gigabit ethernet)
- LEDs (Red, Blue and Green)
- Support for HW decoding (cedrus H264) - https://github.com/avafinger/cedrusH264_vdpau_A64


This OS image is based on the works and ideas of
-------------------------------------------------

- Bpi-tools (https://github.com/BPI-SINOVOIP/bpi-tools)
- Longsleep's kernel 3.10.105 / Bpi sdk-dtb
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
- HDMI sound output/ Jack analog sound output
- Cedrus H264 Hardware Decoding (https://github.com/avafinger/cedrusH264_vdpau_A64)
- ssh
- Very low load average with Desktop usage and idle

	ubuntu@bpi-m64:~$ uptime
 	08:33:37 up 11:16,  2 users,  load average: 0,02, 0,08, 0,12


Not included in OS Image
------------------------

- 3D Mali acceleration
- Firefox with HW acceleration
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


**Update Wifi firmware for new boards with A1 chip**

- new board revision seems to have Wifi with A1 chip, **firmware update is needed**
- How do i know if my wifi is A1?
  It is written on the chip, but if Wifi and BT is not working and your board is new **update**!
- check if you have **update_wifi_bt.sh**, if not type in Shell:

        wget https://raw.githubusercontent.com/avafinger/bpi-m64-firmware/master/update_wifi_bt.sh

- Now run the script to update the firmware and Wifi/BT service

        sudo chmod +x *.sh
        sudo ./update_wifi_bt.sh
        sync
        sudo reboot


**Fix**
- The eMMC boot label conflits with SDCARD boot label with previous image, to fix this, type:

       sudo e2label /dev/mmcblk1p1 emmcboot
 
- Script to automate the changing HDMI from 720p to 1080p and vice-ersa
  Download the script and put it on /media/ubuntu/boot/a64 and /media/ubuntu/emmcboot/a64

        wget https://raw.githubusercontent.com/avafinger/bpi-m64-firmware/master/set-hdmi-res.sh
        sudo cp -a set-hdmi-res.sh /media/ubuntu/boot/a64/.
        sudo cp -a set-hdmi-res.sh /media/ubuntu/emmcboot/a64/.

  then run the script from ././a64/ and chose which HDMI screen resolution for your next boot.

        sudo chmod +x *.sh
        sudo ./set-hdmi-res.sh


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


Fixes
-----

- HDMI sound and JACK sound


OS Image default
----------------

- Camera OV5640
- HDMI 1280x720 (720p) - HD
- DHCP on GbE	



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

Flashing SD CARD
----------------

1.  We need wget,md5sum and fdisk, please install this packages on your distro if not already installed

            sudo apt-get install wget
            sudo apt-get install md5sum
            sudo apt-get install git

2.  Download the files entirely with git 

    a.  **In shell type (host PC):**

            git clone https://github.com/avafinger/bpi-m64-firmware
            cd bpi-m64-firmware


    b. Rebuild boot and rootfs and check MD5 (must match)

            cat rootfs_m64_a64_rc1.tar.gz.* > rootfs_m64_a64_rc1.tar.gz
            md5sum rootfs_m64_a64_rc1.tar.gz 
            a97aecc11ad55bdb0c9e6aabace86056  rootfs_m64_a64_rc1.tar.gz

            md5sum boot_m64_a64_rc1.tar.gz
            419c74cd6be0533ef31eaa6e6175697d  boot_m64_a64_rc1.tar.gz


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
            sudo ./burn_sdcard.sh /dev/sdc


    Now you have SD card with kernel in it, you can now boot up bpi-m64 with this SD card and it will detect the eMMC:

  
            user: ubuntu
            pass: ubuntu



**OR**


3.  Download the files manually and check MD5

    a.  **In shell type (host PC):**

            mkdir -p m64
            cd m64
            wget https://github.com/avafinger/bpi-m64-firmware/raw/master/ub-m64-emmc.bin
            wget https://github.com/avafinger/bpi-m64-firmware/raw/master/ub-m64-sdcard.bin
            wget https://github.com/avafinger/bpi-m64-firmware/raw/master/boot_m64_a64_rc1.tar.gz
            wget https://github.com/avafinger/bpi-m64-firmware/raw/master/burn_emmc.sh
            wget https://github.com/avafinger/bpi-m64-firmware/raw/master/burn_sdcard.sh


    b.  **Get the kernel and check MD5**

    Get the files using wget (wget the files in this order):


            wget https://github.com/avafinger/bpi-m64-firmware/raw/master/rootfs_m64_a64_rc1.tar.gz.000
            wget https://github.com/avafinger/bpi-m64-firmware/raw/master/rootfs_m64_a64_rc1.tar.gz.001
            wget https://github.com/avafinger/bpi-m64-firmware/raw/master/rootfs_m64_a64_rc1.tar.gz.002
            wget https://github.com/avafinger/bpi-m64-firmware/raw/master/rootfs_m64_a64_rc1.tar.gz.003
            wget https://github.com/avafinger/bpi-m64-firmware/raw/master/rootfs_m64_a64_rc1.tar.gz.004
            wget https://github.com/avafinger/bpi-m64-firmware/raw/master/rootfs_m64_a64_rc1.tar.gz.005
            wget https://github.com/avafinger/bpi-m64-firmware/raw/master/rootfs_m64_a64_rc1.tar.gz.006
            wget https://github.com/avafinger/bpi-m64-firmware/raw/master/rootfs_m64_a64_rc1.tar.gz.007

            cat rootfs_m64_a64_rc1.tar.gz.* > rootfs_m64_a64_rc1.tar.gz
            md5sum rootfs_m64_a64_rc1.tar.gz 
            419c74cd6be0533ef31eaa6e6175697d  boot_m64_a64_rc1.tar.gz

            md5sum boot_m64_a64_rc1.tar.gz
            419c74cd6be0533ef31eaa6e6175697d  boot_m64_a64_rc1.tar.gz



**Alternatively** 

4.  You can use the [Clone or download] green button to download the ZIP file and UnZip it.

            cd bpi-m64-firmware-master
            cat rootfs_m64_a64_rc1.tar.gz.* > rootfs_m64_a64_rc1.tar.gz
            md5sum rootfs_m64_a64_rc1.tar.gz 
            419c74cd6be0533ef31eaa6e6175697d  boot_m64_a64_rc1.tar.gz

            md5sum boot_m64_a64_rc1.tar.gz
            419c74cd6be0533ef31eaa6e6175697d  boot_m64_a64_rc1.tar.gz




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
            sudo ./burn_sdcard.sh /dev/sdc

    Now you have SD card with kernel in it, you can now boot up bpi-m64 with this SD card and it will detect the eMMC:
  
            user: ubuntu
            pass: ubuntu



Flashing eMMC
-------------

1.  Using git

    a.  **In shell type (after you boot bpi-m64 with SD CARD):**

            git clone https://github.com/avafinger/bpi-m64-firmware
            cd bpi-m64-firmware


    b. Rebuild boot and rootfs and check MD5 (must match)

            cat rootfs_m64_a64_rc1.tar.gz.* > rootfs_m64_a64_rc1.tar.gz
            md5sum rootfs_m64_a64_rc1.tar.gz 
            a97aecc11ad55bdb0c9e6aabace86056  rootfs_m64_a64_rc1.tar.gz

            md5sum boot_m64_a64_rc1.tar.gz
            419c74cd6be0533ef31eaa6e6175697d  boot_m64_a64_rc1.tar.gz

    c.  **Start flashing eMMC... (Warning, make sure you get the correct device or you may WIPE your HDD)**


            sudo chmod +x *.sh
            sudo ./burn_emmc.sh


**OR mnually**


2.  Flashing eMMC (mannually)

    a.  **After you boot up with SD card, in shell type:**

            mkdir -p m64
            cd m64
            wget https://github.com/avafinger/bpi-m64-firmware/raw/master/ub-m64-emmc.bin
            wget https://github.com/avafinger/bpi-m64-firmware/raw/master/ub-m64-sdcard.bin
            wget https://github.com/avafinger/bpi-m64-firmware/raw/master/boot_m64_a64_rc1.tar.gz
            wget https://github.com/avafinger/bpi-m64-firmware/raw/master/burn_emmc.sh
            wget https://github.com/avafinger/bpi-m64-firmware/raw/master/burn_sdcard.sh
            wget https://github.com/avafinger/bpi-m64-firmware/raw/master/rootfs_m64_a64_rc1.tar.gz.000
            wget https://github.com/avafinger/bpi-m64-firmware/raw/master/rootfs_m64_a64_rc1.tar.gz.001
            wget https://github.com/avafinger/bpi-m64-firmware/raw/master/rootfs_m64_a64_rc1.tar.gz.002
            wget https://github.com/avafinger/bpi-m64-firmware/raw/master/rootfs_m64_a64_rc1.tar.gz.003
            wget https://github.com/avafinger/bpi-m64-firmware/raw/master/rootfs_m64_a64_rc1.tar.gz.004
            wget https://github.com/avafinger/bpi-m64-firmware/raw/master/rootfs_m64_a64_rc1.tar.gz.005
            wget https://github.com/avafinger/bpi-m64-firmware/raw/master/rootfs_m64_a64_rc1.tar.gz.006
            wget https://github.com/avafinger/bpi-m64-firmware/raw/master/rootfs_m64_a64_rc1.tar.gz.007



     b.  **Rebuild kernel and check integrity, type:**

            cat rootfs_m64_a64_rc1.tar.gz.* > rootfs_m64_a64_rc1.tar.gz
            md5sum rootfs_m64_a64_rc1.tar.gz 
            419c74cd6be0533ef31eaa6e6175697d  boot_m64_a64_rc1.tar.gz

            md5sum boot_m64_a64_rc1.tar.gz
            419c74cd6be0533ef31eaa6e6175697d  boot_m64_a64_rc1.tar.gz


     c.  **Start flashing eMMC... (Warning, make sure you get the correct device or you may WIPE your HDD)**


            sudo chmod +x *.sh
            sudo ./burn_emmc.sh


    
     **If everything is OK you can now shutdown and boot up without the SD card.**



Initial setup
-------------

1.  DHCP is activated by default

2.  Eth0 is setup for DHCP, if you connect using Wifi and later wish to get back
    to DHCP you must issue a ifdown and ifup command to renew DHCP.

3.  Output mode is HDMI 720@60 , to change it to 1080p you need to to re-create the symlink


                cd /media/ubuntu/boot/a64
                sudo rm m64.dtb
                sudo ln -s m64.dtb_1080p m64.dtb
                sync
                sudo reboot



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

    Write or Change accordingly:

		pcm.!default {
		  type hw
		  card 1
		  device 0
		}
		ctl.!default {
		  type hw
		  card 1
		}
  

    b.  **reboot**



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

    Partition is **ext4**, FAT32 has been dropped!

        unmount the SD CARD fisrt: 
        sudo umount /dev/sdX (where X is your SD card letter [b,c..])
        sudo fsck.ext4 -f /dev/sdX1 (where X is your SD card letter [b,c..])
        sudo fsck.ext4 -f /dev/sdX2  (where X is your SD card letter [b,c..])


    d.  **Check for eMMC integrity**

    Partition is **ext4**, FAT32 has been dropped!

    Boot board from SD CARD, unmount eMMC and do a fsck, like so:

        sudo umount /media/ubuntu/boot
        sudo umount /media/ubuntu/boot
        sudo fsck.ext4 -f /dev/sdX1 (where X is your SD card letter [b,c..])
        sudo fsck.ext4 -f /dev/sdX2  (where X is your SD card letter [b,c..])
     
    e. **DO NOT** Power the board with microUSB, use the DCIN (power barrel)


  
*** WIP ***

History Log:
===========
* initial commit (readme file)
* created on 26/01/2017
* fix readme (wip)
* readme with instructions (wip)
* support for Leds
* Fix for codec on DTB (another attempt)
* HW decoding (deb files on another repo)
* New kernel with better configuration
- Fix eMMC label name
- Create a script to automate changing HDMI resolution to 720p or 1080p
