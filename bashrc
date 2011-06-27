. ~/.bash/aliases
. ~/.bash/completions
. ~/.bash/windowtitle
. ~/.bash/keychain
. ~/.bash/config
. ~/.bash/prompt
. ~/.env/all

# use .localrc for settings specific to one system
if [ -f ~/.localrc ]; then
  . ~/.localrc
fi
