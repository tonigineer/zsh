# ZSH configuration

This is a simple customization of my [ZSH](https://www.zsh.org/) shell, without using [oh-my-zsh](https://ohmyz.sh/). This configuration is part of my [dotfiles](https://github.com/tonigineer/dotfiles).

## Features

All features are bootstrapped during the first startup:

- [x] Auto-suggestions
- [x] Syntax highlighting
- [x] VI mode
- [x] Git status integration

## Installation

To install the configuration, clone this repository into your user config folder and ensure that the `.zshrc` file is properly loaded:

```sh
git clone https://github.com/tonigineer/zsh.git ~/.config/zsh

# Symlink .zshrc to your home directory (alternative: set ZDOTDIR in your environment)
ln -s ~/.config/zsh/.zshrc ~/.zshrc
```
