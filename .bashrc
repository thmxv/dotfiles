#!/bin/bash
#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Windows colors
if [[ "$OSTYPE" == "msys" ]] && [ -f $HOME/.bash/dir_colors ]; then
    eval `dircolors $HOME/.bash/dir_colors`
fi

# VTE stuff :/
if [ -f /etc/profile.d/vte.sh ]; then
    source /etc/profile.d/vte.sh
fi

# Cross compilation toolchain
if [ -f $HOME/Projects/sp3/current_toolchains/set_path.sh ]; then
    source $HOME/Projects/sp3/current_toolchains/set_path.sh
fi

# launch ssh-agent if not running yet and set env to use it
if [[ "$OSTYPE" == "msys" ]] && [ -z $XDG_RUNTIME_DIR ]; then
    XDG_RUNTIME_DIR="/tmp"
fi
if [[ ! `ps -u "$UID" | grep ssh-agent` ]]; then
    ssh-agent -t 1h > "$XDG_RUNTIME_DIR/ssh-agent.env"
fi
if [[ ! "$SSH_AUTH_SOCK" ]]; then
    source "$XDG_RUNTIME_DIR/ssh-agent.env" > /dev/null
fi

# Powerline style promp
if [[ "$OSTYPE" != "msys" ]] && [ -f $HOME/.bash/prompt.sh ]; then
    source $HOME/.bash/prompt.sh
fi

alias ls='ls --color=auto'
alias grep='grep --color=auto'

# alias for dotfiles git and autocomplete alias
alias config='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
complete -F _complete_alias config

export VISUAL=nvim
export EDITOR=nvim
export DIFFPROG='nvim -d'
alias pacdiff='sudo -H DIFFPROG="nvim -d" pacdiff'

alias arch-maintenance='bash $HOME/.bash/arch-maintenance.sh'

