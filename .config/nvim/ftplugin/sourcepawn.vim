" SourcePawn filetype settings

setlocal makeprg=/usr/local/bin/spc\ % |
setlocal commentstring=//\ %s

let g:tagbar_type_sourcepawn = {
  \ 'ctagstype' : 'c',
  \ 'kinds' : [
      \ 'd:macros:1:0',
      \ 'g:enums',
      \ 'e:enumerators:0:0',
      \ 't:typedefs:0:0',
      \ 's:structs',
      \ 'm:members:0:0',
      \ 'v:variables:0:0',
      \ 'f:functions',
  \ ],
  \ 'sro' : '.',
  \ 'kind2scope' : {
      \ 'g' : 'enum',
      \ 's' : 'struct'
  \ },
\ }

