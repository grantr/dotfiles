# autojump

[ -f /usr/local/share/autojump/autojump.fish ]; and . /usr/local/share/autojump/autojump.fish

# git prompt
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_showupstream 'yes'
set __fish_git_prompt_color_branch yellow

# go
set -x GOPATH $HOME/go
set -x GO15VENDOREXPERIMENT 1
set -x PATH $GOPATH/bin $PATH

# rbenv
set PATH $HOME/.rbenv/shims $PATH
rbenv rehash >/dev/null ^&1
