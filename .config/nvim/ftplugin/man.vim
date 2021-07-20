" Man filetype settings

" These maps should be recursive so that it actually performs the rhs mapping
" set by man.vim
nmap <silent> <buffer> <CR> <C-]>
nmap <silent> <buffer> <BS> <C-T>

" Jump between sections
nnoremap <silent> <buffer> [[ :<C-U>call man#move_to_section('b', 'n', v:count1)<CR>
nnoremap <silent> <buffer> ]] :<C-U>call man#move_to_section('' , 'n', v:count1)<CR>
xnoremap <silent> <buffer> [[ :<C-U>call man#move_to_section('b', 'v', v:count1)<CR>
xnoremap <silent> <buffer> ]] :<C-U>call man#move_to_section('' , 'v', v:count1)<CR>

" Search that matches at the first non-whitespace character of a line. Useful
" for searching for options or sub-command names
nnoremap <silent> <buffer> g/ /^\s*\zs
