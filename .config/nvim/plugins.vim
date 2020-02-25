" Vim Plugins
" ------------------------------------------------------------------------------

" Ensure that vim-plug is installed. {{{1
let s:vimplug_path      = $VIMDATA.'/site/autoload/plug.vim'
let s:vimplug_docs_path = $VIMDATA.'/site/doc/plug.txt'
if (!filereadable(s:vimplug_path) || !filereadable(s:vimplug_docs_path))
  if executable('curl')
    let s:vimplug_url = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/'
    if !filereadable(s:vimplug_path)
      call system('curl -fLo ' . shellescape(s:vimplug_path) . ' --create-dirs ' . s:vimplug_url.'plug.vim')
    endif
    if !filereadable(s:vimplug_docs_path)
      call system('curl -fLo ' . shellescape(s:vimplug_docs_path) . ' --create-dirs ' . s:vimplug_url.'doc/plug.txt')
      exec 'helptags' . fnamemodify(s:vimplug_docs_path, ':h')
    endif
    if v:shell_error
      echom 'Error downloading vim-plug; you may need to install it manually.'
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
Plug 'mbbill/undotree', {'on': ['UndotreeFocus', 'UndotreeHide', 'UndotreeShow', 'UndotreeToggle']}
Plug 'mhinz/vim-startify'
Plug 'romainl/vim-qlist'
Plug 'unblevable/quick-scope'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'wesQ3/vim-windowswap'
Plug 'Yggdroot/indentLine'
"Plug 'scrooloose/nerdtree'
"}}}

" Completion {{{
" Neovim Completion Manager
Plug 'ncm2/ncm2'
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-github'
" Plug 'ncm2/ncm2-neoinclude', {'for': ['c', 'cpp']} | Plug 'Shougo/neoinclude.vim', {'for': ['c', 'cpp']}
Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-pyclang', {'for': ['c', 'cpp']}
Plug 'ncm2/ncm2-ultisnips'
Plug 'ncm2/ncm2-tmux'
Plug 'ncm2/ncm2-vim', {'for': 'vim'} | Plug 'Shougo/neco-vim', {'for': 'vim'}
"}}}

" Language Server, Linting {{{
Plug 'natebosch/vim-lsc'
Plug 'dense-analysis/ale'
" Plug 'neomake/neomake'
"}}}

" Utilities {{{
Plug 'alx741/vinfo', {'on': 'Vinfo'}
Plug 'christoomey/vim-sort-motion'
Plug 'godlygeek/tabular', {'on': 'Tabularize'}
Plug 'hotchpotch/perldoc-vim', {'for': ['perl', 'pod'], 'on': 'Perldoc'}
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
" Plug 'ZeroKnight/vim-signjump'
Plug '~/Projects/vim-signjump'

Plug 'junegunn/fzf.vim'
Plug 'mhinz/vim-grepper'
Plug 'mileszs/ack.vim'

Plug 'SirVer/ultisnips'
Plug 'majutsushi/tagbar' " Don't defer, airline uses tagbar for a status item

if !has('nvim')
  Plug 'bruno-/vim-man'
endif

" Plug 'ervandew/supertab'
"}}}

" Syntax {{{
Plug 'sheerun/vim-polyglot'
Plug 'othree/xml.vim',          {'for': 'xml'}
Plug 'withgod/vim-sourcepawn',  {'for': 'sourcepawn'}
Plug 'Valloric/MatchTagAlways', {'for': ['html', 'xhtml', 'xml', 'jinja']}
Plug 'xolox/vim-lua-ftplugin',  {'for': 'lua'}

if has('nvim')
  Plug 'arakashic/chromatica.nvim', {'for': ['c', 'cpp', 'objc'], 'do': ':UpdateRemotePlugins'}
else
  Plug 'jeaye/color_coded', {'for': ['c', 'cpp', 'objc']}
endif
"}}}

" Color Schemes {{{
Plug 'rakr/vim-one'
Plug 'ciaranm/inkpot'
Plug 'tomasr/molokai'
Plug 'romainl/Apprentice'
Plug 'arcticicestudio/nord-vim'
Plug 'tyrannicaltoucan/vim-quantum'
Plug 'tyrannicaltoucan/vim-deep-space'
Plug 'mhartington/oceanic-next'
Plug 'dracula/vim', {'as': 'vim-dracula'}
Plug 'drewtempelmeyer/palenight.vim'
"}}}

" Libraries & Misc {{{
Plug 'tpope/vim-repeat'
Plug 'xolox/vim-misc'
Plug 'roxma/nvim-yarp'
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
let g:airline_symbols.maxlinenr = ''

" Extensions
let g:airline_theme='one'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_close_button = 0

" ALE {{{1
let g:ale_completion_enabled = 0
let g:ale_disable_lsp = 1
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '‼'

" FastFold {{{1
let g:fastfold_skip_filetypes = [ 'gitcommit', 'taglist' ]

" fzf-vim {{{1
let g:fzf_colors = {
  \ 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" Indent Guides {{{1
let g:indentLine_char = '│'
let g:indentLine_color_gui = 'Grey40'
let g:indentLine_fileTypeExclude = ['help', 'text', 'nerdtree', 'startify', 'man']
"let g:indentLine_bufNameExclude = []

" Language Server Client (vim-lsc) {{{1
set shortmess-=F
let g:lsc_autocomplete_length = 2
let g:lsc_auto_map = {
  \ 'defaults': v:true,
  \ 'FindCodeActions': '<Leader>a',
  \ 'SignatureHelp': '<C-s>',
  \ 'Completion': 'omnifunc'
  \ }
let g:lsc_server_commands = {
  \ 'python': 'pyls'
  \ }

" Neomake {{{1
let g:neomake_perl_args = ['PERL5LIB=.', '-c', '-X', '-Mwarnings']

" Neovim Completion Manager {{{1
set shortmess+=c
set completeopt=menuone,noinsert,noselect
let g:ncm2#complete_delay = 100

" Show completion menu after two characters like YCM
let g:ncm2#complete_length = [ [1,2], [7,2] ]

let g:ncm2_pyclang#library_path = '/usr/lib64/'

" Expand completed snippets
inoremap <silent> <expr> <C-Space> ncm2_ultisnips#expand_or("\<C-Space>", 'n')

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

" UltiSnips {{{1
let g:snips_author = 'Alex "ZeroKnight" George'
let g:UltiSnipsExpandTrigger = '<C-Space>'
let g:UltiSnipsListSnippets = '<C-l>'
let g:ultisnips_java_brace_style = 'nl'

" Quick-Scope {{{1
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
"}}}

" Plugin Autocommands
" ------------------------------------------------------------------------------

if has('autocmd')
  augroup ZeroVimPluginAutoCommands
    autocmd!

    if has_key(g:plugs, 'neomake')
      " Run NeoMake on write
      autocmd BufWritePost * Neomake
    endif

    if has_key(g:plugs, 'ncm2')
      autocmd BufEnter * call ncm2#enable_for_buffer()

      " Enable autocomplete for `<backspace>` and `<c-w>`
      autocmd TextChangedI * call ncm2#auto_trigger()
    endif

    if has_key(g:plugs, 'ultisnips')
      " Use actual TABs when editing UltiSnips snippets. This makes UltiSnips
      " dynamically use expandtab, softtabstop, shiftwidth, etc in snippets
      autocmd FileType snippets setlocal sts=0
    endif
  augroup END
endif

" vim: fdm=marker
