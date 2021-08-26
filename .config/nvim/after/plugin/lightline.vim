" itchyny/lightline.vim

if !exists('g:loaded_lightline')
  finish
endif

" Diagnostics coloring hack
function! s:DiagnosticsHack(name) abort
  let palette = get(g:, printf('lightline#colorscheme#%s#palette', a:name))
  for severity in ['Error', 'Warning', 'Information', 'Hint']
    let fg = printf('#%06x', nvim_get_hl_by_name('LspDiagnosticsDefault' .. severity, v:true).foreground)
    let bg = palette.normal.middle[0][1]
    exec printf('hi LightlineLspDiagnostics%s guifg=%s guibg=%s', severity, fg, bg)
  endfor
endfunction

function! s:ReloadLightlineColorScheme(name) abort
  let g:lightline.colorscheme = a:name
  exec printf('runtime autoload/lightline/colorscheme/%s.vim', a:name)
  call s:DiagnosticsHack(a:name)
  call lightline#enable()
endfunction

augroup ZeroKnight_lightline
  autocmd!
  " LightLine doesn't automatically reload colorschemes
  autocmd ColorScheme * call s:ReloadLightlineColorScheme(expand('<amatch>'))
  autocmd VimEnter * call s:DiagnosticsHack(g:colors_name) | call lightline#colorscheme()
augroup END
