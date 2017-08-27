" ZeroKnight's Vim Functions
" ------------------------------------------------------------------------------

" Recompile YCM {{{1
function! zerofunc#RecompileYCM(nJobs) abort
  let l:wd = getcwd()
  exec 'cd ' . system('mktemp -d')
  silent call system('cmake -G "Unix Makefiles" -DUSE_SYSTEM_LIBCLANG=ON . ~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp')
  silent call system('cmake --build . --target ycm_core' . a:nJobs ? ' -- -j'.a:nJobs : '')
  silent call system('rm -rf ' . getcwd())
  silent exec 'cd ' l:wd
  redraw!
  exec 'YcmRestartServer'
endfunction

" Quick Trim Trailing Space {{{1
function! zerofunc#TrimTrailingWhiteSpace() abort
  let l:col = col('.')
  let l:line = getline('.')
  if l:line !~# '\s\+$'
    return
  endif
  call setline('.', substitute(getline('.'), '\s\+$', '', ''))
  nohls
  call cursor(0, l:col)
endfunction

" Redirect the output of a Vim command into a Scratch buffer {{{1
function! zerofunc#Redir(split_type, ...)
  if a:0 < 1
    echoerr 'Not enough arguments. Must specify split_type, and a command with optional arguments.'
    return
  endif
  redir => l:output
  if a:1 =~# '^!'
    " If given a :! command, run it through system(), as execute() on a :!
    " command doesn't return the proper output
    let l:args = deepcopy(a:000)
    let l:args[0] = substitute(l:args[0], '^!', '', '')
    echo system(join(l:args))
  else
    call execute(join(a:000))
  endif
  redir END
  if a:split_type ==# 'vertical'
    vnew
  elseif a:split_type ==# 'tab'
    tabnew
  else
    new
  endif
  setlocal nobuflisted buftype=nofile bufhidden=wipe noswapfile
  call setline(1, split(l:output, "\n"))
endfunction

" vim: fdm=marker
