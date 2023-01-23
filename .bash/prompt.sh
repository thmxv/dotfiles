# nightfox colors
declare -A TRUELINE_COLORS=(
    [bg0]='19;26;36'
    [bg1]='25;35;48'  # Default bg
    [bg2]='33;46;63'
    [bg3]='41;57;79'
    [bg4]='57;80;109'

    [fg0]='214;214;215'
    [fg1]='205;206;207'  # Default fg
    [fg2]='174;175;176'
    [fg3]='113;131;155'

    [sel0]='43;59;81'  # Default selection bg
    [sel1]='60;83;114'

    [comment]='115;148;145'

    [black]='57;59;68'
    [blue]='113;156;214'
    [cyan]='99;205;207'
    [green]='129;178;154'
    [magenta]='157;121;214'
    [orange]='244;162;97'
    [pink]='214;122;210'
    [red]='201;79;109'
    [white]='223;223;224'
    [yellow]='219;192;116'
)

declare -A TRUELINE_SYMBOLS=(
    [working_dir_home]='~'
    [newline]='$'
    [newline_root]='#'
    [exit_status]=''
)

declare -a TRUELINE_SEGMENTS=(
    'exit_status,red,bg2,bold'
    'my_newline,,,'
    'user,bg1,fg2,bold'
    'venv,bg1,violet,bold'
    'git,bg1,fg1,normal'
    'working_dir,bg1,fg3,normal'
    'read_only,bg1,orange,normal'
    'my_newline,,,'
    'bg_jobs,bg1,yellow,normal'
    'prompt_char,bg1,fg2,bold'
)

TRUELINE_GIT_MODIFIED_COLOR='red'
TRUELINE_GIT_BEHIND_AHEAD_COLOR='bg1'
TRUELINE_USER_ROOT_COLORS=('bg1' 'orange')
# TRUELINE_USER_ALWAYS_SHOW_HOSTNAME=true
TRUELINE_WORKING_DIR_SPACE_BETWEEN_PATH_SEPARATOR=true
TRUELINE_PROMPT_CHAR_ROOT_COLORS=('bg1' 'orange')

_trueline_my_newline_segment() {
    local fg_color="$1"
    local bg_color="$2"
    local font_style="$3"
    local segment="$(_trueline_separator default_bg)"
    segment+="\n"
    PS1+="$segment"
    unset _last_color
}

_trueline_prompt_char_segment() {
    local fg_color="$1"
    local bg_color="$2"
    local font_style="$3"
    local is_root="$(_trueline_is_root)"
    local newline_symbol="${TRUELINE_SYMBOLS[newline]}"
    if [[ -n "$is_root" ]]; then
        fg_color=${TRUELINE_PROMPT_CHAR_ROOT_COLORS[0]}
        bg_color=${TRUELINE_PROMPT_CHAR_ROOT_COLORS[1]}
        local newline_symbol="${TRUELINE_SYMBOLS[newline_root]}"
    fi
    local segment="$(_trueline_separator)"
    segment+="$(_trueline_content "$fg_color" "$bg_color" "$font_style" " $newline_symbol ")"
    PS1+="$segment"
    _trueline_record_colors "$fg_color" "$bg_color" "$font_style" true
}

if [ -f $HOME/.bash/trueline/trueline.sh ]; then
    source $HOME/.bash/trueline/trueline.sh
fi

# Fix trueline ovberwriting vte
PROMPT_COMMAND="${PROMPT_COMMAND}; ${_PROMPT_COMMAND_OLD}"
