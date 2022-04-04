-- Individual Language Server settings

local function config(name)
  return require(string.format('zeroknight.lsp.servers.%s', name)).config
end

local servers = {
  jsonls = {},
  sumneko_lua = config 'sumneko',
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
      client.resolved_capabilities.document_formatting = false
      client.resolved_capabilities.document_range_formatting = false
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
