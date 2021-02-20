#!/usr/bin/env bash
set -e

if [ $# -eq 1 ]; then
    if [ $1 = "caslcomet" ]; then
        if (type "casl2" > /dev/null 2>&1) && (type "comet2" > /dev/null 2>&1); then
            echo "The CASLII/COMETII simulator is already installed, and nothing has been changed."
        else
            echo "Installing the CASLII/COMETII simulator (Osaka University)..."
            cd ~
            curl -fLO https://www-hasegawa.ist.osaka-u.ac.jp/~ykoizumi/lecture/fco/files/casl2-2017-11-16.zip
            unzip casl2-2017-11-16.zip
            cd casl2-2017-11-16
            chmod +x casl2 comet2
            sudo mv casl2 comet2 /usr/local/bin/
            cd ..
            rm -rf casl2-2017-11-16.zip casl2-2017-11-16
            echo "The Installation Completed."
        fi
    elif [ $1 = "brain" ]; then
        if !(grep -Fq "deb [trusted=yes] https://max.kellermann.name/debian cegcc_buster-default main" "/etc/apt/sources.list"); then
            echo "Registering the repository of CeGCC..."
            sudo bash -c 'echo >> /etc/apt/sources.list'
            sudo bash -c 'echo "deb [trusted=yes] https://max.kellermann.name/debian cegcc_buster-default main" >> /etc/apt/sources.list'
        fi
        echo "Installing packages for SHARP Brain developments..."
        sudo apt update
        sudo apt install gcc-arm-mingw32ce gcc-arm-linux-gnueabi bison flex libncurses5-dev libssl-dev debootstrap qemu-user-static
        echo "The Installation Completed."
    else
        echo "No such option: $1"
    fi
elif [ $# -eq 0 ]; then
    echo "Installing essential packages..."
    sudo apt update
    sudo apt install git curl zip unzip gawk vim build-essential exfat-fuse exfat-utils xsel peco
    echo "Setting up the Git..."
    echo -n "Your email address: "; read email
    git config --global user.email ${email}
    echo -n "Your name: "; read name
    git config --global user.name ${name}
    git config --global color.ui true
    git config --global core.quotepath false
    echo "The Initialization Completed."
else
    echo "Error: The number of options must be 0 or 1."
fi
