-- General UI settings, colors, and highlighting

local util = require 'zeroknight.util'
local Color = require('zeroknight.util.color').Color

local M = {
  borders = 'rounded',
  colors = {
    diagnostics = {
      -- Colors from folke/lsp-colors.nvim
      Error = '#db4b4b',
      Warn = '#e0af68',
      Info = '#0db9d7',
      Hint = '#10b981',
    },
    lsp = {
      reference = {
        Read = Color:new '#38b9ff',
        Write = Color:new '#ffab26',
      },
    },
  },
  icons = {
    common = {
      bug = ' ',
      check = ' ',
      note = ' ',
    },
    folds = {
      open = '',
      closed = '',
    },
    diagnostics = {
      Error = ' ',
      Warn = ' ',
      Info = ' ',
      Hint = ' ',
    },
    kinds = {
      Array = '',
      Boolean = '',
      Class = '',
      Color = '',
      Constant = '',
      Constructor = '',
      Enum = '',
      EnumMember = '',
      Event = '',
      Field = '',
      File = '',
      Folder = '',
      Function = 'ƒ',
      Interface = '',
      Key = '',
      Keyword = '',
      Method = 'ƒ',
      Module = '',
      Namespace = '',
      Null = '∅',
      Number = '#',
      Object = '',
      Operator = 'λ',
      Package = '',
      Property = '',
      Reference = '',
      Snippet = '',
      String = '',
      Struct = '',
      Text = '',
      TypeParameter = '',
      Unit = '',
      Value = '',
      Variable = '',
    },
  },
}

function M.init()
  -- Set initial background based on time of day
  local hour = tonumber(os.date '%H')
  if hour >= 6 and hour < 18 then
    vim.opt.background = 'light'
  else
    vim.opt.background = 'dark'
  end

  vim.api.nvim_create_autocmd('ColorScheme', {
    desc = 'Reload highlighting on colorscheme change',
    group = vim.api.nvim_create_augroup('ZeroKnight.config.ui', { clear = true }),
    callback = function()
      require('zeroknight.config.ui').make_highlights()
    end,
  })

  vim.cmd.colorscheme 'tokyonight'
end

function M.make_highlights()
  -- Spellcheck colors
  vim.cmd [[hi SpellBad cterm=undercurl,bold]]

  -- Make special characters stand out
  vim.cmd [[hi! link SpecialKey DiagnosticHint]]

  -- Diagnostic Highlighting
  for severity, col in pairs(M.colors.diagnostics) do
    util.cmdf('hi def Diagnostic%s guifg=%s', severity, col)
    util.cmdf('hi def DiagnosticUnderline%s gui=undercurl guisp=%s', severity, col)
  end

  -- Alias for Struct LSP kind
  vim.cmd [[hi link Struct Structure]]

  vim.cmd [[hi link LspReferenceText Visual]]
  vim.cmd [[hi link LspSignatureActiveParameter Visual]]

  -- LSP Reference Highlighting
  for reftype, col in pairs(M.colors.lsp.reference) do
    util.cmdf('hi LspReference%s guibg=%s', reftype, col:over(Color:from_background(), 0.18))
  end
end

return M
