-- Editing Plugins
--
-- Plugins that enhance the actual text-editing experience.

local util = require 'zeroknight.util'

---@type LazySpec
return {
  { 'christoomey/vim-sort-motion', keys = { 'gs', 'gss' } },
  { 'godlygeek/tabular', cmd = 'Tabularize' },

  {
    'echasnovski/mini.ai',
    version = false,
    event = 'VeryLazy',
    dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' },
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
          m = spec_treesitter { a = '@comment.outer', i = '@comment.inner' },
          r = spec_treesitter { a = '@return.outer', i = '@return.inner' },
        },
      }
    end,
  },

  {
    'echasnovski/mini.align',
    version = false,
    keys = {
      { '<Leader>a', desc = 'Align text (mini.align)', mode = { 'n', 'v' } },
      { '<Leader>A', desc = 'Align text with preview (mini.align)', mode = { 'n', 'v' } },
    },
    opts = function(plugin)
      return {
        mappings = { start = plugin.keys[1][1], start_with_preview = plugin.keys[2][1] },
      }
    end,
  },

  {
    'echasnovski/mini.bracketed',
    version = false,
    event = 'VeryLazy',
    opts = {
      comment = { suffix = 'm', opts = { add_to_jumplist = true } },
      conflict = { suffix = 'x', opts = { add_to_jumplist = true } },
      file = { suffix = '' },
      undo = { suffix = '' },
      window = { suffix = '' },
      yank = { suffix = '' },
    },
  },

  {
    'echasnovski/mini.move',
    version = false,
    event = { 'BufReadPost', 'BufNewFile' },
    config = true,
  },

  {
    'echasnovski/mini.splitjoin',
    version = false,
    event = { 'BufReadPost', 'BufNewFile' },
    opts = { toggle = 'gA' },
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
    enabled = false,
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
    opts = {
      padding = true,
      sticky = true,
      mappings = { basic = true, extra = true },
    },
    keys = {
      { 'gc', mode = { 'n', 'v' } },
      { 'gb', mode = { 'n', 'v' } },
      { 'gcc' },
      { 'gco' },
      { 'gcO' },
      { 'gcA' },
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
          FIX = {
            icon = ui.icons.common.bug,
            color = 'error',
            alt = { 'FIXME', 'FIXIT', 'BUG', 'DEBUG', 'ISSUE' },
          },
          HACK = { icon = ' ', color = 'warn', alt = { 'XXX' } },
          NOTE = { icon = ui.icons.common.note, color = 'hint', alt = { 'NOTICE', 'INFO' } },
          IDEA = { icon = ui.icons.diagnostics.hint, color = 'hint' },
          WARN = {
            icon = ui.icons.diagnostics.Warn,
            color = 'warn',
            alt = { 'WARNING', 'DEPRECATED', 'ATTENTION', 'ALERT', 'DANGER', 'WTF' },
          },
          PERF = {
            icon = ' ',
            color = 'default',
            alt = { 'PERFORMANCE', 'OPTI', 'OPTIM', 'OPTIMIZE', 'OPTIMIZATION' },
          },
        },
      }
    end,
  },

  {
    'unblevable/quick-scope',
    event = { 'BufReadPost', 'BufNewFile' },
    init = function() vim.g.qs_highlight_on_keys = { 'f', 'F', 't', 'T' } end,
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
    config = function(_, opts)
      local npairs = require 'nvim-autopairs'
      local ts_conds = require 'nvim-autopairs.ts-conds'
      local Rule = require 'nvim-autopairs.rule'
      npairs.setup(opts)

      -- Append comma to nested table definitions
      npairs.add_rule(Rule('{', '},', 'lua'):with_pair(ts_conds.is_ts_node { 'field', 'table_constructor' }))
    end,
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
    -- stylua: ignore
    keys = {
      { '<Leader>ur', function() require('illuminate').toggle_buf() end, desc = 'Toggle reference highlighting for buffer' },
      { ']r', function() require('illuminate').goto_next_reference() end, desc = 'Go to next instance of reference under cursor' },
      { '[r', function() require('illuminate').goto_prev_reference() end, desc = 'Go to previous instance of reference under cursor' },
    },
    config = function(_, opts)
      require('illuminate').configure(opts)

      local function _highlight()
        vim.cmd [[
          hi! link IlluminatedWordText LspReferenceText
          hi! link IlluminatedWordRead LspReferenceRead
          hi! link IlluminatedWordWrite LspReferenceWrite
        ]]
      end
      _highlight()

      vim.api.nvim_create_autocmd('ColorScheme', {
        desc = 'Redo Illuminate highlight override on colorscheme change',
        group = vim.api.nvim_create_augroup('ZeroKnight.plugins.editing.illuminate', { clear = true }),
        callback = _highlight,
      })
    end,
  },

  {
    'gbprod/yanky.nvim',
    opts = {
      ring = {
        history_length = 25,
        storage = 'shada',
        sync_with_numbered_registers = true,
      },
      system_clipboard = { sync_with_ring = true },
      highlight = { on_put = false, on_yank = false },
    },
    keys = {
      { '<Leader>fy', util.telescope 'yank_history.yank_history', desc = 'Find Yank' },
      { '<M-p>', '<Plug>(YankyPreviousEntry)', desc = 'Yank-Ring Previous' },
      { '<M-n>', '<Plug>(YankyNextEntry)', desc = 'Yank-Ring Next' },

      { 'p', '<Plug>(YankyPutAfter)', mode = { 'n', 'x' } },
      { 'P', '<Plug>(YankyPutBefore)', mode = { 'n', 'x' } },
      { 'gp', '<Plug>(YankyGPutAfter)', desc = 'Put After, cursor after text', mode = { 'n', 'x' } },
      { 'gP', '<Plug>(YankyGPutBefore)', desc = 'Put Before, cursor after text', mode = { 'n', 'x' } },

      { '[p', '<Plug>(YankyPutIndentBeforeLinewise)', desc = 'Put Before, Indent' },
      { ']p', '<Plug>(YankyPutIndentAfterLinewise)', desc = 'Put After, Indent' },

      { '<p', '<Plug>(YankyPutIndentAfterShiftLeft)', desc = 'Put After, Indent, Shift Left' },
      { '>p', '<Plug>(YankyPutIndentAfterShiftRight)', desc = 'Put After, Indent, Shift Right' },
      { '<P', '<Plug>(YankyPutIndentBeforeShiftLeft)', desc = 'Put Before, Indent, Shift Left' },
      { '>P', '<Plug>(YankyPutIndentBeforeShiftRight)', desc = 'Put Before, Indent, Shift Right' },

      { '=p', '<Plug>(YankyPutAfterFilter)', desc = 'Put After, Filtered' },
      { '=P', '<Plug>(YankyPutBeforeFilter)', desc = 'Put Before, Filtered' },
    },
    config = function(_, opts)
      require('yanky').setup(opts)
      require('plugins.telescope.ext').add_extension 'yank_history'
    end,
  },
}
