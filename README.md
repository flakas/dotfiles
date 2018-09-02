Dotfiles
========

Personal configs I use.

### Tmux

- Leader: `Ctrl + a`
- Horizontal split: `<Leader> + -`
- Vertical split: `<Leader> + |`
- Toggle panes: `<Leader> + a`

### VIM

Plugins:
- Vundle.vim
- vim-colors-solarized (Solarized light)
- rainbow_parentheses
- vim-fugitive
- vim-surround
- Command-T
- NerdCommenter
- NerdTree
- vim-airline
- CamelCaseMotion
- vim-easymotion

### i3

Mostly base configuration with ThinkPad specific hotkey bindings.

Installation
------------

- `git clone git@github.com:flakas/dotfiles.git`
- Symlink:
  * `i3/` -> `~/.config/i3`
  * `tmux/.tmux.conf` -> `~/.tmux.conf`
  * `vim/.vimrc` -> `~/.vimrc`
- Follow Command-T setup instructions

### i3

To get screen brightness controls to work `xbacklight` is necessary.

But if `xbacklight` returns `No outputs have backlight property`, then add this to `/etc/X11/xorg.conf`:

```
  Section "Device"
     Identifier  "Intel Graphics"
     Driver      "intel"
  EndSection
```
