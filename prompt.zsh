# Terminal color indices (256-color palette):
# https://gist.github.com/JBlond/2fea43a3049b38287e5e9cefc87b2124?permalink_comment_id=3892823#gistcomment-3892823

# vi-mode indicators
_p_vi_ins='%7F[%2F%7F]%f '
_p_vi_cmd='%7F[%1F%7F]%f '

# prompt components (globals because zle widgets mutate _p_vimode)
typeset -g _p_vimode=$_p_vi_ins
typeset -g _p_time='%8F%D{%H:%M}%f '
typeset -g _p_userhost='%14F%n%8F:%11F%m%f '
typeset -g _p_cwd='%15F%$((-${#GITSTATUS_PROMPT}-1))<…<%~%<<%f '
typeset -g _p_git='${GITSTATUS_PROMPT:+ %8F⌜%9F%f $GITSTATUS_PROMPT%8F⌟%f}'
typeset -g _p_prompt='~%(?.%F{15}.%F{9}) ❯ %f'

build_prompt() {
    PS1="${_p_vimode}${_p_time}${_p_userhost}${_p_cwd}${_p_git}"$'\n'"${_p_prompt}"
}

# prime prompt before any keymap event
build_prompt

# single body handles both widgets: set vi-mode segment then redraw
function zle-line-init zle-keymap-select {
    case $KEYMAP in
        vicmd) _p_vimode=$_p_vi_cmd ;;
        *)     _p_vimode=$_p_vi_ins  ;;
    esac
    build_prompt
    zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select
