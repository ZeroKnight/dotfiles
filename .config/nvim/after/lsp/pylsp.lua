---@type lspconfig.Config
---@diagnostic disable:missing-fields
return {
  enabled = false,

  -- Disable logging for now until the jsonrpc warning flood is fixed
  cmd = { 'pylsp', '--log-file', '/dev/null' },

  capabilities = {
    -- Using external tools for formatting
    documentFormattingProvider = false,
    documentRangeFormattingProvider = false,
  },

  ---@type lspconfig.settings.pylsp
  settings = {
    pylsp = {
      configurationSources = { 'flake8' },
      plugins = {
        -- Get lints from external tools
        autopep8 = { enabled = false },
        flake8 = { enabled = false },
        pycodestyle = { enabled = false },
        pydocstyle = { enabled = false },
        pyflakes = { enabled = false },
        pylint = { enabled = false },
        rope_autoimport = { enabled = true },
        rope_completion = { enabled = true },
        yapf = { enabled = false },
      },
    },
  },
}
