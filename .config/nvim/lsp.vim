" Language Server Configuration

function! s:on_lsp_buffer_enabled() abort
  setlocal omnifunc=lsp#complete
  setlocal signcolumn=yes
  setlocal foldmethod=expr
    \ foldexpr=lsp#ui#vim#folding#foldexpr()
    \ foldtext=lsp#ui#vim#folding#foldtext()

  nmap <buffer> <Leader>a  <Plug>(lsp-code-action)
  nmap <buffer> gD         <Plug>(lsp-declaration)
  nmap <buffer> gd         <Plug>(lsp-definition)
  nmap <buffer> K          <Plug>(lsp-hover)
  nmap <buffer> ]r         <Plug>(lsp-next-reference)
  nmap <buffer> [r         <Plug>(lsp-previous-reference)
  nmap <buffer> [I         <Plug>(lsp-references)
  nmap <buffer> ]I         <Plug>(lsp-references)
  nmap <buffer> <F2>       <Plug>(lsp-rename)
  nmap <buffer> <C-s>      <Plug>(lsp-signature-help)
  nmap <buffer> <Leader>pD <Plug>(lsp-peek-declaration)
  nmap <buffer> <Leader>pd <Plug>(lsp-peek-definition)
endfunction

augroup lsp_install
    autocmd!
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

if executable('pyls')
  au User lsp_setup call lsp#register_server({
    \ 'name': 'pyls',
    \ 'cmd': {server_info->['pyls']},
    \ 'whitelist': ['python'],
    \ })
endif

