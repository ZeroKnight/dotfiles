-- ZeroKnight's Mappings

-- These are my general, non-plugin-specific mappings. Plugin-related mappings
-- are defined in their lazy.nvim spec.

local wk = require 'which-key'

local util = require 'zeroknight.util'
local format = require 'zeroknight.format'
local lint = require 'zeroknight.lint'

local api = vim.api
local diag = vim.diagnostic

local function copy(addr, count)
  if string.find(vim.fn.mode(), '[vVsS\22\23]') then
    api.nvim_feedkeys('V', 'x', true) -- Make nvim update visual marks
    util.cmdf([[silent! execute "'<,'>copy %s%d"]], addr, count)
    api.nvim_feedkeys("'[V']", 'n', false)
  else
    util.cmdf('silent! execute "copy %s%d"', addr, count)
  end
end

local function blank(dir, count)
  if dir == 'up' then
    util.cmdf("put! =repeat(nr2char(10), %d) | ']+", count)
  else
    util.cmdf("put =repeat(nr2char(10), %d) | '[-", count)
  end
end

-- Set up primary group names
wk.add {
  mode = { 'n', 'v' },
  { ']', group = 'next' },
  { '[', group = 'prev' },
  { '<Leader><Leader>', group = 'Aux Leader' },
  { '<Leader>b', group = 'buffer' },
  { '<Leader>f', group = 'file/find' },
  { '<Leader>g', group = 'git' },
  { '<Leader>h', group = 'help' },
  { '<Leader>r', group = 'refactor' },
  { '<Leader>s', group = 'search/snippets' },
  { '<Leader>t', group = 'toggle' },
  { '<Leader>u', group = 'ui' },
  { '<Leader>x', group = 'diag/quickfix' },
  { '<LocalLeader>t', group = 'testing' },
}

-- Leader Mappings {{{1

-- stylua: ignore
wk.add {
  { '<Leader>tb', util.toggle_background, desc = 'Toggle background' },
  { '<Leader>tf', format.toggle, desc = 'Toggle format on write' },
  { '<Leader>tl', lint.toggle, desc = 'Toggle automatic linting' },
  { '<Leader>ui', vim.show_pos, desc = 'Inspect cursor position' },
  { '<Leader>xL', vim.diagnostic.setloclist, desc = 'Dump diagnostics to location list' },
  { '<Leader>xQ', vim.diagnostic.setqflist, desc = 'Dump diagnostics to quickfix list' },
  { '<Leader>wx', '<Cmd>write | source %<CR>', desc = 'Write and Execute' },
  { "<Leader>Y", '"+Y', desc = "Yank til EOL to clipboard" },
  {
    mode = {'n', 'v'},
    { '<Leader>bf', util.partial(format.format), desc='Format buffer'},
    { '<Leader>d', '"_d', desc = 'Delete, but preserve unnamed register' },
    { '<Leader>y', '"+y', desc = 'Yank to clipboard'  },
  },
}

-- LocalLeader Mappings {{{1

wk.add {
  { '<LocalLeader>K', 'K', desc = 'Run keywordprg on word' },
  { '<LocalLeader>rs', util.trim_whitespace, desc = 'Trim trailing spaces' },
  { '<LocalLeader>rw', ':%s/\\<<C-r><C-w>\\>//gI<Left><Left><Left>', desc = 'Substitute cursor word' },
  { '<LocalLeader>rW', ':%s/\\<<C-r><C-a>\\>//gI<Left><Left><Left>', desc = 'Substitute cursor WORD' },
}

-- Everything else {{{1
-- stylua: ignore
wk.add {
  { '[y', function() copy('-', vim.v.count1) end, desc = 'Copy line up', },
  { '[<Space>', function() blank('up', vim.v.count1) end, desc = 'Add blank line up' },
  { ']y', function() copy('+-', vim.v.count1) end, desc = 'Copy line down' },
  { ']<Space>', function() blank('down', vim.v.count1) end, desc = 'Add blank line down' },
  { 'gy', '<Cmd>%y+<CR>', desc = 'Yank buffer to clipboard' },
  { 'gK', 'f<Space>r<CR>', desc = 'Split line' },
  { 'g{', "len(getline(line('.')-1)) > 0 ? '{+' : '{-'", desc = 'Smart paragraph backward', expr = true },
  { 'g}', "len(getline(line('.')+1)) > 0 ? '}-' : '}+'", desc = 'Smart paragraph forward', expr = true },
  { '<M-d>', util.partial(diag.open_float, 0, { scope = 'line' }), desc = 'Show diagnostics for line', mode = { 'n', 'i' } },
  {
    mode = 'v',
    { '[y', function() copy("'<-", vim.v.count1) end, desc = 'Copy line(s) up' },
    { ']y', function() copy("'>.", vim.v.count1) end, desc = 'Copy line(s) down' },
  },
}

-- }}}

-- Standard Behavior Overwrites {{{1

-- More logical Y
vim.keymap.set('', 'Y', 'y$', { desc = 'Yank to end of line' })

-- Always move by visual line, except when giving a count
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

vim.keymap.set('i', '<C-@>', '<C-Space>', { remap = true, desc = 'Workaround for C-Space detection' })

vim.keymap.set('x', '<', '<gv', { desc = 'Stay in Visual mode after unindenting' })
vim.keymap.set('x', '>', '>gv', { desc = 'Stay in Visual mode after indenting' })

vim.keymap.set('n', 'J', "m'J`'", { desc = 'Maintain cursor position when joining lines' })
vim.keymap.set('n', '<C-u>', '<Cmd>normal! <C-u>zz<CR>', { desc = 'Scroll up; keep cursor line centered' })
vim.keymap.set('n', '<C-d>', '<Cmd>normal! <C-d>zz<CR>', { desc = 'Scroll down; keep cursor line centered' })

vim.keymap.set('n', 'n', 'nzv', { desc = 'Next search result; open folds' })
vim.keymap.set('n', 'N', 'Nzv', { desc = 'Previous search result; open folds' })

-- Add undo breakpoints while typing
vim.keymap.set('i', '.', '.<C-g>u')
vim.keymap.set('i', ',', ',<C-g>u')
vim.keymap.set('i', ';', ';<C-g>u')

-- Simple Remappings and Shortcuts {{{1

vim.keymap.set('x', 'v', '<C-v>', { desc = 'Switch to Visual-Block mode from Visual mode a bit quicker' })
vim.keymap.set('x', '.', '<Cmd>normal .<CR>', { desc = 'Enable . in visual mode' })

-- Copy lines up/down in visual or insert mode.
-- Companion mappings to [y and ]y
vim.keymap.set('i', '<M-K>', '<Cmd>copy -1<CR>', { desc = 'Copy line up' })
vim.keymap.set('i', '<M-J>', '<Cmd>copy .<CR>', { desc = 'Copy line down' })
vim.keymap.set('v', '<M-K>', function() copy("'<-", vim.v.count1) end, { desc = 'Copy line up' })
vim.keymap.set('v', '<M-J>', function() copy("'>.", vim.v.count1) end, { desc = 'Copy line down' })

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
