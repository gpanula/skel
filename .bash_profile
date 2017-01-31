# .bash_profile

PATH="${PATH}:/usr/sbin/:/sbin:/home/${USER}/bin"
export PATH

# check for dev's opt directory(autofs magic)
[ -f /etc/auto.dev-checkout ] && [ ! -h ~/workspace ] && ln -s /opt/checkout/developers/${USER} ~/workspace

# check for symlink to apache's conf.d directory
[ -f /etc/auto.dev-checkout ] && [ ! -h ~/workspace/httpd/conf.d ] && mkdir -p /opt/checkout/${USER}/httpd && ln -s /etc/http/conf.d /opt/checkout/${USER}/httpd/conf.d

# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# git completion
# http://code-worrier.com/blog/autocomplete-git/
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

##uncomment the following to activate bash-completion:
[ -f /etc/profile.d/bash-completion ] && source /etc/profile.d/bash-completion.sh
