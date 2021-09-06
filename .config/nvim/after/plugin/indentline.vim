" Yggdroot/indentLine

if !exists('g:indentLine_loaded')
  finish
endif

let g:indentLine_char = '│'
let g:indentLine_defaultGroup = 'LineNr'

let g:indentLine_bufTypeExclude = ['help', 'terminal']
let g:indentLine_fileTypeExclude = ['text', 'markdown', 'startify', 'man', 'packer']
" let g:indentLine_bufNameExclude = []

augroup ZeroKnight_IndentLine
  autocmd!
  autocmd TermOpen * IndentLinesDisable
augroup END

