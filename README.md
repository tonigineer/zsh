# ZSH Configuration

A lightweight, plugin-based Zsh setup without [oh-my-zsh](https://ohmyz.sh/).
Plugins bootstrap automatically on first launch.
Part of my [dotfiles](https://github.com/tonigineer/dotfiles).

## Features

- **Auto-suggestions** — Inline suggestions from history and completions
- **Syntax highlighting** — Real-time command validation
- **Vi mode** — `jk` to escape insert mode
- **Git status** — Branch and dirty-state in prompt via [gitstatus](https://github.com/romkatv/gitstatus)
- **Yazi integration** — `y` wrapper changes directory on quit

## Prompt

Two-line prompt with an active vi-mode indicator (insert vs. command).
Built with `zle-line-init` and `zle-keymap-select` redraw hooks.
Uses the 256-color palette for consistent theming across terminals.

## Requirements

- Zsh 5.0+
- Git (for plugin bootstrapping)
- Optional: [Yazi](https://github.com/sxyazi/yazi) for the file-manager wrapper

## File layout

| File | Purpose |
|------|---------|
| `.zshrc` | Entry point: plugins, history, key bindings, utilities |
| `prompt.zsh` | Prompt builder and zle redraw widgets |

## Installation

```sh
git clone https://github.com/tonigineer/zsh.git ~/.config/zsh
ln -s ~/.config/zsh/.zshrc ~/.zshrc
```

Start a new shell. The four plugins clone and load on first run.
