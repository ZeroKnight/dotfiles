" ZeroKnight's Vim Config

" General Settings {{{1
" ------------------------------------------------------------------------------

scriptencoding utf-8

" Set up Vim state directories
" Create any directories if needed
for s:vdir in ['swap', 'backup', 'view', 'undo', 'session']
  if !isdirectory($VIMDATA.'/'.s:vdir)
    call system('mkdir -p ' . shellescape($VIMDATA.'/'.s:vdir))
  endif
endfor
set directory=$VIMDATA/swap
set backup backupdir=$VIMDATA/backup
set viewdir=$VIMFILES/view

" Persistent Undo
if has('persistent_undo')
  set undofile undodir=$VIMDATA/undo
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

" Directories to search when using file commands (gf, [f, ]f, ^Wf, :*find, etc)
set path=.;include,/usr/include/**,./**,$PWD/**

" K should show man pages inside Vim
set keywordprg=:Man

if !has('nvim') && &ttimeoutlen == -1
  set ttimeout
  set ttimeoutlen=100
endif

set history=10000

" UI Settings {{{1
" ------------------------------------------------------------------------------

set belloff=all                " Bells are evil, kill them with fire
set hidden                     " Make buffers not annoying
set showcmd                    " Let our last command stick around
set laststatus=2               " Always show statusline
set number relativenumber      " Hybrid line-numbering
set cursorline cursorcolumn    " Crosshairs
set scrolloff=3                " Make scrolling look nicer
set splitright splitbelow      " New splits will open more naturally
set fileignorecase             " I like to be lazy when tab-completing

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
set expandtab softtabstop=2 shiftwidth=2

" cindent options
set cinoptions=Ls,l1,b1,g0,N-s,t0,(0,U1,w1,Ws,m1,j1,J1
set cinkeys=0{,0},:,0#,!^F,o,O,e,0=break

" Color & Syntax {{{1
" ------------------------------------------------------------------------------

" Enable Syntax Highlighting
set background=dark
if !exists('g:syntax_on')
  syntax enable
endif

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

" Miscellaneous {{{1
" ------------------------------------------------------------------------------

" Other variables
let g:zeroknight_comment_tags = 'TODO|FIXME|XXX|NOTE|HACK|BUG|WARNING|ATTENTION|ALERT|DANGER|TBD|TASK|NOTICE|TEST|DEBUG|DEPRECATED|WTF'


" vim: fdm=marker
