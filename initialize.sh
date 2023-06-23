#!/usr/bin/env bash
set -e
wd=$(cd "$(dirname "$0")"; pwd) # where this dotfiles directory exists

if [ $# -eq 1 ]; then
  if [ "$1" = "caslcomet" ]; then
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

  elif [ "$1" = "brain" ]; then
    if ! (grep -Fq "deb [trusted=yes] https://max.kellermann.name/debian cegcc_buster-default main" "/etc/apt/sources.list"); then
      echo "Registering the repository of CeGCC..."
      sudo sh -c 'echo "
deb [trusted=yes] https://max.kellermann.name/debian cegcc_buster-default main" >> /etc/apt/sources.list'
    fi
    sudo cp -p tools/cegcc /usr/local/bin/
    sudo cp -p tools/ceg++ /usr/local/bin/
    echo "Installing packages for SHARP Brain development..."
    sudo apt update
    sudo apt install -y gcc-arm-mingw32ce qemu-user-static
    echo "Done."

  elif [ "$1" = "xtbook" ]; then
    echo "Installing packages..."
    sudo apt install -y mecab-ipadic libmecab2 libkakasi2 imagemagick libmecab-dev libkakasi2-dev libxml2-dev liblzma-dev

    echo "Setting up MkXTBWikiplexus..."
    cd
    curl -fL https://github.com/yvt/xtbook/releases/download/v0.2.6/MkXTBWikiplexus-R3.tar.gz | tar zxvf -
    sed -i -e 's/gets(buf)/scanf("%s",buf)!=EOF/' MkXTBWikiplexus/MkImageComplex/main.cpp
    sed -i -e 's/-liconv //' MkXTBWikiplexus/build.unix/Makefile
    cd MkXTBWikiplexus/build.unix
    make
    sudo apt remove -y libmecab-dev libkakasi2-dev libxml2-dev liblzma-dev

    cd "${wd}"
    sudo cp -p tools/xtbconv /usr/local/bin/
    while true; do
      read -rp "Your dictionary path: " dict
      read -rp "Correct (DICTDIR: ${dict:-"<Keep Current>"})? [Y/n] " key
      if [ "$key" != "n" ]; then
        break
      fi
    done
    if [ -n "${dict}" ]; then
      echo "export DICTDIR=${dict}
export PATH=$PATH:$HOME/MkXTBWikiplexus/build.unix
export PLIST=${wd}/tools/info-plists" >> ~/.bash_profile
    fi
    echo "Done."

  else
    echo "No such option: $1"
  fi

elif [ $# -eq 0 ]; then
  read -rp "Install essential packages? [Y/n]" key
  if [ "$key" != "n" ]; then
    sudo apt update
    sudo apt install -y git-lfs curl wget zip unzip bzip2 gawk vim build-essential gdb mingw-w64 xsel peco
    curl -sfL https://www.7-zip.org/a/7z2301-linux-x64.tar.xz | sudo tar Jxfp - -C /usr/local/bin
    sudo curl -fL https://github.com/puhitaku/rcs/raw/master/scripts/fontify -o /usr/local/bin/fontify
    sudo chmod +x /usr/local/bin/fontify
  fi
  echo "Setting up Git..."
  while true; do
    read -rp "Your email address: " email
    read -rp "Your name: " name
    read -rp "Correct (email: ${email:=$(git config user.email)}, name: ${name:=$(git config user.name)})? [Y/n] " key
    if [ "$key" != "n" ]; then
      break
    fi
  done
  cp .gitconfig ~/
  git config --global user.email "${email}"
  git config --global user.name "${name}"
  git config --global color.ui true
  git config --global core.quotepath false
  git config --global core.autocrlf input
  git config --global gpg.format ssh
  git config --global commit.gpgsign true
  git config --global user.signingkey "${HOME}/.ssh/id_ed25519.pub"
  echo "The Initialization Completed."

else
  echo "Error: The number of options must be 0 or 1."
fi
