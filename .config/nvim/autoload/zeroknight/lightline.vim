" Functions for my LightLine

" Minimum window width for certain components to show
let s:minwidth = 80

function! zeroknight#lightline#has_minwidth() abort
  return winwidth(0) >= s:minwidth
endfunction
let s:has_minwidth = function('zeroknight#lightline#has_minwidth')

let s:filetype_map = #{fugitive: 'Fugitive', dirvish: 'Dirvish'}
function! zeroknight#lightline#mode() abort
  if &buftype ==# 'help'
    return 'Help'
  endif
  let l:wininfo = getwininfo(win_getid())[0]
  if get(l:wininfo, 'quickfix', 0)
    return get(l:wininfo, 'loclist', 0) ? 'Location' : 'Quickfix'
  endif
  let l:mode = get(s:filetype_map, &filetype, lightline#mode())
  return s:has_minwidth() ? l:mode : l:mode[:2]
endfunction

function! zeroknight#lightline#file_name() abort
  let l:icon = ''
  if &buftype ==# 'help'
    let l:icon = ''
    let l:filename = expand('%:t')
  elseif &buftype ==# 'quickfix'
    " Show Quickfix/LocList title as filename
    if get(getwininfo(win_getid())[0], 'loclist', 0)
      return getloclist(0, {'title': 1})['title']
    endif
    return getqflist({'title': 1})['title']
  else
    " Regular filename
    let l:exp = expand('%')
    let l:icon = luaeval("require('nvim-web-devicons').get_icon(_A)", expand('%:e'))
    let l:filename = len(l:exp) ? l:exp : '[No Name]'
  endif
  let l:icon = len(l:icon) ? l:icon . ' ' : ''
  let l:mod = &modified ? ' [+]' : !&modifiable && (&buftype ==# '') ? ' [-]' : ''
  return printf('%s%s %s', l:icon, l:filename, l:mod)
endfunction

function! zeroknight#lightline#file_info() abort
  let l:enc = &fenc !=# '' ? &fenc : &enc
  return s:has_minwidth() ? printf('%s [%s]', l:enc, &ff) : ''
endfunction

function! zeroknight#lightline#readonly() abort
  return &readonly && (&buftype ==# '') ? 'RO' : ''
endfunction

function! zeroknight#lightline#git_branch() abort
  let l:branch = get(b:, 'gitsigns_head')
  return s:has_minwidth() && l:branch !=# '' ? ' ' .. l:branch : ''
endfunction

function! zeroknight#lightline#git_hunks() abort
  let l:stats = get(b:, 'gitsigns_status')
  return s:has_minwidth() && len(l:stats) ? l:stats : ''
endfunction

function! zeroknight#lightline#diagnostics() abort
  if !zeroknight#util#has_lsp()
    return ''
  endif
  let segments = []
  for severity in ['Error', 'Warning', 'Information', 'Hint']
    let count = luaeval("vim.lsp.diagnostic.get_count(0, _A)", severity)
    if count
      let icon = sign_getdefined('LspDiagnosticsSign' .. severity)[0].text
      call add(segments, printf('%%#LightlineLspDiagnostics%s#%s %d', severity, icon, count))
    endif
  endfor
  return join(segments)
endfunction

function! zeroknight#lightline#current_symbol() abort
  if !zeroknight#util#has_lsp()
    return ''
  endif
  return get(b:, 'lsp_current_function', '')
endfunction

function! zeroknight#lightline#lsp_progress() abort
  if !zeroknight#util#has_lsp()
    return ''
  endif
  return luaeval("require('lsp-status').status_progress()")
endfunction
