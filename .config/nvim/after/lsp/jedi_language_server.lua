---@type lspconfig.Config
---@diagnostic disable:missing-fields
return {
  settings = {
    diagnostics = { enable = true },
    markupKindPreferred = 'markdown',
    workspace = {
      symbols = {
        maxSymbols = 0, -- Return all symbols
      },
    },
  },
}
