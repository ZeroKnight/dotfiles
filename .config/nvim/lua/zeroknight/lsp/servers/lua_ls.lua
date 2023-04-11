-- Sumneko Lua LSP Config

local function lua_path()
  local p = vim.split(package.path, ';')
  table.insert(p, 'lua/?.lua')
  table.insert(p, 'lua/?/init.lua')
  return p
end

local M = {}

M.config = {
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path = lua_path(),
      },
      completion = {
        enable = true,
        autoRequire = true,
        callSnippet = 'Disable',
        keywordSnippet = 'Disable', -- Use regular snippets for this
        displayContext = 6,         -- Show function lines in suggestion
        showParams = true,
        workspaceWord = true,
      },
      diagnostics = {
        enable = true,
        globals = { 'vim', 'packer_plugins' },
        -- Disabled diagnostic categories
        disable = { 'undefined-field', 'undefined-global' },
      },
      semantic = {
        enable = false, -- No plans to use Semantic highlighting
      },
      workspace = {
        -- Include Neovim runtime files
        library = vim.api.nvim_get_runtime_file('', true),
      },
      -- Sumneko's telemetry looks minimal and non-invasive.
      telemetry = { enable = true },
    },
  },
}

return M
