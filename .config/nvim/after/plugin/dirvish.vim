" justinmk/vim-dirvish

if !exists('g:loaded_dirvish')
  finish
endif

" NOTE: Dirvish implements the icon with `conceal`, so we can't add a space
" between the icon and filename, unfortunately.
function! <SID>dirvish_get_icon(path) abort
  let devicon = luaeval("require('nvim-web-devicons').get_icon(_A)", fnamemodify(a:path, ':e'))
  return a:path[-1:] == '/' ? '' : devicon
endfunction

call dirvish#add_icon_fn(funcref('<SID>dirvish_get_icon'))

