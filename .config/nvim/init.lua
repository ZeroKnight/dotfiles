-- ZeroKnight's init.lua

-- Mapping leader. Always set as early as possible.
vim.g.mapleader = '\\'
vim.g.maplocalleader = ' '

-- Handle initial setup for fresh installs
if require('zeroknight.bootstrap')() then
  return
end

-- Assorted global stuff
require 'zeroknight.globals'

if not vim.env.VIMSESSIONS then
  vim.env.VIMSESSIONS = as_stdpath('data', 'session')
end

-- Load plugins
require 'zeroknight.plugins'

-- Neovim settings
require 'zeroknight.config'
require 'zeroknight.config.highlight'
require 'zeroknight.config.keymaps'
require 'zeroknight.config.diagnostic'

-- Neovim LSP client
require('zeroknight.lsp').init()
