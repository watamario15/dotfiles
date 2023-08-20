#!/usr/bin/env bash
set -e

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
      mv casl2 comet2 /data/data/com.termux/files/usr/bin/
      cd ..
      rm -rf casl2-2017-11-16.zip casl2-2017-11-16
      echo "Done."
    fi
  else
    echo "No such option: $1"
  fi

elif [ $# -eq 0 ]; then
  read -rp "Install essential packages? [Y/n]" key
  if [ "$key" != "n" ]; then
  apt update
  apt install -y git-lfs curl wget zip unzip gawk vim build-essential gdb which
  curl -fL https://raw.githubusercontent.com/puhitaku/rcs/master/scripts/fontify -o /data/data/com.termux/files/usr/bin/fontify
  chmod +x /data/data/com.termux/files/usr/bin/fontify
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
  git config --global init.defaultBranch main
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
