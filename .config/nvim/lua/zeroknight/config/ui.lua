-- General UI settings, colors, and highlighting

local util = require 'zeroknight.util'
local Color = require('zeroknight.util.color').Color

local format = string.format

local M = {
  borders = 'rounded',
  highlight = {
    -- How long a temporary "indicator" highlight should last, e.g. yank highlights
    indicator_duration = 300,
  },
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
      note = '󰍨 ',
      help = '󰘥 ',
      linenr = '',
      find = ' ',
      file = ' ',
      file_blank = ' ',
      folder = ' ',
      folder_open = ' ',
      prompt = '',
    },
    folds = {
      open = '󰅀',
      closed = '󰅂',
      span = '│',
    },
    separators = {
      breadcrumb = '»',
      left = { a = '', b = '' },
      right = { a = '', b = '' },
    },
    git = {
      logo = '󰊢 ',
      branch = '',
      dir = ' ',
      added = ' ',
      modified = ' ',
      removed = ' ',
    },
    diagnostics = {
      Ok = '󰗡 ',
      Error = '󰅚 ',
      Warn = '󰀪 ',
      Info = ' ',
      Hint = ' ',
    },
    logging = {
      error = '󰅚 ',
      warn = '󰀪 ',
      info = ' ',
      debug = ' ',
      trace = '  ',
    },
    kinds = {
      Array = ' ',
      Boolean = '󰨙 ',
      Class = ' ',
      Color = ' ',
      Constant = ' ',
      Constructor = ' ',
      Enum = ' ',
      EnumMember = ' ',
      Event = ' ',
      Field = ' ',
      File = ' ',
      Folder = ' ',
      Function = '󰊕 ',
      Interface = ' ',
      Key = ' ',
      Keyword = ' ',
      Method = '󰊕 ',
      Module = ' ',
      Namespace = '󰅩 ',
      Null = '󰟢 ',
      Number = '󰎠 ',
      Object = '󰅩 ',
      Operator = ' ',
      Package = ' ',
      Property = ' ',
      Reference = ' ',
      Snippet = ' ',
      String = ' ',
      Struct = ' ',
      Text = ' ',
      TypeParameter = ' ',
      Unit = ' ',
      Value = ' ',
      Variable = ' ',
    },
  },
}

function M.init()
  -- Set initial background based on current system theme
  vim.opt.background = M.system_theme()

  vim.api.nvim_create_autocmd('ColorScheme', {
    desc = 'Reload highlighting on colorscheme change',
    group = vim.api.nvim_create_augroup('ZeroKnight.config.ui', { clear = true }),
    callback = function() require('zeroknight.config.ui').make_highlights() end,
  })

  vim.cmd.colorscheme 'tokyonight'
  vim.opt.statuscolumn = "%{%v:lua.require('zeroknight.config.ui').statuscolumn()%}"
  vim.opt.foldtext = ''
end

function M.system_theme()
  local preference_map = { [0] = vim.NIL, [1] = 'dark', [2] = 'light' }
  local result = vim
    .system({
      'dbus-send',
      '--session',
      '--dest=org.freedesktop.portal.Desktop',
      '--type=method_call',
      '--print-reply=literal',
      '/org/freedesktop/portal/desktop',
      'org.freedesktop.portal.Settings.Read',
      'string:org.freedesktop.appearance',
      'string:color-scheme',
    }, { text = true })
    :wait()
  local pref = vim.split(result.stdout, '%s+', { trimempty = true })[4]
  return preference_map[tonumber(pref)]
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
  local segments = { fold = '', sign = '', line = '' }

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

  segments.sign = '%s'
  segments.line = '%l'

  return format('%s%s%s ', segments.fold, segments.sign, segments.line)
end

return M
