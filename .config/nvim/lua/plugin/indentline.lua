-- Indentation Guides

local indentline = require 'indent_blankline'

indentline.setup {
  enabled = true,
  disable_with_nolist = true,
  char = '│',
  char_blankline = '┊',
  show_first_indent_level = false,
  show_end_of_line = true,
  show_trailing_blankline_indent = false,

  -- NOTE: Turn this stuff on later when TS indent improves
  use_treesitter = false,
  -- show_current_context = true,

  filetype_exclude = {
    'lspinfo',
    'packer',
    'checkhealth',
    'help',
    'man',
    'text',
    'markdown',
    'startify',
    '',
  },

  buftype_exclude = {
    'terminal',
    'nofile',
    'quickfix',
    'prompt',
  },
}
