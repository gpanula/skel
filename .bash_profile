# .bash_profile

# .bash_profile is read for login shells
# the bits in here are only applied for login shells
# ref: http://www.joshstaiger.org/archives/2005/07/bash_profile_vs.html

export ORIGINAL_PATH="${PATH}"
export PATH="${PATH}:/usr/sbin/:/sbin:/home/${USER}/bin"

# locale settings
[ -f /etc/profile.d/locale ] && source /etc/profile.d/locale

# make sure we are generating log messages for the creation & destruction of shells
[ -z "${SHELL_PID}" ] && source /etc/profile.d/log-shells.sh

# if you want autofs bits to be available for non-interactive shells(e.g. scp)
# put those bits here. otherwise put the autofs bit below in the interactive shell portion

# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi

### !!! Configuring interactive shell !!! ###

# dynamic motd
# ref: https://github.com/alexconst/dynamotd
if [ -x /usr/local/bin/dynamotd ]; then
	/usr/local/bin/dynamotd
fi

# give a fortune
if [ -x /usr/games/fortune ]; then
     /usr/games/fortune
fi

# reset the PATH.  We are trying to avoid dupes in the PATH.
# PATH will be set in /etc/profile.d/environment-setup (which is sourced by .bashrc)
export PATH="${ORIGINAL_PATH}"

# .bashrc is read for interactive non-login shells
# .bashrc is stuff we want to setup in *any* type of interactive shell
# ref: http://www.joshstaiger.org/archives/2005/07/bash_profile_vs.html
# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi
