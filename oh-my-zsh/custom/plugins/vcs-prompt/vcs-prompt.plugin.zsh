###############################################################################
#
#  VCS INFO
#
#  How to install:
#
#    1.Source this file in your .zshrc.
#      # e.g.
#      source ~/.zsh/zsh-vcs-prompt/zshrc.sh
#
#    2.Add the following in your .zshrc:
#      # e.g.
#      RPROMPT='$(vcs_super_info)'
#
###############################################################################

### Set default values.
#
#  If you want to customize the appearance of the prompt,
#  try to change the values in the following variables in your zshrc file.
#

## Enable caching, if set 'true'.
ZSH_VCS_PROMPT_ENABLE_CACHING=${ZSH_VCS_PROMPT_ENABLE_CACHING:-'false'}

## Use the python script (lib/gitstatus-fast.py) by default.
ZSH_VCS_PROMPT_USING_PYTHON=${ZSH_VCS_PROMPT_USING_PYTHON:-'true'}

## Symbols.
ZSH_VCS_PROMPT_AHEAD_SIGIL=${ZSH_VCS_PROMPT_AHEAD_SIGIL:-'↑ '}
ZSH_VCS_PROMPT_BEHIND_SIGIL=${ZSH_VCS_PROMPT_BEHIND_SIGIL:-'↓ '}
ZSH_VCS_PROMPT_STAGED_SIGIL=${ZSH_VCS_PROMPT_STAGED_SIGIL:-'● '}
ZSH_VCS_PROMPT_CONFLICTS_SIGIL=${ZSH_VCS_PROMPT_CONFLICTS_SIGIL:-'✖ '}
ZSH_VCS_PROMPT_UNSTAGED_SIGIL=${ZSH_VCS_PROMPT_UNSTAGED_SIGIL:-'✚ '}
ZSH_VCS_PROMPT_UNTRACKED_SIGIL=${ZSH_VCS_PROMPT_UNTRACKED_SIGIL:-'… '}
ZSH_VCS_PROMPT_STASHED_SIGIL=${ZSH_VCS_PROMPT_STASHED_SIGIL:-'⚑'}
ZSH_VCS_PROMPT_CLEAN_SIGIL=${ZSH_VCS_PROMPT_CLEAN_SIGIL:-'✔ '}

## Prompt formats.
#   #s : The VCS name (e.g. git svn hg).
#   #a : The action name.
#   #b : The current branch name.
#
#   #c : The ahead status.
#   #d : The behind status.
#
#   #e : The staged status.
#   #f : The conflicted status.
#   #g : The unstaged status.
#   #h : The untracked status.
#   #i : The stashed status.
#   #j : The clean status.

if [ -n "$BASH_VERSION" ]; then
    if ! type zsh > /dev/null 2>&1; then
        echo 'Error: zsh is not installed' 1>&2
        return 1
    fi

    ### Bash
    ## Git.
    # No action.
    if [ -z "$ZSH_VCS_PROMPT_GIT_FORMATS" ]; then
        ZSH_VCS_PROMPT_GIT_FORMATS=' (#s)[#b#c#d|#e#f#g#h#i#j]'
    fi
    # No action using python.
    # Default is empty.
    if [ -z "$ZSH_VCS_PROMPT_GIT_FORMATS_USING_PYTHON" ]; then
        ZSH_VCS_PROMPT_GIT_FORMATS_USING_PYTHON=''
    fi
    # Action.
    if [ -z "$ZSH_VCS_PROMPT_GIT_ACTION_FORMATS" ]; then
        ZSH_VCS_PROMPT_GIT_ACTION_FORMATS=' (#s)[#b:#a#c#d|#e#f#g#h#i#j]'
    fi

    ## Other vcs.
    # No action.
    if [ -z "$ZSH_VCS_PROMPT_VCS_FORMATS" ]; then
        ZSH_VCS_PROMPT_VCS_FORMATS=' (#s)[#b]'
    fi
    # Action.
    if [ -z "$ZSH_VCS_PROMPT_VCS_ACTION_FORMATS" ]; then
        ZSH_VCS_PROMPT_VCS_ACTION_FORMATS=' (#s)[#b:#a]'
    fi
