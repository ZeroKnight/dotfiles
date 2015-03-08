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
    let l:col = col(".")
    normal! ^
    if l:col == col(".")
        normal! 0
    endif
endfunction
nnoremap <silent> <Home> :call SmartHome()<CR>
inoremap <silent> <Home> <C-O>:call SmartHome()<CR>
nnoremap <silent> 0 :call SmartHome()<CR>

" Recompile YCM {{{1
function! RecompileYCM()
    let l:wd = getcwd()
    execute "cd " . system("mktemp -d")
    execute "silent !cmake -G \"Unix Makefiles\" -DUSE_SYSTEM_LIBCLANG=ON . ~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp"
    execute "silent !make -j6 ycm_support_libs"
    execute "silent !rm -rf " . getcwd()
    execute "cd " . l:wd
    redraw!
    execute "YcmRestartServer"
endfunction
nnoremap <Leader>ycm :call RecompileYCM()<CR>

" Quick Trim Trailing Space {{{1
function! TrimTrailingWhiteSpace()
    let l:col = col(".")
    substitute/\s\+$//e
    nohls
    call cursor(0, l:col)
endfunction
nnoremap <silent> <Leader>ts :call TrimTrailingWhiteSpace()<CR>
vnoremap <silent> <Leader>ts :call TrimTrailingWhiteSpace()<CR>

" vim: fdm=marker
