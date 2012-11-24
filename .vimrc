"-------------------------oOo-------------------------
"
"                 ZeroKnight's VIMRC
"
"-------------------------oOo-------------------------



"-------------------------oOo-------------------------
"
"                 Global/Misc Settings
"
"-------------------------oOo-------------------------
" VIM settings are better than VI!
set nocompatible

" Encoding
setglobal fileencoding=utf-8
set encoding=utf-8
set termencoding=utf-8

" Filetype Settings
filetype on
filetype plugin on
autocmd BufRead,BufNewFile *.gui set filetype=cfg

" No need for the spam
set nobackup

" Turn off bells beeps, as they're the devil.
set novisualbell
set t_vb=

" Session Options
set sessionoptions=blank,buffers,curdir,folds,help,winsize,tabpages,winpos

" Always load/save Folds
au BufWinLeave,BufWrite * silent! mkview
au BufWinEnter,BufRead * silent! loadview

" Misc
set helplang=En
set history=50

" Call Vim Functions file
source ~/.vimrc_functions

"-------------------------oOo-------------------------
"
"                   Directory Settings
"
"-------------------------oOo-------------------------
" Persistent Undo
set undofile
set undodir="$HOME/.vim/undo"

set viewdir=~/.vim/view

" Starting Directory
cd ~/Documents/Coding/Projects

" Write all temporary files to /tmp/vim
if !isdirectory("/tmp/vim")
    silent !mkdir -p /tmp/vim
endif
set dir=/tmp/vim

" NERDTree Bookmarks
let NERDTreeBookmarksFile = '/home/zeroknight/.vim/.NERDTreeBookmarks'


