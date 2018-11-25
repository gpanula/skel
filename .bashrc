# .bashrc

# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi

### !!! Interactive shell configuration !!! ###

# Source global definitions
[ -f /etc/bashrc ] && source /etc/bashrc
[ -f /etc/bash.bashrc ] && source /etc/bash.bashrc

# Setup common environment bits
[ -f /etc/profile.d/environment-setup ] && source /etc/profile.d/environment-setup

# local user specific bits

# User specific aliases
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable git completion
# ref: https://github.com/git/git/tree/master/contrib/completion
# ref: https://web.archive.org/web/20180403094701/http://code-worrier.com/blog/autocomplete-git/
[ -f /etc/profile.d/git-completion.bash ] && source /etc/profile.d/git-completion.bash

# should also add the following to /etc/sudoers
# Defaults env_keep += "TZ"
export TZ="CST6CDT"

