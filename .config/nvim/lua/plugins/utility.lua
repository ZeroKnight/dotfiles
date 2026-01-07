-- Utility plugins
--
-- Miscellaneous plugins that provide tools, low-level/indirect functionality,
-- subsystems for other plugins, or even just extra docs. Things that don't
-- belong anywhere else will have a home here.

local ui = require 'zeroknight.config.ui'
local util = require 'zeroknight.util'

---@type LazySpec
return {
  -- Utilities
  { 'dstein64/vim-startuptime', cmd = 'StartupTime' },
  { 'tpope/vim-eunuch', event = 'VeryLazy' },

  {
    'tpope/vim-characterize',
    keys = {
      { 'ga', '<Plug>(characterize)', desc = 'Get character info' },
    },
  },

  {
    'folke/persistence.nvim',
    event = 'BufReadPre',
    opts = function() return { dir = vim.g.sessiondir .. '/', options = vim.opt.sessionoptions:get() } end,
  },

  -- Built-in Overrides/Enhancements
  {
    'romainl/vim-qlist',
    keys = {
      { '[I', desc = 'Send all instances of cursor word to quickfix (from top)', mode = { 'n', 'x' } },
      { ']I', desc = 'Send all instances of cursor word to quickfix (from current line)', mode = { 'n', 'x' } },
    },
    cmd = { 'Ilist' },
  },

  -- Libraries
  { 'nvim-lua/plenary.nvim', lazy = true },
  { 'tpope/vim-repeat', event = 'VeryLazy' },
  { 'tjdevries/colorbuddy.nvim', lazy = true },
  { 'nvim-lua/popup.nvim', lazy = true },

  {
    'echasnovski/mini.icons',
    version = false,
    opts = function()
      local lsp = {}
      for k, v in pairs(ui.icons.kinds) do
        lsp[k:lower()] = { glyph = v }
      end
      return {
        style = 'glyph',
        lsp = lsp,
      }
    end,
  },

  -- NOTE: Snacks creates a global reference to itself as `Snacks`
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      animate = {
        duration = { step = 15, total = 300 },
      },
      bigfile = {
        enabled = true,
        notify = true,
        size = 2 * 1024 * 1024,
        config = function(opts, defaults)
          opts.setup = function(ctx)
            vim.b[ctx.buf].lsp_allow_attach = false
            vim.b[ctx.buf].auto_lint = false
            defaults.setup(ctx)
          end
        end,
      },
      dashboard = require 'zeroknight.startup',
      debug = { enabled = true },
      dim = {
        enabled = true,
        animate = { easing = 'outCubic' },
        filter = function(buffer) return util.flag('snacks_dim', buffer) and util.is_normal_buffer(buffer) end,
      },
      indent = {
        enabled = true,
        indent = {
          char = '│',
          hl = 'LineNr',
        },
        scope = {
          char = '│',
          only_current = true,
        },
        animate = {
          duration = { total = 500 },
        },
        filter = function(buffer)
          return util.flag('snacks_indent', buffer)
            and util.is_normal_buffer(buffer)
            and not util.is_filetype(buffer, { 'text', 'markdown' })
        end,
      },
      input = {
        icon = ui.icons.common.prompt,
        prompt_pos = 'title',
      },
      notifier = {
        enabled = true,
        timeout = 5000,
        icons = ui.icons.logging,
        style = 'compact',
      },
      rename = { enabled = true },
      scratch = { enabled = true },
      terminal = { enabled = true },
      toggle = { enabled = true },
      quickfile = { enabled = true },
    },
    keys = {
      {
        '<Leader>un',
        function() Snacks.notifier.hide() end,
        desc = 'Dismiss notifications',
      },
      {
        '<Leader>.',
        function() Snacks.scratch() end,
        desc = 'Toggle Scratch Buffer',
      },
      {
        '<Leader>f.',
        function() Snacks.scratch.select() end,
        desc = 'Find Scratch Buffer',
      },
      {
        '<C-/>',
        function() Snacks.terminal() end,
        desc = 'Toggle terminal',
      },
      {
        '<Leader>bd',
        function() require('snacks').bufdelete.delete() end,
        desc = 'Delete buffer but keep window',
      },
      {
        '<Leader>bD',
        function() require('snacks').bufdelete.delete { force = true } end,
        desc = 'Delete buffer but keep window (force)',
      },
    },
    init = function()
      vim.api.nvim_create_autocmd('User', {
        pattern = 'VeryLazy',
        callback = function()
          _G.dd = function(...) Snacks.debug.inspect(...) end
          _G.bt = function() Snacks.debug.backtrace() end
          vim.print = _G.dd -- Also overrides :=

          -- NOTE: Snacks.toggle adds to Which-Key on our behalf
          Snacks.toggle.option('spell', { name = 'Spellcheck' }):map '<Leader>ts'
          Snacks.toggle.option('wrap', { name = 'Word Wrap' }):map '<Leader>tw'
          Snacks.toggle.option('hlsearch', { name = 'hlsearch' }):map '<Leader>t/'
          Snacks.toggle.option('list', { name = 'listchars' }):map '<Leader>tc'
          Snacks.toggle.dim():map '<Leader>ud'
          Snacks.toggle.indent():map '<Leader>ti'
          Snacks.toggle.inlay_hints():map '<Leader>th'
          Snacks.toggle.diagnostics():map '<Leader>tdd'

          Snacks.toggle
            .new({
              name = 'Diagnostic Virtual Lines',
              get = function() return vim.diagnostic.config().virtual_lines end,
              set = function(state) return vim.diagnostic.config { virtual_lines = state } end,
            })
            :map '<Leader>tdl'

          Snacks.toggle
            .new({
              name = 'Diagnostic Virtual Text',
              get = function() return vim.diagnostic.config().virtual_text end,
              set = function(state) return vim.diagnostic.config { virtual_text = state } end,
            })
            :map '<Leader>tdt'

          Snacks.toggle
            .new({
              name = 'Search Highlighting',
              get = function() return vim.v.hlsearch == 1 end,
              set = function(state) vim.v.hlsearch = state and 1 or 0 end,
            })
            :map '<Leader>/'

          vim.api.nvim_create_user_command('Rename', function() Snacks.rename.rename_file() end, {})
          vim.api.nvim_create_user_command('Notifications', function() Snacks.notifier.show_history() end, {})
        end,
      })
    end,
  },
}
