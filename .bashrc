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

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias py='python'
alias ipy='ipython'
alias ga='git add'
alias gd='git diff'
alias gr='git rebase'
alias gs='git status'
alias gp='git push'
alias gb='git branch'
alias gsw='git switch'
alias grs='git restore'
alias gf='git fetch'
alias gc='git commit'
alias gm='git merge'
alias gt='git log --graph --all --format="%as %C(cyan bold)%an%Creset %C(yellow)%h%Creset %C(green reverse)%d%Creset %s"'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias apti='sudo apt install -y'
alias aptr='sudo apt remove -y'
alias apta='sudo apt autoremove -y'
alias aptu='sudo apt update && sudo apt dist-upgrade -y'
alias aptf='sudo apt --fix-broken install -y'
alias apts='apt search'
alias aptif='apt info'
alias spstop='sudo /opt/sophos-av/bin/savdctl disable'
alias spstart='sudo /opt/sophos-av/bin/savdctl enable'
alias spup='sudo /opt/sophos-av/bin/savupdate'
alias editrc='nano -w ~/.bashrc'
alias applyrc='source ~/.bashrc'
alias pwdc='pwd | tr -d "\n" | xsel -ib'
alias copy='xsel -ip && xsel -op | xsel -ib'
alias hist='history | peco'
alias ng++='g++ -Wall -Wextra -O3 -std=gnu++2a -static -s -lm'
alias ngcc='gcc -Wall -Wextra -O3 -std=gnu2x -static -s -lm'
alias mg++='g++-13 -Wall -Wextra -O3 -std=gnu++23 -lm'
alias mgcc='gcc-13 -Wall -Wextra -O3 -std=gnu2x -lm'
alias mclang++='clang++ -Wall -Wextra -O3 -std=gnu++2b -arch x86_64 -arch arm64 -lm'
alias mclang='clang -Wall -Wextra -O3 -std=gnu2x -arch x86_64 -arch arm64 -lm'
alias wceg++='arm-mingw32ce-g++ -Wall -Wextra -O3 -std=gnu++2a -march=armv5tej -mcpu=arm926ej-s -static -s -lcommctrl -lcommdlg -lmmtimer -lm'
alias wcegcc='arm-mingw32ce-gcc -Wall -Wextra -O3 -std=gnu2x -march=armv5tej -mcpu=arm926ej-s -static -s -lcommctrl -lcommdlg -lmmtimer -lm'
alias w32g++='i686-w64-mingw32-g++ -Wall -Wextra -O3 -std=gnu++2a -static -s -lm'
alias w32gcc='i686-w64-mingw32-gcc -Wall -Wextra -O3 -std=gnu2x -static -s -lm'
alias w64g++='x86_64-w64-mingw32-g++ -Wall -Wextra -O3 -std=gnu++2a -static -s -lm'
alias w64gcc='x86_64-w64-mingw32-gcc -Wall -Wextra -O3 -std=gnu2x -static -s -lm'

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
