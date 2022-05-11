#!/usr/bin/env bash
set -e

echo "Make sure that you've manually expanded the rootfs partition before running this script!"
echo -n "Enter the SD path (without the last slash): "; read sd
sudo cp $(which casl2) $(which comet2) $(which fontify) swap usbg ${sd}/usr/local/bin/
cp .bashrc .nanorc .vimrc .fbtermrc .uim ${sd}/home/user/
sudo dd if=/dev/zero of=${sd}/swapfile bs=1M count=4096
sudo chmod 0600 ${sd}/swapfile
sudo mkswap ${sd}/swapfile
sudo chroot $sd << EOF
apt update
apt dist-upgrade -y
apt install -y gdb zip unzip xsel peco
echo "/swapfile  none   swap    defaults   0 0" >> /etc/fstab
sed -ie "s%PATH=\"/usr/local/bin:/usr/bin:/bin:/usr/games:/usr/local/games\"%PATH=\"/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games\"%" /etc/profile
EOF
