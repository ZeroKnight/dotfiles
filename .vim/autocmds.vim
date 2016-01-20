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

        " Use actual TABs when editing UltiSnips snippets. This makes UltiSnips
        " dynamically use expandtab, softtabstop, shiftwidth, etc in snippets
        autocmd BufRead ~/.vim/UltiSnips/*.snippets setlocal noet sts=0

        " Set SourcePawn syntax
        autocmd BufRead *.sp set filetype=sourcepawn

        " Help/Man Page Viewer
        autocmd filetype help nnoremap <buffer><CR> <C-]>
        autocmd filetype help nnoremap <buffer><BS> <C-T>
        autocmd filetype help,man nnoremap <buffer>q :q<CR>
        autocmd filetype man
            \ setlocal ro noma nonu cc=0 noet ts=8 sts=8 sw=8 nolist |
            \ IndentGuidesDisable
    augroup END
endif
