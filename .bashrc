# .bashrc

# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions

# setup some aliases
alias d="ls --color"
alias ls="ls --color=auto"
alias ll="ls --color -l"
alias la="ls --color -a"
alias lart="ls --color -lart"
alias larth="ls --color -larth"
alias arin="whois -h whois.arin.net"
alias ripe="whois -h whois.ripe.net"

# set PATH to include bin in the user's home directory
PATH="${PATH}:/usr/sbin/:/sbin:/home/${USER}/bin"
export PATH

# use vi as my EDITOR
export EDITOR="vim"

# Change the window title of X terminals 
case ${TERM} in
	xterm*|rxvt*|Eterm|aterm|kterm|gnome)
		PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\007"'
		;;
	screen)
		PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\033\\"'
		;;
esac

# We only want the git prompt info in directories that are git repos
GIT_PROMPT_ONLY_IN_REPO=1

# Grab the local colorful bash prompt setting
[ -f /etc/profile.d/bash_prompt ] && source /etc/profile.d/bash_prompt

# configure git for us
[ -f /etc/profile.d/set-git-info ] && source /etc/profile.d/set-git-info

# enable git completion
[ -f ~/.git-completion.bash ] && source ~/.git-completion.bash

# locale settings
# http://www.gentoo.org/doc/en/guide-localization.xml
# also see http://www.linuxquestions.org/questions/slackware-14/gnome-clock-411886/
export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"
export TZ="CST6CDT"
