-- Core plugins

---@type LazySpec
return {
  { 'folke/lazy.nvim', version = '*', branch = 'main' },
  { 'nvim-lua/plenary.nvim', lazy = true },
  { 'tpope/vim-repeat', event = 'VeryLazy' },
  { 'nvim-lua/popup.nvim', lazy = true },
}
