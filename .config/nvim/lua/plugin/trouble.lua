-- Trouble configuration

local wk = require 'which-key'

require('trouble').setup {
  action_keys = {
    close = { 'q', 'gq' }, -- Other plugins use gq for closing
    open_split = { '<C-s>' },
  },
  group = true,
  use_diagnostic_signs = true,
}

wk.register({
  name = 'errors/diag',
  x = { '<Cmd>TroubleToggle<CR>', 'Toggle Trouble window' },
  w = { '<Cmd>Trouble workspace_diagnostics<CR>', 'Show workspace diagnostics (Trouble)' },
  d = { '<Cmd>Trouble document_diagnostics<CR>', 'Show document diagnostics (Trouble)' },
  q = { '<Cmd>Trouble quickfix<CR>', 'Show quickfix list (Trouble)' },
  l = { '<Cmd>Trouble loclist<CR>', 'Show location list (Trouble)' },
  t = { '<Cmd>TodoTrouble<CR>', 'Show Todo (Trouble)' },
  T = { '<Cmd>TodoTelescope<CR>', 'Show Todo (Telescope)' },
}, {
  prefix = '<Leader>x',
})
