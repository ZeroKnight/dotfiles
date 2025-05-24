-- Individual Language Server settings

---@type table<string, lspconfig.Config>
---@diagnostic disable:missing-fields
return {
  ansiblels = {
    settings = {
      ansible = {
        ansible = { useFullyQualifiedCollectionNames = true },
        completion = {
          provideRedirectModules = true,
          provideModuleOptionAliases = true,
        },
        validation = {
          enabled = true,
          lint = { enabled = true },
        },
      },
    },
  },
  gopls = {},
  jedi_language_server = {
    settings = {
      diagnostics = { enable = true },
      markupKindPreferred = 'markdown',
      workspace = {
        symbols = {
          maxSymbols = 0, -- Return all symbols
        },
      },
    },
  },
  jsonls = {
    settings = {
      json = {
        schemas = require('schemastore').json.schemas(),
        validate = { enable = true },
      },
    },
  },
  -- NOTE: lua_ls will not (yet) use the passed settings in a
  -- workspace/didChangeConfiguration notification. See issue #2899.
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
  },
  powershell_es = {
    settings = {
      powershell = {
        codeFolding = { enable = true },
        codeFormatting = {
          addWhitespaceAroundPipe = true,
          alignPropertyValuePairs = false,
          autoCorrectAliases = true,
          avoidSemicolonsAsLineTerminators = true,
          ignoreOneLineBlock = true,
          newLineAfterCloseBrace = true,
          newLineAfterOpenBrace = false,
          openBraceOnSameLine = true,
          pipelineIndentationStyle = 'IncreaseIndentationForFirstPipeline',
          trimWhitespaceAroundPipe = true,
          useConstantStrings = true,
          useCorrectCasing = true,
          whitespaceAfterSeparator = true,
          whitespaceAroundOperator = true,
          whitespaceBeforeOpenBrace = true,
          whitespaceBeforeOpenParen = true,
          whitespaceBetweenParameters = true,
          whitespaceInsideBrace = true,
        },
        developer = { editorServicesLogLevel = 'None' },
        enableReferencesCodeLens = true,
        integratedConsole = { showOnStartup = false },
        scriptAnalysis = { enable = true },
      },
    },
  },
  pylsp = {
    disabled = true,
    -- Disable logging for now until the jsonrpc warning flood is fixed
    cmd = { 'pylsp', '--log-file', '/dev/null' },
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
    capabilities = {
      -- Using external tools for formatting
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
