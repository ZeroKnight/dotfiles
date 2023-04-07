-- Individual Language Server settings

local function config(name)
  return require(string.format('zeroknight.lsp.servers.%s', name)).config
end

local servers = {
  jsonls = {},
  lua_ls = config 'lua_ls',
  pylsp = {
    settings = {
      pylsp = {
        configurationSources = { 'flake8' },
        plugins = {
          flake8 = { enabled = true },
          pyflakes = { enabled = false },
          pydocstyle = { enabled = true },
        },
      },
    },
    on_attach = function(client)
      -- Using either null-ls or external tools for formatting
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
    end,
  },
  pyright = {
    disabled = true,
    settings = {
      python = {
        analysis = {
          autoImportCompletions = true,
        },
        venvPath = { 'venv', '.venv' },
      },
    },
  },
  vimls = {},
}

return servers
