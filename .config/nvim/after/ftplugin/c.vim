" Swap between header and source
nnoremap <buffer> <expr> <localleader>a ':e ' . findfile(expand('%:t:r') .
  \ (expand('%:e') =~? '^c' ? '.h' : '.c') . expand('%:e')[1:], &path) . '<CR>'
