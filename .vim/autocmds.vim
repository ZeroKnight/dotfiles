" Auto Commands
"==============================

if has("autocmd")
  augroup ZeroVimAutoCommands
    " Clear the auto command group so we don't define it multiple times
    " From http://learnvimscriptthehardway.stevelosh.com/chapters/14.html
    autocmd!

    " Automatically source personal runtime files on modification
    autocmd BufWritePost .vimrc source $MYVIMRC
    autocmd BufWritePost ~/.vim/*.vim,~/dotfiles/.vim/*.vim source %

    " Automatically create directories for new files when saving
    autocmd BufWritePre,FileWritePre *
      \ if !isdirectory(expand('<afile>:p:h')) |
      \ silent! exec '!mkdir -p ' . expand('<afile>:p:h') | endif

    " Toggle Relative-Numbering in various cases
    autocmd WinLeave,InsertEnter *
      \ if &number | set norelativenumber | endif
    autocmd WinEnter,BufWinEnter,VimEnter,InsertLeave *
      \ if &number | set relativenumber | endif

    " Only show cursor(line|column) in the active window
    autocmd WinLeave * set nocursorline nocursorcolumn
    autocmd WinEnter * set cursorline cursorcolumn

    " Use actual TABs when editing UltiSnips snippets. This makes UltiSnips
    " dynamically use expandtab, softtabstop, shiftwidth, etc in snippets
    autocmd FileType snippets setlocal sts=0

    " SourcePawn compilation
    autocmd FileType sourcepawn
      \ setlocal makeprg=/usr/local/bin/spc\ % |
      \ setlocal commentstring=//%s

    " Help/Man Page Viewer
    autocmd FileType help,man
      \ nnoremap <buffer> <CR> <C-]> |
      \ nnoremap <buffer> <BS> <C-T> |
      \ nnoremap <buffer> q :q<CR>
    autocmd FileType man
      \ setlocal ro noma nonu cc=0 noet ts=8 sts=8 sw=8 nolist

    " C/++ Settings
    autocmd FileType c,cpp setlocal nosmartindent cindent

    " Dirvish
    autocmd FileType dirvish
      \ nnoremap <buffer> t :call dirvish#open('tabedit', 0)<CR> |
      \ xnoremap <buffer> t :call dirvish#open('tabedit', 0)<CR> |
      \ call fugitive#detect(@%) |
      \ nnoremap gh :keeppatterns g@\v/\.[^\/]+/?$@d<cr>

    " Comment Tags
    autocmd Syntax * execute 'syn match ZeroCommentTags /\v(' .
      \ g:zeroknight_comment_tags . '):?/ containedin=.*Comment.*' |
      \ hi def link ZeroCommentTags Todo
  augroup END
endif
