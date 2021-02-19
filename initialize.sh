#!/usr/bin/env bash
set -e

if [ $# -eq 1 ]; then
    elif [ $1 = "caslcomet" ]; then
        cd ~
        curl -fLO https://www-hasegawa.ist.osaka-u.ac.jp/~ykoizumi/lecture/fco/files/casl2-2017-11-16.zip
        unzip casl2-2017-11-16.zip
        cd casl2-2017-11-16
        chmod +x casl2 comet2
        sudo mv casl2 comet2 /usr/local/bin/
        cd ..
        rm -rf casl2-2017-11-16.zip casl2-2017-11-16
    elif [ $1 = "brain" ]; then
        sudo bash
        echo >> /etc/apt/sources.list
        echo "deb [trusted=yes] https://max.kellermann.name/debian cegcc_buster-default main" >> /etc/apt/sources.list
        exit
        sudo apt update
        sudo apt install gcc-arm-mingw32ce gcc-arm-linux-gnueabi bison flex libncurses5-dev libssl-dev debootstrap qemu-user-static
    fi
else
    sudo apt install git curl gawk vim build-essential exfat-fuse exfat-utils xsel peco
    echo "Setting up the Git..."
    echo -n "Your email address: "; read email
    git config --global user.email ${email}
    echo -n "Your name: "; read name
    git config --global user.name ${name}
    git config --global color.ui true
    git config --global core.quotepath false
fi
