" Extra settings and features for `dirvish` buffers
" ------------------------------------------------------------------------------

" Hide dot files. Press R to reload the buffer and show them again
nnoremap gh :keeppatterns g@\v/\.[^\/]+/?$@d<cr>

nnoremap <buffer> t :call dirvish#open('tabedit', 0)<CR> |
xnoremap <buffer> t :call dirvish#open('tabedit', 0)<CR> |
