#!/bin/bash
#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Windows only
if [[ "$OSTYPE" == "msys" ]]; then
    if [ -f "$HOME/.bash/dir_colors" ]; then
        eval "$(dircolors "$HOME/.bash/dir_colors")"
    fi
    XDG_RUNTIME_DIR=${XDG_RUNTIME_DIR:-'/tmp'}
    USER=${USER:-$USERNAME}
fi

# VTE stuff :/
if [ -f /etc/profile.d/vte.sh ]; then
    source /etc/profile.d/vte.sh
fi

# Cross compilation toolchain
if [ -f "$HOME/Projects/sp3/current_toolchains/set_path.sh" ]; then
    source "$HOME/Projects/sp3/current_toolchains/set_path.sh"
fi

# launch ssh-agent if not running yet and set env to use it
if [[ ! `ps -u "$UID" | grep ssh-agent` ]]; then
    ssh-agent -t 1h > "$XDG_RUNTIME_DIR/ssh-agent.env"
fi
if [[ ! "$SSH_AUTH_SOCK" ]]; then
    source "$XDG_RUNTIME_DIR/ssh-agent.env" > /dev/null
fi

# Starship prompt
eval "$(starship init bash)"

# Python pip installed executables script path
PATH="$PATH:$HOME/.local/bin"
# rustup binaries
PATH="$PATH:$HOME/.cargo/bin"
# go binaries
PATH="$PATH:$HOME/go/bin"

alias ls='ls --color=auto'
alias grep='grep --color=auto'

# alias for dotfiles git and autocomplete alias
alias config='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
complete -F _complete_alias config

# make xargs expands alias
alias xargs='xargs '

export VISUAL=nvim
export EDITOR=nvim
export DIFFPROG='nvim -d'
export MANPAGER='nvim -c "%! col -b" -c "set ft=man nomod | let &titlestring=$MAN_PN"'
alias pacdiff='sudo -H DIFFPROG="nvim -d" pacdiff'

alias arch-maintenance='bash $HOME/.bash/arch-maintenance.sh'

echo -e "(o)> \n//\\ \nV_/_"
