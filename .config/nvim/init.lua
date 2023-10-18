-- ZeroKnight's init.lua

-- Mapping leader. Always set as early as possible.
vim.g.mapleader = '\\'
vim.g.maplocalleader = ' '

-- Ensure baseline environment
if not require 'zeroknight.bootstrap'() then
  return
end

-- Assorted global stuff
require 'zeroknight.globals'

vim.g.sessiondir = as_stdpath('state', 'session')

-- Load plugins
require('lazy').setup('plugins', {
  defaults = {
    lazy = false,
    version = false,
  },
  git = {
    log = { '--since=7 days ago' },
  },
  dev = {
    path = '~/Projects',
  },
  install = {
    colorscheme = { 'tokyonight', 'one' },
  },
  ui = {
    border = require('zeroknight.config.ui').borders,
  },
  custom_keys = {
    ['<LocalLeader>l'] = false,
    ['<LocalLeader>t'] = false,
  },
})

-- Load basic configuration
require('zeroknight.config').setup()
