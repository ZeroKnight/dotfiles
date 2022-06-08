-- ZeroKnight's Mappings

-- These are my general, non-plugin-specific mappings. Plugin-related mappings
-- are defined in the sibling `plugins.lua` file.

local wk = require 'which-key'

local function diag_method(method)
  return string.format('<Cmd>lua vim.diagnostic.%s<CR>', method)
end

local show_line_diag = diag_method "open_float(0, {scope='line'})"

-- Leader Mappings {{{1
local leader = {
  cd = { '<Cmd>cd %:p:h<Bar>pwd<CR>', 'CWD to current file' },
  lcd = { '<Cmd>lcd %:p:h<Bar>pwd<CR>', 'CWD to current file (Buffer)' },
  tcd = { '<Cmd>tcd %:p:h<Bar>pwd<CR>', 'CWD to current file (Tab)' },
  d = {
    name = 'diagnostic',
    c = { diag_method "open_float(0, {scope='cursor'})", 'Show diagnostics for cursor position' },
    d = { diag_method 'disable()', 'Disable diagnostics for buffer' },
    e = { diag_method 'enable()', 'Enable diagnostics for buffer' },
    l = { show_line_diag, 'Show diagnostics for line' },
    L = { diag_method 'setloclist()', 'Dump diagnostics to location list' },
    q = { diag_method 'setqflist()', 'Dump diagnostics to quickfix list' },
  },
  r = {
    w = { ':%s/\\<<C-r><C-w>\\>/', 'Substitute cursor word' },
    W = { ':%s/\\<<C-r><C-a>\\>/', 'Substitute cursor WORD' },
  },
  ts = { '<Cmd>call zeroknight#util#TrimTrailingSpace()<CR>', 'Trim trailing spaces' },
  wx = { '<Cmd>call zeroknight#util#save_and_exec()<CR>', 'Write and Execute' },
  ww = { '<Cmd>set wrap!<CR>', 'Toggle Word Wrap' },
  ['/'] = { '<Cmd>let v:hlsearch = !v:hlsearch<CR>', 'Toggle Search Highlighting' },
}

-- LocalLeader Mappings {{{1
local localleader = {
  K = { 'K', 'Run keywordprg on word' },
  s = { '<Cmd>setlocal spell!<CR>', 'Toggle Spellcheck' },
}

-- g Mappings {{{1
local g = {
  y = { '<Cmd>%y+<CR>', 'Yank buffer to clipboard' },
  K = { 'f<Space>r<CR>', 'Split line' },
  ['{'] = { "len(getline(line('.')-1)) > 0 ? '{+' : '{-'", 'Smart paragraph backward', expr = true },
  ['}'] = { "len(getline(line('.')+1)) > 0 ? '}-' : '}+'", 'Smart paragraph forward', expr = true },
}

-- Normal/Insert hybrid Mappings {{{1
local ni = {
  ['<M-d>'] = { show_line_diag, 'Show diagnostics for line' },
}

-- Everything else {{{1
local other = {
  ['['] = {
    name = 'prev',
    d = { diag_method 'goto_prev()', 'Previous Diagnostic' },
  },
  [']'] = {
    name = 'next',
    d = { diag_method 'goto_next()', 'Next Diagnostic' },
  },
}

-- }}}

wk.register(leader, { prefix = '<Leader>' })
wk.register(localleader, { prefix = '<LocalLeader>' })
wk.register(g, { prefix = 'g' })
wk.register(ni, { mode = 'n' })
wk.register(ni, { mode = 'i' })
wk.register(other)

-- Standard Behavior Overwrites {{{1

-- More logical Y
vim.keymap.set('', 'Y', 'y$', { desc = 'Yank to end of line' })

-- More sensible mark jumping. ` is at the beginning of the keyboard, so have its
-- behavior match its position. It also "points" toward the start of the line.
-- Also, ' is easier to reach and what I want more often anyway.
vim.keymap.set('', '`', "'")
vim.keymap.set('', "'", '`')

-- Always move by visual line
vim.keymap.set('n', 'k', 'gk')
vim.keymap.set('n', 'j', 'gj')

vim.keymap.set('i', '<C-@>', '<C-Space>', { remap = true }, { desc = 'Workaround for C-Space detection' })

vim.keymap.set('v', '<', '<gv', { desc = 'Stay in Visual mode after unindenting' })
vim.keymap.set('v', '>', '>gv', { desc = 'Stay in Visual mode after indenting' })

-- Simple Remappings and Shortcuts {{{1

vim.keymap.set('x', 'v', '<C-v>', { desc = 'Switch to Visual-Block mode from Visual mode a bit quicker' })
vim.keymap.set('v', '.', '<Cmd>normal .<CR>', { desc = 'Enable . in visual mode' })

-- UI Related {{{1

-- Window Switching
vim.keymap.set('n', '<C-H>', '<C-w>h')
vim.keymap.set('n', '<C-J>', '<C-w>j')
vim.keymap.set('n', '<C-K>', '<C-w>k')
vim.keymap.set('n', '<C-L>', '<C-w>l')

-- Window Resizing
vim.keymap.set('n', '<M-Left>', '<C-w>5<')
vim.keymap.set('n', '<M-Right>', '<C-w>5>')
vim.keymap.set('n', '<M-Up>', '<C-w>5+')
vim.keymap.set('n', '<M-Down>', '<C-w>5-')

-- Allow <Tab> and <S-Tab> to cycle the popup menu
vim.keymap.set(
  'i',
  '<Tab>',
  'pumvisible() ? "\\<C-n>" : "\\<Tab>"',
  { expr = true, desc = 'Cycle popup menu forward if open' }
)
vim.keymap.set(
  'i',
  '<S-Tab>',
  'pumvisible() ? "\\<C-p>" : "\\<S-Tab>"',
  { expr = true, desc = 'Cycle popup menu backward if open' }
)

-- }}}

-- Define plugin mappings
require 'zeroknight.config.keymaps.plugins'

-- Abbreviations (See also: after/plugin/abolish.vim)

-- Lazy abbreviations {{{1

vim.cmd [[
  inoreabbrev afaik as far as I know
  inoreabbrev afaict as far as I can tell
  inoreabbrev idk I don't know
  inoreabbrev tbh to be honest
  inoreabbrev tbf to be fair
]]

-- Command Typos {{{1

vim.cmd [[
  cabbrev W w
  cabbrev Q q
  cabbrev E e
]]

-- Command Shortcuts {{{1

vim.cmd [[
  cnoreabbrev hv vert help
  cnoreabbrev ht tab help
]]

-- }}}

-- vim: fdm=marker
