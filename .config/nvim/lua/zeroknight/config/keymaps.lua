-- ZeroKnight's Mappings

-- These are my general, non-plugin-specific mappings. Plugin-related mappings
-- are defined in their lazy.nvim spec.

local wk = require 'which-key'

local function diag_method(method)
  return string.format('<Cmd>lua vim.diagnostic.%s<CR>', method)
end

local show_line_diag = diag_method "open_float(0, {scope='line'})"

-- Set up primary group names
wk.register({
  [']'] = { name = 'next' },
  ['['] = { name = 'prev' },
  ['<Leader><Leader>'] = { name = 'Aux Leader' },
  ['<Leader>b'] = { name = 'buffer' },
  ['<Leader>f'] = { name = 'file/find' },
  ['<Leader>g'] = { name = 'git' },
  ['<Leader>h'] = { name = 'help' },
  ['<Leader>r'] = { name = 'refactor' },
  ['<Leader>s'] = { name = 'snippets' },
  ['<Leader>t'] = { name = 'toggle' },
  ['<Leader>u'] = { name = 'ui' },
  ['<Leader>x'] = { name = 'diag/quickfix' },
  ['<LocalLeader>t'] = { name = 'testing' },
}, { mode = { 'n', 'v' } })

-- Leader Mappings {{{1
local leader = {
  ['<Leader>'] = {
    d = {
      name = 'diagnostic',
      c = { diag_method "open_float(0, {scope='cursor'})", 'Show diagnostics for cursor position' },
      d = { diag_method 'disable()', 'Disable diagnostics for buffer' },
      e = { diag_method 'enable()', 'Enable diagnostics for buffer' },
      l = { show_line_diag, 'Show diagnostics for line' },
      L = { diag_method 'setloclist()', 'Dump diagnostics to location list' },
      q = { diag_method 'setqflist()', 'Dump diagnostics to quickfix list' },
    },
  },
  cd = { '<Cmd>cd %:p:h<Bar>pwd<CR>', 'CWD to current file' },
  lcd = { '<Cmd>lcd %:p:h<Bar>pwd<CR>', 'CWD to current file (Buffer)' },
  tcd = { '<Cmd>tcd %:p:h<Bar>pwd<CR>', 'CWD to current file (Tab)' },
  d = { '"_d', 'Delete, but preserve unnamed register' },
  r = {
    w = { ':%s/\\<<C-r><C-w>\\>//gI<Left><Left><Left>', 'Substitute cursor word' },
    W = { ':%s/\\<<C-r><C-a>\\>//gI<Left><Left><Left>', 'Substitute cursor WORD' },
  },
  ts = { '<Cmd>call zeroknight#util#TrimTrailingSpace()<CR>', 'Trim trailing spaces' },
  wx = { '<Cmd>call zeroknight#util#save_and_exec()<CR>', 'Write and Execute' },
  ww = { '<Cmd>set wrap!<CR>', 'Toggle Word Wrap' },
  y = { '"+y', 'Yank to clipboard' },
  Y = { '"+Y', 'Yank til EOL to clipboard' },
  ['/'] = { '<Cmd>let v:hlsearch = !v:hlsearch<CR>', 'Toggle Search Highlighting' },
}

-- Leader Mappings (Visual) {{{1
local leader_v = {
  d = { '"_d', 'Delete, but preserve unnamed register' },
  y = { '"+y', 'Yank to clipboard' },
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
  n = {
    ['['] = {
      c = { '<Cmd>copy -<CR>', 'Copy line up' },
      d = { diag_method 'goto_prev()', 'Previous Diagnostic' },
    },
    [']'] = {
      c = { '<Cmd>copy .<CR>', 'Copy line down' },
      d = { diag_method 'goto_next()', 'Next Diagnostic' },
    },
  },
  v = {
    ['['] = {
      c = { ':copy -<CR>', 'Copy line up' },
    },
    [']'] = {
      c = { ':copy +<CR>', 'Copy line down' },
    },
  },
}

-- }}}

wk.register(leader, { prefix = '<Leader>', mode = 'n' })
wk.register(leader_v, { prefix = '<Leader>', mode = 'v' })
wk.register(localleader, { prefix = '<LocalLeader>' })
wk.register(g, { prefix = 'g' })
wk.register(ni, { mode = 'n' })
wk.register(ni, { mode = 'i' })
for mode, mappings in pairs(other) do
  wk.register(mappings, { mode = mode })
end

-- Standard Behavior Overwrites {{{1

-- More logical Y
vim.keymap.set('', 'Y', 'y$', { desc = 'Yank to end of line' })

-- More sensible mark jumping. ` is at the beginning of the keyboard, so have its
-- behavior match its position. It also "points" toward the start of the line.
-- Also, ' is easier to reach and what I want more often anyway.
vim.keymap.set({ 'n', 'x', 'o' }, '`', "'")
vim.keymap.set({ 'n', 'x', 'o' }, "'", '`')

-- Always move by visual line
vim.keymap.set('n', 'k', 'gk')
vim.keymap.set('n', 'j', 'gj')

vim.keymap.set('i', '<C-@>', '<C-Space>', { remap = true }, { desc = 'Workaround for C-Space detection' })

vim.keymap.set('x', '<', '<gv', { desc = 'Stay in Visual mode after unindenting' })
vim.keymap.set('x', '>', '>gv', { desc = 'Stay in Visual mode after indenting' })

vim.keymap.set('n', 'J', "m'J`'", { desc = 'Maintain cursor position when joining lines' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Scroll up; keep cursor line centered' })
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Scroll down; keep cursor line centered' })

vim.keymap.set('n', 'n', 'nzv', { desc = 'Next search result; open folds' })
vim.keymap.set('n', 'N', 'Nzv', { desc = 'Previous search result; open folds' })

-- Simple Remappings and Shortcuts {{{1

vim.keymap.set('x', 'v', '<C-v>', { desc = 'Switch to Visual-Block mode from Visual mode a bit quicker' })
vim.keymap.set('x', '.', '<Cmd>normal .<CR>', { desc = 'Enable . in visual mode' })

-- Copy/Move the current line while in Insert mode like in other editors.
-- A nice pair to tpope/unimpaired
vim.keymap.set('i', '<M-Up>', '<Cmd>move -2<CR>', { desc = 'Move line up' })
vim.keymap.set('i', '<M-Down>', '<Cmd>move +1<CR>', { desc = 'Move line down' })
vim.keymap.set('i', '<M-S-Up>', '<Cmd>copy -1<CR>', { desc = 'Copy line up' })
vim.keymap.set('i', '<M-S-Down>', '<Cmd>copy .<CR>', { desc = 'Copy line down' })

vim.keymap.set('v', 'K', ":move '<-2<CR>gv=gv", { desc = 'Move selection up', silent = true })
vim.keymap.set('v', 'J', ":move '>+1<CR>gv=gv", { desc = 'Move selection up', silent = true })
vim.keymap.set('v', '<M-S-Up>', ':copy -<CR>', { desc = 'Copy line up', silent = true })
vim.keymap.set('v', '<M-S-Down>', ':copy +<CR>', { desc = 'Copy line down', silent = true })

-- Quickly start a :lua command line
vim.keymap.set('n', '<M-;>', ':lua ', { desc = 'Quick :lua prompt' })

-- Append comma to line and start a new line
vim.keymap.set('i', '<M-,>', '<End>,<CR>', { desc = 'Append comma and start new line' })

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

-- Abbreviations (See also: Abolish)

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
