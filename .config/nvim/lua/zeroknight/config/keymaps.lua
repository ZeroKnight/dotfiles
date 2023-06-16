-- ZeroKnight's Mappings

-- These are my general, non-plugin-specific mappings. Plugin-related mappings
-- are defined in their lazy.nvim spec.

local wk = require 'which-key'

local util = require 'zeroknight.util'

local diag = vim.diagnostic

local function toggle(option)
  vim.opt_local[option] = not vim.opt_local[option]:get()
  vim.notify(
    (vim.opt_local[option]:get() and 'Enabled ' or 'Disabled ') .. option,
    vim.log.levels.INFO,
    { title = 'Option toggled' }
  )
end

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
  ['<Leader>s'] = { name = 'search/snippets' },
  ['<Leader>t'] = { name = 'toggle' },
  ['<Leader>u'] = { name = 'ui' },
  ['<Leader>x'] = { name = 'diag/quickfix' },
  ['<LocalLeader>t'] = { name = 'testing' },
}, { mode = { 'n', 'v' } })

-- Leader Mappings {{{1

-- stylua: ignore
wk.register({
  ['/'] = { '<Cmd>let v:hlsearch = !v:hlsearch<CR>', 'Toggle Search Highlighting' },
  d = { '"_d', 'Delete, but preserve unnamed register', mode = { 'n', 'v' } },
  t = {
    d = { util.partial(util.toggle_diagnostics, 0), 'Toggle diagnostics' },
    l = { function() toggle 'list' end, 'Toggle listchars', },
    s = { function() toggle 'spell' end, 'Toggle Spellcheck', },
    w = { function() toggle 'wrap' end, 'Toggle word wrap', },
    ['/'] = { function() toggle 'hlsearch' end, 'Toggle hlsearch', },
  },
  u = {
    i = { vim.show_pos, 'Inspect cursor position' },
  },
  x = {
    L = { vim.diagnostic.setloclist, 'Dump diagnostics to location list' },
    Q = { vim.diagnostic.setqflist, 'Dump diagnostics to quickfix list' },
  },
  wx = { '<Cmd>call zeroknight#util#save_and_exec()<CR>', 'Write and Execute' },
  y = { '"+y', 'Yank to clipboard', mode = { 'n', 'v' } },
  Y = { '"+Y', 'Yank til EOL to clipboard' },
}, { prefix = '<Leader>' })

-- LocalLeader Mappings {{{1

wk.register({
  K = { 'K', 'Run keywordprg on word' },
  r = {
    s = { '<Cmd>call zeroknight#util#TrimTrailingSpace()<CR>', 'Trim trailing spaces' },
    w = { ':%s/\\<<C-r><C-w>\\>//gI<Left><Left><Left>', 'Substitute cursor word' },
    W = { ':%s/\\<<C-r><C-a>\\>//gI<Left><Left><Left>', 'Substitute cursor WORD' },
  },
}, { prefix = '<LocalLeader>' })

-- Everything else {{{1
wk.register {
  ['['] = {
    c = { '<Cmd>copy -<CR>', 'Copy line up' },
    d = { diag.goto_prev, 'Previous Diagnostic' },
  },
  [']'] = {
    c = { '<Cmd>copy .<CR>', 'Copy line down' },
    d = { diag.goto_next, 'Next Diagnostic' },
  },
  g = {
    y = { '<Cmd>%y+<CR>', 'Yank buffer to clipboard' },
    K = { 'f<Space>r<CR>', 'Split line' },
    ['{'] = { "len(getline(line('.')-1)) > 0 ? '{+' : '{-'", 'Smart paragraph backward', expr = true },
    ['}'] = { "len(getline(line('.')+1)) > 0 ? '}-' : '}+'", 'Smart paragraph forward', expr = true },
  },
  ['<M-d>'] = { util.partial(diag.open_float, 0, { scope = 'line' }), 'Show diagnostics for line', mode = { 'n', 'i' } },
}

wk.register({
  ['['] = {
    c = { ':copy -<CR>', 'Copy line up' },
  },
  [']'] = {
    c = { ':copy +<CR>', 'Copy line down' },
  },
}, { mode = 'v' })

-- }}}

-- Standard Behavior Overwrites {{{1

-- More logical Y
vim.keymap.set('', 'Y', 'y$', { desc = 'Yank to end of line' })

-- Always move by visual line, except when giving a count
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

vim.keymap.set('i', '<C-@>', '<C-Space>', { remap = true }, { desc = 'Workaround for C-Space detection' })

vim.keymap.set('x', '<', '<gv', { desc = 'Stay in Visual mode after unindenting' })
vim.keymap.set('x', '>', '>gv', { desc = 'Stay in Visual mode after indenting' })

vim.keymap.set('n', 'J', "m'J`'", { desc = 'Maintain cursor position when joining lines' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Scroll up; keep cursor line centered' })
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Scroll down; keep cursor line centered' })

vim.keymap.set('n', 'n', 'nzv', { desc = 'Next search result; open folds' })
vim.keymap.set('n', 'N', 'Nzv', { desc = 'Previous search result; open folds' })

-- Add undo breakpoints while typing
vim.keymap.set('i', '.', '.<C-g>u')
vim.keymap.set('i', ',', ',<C-g>u')
vim.keymap.set('i', ';', ';<C-g>u')

-- Simple Remappings and Shortcuts {{{1

vim.keymap.set('x', 'v', '<C-v>', { desc = 'Switch to Visual-Block mode from Visual mode a bit quicker' })
vim.keymap.set('x', '.', '<Cmd>normal .<CR>', { desc = 'Enable . in visual mode' })

-- Copy/Move the current line while in Insert/Visual mode like in other editors.
-- A nice companion to tpope/unimpaired
vim.keymap.set('i', '<M-Up>', '<Esc><Cmd>move -2<CR>==gi', { desc = 'Move line up', silent = true })
vim.keymap.set('i', '<M-Down>', '<Esc><Cmd>move +1<CR>==gi', { desc = 'Move line down', silent = true })
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