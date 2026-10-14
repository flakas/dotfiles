" Neovim reuses the Vim config and plugins from ~/.vim (see :h nvim-from-vim)
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
