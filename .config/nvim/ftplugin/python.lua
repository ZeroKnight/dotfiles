-- Python filetype settings

if packer_loaded 'nvim-surround' then
  print 'did buffer setup'
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
