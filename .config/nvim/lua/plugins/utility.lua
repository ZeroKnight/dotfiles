-- Utility plugins
--
-- Miscellaneous plugins that provide tools, low-level/indirect functionality,
-- subsystems for other plugins, or even just extra docs. Things that don't
-- belong anywhere else will have a home here.

---@type LazySpec
return {
  -- Utilities
  { 'dstein64/vim-startuptime', cmd = 'StartupTime' },
  { 'tpope/vim-dispatch', cmd = { 'Make', 'Dispatch', 'Start', 'Spawn' } }, -- TBD: keep this?
  { 'tpope/vim-eunuch', event = 'VeryLazy' },

  {
    'echasnovski/mini.bufremove',
    version = false,
    keys = function()
      -- stylua: ignore
      return {
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
      }
    end,
  },

  {
    'tpope/vim-characterize',
    keys = {
      { 'ga', '<Plug>(characterize)', desc = 'Get character info' },
    },
  },

  {
    'folke/persistence.nvim',
    event = 'BufReadPre',
    opts = function()
      return { dir = vim.g.sessiondir .. '/', options = vim.opt.sessionoptions:get() }
    end,
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
      for k, v in pairs(require('zeroknight.config.ui').icons.kinds) do
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
      notify = { enabled = true },
      rename = { enabled = true },
      scratch = { enabled = true },
      terminal = { enabled = true },
      toggle = { enabled = true },
    },
    keys = {
      {
        '<Leader>.',
        function()
          Snacks.scratch()
        end,
        desc = 'Toggle Scratch Buffer',
      },
      {
        '<Leader>f.',
        function()
          Snacks.scratch.select()
        end,
        desc = 'Find Scratch Buffer',
      },
      {
        '<C-/>',
        function()
          Snacks.terminal()
        end,
        desc = 'Toggle terminal',
      },
    },
    init = function()
      vim.api.nvim_create_autocmd('User', {
        pattern = 'VeryLazy',
        callback = function()
          _G.dd = function(...)
            Snacks.debug.inspect(...)
          end
          _G.bt = function()
            Snacks.debug.backtrace()
          end
          vim.print = _G.dd -- Also overrides :=

          -- NOTE: Snacks.toggle adds to Which-Key on our behalf
          Snacks.toggle.option('spell', { name = 'Spellcheck' }):map '<Leader>ts'
          Snacks.toggle.option('wrap', { name = 'Word Wrap' }):map '<Leader>tw'
          Snacks.toggle.option('hlsearch', { name = 'Toggle hlsearch' }):map '<Leader>t/'
          Snacks.toggle.option('list', { name = 'Toggle listchars' }):map '<Leader>tc'
          Snacks.toggle.diagnostics():map '<Leader>td'
          Snacks.toggle.inlay_hints():map '<Leader>th'

          Snacks.toggle
            .new({
              name = 'Search Highlighting',
              get = function()
                return vim.v.hlsearch == 1
              end,
              set = function(state)
                vim.v.hlsearch = state and 1 or 0
              end,
            })
            :map '<Leader>/'

          vim.api.nvim_create_user_command('Rename', function()
            Snacks.rename.rename_file()
          end, {})
        end,
      })
    end,
  },

  -- Extra Documentation
  'nanotee/nvim-lua-guide',
  'nanotee/luv-vimdocs',
  'bfredl/luarefvim',
}
