if exists('s:loaded_man')
  finish
endif
let s:loaded_man = 1

" From bruno-/vim-man, with some edits
function! man#move_to_section(direction, mode, count)
  norm! m'
  if a:mode ==# 'v'
    norm! gv
  endif
  let l:i = 0
  while l:i < a:count
    let l:i += 1
    call search('^\%( \{3\}\)\=\S.*$', 'W'.a:direction)
  endwhile
endfunction

