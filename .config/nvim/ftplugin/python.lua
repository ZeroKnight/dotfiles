-- Python filetype settings

if packer_loaded 'nvim-surround' then
  require('nvim-surround').buffer_setup {
    surrounds = {
      Q = {
        add = { '"""', '"""' },
        find = '""".-"""',
        delete = '^(...)().-(...)()$',
        change = {
          target = '^(...)().-(...)()$',
        },
      },
    },
  }
end

-- Override asinine default indent settings from the runtime
vim.g.python_indent = {
  closed_paren_align_last_line = false,
  open_paren = 'shiftwidth()',
  continue = 'shiftwidth()',
}
