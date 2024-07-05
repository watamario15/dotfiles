#!/usr/bin/env bash
set -e

if [ $# -eq 1 ]; then
  if [ "$1" = "caslcomet" ]; then
    if type "casl2" &> /dev/null && type "comet2" &> /dev/null; then
      echo "The CASLII/COMETII simulator is already installed, and nothing has been changed."
    else
      echo "Installing the CASLII/COMETII simulator (Osaka University)..."
      cd
      curl -fLO https://www-hasegawa.ist.osaka-u.ac.jp/~ykoizumi/lecture/fco/files/casl2-2017-11-16.zip
      unzip -oq casl2-2017-11-16.zip
      cd casl2-2017-11-16
      chmod +x casl2 comet2
      if [ "$(uname -o)" = "Android" ]; then
        mv casl2 comet2 "${PREFIX}/local/bin/"
      else
        sudo mv casl2 comet2 "/usr/local/bin/"
      fi
      cd ..
      rm -rf casl2-2017-11-16.zip casl2-2017-11-16

      echo "Done."
    fi

  elif [ -f /etc/debian_version ] && [ "$1" = "brain" ]; then
    echo "Installing CeGCC and convenience scripts..."
    curl -fLO "https://github.com/brain-hackers/cegcc-build/releases/download/2022-10-26-225811/cegcc-$(uname -m)-2022-10-26-225811.zip"
    sudo rm -rf /opt/cegcc
    sudo unzip -oq "cegcc-$(uname -m)-2022-10-26-225811.zip" -d /opt
    sudo rm -f "cegcc-$(uname -m)-2022-10-26-225811.zip"
    
    sudo cp -p tools/cegcc "/usr/local/bin/"
    sudo cp -p tools/ceg++ "/usr/local/bin/"

    echo "Note: CeGCC has been installed to /opt/cegcc as 'arm-mingw32ce-gcc-*'. You may want to configure the PATH environmental variable to include '/opt/cegcc/bin'."
    echo "Done."

  elif [ -f /etc/debian_version ] && [ "$(uname -m)" = "x86_64" ] && [ "$1" = "xtbook" ]; then
    echo "Installing packages..."
    sudo apt install -y libmecab mecab-ipadic-utf8 libkakasi2 imagemagick

    echo "Setting up MkXTBWikiplexus..."
    curl -fLO https://github.com/watamario15/MkXTBWikiplexus/releases/latest/download/linux-amd64.zip
    unzip -oq linux-amd64.zip -d xtbconv
    sudo mv xtbconv/*-bin xtbconv/xtbconv "/usr/local/bin/"
    mv xtbconv/info-plists "${HOME}/"
    rm -rf xtbconv

    while true; do
      read -rp "Dictionary path: " dict
      read -rp "Wikimedia mirror: " wiki_mirror
      read -rp "Correct (DICTDIR: ${dict:-"<Keep Current>"}, WIKIMEDIA_MIRROR: ${wiki_mirror:-"<Keep Current>"})? [Y/n] " key
      if [ "$key" != "n" ]; then
        break
      fi
    done
    if [ -n "${dict}" ]; then
      echo "export DICTDIR=${dict}" >> ~/.bash_profile
    fi
    if [ -n "${wiki_mirror}" ]; then
      echo "export WIKIMEDIA_MIRROR=${wiki_mirror}" >> ~/.bash_profile
    fi
    echo "export PLIST=${HOME}/info-plists" >> ~/.bash_profile

    echo "Done."

  else
    echo "No such option or not supported on your platform: $1"
  fi

elif [ $# -eq 0 ]; then
  read -rp "Install essential packages? [Y/n]" key
  if [ "$key" != "n" ]; then
    if [ "$(uname -o)" = "Android" ]; then
      apt update
      apt install -y git-lfs curl wget zip unzip p7zip gawk vim build-essential gdb which
      curl -fL https://github.com/puhitaku/rcs/raw/master/scripts/fontify -o "$PREFIX/bin/fontify"
      curl -fL https://github.com/slimm609/checksec.sh/raw/main/checksec -o "$PREFIX/bin/checksec"
      chmod +x "$PREFIX/bin/fontify" "$PREFIX/bin/checksec"
    else
      if [ "$(uname)" = "Linux" ]; then
        if [ -f /etc/debian_version ]; then
          sudo apt update
          sudo apt install -y git-lfs curl wget zip unzip bzip2 gawk vim build-essential gdb mingw-w64 xsel peco
        fi
        
        case $(uname -m) in
          x86) arch_7z=x86;;
          x86_64) arch_7z=x64;;
          arm64* | aarch64* | armv8* | armv9*) arch_7z=arm64;;
          arm*) arch_7z=arm;;
        esac

        if [ -n "$arch_7z" ]; then
          curl -sfL "https://www.7-zip.org/a/7z2407-linux-${arch_7z}.tar.xz" | sudo tar Jxfp - -C "/usr/local/bin"
        fi
      elif [ "$(uname -o)" = "Darwin" ]; then
        curl -sfL https://www.7-zip.org/a/7z2407-mac.tar.xz | sudo tar Jxfp - -C "/usr/local/bin"
      fi

      sudo curl -fL https://github.com/puhitaku/rcs/raw/master/scripts/fontify -o "/usr/local/bin/fontify"
      sudo curl -fL https://github.com/slimm609/checksec.sh/raw/main/checksec -o "/usr/local/bin/checksec"
      sudo chmod +x "/usr/local/bin/fontify" "/usr/local/bin/checksec"
    fi
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
  git config --global color.ui true
  git config --global commit.gpgsign true
  git config --global core.quotepath false
  git config --global core.autocrlf input
  git config --global core.ignorecase false
  git config --global diff.tool vscode
  git config --global difftool.prompt false
  git config --global difftool.vscode.cmd 'code --wait --diff "$LOCAL" "$REMOTE"'
  git config --global difftool.vscode.trustExitCode false
  git config --global gpg.format ssh
  git config --global init.defaultBranch main
  git config --global merge.tool vscode
  git config --global mergetool.prompt false
  git config --global mergetool.keepBackup false
  git config --global mergetool.vscode.cmd 'code --wait --merge "$REMOTE" "$LOCAL" "$BASE" "$MERGED"'
  git config --global mergetool.vscode.trustExitCode false
  git config --global user.email "${email}"
  git config --global user.name "${name}"
  git config --global user.signingkey "${HOME}/.ssh/id_ed25519.pub"

  echo "The Initialization Completed."

else
  echo "Error: The number of options must be 0 or 1."
fi
