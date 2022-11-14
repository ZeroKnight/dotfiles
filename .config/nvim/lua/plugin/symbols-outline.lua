-- Symbols Outline configuration
local kinds = require 'zeroknight.lsp.kinds'

local symbol_hl = {
  Array = 'TSConstant',
  Boolean = 'TSBoolean',
  Class = 'TSType',
  Constant = 'TSConstant',
  Constructor = 'TSConstructor',
  Enum = 'TSType',
  EnumMember = 'TSField',
  Event = 'TSType',
  Field = 'TSField',
  File = 'TSURI',
  Function = 'TSFunction',
  Interface = 'TSType',
  Key = 'TSType',
  Method = 'TSMethod',
  Module = 'TSNamespace',
  Namespace = 'TSNamespace',
  Null = 'TSType',
  Number = 'TSNumber',
  Object = 'TSType',
  Operator = 'TSOperator',
  Package = 'TSNamespace',
  Property = 'TSMethod',
  String = 'TSString',
  Struct = 'TSType',
  TypeParameter = 'TSParameter',
  Variable = 'TSConstant',
}

local symbols = {}
for k, v in pairs(symbol_hl) do
  symbols[k] = { icon = kinds.symbols[k], hl = v }
end

vim.g.symbols_outline = {
  auto_preview = true,
  highlight_hovered_item = false,
  symbols = symbols,
  width = 20,
}

vim.keymap.set({ 'n', 'i' }, '<F4>', '<Esc><Cmd>SymbolsOutline<CR>')
