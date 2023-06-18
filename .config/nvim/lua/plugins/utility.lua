-- Utility plugins
--
-- Miscellaneous plugins that provide tools, low-level/indirect functionality,
-- subsystems for other plugins, or even just extra docs. Things that don't
-- belong anywhere else will have a home here.

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
    'moll/vim-bbye',
    cmd = { 'Bdelete', 'Bwipeout' },
    keys = {
      { '<Leader>bd', '<Cmd>Bdelete<CR>', desc = 'Delete buffer but keep window' },
    },
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
      return { options = vim.o.sessionoptions }
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

  {
    'Konfekt/FastFold',
    event = { 'BufReadPost', 'BufNewFile' },
    init = function()
      vim.g.fastfold_skip_filetypes = { 'gitcommit', 'taglist' }
    end,
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
