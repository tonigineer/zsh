# The prompt is built around the function to determine
# the current VI Mode.

# Color codes
# https://gist.github.com/JBlond/2fea43a3049b38287e5e9cefc87b2124?permalink_comment_id=3892823#gistcomment-3892823

viinsert='%F{green}%S I %s%f'
vicommand='%F{red}%S N %s%f'
# vivisual='%F{yellow}%S V %s%f'
# vireplace='%F{red}%S %K{white}R%k %s%f'

function zle-line-init zle-keymap-select {
    case $KEYMAP in
        (vicmd)       VIMODE=$vicommand ;;
        (viins|main)  VIMODE=$viinsert  ;;
        # Is there a vireplace and vivisual I don't know about?
    esac

    PROMPT='$VIMODE '

    # --- From here on the `actual` prompt is defined ---
    # Time
    PROMPT+='%239F%D{%H:%M}%f '

    # Username and host
    PROMPT+='%39F%n%8F:%222F%m%f '

    # Directory
    PROMPT+='%255F%$((-${#GITSTATUS_PROMPT}-1))<…<%~%<<%f '

    # Git status
    PROMPT+='${GITSTATUS_PROMPT:+ %255F⌜%210F%f $GITSTATUS_PROMPT⌟%f}'

    # Two line command prompt
    PROMPT+=$'\n'

    # %/# (normal/root); green/red (ok/error)
    PROMPT+='~%F{%(?.15.210)} ❯ %f'


    zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select