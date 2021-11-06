-- Formatter Configuration

local lua_cmd = 'stylua -s'

require('format').setup {
  ['*'] = {
    {
      cmd = {
        -- Trim trailing spaces
        [[sed -i 's/\s*$//']],
        -- Trim extra trailing newlines (but not the final newline)
        [[sed -i -e ':a' -e '/^\n*$/{$d; N}' -e '/\n$/ba']]
      }
    }
  },
  lua = {
    {cmd = {lua_cmd}},
  },
  markdown = {
    {cmd = {'prettier -w'}},
  },
  vim = {
    {
      cmd = {lua_cmd},
      start_pattern = '^lua << EOF$',
      end_pattern = '^EOF$'
    },
  },
}

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

function M.format_on_write()
  if M.should_format() then
    vim.cmd 'FormatWrite'
  end
end

function M.lsp_format_on_write()
  if M.should_format() then
    vim.lsp.buf.formatting_sync(nil, 3000)
  end
end

vim.cmd [[
  augroup ZeroKnight_Format
    autocmd!
    autocmd BufWritePost * lua require('plugin.formatting').format_on_write()
  augroup END
]]

return M
