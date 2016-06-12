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
cnoreabbrev <expr> ht getcmdtype() == ':' && getcmdline() == 'ht' ? 'Helptab' : 'ht'

" Open :help in a vertical split {{{1
command! -nargs=? -complete=help Helpvert vert help <args>
cnoreabbrev <expr> hv getcmdtype() == ':' && getcmdline() == 'hv' ? 'Helpvert' : 'hv'
cnoreabbrev <expr> vh getcmdtype() == ':' && getcmdline() == 'vh' ? 'Helpvert' : 'vh'

" Load Comment Tags into the Location List {{{1
command! -nargs=0 Todo execute 'LAg -A ' . string(g:zeroknight_comment_tags)

" vim: fdm=marker
