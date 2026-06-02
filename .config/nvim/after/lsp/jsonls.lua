---@type lspconfig.Config
---@diagnostic disable:missing-fields
return {
  ---@type lspconfig.settings.jsonls
  settings = {
    json = {
      schemas = require('schemastore').json.schemas(),
      validate = { enable = true },
    },
  },
}
