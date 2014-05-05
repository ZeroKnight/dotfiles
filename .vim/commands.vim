" Commands
"==============================

" Session Save/Load shortcut
command! -nargs=1 Ss :mksession! ~/.vim/sessions/<args>.vim
command! -nargs=1 Sl :source ~/.vim/sessions/<args>.vim

" common typos
command! W w
command! Q q