"-------------------------oOo-------------------------
"
"                   Editing Settings
"
"-------------------------oOo-------------------------
" Visual Information & Statistics
set ruler
set relativenumber
set foldcolumn=2
set showcmd
set listchars=eol:$,tab:>-,trail:`

" StatusLine
set statusline=%<%f%1*%h%*%2*%m%*%3*%r%*%4*%{VarExists('b:gzflag','\ [GZ]')}%*\ [%3l,%c/%L]\ [%P]%=%b/0x%B\ %4*%y%*\ [%{&encoding}] 
set laststatus=2

" Tabs/Indentation
set expandtab
set autoindent
set cindent
set smartindent
set softtabstop=4
set shiftwidth=4
set tabstop=4

" Set line wrapping
set wrap
set lbr

" Searching
set incsearch
set nohls

" Selecting
set selection=inclusive
set selectmode=mouse,key

" Shift + [End|Home|PgUp|PgDn] can select text (sans Shift will deselect)
set keymodel=startsel,stopsel

" Makes backspace behave like it does in most editors
set backspace=indent,eol,start

" Jump 5 lines when running out of the screen
set scrolljump=5

" Prevents unloading of buffer when switching. Allows editing multiple
" files without /needing/ to save
set hidden

set whichwrap=b,s,<,>,[,]


"-------------------------oOo-------------------------
"
"           Coloring/Highlighting/Syntax
"
"-------------------------oOo-------------------------
" Turn on Syntax Highlighting if not already on
if !exists("syntax on")
    syntax on
endif

set background=dark
color solarized

" If using Solarized, make listchars lightly colored
if exists("color solarized")
    let g:solarized_visibility = low
endif

" If using Solarized, use 16 color palette for vim in terminal
if has("gui_running")
    let g:solarized_termcolors = 256
else
    let g:solarized_termcolors = 16
endif
    

" Custom Settings
"hi Cursor               guibg=#00FF00 guifg=#000000
"hi CursorLine           guibg=#1A1A1A
"hi StatusLine           guibg=#767676 guifg=#1A1A1A 
"hi StatusLineNC         guibg=#1A1A1A guifg=#767676
"hi LineNr               guibg=#1A1A1A guifg=#767676
"hi Folded               guibg=#1A1A1A guifg=cyan
"hi FoldColumn           guibg=#1A1A1A guifg=cyan
"hi Visual               guibg=#323846

" Extra C++ Syntax Highlighting
"autocmd BufRead,BufNewFile *.cpp,*.hpp,*.c,*.h syntax match cOpers "[!~%^&*(){}?+=[\]\\\-;,.:<>|]"
"autocmd BufRead,BufNewFile *.cpp,*.hpp,*.c,*.h hi cOpers guifg=#E81919

" StatusLine Highlights
hi User1 gui=bold guifg=#00FFFF term=bold cterm=bold ctermfg=cyan
hi User2 guifg=#00FF00 ctermfg=green
hi User3 gui=bold guifg=#FF0000 term=bold cterm=bold ctermfg=red
hi User4 guifg=#CCCC00 ctermfg=107

" Change Color of StatusLine when in Insert mode (zerocasts)
"autocmd InsertEnter * hi StatusLine guifg=#0E1B0E | hi User1 guibg=#0E1B0E | hi User2 guibg=#0E1B0E | hi User3 guibg=#0E1B0E | hi User4 guibg=#0E1B0E
"autocmd InsertLeave * hi StatusLine guifg=#1A1A1A | hi User1 guibg=#1A1A1A | hi User2 guibg=#1A1A1A | hi User3 guibg=#1A1A1A | hi User4 guibg=#1A1A1A


"-------------------------oOo-------------------------
"
"                   Plugin Settings
"
"-------------------------oOo-------------------------
" Pathogen
call pathogen#infect()
call pathogen#helptags()

" NERDTree Settings
let NERDChristmasTree = 1
let NERDTreeHijackNetrw = 1
let NERDTreeShowBookmarks = 1
let NERDTreeShowHidden = 1

" Indent Guides
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
let g:snips_author = "Alex \"ZeroKnight\" George"

" Turn off ShowMarks on startup
let showmarks_enable=0 


"-------------------------oOo-------------------------
"
"                        Binds
"
"-------------------------oOo-------------------------
" Search/Replace word under cursor (needs to be fixed?)
" nmap ; :%s/\<=expand("")\>/

" F2 - quick save + remove trailing whitespace
nnoremap <F2> :%s/\s\+$/g<Return>:w<Return>

" F3 - Toggle NERDtree
nnoremap <F3> :NERDTreeToggle<Return>
vnoremap <F3> :NERDTreeToggle<Return>
inoremap <F3> :NERDTreeToggle<Return>

" F4 - Toggle TagList
nnoremap <F4> :TlistToggle<Return>
vnoremap <F4> :TlistToggle<Return>
inoremap <F4> :TlistToggle<Return>

" F5 - Toggle Gundo
nnoremap <F5> :GundoToggle<Return>
vnoremap <F5> :GundoToggle<Return>
inoremap <F5> :GundoToggle<Return>

" F6 - Toggle ShowMarks
nnoremap <F6> :ShowMarksToggle<Return>
vnoremap <F6> :ShowMarksToggle<Return>
inoremap <F6> :ShowMarksToggle<Return>

" F7 - Marks
noremap <F7> :marks<Return>
vnoremap <F7> :marks<Return>
inoremap <F7> :marks<Return>

" F9 - make
noremap <F9> :make<Return>

" ,cd - Change cwd to that of the current file
nnoremap ,cd :cd %:p:h<CR>:pwd<CR>


"-------------------------oOo-------------------------
"
"                       Mappings
"
"-------------------------oOo-------------------------
" Sudo Write
cmap w!! %!sudo tee > /dev/null %

" Window cycle
cnoremap <C-Tab> w
inoremap <C-Tab> w
onoremap <C-Tab> w
nnoremap <C-Tab> w
vnoremap <C-Tab> w

" Select All
xnoremap  ggVG
snoremap  gggHG
onoremap  gggHG
nnoremap  gggHG

" Cut/Paste
cmap <S-Insert> +
imap <S-Insert> +
vmap <S-Insert> +
vnoremap <C-Insert> "+y
vnoremap  "+y
vnoremap  "+x
vnoremap <S-Del> "+x
vnoremap <BS> d

