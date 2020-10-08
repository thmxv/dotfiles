#!/bin/bash
#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

unameOut="$(uname -s)"
case "${unameOut}" in
    MINGW*)
        eval `dircolors ~/.dir_colors`
        #alias python='winpty python.exe'
        #alias nvim='winpty nvim.exe'
        #alias vim='nvim'
        ;;
    Linux*)
        . /etc/profile.d/vte.sh

        # Launch tmux, only if interactive and inside X
        #if [[ $DISPLAY ]]; then
        #    [[ -z "$TMUX" ]] && exec tmux
        #fi

        # cross toolchain
        . $HOME/Projects/sp3/current_toolchains/set_path.sh

        #alias vim='nvim'
        ;;
    Darwin*)    ;;
    CYGWIN*)    ;;
    *)   ;;
esac

if [ -f $HOME/.bash/bashrc_prompt ]; then
    . $HOME/.bash/bashrc_prompt
fi


alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias vim='nvim'
alias tmux='tmux -2'

alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
complete -F _complete_alias config


export VISUAL=vim
export EDITOR=vim

