-- Lua Language Server Config

local uv = vim.loop

local function nvim_lua_path()
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
        -- TODO: test if treesitter is doing semantic highlighting for lua
        enable = false,
      },
      workspace = {},
      -- Sumneko's telemetry looks minimal and non-invasive.
      telemetry = { enable = true },
    },
  },
  on_new_config = function(new_config, new_root_dir)
    -- Editing Neovim configuration
    if new_root_dir == uv.fs_realpath(vim.fn.stdpath 'config') then
      new_config.root_dir = function(_)
        return vim.fn.stdpath 'config'
      end
      new_config.settings.Lua = vim.tbl_deep_extend('force', new_config.settings.Lua, {
        runtime = {
          version = 'LuaJIT',
          path = nvim_lua_path(),
        },
        diagnostics = {
          globals = { 'vim', 'packer_plugins' },
        },
        workspace = {
          -- Include Neovim runtime files
          library = vim.api.nvim_get_runtime_file('', true),
        },
      })
    end
  end,
}

return M
