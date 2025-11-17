-- Completion source configuration

local cmp = require 'cmp'

-- NOTE: There are some useful helpers for contextual completion sources:
-- - cmp.config.context.in_syntax_group
-- - cmp.config.context.in_treesitter_capture

-- nvim-cmp doesn't coalesce source options from buf->ft->global, so this is
-- a workaround that lets me accomplish more or less that.
local source = setmetatable({
  buffer = { keyword_length = 5 },
  calc = { keyword_length = 3 },
  path = { option = { trailing_slash = true }, keyword_length = 1 },
}, {
  __call = function(self, source, overrides)
    return vim.tbl_extend('force', { name = source }, self[source] or {}, overrides or {})
  end,
})

cmp.setup.global {
  sources = cmp.config.sources {
    source 'nvim_lsp',
    source 'path',
    source 'diag-codes',
    source 'treesitter',
    source 'luasnip',
    source 'calc',
    source 'buffer',
  },
}

-- Disabled filetypes
cmp.setup.filetype({ 'TelescopePrompt' }, {
  sources = {},
})

cmp.setup.filetype({ 'lua', 'vim' }, {
  sources = cmp.config.sources {
    { name = 'lazydev' },
    source 'nvim_lsp',
    source 'path',
    source 'diag-codes',
    source 'treesitter',
    source 'luasnip',
    source 'calc',
    source 'buffer',
  },
})

cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'cc_types', keyword_length = 1 },
    { name = 'git' },
  }, {
    source 'path',
    source 'luasnip',
    source 'calc',
    source('buffer', { keyword_length = 2 }),
  }),
})

cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    source 'path',
    source('calc', { keyword_length = 1 }),
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
    source 'path',
    source('buffer', { keyword_length = 2 }),
  }),
})

-- Set up sources
require('cmp_git').setup()
