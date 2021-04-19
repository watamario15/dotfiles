#!/usr/bin/env bash

# Manually expand the system partition before running this script!

set -e
echo -n "Enter the SD path: "; read sd
sudo cp $(which casl2) $(which comet2) $(which fontify) swap.sh usbg.sh ${sd}/usr/local/bin/
cp .bashrc .nanorc .vimrc .fbtermrc .uim ${sd}/home/user/
sudo dd if=/dev/zero of=${sd}/swapfile bs=1M count=1024
sudo chmod 0600 ${sd}/swapfile
sudo chroot $sd

# Manually run:
# apt install zip unzip xsel peco
