-- LSP Highlighting
-- NOTE: This file will be executed on ColorScheme events

local color = require('zeroknight.util.color')
local Color = color.Color

-- Reference Highlighting
local ref_cols = {
  Read = Color:new('#38b9ff'),
  Write = Color:new('#ffab26')
}
for reftype, col in pairs(ref_cols) do
  vim.cmd(string.format(
    'hi LspReference%s guibg=%s', reftype, col:over(Color:from_background(), 0.18)
  ))
end
vim.cmd 'hi link LspReferenceText Visual'

vim.cmd [[
  hi link LspDiagnosticsDefaultError Error
]]

