" Yggdroot/indentLine

if !exists('g:indentLine_loaded')
  finish
endif

let g:indentLine_char = '│'
let g:indentLine_color_gui = 'Grey40'

let g:indentLine_fileTypeExclude = ['help', 'text', 'markdown', 'startify', 'man']
" let g:indentLine_bufNameExclude = []

" Toggle Indent Guides
nnoremap <silent> <Leader>ig <Cmd>IndentLinesToggle<CR>
inoremap <silent> <Leader>ig <Cmd>IndentLinesToggle<CR>

augroup ZeroKnight_IndentLine
  autocmd!
  autocmd TermOpen * IndentLinesDIsable
augroup END

