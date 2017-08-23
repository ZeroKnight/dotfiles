" Platform specific config
"==============================

if has('win32') || has('win64') "{{{1
  " DOS Line endings can go to hell
  set fileformats=unix,dos fileformat=unix

  " DOS path separators can also go to hell
  set shellslash

  " Make shell options behave more like Linux
  " see :h 'shell'
  "set shell=bash shellcmdflag=-c
  " NOTE: Disabled for now as this causes all sorts of problems because
  " system() is fucking lame.
  set shell=cmd shellcmdflag=/c

  " Editing over scp
  let g:netrw_cygwin = 1
  let g:netrw_scp_cmd = 'bash -c "eval $(keychain --eval --agents ssh -Q --quiet ~/.ssh/*.key); scp -q'
else " Linux {{{1
  " blah
endif

"}}}1

" vim: fdm=marker
