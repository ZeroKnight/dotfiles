" Auto Commands

augroup ZeroVimAutoCommands
  " Clear the auto command group so we don't define it multiple times
  " From http://learnvimscriptthehardway.stevelosh.com/chapters/14.html
  autocmd!

  " Automatically create directories for new files when saving
  autocmd BufWritePre,FileWritePre * call mkdir(expand('<afile>:p:h'), 'p')

  " Many filetype plugins set `formatoptions+=o`. Undo this.
  autocmd FileType * setlocal formatoptions-=o

  " Toggle Relative-Numbering in various cases
  autocmd WinLeave,InsertEnter *
    \ if &number | set norelativenumber | endif
  autocmd WinEnter,BufWinEnter,VimEnter,InsertLeave *
    \ if &number | set relativenumber | endif

  " Only show cursor(line|column) in the active window
  " The settings are restored to their global values, respecting config settings
  autocmd WinLeave * setlocal nocursorline nocursorcolumn
  autocmd WinEnter * setlocal cursorline< cursorcolumn<

  " Terminal settings
  autocmd TermOpen * setlocal nonumber norelativenumber nocursorline nocursorcolumn

  " Highlight yanked text
  autocmd TextYankPost * silent!
    \ lua require('vim.highlight').on_yank{timeout = 300, higroup = 'LspReferenceWrite', on_visual = false}
augroup END
