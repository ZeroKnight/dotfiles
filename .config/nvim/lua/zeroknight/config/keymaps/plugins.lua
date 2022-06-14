-- ZeroKnight's Plugin Mappings

local wk = require 'which-key'

-- Leader Mappings {{{1

local leader = {
  b = {
    name = 'buffer',
    d = { '<Cmd>Bdelete<CR>', 'Delete buffer (keep window)' },
  },
  f = {
    name = 'find',
    f = { 'Find File' },
    o = { 'Find Old File' },
    z = { 'Find Directory via z' },
    d = { 'Find Diagnostic' },
    t = { 'Find Treesitter' },
    q = { 'Find Quickfix' },
    l = { 'Find Location' },
    G = { 'Live Grep' },
    w = { 'Find Word' },
    b = { 'Find in Buffer' },
    [':'] = { 'Command History' },
    ['/'] = { 'Search History' },
    g = {
      name = 'git',
      f = { 'Find Git File' },
      c = { 'Find Commit' },
      C = { 'Find Commit (Buffer)' },
      b = { 'Find Branch' },
      s = { 'Git Status' },
      S = { 'Git Stash' },
    },
  },
  F = { 'Browse Files' },
  g = {
    name = 'git',
    s = { '<Cmd>Git<CR>', 'Status' },
    ce = { '<Cmd>Git commit --amend --reuse-message=HEAD<CR>', 'Amend last commit (no edit)' },
  },
  h = {
    name = 'help/hunks',
    h = { 'Help Pages' },
    m = { 'Man Pages' },
    k = { 'Keymaps' },
    c = { 'Commands' },
    f = { 'Filetypes' },
    a = { 'AutoCommands' },
    o = { 'Vim Options' },
    P = { 'Plugins' },

    -- Hunks (GitSigns)
    s = { 'Stage Hunk' },
    u = { 'Undo Stage Hunk' },
    r = { 'Reset Hunk' },
    R = { 'Reset Buffer (Git)' },
    S = { 'Stage Buffer' },
    p = { 'Preview Hunk' },
    b = { 'Toggle Hunk Blame' },
    U = { 'Reset Buffer Index (Git)' },
  },
  ig = { '<Cmd>IndentBlanklineToggle<CR>', 'Toggle indent guides' },
  x = {
    name = 'errors/diag',
    x = { '<Cmd>TroubleToggle<CR>', 'Toggle Trouble window' },
    w = { '<Cmd>Trouble lsp_workspace_diagnostics<CR>', 'Show workspace diagnostics (Trouble)' },
    d = { '<Cmd>Trouble lsp_document_diagnostics<CR>', 'Show document diagnostics (Trouble)' },
    q = { '<Cmd>Trouble quickfix<CR>', 'Show quickfix list (Trouble)' },
    l = { '<Cmd>Trouble loclist<CR>', 'Show location list (Trouble)' },
    t = { '<Cmd>TodoTrouble<CR>', 'Show Todo (Trouble)' },
    T = { '<Cmd>TodoTelescope<CR>', 'Show Todo (Telescope)' },
  },
  ['<Leader>'] = {
    name = 'Aux Leader',
    n = {
      name = 'neovim',
      c = 'Find Neovim Config File',
      p = 'Find Neovim Plugin File',
      l = 'Find Neovim Log File',
      r = 'Find Neovim Runtime File',
    },
    p = { 'Browse Projects' },
    s = {
      name = 'snippets',
      e = {
        function()
          require('luasnip.loaders').edit_snippet_files()
        end,
        'Edit snippets for current filetype(s)',
      },
      r = {
        function()
          rerequire 'plugin.luasnip'
        end,
        'Reload LuaSnip',
      },
    },
    z = {
      name = 'zsh',
      c = 'Find Zsh Config File',
    },
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
wk.register({
  h = {
    name = 'hunks',
    s = { 'Stage Hunk' },
    r = { 'Reset Hunk' },
  },
}, {
  prefix = '<Leader>',
  mode = 'v',
})

vim.keymap.set({ 'n', 'i' }, '<F4>', '<Esc><Cmd>SymbolsOutline<CR>')
vim.keymap.set({ 'n', 'i' }, '<F5>', '<Cmd>UndotreeToggle<CR>')

-- vim: fdm=marker
