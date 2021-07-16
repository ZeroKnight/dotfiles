-- Sumneko Lua LSP Config

local Path = require('plenary.path')

-- TODO: Downloader/Builder function

local function get_runtime_path()
  local rtp = vim.split(package.path, ';')
  table.insert(rtp, 'lua/?.lua')
  table.insert(rtp, 'lua/?/init.lua')
  return rtp
end

local M = {}

M.base_directory = Path:new(vim.fn.stdpath('data'), 'lsp/lua-language-server')
M.bin_path = M.base_directory:joinpath('bin', jit.os, 'lua-language-server')
M.cmd = {
  tostring(M.bin_path), '-E', string.format('%s/main.lua', M.base_directory)
}

-- TBD: What goes in runtime.path vs workspace.library?
M.config = {
  cmd = M.cmd,
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path = get_runtime_path()
      },
      completion = {
        enable = true,
        autoRequire = true,
        callSnippet = 'Disable',
        keywordSnippet = 'Disable',  -- Use regular snippets for this
        displayContext = 6,  -- Show function lines in suggestion
        showParams = true,
        workspaceWord = true
      },
      diagnostics = {
        enable = true,
        globals = {'vim', 'packer_plugins'},
        -- Disabled diagnostic categories
        disable = {}
      },
      workspace = {
        -- Include Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true)
      },
      -- Sumneko's telemetry looks minimal and non-invasive.
      telemetry = {enable = true}
    }
  }
}

return M
