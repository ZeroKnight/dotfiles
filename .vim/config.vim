" ZeroKnight's Vim Config

" Basic & Global Settings {{{1
"==============================

" Accept nothing less than unicode. NOTHING!
setglobal fileencoding=utf-8
set encoding=utf-8 termencoding=utf-8

" Set some environment variables
let $VIMFILES = expand('~/.vim')
let $VIMSESSIONS = $VIMFILES . '/session'

" viminfo Options
" ' = Save marks; : = Save command history
" Don't include '/' because we want all search/substitute pattern history
" Don't include '<' because we want all register lines, but limit size with 's'
set viminfo='50,:100,s256,n$VIMFILES/.viminfo

" Session/View Options
set sessionoptions=buffers,curdir,folds,globals,resize,slash,tabpages,unix,winpos,winsize
set viewoptions=cursor,folds,slash,unix

" File/Directory Locations {{{1
"==============================

" To avoid clutter, keep all file types in their own directory in .vim
set dir=$VIMFILES/tmp
set backup backupdir=$VIMFILES/backup
set viewdir=$VIMFILES/view

" Persistent Undo
if has('persistent_undo')
    set undofile undodir=$VIMFILES/undo
endif

" Tell Vim where to look for tags
set tags=./tags,./TAGS,tags,TAGS,src/tags,src/TAGS,.git/tags,.git/TAGS
set tags+=$VIMFILES/tags/cpp
set tags+=$VIMFILES/tags/gl
set tags+=$VIMFILES/tags/sdl
set tags+=$VIMFILES/tags/qt

" UI Settings {{{1
"==============================

set showcmd                 " Let our last command stick around
set laststatus=2            " Always show statusline
set number relativenumber   " Hybrid line-numbering
set cursorline cursorcolumn " Crosshairs

" Fold Options
set foldcolumn=2            " Minimal fold column
set foldopen=block,hor,mark,percent,quickfix,search,tag,undo

" Searching
set ignorecase smartcase incsearch hls
set wildignore+=*.o,*.obj,*.exe,*.so,*.dll,*.pyc,.svn,.hg,.bzr,.git

" List mode
set list
set listchars=tab:▮▶,trail:∙,extends:▷,precedes:◁

" Wild Menu
set wildmenu

" Buffer Settings {{{1
"==============================

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

set textwidth=80 colorcolumn=+1
set formatoptions=crqanj

" Use spaces for tabs like a civilized person
set expandtab softtabstop=2 shiftwidth=2
set smartindent " cindent set automatically based on filetype
set cinoptions=>s,l1,b0,g0,(0,U1,w1,Ws,m1,j1,J1
set cinkeys=0{,0},:,0#,!^F,o,O,e,0=break

" Coloring/Highlighting/Syntax {{{1
"==============================

" Turn on Syntax Highlighting if not already on
if !exists("syntax on")
    syntax on
endif

" Set color scheme
set background=dark
color molokai

" Solarized Settings
if exists("color solarized")
    " Make listchars lightly colored
    let g:solarized_visibility = low

    " Do not use italics for comments
    let g:solarized_italic = 0

    " Set termcolors
    if has("gui_running")
        "let g:solarized_termcolors = 256
    else
        let g:solarized_termcolors = 256
        set t_Co=256
    endif
endif

" C Syntax Settings
let c_gnu = 1
let c_comment_strings = 1
let c_curly_error = 1
" Load doxygen syntax
let g:load_doxygen_syntax = 1

" vim: fdm=marker
