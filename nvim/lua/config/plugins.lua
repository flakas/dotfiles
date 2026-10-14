-- Custom plugin configs

-- Enable LSP diagnostics globally
-- Shows the first linting error inline
vim.diagnostic.config({ virtual_text = true })

-- Enable lualine.nvim
require('lualine').setup()

