#!/usb/bin/env bash
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

DOTFILES='dotfiles'

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

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
    #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    :
else
    #PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
    :
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    #PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

if [ -f $HOME/dotfiles/alias ]; then
  . $HOME/dotfiles/alias
fi

if [ -d $HOME/.pyenv/bin ]; then
  export PATH="$HOME/.pyenv/bin:$PATH"
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

if [ -d $HOME/.rbenv/bin ]; then
  export PATH="$HOME/.rbenv/bin:$PATH"
fi

if [ -d $HOME/dotfiles/bin ]; then
  export PATH="$HOME/dotfiles/bin:$PATH"
fi
if [ -d $HOME/bin ]; then
  export PATH="$HOME/bin:$PATH"
fi

if [ -f $HOME/.bashrc.local ]; then
  source "$HOME/.bashrc.local"
fi

export PATH="$HOME/.local/bin:$PATH"

export BINLOG="$HOME/bin/bin.log"

# disable xon/xoff
stty -ixon
GPG_TTY=$(tty)
export GPG_TTY

LC_ALL=en_US.utf8
export LC_ALL

## unix-porn {{{
# borrowed from http://slackmagic.com/filedump/bashrc
#######################################################
# slackmaGic's .bashrc file
# IRC ##slackware @ freenode
# www.slackmagic.com
#
# Last Modified 07-14-2013
#######################################################

# Define a few COLORS
liBlack="\[\033[0;30m\]"
boBlack="\[\033[1;30m\]"
liRed="\[\033[0;31m\]"
boRed="\[\033[1;31m\]"
liGreen="\[\033[0;32m\]"
boGreen="\[\033[1;32m\]"
liYellow="\[\033[0;33m\]"
boYellow="\[\033[1;33m\]"
liBlue="\[\033[0;34m\]"
boBlue="\[\033[1;34m\]"
liMagenta="\[\033[0;35m\]"
boMagenta="\[\033[1;35m\]"
liCyan="\[\033[0;36m\]"
boCyan="\[\033[1;36m\]"
liWhite="\[\033[0;37m\]"
boWhite="\[\033[1;37m\]"
bgRed="\[\033[0;41m\]"


# Enable 256 Colors for bash prompt
function EXT_COLOR () { echo -ne "\[\033[38;5;$1m\]"; }

#PROMPT_COMMAND='history -a'
jobs_warning () {
  count_jobs=$(jobs | wc -l)
  if [[ $count_jobs > 0 ]]; then
    jobs_highlight="$bgRed$boBlack`EXT_COLOR 234`"
  else
    jobs_highlight="\[\033[m\]$boBlack`EXT_COLOR 234`"
  fi
  PS1="\n $boBlack($liBlack`EXT_COLOR 32`\$(ls -lah | grep -m 1 total | sed 's/total //')B, \$(ls -1 | wc -l | sed 's: ::g') files$boBlack)`EXT_COLOR 234`\342\224\200 $jobs_highlight jobs:\j \[\e[m\]`EXT_COLOR 234`\342\224\200[ $liBlack`EXT_COLOR 59`\T \d $boBlack`EXT_COLOR 234`]\342\224\200\342\224\200\342\224\200\342\224\200\342\224\200\342\224\200\342\224\200\342\224\200\342\224\200\342\224\200$boBlack[ `EXT_COLOR 220`\u$boBlack@`EXT_COLOR 156`\h$boBlack ] \n $boBlack(`EXT_COLOR 33`\w$boBlack) $boWhite>$liWhite "
}

PROMPT_COMMAND='jobs_warning'

#PS1="\n $boBlack($liBlack`EXT_COLOR 32`\$(ls -lah | grep -m 1 total | sed 's/total //')B, \$(ls -1 | wc -l | sed 's: ::g') files$boBlack)`EXT_COLOR 234`\342\224\200\342\224\200\342\224\200\342\224\200\342\224\200\342\224\200\342\224\200\342\224\200\342\224\200\342\224\200[ $liBlack`EXT_COLOR 59`\T \d $boBlack`EXT_COLOR 234`]\342\224\200\342\224\200\342\224\200\342\224\200\342\224\200\342\224\200\342\224\200\342\224\200\342\224\200\342\224\200$boBlack[ `EXT_COLOR 220`\u$boBlack@`EXT_COLOR 156`\h$boBlack ] \n $boBlack(`EXT_COLOR 33`\w$boBlack) $boWhite>$liWhite "
PS2="> "
PS3="> "
PS4="+ "

# EXPORTS
#######################################################
shopt -s histappend	 		#append new history to existing file rather than rewriting - saves everything now!
shopt -s cdspell 			#ignore simple mistakes such as otp instead of opt or ect instead of etc
shopt -s cmdhist			#multiple line commands stay together in history
shopt -s extglob			#needed for working with files EXCEPT specific ones
export HISTFILESIZE="12000" 		#the bash history should save 3000 commands
export HISTSIZE="12000"
export HISTCONTROL="ignoredups" 	#don't put duplicate lines in the history
export HISTIGNORE="&:ls:ll:la:lt:clear:q:[bf]g:exit"	#will ignore a few common commands
export GREP_COLOR="1;32"

export EDITOR="vim"
export VISUAL="vim"

## /unix-porn }}}

source ~/dotfiles/littlehelper

eval $(dircolors -b $HOME/.dircolors)

## perl local bin
PATH="$HOME/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="$HOME/perl5/lib/perl5:${PERL5LIB}"; export PERL5LIB;
#PERL5LIB="$HOME/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="$HOME/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"$HOME/perl5\""; export PERL_MB_OPT; 
PERL_MM_OPT="INSTALL_BASE=$HOME/perl5"; export PERL_MM_OPT;

## extended path to dotfiles
# already in path PATH="$HOME/perl5/dotfiles/bin${PATH:+:${PATH}}"; export PATH;
#PERL5LIB="$HOME/dotfiles/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL5LIB="$HOME/dotfiles/lib/perl5:${PERL5LIB}"; export PERL5LIB;
#PERL_LOCAL_LIB_ROOT="$HOME/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;

PERL5LIB=".:${PERL5LIB}"; export PERL5LIB

# perlbrew
[ -f $HOME/perl5/perlbrew/etc/bashrc ] && source $HOME/perl5/perlbrew/etc/bashrc

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

