-- ZeroKnight's Plugin Mappings
-- Configless plugin mappings will live here

local wk = require 'which-key'

-- Leader Mappings {{{1

local leader = {
  b = {
    name = 'buffer',
    d = { '<Cmd>Bdelete<CR>', 'Delete buffer (keep window)' },
  },
  g = {
    name = 'git',
    s = { '<Cmd>Git<CR>', 'Status' },
    ce = { '<Cmd>Git commit --amend --reuse-message=HEAD<CR>', 'Amend last commit (no edit)' },
  },
}

-- LocalLeader Mappings {{{1

local localleader = {}

-- g Mappings {{{1

local g = {
  cy = { 'yyPgccj', 'Comment a copy of the line' },
}

-- }}}

wk.register(leader, { prefix = '<Leader>' })
wk.register(localleader, { prefix = '<LocalLeader>' })
wk.register(g, { prefix = 'g' })

vim.keymap.set({ 'n', 'i' }, '<F5>', '<Cmd>UndotreeToggle<CR>')

-- vim: fdm=marker
