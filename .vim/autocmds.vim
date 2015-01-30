" Auto Commands
"==============================

if has("autocmd")
    augroup ZeroVimAutoCommands
        " Clear the auto command group so we don't define it multiple times
        " Idea from http://learnvimscriptthehardway.stevelosh.com/chapters/14.html
        autocmd!

        " Automatically source personal runtime files on modification
        autocmd BufWritePost .vimrc source $MYVIMRC
        autocmd BufWritePost ~/.vim/*.vim source %

        " OpenBox WM configuration related 
        autocmd BufWritePost */openbox/menu.xml silent !openbox --reconfigure
        autocmd BufEnter */openbox/autostart nested set filetype=sh


        " Help/Man Page Viewer
        autocmd filetype help nnoremap <buffer><CR> <C-]>
        autocmd filetype help nnoremap <buffer><BS> <C-T>
        autocmd filetype help,man nnoremap <buffer>q :q<CR>
        autocmd filetype man
            \ setlocal ro noma nonu cc=0 noet ts=8 sts=8 sw=8 nolist |
            \ IndentGuidesDisable

        " Extra C++ Syntax Highlighting
        autocmd BufRead,BufNewFile *.[ch]\\\{1,2\},*.[ch]pp,*.[ch]xx,*.m syntax match cOpers "[!~%^&*(){}?+=[\]\\\-;,.:<>|]"
        autocmd BufRead,BufNewFile *.[ch]\\\{1,2\},*.[ch]pp,*.[ch]xx,*.m hi def link cOpers Operator

        autocmd BufRead,BufNewFile *.[ch]\\\{1,2\},*.[ch]pp,*.[ch]xx,*.m setlocal cindent
    augroup END
endif
