Dotfiles
========

Personal configs I use.

### Tmux

- Leader: `Ctrl + a`
- Horizontal split: `<Leader> + -`
- Vertical split: `<Leader> + \`
- Cycle panes: `<Leader> + Ctrl + a`
- Move between panes: `<Leader> + h/j/k/l`, resize: `<Leader> + Ctrl + h/j/k/l`
- Reload config: `<Leader> + r`

### VIM / Neovim

Neovim reuses the Vim config: `nvim/init.vim` loads `~/.vimrc` and the plugins in `~/.vim`.

Plugins (managed by Vundle):
- Vundle.vim
- fzf + fzf.vim (`,f` git files, `,F` all files)
- vim-colors-solarized (Solarized light)
- rainbow_parentheses
- vim-fugitive
- vim-surround
- Command-T
- NerdCommenter
- NerdTree (`F2`)
- vim-airline
- CamelCaseMotion
- vim-easymotion
- vim-elixir, vim-markdown, tabular, editorconfig-vim
- Tagbar (`F8`)
- copilot.vim
- avante.nvim (experimental, not set up yet) and its deps: dressing.nvim, plenary.nvim, nui.nvim,
  mega.logging, mega.cmdparse, nvim-web-devicons, img-clip.nvim, copilot.lua

### i3

Base config from i3-config-wizard, plus:
- ThinkPad media keys: volume and mic mute (`wpctl`), brightness (`brightnessctl`)
- Screenshots to `~/Pictures` and the clipboard: `Print` (desktop), `Alt + Print` (focused window), `Shift + Print` (selection)
- `$mod + Ctrl + l` locks the screen
- US + Lithuanian layouts (`Alt + Shift` to switch), Caps-Lock as Control
- Redshift night mode
- Idle handling (`bin/idle-manager`): blank + lock after 10 min, suspend after 15 min on battery.
  Skipped while video plays, the mic is in use (calls), or "stay awake" is toggled with `$mod + Shift + a`.

### bin

Added to `PATH` in `~/.zshrc`.

- `notes`: open today's note in `~/Documents/notes`
- `multimonitor.sh`: extend the laptop screen to HDMI-1 and DP-2
- `idle-manager`, `mic-in-use`, `stay-awake-toggle`: i3 idle handling (see above)
- `fake-mailer.sh`: dump mail to `/tmp/fake-mailer` instead of sending it

Installation
------------

Tested on Ubuntu 26.04 with the i3 X11 session.

- `git clone git@github.com:flakas/dotfiles.git ~/dotfiles`
- Install dependencies:

  ```
  sudo apt install i3 xserver-xorg-core xserver-xorg-input-libinput \
    tmux neovim git build-essential fzf universal-ctags \
    xss-lock i3lock xssproxy xprintidle brightnessctl scrot xclip redshift dunst dex
  ```

- Symlink:
  * `i3/` -> `~/.config/i3`
  * `nvim/` -> `~/.config/nvim`
  * `tmux/.tmux.conf` -> `~/.tmux.conf`
  * `vim/.vimrc` -> `~/.vimrc`
  * `redshift/redshift.conf` -> `~/.config/redshift/redshift.conf`
- Add `bin/` to `PATH` in `~/.zshrc`: `export PATH="$HOME/dotfiles/bin:$PATH"`
- Install Vim plugins:
  * `git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim`
  * `nvim +PluginInstall +qall`
  * Build Command-T: `make -C ~/.vim/bundle/Command-T/lua/wincent/commandt/lib`
