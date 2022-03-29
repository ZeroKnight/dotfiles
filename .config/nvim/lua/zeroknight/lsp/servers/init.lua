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
          pydocstyle = { enabled = true },
        },
      },
    },
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
