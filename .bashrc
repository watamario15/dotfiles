# If not running interactively, don't do anything
case $- in
  *i*) ;;
  *) return;;
esac

# history
HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000
shopt -s histappend # append to the history file, don't overwrite it

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

if [ "$(uname)" = "Darwin" ]; then
  colorize="-G"
else
  colorize="--color=auto"
fi

get_status_color() {
  if [ $1 -eq 0 ]; then
    echo -e "\033[01;36m"
  else
    echo -e "\033[01;31m"
  fi

  return $1 # Preserve the exit code
}

prompt_pwd() {
  case "$PWD" in
    ${HOME}*) cwd=~${PWD:${#HOME}};;
    *) cwd=$PWD;;
  esac

  declare i=$(( ${#cwd} - 1 ))
  declare cnt=0
  declare result

  while true; do
    if [ $i -lt 0 ]; then
      echo "$cwd"
      return
    fi

    if [ "${cwd:$i:1}" = '/' ]; then
      (( ++cnt ))

      if [ $cnt -ge 2 ]; then
        if [ $i -gt 0 ]; then
          result=${cwd:$i}
          break;
        fi
      fi
    fi

    (( --i ))
  done

  declare j=0
  cnt=0

  while true; do
    if [ $j -ge $i ]; then
      echo "$cwd"
      return
    fi

    if [ "${cwd:$j:1}" = '/' ]; then
      (( ++cnt ))

      if [ $cnt -ge 2 ]; then
        if [ $j -lt $i ]; then
          echo "${cwd:0:(($j + 1))}...$result"
          return
        fi
      fi
    fi

    (( ++j ))
  done
}

PS1='\[$(get_status_color $?)\]$?\[\033[00m\] \[\033[01;32m\]\h\[\033[00m\]:\[\033[01;34m\]$(prompt_pwd)\[\033[00m\]$ '

# enable color support of ls and also add handy aliases
alias ls='ls ${colorize}'
alias dir='dir ${colorize}'
alias vdir='vdir ${colorize}'
alias grep='grep ${colorize}'
alias fgrep='fgrep ${colorize}'
alias egrep='egrep ${colorize}'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias editrc='nano -w ~/.bashrc'
alias applyrc='source ~/.bashrc'

alias pwdc='pwd | tr -d "\n" | xsel -ib'
alias copy='xsel -ip && xsel -op | xsel -ib'
alias hist='history | peco'

alias py='python'
alias ipy='ipython'

alias ga='git add'
alias gd='git diff'
alias gr='git rebase'
alias gs='git status'
alias gpl='git pull'
alias gb='git branch'
alias gsw='git switch'
alias grs='git restore'
alias gf='git fetch'
alias gc='git commit'
alias gm='git merge'
alias gt='git log --graph --all --format="%as %C(cyan bold)%an%Creset %C(yellow)%h%Creset %C(green reverse)%d%Creset %s"'

gps() {
  declare args=()
  declare isForcePush=0

  while (( $# > 0 )); do
    case $1 in
      -f) isForcePush=1;;
      *) args+=("$1");;
    esac
    shift
  done

  if [ $isForcePush -ne 0 ]; then
    echo "Invoking 'git push --force-if-includes --force-with-lease ${args[@]}'"
    read -rp "Are you sure? [y/N]: " key
    [ "$key" != "y" ] && return 1
    git push --force-if-includes --force-with-lease "${args[@]}"
  else
    git push "${args[@]}"
  fi
}

alias w32g++='i686-w64-mingw32-g++ -Wall -Wextra -O3 -std=gnu++2a -static -s -lm'
alias w32gcc='i686-w64-mingw32-gcc -Wall -Wextra -O3 -std=gnu2x -static -s -lm'
alias w64g++='x86_64-w64-mingw32-g++ -Wall -Wextra -O3 -std=gnu++2a -static -s -lm'5
alias w64gcc='x86_64-w64-mingw32-gcc -Wall -Wextra -O3 -std=gnu2x -static -s -lm'

alias sa='eval "$(ssh-agent -s)"'

if [ "$(uname -o)" = "Darwin" ]; then
  alias ng++='g++-{1..100} -Wall -Wextra -O3 -std=gnu++23 -lm'
  alias ngcc='gcc-{1..100} -Wall -Wextra -O3 -std=gnu2x -lm'
  alias nclang++='clang++ -Wall -Wextra -O3 -std=gnu++2b -arch x86_64 -arch arm64 -lm'
  alias nclang='clang -Wall -Wextra -O3 -std=gnu2x -arch x86_64 -arch arm64 -lm'

  alias pkgi='brew install'
  alias pkgr='brew uninstall'
  alias pkga='brew autoremove'
  alias pkgu='brew upgrade'
  alias pkgs='brew search'
  alias pkgif='brew info'
else
  alias ng++='g++ -Wall -Wextra -O3 -std=gnu++2a -static -s -lm'
  alias ngcc='gcc -Wall -Wextra -O3 -std=gnu2x -static -s -lm'
  alias wceg++='arm-mingw32ce-g++ -Wall -Wextra -O3 -std=gnu++2a -march=armv5tej -mcpu=arm926ej-s -static -s -lcommctrl -lcommdlg -lmmtimer -lm'
  alias wcegcc='arm-mingw32ce-gcc -Wall -Wextra -O3 -std=gnu2x -march=armv5tej -mcpu=arm926ej-s -static -s -lcommctrl -lcommdlg -lmmtimer -lm'

  if [ "$(uname -o)" = "Android" ]; then
    alias pkgi='pkg install -y'
    alias pkgr='pkg remove -y'
    alias pkga='apt autoremove -y'
    alias pkgu='pkg upgrade -y'
    alias pkgf='pkg install --fix-broken -y'
    alias pkgs='pkg search'
    alias pkgif='pkg show'
  elif [ "$(uname -o)" = "FreeBSD" ]; then
    alias pkgi='sudo pkg install'
    alias pkgr='sudo pkg remove'
    alias pkga='sudo pkg autoremove'
    alias pkgu='sudo pkg upgrade'
    alias pkgf='sudo pkg check -ad'
    alias pkgs='pkg search'
    alias pkgif='pkg info'
  elif type apt &> /dev/null; then
    alias pkgi='sudo apt install -y'
    alias pkgr='sudo apt remove -y'
    alias pkga='sudo apt autoremove -y'
    alias pkgu='sudo apt update && sudo apt dist-upgrade -y'
    alias pkgf='sudo apt --fix-broken install -y'
    alias pkgs='apt search'
    alias pkgif='apt info'
  elif type pacman &> /dev/null; then
    alias pkgi='sudo pacman -S'
    alias pkgr='sudo pacman -R'
    alias pkga='sudo pacman -Rs $(pacman -Qdtq)'
    alias pkgu='sudo pacman -Syyu'
    alias pkgs='pacman -Ss'
    alias pkgif='pacman -Si'
  fi
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
