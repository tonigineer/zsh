# ZSH configuration

Simple customization of my [zsh](https://www.zsh.org/) shell.

<kbd><img alt="preview-zsh-prompt" src="./assets/preview.png" style="width: 600px;"/></kbd>

> [!NOTE]
> [Here](https://github.com/tonigineer/.dotfiles), you can find all of my [Hyprland](https://hyprland.org/) configuration.

## Dependencies

Make sure to have a [NerdFont](https://www.nerdfonts.com/font-downloads) installed:

```sh
# Example
wget -P ~/Downloads https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/CascadiaCode.zip
unzip ~/Downloads/CascadiaCode.zip -d ~/.fonts

fc-cache -v
fc-list | grep Cas*  # check if it worked
```

## Installation

Simply clone this repository into your user config folder and take care, that the `.zshrc` will be loaded:

```sh
git clone https://github.com/tonigineer/zsh.git ~/.config/zsh

# Symlink .zshrc (alt: set ZDOTDIR in env)
ln -s ~/.config/zsh/.zshrc ~/.zshrc
```

> [!IMPORTANT]
> All plugins will be installed automatically.
