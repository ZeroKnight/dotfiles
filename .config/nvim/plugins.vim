" Vim Plugins
" ------------------------------------------------------------------------------

" Ensure that vim-plug is installed. {{{1
let s:vimplug_path = $VIMDATA.'/site/autoload/plug.vim'
if !filereadable(s:vimplug_path)
  if executable('curl')
    let s:vimplug_url = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    call system('curl -fLo ' . shellescape(s:vimplug_path) . ' --create-dirs ' . s:vimplug_url)
    if v:shell_error
      echom 'Error downloading vim-plug; you may need to install it manually.'
      exit
    else
      echom 'vim-plug installed successfully!'
    endif
  else
    echom "Cannot download and install vim-plug as 'curl' is unavailable."
    exit
  endif
endif " }}}1

let g:plug_threads = 16
let g:plug_shallow = 1

" Initialize vim-plug and declare our plugins
call plug#begin($VIMDATA.'/plugins')

" UI {{{
Plug 'airblade/vim-gitgutter'
Plug 'chrisbra/NrrwRgn'
Plug 'justinmk/vim-dirvish'
Plug 'kshenoy/vim-signature'
Plug 'mbbill/undotree', { 'on': ['UndotreeFocus', 'UndotreeHide', 'UndotreeShow', 'UndotreeToggle'] }
Plug 'mhinz/vim-startify'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'wesQ3/vim-windowswap'
Plug 'Yggdroot/indentLine'
"Plug 'scrooloose/nerdtree'
"}}}

" Utilities {{{
Plug 'alx741/vinfo'
Plug 'christoomey/vim-sort-motion'
Plug 'godlygeek/tabular'
Plug 'Konfekt/FastFold'
Plug 'moll/vim-bbye'
Plug 'reedes/vim-wordy'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-characterize'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-scriptease'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'wellle/targets.vim'

Plug 'ctrlpvim/ctrlp.vim'
Plug 'mhinz/vim-grepper'
Plug 'mileszs/ack.vim'

Plug 'neomake/neomake'
Plug 'SirVer/ultisnips'
Plug 'majutsushi/tagbar' " Don't defer, airline uses tagbar for a status item
Plug 'Valloric/YouCompleteMe'
Plug 'rdnetto/YCM-Generator'

" Plug 'ervandew/supertab'
"}}}

" Syntax {{{
Plug 'sheerun/vim-polyglot'
Plug 'othree/xml.vim',          { 'for': 'xml' }
Plug 'withgod/vim-sourcepawn',  { 'for': 'sourcepawn' }
Plug 'Valloric/MatchTagAlways', { 'for': ['html', 'xhtml', 'xml', 'jinja'] }
Plug 'xolox/vim-lua-ftplugin',  { 'for': 'lua' }

if has('nvim')
  Plug 'arakashic/chromatica.nvim', { 'for': ['c', 'cpp', 'objc'] }
else
  Plug 'jeaye/color_coded', { 'for': ['c', 'cpp', 'objc'] }
endif
"}}}

" Color Schemes {{{
Plug 'altercation/vim-colors-solarized'
Plug 'ciaranm/inkpot'
Plug 'nanotech/jellybeans.vim'
Plug 'Pychimp/vim-luna'
Plug 'rakr/vim-one'
Plug 'sickill/vim-monokai'
Plug 'tomasr/molokai'
"}}}

" Libraries & Misc {{{
Plug 'tpope/vim-repeat'
Plug 'xolox/vim-misc'
"}}}

call plug#end()

" Plugin Settings
" ------------------------------------------------------------------------------

" Ack.vim (Ag in disguise) {{{1
let g:ackprg = 'ag --vimgrep --smart-case'
cnoreabbrev Ag  Ack
cnoreabbrev LAg LAck

" Airline {{{1
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.linenr = ''

" Extensions
let g:airline_theme='one'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_close_button = 0

" CtrlP {{{1
let g:ctrlp_cmd = 'CtrlPBuffer'
let g:ctrlp_extensions = ['mixed', 'line', 'dir', 'quickfix', 'buffertag', 'tag']
let g:ctrlp_switch_buffer = 'et'
let g:ctrlp_working_path_mode = 'ar'
let g:ctrlp_open_new_file = 'r'

if executable('ag')
  " Enables CtrlP to search using Ag for listing files.
  " Lightning fast, no need to cache and even respects .gitignore
  let g:ctrlp_user_command = 'ag %s --nocolor -l -g ""'
  let g:ctrlp_use_caching = 0
endif

" Indent Guides {{{1
let g:indentLine_char = '│'
let g:indentLine_color_gui = 'Grey40'
let g:indentLine_fileTypeExclude = ['help', 'text', 'nerdtree', 'startify', 'man']
"let g:indentLine_bufNameExclude = []

" Startify {{{1
function! s:PrettyVersion()
  let l:major = v:version / 100
  let l:minor = v:version - (l:major * 100)
  return l:major . '.' . l:minor
endfunction

hi! link StartifySpecial Comment
hi! link StartifyFile Constant
hi! link StartifyHeader Statement
hi! link StartifyFooter Statement
let g:startify_change_to_vcs_root = 1
let g:startify_restore_position = 1
let g:startify_session_dir = $VIMSESSIONS
let g:startify_custom_header = [
  \ '  ____   ____.__         ',
  \ '  \   \ /   /|__| _____  ',
  \ '   \   Y   / |  |/     \ ',
  \ '    \     /  |  |  Y Y  \',
  \ '     \___/   |__|__|_|  /  ' . s:PrettyVersion(),
  \ '                      \/ ',
  \ '',
  \ ] + map(split(system('fortune'), '\n'), '"   ". v:val') + ['']
let g:startify_list_order = [
  \ ['=== Recent files:'], 'files',
  \ ['=== Last modified files in: ' . getcwd() ], 'dir',
  \ ['=== Sessions:'], 'sessions',
  \ ['=== Bookmarks:'], 'bookmarks',
  \ ]
let g:startify_bookmarks = [
  \ '~/.config/nvim/init.vim',
  \ '~/.config/nvim/config.vim',
  \ '~/.config/nvim/plugins.vim',
  \ ]
let g:startify_skiplist = [
  \ 'COMMIT_EDITMSG',
  \ $VIMRUNTIME . '/doc',
  \ $VIMDATA . 'bundle/.*/doc',
  \ ]

" Tagbar {{{1
let g:tagbar_autoshowtag = 1
"let g:tagbar_compact = 1

let g:tagbar_type_sourcepawn = {
  \ 'ctagstype' : 'c',
  \ 'kinds' : [
      \ 'd:macros:1:0',
      \ 'g:enums',
      \ 'e:enumerators:0:0',
      \ 't:typedefs:0:0',
      \ 's:structs',
      \ 'm:members:0:0',
      \ 'v:variables:0:0',
      \ 'f:functions',
  \ ],
  \ 'sro' : '.',
  \ 'kind2scope' : {
      \ 'g' : 'enum',
      \ 's' : 'struct'
  \ },
\ }

" UltiSnips {{{1
let g:snips_author = 'Alex "ZeroKnight" George'
let g:UltiSnipsExpandTrigger = '<C-Tab>'
let g:UltiSnipsListSnippets = '<C-l>'

" YouCompleteMe {{{1
let g:ycm_error_symbol = '✗'
let g:ycm_warning_symbol = '!!'
let g:ycm_complete_in_comments = 1
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_always_populate_location_list = 1
" let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
" let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']

" xolox Lua ftplugin {{{1
let g:lua_internal = 0

" vim: fdm=marker
