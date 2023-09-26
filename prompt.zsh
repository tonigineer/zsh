# Color codes
# https://gist.github.com/JBlond/2fea43a3049b38287e5e9cefc87b2124?permalink_comment_id=3892823#gistcomment-3892823


# VIM mode indicator - insert not shown after successful command, fixing needed
# https://stackoverflow.com/questions/3622943/zsh-vi-mode-status-line
PROMPT='${${KEYMAP/vicmd/%210F󰍽%f}/main/%10F%f}  '
# Time
PROMPT+='%239F%D{%H:%M}%f '
# Username and host
PROMPT+='%39F%n%8F:%222F%m%f '
# Working dir
# subfolder only as on char needed
PROMPT+='%255F%$((-${#vcs_info_msg_0_}-1))<…<%~%<<%f '
# Git status
PROMPT+='${vcs_info_msg_0_:+ %255F⌜%210F%f %39F$vcs_info_msg_0_}%255F⌟%f'
PROMPT+=$'\n'
 # %/# (normal/root); green/red (ok/error)
PROMPT+='%F{%(?.15.210)}❯ %f '
