#!/usr/bin/env bash
set -e

if [ $# -eq 1 ]; then
    if [ $1 = "caslcomet" ]; then
        if (type "casl2" > /dev/null 2>&1) && (type "comet2" > /dev/null 2>&1); then
            echo "The CASLII/COMETII simulator is already installed, and nothing has been changed."
        else
            echo "Installing the CASLII/COMETII simulator (Osaka University)..."
            cd
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
            sudo sh -c 'echo >> /etc/apt/sources.list'
            sudo sh -c 'echo "deb [trusted=yes] https://max.kellermann.name/debian cegcc_buster-default main" >> /etc/apt/sources.list'
        fi
        sudo cp tools/CeGCC /usr/local/bin/
        sudo chmod +x /usr/local/bin/CeGCC
        echo "Installing packages for SHARP Brain developments..."
        sudo apt update
        sudo apt install -y gcc-arm-mingw32ce gcc-arm-linux-gnueabi bison flex libncurses5-dev libssl-dev debootstrap qemu-user-static
        echo "The Installation Completed."

    elif [ $1 = "xtbook" ]; then
        echo "Installing packages..."
        sudo apt install -y mecab libmecab-dev mecab-ipadic-utf8 kakasi libkakasi2-dev libxml2-dev liblzma-dev

        echo "Setting up mecab-ipadic-neologd..."
        cd
        git clone --depth 1 "https://github.com/neologd/mecab-ipadic-neologd.git"
        cd mecab-ipadic-neologd
        echo "yes" | ./bin/install-mecab-ipadic-neologd -n -a
        sudo sed -i -e "s%^dicdir.*%dicdir = `mecab-config --dicdir`/mecab-ipadic-neologd%" `mecab-config --sysconfdir`/mecabrc

        echo "Setting up libiconv..."
        cd /usr/src
        sudo wget https://ftp.gnu.org/gnu/libiconv/libiconv-1.14.tar.gz -O - | sudo tar zxvf -
        cd libiconv-1.14
        sudo sed -i -e 's%_GL_WARN_ON_USE (gets%//_GL_WARN_ON_USE (gets%' srclib/stdio.in.h
        sudo ./configure
        sudo make
        sudo make install
        sudo sh -c 'echo "/usr/local/lib" >> /etc/ld.so.conf'
        sudo ldconfig

        echo "Setting up MkXTBWikiplexus..."
        cd
        sudo rm -rf /usr/src/libiconv-1.14
        wget https://github.com/yvt/xtbook/releases/download/v0.2.6/MkXTBWikiplexus-R3.tar.gz -O - | tar zxvf -
        cd MkXTBWikiplexus/build.unix
        sudo sed -i -e 's%gets(buf)%scanf("%s",buf)!=EOF%' MkXTBWikiplexus/MkImageComplex/main.cpp
        make

    else
        echo "No such option: $1"
    fi

elif [ $# -eq 0 ]; then
    echo "Installing essential packages..."
    sudo apt update
    sudo apt install -y git-lfs curl wget zip unzip gawk vim build-essential exfat-fuse exfat-utils xsel peco
    sudo curl -fL https://raw.githubusercontent.com/puhitaku/rcs/master/scripts/fontify -o /usr/local/bin/fontify
    sudo chmod +x /usr/local/bin/fontify
    echo "Setting up Git..."
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
