#!/usr/bin/env bash

# Manually expand the system partition before running this script!

set -e
echo "Enter the SD path: "; read sd
sudo cp $(type casl2 | gawk '{print $3}') $(type comet2 | gawk '{print $3}') ${sd}/usr/local/bin/
sudo cp .bashrc .nanorc .vimrc swap.sh usbg.sh ${sd}/root
sudo chroot $sd

# Manually run:
# apt install zip unzip gawk exfat-fuse exfat-utils xsel peco
# echo -e 'Section "Device"\n        Identifier "device"\n        Driver     "fbdev"\nEndSection\nSection "Screen"\n        Identifier "screen"\n        Device     "device"\nEndSection' > /etc/X11/xorg.conf
