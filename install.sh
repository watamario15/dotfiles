#!/usr/bin/env bash
set -euo pipefail

# 2 文字以上の dotfiles に対して
for f in .??*; do
  [ "$f" = ".git" ] && continue
  [ "$f" = ".gitconfig.local.template" ] && continue
  [ "$f" = ".gitmodules" ] && continue
  [ "$f" = ".gitconfig" ] && continue
  [[ "$f" = .nanorc* ]] && continue

  # Symlink を貼る
  ln -snfv "${PWD}/$f" ~/
done

if [ "$(uname -o)" = "Android" ]; then
  ln -snfv "${PWD}/.nanorc-termux" ~/.nanorc
else
  ln -snfv "${PWD}/.nanorc" ~/.nanorc
fi
