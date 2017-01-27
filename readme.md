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
- HDMI 720P / 1080P
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
- @lex (Alexander Finger)


This Image is intended to run with other A64 boards with or without eMMC just by updating the Device Tree Blob with specific settings for different board.

Things that work with this Image
--------------------------------

- Firefox
- Guvcview
- MJPG-streamer
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
- Get a good PSU with at least 2.5A (be in the safe side).
- Make sure you have HDMI (don't use HDMI to DVI if you can).
- Make sure HDMI is connected to the board very tight or you may experience some flickering or the image will not appear.


Screenshots
-----------

![bluetooth](https://github.com/avafinger/bpi-m64-firmware/raw/master/img/bluetooth.png)


![bluetooth](https://github.com/avafinger/bpi-m64-firmware/raw/master/img/wifi.png)

Installation
------------

### Option 1: Manual installation



### Option 2: Semi automated installation

*** WIP ***

History Log:
===========
* initial commit (readme file)
* created on 26/01/2017
