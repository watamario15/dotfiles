#!/usr/bin/env bash
set -e
wd=$(cd `dirname $0`; pwd) # where this dotfiles directory exists

if [ $# -eq 1 ]; then
    if [ $1 = "caslcomet" ]; then
        if (type "casl2" > /dev/null 2>&1) && (type "comet2" > /dev/null 2>&1); then
            echo "The CASLII/COMETII simulator is already installed, and nothing has been changed."
        else
            echo "Installing the CASLII/COMETII simulator (Osaka University)..."
            cd
            curl -fLO https://www-hasegawa.ist.osaka-u.ac.jp/~ykoizumi/lecture/fco/files/casl2-2017-11-16.zip
            unzip -oq casl2-2017-11-16.zip
            cd casl2-2017-11-16
            chmod +x casl2 comet2
            sudo mv casl2 comet2 /usr/local/bin/
            cd ..
            rm -rf casl2-2017-11-16.zip casl2-2017-11-16
            echo "Done."
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
        sudo apt install -y gcc-arm-mingw32ce qemu-user-static
        echo "Done."

    elif [ $1 = "xtbook" ]; then
        echo "Installing packages..."
        sudo apt install -y mecab-ipadic libmecab2 libkakasi2 imagemagick libmecab-dev libkakasi2-dev libxml2-dev liblzma-dev

        echo "Setting up MkXTBWikiplexus..."
        curl -fL https://github.com/yvt/xtbook/releases/download/v0.2.6/MkXTBWikiplexus-R3.tar.gz | tar zxvf -
        sudo sed -i -e 's/gets(buf)/scanf("%s",buf)!=EOF/' MkXTBWikiplexus/MkImageComplex/main.cpp
        sudo sed -i -e 's/-liconv //' MkXTBWikiplexus/build.unix/Makefile
        cd MkXTBWikiplexus/build.unix
        make
        sudo apt remove -y libmecab-dev libkakasi2-dev libxml2-dev liblzma-dev

        cd ${wd}
        sudo cp tools/XTBook /usr/local/bin/
        sudo chmod +x /usr/local/bin/XTBook
        while true; do
            echo -n "Your dictionary path: "; read dict
            echo -n "7-Zip flag: "; read flag
            echo -n "Correct (DICTDIR: ${dict}, 7ZFLAG: ${flag}) [Y/n]? "; read key
            if [ "$key" != "n" ]; then
                break
            fi
        done
        echo "export DICTDIR=${dict}" >> ~/.bash_profile
        echo "export MKXTBDIR=${HOME}/MkXTBWikiplexus/build.unix" >> ~/.bash_profile
        echo "export PLIST=${wd}/tools/info-plists" >> ~/.bash_profile
        echo "export 7ZFLAG=${flag}" >> ~/.bash_profile
        echo "Done."

    else
        echo "No such option: $1"
    fi

elif [ $# -eq 0 ]; then
    echo "Installing essential packages..."
    sudo apt update
    sudo apt install -y git-lfs curl wget zip unzip bzip2 gawk vim build-essential gdb mingw-w64 xsel peco
    curl -sfL https://www.7-zip.org/a/7z2201-linux-x64.tar.xz | sudo tar Jxfp - -C /usr/local/bin
    sudo curl -fL https://github.com/puhitaku/rcs/raw/master/scripts/fontify -o /usr/local/bin/fontify
    sudo chmod +x /usr/local/bin/fontify
    echo "Setting up Git..."
    while true; do
        echo -n "Your email address: "; read email
        echo -n "Your name: "; read name
        echo -n "Correct (email: ${email}, name: ${name}) [Y/n]? "; read key
        if [ "$key" != "n" ]; then
            break
        fi
    done
    cp .gitconfig ~/
    git config --global user.email ${email}
    git config --global user.name ${name}
    git config --global color.ui true
    git config --global core.quotepath false
    echo "The Initialization Completed."

else
    echo "Error: The number of options must be 0 or 1."
fi
