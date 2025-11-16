-- Completion source configuration

local cmp = require 'cmp'

-- NOTE: There are some useful helpers for contextual completion sources:
-- - cmp.config.context.in_syntax_group
-- - cmp.config.context.in_treesitter_capture

-- Disabled filetypes
cmp.setup.filetype({ 'TelescopePrompt' }, {
  sources = {},
})

cmp.setup.filetype({ 'lua', 'vim' }, {
  sources = cmp.config.sources {
    { name = 'lazydev' },
    { name = 'nvim_lsp' },
    { name = 'path' },
    { name = 'treesitter' },
    { name = 'luasnip' },
    { name = 'calc', keyword_length = 3 },
    { name = 'buffer', keyword_length = 5 },
  },
})

cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'cc_types', keyword_length = 1 },
    { name = 'git' },
  }, {
    { name = 'path' },
    { name = 'luasnip' },
    { name = 'calc' },
    { name = 'buffer' },
  }),
})

cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'path' },
    { name = 'calc' },
  }, {
    {
      name = 'cmdline',
      option = { ignore_cmds = { '!' } },
    },
  }),
})

cmp.setup.cmdline('/', {
  sources = cmp.config.sources({
    { name = 'nvim_lsp_document_symbol' },
  }, {
    { name = 'path' },
    { name = 'buffer' },
  }),
})

-- Set up sources
require('cmp_git').setup()
