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

        " Help/Man Page Viewer
        autocmd filetype help nnoremap <buffer><CR> <C-]>
        autocmd filetype help nnoremap <buffer><BS> <C-T>
        autocmd filetype help,man nnoremap <buffer>q :q<CR>
        autocmd filetype man
            \ setlocal ro noma nonu cc=0 noet ts=8 sts=8 sw=8 nolist |
            \ IndentGuidesDisable
    augroup END
endif
