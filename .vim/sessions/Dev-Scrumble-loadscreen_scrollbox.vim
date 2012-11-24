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
badd +162 ~/Documents/Coding/scrumbleship/config/text/components
badd +19 ~/Documents/Coding/scrumbleship/config/language/english
badd +8 ~/Documents/Coding/scrumbleship/src/ScrumbleGui.c
badd +56 ~/Documents/Coding/scrumbleship/src/ScrumbleMaterials.c
badd +9 ~/Documents/Coding/scrumbleship/src/ScrumbleShipStorage.c
badd +5 ~/Documents/Coding/scrumbleship/src/ScrumbleParse.h
badd +10 ~/Documents/Coding/scrumbleship/src/ScrumbleSaves.c
badd +64 ~/Documents/Coding/scrumbleship/src/ScrumbleShipStorage.h
badd +1 ~/Documents/Coding/scrumbleship/ScrumbleSnippets
badd +1921 ~/Documents/Coding/scrumbleship/src/ScrumbleGui.c.old
badd +113 ~/Documents/Coding/scrumbleship/src/ScrumbleGui.h
badd +5 ~/Documents/Coding/scrumbleship/src/ScrumbleSaves.h
badd +385 ~/Documents/Coding/scrumbleship/src/ScrumbleClient.c
badd +13 ~/Documents/Coding/scrumbleship/src/ScrumbleOptions.h
badd +7 ~/Documents/Coding/scrumbleship/src/ScrumbleOptions.c
badd +0 ~/Documents/Coding/scrumbleship/src/ScrumbleInput.c
silent! argdel *
winpos 0 40
edit ~/Documents/Coding/scrumbleship/src/ScrumbleGui.h
set splitbelow splitright
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
3wincmd k
wincmd w
wincmd w
wincmd w
set nosplitbelow
set nosplitright
wincmd t
set winheight=1 winwidth=1
exe 'vert 1resize ' . ((&columns * 31 + 91) / 182)
exe '2resize ' . ((&lines * 7 + 27) / 54)
exe 'vert 2resize ' . ((&columns * 102 + 91) / 182)
exe '3resize ' . ((&lines * 14 + 27) / 54)
exe 'vert 3resize ' . ((&columns * 102 + 91) / 182)
exe '4resize ' . ((&lines * 17 + 27) / 54)
exe 'vert 4resize ' . ((&columns * 102 + 91) / 182)
exe '5resize ' . ((&lines * 11 + 27) / 54)
exe 'vert 5resize ' . ((&columns * 102 + 91) / 182)
exe '6resize ' . ((&lines * 14 + 27) / 54)
exe 'vert 6resize ' . ((&columns * 47 + 91) / 182)
exe '7resize ' . ((&lines * 15 + 27) / 54)
exe 'vert 7resize ' . ((&columns * 47 + 91) / 182)
exe '8resize ' . ((&lines * 13 + 27) / 54)
exe 'vert 8resize ' . ((&columns * 47 + 91) / 182)
exe '9resize ' . ((&lines * 7 + 27) / 54)
exe 'vert 9resize ' . ((&columns * 47 + 91) / 182)
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
let s:l = 62 - ((1 * winheight(0) + 3) / 7)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
62
normal! 018l
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
let s:l = 1873 - ((6 * winheight(0) + 7) / 14)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
1873
normal! 05l
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
let s:l = 1 - ((0 * winheight(0) + 8) / 17)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
1
normal! 040l
wincmd w
argglobal
edit ~/Documents/Coding/scrumbleship/src/ScrumbleInput.c
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 576 - ((4 * winheight(0) + 5) / 11)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
576
normal! 069l
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
let s:l = 1 - ((0 * winheight(0) + 7) / 14)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
1
normal! 0
wincmd w
argglobal
edit ~/Documents/Coding/scrumbleship/config/language/english
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 37 - ((0 * winheight(0) + 7) / 15)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
37
normal! 06l
wincmd w
argglobal
edit ~/Documents/Coding/scrumbleship/config/text/components
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 162 - ((7 * winheight(0) + 6) / 13)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
162
normal! 03l
wincmd w
argglobal
enew
file ~/Documents/Coding/scrumbleship/rotationref
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
wincmd w
3wincmd w
exe 'vert 1resize ' . ((&columns * 31 + 91) / 182)
exe '2resize ' . ((&lines * 7 + 27) / 54)
exe 'vert 2resize ' . ((&columns * 102 + 91) / 182)
exe '3resize ' . ((&lines * 14 + 27) / 54)
exe 'vert 3resize ' . ((&columns * 102 + 91) / 182)
exe '4resize ' . ((&lines * 17 + 27) / 54)
exe 'vert 4resize ' . ((&columns * 102 + 91) / 182)
exe '5resize ' . ((&lines * 11 + 27) / 54)
exe 'vert 5resize ' . ((&columns * 102 + 91) / 182)
exe '6resize ' . ((&lines * 14 + 27) / 54)
exe 'vert 6resize ' . ((&columns * 47 + 91) / 182)
exe '7resize ' . ((&lines * 15 + 27) / 54)
exe 'vert 7resize ' . ((&columns * 47 + 91) / 182)
exe '8resize ' . ((&lines * 13 + 27) / 54)
exe 'vert 8resize ' . ((&columns * 47 + 91) / 182)
exe '9resize ' . ((&lines * 7 + 27) / 54)
exe 'vert 9resize ' . ((&columns * 47 + 91) / 182)
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
