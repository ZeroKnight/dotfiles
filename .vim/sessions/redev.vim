let SessionLoad = 1
if &cp | set nocp | endif
let s:so_save = &so | let s:siso_save = &siso | set so=0 siso=0
let v:this_session=expand("<sfile>:p")
silent only
cd ~/Documents/Development/redeclipse
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +52 data/config/menus/options.cfg
badd +1 src/game/hud.cpp
badd +41 data/config/menus/main.cfg
badd +20 data/config/menus/game.cfg
badd +1 data/config/menus/package.cfg
badd +165 data/config/menus/glue.cfg
badd +2 data/config/menus/maps.cfg
silent! argdel *
winpos 990 40
edit data/config/menus/maps.cfg
set splitbelow splitright
wincmd _ | wincmd |
split
wincmd _ | wincmd |
split
wincmd _ | wincmd |
split
wincmd _ | wincmd |
split
4wincmd k
wincmd w
wincmd w
wincmd w
wincmd w
set nosplitbelow
set nosplitright
wincmd t
set winheight=1 winwidth=1
exe '1resize ' . ((&lines * 1 + 24) / 48)
exe '2resize ' . ((&lines * 6 + 24) / 48)
exe '3resize ' . ((&lines * 17 + 24) / 48)
exe '4resize ' . ((&lines * 10 + 24) / 48)
exe '5resize ' . ((&lines * 8 + 24) / 48)
argglobal
enew
file -MiniBufExplorer-
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
wincmd w
argglobal
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 182 - ((2 * winheight(0) + 3) / 6)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
182
normal! 034l
wincmd w
argglobal
edit data/config/menus/options.cfg
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
33,278fold
280,376fold
let s:l = 381 - ((102 * winheight(0) + 8) / 17)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
381
normal! 04l
wincmd w
argglobal
edit data/config/menus/options.cfg
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 416 - ((5 * winheight(0) + 5) / 10)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
416
normal! 04l
wincmd w
argglobal
edit data/config/menus/glue.cfg
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 165 - ((4 * winheight(0) + 4) / 8)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
165
normal! 0
wincmd w
3wincmd w
exe '1resize ' . ((&lines * 1 + 24) / 48)
exe '2resize ' . ((&lines * 6 + 24) / 48)
exe '3resize ' . ((&lines * 17 + 24) / 48)
exe '4resize ' . ((&lines * 10 + 24) / 48)
exe '5resize ' . ((&lines * 8 + 24) / 48)
tabedit src/game/hud.cpp
set splitbelow splitright
wincmd _ | wincmd |
split
wincmd _ | wincmd |
split
2wincmd k
wincmd w
wincmd w
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
set nosplitbelow
set nosplitright
wincmd t
set winheight=1 winwidth=1
exe '1resize ' . ((&lines * 1 + 24) / 48)
exe '2resize ' . ((&lines * 3 + 24) / 48)
exe '3resize ' . ((&lines * 37 + 24) / 48)
exe 'vert 3resize ' . ((&columns * 93 + 66) / 132)
exe '4resize ' . ((&lines * 37 + 24) / 48)
exe 'vert 4resize ' . ((&columns * 38 + 66) / 132)
argglobal
enew
file -MiniBufExplorer-
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
wincmd w
argglobal
enew
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
wincmd w
argglobal
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 2191 - ((0 * winheight(0) + 18) / 37)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
2191
normal! 028l
wincmd w
argglobal
edit src/game/hud.cpp
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 1 - ((0 * winheight(0) + 18) / 37)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
1
normal! 0
wincmd w
3wincmd w
exe '1resize ' . ((&lines * 1 + 24) / 48)
exe '2resize ' . ((&lines * 3 + 24) / 48)
exe '3resize ' . ((&lines * 37 + 24) / 48)
exe 'vert 3resize ' . ((&columns * 93 + 66) / 132)
exe '4resize ' . ((&lines * 37 + 24) / 48)
exe 'vert 4resize ' . ((&columns * 38 + 66) / 132)
tabnext 1
if exists('s:wipebuf')
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20 shortmess=filnxtToO
let s:sx = expand("<sfile>:p:r")."x.vim"
if file_readable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &so = s:so_save | let &siso = s:siso_save
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
