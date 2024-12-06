-- Neovim Diagnostics configuration

local ui = require 'zeroknight.config.ui'

local command = vim.api.nvim_create_user_command
local severity = vim.diagnostic.severity

vim.diagnostic.config {
  underline = { severity = { min = severity.WARN } },
  virtual_text = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = ui.borders,
    scope = 'line',
    source = true,
  },
  signs = {
    text = {
      [severity.ERROR] = ui.icons.diagnostics.Error,
      [severity.WARN] = ui.icons.diagnostics.Warn,
      [severity.INFO] = ui.icons.diagnostics.Info,
      [severity.HINT] = ui.icons.diagnostics.Hint,
    },
  },
}

command('Diagnostics', function(ctx)
  local severity = nil
  if ctx.args and ctx.args ~= '' then
    severity = severity[ctx.args]
  end
  if ctx.bang then
    vim.diagnostic.setloclist { severity = severity }
  else
    vim.diagnostic.setqflist { severity = severity }
  end
end, {
  desc = 'Send diagnostics to the quickfix or location list',
  bang = true,
  force = true,
  nargs = '?',
  complete = function() return { 'error', 'warn', 'info', 'hint' } end,
})
