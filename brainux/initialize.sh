#!/usr/bin/env bash
set -e

echo "Make sure that you've manually expanded the rootfs partition before running this script!"
echo -n "Enter the SD path (without the last slash): "; read sd
sudo cp $(which casl2) $(which comet2) $(which fontify) swap.sh usbg.sh ${sd}/usr/local/bin/
cp .bashrc .nanorc .vimrc .fbtermrc .uim ${sd}/home/user/
sudo dd if=/dev/zero of=${sd}/swapfile bs=1M count=4096
sudo chmod 0600 ${sd}/swapfile
sudo mkswap ${sd}/swapfile
sudo chroot $sd << EOF
apt install -y zip unzip xsel peco
echo "/swapfile  swap   swap    defaults   0 0" >> /etc/fstab
EOF
