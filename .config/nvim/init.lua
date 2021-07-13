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

-- TODO: astronauta?

-- Neovim settings
require 'zeroknight.config'

-- Neovim LSP client
require 'zeroknight.lsp'
