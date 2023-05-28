local M = {}

function M.setup()
  local function load(cfg)
    require('zeroknight.config.' .. cfg)
  end

  load 'options'

  -- Defer loading unless the argument list is populated; in which case they
  -- should be available to the loaded buffers. Pinched from LazyVim.
  if vim.fn.argc(-1) == 0 then
    vim.api.nvim_create_autocmd('User', {
      group = vim.api.nvim_create_augroup('zeroknight.config', { clear = true }),
      pattern = 'VeryLazy',
      callback = function()
        load 'autocmds'
        load 'keymaps'
      end,
    })
  else
    load 'autocmds'
    load 'keymaps'
  end

  require('zeroknight.config.ui').init()
  load 'diagnostics'
end

return M
