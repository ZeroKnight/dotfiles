" mbbill/undotree

if !exists('g:loaded_undotree')
  finish
endif

" Toggle UndoTree
nnoremap <silent> <F5> <Cmd>UndotreeToggle<CR>
inoremap <silent> <F5> <Cmd>UndotreeToggle<CR>

