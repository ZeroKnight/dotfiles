-- Lua filetype settings

local optl = vim.opt_local

optl.tabstop = 2
optl.shiftwidth = 2

-- Make it easy to look up Neovim API functions
optl.keywordprg = ':help'

vim.keymap.set('', '<LocalLeader>x', '<Plug>(Luadev-Run)', { buffer = true })
vim.keymap.set('n', '<LocalLeader>xx', '<Plug>(Luadev-RunLine)', { buffer = true })
