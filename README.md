# Kikkeri-app

A client application for a [kikkeri][] server. Intended to be used on a Raspberry Pi 3 with the official touchscreen. The recommended setup is running the archlinuxarm on top of EGL with no X server.

## Installation

1. Install archlinuxarm on an SD card according to the [instructions][archlinuxarm-rpi3]
1. Boot the Pi and log in as root
1. Configure networking with `wifi-menu` and `netctl` if necessary
1. Upgrade and install relevant packages

    ```bash
    pacman -Syu base-devel qt5-base qt5-tools qt5-virtualkeyboard qt5-declarative qt5-quickcontrols2 ttf-dejavu qml-material git
    ```

1. Edit `/boot/config.txt`

    ```ini
    gpu_mem=256
    dtoverlay=vc4-kms-v3d
    lcd_rotate=2
    ```

1. Edit `/etc/modules-load.d/raspberrypi.conf`

    ```text
    snd-bcm2835
    vc4
    ```

1. Create a backlight control group and add your user to it

    ```bash
    groupadd backlight
    groupmems -g backlight -a alarm
    ```

1. Set the following commands to happen at boot, for example with a oneshot systemd unit

    ```bash
    chgrp backlight /sys/class/backlight/rpi_backlight/bl_power
    chmod g+w /sys/class/backlight/rpi_backlight/bl_power
    ```

1. Reboot
1. Clone this repo

    ```bash
    git clone https://github.com/bzar/kikkeri-app
    cd kikkeri-app
    ```

1. Edit `qml/config.js` variable `SITE_URL` to point to your [kikkeri][] instance
1. Compile

    ```bash
    qmake
    make -j4
    ```

1. Try running the application on EGL

    ```bash
    ./kikkeri-app -platform eglfs
    ```

You can close the application with the keyboard shortcut Ctrl-M or by sending it SIGTERM.

Now use regular systemd methods to make the application start on startup.

## Development

1. Install the same (for your environment) packages as on the Pi
1. Open the `.pro` file with QtCreator
1. You should be able to just edit and run the application on your desktop

[kikkeri]: https://github.com/bzar/kikkeri
[archlinuxarm-rpi3]: https://archlinuxarm.org/platforms/armv8/broadcom/raspberry-pi-3
