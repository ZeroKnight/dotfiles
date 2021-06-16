" ZeroKnight's Misc Vim Functions
" ------------------------------------------------------------------------------

" Trim trailing whitespace while preserving buffer state
" Courtesy Martin Tournoji
function! zeroknight#util#TrimTrailingSpace() abort
  let l:save = winsaveview()
  keeppatterns %substitute/\s\+$//e
  call winrestview(l:save)
endfunction

" Redirect the output of a Vim command into a Scratch buffer
function! zeroknight#util#Redir(split_type, ...)
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

function! zeroknight#util#Pcol(...) abort
  let a:above = get(a:, 1, 0)
  let l:col = virtcol('.')
  execute 'normal!' a:above ? 'P' : 'p'
  call cursor('.', l:col)
endfunction
