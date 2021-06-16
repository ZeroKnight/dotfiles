" itchyny/lightline.vim

if !exists('g:loaded_lightline')
  finish
endif

function! s:ReloadLightlineColorScheme(name) abort
  let g:lightline.colorscheme = a:name
  exec printf('runtime autoload/lightline/colorscheme/%s.vim', a:name)
  call lightline#enable()
endfunction

augroup ZeroKnight_lightline
  autocmd!
  " LightLine doesn't automatically reload colorschemes
  autocmd ColorScheme * call s:ReloadLightlineColorScheme(expand('<amatch>'))
augroup END
