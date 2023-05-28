-- Neovim Diagnostics configuration

local ui = require 'zeroknight.config.ui'

local command = vim.api.nvim_create_user_command

vim.diagnostic.config {
  underline = true,
  virtual_text = true,
  signs = true,
  update_in_insert = false,
  severity_sort = true,
}

-- Define Diagnostic signs
for severity, icon in pairs(ui.icons.diagnostics) do
  local name = string.format('DiagnosticSign%s', severity)
  vim.fn.sign_define(name, { text = icon, texthl = name })
end

command('Diagnostics', function(ctx)
  local severity = nil
  if ctx.args and ctx.args ~= '' then
    severity = vim.diagnostic.severity[ctx.args]
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
  complete = function()
    return { 'error', 'warn', 'info', 'hint' }
  end,
})
