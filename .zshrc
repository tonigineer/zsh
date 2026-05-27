ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"

# ———— SOURCING ————————————————————————————————————————————————————————————————

[[ -f ~/.cargo/env ]] && source ~/.cargo/env
[[ -f ~/.bash_aliases ]] && source ~/.bash_aliases

[[ -d "$HOME/.local/bin" ]] && PATH="$HOME/.local/bin:$PATH"
[[ -d "$HOME/.cargo/bin" ]] && PATH="$HOME/.cargo/bin:$PATH"

# ———— UTILITIES ———————————————————————————————————————————————————————————————

function load_plugin() {
    local repo="$1" autoload="$2"
    local plugin="${repo##*/}"
    local dir="$ZDOTDIR/plugins/$plugin"

    if [[ ! -d "$dir" ]]; then
        git clone --depth=1 "https://github.com/$repo.git" "$dir"

        if (( $? != 0 )); then
            echo "load_plugin: failed to clone $repo" >&2
            return 1
        fi

        if [[ "$repo" == "romkatv/gitstatus" ]]; then
            sed -i \
                -e 's/%196F/%9F/g' \
                -e 's/%39F/%13F/g' \
                -e 's/%178F/%11F/g' \
                -e 's/%76F/%12F/g' \
                "$dir/gitstatus.prompt.zsh"
        fi
    fi

    if [[ "$autoload" == "." ]]; then
        local file
        for file in "$plugin.plugin.zsh" "$plugin.zsh"; do
            [[ -f "$dir/$file" ]] && source "$dir/$file"
        done
    fi
}

# ———— PLUGINS —————————————————————————————————————————————————————————————————

load_plugin zsh-users/zsh-autosuggestions .
{
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#444b6a"
    ZSH_AUTOSUGGEST_STRATEGY=(history completion)
    bindkey '^ ' autosuggest-accept
}

load_plugin jeffreytse/zsh-vi-mode .
{
    ZVM_VI_INSERT_ESCAPE_BINDKEY='jk'
}

load_plugin romkatv/gitstatus
{
    source "$ZDOTDIR/plugins/gitstatus/gitstatus.prompt.zsh"
}

load_plugin zsh-users/zsh-syntax-highlighting .
{
    source "$ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
    ZSH_HIGHLIGHT_STYLES[path]=none
    ZSH_HIGHLIGHT_STYLES[path_prefix]=none
}

# ———— YAZI FILE MANAGER INTEGRATION ———————————————————————————————————————————

function y() {
    local tmp cwd
    tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
    trap 'rm -f -- "$tmp"' EXIT INT TERM

    yazi "$@" --cwd-file="$tmp"
    cwd="$(< "$tmp")"

    [[ -n "$cwd" && "$cwd" != "$PWD" ]] && builtin cd -- "$cwd"
}

# ———— HISTORY —————————————————————————————————————————————————————————————————

HISTFILE="${XDG_DATA_HOME:-$HOME/.local/share}/zsh/history"
[[ -d "${HISTFILE:h}" ]] || mkdir -p "${HISTFILE:h}"

HISTSIZE=10000
SAVEHIST=10000

setopt SHARE_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt EXTENDED_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE

# ———— PROMPT ——————————————————————————————————————————————————————————————————

source "$ZDOTDIR/prompt.zsh"
