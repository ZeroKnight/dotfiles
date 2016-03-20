" Vim Plugin Settings
"==============================

" CtrlP {{{1
let g:ctrlp_extensions = ['mixed', 'line', 'dir', 'quickfix', 'buffertag', 'tag']
let g:ctrlp_switch_buffer = 'Et'
let g:ctrlp_working_path_mode = 'ar'

if executable('ag')
    " Enables CtrlP to search using Ag for listing files.
    " Lightning fast, no need to cache and even respects .gitignore
    let g:ctrlp_user_command = 'ag %s --nocolor -l -g ""'
    let g:ctrlp_use_caching = 0
endif

" GitGutter {{{1
hi! link SignColumn LineNr
hi! link GitGutterAdd           DiffAdd
hi! link GitGutterChange        DiffChange
hi! link GitGutterDelete        DiffDelete
hi! link GitGutterChangeDelete  DiffDelete

" Indent Guides {{{1
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2
let g:indent_guides_exclude_filetypes = ['help', 'nerdtree', 'startify', 'man']

" NERDTree {{{1
let NERDChristmasTree = 1
let NERDTreeHijackNetrw = 1
let NERDTreeShowBookmarks = 1
let NERDTreeShowHidden = 1
let NERDTreeBookmarksFile = $VIMFILES . "/.NERDTreeBookmarks"

" ShowMarks {{{1
" Keep disabled on startup
let showmarks_enable = 0

" Startify {{{1
function! PrettyVersion()
    let major = v:version / 100
    let minor = v:version - (major * 100)
    return major . '.' . minor
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
    \ '     \___/   |__|__|_|  /  ' . PrettyVersion(),
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
    \ '~/.vimrc',
    \ '~/.vim/config.vim',
    \ '~/.vim/vundle.vim',
    \ '~/.vim/plugins.vim',
    \ '~/.config/awesome/rc.lua',
    \ ]
let g:startify_skiplist = [
    \ 'COMMIT_EDITMSG',
    \ expand($VIMRUNTIME) . '/doc',
    \ expand($VIMFILES) . 'bundle/.*/doc',
    \ ]

" Tagbar {{{1
let g:tagbar_autoshowtag = 1
"let g:tagbar_compact = 1

" UltiSnips {{{1
let g:snips_author = "Alex \"ZeroKnight\" George"
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsListSnippets = "<C-x>"

" xolox Extended Sessions {{{1
let g:session_directory = $VIMSESSIONS
let g:session_autoload = 'no'
let g:session_autosave_periodic = 10

" YouCompleteMe {{{1
let g:ycm_error_symbol = '✗'
let g:ycm_warning_symbol = '!!'
let g:ycm_complete_in_comments = 1
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_always_populate_location_list = 1
" UltiSnips compatibility via SuperTab
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" vim: fdm=marker
