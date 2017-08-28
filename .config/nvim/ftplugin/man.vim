" Extra settings and features for `man` buffers
" ------------------------------------------------------------------------------

" These maps should be recursive so that it actually performs the rhs mapping
" set by man.vim
nmap <buffer> <CR> <C-]>
nmap <buffer> <BS> <C-T>

" Search that matches at the first non-whitespace character of a line. Useful
" for searching for options or sub-command names
nnoremap <buffer> g/ /^\s*\zs