else
    ### ZSH
    ## Git.
    # No action.
    if [ -z "$ZSH_VCS_PROMPT_GIT_FORMATS" ]; then
        # VCS name
        ZSH_VCS_PROMPT_GIT_FORMATS='(%{%B%F{yellow}%}#s%{%f%b%})'
        # Branch name
        ZSH_VCS_PROMPT_GIT_FORMATS+='[%{%B%F{red}%}#b%{%f%b%}'
        # Ahead and Behind
        ZSH_VCS_PROMPT_GIT_FORMATS+='#c#d|'
        # Staged
        ZSH_VCS_PROMPT_GIT_FORMATS+='%{%F{blue}%}#e%{%f%b%}'
        # Conflicts
        ZSH_VCS_PROMPT_GIT_FORMATS+='%{%F{red}%}#f%{%f%b%}'
        # Unstaged
        ZSH_VCS_PROMPT_GIT_FORMATS+='%{%F{yellow}%}#g%{%f%b%}'
        # Untracked
        ZSH_VCS_PROMPT_GIT_FORMATS+='#h'
        # Stashed
        ZSH_VCS_PROMPT_GIT_FORMATS+='%{%F{cyan}%}#i%{%f%b%}'
        # Clean
        ZSH_VCS_PROMPT_GIT_FORMATS+='%{%F{green}%}#j%{%f%b%}]'
    fi
    # No action using python.
    if [ -z "$ZSH_VCS_PROMPT_GIT_FORMATS_USING_PYTHON" ]; then
        # Default is empty.
        ZSH_VCS_PROMPT_GIT_FORMATS_USING_PYTHON=''
    fi
    # Action.
    if [ -z "$ZSH_VCS_PROMPT_GIT_ACTION_FORMATS" ]; then
        # VCS name
        ZSH_VCS_PROMPT_GIT_ACTION_FORMATS='(%{%B%F{yellow}%}#s%{%f%b%})'
        # Branch name
        ZSH_VCS_PROMPT_GIT_ACTION_FORMATS+='[%{%B%F{red}%}#b%{%f%b%}'
        # Action
        ZSH_VCS_PROMPT_GIT_ACTION_FORMATS+=':%{%B%F{red}%}#a%{%f%b%}'
        # Ahead and Behind
        ZSH_VCS_PROMPT_GIT_ACTION_FORMATS+='#c#d|'
        # Staged
        ZSH_VCS_PROMPT_GIT_ACTION_FORMATS+='%{%F{blue}%}#e%{%f%}'
        # Conflicts
        ZSH_VCS_PROMPT_GIT_ACTION_FORMATS+='%{%F{red}%}#f%{%f%}'
        # Unstaged
        ZSH_VCS_PROMPT_GIT_ACTION_FORMATS+='%{%F{yellow}%}#g%{%f%}'
        # Untracked
        ZSH_VCS_PROMPT_GIT_ACTION_FORMATS+='#h'
        # Stashed
        ZSH_VCS_PROMPT_GIT_ACTION_FORMATS+='%{%F{cyan}%}#i%{%f%}'
        # Clean
        ZSH_VCS_PROMPT_GIT_ACTION_FORMATS+='%{%F{green}%}#j%{%f%}]'
    fi

    ## Other vcs.
    # No action.
    if [ -z "$ZSH_VCS_PROMPT_VCS_FORMATS" ]; then
        # VCS name
        ZSH_VCS_PROMPT_VCS_FORMATS='(%{%B%F{yellow}%}#s%{%f%b%})'
        # Branch name
        ZSH_VCS_PROMPT_VCS_FORMATS+='[%{%B%F{red}%}#b%{%f%b%}]'
    fi
    # Action.
    if [ -z "$ZSH_VCS_PROMPT_VCS_ACTION_FORMATS" ]; then
        # VCS name
        ZSH_VCS_PROMPT_VCS_ACTION_FORMATS='(%{%B%F{yellow}%}#s%{%f%b%})'
        # Branch name
        ZSH_VCS_PROMPT_VCS_ACTION_FORMATS+='[%{%B%F{red}%}#b%{%f%b%}'
        # Action
        ZSH_VCS_PROMPT_VCS_ACTION_FORMATS+=':%{%B%F{red}%}#a%{%f%b%}]'
    fi
fi


## Initialize.
if [ -n "$BASH_VERSION" ]; then
    ## The exe directory.
    ZSH_VCS_PROMPT_DIR=$(cd "$(dirname "$BASH_SOURCE")" && pwd)
