let SessionLoad = 1
if &cp | set nocp | endif
let s:so_save = &so | let s:siso_save = &siso | set so=0 siso=0
let v:this_session=expand("<sfile>:p")
silent only
cd ~/Documents/Coding/Projects
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +1 ~/Documents/Coding/scrumbleship/rotationref
badd +4 ~/Documents/Coding/scrumbleship/src/ScrumbleGui.c
badd +56 ~/Documents/Coding/scrumbleship/src/ScrumbleMaterials.c
badd +9 ~/Documents/Coding/scrumbleship/src/ScrumbleShipStorage.c
badd +5 ~/Documents/Coding/scrumbleship/src/ScrumbleParse.h
badd +33 ~/Documents/Coding/scrumbleship/src/ScrumbleSaves.c
badd +64 ~/Documents/Coding/scrumbleship/src/ScrumbleShipStorage.h
badd +1 ~/Documents/Coding/scrumbleship/ScrumbleSnippets
badd +69 ~/Documents/Coding/scrumbleship/src/ScrumbleGui.h
badd +12 ~/Documents/Coding/scrumbleship/src/ScrumbleSaves.h
badd +1343 ~/Documents/Coding/scrumbleship/src/ScrumbleClient.c
badd +13 ~/Documents/Coding/scrumbleship/src/ScrumbleOptions.h
badd +7 ~/Documents/Coding/scrumbleship/src/ScrumbleOptions.c
badd +100 /games/scrumbleship/config/language/english
badd +5 /games/scrumbleship/config/text/components
silent! argdel *
winpos 0 40
edit ~/Documents/Coding/scrumbleship/src/ScrumbleGui.c
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
wincmd _ | wincmd |
split
1wincmd k
wincmd w
wincmd _ | wincmd |
vsplit
1wincmd h
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
3wincmd k
wincmd w
wincmd w
wincmd w
set nosplitbelow
set nosplitright
wincmd t
set winheight=1 winwidth=1
exe 'vert 1resize ' . ((&columns * 31 + 84) / 169)
exe '2resize ' . ((&lines * 3 + 28) / 56)
exe 'vert 2resize ' . ((&columns * 137 + 84) / 169)
exe '3resize ' . ((&lines * 16 + 28) / 56)
exe 'vert 3resize ' . ((&columns * 87 + 84) / 169)
exe '4resize ' . ((&lines * 8 + 28) / 56)
exe 'vert 4resize ' . ((&columns * 87 + 84) / 169)
exe '5resize ' . ((&lines * 17 + 28) / 56)
exe 'vert 5resize ' . ((&columns * 87 + 84) / 169)
exe '6resize ' . ((&lines * 6 + 28) / 56)
exe 'vert 6resize ' . ((&columns * 87 + 84) / 169)
exe '7resize ' . ((&lines * 10 + 28) / 56)
exe 'vert 7resize ' . ((&columns * 49 + 84) / 169)
exe '8resize ' . ((&lines * 13 + 28) / 56)
exe 'vert 8resize ' . ((&columns * 49 + 84) / 169)
exe '9resize ' . ((&lines * 14 + 28) / 56)
exe 'vert 9resize ' . ((&columns * 49 + 84) / 169)
exe '10resize ' . ((&lines * 10 + 28) / 56)
exe 'vert 10resize ' . ((&columns * 49 + 84) / 169)
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
let s:l = 1878 - ((6 * winheight(0) + 8) / 16)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
1878
let s:c = 70 - ((24 * winwidth(0) + 43) / 87)
if s:c > 0
  exe 'normal! 0' . s:c . 'lzs' . (70 - s:c) . 'l'
else
  normal! 070l
endif
wincmd w
argglobal
edit ~/Documents/Coding/scrumbleship/src/ScrumbleGui.c
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 3170 - ((1 * winheight(0) + 4) / 8)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
3170
normal! 055l
wincmd w
argglobal
edit ~/Documents/Coding/scrumbleship/src/ScrumbleGui.c
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 786 - ((3 * winheight(0) + 8) / 17)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
786
normal! 025l
wincmd w
argglobal
edit ~/Documents/Coding/scrumbleship/ScrumbleSnippets
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 13 - ((4 * winheight(0) + 3) / 6)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
13
normal! 0
wincmd w
argglobal
edit ~/Documents/Coding/scrumbleship/ScrumbleSnippets
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 9 - ((6 * winheight(0) + 5) / 10)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
9
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
let s:l = 101 - ((5 * winheight(0) + 6) / 13)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
101
normal! 014l
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
let s:l = 116 - ((9 * winheight(0) + 7) / 14)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
116
normal! 08l
wincmd w
argglobal
edit ~/Documents/Coding/scrumbleship/rotationref
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 1 - ((0 * winheight(0) + 5) / 10)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
1
normal! 08l
wincmd w
3wincmd w
exe 'vert 1resize ' . ((&columns * 31 + 84) / 169)
exe '2resize ' . ((&lines * 3 + 28) / 56)
exe 'vert 2resize ' . ((&columns * 137 + 84) / 169)
exe '3resize ' . ((&lines * 16 + 28) / 56)
exe 'vert 3resize ' . ((&columns * 87 + 84) / 169)
exe '4resize ' . ((&lines * 8 + 28) / 56)
exe 'vert 4resize ' . ((&columns * 87 + 84) / 169)
exe '5resize ' . ((&lines * 17 + 28) / 56)
exe 'vert 5resize ' . ((&columns * 87 + 84) / 169)
exe '6resize ' . ((&lines * 6 + 28) / 56)
exe 'vert 6resize ' . ((&columns * 87 + 84) / 169)
exe '7resize ' . ((&lines * 10 + 28) / 56)
exe 'vert 7resize ' . ((&columns * 49 + 84) / 169)
exe '8resize ' . ((&lines * 13 + 28) / 56)
exe 'vert 8resize ' . ((&columns * 49 + 84) / 169)
exe '9resize ' . ((&lines * 14 + 28) / 56)
exe 'vert 9resize ' . ((&columns * 49 + 84) / 169)
exe '10resize ' . ((&lines * 10 + 28) / 56)
exe 'vert 10resize ' . ((&columns * 49 + 84) / 169)
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
