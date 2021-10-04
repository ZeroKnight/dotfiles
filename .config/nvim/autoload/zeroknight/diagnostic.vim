" Functions leveraging the Neovim Diagnostic API

" Check if buffer has any diagnostics available
function! zeroknight#diagnostic#available(...) abort
  let buffer = get(a:, 1, bufnr())
  return !empty(luaeval('vim.diagnostic.get(_A)', buffer))
endfunction

function! zeroknight#diagnostic#set_list(use_loclist, ...) abort
  let severity = get(a:, 1, v:null)
  if severity ==# ''
    let severity = v:null
  elseif severity != v:null
    let severity = luaeval(printf('vim.diagnostic.severity.%s', toupper(severity)))
  endif
  if a:use_loclist == v:true
    call luaeval('vim.diagnostic.setloclist{severity = _A}', severity)
  else
    call luaeval('vim.diagnostic.setqflist{severity = _A}', severity)
  endif
endfunction
