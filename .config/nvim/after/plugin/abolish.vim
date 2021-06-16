" tpope/vim-abolish

if !exists("g:loaded_abolish")
  finish
endif

Abolish anomol{y,ies} anomal{}
Abolish fu{cn,nc}{ti,it}on{,s} fu{nc}{ti}on{}
Abolish {,un}nec{ce,ces,e}sar{y,ily} {}nec{es}sar{}
Abolish oc{,c}ur{,r} occur

" Twiddled characters
Abolish teh the
Abolish cosnt const
Abolish do{ens,sen} doesn
Abolish versoin version
Abolish aroudn around
Abolish reutrn return

" eh/æ mixups
Abolish {,in}consistant{,ly} {}consistent{}
Abolish persistant{,ly} persistent{}
Abolish permanant{,ly} permanent{}
Abolish existan{t,ce} existen{}
Abolish inheritence inheritance
Abolish oc{,c}ur{,r}ance occurrence

" Other mixups
Abolish competative{,ly} competitive{}

