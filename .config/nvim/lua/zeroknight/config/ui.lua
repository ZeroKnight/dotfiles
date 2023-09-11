-- General UI settings, colors, and highlighting

local util = require 'zeroknight.util'
local Color = require('zeroknight.util.color').Color

local format = string.format

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
      help = ' ',
      linenr = '',
    },
    folds = {
      open = '',
      closed = '',
      span = '│',
    },
    separators = {
      breadcrumb = '»',
      left = { a = '', b = '' },
      right = { a = '', b = '' },
    },
    git = {
      logo = ' ',
      branch = '',
      added = ' ',
      modified = ' ',
      removed = ' ',
    },
    diagnostics = {
      Ok = '﫠',
      Error = ' ',
      Warn = ' ',
      Info = ' ',
      Hint = ' ',
    },
    logging = {
      TRACE = ' ',
      DEBUG = ' ',
      INFO = ' ',
      WARN = ' ',
      ERROR = ' ',
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
  vim.opt.statuscolumn = "%{%v:lua.require('zeroknight.config.ui').statuscolumn()%}"
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

function M.statuscolumn()
  local segments = { fold = '', line = '' }

  if vim.wo.foldcolumn ~= 0 then
    local foldlevel = vim.fn.foldlevel
    local foldclosed = vim.fn.foldclosed
    local content = ' '

    local current_foldlevel = foldlevel(vim.v.lnum)
    if current_foldlevel > 0 then
      if current_foldlevel > foldlevel(vim.v.lnum - 1) then
        content = foldclosed(vim.v.lnum) > -1 and M.icons.folds.closed or M.icons.folds.open
      else
        content = M.icons.folds.span
      end
    end
    segments.fold = format('%%#FoldColumn#%s%%*', content)
  end

  if vim.wo.number or vim.wo.relativenumber then
    if vim.v.relnum == 0 then -- Current line
      if vim.wo.number then
        local total_lines = tostring(vim.api.nvim_buf_line_count(0))
        segments.line = format('%%%d{v:lnum}', #total_lines)
      else
        segments.line = '%=' .. vim.v.relnum
      end
    else -- Other lines
      segments.line = '%=' .. (vim.wo.relativenumber and vim.v.relnum or vim.v.lnum)
    end
  end

  return format('%s%%s%s ', segments.fold, segments.line)
end

return M
