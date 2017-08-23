" ZeroKnight's Vim Config

" Core Settings {{{1
"==============================

" Set some environment variables
let $VIMFILES    = expand('~/.config/nvim')
let $VIMDATA     = expand('~/.local/share/nvim')
let $VIMSESSIONS = expand($VIMDATA.'/sessions')

" Other variables
let g:zeroknight_comment_tags = 'TODO|FIXME|XXX|NOTE|HACK|BUG|WARNING|ATTENTION|ALERT|DANGER|TBD|TASK|NOTICE|TEST|DEBUG|DEPRECATED|WTF'

" Create any Vim state directories if needed
for vdir in ['swap', 'backup', 'view', 'undo', 'session']
  if !isdirectory(expand($VIMDATA.'/'.vdir))
    silent! exec '!mkdir -p ' . expand($VIMDATA.'/'.vdir)
  endif
endfor
set dir=$VIMDATA/swap
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
  \tags,TAGS,src/**/tags,src/**/TAGS,.git/tags,.git/TAGS

" K should show man pages inside Vim
set keywordprg=:Man

" UI Settings {{{1
"==============================

set showcmd                 " Let our last command stick around
set laststatus=2            " Always show statusline
set number relativenumber   " Hybrid line-numbering
set cursorline cursorcolumn " Crosshairs

" Fold Options
set foldcolumn=2            " Minimal fold column
set foldopen=block,hor,jump,mark,percent,quickfix,search,tag,undo

" Searching
set ignorecase smartcase incsearch hls
set wildignore=*.o,*.obj,*.exe,*.so,*.dll,*.pyc,.svn,.hg,.bzr,.git

" List mode
set list
set listchars=tab:▮▶,trail:∙,extends:▷,precedes:◁

" Prefix wrapped lines
let &showbreak = '↪ '

" Wild Menu
set wildmenu

" New splits will open more naturally
set splitright splitbelow

set hidden      " Make buffers not annoying
set scrolloff=3 " Make scrolling look nicer
set backspace=indent,eol,start " Sane backspace functionality

" Set line wrapping, but do so intelligently
set wrap lbr whichwrap=b,s,<,>,[,]

" Selecting
set selection=inclusive
set selectmode=mouse,key
" Shift + [End|Home|PgUp|PgDn] can select text (sans Shift will deselect)
set keymodel=startsel,stopsel

" Automatically reload buffers changed outside of Vim
set autoread


" Formatting Options {{{1
"==============================

filetype indent on

set textwidth=80 colorcolumn=+1
set formatoptions=crqnj
set nojoinspaces

" Use spaces for tabs like a civilized person
set expandtab softtabstop=2 shiftwidth=2

" cindent options
set cinoptions=Ls,l1,b1,g0,N-s,t0,(0,U1,w1,Ws,m1,j1,J1
set cinkeys=0{,0},:,0#,!^F,o,O,e,0=break

" Coloring/Highlighting/Syntax {{{1
"==============================

" Turn on Syntax Highlighting if not already on
if !exists("syntax on")
  syntax on
endif

" Use 24-bit colors
if (has('termguicolors'))
  set termguicolors
endif

" Disable Background Color Erase (BCE) so that color schemes render properly
" when inside 256-color tmux and GNU screen. See also
" http://sunaku.github.io/vim-256color-bce.html
if (!empty($TMUX) && &term =~ '256color')
  set t_ut=
endif

" Set Colorscheme
set background=dark
colorscheme onedark

" C Syntax Settings
let c_gnu = 1
let c_comment_strings = 1
let c_curly_error = 1
" Load doxygen syntax
let g:load_doxygen_syntax = 1

" vim: fdm=marker
