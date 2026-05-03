#!/usr/bin/env bash
set -euo pipefail

echo "Make sure that you've manually expanded the rootfs partition before running this script!"

echo "Remounting the rootfs SD card with dev enabled..."
echo "== Found rootfs devices =="
mount | grep rootfs
read -rp "Target rootfs in device ID (ex. sdb2): " sd
sudo mount -o remount,dev "/dev/${sd}"
read -rp "Target rootfs in full path without the trailing slash (ex. /run/media/user/rootfs): " sd

echo "Copying files..."
sudo cp "$(which fontify)" "${sd}/usr/local/bin/"
cp ../rc.sh ../.nanorc .vimrc .fbtermrc .uim "${sd}/home/user/"
echo "if [ -f ~/rc.sh ]; then
    . ~/rc.sh
fi" >> "${sd}/home/user/.bashrc"

echo "Setting up swap..."
sudo dd if=/dev/zero "of=${sd}/swapfile" bs=1M count=4096
sudo chmod 0600 "${sd}/swapfile"
sudo mkswap "${sd}/swapfile"
sudo tee -a "${sd}/etc/fstab" << EOF
/swapfile  none   swap    defaults   0 0
EOF

echo "Updating installed packages and adding essential packages..."
sudo chroot "$sd" << EOF
apt update
apt upgrade -y
apt install gdb zip unzip xsel peco -y
EOF
