-- Disable spell checking, as it doesn't work in files with multiple languages
vim.opt.spell = false
-- Enable line wrapping
vim.opt.wrap = true
vim.opt.timeoutlen = 5000

-- Indentation
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.list = true

-- Invisible chars
vim.opt.list = true
vim.opt.listchars = {eol = '¬', tab = '>-', trail = '~', extends = '>', precedes = '<'}

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.termguicolors = true
vim.opt.encoding = "utf-8"

-- Scrolling
vim.opt.scrolloff = 3

-- Line numbers
vim.opt.number = true

-- Disable backup
vim.opt.swapfile = false
vim.opt.backup = false


vim.opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus" -- Sync with system clipboard
vim.opt.cursorline = true -- Enable highlighting of the current line

-- Enable automatic file reloading to aid in AI development
vim.opt.autoread = true
