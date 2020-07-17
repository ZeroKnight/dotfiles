" ZeroKnight's Vim Config

" General Settings {{{1
" ------------------------------------------------------------------------------

scriptencoding utf-8

" Set up Vim state directories
" Create any directories if needed
for s:vdir in ['swap', 'view', 'undo', 'session']
  if !isdirectory($VIMDATA.'/'.s:vdir)
    call mkdir($VIMDATA.'/'.s:vdir, 'p')
  endif
endfor
set directory=$VIMDATA/swap//
set viewdir=$VIMFILES/view

" Persistent Undo
if has('persistent_undo')
  set undofile undodir=$VIMDATA/undo
else
  if !isdirectory($VIMDATA.'/backup')
    call mkdir($VIMDATA.'/backup')
  endif
  set backup backupdir=$VIMDATA/backup
endif

" Neovim Python provider
if has('nvim')
  call system("python3 -c 'import pynvim'") " Check for system install of pynvim
  if v:shell_error
    let s:venv_dir = expand('$VIMDATA/pynvim-venv')
    if !isdirectory(s:venv_dir)
      call mkdir(s:venv_dir)
      " TODO: Perform this automatically
      echohl WarningMsg
      echom "Created directory for Python provider virtualenvs at '"
        \ . s:venv_dir . "'. You should create py2nvim and py3nvim venvs now."
      echohl None
    endif
    let g:python_host_prog = expand('$VIMDATA/pynvim-venv/py2nvim/bin/python2.7')
    let g:python3_host_prog = expand('$VIMDATA/pynvim-venv/py3nvim/bin/python3')
  end
endif

" Make a temporary backup before writing that will be deleted on a successful
" write. Prevents total file loss in case Vim fails to write and then closes.
if has('writebackup')
  set writebackup
endif

" viminfo/shada Settings
if has('shada')
  set shada=!,'100
else
  " Older viminfo file isn't as efficient as ShaDA, so cut back on the sizes
  set viminfo=!,'50,s1024,n$VIMDATA/shada/.viminfo
endif

" Session/View Options
set sessionoptions=buffers,curdir,folds,globals,help,localoptions,resize,slash,tabpages,unix,winpos,winsize
set viewoptions=cursor,folds,slash,unix

" Tell Vim where to look for tags. Prefer directory of file over CWD
set tags=./tags,./TAGS,./src/**/tags,./src/**/TAGS,./.git/tags,./.git/TAGS,
set tags+=tags,TAGS,src/**/tags,src/**/TAGS,.git/tags,.git/TAGS

" Directories to search when using file commands (gf, ^Wf, :*find, etc)
set path=.,/usr/include,/usr/local/include,,

" K should show man pages inside Vim
set keywordprg=:Man

if !has('nvim') && &ttimeoutlen == -1
  set ttimeout
  set ttimeoutlen=100
endif

set history=10000
set updatetime=500

" Map Leader
let mapleader = '\'
let maplocalleader = "\<Space>"

" Spell-check
set spellfile=$VIMFILES/en.utf-8.add

" UI Settings {{{1
" ------------------------------------------------------------------------------

set belloff=all                " Bells are evil, kill them with fire
set cursorline cursorcolumn    " Crosshairs
set display=lastline
set fileignorecase             " I like to be lazy when tab-completing
set hidden                     " Make buffers not annoying
set laststatus=2               " Always show statusline
set number relativenumber      " Hybrid line-numbering
set scrolloff=3                " Make scrolling look nicer
set sidescroll=15
set sidescrolloff=5
set showcmd                    " Let our last command stick around
set splitright splitbelow      " New splits will open more naturally
set noequalalways

" Enable the mouse. Being able to resize windows with the mouse is fantastic.
if has('mouse')
  set mouse=a
endif

" Cursor style
set guicursor=n-v-c-sm:block
set guicursor+=i-ci-ve:ver25
set guicursor+=r-cr-o:hor20
set guicursor+=a:Cursor-blinkwait300-blinkon200-blinkoff150

