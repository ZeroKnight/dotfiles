" C filetype settings

let g:c_gnu = 1
let g:c_comment_strings = 1

" Load doxygen syntax
let g:load_doxygen_syntax = 1

setlocal nosmartindent cindent

" Swap between header and source
nnoremap <buffer> <expr> <LocalLeader>a ':e ' . findfile(expand('%:t:r') .
  \ (expand('%:e') =~? '^c' ? '.h' : '.c') . expand('%:e')[1:], &path) . '<CR>'
