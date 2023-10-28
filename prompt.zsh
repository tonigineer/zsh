# COLOR ID's https://gist.github.com/JBlond/2fea43a3049b38287e5e9cefc87b2124?permalink_comment_id=3892823#gistcomment-3892823

viinsert='%7F[%2F%7F]%f '
vicommand='%7F[%1F%7F]%f '

PRPT_VIM=$viinsert
PRPT_TIME='%8F%D{%H:%M}%f '
PRPT_USR='%12F%n%8F:%11F%m%f '
PRPT_DIR='%15F%$((-${#GITSTATUS_PROMPT}-1))<…<%~%<<%f '
PRPT_GIT='${GITSTATUS_PROMPT:+ %8F⌜%9F%f $GITSTATUS_PROMPT%8F⌟%f}'
PRPT_BR=$'\n'
PRPT_PRPT='~%F{%(?.15.9)} ❯ %f'

# WORKAROUND: otherwise, VI mode must change once to display wanted prompt
PS1=$PRPT_VIM$PRPT_TIME$PRPT_USR$PRPT_DIR$PRPT_GIT$PRPT_BR$PRPT_PRPT

function zle-line-init zle-keymap-select {
    case $KEYMAP in
        (vicmd)       PRPT_VIM=$vicommand ;;
        (viins|main)  PRPT_VIM=$viinsert  ;;
        (*)           PRPT_VIM=$viinsert  ;;
        # Is there a vireplace and vivisual I don't know about?
    esac

    PS1=$PRPT_VIM$PRPT_TIME$PRPT_USR$PRPT_DIR$PRPT_GIT$PRPT_BR$PRPT_PRPT

    zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select