" Set line wrapping, but do so intelligently
set wrap linebreak breakindent whichwrap=b,s,<,>,[,]

" Searching
set ignorecase smartcase incsearch hlsearch

" Automatically reload buffers changed outside of Vim
set autoread

" Show effects of some commands incrementally as you type (:s* commands)
if has('nvim')
  set inccommand=split
endif

" Show helpful meta-characters
set list
set listchars=tab:→\ ,trail:∙,nbsp:∙,eol:¬,extends:❯,precedes:❮
let &showbreak = '↪ '
set fillchars=vert:│

" Wild Menu
set wildmenu
set wildmode=longest,full
set wildignorecase
set wildignore+=*.jpg,*.jpeg,*.png,*.bmp,*.tiff,*.tga,*.gif
set wildignore+=*.o,*.obj,*.exe,*.a,*.so,*.dll,*.pyc
set wildignore+=*/.svn,*/.hg,*/.bzr,*/.git
set wildignore+=*.swp,*.swo,*.swn
set wildignore+=tags,TAGS,*.tags,*.TAGS
set wildignore+=*.db,*.sqlite

" Prevent pop-up menus from taking up the entire screen height
set pumheight=20

" Fold Options
set foldcolumn=2 " Minimal fold column
set foldopen=block,hor,jump,mark,percent,quickfix,search,tag,undo

" Selecting
set selection=inclusive
set selectmode=mouse,key
" Shift + [End|Home|PgUp|PgDn|Arrows] can select text (sans Shift will deselect)
set keymodel=startsel,stopsel

" Formatting Options {{{1
" ------------------------------------------------------------------------------

" Sane backspace functionality
set backspace=indent,eol,start

set textwidth=80 colorcolumn=+1
set formatoptions=crqn1j
set nojoinspaces

" Use spaces for tabs like a civilized person
set expandtab smarttab softtabstop=2 shiftwidth=2

" cindent options
set cinoptions=Ls,l1,b1,g0,N-s,t0,(0,U1,w1,Ws,m1,j1,J1
set cinkeys=0{,0},:,0#,!^F,o,O,e,0=break

" Sane default for 'commentstring'
set commentstring=#\ %s

" Color & Syntax {{{1
" ------------------------------------------------------------------------------

" Set initial background based on time of day
let s:hour = system("date '+%H'")
if s:hour >= 6 && s:hour < 18
  set background=light
else
  set background=dark
endif

" Enable Syntax Highlighting
if !exists('g:syntax_on')
  syntax enable
endif

set synmaxcol=500

" Set Colorscheme
colorscheme one

" Use 24-bit colors
if has('termguicolors')
  set termguicolors

  " Nasty hack because Vim 8's 24-bit color implementation is faulty and makes
  " assumptions... it seems to really only work with xterm-256color
  if !has('nvim')
    set term=xterm-256color
  endif
endif

" Disable Background Color Erase (BCE) so that color schemes render properly
" when running Vim inside 256-color tmux and GNU screen. See also
" http://sunaku.github.io/vim-256color-bce.html
if !has('nvim') && !empty($TMUX) && &term =~# '256color'
  set t_ut=
endif

" C Syntax Settings
let g:c_gnu = 1
let g:c_comment_strings = 1
let g:c_curly_error = 1
" Load doxygen syntax
let g:load_doxygen_syntax = 1

" Spellcheck colors
hi SpellBad cterm=undercurl,bold

" Miscellaneous {{{1
" ------------------------------------------------------------------------------

" Namespace for misc variables
if !exists('g:zeroknight')
  let g:zeroknight = {
    \ 'comment_tags':
    \   'TODO|FIXME|XXX|NOTE|HACK|BUG|WARNING|ATTENTION|ALERT|DANGER|TBD|TASK|NOTICE|TEST|DEBUG|DEPRECATED|WTF',
  \}
endif

" vim: fdm=marker
