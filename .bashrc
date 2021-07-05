#!/bin/bash
#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return


# Platform specific stuff
unameOut="$(uname -s)"
case "${unameOut}" in
    MINGW*)
        eval `dircolors ~/.dir_colors`

        ;;
    Linux*)
        . /etc/profile.d/vte.sh

        # cross toolchain
        if [ -f $HOME/Projects/sp3/current_toolchains/set_path.sh ]; then
            source $HOME/Projects/sp3/current_toolchains/set_path.sh
        fi

        # launch ssh-agent if not running yet and set env to use it
        if ! pgrep -u "$USER" ssh-agent > /dev/null; then
            ssh-agent -t 1h > "$XDG_RUNTIME_DIR/ssh-agent.env"
        fi
        if [[ ! "$SSH_AUTH_SOCK" ]]; then
            source "$XDG_RUNTIME_DIR/ssh-agent.env" >/dev/null
        fi

        ;;
    Darwin*)    ;;
    CYGWIN*)    ;;
    *)   ;;
esac

# Powerline style promp
if [ -f $HOME/.bash/prompt.sh ]; then
    source $HOME/.bash/prompt.sh
fi


alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias vim='nvim'
alias tmux='tmux -2'

# alias for dotfiles git and autocomplete alias
alias config='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
complete -F _complete_alias config


export VISUAL=nvim
export EDITOR=nvim

