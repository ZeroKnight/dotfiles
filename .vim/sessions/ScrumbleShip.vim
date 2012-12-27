let SessionLoad = 1
if &cp | set nocp | endif
let s:so_save = &so | let s:siso_save = &siso | set so=0 siso=0
let v:this_session=expand("<sfile>:p")
silent only
cd ~/Documents/Coding/scrumbleship
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +1 rotationref
badd +3221 src/ScrumbleGui.c
badd +56 src/ScrumbleMaterials.c
badd +9 src/ScrumbleShipStorage.c
badd +5 src/ScrumbleParse.h
badd +470 src/ScrumbleSaves.c
badd +100 src/ScrumbleShipStorage.h
badd +1 ScrumbleSnippets
badd +78 src/ScrumbleGui.h
badd +12 src/ScrumbleSaves.h
badd +1343 src/ScrumbleClient.c
badd +13 src/ScrumbleOptions.h
badd +7 src/ScrumbleOptions.c
badd +111 /games/scrumbleship/config/language/english
badd +229 /games/scrumbleship/config/text/components
badd +0 /games/scrumbleship/config/text/materials
silent! argdel *
winpos 0 40
edit src/ScrumbleGui.c
set splitbelow splitright
wincmd _ | wincmd |
split
1wincmd k
wincmd w
wincmd _ | wincmd |
vsplit
wincmd _ | wincmd |
vsplit
2wincmd h
wincmd w
wincmd _ | wincmd |
split
wincmd _ | wincmd |
split
wincmd _ | wincmd |
split
3wincmd k
wincmd w
wincmd w
wincmd w
wincmd w
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
exe '1resize ' . ((&lines * 2 + 33) / 66)
exe '2resize ' . ((&lines * 61 + 33) / 66)
exe 'vert 2resize ' . ((&columns * 27 + 136) / 273)
exe '3resize ' . ((&lines * 18 + 33) / 66)
exe 'vert 3resize ' . ((&columns * 195 + 136) / 273)
exe '4resize ' . ((&lines * 16 + 33) / 66)
exe 'vert 4resize ' . ((&columns * 195 + 136) / 273)
exe '5resize ' . ((&lines * 10 + 33) / 66)
exe 'vert 5resize ' . ((&columns * 195 + 136) / 273)
exe '6resize ' . ((&lines * 14 + 33) / 66)
exe 'vert 6resize ' . ((&columns * 195 + 136) / 273)
exe '7resize ' . ((&lines * 8 + 33) / 66)
exe 'vert 7resize ' . ((&columns * 49 + 136) / 273)
exe '8resize ' . ((&lines * 10 + 33) / 66)
exe 'vert 8resize ' . ((&columns * 49 + 136) / 273)
exe '9resize ' . ((&lines * 9 + 33) / 66)
exe 'vert 9resize ' . ((&columns * 49 + 136) / 273)
exe '10resize ' . ((&lines * 23 + 33) / 66)
exe 'vert 10resize ' . ((&columns * 49 + 136) / 273)
exe '11resize ' . ((&lines * 7 + 33) / 66)
exe 'vert 11resize ' . ((&columns * 49 + 136) / 273)
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
file NERD_tree_1
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal nofen
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
let s:l = 2780 - ((3 * winheight(0) + 9) / 18)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
2780
normal! 032l
wincmd w
argglobal
edit src/ScrumbleGui.c
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 3223 - ((4 * winheight(0) + 8) / 16)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
3223
normal! 034l
wincmd w
argglobal
edit src/ScrumbleGui.c
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 1876 - ((8 * winheight(0) + 5) / 10)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
1876
normal! 060l
wincmd w
argglobal
edit src/ScrumbleOptions.h
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 20 - ((10 * winheight(0) + 7) / 14)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
20
normal! 036l
wincmd w
argglobal
edit ScrumbleSnippets
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 8 - ((2 * winheight(0) + 4) / 8)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
8
normal! 016l
wincmd w
argglobal
edit /games/scrumbleship/config/text/components
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 137 - ((4 * winheight(0) + 5) / 10)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
137
normal! 0
wincmd w
argglobal
edit /games/scrumbleship/config/text/materials
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 119 - ((4 * winheight(0) + 4) / 9)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
119
normal! 0
wincmd w
argglobal
edit /games/scrumbleship/config/language/english
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 111 - ((18 * winheight(0) + 11) / 23)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
111
normal! 08l
wincmd w
argglobal
edit rotationref
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 5 - ((4 * winheight(0) + 3) / 7)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
5
normal! 032l
wincmd w
4wincmd w
exe '1resize ' . ((&lines * 2 + 33) / 66)
exe '2resize ' . ((&lines * 61 + 33) / 66)
exe 'vert 2resize ' . ((&columns * 27 + 136) / 273)
exe '3resize ' . ((&lines * 18 + 33) / 66)
exe 'vert 3resize ' . ((&columns * 195 + 136) / 273)
exe '4resize ' . ((&lines * 16 + 33) / 66)
exe 'vert 4resize ' . ((&columns * 195 + 136) / 273)
exe '5resize ' . ((&lines * 10 + 33) / 66)
exe 'vert 5resize ' . ((&columns * 195 + 136) / 273)
exe '6resize ' . ((&lines * 14 + 33) / 66)
exe 'vert 6resize ' . ((&columns * 195 + 136) / 273)
exe '7resize ' . ((&lines * 8 + 33) / 66)
exe 'vert 7resize ' . ((&columns * 49 + 136) / 273)
exe '8resize ' . ((&lines * 10 + 33) / 66)
exe 'vert 8resize ' . ((&columns * 49 + 136) / 273)
exe '9resize ' . ((&lines * 9 + 33) / 66)
exe 'vert 9resize ' . ((&columns * 49 + 136) / 273)
exe '10resize ' . ((&lines * 23 + 33) / 66)
exe 'vert 10resize ' . ((&columns * 49 + 136) / 273)
exe '11resize ' . ((&lines * 7 + 33) / 66)
exe 'vert 11resize ' . ((&columns * 49 + 136) / 273)
tabnext 1
if exists('s:wipebuf')
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=1 shortmess=filnxtToO
let s:sx = expand("<sfile>:p:r")."x.vim"
if file_readable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &so = s:so_save | let &siso = s:siso_save
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
