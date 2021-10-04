-- General highligting configuration

local util = require('zeroknight.util')
local color = require('zeroknight.util.color')

-- Spellcheck colors
vim.cmd [[hi SpellBad cterm=undercurl,bold]]

-- Make special characters stand out
vim.cmd [[hi! link SpecialKey DiagnosticHint]]

-- Diagnostic Highlighting

-- From folke/lsp-colors.nvim
local folke_colors = {Error = "#db4b4b", Warn = "#e0af68", Info = "#0db9d7", Hint = "#10b981"}
local diag_colors = vim.tbl_extend(
  'force', folke_colors, {Error = color.to_hex(vim.api.nvim_get_hl_by_name('Error', true).foreground)}
)

for severity, col in pairs(diag_colors) do
  util.cmdf('hi Diagnostic%s guifg=%s', severity, col)
  util.cmdf('hi DiagnosticUnderline%s gui=undercurl guisp=%s', severity, col)
end
vim.cmd [[
  hi clear DiagnosticError
  hi link DiagnosticError Error
]]
