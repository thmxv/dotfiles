#!/bin/bash
#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if [ -f $HOME/.bashrc_prompt ]; then
    . $HOME/.bashrc_prompt
fi

unameOut="$(uname -s)"
case "${unameOut}" in
    MINGW*)
        eval `dircolors ~/.dir_colors`
        alias python='winpty python.exe'
        #alias nvim='winpty nvim.exe'
        #alias vim='nvim'
        ;;
    Linux*)
        alias vim='nvim'
        ;;
    Darwin*)    ;;
    CYGWIN*)    ;;
    *)   ;;
esac

alias ls='ls --color=auto'
alias grep='grep -n --color'
#alias vim='nvim'

export VISUAL=vim
export EDITOR=vim

