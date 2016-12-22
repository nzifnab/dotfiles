# base-files version 3.7-1

# To pick up the latest recommended .bash_profile content,
# look in /etc/defaults/etc/skel/.bash_profile

# Modifying /etc/skel/.bash_profile directly will prevent
# setup from updating it.

# The copy in your home directory (~/.bash_profile) is yours, please
# feel free to customise it to create a shell
# environment to your liking.  If you feel a change
# would be benifitial to all, please feel free to send
# a patch to the cygwin mailing list.

# ~/.bash_profile: executed by bash for login shells.

# source the system wide bashrc if it exists
if [ -e /etc/bash.bashrc ] ; then
  source /etc/bash.bashrc
fi

# source the users bashrc if it exists
if [ -e "${HOME}/.bashrc" ] ; then
  source "${HOME}/.bashrc"
fi

# Set PATH so it includes user's private bin if it exists
# if [ -d "${HOME}/bin" ] ; then
#   PATH=${HOME}/bin:${PATH}
# fi

# Set MANPATH so it includes users' private man if it exists
# if [ -d "${HOME}/man" ]; then
#   MANPATH=${HOME}/man:${MANPATH}
# fi

# Set INFOPATH so it includes users' private info if it exists
# if [ -d "${HOME}/info" ]; then
#   INFOPATH=${HOME}/info:${INFOPATH}
# fi

# http://pastie.org/pastes/165446
 function parse_git_branch {
   git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
 }

 function proml {
   local        BLUE="\[\033[0;34m\]"
   local         RED="\[\033[0;31m\]"
   local   LIGHT_RED="\[\033[1;31m\]"
   local       GREEN="\[\033[0;32m\]"
   local LIGHT_GREEN="\[\033[1;32m\]"
   local       WHITE="\[\033[1;37m\]"
   local  LIGHT_GRAY="\[\033[0;37m\]"
   case $TERM in
     xterm*)
     TITLEBAR='\[\033]0;\u@\h:\w\007\]'
     ;;
     *)
     TITLEBAR=""
     ;;
   esac

 PS1="${TITLEBAR}\
 $GREEN\u:$RED\W$WHITE\$(parse_git_branch)$GREEN\$ "
 PS2='> '
 PS4='+ '
 }
 proml

 # git tab completion
 source ~/bin/dotfiles/lib/.git-completion.bash


test -r /sw/bin/init.sh && . /sw/bin/init.sh
PS1="\$(~/.rvm/bin/rvm-prompt i v g s) $PS1"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"  # This loads RVM into a shell session.

[[ -s /Users/nbenes/.nvm/nvm.sh ]] && . /Users/nbenes/.nvm/nvm.sh # This loads NVM

eval "$(/Users/nbenes/projects/scripts/bin/law init -)"
