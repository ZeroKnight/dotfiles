" majutsushi/tagbar

if !exists('g:loaded_tagbar')
  finish
endif

let g:tagbar_autoshowtag = 1

" Toggle Tagbar
nnoremap <silent> <F4> <Cmd>TagbarToggle<CR>
inoremap <silent> <F4> <Cmd>TagbarToggle<CR>

