export ZSH=$HOME/.oh-my-zsh
export ZSH_THEME="grantr"
export DISABLE_AUTO_UPDATE="true"
# export DISABLE_LS_COLORS="true"
# export DISABLE_AUTO_TITLE="true"

plugins=()

source $ZSH/oh-my-zsh.sh

. ~/.zsh/keychain
. ~/.zsh/aliases
. ~/.env/all

# disable autocorrect completely
unsetopt correct_all

# disable autocorrect for certain commands
if [ -f ~/.zsh_nocorrect ]; then
    while read -r COMMAND; do
        alias $COMMAND="nocorrect $COMMAND"
    done < ~/.zsh_nocorrect
fi

# bind special keys according to readline configuration
eval "$(sed -n 's/^/bindkey /; s/: / /p' /etc/inputrc)" >/dev/null

# use bash-style history search
bindkey "^[[5~" history-beginning-search-backward
bindkey "^[[6~" history-beginning-search-forward

# use .localrc for settings specific to one system
[[ -f ~/.localrc ]] && . ~/.localrc
