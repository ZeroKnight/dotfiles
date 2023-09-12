-- Neovim Options

local providers = require 'zeroknight.providers'

local opt = vim.opt

-- UI Settings {{{1

-- Enable the mouse. Being able to resize windows with the mouse is fantastic.
-- However, it gets annoying in insert mode with overly sensitive touchpads...
opt.mouse = 'nvch'

-- Selecting
opt.selection = 'inclusive'
opt.selectmode = { 'mouse', 'key' }
-- Shift + [End|Home|PgUp|PgDn|Arrows] can select text
opt.keymodel = { 'startsel', 'stopsel' }

-- Cursor style
opt.guicursor = {
  'n-v-c-sm:block',
  'i-ci-ve:ver25',
  'r-cr-o:hor20',
  'a:Cursor-blinkwait300-blinkon200-blinkoff150',
}

-- Statusline and Commandline
opt.display = { 'lastline', 'msgsep' }
opt.laststatus = 2 -- Always show statusline
opt.showcmd = true -- Show pending operators and visual selection range
opt.showmode = false -- Our statusline covers this
opt.shortmess = opt.shortmess
  + 'c' -- Don't show ins-completion messages, it's annoying with autocompletion
  - 'A' -- Show warning about existing swap files

opt.relativenumber = true -- Show relative line numbers
opt.number = true -- But show our current line number instead of 0
opt.colorcolumn = '+1' -- Show the boundary of textwidth
opt.cursorline = true
opt.inccommand = 'split'

-- Buffer Behavior
opt.hidden = true -- Make buffers not annoying
opt.autoread = true -- Automatically reload buffers changed outside of Neovim

-- Comfy scroll padding
opt.scrolloff = 3
opt.sidescrolloff = 5 -- Start scrolling 5 columns from the horizontal window edge
opt.sidescroll = 15 -- Scroll 15 columns at a time

-- This splitting behavior feels more natural to me
opt.splitright = true
opt.splitbelow = true

-- Don't mess with my windows; I'll <C-w>= when I need to.
opt.equalalways = false

-- Line wrapping
opt.wrap = true -- Wrapping is on by default
opt.linebreak = true -- Break early at certain characters, rather than just the last
opt.breakindent = true -- Visually indicate wrapped lines
opt.showbreak = '↪ '

-- Show helpful meta-characters
opt.list = true
opt.listchars = {
  tab = '→ ',
  trail = '∙',
  nbsp = '␣',
  eol = '¬',
  extends = '❯',
  precedes = '❮',
}

-- Wild Menu
opt.wildmenu = true
opt.wildmode = { 'longest', 'full' }
opt.wildignorecase = true

-- styulua: ignore
opt.wildignore = {
  '*.jpg',
  '*.jpeg',
  '*.png',
  '*.bmp',
  '*.tiff',
  '*.tga',
  '*.gif',
  '*.o',
  '*.obj',
  '*.exe',
  '*.a',
  '*.so',
  '*.dll',
  '*.pyc',
  '__pycache__',
  '*/.svn',
  '*/.hg',
  '*/.bzr',
  '*/.git',
  '*.db',
  '*.sqlite',
  '*~',
  '*.swp',
  '*.swo',
  '*.swn',
  'tags',
  'TAGS',
  '*.tags',
  '*.TAGS',
}

-- Pop-up Menu
opt.pumheight = 20 -- Don't take up the entire screen height
opt.pumblend = 17 -- Transparent menu

-- Fold Options
opt.foldcolumn = 'auto:1' -- Minimal fold column
opt.foldopen:append { 'jump' }

opt.belloff = 'all' -- Bells are evil, kill them with fire
opt.whichwrap:append '<,>,[,]'

-- Color & Syntax Settings
opt.termguicolors = true -- 24-bit Colors
opt.synmaxcol = 500 -- Don't bother highlighting obnoxious lines

-- Editing & Formatting {{{1

-- Searching
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.hlsearch = true

opt.textwidth = 120
opt.commentstring = '# %s' -- Sane default
opt.formatoptions = opt.formatoptions
  - 'at' -- Don't auto-format, we have linters now
  + 'cq' -- Formatting comments is fine, though
  + '1' -- Don't break on single-letter words
  + 'l' -- Don't try to wrap a line that was already longer than textwidth
  - 'o' -- I rarely want comment leaders continued on o and O
  + 'r' -- ... but I do want Enter to continue comments
  + 'n' -- Keep lists looking nice
  + 'j' -- No point in keeping comment leaders on joined lines
  - '2' -- This is a text editor, not a word processor
opt.joinspaces = false -- Nobody does this

opt.backspace = { 'indent', 'eol', 'start' } -- Sane backspace functionality

-- Tabs
opt.expandtab = true -- Use spaces for tabs like a civilized person
opt.smarttab = true -- Redundant when sts=-1, but useful when sts=0
opt.autoindent = true
opt.smartindent = false -- Explicitly disable this legacy behavior
opt.tabstop = 4 -- 4 spaces by default, 2 on a per-filetype basis
opt.shiftwidth = opt.tabstop:get()

-- My preference is to set 'sts' one of two ways: either 0 or -1 and always with
-- 'smarttab' set. When -1, <BS> will always delete enough spaces to reach
-- a tabstop, even between words. When 0, <BS> will only delete more than one
-- space when at the start of a line, not in between words; this is due to
-- 'smarttab' being active.
--
-- My general default is -1, as that's the behavior I want most of the time.
-- I may switch to 0 on a per-file or per-filetype basis if I need to do a lot
-- of text alignment.
opt.softtabstop = -1

-- stylua: ignore start
opt.cinoptions = {
  'Ls', 'l1', 'b1', 'g0', 'N-s', 't0', '(0', 'U1', 'w1', 'Ws', 'm1', 'j1', 'J1',
}
opt.cinkeys = {
  '0{', '0}', ':', '0#', '!^F', 'o', 'O', 'e', '0=break',
}
-- stylua: ignore end

-- Neovim State/Persistence Settings {{{1

opt.history = 10000
opt.shada = { '!', 'h', "'100", '<1000' }
opt.undofile = true

-- Make a temporary backup before writing that will be deleted on
-- a successful write.
-- Prevents total file loss in case Vim fails to write and then closes.
opt.writebackup = true

opt.sessionoptions = {
  'buffers',
  'curdir',
  'help',
  'localoptions',
  'tabpages',
  'winsize',
}
opt.viewoptions = { 'cursor', 'curdir', 'folds', 'localoptions' }

-- Neovim Providers {{{1
-- vim.g.python_host_prog = providers.python(2) and providers.python(2) or nil
vim.g.python3_host_prog = providers.python(3) and providers.python(3) or nil

-- Miscellaneous {{{1

opt.fileignorecase = true -- I like to be lazy when tab-completing
opt.keywordprg = ':Man' -- K should show man pages inside Vim
opt.updatetime = 1000 -- Faster update time for swap writes and `CursorHold` events

if vim.fn.executable 'rg' then
  opt.grepprg = 'rg -H --no-heading --vimgrep'
end

opt.spellfile = as_stdpath('config', 'en.utf-8.add')

opt.tags:append { 'src/**/tags', '.git/tags' }

-- Directories to search when using file commands (gf, ^Wf, :*find, etc)
opt.path:append { '/usr/local/include' }

-- Namespace for misc variables
if not vim.g.zeroknight then
  vim.g.zeroknight = {}
end

-- }}}

-- Use local config, if available
local local_init = as_stdpath('data', 'init.local.lua')
if vim.fn.filereadable(local_init) == 1 then
  dofile(local_init)
end

-- vim: fdm=marker
