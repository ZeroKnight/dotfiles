"   _____                  __ __       _       __    __ _
"  /__  / ___  _________  / //_/____  (_)___ _/ /_  / /( )_____
"    / / / _ \/ ___/ __ \/ ,<  / __ \/ / __ `/ __ \/ __/// ___/
"   / /_/  __/ /  / /_/ / /| |/ / / / / /_/ / / / / /_  (__  )
"  /____|___/_/   \____/_/ |_/_/ /_/_/\__, /_/ /_/\__/ /____/
"                 _   __(_)___ ___  _/____/___
"                | | / / / __ `__ \/ ___/ ___/
"               _| |/ / / / / / / / /  / /__
"              (_)___/_/_/ /_/ /_/_/   \___/
"


" Basic & Global Settings
"==============================

" First and foremost, I want Vim settings! Let's make sure of that
set nocompatible

" Accept nothing less than unicode. NOTHING!
setglobal fileencoding=utf-8
set encoding=utf-8
set termencoding=utf-8

" The oh-so-essential Filetype!
filetype on
filetype plugin on

" Set some environment variables
let $VIMFILES = expand("~/.vim")

" Source our Vim functions file
source ~/.vimrc_functions

" Write swap files to $TEMP
set dir=$TEMP

" Keep backups, but without cluttering everything
set backup
set backupdir=$VIMFILES/backup

" viminfo Options
" ' = Save marks; : = Save command history; % = Save buffer list
" Don't include '/' because we want all search/substitute pattern history
" Don't include '<' because we want all register lines, but limit size with 's'
set viminfo='50,:100,%,s256,n$VIMFILES/.viminfo

" Session/View Options
set sessionoptions=buffers,curdir,folds,globals,resize,slash,tabpages,unix,winpos,winsize
let $VIMSESSIONS = $VIMFILES . "/sessions"
set viewoptions=cursor,folds,slash,unix
set viewdir=$VIMFILES/view

" Persistent Undo
set undofile
set undodir=$VIMFILES/undo

" Tell Vim where to look for tags
set tags=./tags,./TAGS,tags,TAGS,src/tags,src/TAGS
set tags+=$VIMFILES/tags/cpp
set tags+=$VIMFILES/tags/gl
set tags+=$VIMFILES/tags/sdl
set tags+=$VIMFILES/tags/qt


" Editor Settings
"==============================

" Hybrid line numbering, woo! Thanks, Vim 7.4!
set number
set relativenumber

" I've got you in my crosshairs...
set cursorline
set cursorcolumn

