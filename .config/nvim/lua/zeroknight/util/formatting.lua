-- Formatting Utilities

local M = {}

function M.should_format()
  local bval = vim.b.format_on_write
  local gval = vim.g.zeroknight.format_on_write
  if bval ~= nil then
    return bval
  elseif gval ~= nil then
    return gval
  end
  return false
end

function M.lsp_format_on_write()
  if M.should_format() then
    vim.lsp.buf.format()
  end
end

return M
