-- Treesitter configuration

local wk = require 'which-key'

require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true,
    custom_captures = {},
    additional_vim_regex_highlighting = false,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<Leader>v',
      scope_incremental = '<C-Up>',
      node_incremental = '<M-Up>',
      node_decremental = '<M-Down>',
    },
  },
  indent = {
    enable = true,
    disable = { 'python' },
  },
}

wk.register({
  ['<Leader>v'] = { 'Treesitter Incremental Selection', mode = 'n' },
  ['<C-Up>'] = { 'Increment selection by scope' },
  ['<M-Up>'] = { 'Increment selection by node' },
  ['<M-Down>'] = { 'Decrement selection by node' },
}, {
  mode = 'v',
})

vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
