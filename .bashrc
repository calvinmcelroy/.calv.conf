# Servious .bashrc
# Last Mod- 9/30/19
#
# NEEDED PACKAGES:
# cowsay google-chrome-stable rclone
#
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=20000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

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

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='\e[31;1m\u@\h: \e[01;37m\W\e[0m\$ '
    #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

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
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

cowsay -f eyes "Welcome $USER"

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias chrome='google-chrome-stable'
alias ls='ls -l --group-directories-first --color=auto'
alias lsa='ls -lG --color --group-directories-first -A -v'
alias ifconfig='/sbin/ifconfig'

# Alert alias for long running commands. Use like so:
# sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alerts$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
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

# java jdk
export PATH=$PATH:~/Desktop/jdk1.8.0_144/bin/

# uDn
alias uDn='/home/servious/myDev/uDn'

#fuction run
run () {
    if [ $# -ne 2 ]
    then
        echo "[*] Usage: run <iterations> <file>"
    else
        number=$1
        shift
        for i in `seq $number`; do
            $@
        done
    fi
}

alias fuck='sudo $(history -p !!)'

###timestamp###
# Add time to terminal
export PROMPT_COMMAND="echo -n \[\$(date +%F-%T)\]\ "
# Add time to History
HISTTIMEFORMAT="%d/%m/%y %T "

###unpack###
alias unpack='tar xvzf $1'

###rclone###
# Usage:
#
#[*] List directories in top level of your drive:
# rclone lsd remote:
#
#[*] List all the files in your drive:
# rclone ls remote:
#
#[*] To copy a local directory to a drive directory called backup
# rclone copy /home/source remote:backup
#
#[*] To copy a drive directory to a local directory
# rclone copy remote:backup /home/source
#
#[*] Empty trash, perm delete all trashed files:
# rclone cleanup remote:
#
#[*] To make source and dest identical, modifying destination only w/ progress (-p):
# rclone sync source:path dest:path -p
####################################
alias sync-pollux="rclone sync /home/servious remote:backup_pollux -p --exclude '.*{/**,}'"


IFS=$'\n'

export ANSIBLE_NOCOWS=1
