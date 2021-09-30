-- Formatter Configuration

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
    {cmd = {'stylua'}},
  },
  markdown = {
    {cmd = {'prettier'}},
  },
  python = {
    {cmd = {'isort', 'yapf'}},
  },
  vim = {
    {
      cmd = {'stylua'},
      start_pattern = '^lua << EOF$',
      end_pattern = '^EOF$'
    },
  },
}

local zeroknight = vim.g.zeroknight
if zeroknight.format_on_write == nil then
  zeroknight.format_on_write = true
  vim.g.zeroknight = zeroknight  -- XXX: Work around neovim issue #12544
end

vim.cmd [[
  augroup ZeroKnight_Format
    autocmd!
    autocmd BufWritePost * if g:zeroknight.format_on_write | execute 'FormatWrite' | endif
  augroup END
]]
