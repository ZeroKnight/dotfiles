" Platform specific config
"==============================

if has('win32') || has('win64') "{{{1
  " DOS Line endings can go to hell
  set fileformats=unix,dos fileformat=unix

  " DOS path separators can also go to hell
  set shellslash

  set shell=cmd shellcmdflag=/c

  " win32unix == Cygwin
  if has('win32unix')
    " Editing over scp
    let g:netrw_cygwin = 1
    let g:netrw_scp_cmd = 'bash -c "eval $(keychain --eval --agents ssh -Q --quiet ~/.ssh/*.key); scp -q'
  endif
else " Linux {{{1
  " blah
endif

"}}}1

" vim: fdm=marker
