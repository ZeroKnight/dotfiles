" Functions
" ------------------------------------------------------------------------------

" Recompile YCM {{{1
function! RecompileYCM(nJobs) abort
  let l:wd = getcwd()
  exec 'cd ' . system('mktemp -d')
  silent call system('cmake -G "Unix Makefiles" -DUSE_SYSTEM_LIBCLANG=ON . ~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp')
  silent call system('cmake --build . --target ycm_core' . a:nJobs ? ' -- -j'.a:nJobs : '')
  silent call system('rm -rf ' . getcwd())
  silent exec 'cd ' l:wd
  redraw!
  exec 'YcmRestartServer'
endfunction
nnoremap <Leader>ycm :<C-U>call RecompileYCM(v:count)<CR>

" Quick Trim Trailing Space {{{1
function! TrimTrailingWhiteSpace() abort
  let l:col = col('.')
  let l:line = getline('.')
  if l:line !~# '\s\+$'
    return
  endif
  call setline('.', substitute(getline('.'), '\s\+$', '', ''))
  nohls
  call cursor(0, l:col)
endfunction
nnoremap <silent> <Leader>ts :call TrimTrailingWhiteSpace()<CR>
vnoremap <silent> <Leader>ts :call TrimTrailingWhiteSpace()<CR>

" Redirect the output of a Vim command into a Scratch buffer {{{1
function! Redir(split_type, ...) abort
  redir => l:output
  exec join(a:000)
  redir END
  if a:split_type ==# 'vertical'
    vnew
  elseif a:split_type ==# 'tab'
    tabnew
  endif
  setlocal nobuflisted buftype=nofile bufhidden=wipe noswapfile
  call setline(1, split(l:output, "\n"))
endfunction
command! -nargs=+ Redir silent call Redir('horizontal', <f-args>)
command! -nargs=+ VRedir silent call Redir('vertical', <f-args>)
command! -nargs=+ TRedir silent call Redir('tab', <f-args>)

" vim: fdm=marker
