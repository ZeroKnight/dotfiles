-- ZeroKnight's Neovim Config

local providers = require('zeroknight.providers')

local opt = vim.opt

-- UI Settings {{{1

-- Enable the mouse. Being able to resize windows with the mouse is fantastic.
-- However, it gets annoying in insert mode with overly sensitive touchpads...
opt.mouse = 'nvch'

-- Selecting
opt.selection = 'inclusive'
opt.selectmode = {'mouse', 'key'}
-- Shift + [End|Home|PgUp|PgDn|Arrows] can select text
opt.keymodel = {'startsel', 'stopsel'}

-- Cursor style
opt.guicursor = {
  'n-v-c-sm:block',
  'i-ci-ve:ver25',
  'r-cr-o:hor20',
  'a:Cursor-blinkwait300-blinkon200-blinkoff150'
}

-- Statusline and Commandline
opt.display = {'lastline', 'msgsep'}
opt.laststatus = 2    -- Always show statusline
opt.showcmd = true    -- Show pending operators and visual selection range
opt.showmode = false  -- Our statusline covers this
opt.shortmess = opt.shortmess
  + 'c'  -- Don't show ins-completion messages, it's annoying with autocompletion
  - 'A'  -- Show warning about existing swap files

opt.relativenumber = true  -- Show relative line numbers
opt.number = true          -- But show our current line number instead of 0
opt.colorcolumn = '+1'     -- Show the boundary of textwidth
opt.cursorline = true
opt.inccommand = 'split'

-- Buffer Behavior
opt.hidden = true    -- Make buffers not annoying
opt.autoread = true  -- Automatically reload buffers changed outside of Neovim

-- Comfy scroll padding
opt.scrolloff = 3
opt.sidescrolloff = 5  -- Start scrolling 5 columns from the horizontal window edge
opt.sidescroll = 15    -- Scroll 15 columns at a time

-- This splitting behavior feels more natural to me
opt.splitright = true
opt.splitbelow = true

-- Don't mess with my windows; I'll <C-w>= when I need to.
opt.equalalways = false

-- Line wrapping
opt.wrap = true         -- Wrapping is on by default
opt.linebreak = true    -- Break early at certain characters, rather than just the last
opt.breakindent = true  -- Visually indicate wrapped lines
opt.showbreak = '↪ '

-- Show helpful meta-characters
opt.list = true
opt.listchars = {
  tab = '→ ', trail = '∙', nbsp = '␣', eol = '¬',
  extends = '❯', precedes = '❮'
}

-- Wild Menu
opt.wildmenu = true
opt.wildmode = {'longest', 'full'}
opt.wildignorecase = true
opt.wildignore = {
  '*.jpg', '*.jpeg', '*.png', '*.bmp', '*.tiff', '*.tga', '*.gif',
  '*.o', '*.obj', '*.exe', '*.a', '*.so', '*.dll', '*.pyc', '__pycache__',
  '*/.svn', '*/.hg', '*/.bzr', '*/.git',
  '*.db', '*.sqlite',
  '*~', '*.swp', '*.swo', '*.swn',
  'tags', 'TAGS', '*.tags', '*.TAGS'
}

-- Pop-up Menu
opt.pumheight = 20  -- Don't take up the entire screen height
opt.pumblend = 17   -- Transparent menu

-- Fold Options
opt.foldcolumn = 'auto:3'  -- Minimal fold column
opt.foldopen:append{'jump'}

opt.belloff = 'all'              -- Bells are evil, kill them with fire
opt.whichwrap:append('<,>,[,]')  -- Allow left/right arrow-keys to move to the previous/next line

-- Colors & Theme Settings {{{1

opt.termguicolors = true  -- 24-bit Colors
opt.synmaxcol = 500       -- Don't bother highlighting obnoxious lines

-- Set initial background based on time of day
local hour = tonumber(os.date('%H'))
if hour >= 6 and hour < 18 then
  opt.background = 'light'
else
  opt.background = 'dark'
end

vim.cmd 'colorscheme one'

-- Editing & Formatting {{{1

-- Searching
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.hlsearch = true

opt.textwidth = 120
opt.commentstring = '# %s'  -- Sane default
opt.formatoptions = opt.formatoptions
  - 'at'  -- Don't auto-format, we have linters now
  + 'cq'  -- Formatting comments is fine, though
  + '1'   -- Don't break on single-letter words
  + 'l'   -- Don't try to wrap a line that was already longer than textwidth
  - 'o'   -- I rarely want comment leaders continued on o and O
  + 'r'   -- ... but I do want Enter to continue comments
  + 'n'   -- Keep lists looking nice
  + 'j'   -- No point in keeping comment leaders on joined lines
  - '2'   -- This is a text editor, not a word processor
opt.joinspaces = false  -- Nobody does this

opt.backspace = {'indent', 'eol', 'start'}  -- Sane backspace functionality

-- Tabs
opt.expandtab = true  -- Use spaces for tabs like a civilized person
opt.smarttab = true   -- TBD: Is this actually necessary?
opt.autoindent = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = -1

opt.cinoptions = {
  'Ls', 'l1', 'b1', 'g0', 'N-s', 't0', '(0', 'U1', 'w1', 'Ws', 'm1', 'j1', 'J1'
}
opt.cinkeys = {
  '0{', '0}', ':', '0#', '!^F', 'o', 'O', 'e', '0=break'
}

-- Neovim State/Persistence Settings {{{1

-- Set state directories
opt.directory = as_stdpath('data', 'swap//')
opt.undodir = as_stdpath('data', 'undo')
opt.viewdir = as_stdpath('data', 'view')

opt.history = 10000
opt.shada = {'!', 'h', "'100", '<1000'}
opt.undofile = true

-- Make a temporary backup before writing that will be deleted on
-- a successful write.
-- Prevents total file loss in case Vim fails to write and then closes.
opt.writebackup = true

opt.sessionoptions = {
  'buffers', 'curdir', 'folds', 'globals', 'help', 'localoptions',
  'resize', 'skiprtp', 'tabpages', 'terminal', 'winpos', 'winsize'
}
opt.viewoptions = {'cursor', 'curdir', 'folds', 'localoptions'}

-- Neovim Providers {{{1
-- vim.g.python_host_prog = providers.python(2) and providers.python(2) or nil
vim.g.python3_host_prog = providers.python(3) and providers.python(3) or nil

-- Miscellaneous {{{1

opt.fileignorecase = true  -- I like to be lazy when tab-completing
opt.keywordprg = ':Man'    -- K should show man pages inside Vim
opt.updatetime = 1000      -- Faster update time for swap writes and `CursorHold` events

if vim.fn.executable('rg') then
  opt.grepprg = 'rg -H --no-heading --vimgrep'
end

opt.spellfile = as_stdpath('config', 'en.utf-8.add')

opt.tags:append{'src/**/tags', '.git/tags'}

-- Directories to search when using file commands (gf, ^Wf, :*find, etc)
opt.path:append{'/usr/local/include'}

-- Namespace for misc variables
if not vim.g.zeroknight then
  vim.g.zeroknight = {
    format_on_write = true,  -- Perform auto-formatting on write via LSP or plugins
  }
end

-- }}}

-- Use local config, if available
local local_init = as_stdpath('data', 'init.local.lua')
if vim.fn.filereadable(local_init) == 1 then
  dofile(local_init)
end

-- Additional configuration such as plugins, mappings, autocmds, and the like
-- are live elsewhere in the runtimepath and are automatically sourced as
-- appropriate.

-- vim: fdm=marker
