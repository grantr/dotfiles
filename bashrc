source ~/.bash/aliases
source ~/.bash/completions
source ~/.bash/windowtitle
source ~/.bash/keychain
source ~/.bash/paths
source ~/.bash/config
source ~/.bash/prompt

# use .localrc for settings specific to one system
if [ -f ~/.localrc ]; then
  source ~/.localrc
fi
