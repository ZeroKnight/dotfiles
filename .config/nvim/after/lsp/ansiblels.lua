---@type lspconfig.Config
---@diagnostic disable:missing-fields
return {
  ---@type lspconfig.settings.ansiblels
  settings = {
    ansible = {
      ansible = { useFullyQualifiedCollectionNames = true },
      completion = {
        provideRedirectModules = true,
        provideModuleOptionAliases = true,
      },
      validation = {
        enabled = true,
        lint = { enabled = true },
      },
    },
  },
}
