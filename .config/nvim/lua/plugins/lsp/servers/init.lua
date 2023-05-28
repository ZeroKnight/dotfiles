-- Individual Language Server settings

local function config(name)
  return require(string.format('plugins.lsp.servers.%s', name)).config
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
    capabilities = {
      -- Using either null-ls or external tools for formatting
      documentFormattingProvider = false,
      documentRangeFormattingProvider = false,
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
  taplo = {},
  vimls = {},
}

return servers
