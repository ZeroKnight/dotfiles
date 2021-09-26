" SirVer/ultisnips

if !exists('g:did_plugin_ultisnips')
  finish
endif

let g:snips_author = 'Alex "ZeroKnight" George'
let g:ultisnips_java_brace_style = 'nl'

function! s:make_todo_snippet(tag) abort
    let body = printf("`!p from zeroknight.sniputils import comment_tag; comment_tag('%s', snip)` $1", a:tag)
    call UltiSnips#AddSnippetWithPriority(a:tag, body, toupper(a:tag) . ' comment', '', 'all', 50)
endfunction
 
call s:make_todo_snippet('todo')
call s:make_todo_snippet('fixme')
call s:make_todo_snippet('note')
call s:make_todo_snippet('idea')
call s:make_todo_snippet('hack')

augroup ZeroKnight_UltiSnips
  autocmd!
  " Use actual TABs when editing UltiSnips snippets. This makes UltiSnips
  " dynamically use expandtab, softtabstop, shiftwidth, etc in snippets
  autocmd FileType snippets setlocal sts=0
augroup END

