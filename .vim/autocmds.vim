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

    " Toggle Relative-Numbering in various cases
    autocmd WinLeave,InsertEnter *
      \ if &number | set norelativenumber | endif
    autocmd WinEnter,BufWinEnter,VimEnter,InsertLeave *
      \ if &number | set relativenumber | endif

    " Use actual TABs when editing UltiSnips snippets. This makes UltiSnips
    " dynamically use expandtab, softtabstop, shiftwidth, etc in snippets
    autocmd filetype snippets setlocal sts=0

    " SourcePawn compilation
    autocmd filetype sourcepawn setlocal makeprg=/usr/local/bin/spc\ % |
      \ setlocal commentstring=//%s

    " Help/Man Page Viewer
    autocmd filetype help,man nnoremap <buffer><CR> <C-]>
    autocmd filetype help,man nnoremap <buffer><BS> <C-T>
    autocmd filetype help,man nnoremap <buffer>q :q<CR>
    autocmd filetype man
      \ setlocal ro noma nonu cc=0 noet ts=8 sts=8 sw=8 nolist
  augroup END
endif
