"-------------------------oOo-------------------------
"
"                 ZeroKnight's gVIMRC
"
"-------------------------oOo-------------------------
" Window sizing
set lines=30
set columns=100

" Font Settings
set guifont=Source\ Code\ Pro\ Semibold\ 9

set guioptions=iegmt
set cursorline


"-------------------------
" Menus
"-------------------------

" Manually selectable syntax in "Syntax" menu
let do_syntax_sel_menu = 1|runtime! synmenu.vim|aunmenu &Syntax.&Show\ filetypes\ in\ menu
