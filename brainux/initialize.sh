#!/usr/bin/env bash
set -euo pipefail

echo "Make sure that you've manually expanded the rootfs partition before running this script!"

echo "Remounting the SD with dev enabled..."
echo "rootfs devices:"
mount | grep rootfs
read -rp "Enter the SD rootfs device (ex. sdb2): " sd
sudo mount -o remount,dev "/dev/${sd}"
mount | grep rootfs

read -rp "Enter the SD rootfs full path (without the last slash): " sd

echo "Copying files..."
sudo cp "$(which casl2)" "$(which comet2)" "$(which fontify)" swap usbg "${sd}/usr/local/bin/"
cp ../.bashrc ../.nanorc .vimrc .fbtermrc .uim "${sd}/home/user/"

echo "Creating a swap file..."
sudo dd if=/dev/zero "of=${sd}/swapfile" bs=1M count=4096
sudo chmod 0600 "${sd}/swapfile"
sudo mkswap "${sd}/swapfile"

echo "chroot-ing into the SD rootfs to complete the initialization..."
sudo chroot "$sd" << EOF
apt update
apt dist-upgrade -y
apt install gdb zip unzip xsel peco -y
echo "/swapfile  none   swap    defaults   0 0" >> /etc/fstab
EOF
