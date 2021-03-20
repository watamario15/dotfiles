#!/usr/bin/env bash

# Manually expand the system partition before running this script!

set -e
echo "Enter the SD path: "; read sd
sudo cp $(which casl2) $(which comet2) $(which fontify) ${sd}/usr/local/bin/
sudo cp .bashrc .nanorc .vimrc .fbtermrc .uim swap.sh usbg.sh ${sd}/root
sudo chroot $sd

# Manually run:
# apt install zip unzip gawk exfat-fuse exfat-utils xsel peco fbterm uim-fep uim-anthy
# echo -e 'Section "Device"\n        Identifier "device"\n        Driver     "fbdev"\nEndSection\nSection "Screen"\n        Identifier "screen"\n        Device     "device"\nEndSection' > /etc/X11/xorg.conf
