-- ZeroKnight's Mappings

-- These are my general, non-plugin-specific mappings. Plugin-related mappings
-- are defined in the sibling `plugins.lua` file.

local wk = require('which-key')
local key = require('zeroknight.util.key')

-- Leader Mappings {{{1
local leader = {
  cd =  {'<Cmd>cd %:p:h<Bar>pwd<CR>',  'CWD to current file'},
  lcd = {'<Cmd>lcd %:p:h<Bar>pwd<CR>', 'CWD to current file (Buffer)'},
  tcd = {'<Cmd>tcd %:p:h<Bar>pwd<CR>', 'CWD to current file (Tab)'},
  r = {
    w = {':%s/\\<<C-r><C-w>\\>/', 'Substitute cursor word'},
    W = {':%s/\\<<C-r><C-a>\\>/', 'Substitute cursor WORD'}
  },
  ts = {'<Cmd>call zeroknight#util#TrimTrailingSpace()<CR>', 'Trim trailing spaces'},
  wx = {'<Cmd>call zeroknight#util#save_and_exec()<CR>', 'Write and Execute'},
  ['/'] = {'<Cmd>let v:hlsearch = !v:hlsearch<CR>', 'Toggle Search Highlighting'},
}

-- LocalLeader Mappings {{{1
local localleader = {
  s = {'<Cmd>setlocal spell!<CR>', 'Toggle Spellcheck'}
}

-- g Mappings {{{1
local g = {
  y = {'<Cmd>%y+<CR>', 'Yank buffer to clipboard'},
  K = {'f<Space>r<CR>', 'Split line'},
  ['{'] = {"len(getline(line('.')-1)) > 0 ? '{+' : '{-'", 'Smart paragraph backward', expr = true},
  ['}'] = {"len(getline(line('.')+1)) > 0 ? '}-' : '}+'", 'Smart paragraph forward', expr = true},
}

-- }}}

wk.register(leader, {prefix = '<Leader>'})
wk.register(localleader, {prefix = '<LocalLeader>'})
wk.register(g, {prefix = 'g'})

-- Standard Behavior Overwrites {{{1

-- More logical Y
key.noremap('', 'Y', 'y$')

-- More sensible mark jumping. ` is at the beginning of the keyboard, so have its
-- behavior match its position. It also "points" toward the start of the line.
-- Also, ' is easier to reach and what I want more often anyway.
key.noremap('', '`', "'")
key.noremap('', "'", '`')

-- Always move by visual line
key.nnoremap('k', 'gk')
key.nnoremap('j', 'gj')

-- Workaround for C-Space detection
key.imap('<C-@>', '<C-Space>')

-- Stay in Visual mode after indenting
key.vnoremap('<', '<gv')
key.vnoremap('>', '>gv')

-- Simple Remappings and Shortcuts {{{1

-- Switch to Visual-Block mode from Visual mode a bit quicker
key.xnoremap('v', '<C-v>')

-- Enable . in visual mode
key.vnoremap('.', '<Cmd>normal .<CR>')

-- UI Related {{{1

-- Window Switching
key.nnoremap('<C-H>', '<C-w>h')
key.nnoremap('<C-J>', '<C-w>j')
key.nnoremap('<C-K>', '<C-w>k')
key.nnoremap('<C-L>', '<C-w>l')

-- Window Resizing
key.nnoremap('<M-Left>',  '<C-w>5<')
key.nnoremap('<M-Right>', '<C-w>5>')
key.nnoremap('<M-Up>',    '<C-w>5+')
key.nnoremap('<M-Down>',  '<C-w>5-')

-- Allow <Tab> and <S-Tab> to cycle the popup menu
key.inoremap('<Tab>',   'pumvisible() ? "\\<C-n>" : "\\<Tab>"', {expr =true})
key.inoremap('<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<S-Tab>"', {expr = true})

-- }}

-- Define plugin mappings
require('zeroknight.config.keymaps.plugins')

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