"   _____                   __ __       _       __    __ _
"  /__  /  ___  _________  / //_/____  (_)___ _/ /_  / /( )_____
"    / /  / _ \/ ___/ __ \/ ,<  / __ \/ / __ `/ __ \/ __/// ___/
"   / /__/  __/ /  / /_/ / /| |/ / / / / /_/ / / / / /_  (__  )
"  /____/\___/_/   \____/_/ |_/_/ /_/_/\__, /_/ /_/\__/ /____/
"                         _           /____/
"                  _   __(_)___ ___  __________
"                 | | / / / __ `__ \/ ___/ ___/
"                _| |/ / / / / / / / /  / /__
"               (_)___/_/_/ /_/ /_/_/   \___/
"

" Basic & Global Settings
"==============================

" First and foremost, I want Vim settings! Let's make sure of that
set nocompatible

" Accept nothing less than unicode. NOTHING!
setglobal fileencoding=utf-8
set encoding=utf-8 termencoding=utf-8

" DOS Line endings can go to hell
set fileformats=unix,dos fileformat=unix

" The oh-so-essential Filetype!
filetype on
filetype plugin on

" Set some environment variables
let $VIMFILES = expand("~/.vim")

" Write swap files to $TEMP
set dir=$TEMP

" Keep backups, but without cluttering everything
set backup backupdir=$VIMFILES/backup

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
set undofile undodir=$VIMFILES/undo

" Tell Vim where to look for tags
set tags=./tags,./TAGS,tags,TAGS,src/tags,src/TAGS
set tags+=$VIMFILES/tags/cpp
set tags+=$VIMFILES/tags/gl
set tags+=$VIMFILES/tags/sdl
set tags+=$VIMFILES/tags/qt


" Editor Settings
"==============================

" Hybrid line numbering, woo! Thanks, Vim 7.4!
set number relativenumber

" I've got you in my crosshairs...
set cursorline cursorcolumn

" Set indenting options
" cindent set automatically based on filetype
set smartindent
set cinoptions=>s,l1,b1,g0,(0,U1,w1,Ws,j1,J1
set cinkeys=0{,0},:,0#,!^F,o,O,e,0=break
" Use spaces for tabs like a civilized person
set expandtab softtabstop=4 shiftwidth=4

" Fold Options
" Minimal fold column
set foldcolumn=2
set foldopen=block,hor,mark,percent,quickfix,search,tag,undo

" Let our last command stick around
set showcmd

" Searching
set smartcase incsearch nohls

" StatusLine settings
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
set wrap lbr whichwrap=b,s,<,>,[,]

" Selecting
set selection=inclusive
set selectmode=mouse,key
" Shift + [End|Home|PgUp|PgDn] can select text (sans Shift will deselect)
set keymodel=startsel,stopsel

" Makes backspace behave like it does in most editors
set backspace=indent,eol,start


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

" UltiSnips
let g:snips_author = "Alex \"ZeroKnight\" George"

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

" GitGutter
hi! link SignColumn LineNr
hi! link GitGutterAdd           DiffAdd
hi! link GitGutterChange        DiffChange
hi! link GitGutterDelete        DiffDelete
hi! link GitGutterChangeDelete  DiffDelete


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
        autocmd BufRead,BufNewFile *.[ch]\\\{1,2\},*.[ch]pp,*.[ch]xx,*.m syntax match cOpers "[!~%^&*(){}?+=[\]\\\-;,.:<>|]"
        autocmd BufRead,BufNewFile *.[ch]\\\{1,2\},*.[ch]pp,*.[ch]xx,*.m hi def link cOpers Operator
    augroup END

    augroup Indenting
        autocmd!
        autocmd BufRead,BufNewFile *.[ch]\\\{1,2\},*.[ch]pp,*.[ch]xx,*.m setlocal cindent
    augroup END
endif


" Mappings
"==============================

" Change cwd to that of the current file
nnoremap <Leader>cd :cd %:p:h<CR>:pwd<CR>

" Quick-edit .vimrc
nnoremap <Leader>vr :tabedit $MYVIMRC<CR>

" Quick-edit UltiSnips for current filetype
nnoremap <Leader>ue :UltiSnipsEdit<CR>

" GitGutter hunk jumping
nnoremap ]h :GitGutterNextHunk<CR>
nnoremap [h :GitGutterPrevHunk<CR>

" Move cursor to the middle of a line
noremap <silent> gm :call cursor(0, virtcol('$')/2)<CR>

" More logical Y
noremap Y y$

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
vnoremap <F6> :ShowMarksToggle<CR>
inoremap <F6> :ShowMarksToggle<CR>

" C-F12 - Generate tags file for OmniCppComplete
noremap <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

" Yank/Paste Shortcuts
nnoremap <C-Ins> "*y
vnoremap <C-Ins> "*y
nnoremap <S-Ins> "*p
inoremap <S-Ins> <C-o>"*p
vnoremap <S-Ins> "-d"*P

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

" Converts DOS EOL to UNIX
function! DosToUnixEOL()
    update             " Save any changes
    e ++ff=dos         " Edit file again, using dos format ('fileformats' ignored)
    setlocal ff=unix   " Buffer will use LF-only line endings when written
    write              " Write the buffer (using LF-only line endings)
endfunction
nnoremap <silent> <Leader>eol :call DosToUnixEOL()<CR>

" Smart HOME
function! SmartHome()
    let s:col = col(".")
    normal! ^
    if s:col == col(".")
        normal! 0
    endif
endfunction
nnoremap <silent> <Home> :call SmartHome()<CR>
inoremap <silent> <Home> <C-O>:call SmartHome()<CR>
nnoremap <silent> 0 :call SmartHome()<CR>

" Session Save/Load shortcut
command! -nargs=1 Ss :mksession! ~/.vim/sessions/<args>.vim
command! -nargs=1 Sl :source ~/.vim/sessions/<args>.vim
