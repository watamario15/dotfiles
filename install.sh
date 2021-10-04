#!/usr/bin/env bash

# 未定義な変数があったら途中で終了する
set -u

# 2 文字以上の dotfiles に対して
for f in .??*; do
    [ "$f" = ".git" ] && continue
    [ "$f" = ".gitconfig.local.template" ] && continue
    [ "$f" = ".gitmodules" ] && continue
    [ "$f" = ".gitconfig" ] && cp $f ~/ && continue

    # Symlink を貼る
    ln -snfv ${PWD}/"$f" ~/
done
