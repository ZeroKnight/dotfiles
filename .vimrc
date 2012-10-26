"-------------------------
" ZeroKnight's VIMRC
" Last changed: 10/10/2012
"-------------------------

"-------------------------
" Basic/Misc Settings
"-------------------------
" VIM settings are better than VI!
set nocompatible
set encoding=utf-8
setglobal fileencoding=utf-8
set termencoding=utf-8
filetype on
filetype plugin on
set backspace=indent,eol,start
set nobackup
set helplang=En
set history=50
set keymodel=startsel,stopsel
" Turn off bells
set novisualbell
set t_vb=   

" Session Options
set sessionoptions=blank,buffers,curdir,folds,help,winsize,tabpages,winpos

" Always load/save Folds
au BufWinLeave,BufWrite * silent! mkview
au BufWinEnter,BufRead * silent! loadview

" Call Vim Functions file
source ~/.vimrc_functions

"-------------------------
" Directory Settings
"-------------------------
set viewdir=~/.vim/view
" Starting Directory
cd ~/Documents/Coding/Projects

" Write all temporary files to /tmp/vim
set dir=/tmp/vim
"set dir=C:\Windows\Temp\vim

" NERDTree Bookmarks
let NERDTreeBookmarksFile = '/home/zeroknight/.vim/.NERDTreeBookmarks'


"-------------------------
" GUI Settings
"-------------------------
set guifont=Fixed
set guioptions=iegmt
set ruler
set window=44
set relativenumber
set foldcolumn=2
set showcmd
set cursorline
set whichwrap=b,s,<,>,[,]

" StatusLine
set statusline=%<%f%1*%h%*%2*%m%*%3*%r%*%4*%{VarExists('b:gzflag','\ [GZ]')}%*\ [%3l,%c/%L]\ [%P]%=%b/0x%B\ %4*%y%*\ [%{&encoding}] 
set laststatus=2


"-------------------------
" Coloring/Highlighting/Syntax
"-------------------------
" Turn on Syntax Highlighting if not already on
if !exists("syntax on")
    syntax on
endif

color zerocasts
set background=dark
autocmd BufRead,BufNewFile *.gui set filetype=cfg

" Custom Settings
hi Cursor               guibg=#00FF00 guifg=#000000
hi CursorLine           guibg=#1A1A1A
hi StatusLine           guibg=#767676 guifg=#1A1A1A 
hi StatusLineNC         guibg=#1A1A1A guifg=#767676
hi LineNr               guibg=#1A1A1A guifg=#767676
hi Folded               guibg=#1A1A1A guifg=cyan
hi FoldColumn           guibg=#1A1A1A guifg=cyan
hi Visual               guibg=#323846

" Extra C++ Syntax Highlighting
autocmd BufRead,BufNewFile *.cpp,*.hpp,*.c,*.h syntax match cOpers "[!~%^&*(){}?+=[\]\\\-;,.\:<>|]"
autocmd BufRead,BufNewFile *.cpp,*.hpp,*.c,*.h hi cOpers guifg=#E81919

" StatusLine Highlights
hi User1 gui=bold guifg=#00FFFF term=bold cterm=bold ctermfg=cyan
hi User2 guifg=#00FF00 ctermfg=green
hi User3 gui=bold guifg=#FF0000 term=bold cterm=bold ctermfg=red
hi User4 guifg=#CCCC00 ctermfg=107

" Change Color of StatusLine when in Insert mode (zerocasts)
autocmd InsertEnter * hi StatusLine guifg=#0E1B0E | hi User1 guibg=#0E1B0E | hi User2 guibg=#0E1B0E | hi User3 guibg=#0E1B0E | hi User4 guibg=#0E1B0E
autocmd InsertLeave * hi StatusLine guifg=#1A1A1A | hi User1 guibg=#1A1A1A | hi User2 guibg=#1A1A1A | hi User3 guibg=#1A1A1A | hi User4 guibg=#1A1A1A


"-------------------------
" Editing Settings
"-------------------------
" Tabs/Indent
set expandtab
set autoindent
set cindent
set smartindent
set softtabstop=4
set shiftwidth=4
set tabstop=4

" Searching
set incsearch
set nohls

" Selecting
set selection=exclusive
set selectmode=mouse,key

" Jump 5 lines when running out of the screen
set scrolljump=5

" Prevents unloading of buffer when switching. Allows editing multiple
" files without needing to save
set hidden

set nowrap


"-------------------------
" Plugin Settings
"-------------------------
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

"-------------------------
" Binds
"-------------------------
" Search/Replace word under cursor (needs to be fixed?)
" nmap ; :%s/\<=expand("")\>/

" F2 - quick save
nmap <F2> :w<Return>

" F3 - Toggle NERDtree
nmap <F3> :NERDTreeToggle<Return>

" F5 - Delete all trailing whitespace
nmap <F5> :%s/\s\+$/g<Return>

" F7 - Toggle ShowMarks
map <F7> :ShowMarksToggle<Return>
vmap <F7> :ShowMarksToggle<Return>
imap <F7> :ShowMarksToggle<Return>

" F8 - Marks
map <F8> :marks<Return>
vmap <F8> :marks<Return>
imap <F8> :marks<Return>

" F9 - make
map <F9> :make<Return>

" F10 - Toggle TagList
map <F10> :TlistToggle<Return>
vmap <F10> :TlistToggle<Return>
imap <F10> :TlistToggle<Return>

" ,cd - Change cwd to that of the current file
nnoremap ,cd :cd %:p:h<CR>:pwd<CR>


"-------------------------
" Mappings
"-------------------------
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


"-------------------------
" Everything else...
"-------------------------
