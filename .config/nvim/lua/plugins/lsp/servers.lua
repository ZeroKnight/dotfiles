-- Individual Language Server settings

return {
  jsonls = {},
  lua_ls = {
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
        -- Sumneko's telemetry looks minimal and non-invasive.
        telemetry = { enable = true },
      },
    },
  },
  pylsp = {
    -- Disable logging for now until the jsonrpc warning flood is fixed
    cmd = { 'pylsp', '--log-file', '/dev/null' },
    settings = {
      pylsp = {
        configurationSources = { 'flake8' },
        plugins = {
          flake8 = { enabled = true },
          pyflakes = { enabled = false },
          pydocstyle = { enabled = true },
          rope = { enabled = true },
          rope_autoimport = { enabled = true },
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
