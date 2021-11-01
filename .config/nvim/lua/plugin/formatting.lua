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
    {cmd = {'lua-format -i'}},
  },
  markdown = {
    {cmd = {'prettier -w'}},
  },
  vim = {
    {
      cmd = {'lua-format -i'},
      start_pattern = '^lua << EOF$',
      end_pattern = '^EOF$'
    },
  },
}

vim.cmd [[
  augroup ZeroKnight_Format
    autocmd!
    autocmd BufWritePost * if g:zeroknight.format_on_write | execute 'FormatWrite' | endif
  augroup END
]]
