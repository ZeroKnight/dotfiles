" Dirvish filetype settings

" Hide dot files. Press R to reload the buffer and show them again
nnoremap gh :keeppatterns g@\v/\.[^\/]+/?$@d<cr>

nnoremap <buffer> <C-x> <Cmd>call dirvish#open('split', 0)<CR>
xnoremap <buffer> <C-x> <Cmd>call dirvish#open('split', 0)<CR>

nnoremap <buffer> <C-v> <Cmd>call dirvish#open('vsplit', 0)<CR>
xnoremap <buffer> <C-v> <Cmd>call dirvish#open('vsplit', 0)<CR>

nnoremap <buffer> <C-t> <Cmd>call dirvish#open('tabedit', 0)<CR>
xnoremap <buffer> <C-t> <Cmd>call dirvish#open('tabedit', 0)<CR>
