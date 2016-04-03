" Commands
"==============================

" Session Save/Load shortcut {{{1
command! -nargs=1 Ss :mksession! ~/.vim/sessions/<args>.vim
command! -nargs=1 Sl :source ~/.vim/sessions/<args>.vim

" Common typos {{{1
command! W w
command! Q q

" Open :help in a new tab {{{1
command! -nargs=? -complete=help Helptab tab help <args>
cnoreabbrev <expr> ht getcmdtype() == ":" && getcmdline() == 'ht' ? 'Helptab' : 'ht'

" vim: fdm=marker
