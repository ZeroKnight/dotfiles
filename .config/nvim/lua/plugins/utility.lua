-- Utility plugins
--
-- Miscellaneous plugins that provide tools, low-level/indirect functionality,
-- subsystems for other plugins, or even just extra docs. Things that don't
-- belong anywhere else will have a home here.

---@type LazySpec
return {
  -- Utilities
  { 'dstein64/vim-startuptime', cmd = 'StartupTime' },
  {
    'bfredl/nvim-luadev',
    cmd = 'Luadev',
    keys = {
      { '<LocalLeader>x', '<Plug>(Luadev-Run)', desc = 'Run Lua code (motion)' },
      { '<LocalLeader>xx', '<Plug>(Luadev-RunLine)', desc = 'Run current line of Lua code' },
      { '<LocalLeader>xw', '<Plug>(Luadev-RunWord)', desc = 'Evaluate Lua identifier under cursor' },
    },
  },
  { 'tpope/vim-dispatch', cmd = { 'Make', 'Dispatch', 'Start', 'Spawn' } }, -- TBD: keep this?
  { 'tpope/vim-eunuch', event = 'VeryLazy' },

  {
    'echasnovski/mini.bufremove',
    version = false,
    keys = function()
      -- stylua: ignore
      return {
        { '<Leader>bd', function() require('mini.bufremove').delete(0, false) end, desc = 'Delete buffer but keep window' },
        { '<Leader>bD', function() require('mini.bufremove').delete(0, true) end, desc = 'Delete buffer but keep window (force)' },
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
    'nvim-tree/nvim-web-devicons',
    lazy = true,
    opts = { default = true },
  },

  -- Extra Documentation
  'nanotee/nvim-lua-guide',
  'nanotee/luv-vimdocs',
  'bfredl/luarefvim',
}
