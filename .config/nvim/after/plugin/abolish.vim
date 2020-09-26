" Define abbreviations via Abolish
if !exists("g:loaded_abolish")
  finish
endif

Abolish anomol{y,ies} anomal{}
Abolish fu{cn,nc}{ti,it}on{,s} fu{nc}{ti}on{}
Abolish {,un}nec{ce,ces,e}sar{y,ily} {}nec{es}sar{}

" Twiddled characters
Abolish teh the
Abolish cosnt const
Abolish do{ens,sen} doesn
Abolish versoin version
Abolish aroudn around

" eh/æ mixups
Abolish {,in}consistant{,ly} {}consistent{}
Abolish permanant{,ly} permanent{}
Abolish existan{t,ce} existen{}
Abolish inheritence inheritance

" Other mixups
Abolish competative{,ly} competitive{}
