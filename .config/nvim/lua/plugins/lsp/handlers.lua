-- Custom LSP handlers

local M = {}

local function preview_location_callback(_, result)
  if result == nil or vim.tbl_isempty(result) then
    require('vim.lsp.log').info 'No location found for preview'
    return nil
  end
  if vim.tbl_islist(result) then
    vim.lsp.util.preview_location(result[1])
  else
    vim.lsp.util.preview_location(result)
  end
end

function M.peek(what)
  local params = vim.lsp.util.make_position_params()
  return vim.lsp.buf_request(0, 'textDocument/' .. what, params, preview_location_callback)
end

return M
