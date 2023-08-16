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

if [ "$(uname)" == "Darwin" ]; then
  colorize="-G"
else
  colorize="--color=auto"
fi

get_status() {
  exitcode=$?
  if [ $exitcode -ne 0 ]; then
    echo -e "\033[01;31m$exitcode\033[00m"
  else
    echo $exitcode
  fi
}

PS1='$(get_status) \e[01;32m\h\e[00m:\e[01;34m\W\e[00m$ '

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
alias apti='pkg install -y'
alias aptr='pkg remove -y'
alias apta='apt autoremove -y'
alias aptu='pkg upgrade -y'
alias aptf='apt --fix-broken install -y'
alias apts='apt search'
alias aptif='apt info'
alias editrc='nano -w ~/.bashrc'
alias applyrc='source ~/.bashrc'
alias ng++='g++ -Wall -Wextra -O3 -std=gnu++2a -static -s -lm'
alias ngcc='gcc -Wall -Wextra -O3 -std=gnu2x -static -s -lm'

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
