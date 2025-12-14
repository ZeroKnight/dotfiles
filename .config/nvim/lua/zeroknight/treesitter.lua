-- Treesitter Configuration and Extensions

local M = {}

M.wanted_parsers = setmetatable({
  vendored = {
    -- These ship with Neovim and *should* always be available anyway. Including them for completeness.
    'c',
    'lua',
    'vim',
    'vimdoc',
  },
  langs = {
    -- Languages that I use often; not shipped with Neovim
    'bash',
    'cpp',
    'jq',
    'python',
  },
  docs = {
    -- Documentation and other markup
    'markdown',
    'markdown_inline',
    'rst',
  },
  data = {
    -- Data formats, serialization, configuration, etc.
    'cmake',
    'dockerfile',
    'gitattributes',
    'json',
    'jsonc',
    'make',
    'toml',
    'yaml',
  },
  meta = {
    -- Language constructs, meta-languages, extra syntax, etc.
    'comment',
    'diff',
    'git_rebase',
    'gitcommit',
    'query',
    'regex',
  },
}, {
  __call = function(self) return vim.iter(vim.tbl_values(self)):flatten():totable() end,
})

return M
