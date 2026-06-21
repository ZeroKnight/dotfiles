local M = {}

function M.setup()
  local function load(cfg) require('zeroknight.config.' .. cfg) end
  local load_deferables = function()
    load 'autocmds'
    load 'commands'
    load 'diagnostics'
  end

  -- Load options and basic keymaps after lazy.nvim has processed the plugin
  -- specs, but before doing anything else.
  vim.api.nvim_create_autocmd('User', {
    group = vim.api.nvim_create_augroup('zeroknight.config', { clear = true }),
    pattern = 'LazyDone',
    once = true,
    callback = function()
      load 'options'
      load 'keymaps'
      require('zeroknight.config.ui').init()
    end,
  })

  -- When running Neovim with no arguments, defer loading some less-crucial
  -- configuration (VeryLazy). Otherwise, load them with the rest (LazyDone) so
  -- that they're available to the loaded buffer(s). Tweaked from LazyVim.
  vim.api.nvim_create_autocmd('User', {
    group = vim.api.nvim_create_augroup('zeroknight.config', { clear = false }),
    pattern = vim.fn.argc(-1) == 0 and 'VeryLazy' or 'LazyDone',
    once = true,
    callback = load_deferables,
  })
end

return M
