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
        sudo mv casl2 comet2 /usr/local/bin/
      fi
      cd ..
      rm -rf casl2-2017-11-16.zip casl2-2017-11-16

      echo "Done."
    fi

  elif [ "$(uname)" = "Linux" ] && [ "$1" = "brain" ]; then
    echo "Installing CeGCC and convenience scripts..."
    curl -fLO "https://github.com/brain-hackers/cegcc-build/releases/download/2022-10-26-225811/cegcc-$(uname -m)-2022-10-26-225811.zip"
    sudo rm -rf /opt/cegcc
    sudo unzip -oq "cegcc-$(uname -m)-2022-10-26-225811.zip" -d /opt
    sudo rm -f "cegcc-$(uname -m)-2022-10-26-225811.zip"

    sudo cp -p tools/cegcc /usr/local/bin/
    sudo cp -p tools/ceg++ /usr/local/bin/

    echo "Note: CeGCC has been installed to /opt/cegcc as 'arm-mingw32ce-gcc-*'. You may want to configure the PATH environmental variable to include '/opt/cegcc/bin'."
    echo "Done."

  elif [ "$(uname)" = "Linux" ] && [ "$1" = "xtbook" ]; then
    echo "Installing packages..."
    if type dnf &> /dev/null; then
      sudo dnf install -y mecab-ipadic kakasi-libs kakasi-dict ImageMagick
    elif type apt &> /dev/null; then
      sudo apt install -y libmecab mecab-ipadic-utf8 libkakasi2 imagemagick
    else
      echo Error: We currently support only apt and dnf package managers.
      exit 1
    fi

    echo "Setting up MkXTBWikiplexus..."
    case $(uname -m) in
      x86_64) arch_mkxtb=amd64;;
      arm64* | aarch64* | armv8* | armv9*) arch_mkxtb=arm64;;
    esac
    curl -fLO "https://github.com/watamario15/MkXTBWikiplexus/releases/latest/download/linux-${arch_mkxtb}.zip"
    unzip -oq "linux-${arch_mkxtb}.zip" -d xtbconv
    sudo mv xtbconv/*-bin xtbconv/xtbconv /usr/local/bin/
    mv xtbconv/info-plists "${HOME}/"
    rm -rf xtbconv "linux-${arch_mkxtb}.zip"

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
    echo "Error: No such option or not supported on your platform: $1"
  fi

elif [ $# -eq 0 ]; then
  read -rp "Install essential packages? [Y/n]" key
  if [ "$key" != "n" ]; then
    if [ "$(uname -o)" = "Android" ]; then
      apt update
      apt install -y git-lfs curl wget zip unzip 7zip gawk vim build-essential gdb which
      curl -fL https://github.com/puhitaku/rcs/raw/master/scripts/fontify -o "$PREFIX/bin/fontify"
      curl -fL https://github.com/slimm609/checksec.sh/raw/main/checksec -o "$PREFIX/bin/checksec"
      chmod +x "$PREFIX/bin/fontify" "$PREFIX/bin/checksec"
    else
      if [ "$(uname)" = "Linux" ]; then
        if [ -f /etc/debian_version ]; then
          sudo apt update
          sudo apt install -y git-lfs curl wget zip unzip 7zip gawk vim build-essential gdb mingw-w64 xsel peco
        elif type dnf &> /dev/null; then
          sudo dnf install -y git-lfs curl wget zip unzip gawk vim gcc-c++ gdb mingw32-gcc-c++ mingw64-gcc-c++ xsel

          case $(uname -m) in
            x86) arch_7z=x86;;
            x86_64) arch_7z=x64;;
            arm64* | aarch64* | armv8* | armv9*) arch_7z=arm64;;
            arm*) arch_7z=arm;;
          esac
          if [ -n "$arch_7z" ]; then
            curl -sfL "https://www.7-zip.org/a/7z2408-linux-${arch_7z}.tar.xz" | sudo tar Jxf - -C /usr/local/bin
          fi
          
          case $(uname -m) in
            x86_64) arch_peco=amd64;;
            arm64* | aarch64* | armv8* | armv9*) arch_peco=arm64;;
            arm*) arch_peco=arm;;
          esac
          curl -sfL "https://github.com/peco/peco/releases/latest/download/peco_linux_${arch_peco}.tar.gz" | tar zxf -
          sudo mv "peco_linux_${arch_peco}/peco" /usr/local/bin
          rm -r "peco_linux_${arch_peco}"
        fi
      fi

      sudo curl -fL https://github.com/puhitaku/rcs/raw/master/scripts/fontify -o /usr/local/bin/fontify
      sudo curl -fL https://github.com/slimm609/checksec.sh/raw/main/checksec -o /usr/local/bin/checksec
      sudo chmod +x /usr/local/bin/fontify /usr/local/bin/checksec
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
  # shellcheck disable=SC2016
  git config --global difftool.vscode.cmd 'code --wait --diff "$LOCAL" "$REMOTE"'
  git config --global difftool.vscode.trustExitCode false
  git config --global gpg.format ssh
  git config --global init.defaultBranch main
  git config --global merge.tool vscode
  git config --global mergetool.prompt false
  git config --global mergetool.keepBackup false
  # shellcheck disable=SC2016
  git config --global mergetool.vscode.cmd 'code --wait --merge "$REMOTE" "$LOCAL" "$BASE" "$MERGED"'
  git config --global mergetool.vscode.trustExitCode false
  git config --global user.email "${email}"
  git config --global user.name "${name}"
  git config --global user.signingkey "${HOME}/.ssh/id_ed25519.pub"

  echo "The Initialization Completed."

else
  echo "Error: The number of options must be 0 or 1."
fi
