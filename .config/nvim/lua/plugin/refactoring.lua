-- Refactoring configuration

local refactoring = require 'refactoring'
local wk = require 'which-key'

refactoring.setup {}
require('telescope').load_extension 'refactoring'

local function refactor(operation)
  return {
    string.format([[<Esc><Cmd>lua require('refactoring').refactor('%s')<CR>]], operation),
    operation,
  }
end

local function debug(operation, opts)
  return string.format([[<Cmd>lua require('refactoring').debug.%s(%s)<CR>]], operation, opts)
end

wk.register({
  name = 'refactor',
  r = { [[<Cmd>lua require('telescope').extensions.refactoring.refactors()<CR>]], 'Select Refactor' },

  f = refactor 'Extract Function',
  F = refactor 'Extract Function To File',
  v = refactor 'Extract Variable',
  V = refactor 'Inline Variable',

  p = {
    name = 'print debugging',
    v = { debug 'print_var', 'Debug: Print variable' },
  },
}, {
  prefix = '<Leader>r',
  mode = 'v',
})

wk.register({
  name = 'refactor',
  b = refactor 'Extract Block',
  B = refactor 'Extract Block To File',
  V = refactor 'Inline Variable',

  c = { debug 'cleanup', 'Debug: Remove debug prints' },
  P = { debug('printf', { below = false }), 'Debug: Print TS path' },
  p = {
    name = 'print debugging',
    v = { debug('print_var', { normal = true }), 'Debug: Print variable' },
  },
}, {
  prefix = '<Leader>r',
})
