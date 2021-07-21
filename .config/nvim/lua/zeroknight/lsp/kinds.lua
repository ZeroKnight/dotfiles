-- Configure LSP Kinds

local protocol = vim.lsp.protocol

local comp_kinds = #protocol.CompletionItemKind
assert(comp_kinds == 25, 'Unexpected length for CompletionItemKind; got ' .. comp_kinds)

-- NOTE: Order matters per LSP spec
protocol.CompletionItemKind = vim.tbl_extend('force', protocol.CompletionItemKind, {
  '  Text',
  'ƒ  Method',
  'ƒ  Function',
  '  Constructor',
  '  Field',
  '  Variable',
  '  Class',
  '  Interface',
  '  Module',
  '  Property',
  '  Unit',
  '  Value',
  '  Enum',
  '  Keyword',
  '  Snippet',
  '  Color',
  '  File',
  '  Reference',
  '  Folder',
  '  EnumMember',
  '  Constant',
  '  Struct',
  '  Event',
  'λ  Operator',
  '  TypeParameter'
})
