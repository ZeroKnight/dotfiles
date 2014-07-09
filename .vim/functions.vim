" Functions
"==============================

" Converts DOS EOL to UNIX {{{1
function! DosToUnixEOL()
    update             " Save any changes
    e ++ff=dos         " Edit file again, using dos format ('fileformats' ignored)
    setlocal ff=unix   " Buffer will use LF-only line endings when written
    write              " Write the buffer (using LF-only line endings)
endfunction
nnoremap <silent> <Leader>eol :call DosToUnixEOL()<CR>

" Smart HOME {{{1
function! SmartHome()
    let s:col = col(".")
    normal! ^
    if s:col == col(".")
        normal! 0
    endif
endfunction
nnoremap <silent> <Home> :call SmartHome()<CR>
inoremap <silent> <Home> <C-O>:call SmartHome()<CR>
nnoremap <silent> 0 :call SmartHome()<CR>

" vim: fdm=marker
