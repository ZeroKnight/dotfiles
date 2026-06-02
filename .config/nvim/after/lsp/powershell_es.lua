---@type lspconfig.Config
---@diagnostic disable:missing-fields
return {
  -- powershell.nvim handles starting the server since it does a bunch of
  -- bookkeeping for the session and PSES terminal.
  enabled = false,

  ---@type lspconfig.settings.powershell_es
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
}
