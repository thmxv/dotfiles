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

# DIY PS1 prompt pureline/powerline style

# returns a string with the powerline symbol for a section end
# arg: $1 is foreground color of the next section
# arg: $2 is background color of the next section
function section_end {
    if [ "$__last_color" == "$2" ]; then
        # Section colors are the same, use a foreground separator
        local end_char="${PL_SYMBOLS[soft_separator]}"
        local fg="$1"
    else
        # section colors are different, use a background separator
        local end_char="${PL_SYMBOLS[hard_separator]}"
        local fg="$__last_color"
    fi
    if [ -n "$__last_color" ]; then
        echo "${PL_COLORS[$fg]}${PL_COLORS[On_$2]}$end_char"
    fi
}

# returns a string with background and foreground colours set
# arg: $1 foreground color
# arg: $2 background color
# arg: $3 content
function section_content {
    echo "${PL_COLORS[$1]}${PL_COLORS[On_$2]}$3"
}

# append to prompt: end the current promptline and start a newline
function ps1_newline {
    if [ -n "$__last_color" ]; then
        PS1+="$(section_end $__last_color 'Default')"
    fi
    PS1+="\n"
    unset __last_color
}

function ps1_user {
    local bg_color="$1"
    local fg_color="$2"
    local content="\u@\h"
    PS1+="$(section_end $fg_color $bg_color)"
    PS1+="$(section_content $fg_color $bg_color " $content ")"
    __last_color="$bg_color"
}

function ps1_cwd {
    local bg_color="$1"
    local fg_color="$2"
    local content="\w"
    PS1+="$(section_end $fg_color $bg_color)"
    PS1+="$(section_content $fg_color $bg_color " $content ")"
    __last_color="$bg_color"
}

function ps1_read_only {
    local bg_color="$1"
    local fg_color="$2"
    if [ ! -w "$PWD" ]; then
        PS1+="$(section_end $fg_color $bg_color)"
        PS1+="$(section_content $fg_color $bg_color " ${PL_SYMBOLS[read_only]} ")"
        __last_color="$bg_color"
    fi
}

function ps1_git {
    local git_branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)
    if [ -n "$git_branch" ]; then
        local bg_color="$1"
        local fg_color="$2"
        local content="${PL_SYMBOLS[git_branch]} $git_branch"

        if [ -n "$(git status --porcelain)" ]; then
            if [ -n "$PL_GIT_DIRTY_FG" ]; then
                fg_color="$PL_GIT_DIRTY_FG"
            fi
            if [ -n "$PL_GIT_DIRTY_BG" ]; then
                bg_color="$PL_GIT_DIRTY_BG"
            fi
        fi

        PS1+="$(section_end $fg_color $bg_color)"
        PS1+="$(section_content $fg_color $bg_color " $content ")"
        __last_color="$bg_color"
    fi
}

function ps1_return_code {
    if [ ! "$__return_code" -eq 0 ]; then
        local bg_color="$1"
        local fg_color="$2"
        local content=" ${PL_SYMBOLS[return_code]} $__return_code "
        PS1+="$(section_end $fg_color $bg_color)"
        PS1+="$(section_content $fg_color $bg_color "$content")"
        __last_color="$bg_color"
    fi
}

function prompt_char {
    [[ ${EUID} -eq 0 ]] && echo "#" || echo "$"
}

function ps1_prompt {
    local bg_color="$1"
    local fg_color="$2"
    local content=" $(prompt_char) "
    PS1+="$(section_end $fg_color $bg_color)"
    PS1+="$(section_content $fg_color $bg_color "$content")"
    __last_color="$bg_color"
}

function diy_ps1 {
    __return_code=$?    # save the return code
    PS1=""              # reset the command prompt
    PS1+="\[\033]0;$TITLEPREFIX:$PWD\007\]" # set terminal title

    # set the prompt as we want
    ps1_newline Default Default
    ps1_user Blue Default
    ps1_cwd White Black
    ps1_read_only White Black
    ps1_git Yellow Default
    ps1_newline Default Default
    ps1_return_code Red Default
    ps1_prompt White Black

    # final end point
    if [ -n "$__last_color" ]; then
        PS1+="$(section_end $__last_color 'Default')"
    fi

    # cleanup
    PS1+="${PL_COLORS[Color_Off]}"
    if [ "$PL_ERASE_TO_EOL" = true ]; then
        PS1+="\[\e[K\]"
    fi
    PS1+=" "
    unset __last_color
    unset __return_code
}

# define the basic color set
declare -A PL_COLORS=(
[Color_Off]='\[\e[0m\]'       # Text Reset
# Foreground
[Default]='\[\e[0;39m\]'      # Default
[Black]='\[\e[0;30m\]'        # Black
[Red]='\[\e[0;31m\]'          # Red
[Green]='\[\e[0;32m\]'        # Green
[Yellow]='\[\e[0;33m\]'       # Yellow
[Blue]='\[\e[0;34m\]'         # Blue
[Purple]='\[\e[0;35m\]'       # Purple
[Cyan]='\[\e[0;36m\]'         # Cyan
[White]='\[\e[0;37m\]'        # White
# Background
[On_Default]='\[\e[49m\]'     # Default
[On_Black]='\[\e[40m\]'       # Black
[On_Red]='\[\e[41m\]'         # Red
[On_Green]='\[\e[42m\]'       # Green
[On_Yellow]='\[\e[43m\]'      # Yellow
[On_Blue]='\[\e[44m\]'        # Blue
[On_Purple]='\[\e[45m\]'      # Purple
[On_Cyan]='\[\e[46m\]'        # Cyan
[On_White]='\[\e[47m\]'       # White
)

# default symbols are intended for 'out-ofthe-box' compatibility.
# symbols from code page 437: character set of the original IBM PC
declare -A PL_SYMBOLS=(
[hard_separator]=""
[soft_separator]=""
[git_branch]=""
[read_only]=""
[return_code]="⚑"
)

PROMPT_COMMAND="diy_ps1; $PROMPT_COMMAND"

# TODO: prowerline separator, git branch icon, color variables
#PS1=''
#PS1+='\[\033]0;$TITLEPREFIX:$PWD\007\]'     # set terminal title
#PS1+='\[\033[41m\]`nonzero_return`\[\033[40m\]\n'
#PS1+='\[\033[32m\]\u@\h '
#PS1+='\[\033[35m\]$MSYSTEM '
#PS1+='\[\033[33m\]\w'
#PS1+='\[\033[36m\]`__git_ps1`'
#PS1+='\[\033[0m\]\n$'


