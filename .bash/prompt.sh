# solarized colors
declare -A TRUELINE_COLORS=(
    # dark theme bg colors
    [base03]='0;43;54'      # bg default
    [base02]='7;54;66'      # bg higlights
    # fg colors
    [base01]='88;110;117'
    [base00]='101;123;131'  # light theme primary fg
    [base0]='131;148;150'   # dark theme primary fg
    [base1]='147;161;161'
    # light theme bg colors
    [base2]='238;232;213'   # bg highlight
    [base3]='253;246;227'   # bg default
    # accent colors
    [yellow]='181;137;0'
    [orange]='203;75;22'
    [red]='220;50;47'
    [magenta]='211;54;130'
    [violet]='108;113;196'
    [blue]='38;139;210'
    [cyan]='42;161;152'
    [green]='133;153;0'
)

declare -A TRUELINE_SYMBOLS=(
    [working_dir_home]='~'
    [newline]='$'
    [newline_root]='#'
    [exit_status]=''
)

# because the terminal use dark theme and we want to avoid to high contrasts
# we use solarized fg colors for bg and light theme bg colors for fg

declare -a TRUELINE_SEGMENTS=(
    # 'cmd_duration,base03,base01,normal'
    'exit_status,red,base02,bold'
    'my_newline,,,'
    'user,black,blue,bold'
    'aws_profile,base03,orange,bold'
    'venv,base03,violet,bold'
    'conda_env,base03,violet,bold'
    'git,base03,base1,normal'
    'working_dir,base03,base01,normal'
    'read_only,base03,orange,normal'
    'my_newline,,,'
    'bg_jobs,base03,yellow,normal'
    'prompt_char,base03,base01,bold'
)

TRUELINE_GIT_MODIFIED_COLOR='red'
TRUELINE_GIT_BEHIND_AHEAD_COLOR='violet'
TRUELINE_USER_ROOT_COLORS=('base03' 'red')
# TRUELINE_USER_ALWAYS_SHOW_HOSTNAME=true
TRUELINE_WORKING_DIR_SPACE_BETWEEN_PATH_SEPARATOR=true
TRUELINE_PROMPT_CHAR_ROOT_COLORS=('base03' 'orange')

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
