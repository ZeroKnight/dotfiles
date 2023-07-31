-- Editing Plugins
--
-- Plugins that enhance the actual text-editing experience.

return {
  { 'tpope/vim-unimpaired', event = 'VeryLazy' },
  { 'christoomey/vim-sort-motion', keys = { 'gs', 'gss' } },
  { 'godlygeek/tabular', cmd = 'Tabularize' },

  {
    'echasnovski/mini.ai',
    version = false,
    event = 'VeryLazy',
    dependencies = { 'nvim-treesitter-textobjects' },
    opts = function()
      -- NOTE: Remember that g[ and g] are useful mappings!
      local spec_treesitter = require('mini.ai').gen_spec.treesitter
      return {
        n_lines = 200,
        silent = true,
        search_method = 'cover_or_next',
        mappings = {
          around_last = '',
          inside_last = '',
        },
        custom_textobjects = {
          A = spec_treesitter { a = '@assignment.outer', i = '@assignment.inner' },
          C = spec_treesitter { a = '@class.outer', i = '@class.inner' },
          F = spec_treesitter { a = '@function.outer', i = '@function.inner' },
          S = spec_treesitter { a = '@block_string.outer', i = '@block_string.inner' },
          b = spec_treesitter { a = '@block.outer', i = '@block.inner' },
          c = spec_treesitter { a = '@conditional.outer', i = '@conditional.inner' },
          l = spec_treesitter { a = '@loop.outer', i = '@loop.inner' },
          r = spec_treesitter { a = '@return.outer', i = '@return.inner' },
        },
      }
    end,
  },

  {
    'tpope/vim-abolish',
    event = { 'BufReadPost', 'BufNewFile' },
    config = function()
      vim.cmd [[
      Abolish anomol{y,ies} anomal{}
      Abolish fu{cn,nc}{ti,it}on{,s} fu{nc}{ti}on{}
      Abolish {,un}nec{ce,ces,e}sar{y,ily} {}nec{es}sar{}
      Abolish oc{,c}ur{,r} occur

      " Twiddled characters
      Abolish teh the
      Abolish cosnt const
      Abolish do{ens,sen} doesn
      Abolish versoin version
      Abolish aroudn around
      Abolish reutrn return
      Abolish ture true
      Abolish f{las,asl}e false

      " eh/æ mixups
      Abolish {,in}consistant{,ly} {}consistent{}
      Abolish persistant{,ly} persistent{}
      Abolish permanant{,ly} permanent{}
      Abolish existan{t,ce} existen{}
      Abolish inheritence inheritance
      Abolish oc{,c}ur{,r}ance occurrence

      " Other mixups
      Abolish competative{,ly} competitive{}
      ]]
    end,
  },

  {
    'ZeroKnight/vim-signjump',
    dev = true,
    keys = {
      { ']s', desc = 'Next sign' },
      { '[s', desc = 'Previous sign' },
      { '[S', desc = 'First sign' },
      { ']S', desc = 'Last sign' },
    },
  },

  {
    'chrisbra/NrrwRgn',
    -- stylua: ignore
    cmd = {
      'NR', 'NW', 'NRV', 'NUD', 'NRP', 'NRL',
      'NarrowRegion', 'NarrowWindow', 'NRPrepare',
    },
  },

  {
    'kylechui/nvim-surround',
    event = 'VeryLazy',
    opts = {
      aliases = {
        ['?'] = 'i',
      },
      highlight = { duration = 500 },
      move_cursor = false,
    },
  },

  {
    'numToStr/Comment.nvim',
    -- stylua: ignore
    keys = {
      { 'gc' }, { 'gc', mode = 'v' }, { 'gb' }, { 'gb', mode = 'v' }, { 'gcc' }, { 'gco' }, { 'gcO' }, { 'gcA' }
    },
    opts = {
      pre_hook = function()
        require('ts_context_commentstring.internal').update_commentstring {}
      end,
    },
  },

  {
    'folke/todo-comments.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    cmd = { 'TodoTrouble', 'TodoTelescope' },
    opts = function()
      local ui = require 'zeroknight.config.ui'
      return {
        -- Manually set everything since I want tags in certain categories
        merge_keywords = false,

        colors = {
          default = { 'Statement', '#7c3aed' },
          error = { 'DiagnosticError', ui.colors.diagnostics.Error },
          warn = { 'DiagnosticWarn', ui.colors.diagnostics.Warn },
          info = { 'DiagnosticInfo', ui.colors.diagnostics.Info },
          hint = { 'DiagnosticHint', ui.colors.diagnostics.Hint },
        },

        keywords = {
          TODO = { icon = ui.icons.common.check, color = 'info', alt = { 'TBD', 'TEST' } },
          FIX = { icon = ui.icons.common.bug, color = 'error', alt = { 'FIXME', 'FIXIT', 'BUG', 'DEBUG', 'ISSUE' } },
          HACK = { icon = ' ', color = 'warn', alt = { 'XXX' } },
          NOTE = { icon = ui.icons.common.note, color = 'hint', alt = { 'NOTICE', 'INFO' } },
          IDEA = { icon = ui.icons.diagnostics.hint, color = 'hint' },
          WARN = {
            icon = ui.icons.diagnostics.Warn,
            color = 'warn',
            alt = { 'WARNING', 'DEPRECATED', 'ATTENTION', 'ALERT', 'DANGER', 'WTF' },
          },
          PERF = { icon = ' ', color = 'default', alt = { 'PERFORMANCE', 'OPTI', 'OPTIMIZE', 'OPTIMIZATION' } },
        },
      }
    end,
  },

  {
    'unblevable/quick-scope',
    event = { 'BufReadPost', 'BufNewFile' },
    init = function()
      vim.g.qs_highlight_on_keys = { 'f', 'F', 't', 'T' }
    end,
  },

  {
    'windwp/nvim-autopairs',
    dependencies = { 'nvim-cmp' },
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {
      map_c_w = true,
      fast_wrap = {
        map = '<M-w>',
        highlight_grey = 'Visual',
      },
    },
  },

  {
    'RRethy/vim-illuminate',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {
      delay = 500,
      filetypes_denylist = {
        'fugitive',
        'lazy',
        'alpha',
        'lspinfo',
        'checkhealth',
      },
    },
    keys = function()
      local illuminate = require 'illuminate'
      return {
        { '<Leader>ur', illuminate.toggle_buf, desc = 'Toggle reference highlighting for buffer' },
        { ']r', illuminate.goto_next_reference, desc = 'Go to next instance of reference under cursor' },
        { '[r', illuminate.goto_prev_reference, desc = 'Go to previous instance of reference under cursor' },
      }
    end,
    config = function(_, opts)
      require('illuminate').configure(opts)
      vim.cmd [[
        hi! link IlluminatedWordText LspReferenceText
        hi! link IlluminatedWordRead LspReferenceRead
        hi! link IlluminatedWordWrite LspReferenceWrite
      ]]
    end,
  },
}
