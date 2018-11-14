" ZeroKnight's Vim Functions
" ------------------------------------------------------------------------------

" Recompile YCM {{{1
function! zerofunc#RecompileYCM(nJobs) abort
  if !executable('cmake')
    echoerr 'cmake not installed, aborting'
    return
  endif
  let l:build_dir = '/tmp/ycm-build'
  if !isdirectory('l:build_dir')
    silent call system('mkdir -p ' . l:build_dir)
  endif
  exec 'Start -dir=' . l:build_dir . ' cmake -G "Unix Makefiles" -DUSE_PYTHON2=OFF -DUSE_SYSTEM_LIBCLANG=ON . ' . $VIMDATA.'/plugins/YouCompleteMe/third_party/ycmd/cpp && cmake --build . --target ycm_core'
  exec 'YcmRestartServer'
endfunction

" Trim trailing whitespace while preserving buffer state {{{1
" Courtesy Martin Tournoji
function! zerofunc#TrimTrailingSpace() abort
  let l:save = winsaveview()
  keeppatterns %substitute/\s\+$//e
  call winrestview(l:save)
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
