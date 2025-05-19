-- General UI settings, colors, and highlighting

local ffi = require 'ffi'

local util = require 'zeroknight.util'
local Color = require('zeroknight.util.color').Color

local format = string.format

-- Allows us to call a non-exposed nvim function to get the number of screen
-- columns occupied by the gutter.
-- Found in anuvyklack/pretty-fold.nvim issue #38
ffi.cdef [[
  typedef struct window_S win_T;
  int win_col_off(win_T *wp);
  extern win_T *curwin;
]]

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
  vim.opt.foldtext = "v:lua.require('zeroknight.config.ui').foldtext()"
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

local parser_cache = setmetatable({}, {
  __index = function(t, k)
    local parser = vim.F.npcall(vim.treesitter.get_parser, k)
    rawset(t, k, parser)
    return parser
  end,
})

-- TODO: make this a metatable with __call, __index (parser_cache), and setting storage (foldtext.opts)
-- TODO: account for semantic token highlights? e.g. `vim.`
function M.foldtext()
  local indent = string.rep(' ', vim.fn.indent(vim.v.foldstart))
  local chunks = { { indent, 'Folded' } }

  local function _fallback(msg)
    vim.notify_once(format(msg .. '; falling back to empty foldtext()', vim.bo.filetype), vim.log.levels.WARN)
    vim.schedule(function() vim.wo.foldtext = '' end)
  end

  local parser = parser_cache[vim.api.nvim_get_current_buf()] --- @type vim.treesitter.LanguageTree
  if not parser then
    _fallback "No Treesitter parser for buffer with filetype '%s'"
    return
  end
  -- local query = vim.treesitter.query.get(parser:lang(), 'highlights')
  -- if not query then
  --   _fallback "No highlight queries for buffer with filetype '%s'"
  --   return
  -- end

  -- Find first non-blank line that is also not only opening brackets
  local join_stop = vim.v.foldstart
  for _, line in ipairs(vim.api.nvim_buf_get_lines(0, vim.v.foldstart - 1, vim.v.foldend, true)) do
    if not line:match '^[%s{[(]*$' then
      break
    end
    join_stop = join_stop + 1
  end

  local bing = 0
  parser:for_each_tree(function(tstree, tree)
    if not tstree then
      return
    end
    bing = bing + 1
    print(bing)
    local root = tstree:root()
    local root_start_row, _, root_end_row, _ = root:range()

    -- Only worry about trees within the line range
    if root_start_row > vim.v.foldstart - 1 or root_end_row < vim.v.foldstart - 1 then
      return
    end

    local query = vim.treesitter.query.get(tree:lang(), 'highlights')
    if not query then
      return
    end

    -- Build the foldtext out of extmarks-like { text, hl } pairs with info from
    -- the Treesitter node captures
    local prev_node
    for id, node in query:iter_captures(root, 0, vim.v.foldstart - 1, join_stop) do
      local capture = query.captures[id]
      local text = vim.treesitter.get_node_text(node, 0)
      local hl = '@' .. capture

      if prev_node == nil then
        chunks[#chunks + 1] = { text, hl }
      elseif node:equal(prev_node) then
        -- Multiple queries can match the same node. Generally, the last one
        -- tends to be the most specific capture and therefore the "correct" one
        -- for highlighting purposes
        chunks[#chunks] = { text, hl }
      else -- Next node
        local start_row, start_col = node:start()
        local prev_end_row, prev_end_col = prev_node:end_()

        if start_row > prev_end_row then
          -- Coalesce newlines lines in our join range
          chunks[#chunks + 1] = { ' ', 'Folded' }
        elseif start_col > prev_end_col then
          -- Fill in uncaptured text between nodes
          local fill = vim.api.nvim_buf_get_text(0, start_row, prev_end_col, start_row, start_col, {})[1]
          chunks[#chunks + 1] = { fill, 'Folded' }
        end

        chunks[#chunks + 1] = { text, hl }
      end
      prev_node = node
    end
  end)

  -- Right-aligned text

  local rpad = 3
  local total_lines = vim.api.nvim_buf_line_count(0)
  local lines_folded = vim.v.foldend - vim.v.foldstart + 1
  local fold_percentage = (1 - (total_lines - lines_folded) / total_lines) * 100

  local left_len = 0
  for _, chunk in ipairs(chunks) do
    left_len = left_len + vim.fn.strdisplaywidth(chunk[1])
  end

  chunks[#chunks + 1] = {
    format('  %d line%s (%d%%)', lines_folded, lines_folded == 1 and '' or 's', fold_percentage),
    'Folded',
  }

  -- Middle Padding
  table.insert(chunks, #chunks, {
    string.rep(
      vim.opt.fillchars:get().fold or '·',
      vim.api.nvim_win_get_width(0)
        - ffi.C.win_col_off(ffi.C.curwin)
        - left_len
        - vim.fn.strdisplaywidth(chunks[#chunks][1])
        - rpad
    ),
    'Folded',
  })

  return chunks
end

return M