" C Indenting ftw
set cindent
set cinoptions=>1s,l1,b1,(0,U1,w1,j1,J1
set shiftwidth=4

" Use spaces for tabs like a civilized person
set expandtab
set softtabstop=4

" Minimal fold column
set foldcolumn=2

" Let our last command stick around
set showcmd

" Searching
set incsearch
set nohls

" StatusLine settings
set statusline=%<%f%1*%h%*%2*%m%*%3*%r%*%4*%{VarExists('b:gzflag','\ [GZ]')}%*\ [%3l,%c/%L]\ [%P]%=%b/0x%B\ %4*%y%*\ [%{&encoding}]
set laststatus=2

" List mode characters (:set list)
set listchars=eol:$,tab:>-,trail:`,extends:#,precedes:#,nbsp:^


" Buffer Settings
"==============================

" Make buffers not annoying
set hidden

" Jump 5 lines when running out of the screen
set scrolljump=5

" Set line wrapping, but do so intelligently
set wrap
set lbr
set whichwrap=b,s,<,>,[,]

" Selecting
set selection=inclusive
set selectmode=mouse,key
" Shift + [End|Home|PgUp|PgDn] can select text (sans Shift will deselect)
set keymodel=startsel,stopsel

" Makes backspace behave like it does in most editors
set backspace=indent,eol,start


" Plugin Settings
"==============================

" Spread the illness
runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()
execute pathogen#helptags()

" NERDTree(Tabs)
let NERDChristmasTree = 1
let NERDTreeHijackNetrw = 1
let NERDTreeShowBookmarks = 1
let NERDTreeShowHidden = 1
let NERDTreeBookmarksFile = $VIMFILES . "/.NERDTreeBookmarks"

" SnipMate
let g:snips_author = "Alex \"ZeroKnight\" George"
let g:snippets_dir = $VIMFILES . "/snippets"

" Indent Guides
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1

" ShowMarks
" Keep disabled on startup
let showmarks_enable = 0

" OmniCppComplete
let OmniCpp_NamespaceSearch = 2
let OmniCpp_ShowPrototypeInAbbr = 1
let OmniCpp_SelectFirstItem = 0
let OmniCpp_MayCompleteScope = 1

" Taglist
let Tlist_Enable_Fold_Column = 0


" Coloring/Highlighting/Syntax
"==============================

" Turn on Syntax Highlighting if not already on
if !exists("syntax on")
    syntax on
endif

" Set color scheme
set background=dark
color solarized

" Solarized Settings
if exists("color solarized")
    " Make listchars lightly colored
    let g:solarized_visibility = low

    " Set termcolors
    if has("gui_running")
        "let g:solarized_termcolors = 256
    else
        let g:solarized_termcolors = 256
        set t_Co=256
    endif
endif

" StatusLine Highlights
hi User1 gui=bold guifg=#00FFFF term=bold cterm=bold ctermfg=cyan
hi User2 guifg=#00FF00 ctermfg=green
hi User3 gui=bold guifg=#FF0000 term=bold cterm=bold ctermfg=red
hi User4 guifg=#CCCC00 ctermfg=107

" C Syntax Settings
let c_gnu = 1
let c_comment_strings = 1
let c_curly_error = 1
" Load doxygen syntax
let g:load_doxygen_syntax = 1


" Auto Commands
"==============================

if has("autocmd")
    augroup AutoSource
        autocmd!
        autocmd BufWritePost .vimrc source $MYVIMRC
        autocmd BufWritePost */openbox/menu.xml silent !openbox --reconfigure
    augroup END

    augroup SyntaxOverride
        autocmd!
        autocmd BufEnter */openbox/autostart nested set filetype=sh

        " Extra C++ Syntax Highlighting
        autocmd BufRead,BufNewFile *.[ch]p\\\{0,2\} syntax match cOpers "[!~%^&*(){}?+=[\]\\\-;,.:<>|]"
        autocmd BufRead,BufNewFile *.[ch]p\\\{0,2\} hi def link cOpers Operator
    augroup END
endif


" Mappings
"==============================

" ,cd - Change cwd to that of the current file
nnoremap ,cd :cd %:p:h<CR>:pwd<CR>

" Quick-edit .vimrc
nnoremap ,vr :tabedit $MYVIMRC<CR>

" GitGutter hunk jumping
nnoremap ]h <Plug>GitGutterNextHunk
nnoremap [h <Plug>GitGutterPrevHunk

" Move cursor to the middle of a line
noremap <silent> gm :call cursor(0, virtcol('$')/2)<CR>

" F2 - quick save + remove trailing whitespace
nnoremap <F2> :%s/\s\+$//g<CR>:w<CR>

" F3 - Toggle NERDtree
nnoremap <F3> :NERDTreeTabsToggle<CR>
vnoremap <F3> :NERDTreeTabsToggle<CR>
inoremap <F3> :NERDTreeTabsToggle<CR>

" F4 - Toggle Tagbar
nnoremap <F4> :TagbarToggle<CR>
vnoremap <F4> :TagbarToggle<CR>
inoremap <F4> :TagbarToggle<CR>

" F5 - Toggle Gundo
nnoremap <F5> :GundoToggle<CR>
vnoremap <F5> :GundoToggle<CR>
inoremap <F5> :GundoToggle<CR>

" F6 - Toggle ShowMarks
nnoremap <F6> :ShowMarksToggle<CR>
vnoremap <F6> :ShowMarksToggle<CR>http://xkcd.com/1312
inoremap <F6> :ShowMarksToggle<CR>

" F7 - Marks
noremap <F7> :marks<CR>
vnoremap <F7> :marks<CR>
inoremap <F7> :marks<CR>

" F9 - make
noremap <F9> :make<CR>

" C-F12 - Generate tags file for OmniCppComplete
noremap <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

" Window Switching
nnoremap <C-H> h
nnoremap <C-J> j
nnoremap <C-K> k
nnoremap <C-L> l

" Tab Cycling
nnoremap <C-Tab> :tabnext<CR>
inoremap <C-Tab> :tabnext<CR>
vnoremap <C-Tab> :tabnext<CR>
nnoremap <C-S-Tab> :tabprev<CR>
inoremap <C-S-Tab> :tabprev<CR>
vnoremap <C-S-Tab> :tabprev<CR>

" Select All
xnoremap  ggVG
snoremap  gggHG
onoremap  gggHG
nnoremap  gggHG

" Cut/Paste
cmap <S-Insert> +
imap <S-Insert> +
vmap <S-Insert> +
vnoremap <C-Insert> "+y
vnoremap  "+y
vnoremap  "+x
vnoremap <BS> d

