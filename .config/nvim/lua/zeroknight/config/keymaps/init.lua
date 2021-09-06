-- ZeroKnight's Mappings

-- These are my general, non-plugin-specific mappings. Plugin-related mappings
-- are defined in the sibling `plugins.lua` file.

local key = require('zeroknight.util.key')

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

-- Change cwd to that of the current file
key.nnoremap('<Leader>cd',  '<Cmd>cd %:p:h<Bar>pwd<CR>')
key.nnoremap('<Leader>lcd', '<Cmd>lcd %:p:h<Bar>pwd<CR>')
key.nnoremap('<Leader>tcd', '<Cmd>tcd %:p:h<Bar>pwd<CR>')

-- Toggle Spellcheck
key.nnoremap('<LocalLeader>s', '<Cmd>setlocal spell!<CR>')

-- Switch to Visual-Block mode from Visual mode a bit quicker
key.xnoremap('v', '<C-v>')

-- Editing {{{1

-- Save and execute file
key.nnoremap('<Leader>wx', '<Cmd>call zeroknight#util#save_and_exec()<CR>')

-- Yank entire buffer to clipboard
key.nnoremap('gy', '<Cmd>%y+<CR>')

-- Split line (thanks, /u/frumsfrums)
key.nnoremap('gK', 'f<Space>r<CR>')

-- Rename word/WORD under cursor
key.nnoremap('<Leader>rw', ':%s/\\<<C-r><C-w>\\>/')
key.nnoremap('<Leader>rW', ':%s/\\<<C-r><C-a>\\>/')

-- TrimTrailingSpace()
key.nnoremap('<Leader>ts', '<Cmd>call zeroknight#util#TrimTrailingSpace()<CR>')

-- Enable . in visual mode
key.vnoremap('.', '<Cmd>normal .<CR>')

-- Precise paragraph movement (thanks, /u/kshenoy42)
key.nnoremap('g{', "len(getline(line('.')-1)) > 0 ? '{+' : '{-'", {expr = true})
key.nnoremap('g}', "len(getline(line('.')+1)) > 0 ? '}-' : '}+'", {expr = true})

-- UI Related {{{1

-- Clear search highlights
key.nnoremap('<Leader>/', '<Cmd>nohls<CR>')

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

-- }}}

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

-- Define plugin mappings
require('zeroknight.config.keymaps.plugins')

-- vim: fdm=marker
