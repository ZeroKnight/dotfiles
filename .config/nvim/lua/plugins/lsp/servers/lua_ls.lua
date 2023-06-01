-- Lua Language Server Config

local M = {}

M.config = {
  settings = {
    Lua = {
      runtime = {
        version = 'Lua 5.2',
      },
      completion = {
        enable = true,
        autoRequire = true,
        callSnippet = 'Disable',
        keywordSnippet = 'Disable', -- Use regular snippets for this
        displayContext = 6, -- Show function lines in suggestion
        showParams = true,
        workspaceWord = true,
      },
      diagnostics = {
        enable = true,
        -- Disabled diagnostic categories
        disable = { 'undefined-field', 'undefined-global' },
        libraryFiles = 'Disable',
      },
      format = {
        -- Using stylua via null-ls
        enable = false,
      },
      semantic = {
        enable = true,
      },
      workspace = {},
      -- Sumneko's telemetry looks minimal and non-invasive.
      telemetry = { enable = true },
    },
  },
}

return M
