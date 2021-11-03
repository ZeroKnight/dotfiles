-- Configure LSP Kinds

local protocol = vim.lsp.protocol

for kind, expected in pairs{CompletionItemKind = 25, SymbolKind = 26} do
  local actual = #protocol[kind]
  assert(actual == expected, string.format('Unexpected length for %s; got %d', kind, actual))
end

local symbols = {
  Array = '',
  Boolean = '',
  Class = '',
  Color = '',
  Constant = '',
  Constructor = '',
  Enum = '',
  EnumMember = '',
  Event = '',
  Field = '',
  File = '',
  Folder = '',
  Function = 'ƒ',
  Interface = '',
  Key = '',
  Keyword = '',
  Method = 'ƒ',
  Module = '',
  Namespace = '',
  Null = '∅',
  Number = '#',
  Object = '',
  Operator = 'λ',
  Package = '',
  Property = '',
  Reference = '',
  Snippet = '',
  String = '',
  Struct = '',
  Text = '',
  TypeParameter = '',
  Unit = '',
  Value = '',
  Variable = '',
}

-- NOTE: Order matters per LSP spec

for i = 1, #protocol.CompletionItemKind do
  local kind = protocol.CompletionItemKind[i]
  protocol.CompletionItemKind[i] = string.format('%s  %s', symbols[kind], kind)
end

-- TBD: Don't touch this for now. I don't know if these should even be modified
-- in the first place (it might be expected to be able to access by known
-- string keys). It breaks lsp-status.update_current_function. Revisit when
-- I know more about the expectations of this table and/or when lsp-status updates.

-- for i = 1, #protocol.SymbolKind do
--   local kind = protocol.SymbolKind[i]
--   protocol.SymbolKind[i] = string.format('%s  %s', symbols[kind], kind)
-- end

return {symbols = symbols}