else
    ## The exe directory.
    ZSH_VCS_PROMPT_DIR=$(cd "$(dirname "$0")" && pwd)

    ## Source "lib/vcsstatus*.sh".
    # Enable to use the function _zsh_vcs_prompt_vcs_detail_info
    source $ZSH_VCS_PROMPT_DIR/lib/vcsstatus.sh

    # Register precmd hook function
    autoload -Uz add-zsh-hook \
        && add-zsh-hook precmd _zsh_vcs_prompt_precmd_hook_func
fi
# vcs info status (cache data).
ZSH_VCS_PROMPT_VCS_STATUS=''


## This function is called in PROMPT or RPROMPT.
function vcs_super_info() {
    if [ -n "$BASH_VERSION" ]; then
        _zsh_vcs_prompt_update_vcs_status
        echo "$ZSH_VCS_PROMPT_VCS_STATUS"
        return 0
    fi

    if [ "$ZSH_VCS_PROMPT_ENABLE_CACHING" != 'true' ]; then
        _zsh_vcs_prompt_update_vcs_status
    fi
    echo "$ZSH_VCS_PROMPT_VCS_STATUS"
}


function _zsh_vcs_prompt_precmd_hook_func() {
    if [ "$ZSH_VCS_PROMPT_ENABLE_CACHING" = 'true' ]; then
        _zsh_vcs_prompt_update_vcs_status
    fi
}


function _zsh_vcs_prompt_update_vcs_status() {
    # Parse raw data.
    local raw_data="$(vcs_super_info_raw_data)"
    if [ -z "$raw_data" ]; then
        ZSH_VCS_PROMPT_VCS_STATUS=''
        return 0
    fi

    local -a vcs_status
    if [ -n "$BASH_VERSION" ]; then
        IFS=$'\n' vcs_status=($raw_data)
        vcs_status=("" "${vcs_status[@]}")
    else
        vcs_status=("${(f)raw_data}")
    fi

    local using_python=${vcs_status[1]}
    local vcs_name=${vcs_status[2]}
    local action=${vcs_status[3]}
    local branch=${vcs_status[4]}
    local ahead=${vcs_status[5]}
    local behind=${vcs_status[6]}
    local staged=${vcs_status[7]}
    local conflicts=${vcs_status[8]}
    local unstaged=${vcs_status[9]}
    local untracked=${vcs_status[10]}
    local stashed=${vcs_status[11]}
    local clean=${vcs_status[12]}

    # Select formats.
    local used_formats
    if [ "$vcs_name" = 'git' ]; then
        used_formats="$ZSH_VCS_PROMPT_GIT_ACTION_FORMATS"
        if [ -z "$action" -o "$action" = '0' ]; then
            if [ "$using_python" = '1' -a -n "$ZSH_VCS_PROMPT_GIT_FORMATS_USING_PYTHON" ]; then
                used_formats="$ZSH_VCS_PROMPT_GIT_FORMATS_USING_PYTHON"
            else
                used_formats="$ZSH_VCS_PROMPT_GIT_FORMATS"
            fi
        fi
    else
        used_formats="$ZSH_VCS_PROMPT_VCS_ACTION_FORMATS"
        if [ -z "$action" -o "$action" = '0' ]; then
            used_formats="$ZSH_VCS_PROMPT_VCS_FORMATS"
        fi
    fi

    # Escape slash '/'.
    branch=$(echo "$branch" | sed 's%/%\\/%')

    # Set sigil.
    vcs_name=$(_zsh_vcs_prompt_set_sigil "$vcs_name")
    action=$(_zsh_vcs_prompt_set_sigil "$action")
    branch=$(_zsh_vcs_prompt_set_sigil "$branch")
    ahead=$(_zsh_vcs_prompt_set_sigil "$ahead" "$ZSH_VCS_PROMPT_AHEAD_SIGIL")
    behind=$(_zsh_vcs_prompt_set_sigil "$behind" "$ZSH_VCS_PROMPT_BEHIND_SIGIL")
    staged=$(_zsh_vcs_prompt_set_sigil "$staged" "$ZSH_VCS_PROMPT_STAGED_SIGIL")
    conflicts=$(_zsh_vcs_prompt_set_sigil "$conflicts" "$ZSH_VCS_PROMPT_CONFLICTS_SIGIL")
    unstaged=$(_zsh_vcs_prompt_set_sigil "$unstaged" "$ZSH_VCS_PROMPT_UNSTAGED_SIGIL")
    untracked=$(_zsh_vcs_prompt_set_sigil "$untracked" "$ZSH_VCS_PROMPT_UNTRACKED_SIGIL")
    stashed=$(_zsh_vcs_prompt_set_sigil "$stashed" "$ZSH_VCS_PROMPT_STASHED_SIGIL")
    if [ "$clean" = '1' ]; then
        clean="$ZSH_VCS_PROMPT_CLEAN_SIGIL"
    elif [ "$clean" = '0' ]; then
        clean=''
    fi

    # Compose prompt status.
    local prompt_info
    prompt_info=$(echo "$used_formats" | sed \
        -e "s/#s/$vcs_name/" \
        -e "s/#a/$action/" \
        -e "s/#b/$branch/" \
        -e "s/#c/$ahead/" \
        -e "s/#d/$behind/" \
        -e "s/#e/$staged/" \
        -e "s/#f/$conflicts/" \
        -e "s/#g/$unstaged/" \
        -e "s/#h/$untracked/" \
        -e "s/#i/$stashed/" \
        -e "s/#j/$clean/")

    ZSH_VCS_PROMPT_VCS_STATUS=$prompt_info
}

