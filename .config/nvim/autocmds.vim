" Auto Commands
" ------------------------------------------------------------------------------

if has('autocmd')
  augroup ZeroVimAutoCommands
    " Clear the auto command group so we don't define it multiple times
    " From http://learnvimscriptthehardway.stevelosh.com/chapters/14.html
    autocmd!

    " Run NeoMake on write
    autocmd BufWritePost * Neomake

    " Automatically source personal runtime files on modification
    autocmd BufWritePost .{g,}vimrc,{g,}init.vim source %
    autocmd BufWritePost
      \ ~/{dotfiles/,}.vim/*.vim,~/{dotfiles/,}.config/nvim/*.vim
      \ source %

    " Automatically create directories for new files when saving
    autocmd BufWritePre,FileWritePre *
      \ if !isdirectory(expand('<afile>:p:h')) |
      \ call system('mkdir -p ' . shellescape(expand('<afile>:p:h'))) | endif

    " Toggle Relative-Numbering in various cases
    autocmd WinLeave,InsertEnter *
      \ if &number | set norelativenumber | endif
    autocmd WinEnter,BufWinEnter,VimEnter,InsertLeave *
      \ if &number | set relativenumber | endif

    " Only show cursor(line|column) in the active window
    autocmd WinLeave * setlocal nocursorline nocursorcolumn
    autocmd WinEnter * setlocal cursorline cursorcolumn

    " Use actual TABs when editing UltiSnips snippets. This makes UltiSnips
    " dynamically use expandtab, softtabstop, shiftwidth, etc in snippets
    autocmd FileType snippets setlocal sts=0

    " C/++ Settings
    autocmd FileType c,cpp setlocal nosmartindent cindent

    " Comment Tags
    autocmd Syntax * execute 'syn match ZeroCommentTags /\v(' .
      \ g:zeroknight_comment_tags . '):?/ containedin=.*Comment.* contained' |
      \ hi def link ZeroCommentTags Todo
  augroup END
endif
