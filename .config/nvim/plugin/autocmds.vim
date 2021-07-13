" Auto Commands

augroup ZeroVimAutoCommands
  " Clear the auto command group so we don't define it multiple times
  " From http://learnvimscriptthehardway.stevelosh.com/chapters/14.html
  autocmd!

  " Automatically create directories for new files when saving
  autocmd BufWritePre,FileWritePre * call mkdir(expand('<afile>:p:h'), 'p')

  " Toggle Relative-Numbering in various cases
  autocmd WinLeave,InsertEnter *
    \ if &number | set norelativenumber | endif
  autocmd WinEnter,BufWinEnter,VimEnter,InsertLeave *
    \ if &number | set relativenumber | endif

  " Only show cursor(line|column) in the active window
  " The settings are restored to their global values, respecting config settings
  autocmd WinLeave * setlocal nocursorline nocursorcolumn
  autocmd WinEnter * setlocal cursorline< cursorcolumn<

  " C/++ Settings
  autocmd FileType c,cpp setlocal nosmartindent cindent

  " Comment Tags
  autocmd Syntax *
    \ if exists('g:zeroknight.comment_tags') |
    \   execute 'syn keyword ZeroKnightTodo contained ' . join(g:zeroknight.comment_tags, ' ') |
    \   hi def link ZeroKnightTodo Todo |
    \ endif

  " Terminal settings
  autocmd TermOpen * setlocal nonumber norelativenumber nocursorline nocursorcolumn
augroup END
