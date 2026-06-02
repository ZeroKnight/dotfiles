---@type lspconfig.Config
---@diagnostic disable:missing-fields
return {
  enabled = false,

  ---@type lspconfig.settings.pyright
  settings = {
    python = {
      analysis = {
        autoImportCompletions = true,
      },
      venvPath = { 'venv', '.venv' },
    },
  },
}
