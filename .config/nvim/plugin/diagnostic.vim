" TODO: Move this to lua/zeroknight/config/diagnostic.lua once the API supports command definitions

function! s:complete(lead, cmdline, curpos) abort
  return ['error', 'warn', 'info', 'hint']
endfunction

command! -nargs=? -bang -complete=customlist,s:complete Diagnostics
  \ call zeroknight#diagnostic#set_list('<bang>' == '!', <q-args>)
