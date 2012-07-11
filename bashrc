. ~/.bash/aliases
. ~/.bash/completions
. ~/.bash/windowtitle
. ~/.bash/config
. ~/.bash/prompt
. ~/.bash/keychain
. ~/.env/all

# use .localrc for settings specific to one system
if [ -f ~/.localrc ]; then
  . ~/.localrc
fi

# Added by autojump install.sh
source /etc/profile.d/autojump.bash
