" SirVer/ultisnips

if !exists('g:did_plugin_ultisnips')
  finish
endif

let g:snips_author = 'Alex "ZeroKnight" George'
let g:ultisnips_java_brace_style = 'nl'

augroup ZeroKnight_UltiSnips
  autocmd!
  " Use actual TABs when editing UltiSnips snippets. This makes UltiSnips
  " dynamically use expandtab, softtabstop, shiftwidth, etc in snippets
  autocmd FileType snippets setlocal sts=0
augroup END

