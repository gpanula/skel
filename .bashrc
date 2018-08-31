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

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"


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

# useful xfreerdp alias
alias xfreerdp="xfreerdp /size:1366x768 +compression -wallpaper -themes +clipboard +smart-sizing"

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

# give a fortune
if [ -x /usr/games/fortune ]; then
     /usr/games/fortune
fi

# set PATH to include bin in the user's home directory
PATH="${PATH}:/usr/sbin/:/sbin:/usr/local/bin:/usr/local/sbin:/home/${USER}/bin"
export PATH

# use vi as my EDITOR
export EDITOR="vim"

# give me a colorful vi
alias vi="vim"

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

## Try adding git info above the prompt
## https://github.com/magicmonty/bash-git-prompt
if [ -f ~/.bash-git-prompt/gitprompt.sh ]; then
   GIT_PROMPT_START="\[\033[01;35m\][\u]\[\033[m\]"
   GIT_PROMPT_END="\n\[\033[01;36m\][\h]\[\033[01;31m\]:\[\033[01;31m\][\${PWD}] \\$ \[\033[00m\]"
   source ~/.bash-git-prompt/gitprompt.sh
fi

# Grab the local colorful bash prompt setting
[ -f /etc/profile.d/bash_prompt ] && source /etc/profile.d/bash_prompt

# configure git for us
[ -f /etc/profile.d/set-git-info ] && source /etc/profile.d/set-git-info

## activate git-completion
## ref -> http://code-worrier.com/blog/autocomplete-git/
[ -f /etc/profile.d/git-completion.bash ] && source /etc/profile.d/git-completion.bash

# locale settings
# http://www.gentoo.org/doc/en/guide-localization.xml
# also see http://www.linuxquestions.org/questions/slackware-14/gnome-clock-411886/
export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"

# set the shell's timezone
# should also add the following to /etc/sudoers
# Defaults env_keep += "TZ"
export TZ="CST6CDT"

# Fix for "X11 connection rejected because of wrong authentication."
# when using sudo
# NOTE: also need to add the following to /etc/sudoers
# Defaults env_keep += "DISPLAY XAUTHORIZATION XAUTHORITY"
[ -f /home/$USER/.Xauthority ] && export XAUTHORITY=/home/$USER/.Xauthority

# useful aws cli reference
# http://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html#config-settings-and-precedence

# this function lets you set which profile to use
# from ~/.aws/credentials
# it also updates your prompt to remind you which aws profile you are using
function setaws() {
    # re-import the bash prompt as a way of "resetting" it
    # this allows for bouncing between aws accounts and keeping the prompt accurate
    if [ -f /etc/profile.d/bash_prompt ]
    then
        source /etc/profile.d/bash_prompt
    fi

    export AWS_DEFAULT_PROFILE="$1"
    export AWS_PROFILE="$1"

    export PS1="\[\033[01;37m\][AWS]\[\033[01;31m\]:\[\033[01;32m\][$AWS_DEFAULT_PROFILE]\[\033[01;31m\]:\[\033[01;32m\][$AWS_DEFAULT_REGION]\n\[\033[01;33m\]$PS1"
    export GIT_PROMPT_START="\[\033[01;37m\][AWS]\[\033[01;31m\]:\[\033[01;32m\][$AWS_DEFAULT_PROFILE]\[\033[01;31m\]:\[\033[01;32m\][$AWS_DEFAULT_REGION]"
}


# quickly set which aws region to use
# also updates your prompt
function setregion() {
    # re-import the bash prompt as a way of "resetting" it
    # this allows for bouncing between aws accounts and keeping the prompt accurate
    if [ -f /etc/profile.d/bash_prompt ]
    then
        source /etc/profile.d/bash_prompt
    fi

    export AWS_DEFAULT_REGION="$1"
    export PS1="\[\033[01;37m\][AWS]\[\033[01;31m\]:\[\033[01;32m\][$AWS_DEFAULT_PROFILE]\[\033[01;31m\]:\[\033[01;32m\][$AWS_DEFAULT_REGION]\n\[\033[01;33m\]$PS1"
    export GIT_PROMPT_START="\[\033[01;37m\][AWS]\[\033[01;31m\]:\[\033[01;32m\][$AWS_DEFAULT_PROFILE]\[\033[01;31m\]:\[\033[01;32m\][$AWS_DEFAULT_REGION]"
}


# enable terraform logging
# https://www.terraform.io/docs/internals/debugging.html
alias tflog='export TF_LOG=INFO && export TF_LOG_PATH=terraform.log'

# always update source when running terragrunt
# https://github.com/gruntwork-io/terragrunt/pull/387
export TERRAGRUNT_SOURCE_UPDATE=true

