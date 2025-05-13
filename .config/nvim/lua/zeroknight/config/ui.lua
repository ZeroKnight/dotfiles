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
      Constant = ' ',
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
      Namespace = ' ',
      Null = '∅ ',
      Number = '󰎠 ',
      Object = '',
      Operator = ' ',
      Package = ' ',
      Property = ' ',
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
    callback = function() require('zeroknight.config.ui').make_highlights() end,
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

function M.foldtext()
  --[[
    - Indentation is apparent
    - Avoid useless lone brackets as fold text
      - Join them with the next line?
      - Omit them completely?
    - Syntax highlighting like with foldtext=
      - Will have to get ts highlights and transform them into extmark-like pairs
  --]]
  local join_stop = vim.v.foldstart
  local indent = string.rep(' ', vim.fn.indent(vim.v.foldstart))
  for _, line in ipairs(vim.api.nvim_buf_get_lines(0, vim.v.foldstart - 1, vim.v.foldend, true)) do
    if not line:match '^%s*[{[(]?$' then
      break
    end
    join_stop = join_stop + 1
  end

  local parser = vim.treesitter.get_parser()
  local query = vim.treesitter.query.get(parser:lang(), 'highlights')
  local tree = parser:parse({ vim.v.foldstart - 1, join_stop })[1]
  local chunks = {}
  local prev_node
  for id, node in query:iter_captures(tree:root(), 0, vim.v.foldstart - 1, join_stop) do
    local capture = query.captures[id]
    local text = vim.treesitter.get_node_text(node, 0)
    local hl = '@' .. capture
    if prev_node == nil then
      chunks[#chunks + 1] = { text, hl }
    elseif node:equal(prev_node) then
      chunks[#chunks] = { text, hl }
    else
      local start_row, start_col = node:start()
      local prev_end_row, prev_end_col = prev_node:end_()
      if start_row > prev_end_row then
        chunks[#chunks + 1] = { ' ', 'Folded' } -- Fold newlines
      elseif start_col > prev_end_col then
        local fill = vim.api.nvim_buf_get_text(0, start_row, prev_end_col, start_row, start_col, {})[1]
        chunks[#chunks + 1] = { fill, 'Folded' }
      end
      dd(chunks)
      chunks[#chunks + 1] = { text, hl }
    end
    prev_node = node
  end
  return { { indent, 'Folded' }, unpack(chunks) }

  -- return indent
  --   .. vim
  --     .iter(vim.api.nvim_buf_get_lines(0, vim.v.foldstart - 1, join_stop, true), ' ')
  --     :map(function(v) return vim.trim(v) end)
  --     :join ' '
end
vim.opt.foldtext = "v:lua.require('zeroknight.config.ui').foldtext()"

return M
