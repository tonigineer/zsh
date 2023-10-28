
ZDOT_DIR=/home/$USER/.config/zsh

# -----------------------------
# ---------- SOURCING ---------
# # -----------------------------
[[ -f ~/.cargo/env ]] && . ~/.cargo/env
[[ -f ~/.bash_aliases ]] && . ~/.bash_aliases

[[ -d "$HOME/.local/bin" ]] && PATH="$HOME/.local/bin:$PATH"
[[ -d "$HOME/.cargo/bin" ]] && PATH="$HOME/.cargo/bin:$PATH"

# ------------------------------
# ---------- UTILITIES ---------
# ------------------------------
function load_plugin () {
    # Load plugin and clone if not available
    PLUGIN_NAME=$(echo $1 | cut -d "/" -f 2)

    if [ ! -d "$ZDOT_DIR/plugins/$PLUGIN_NAME" ]; then
        git clone "https://github.com/$1.git" "$ZDOT_DIR/plugins/$PLUGIN_NAME"

        # // Customizations
        if [[ "$1" = "romkatv/gitstatus" ]]; then
            # Change colors of git prompt to terminal colors.
            #
            # NOTE: Badly nested, but basically four color
            #       values are simply changed within file.
            while IFS='' read -r a; do
                echo "${"${"${"${a//'%196F'/%9F}"//'%39F'/%13F}"//'%178F'/%11F}"//'%76F'/%12F}"
            done < $ZDOT_DIR/plugins/gitstatus/gitstatus.prompt.zsh > $ZDOT_DIR/plugins/gitstatus/gitstatus.prompt.zsh.t
            mv $ZDOT_DIR/plugins/gitstatus/gitstatus.prompt.zsh{.t,}
        fi
    fi

    if [ "$2" = "." ]; then
        [[ -f "$ZDOT_DIR/plugins/$PLUGIN_NAME/$PLUGIN_NAME.plugin.zsh" ]] && \
            source "$ZDOT_DIR/plugins/$PLUGIN_NAME/$PLUGIN_NAME.plugin.zsh"
        [[ -f "$ZDOT_DIR/plugins/$PLUGIN_NAME/$PLUGIN_NAME.zsh" ]] && \
            source "$ZDOT_DIR/plugins/$PLUGIN_NAME/$PLUGIN_NAME.zsh"
    fi
}


# ----------------------------
# ---------- PLUGINS ---------
# ----------------------------
load_plugin zsh-users/zsh-autosuggestions .
{
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#444b6a,underline"  # bg=cyan,bold,underline
    ZSH_AUTOSUGGEST_STRATEGY=(history completion)
    setopt APPEND_HISTORY
    setopt SHARE_HISTORY
    HISTFILE=$HOME/.zhistory
    SAVEHIST=1000
    HISTSIZE=999
    setopt HIST_EXPIRE_DUPS_FIRST
    setopt EXTENDED_HISTORY
    bindkey '^ ' autosuggest-accept
}

load_plugin jeffreytse/zsh-vi-mode .
{
    ZVM_VI_INSERT_ESCAPE_BINDKEY='^['
    ZVM_VI_INSERT_ESCAPE_BINDKEY='jk'
}

load_plugin romkatv/gitstatus
{
    # Only prompt file that must be sourced,
    # different to the other. Therefore second
    # argument for load_plugin.
    source $ZDOT_DIR/plugins/gitstatus/gitstatus.prompt.zsh
}

load_plugin zsh-users/zsh-syntax-highlighting .
{
    # Must be loaded last
}


# ---------------------------
# ---------- VANITY ---------
# ---------------------------
source $ZDOT_DIR/prompt.zsh