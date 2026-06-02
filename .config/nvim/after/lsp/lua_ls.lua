-- NOTE: lua_ls will not (yet) use the passed settings in a
-- workspace/didChangeConfiguration notification. See issue #2899.

---@type lspconfig.Config
---@diagnostic disable:missing-fields
return {
  ---@type lspconfig.settings.lua_ls
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
        disable = {},
        libraryFiles = 'Disable',
      },
      format = {
        -- Using stylua via null-ls
        enable = false,
      },
      hint = {
        enable = true,
        arrayIndex = 'Auto', -- Show when >3 elements or mixed table
        await = true,
        paramType = true, -- Show parameter type hints at function calls
        setType = true, -- Show type hints at assignment statements
      },
      semantic = {
        enable = true,
      },
      workspace = {},
    },
  },
}
