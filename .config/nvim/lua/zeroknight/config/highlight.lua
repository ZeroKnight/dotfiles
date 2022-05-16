-- General highligting configuration

local util = require 'zeroknight.util'
local color = require 'zeroknight.util.color'
local diag = require 'zeroknight.config.diagnostic'

-- Spellcheck colors
vim.cmd [[hi SpellBad cterm=undercurl,bold]]

-- Make special characters stand out
vim.cmd [[hi! link SpecialKey DiagnosticHint]]

-- I don't like the way vim-one highlights diff headers
vim.cmd [[
  hi clear DiffFile
  hi clear DiffNewFile
  hi clear DiffOldFile
  hi link  DiffFile Statement
  hi link  DiffNewFile DiffAdded
  hi link  DiffOldFile DiffRemoved
]]

-- Alias for Struct LSP kind
vim.cmd [[hi link Struct Structure]]

-- Diagnostic Highlighting

for severity, col in pairs(diag.colors()) do
  util.cmdf('hi def Diagnostic%s guifg=%s', severity, col)
  util.cmdf('hi def DiagnosticUnderline%s gui=undercurl guisp=%s', severity, col)
end
