-- Treesitter configuration

local wk = require 'which-key'

local wanted_parsers = {
  vendored = {
    -- These ship with Neovim and *should* always be available anyway. Including them for completeness.
    'c',
    'help',
    'lua',
    'vim',
  },
  langs = {
    -- Languages that I use often; not shipped with Neovim
    'bash',
    'cpp',
    'jq',
    'python',
  },
  docs = {
    -- Documentation and other markup
    'markdown',
    'markdown_inline',
    'rst',
  },
  data = {
    -- Data formats, serialization, configuration, etc.
    'cmake',
    'dockerfile',
    'gitattributes',
    'json',
    'make',
    'toml',
    'yaml',
  },
  meta = {
    -- Language constructs, meta-languages, extra syntax, etc.
    'comment',
    'diff',
    'git_rebase',
    'gitcommit',
    'query',
    'regex',
  },
}

require('nvim-treesitter.configs').setup {
  ensure_installed = vim.tbl_flatten(vim.tbl_values(wanted_parsers)),
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
  playground = {
    enable = true,
  },
  context = {
    enable = true,
    max_lines = 3,
    trim_scope = 'outer',
    min_window_height = 10,
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Jump ahead to next-nearest text-object if needed
      keymaps = {
        ['ab'] = '@block.outer',
        ['ib'] = '@block.inner',
        ['ac'] = '@conditional.outer',
        ['ic'] = '@conditional.inner',
        ['aC'] = '@class.outer',
        ['iC'] = '@class.inner',
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['al'] = '@loop.outer',
        ['il'] = '@loop.inner',
      },
      selection_modes = {
        ['@block.inner'] = 'V',
        ['@class.inner'] = 'V',
        ['@function.inner'] = 'V',
        ['@loop.inner'] = 'V',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['<Leader>a'] = { query = '@parameter.inner', desc = 'Swap argument with next' },
      },
      swap_previous = {
        ['<Leader>A'] = { query = '@parameter.inner', desc = 'Swap argument with previous' },
      },
    },
    move = {
      enable = true,
      set_jumps = true,
      goto_next_start = {
        [']f'] = { query = '@function.outer', desc = 'Next function start' },
        [']]'] = { query = '@class.outer', desc = 'Next class start' },
      },
      goto_next_end = {
        [']F'] = { query = '@function.outer', desc = 'Next function end' },
        [']['] = { query = '@class.outer', desc = 'Next class end' },
      },
      goto_previous_start = {
        ['[f'] = { query = '@function.outer', desc = 'Previous function start' },
        ['[['] = { query = '@class.outer', desc = 'Previous class start' },
      },
      goto_previous_end = {
        ['[F'] = { query = '@function.outer', desc = 'Previous function end' },
        ['[]'] = { query = '@class.outer', desc = 'Previous class end' },
      },
    },
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