# Helper function.
function _zsh_vcs_prompt_set_sigil() {
    if [ -z "$1" -o "$1" = '0' ]; then
        return
    fi
    echo "$2$1"
}


## Get the raw data of vcs info.
#
# Output:
#   using_python : Using python flag. (Using python : 1, Not using python : 0)
#   vcs_name  : The vcs name string.
#   action    : Action name string. (No action : 0)
#   branch    : Branch name string.
#   ahead     : Ahead count. (No ahead : 0)
#   behind    : Behind count. (No behind : 0)
#   staged    : Staged count. (No staged : 0)
#   conflicts : Conflicts count. (No conflicts : 0)
#   unstaged  : Unstaged count. (No unstaged : 0)
#   untracked : Untracked count.(No untracked : 0)
#   stashed   : Stashed count.(No stashed : 0)
#   clean     : Clean flag. (Clean is 1, Not clean is 0, Unknown is ?)
#
function vcs_super_info_raw_data() {
    local using_python=0

    # Use python
    if [ "$ZSH_VCS_PROMPT_USING_PYTHON" = 'true' ] \
        && type python > /dev/null 2>&1 \
        && type git > /dev/null 2>&1 \
        && [ "$(command git rev-parse --is-inside-work-tree 2> /dev/null)" = "true" ]; then

        # Check python command.
        local cmd_gitstatus="${ZSH_VCS_PROMPT_DIR}/lib/gitstatus-fast.py"
        if [ ! -f "$cmd_gitstatus" ]; then
            echo "[ zsh-vcs-prompt error: ${ZSH_VCS_PROMPT_DIR}/lib/gitstatus-fast.py is not found ]" 1>&2
            return 1
        fi

        # Get vcs status.
        local git_status="$(python "$cmd_gitstatus" 2>/dev/null)"
        if [ -n "$git_status" ];then
            using_python=1
            local vcs_name='git'
            local vcs_action=0
            # Output result.
            echo "$using_python"
            echo "$vcs_name"
            echo "$vcs_action"
            echo "$git_status"
            return 0
        fi
    fi

    # Don't use python.
    local vcs_status

    if type _zsh_vcs_prompt_vcs_detail_info > /dev/null 2>&1; then
        # Run the sourced function.
        vcs_status="$(_zsh_vcs_prompt_vcs_detail_info)"
    else
        # Run the external script
        local cmd_run_vcsstatus="${ZSH_VCS_PROMPT_DIR}/lib/run-vcsstatus.sh"
        if [ ! -f "$cmd_run_vcsstatus" ]; then
            echo "[ zsh-vcs-prompt error: ${ZSH_VCS_PROMPT_DIR}/lib/run-vcsstatus.sh is not found ]" 1>&2
            return 1
        fi
        vcs_status="$("$cmd_run_vcsstatus")"
    fi

    if [ -z "$vcs_status" ]; then
        return 0
    fi

    # Output result.
    echo "$using_python"
    echo "$vcs_status"

    return 0
}

# vim: ft=zsh

