-- Language Support
--
-- Any plugins that add filetype support or various features, tools, helpers,
-- etc. for any languages.

local wanted_ts_parsers = {
  vendored = {
    -- These ship with Neovim and *should* always be available anyway. Including them for completeness.
    'c',
    'lua',
    'vim',
    'vimdoc',
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

return {
  { 'cespare/vim-toml', ft = 'toml' },

  -- Web
  { 'mitsuhiko/vim-jinja', ft = { 'html', 'jinja' } },
  -- TODO: revisit this after trying an HTML language server,
  { 'mattn/emmet-vim', ft = { 'html', 'xhtml', 'xml', 'jinja' } },

  -- Misc
  { 'withgod/vim-sourcepawn', ft = 'sourcepawn', enabled = false },

  -- Treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = { 'BufReadPost', 'BufNewFile' },
    dependencies = {
      'nvim-treesitter/playground',
      'nvim-treesitter/nvim-treesitter-context',
      'nvim-treesitter/nvim-treesitter-textobjects',
      'joosepAlviste/nvim-ts-context-commentstring',
    },
    opts = {
      ensure_installed = vim.tbl_flatten(vim.tbl_values(wanted_ts_parsers)),
      highlight = {
        enable = true,
        custom_captures = {},
        additional_vim_regex_highlighting = false,
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<C-Space>',
          node_incremental = '<C-Space>',
          node_decremental = '<BS>',
          scope_incremental = '<C-s>',
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
      context_commentstring = {
        enable = true,
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
    },
    config = function(_, opts)
      require('nvim-treesitter.configs').setup(opts)
      vim.opt.foldmethod = 'expr'
      vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
    end,
  },
}
