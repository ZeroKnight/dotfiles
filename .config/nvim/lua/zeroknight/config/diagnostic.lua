-- Neovim Diagnostics configuration

local D = vim.diagnostic
local command = vim.api.nvim_create_user_command

D.config {
  underline = true,
  virtual_text = true,
  signs = true,
  update_in_insert = false,
  severity_sort = true,
}

command('Diagnostics', function(ctx)
  vim.fn['zeroknight#diagnostic#set_list'](ctx.bang, ctx.args)
end, {
  desc = 'Send diagnostics to the quickfix or location list',
  bang = true,
  force = true,
  nargs = '?',
  complete = function()
    return { 'error', 'warn', 'info', 'hint' }
  end,
})

-- Colors from folke/lsp-colors.nvim
local M = {
  severity = {
    Error = { icon = '', color = '#db4b4b' },
    Warn = { icon = '', color = '#e0af68' },
    Info = { icon = '', color = '#0db9d7' },
    Hint = { icon = '', color = '#10b981' },
  },
}

function M.icons()
  return vim.tbl_map(function(v)
    return v.icon
  end, M.severity)
end

function M.colors()
  return vim.tbl_map(function(v)
    return v.color
  end, M.severity)
end

-- Define Diagnostic signs
for severity, t in pairs(M.severity) do
  local name = string.format('DiagnosticSign%s', severity)
  vim.fn.sign_define(name, { text = t.icon, texthl = name })
end

return M
