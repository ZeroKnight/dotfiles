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
badd +162 ~/Documents/Coding/scrumbleship/config/text/components
badd +19 ~/Documents/Coding/scrumbleship/config/language/english
badd +2431 ~/Documents/Coding/scrumbleship/src/ScrumbleGui.c
badd +56 ~/Documents/Coding/scrumbleship/src/ScrumbleMaterials.c
badd +9 ~/Documents/Coding/scrumbleship/src/ScrumbleShipStorage.c
badd +5 ~/Documents/Coding/scrumbleship/src/ScrumbleParse.h
badd +33 ~/Documents/Coding/scrumbleship/src/ScrumbleSaves.c
badd +64 ~/Documents/Coding/scrumbleship/src/ScrumbleShipStorage.h
badd +0 ~/Documents/Coding/scrumbleship/ScrumbleSnippets
badd +1921 ~/Documents/Coding/scrumbleship/src/ScrumbleGui.c.old
badd +113 ~/Documents/Coding/scrumbleship/src/ScrumbleGui.h
badd +11 ~/Documents/Coding/scrumbleship/src/ScrumbleSaves.h
badd +58 ~/Documents/Coding/scrumbleship/src/ScrumbleClient.c
badd +13 ~/Documents/Coding/scrumbleship/src/ScrumbleOptions.h
badd +7 ~/Documents/Coding/scrumbleship/src/ScrumbleOptions.c
silent! argdel *
winpos 0 31
edit ~/Documents/Coding/scrumbleship/src/ScrumbleClient.c
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
exe 'vert 1resize ' . ((&columns * 31 + 96) / 192)
exe '2resize ' . ((&lines * 14 + 37) / 74)
exe 'vert 2resize ' . ((&columns * 109 + 96) / 192)
exe '3resize ' . ((&lines * 12 + 37) / 74)
exe 'vert 3resize ' . ((&columns * 109 + 96) / 192)
exe '4resize ' . ((&lines * 23 + 37) / 74)
exe 'vert 4resize ' . ((&columns * 109 + 96) / 192)
exe '5resize ' . ((&lines * 20 + 37) / 74)
exe 'vert 5resize ' . ((&columns * 109 + 96) / 192)
exe '6resize ' . ((&lines * 19 + 37) / 74)
exe 'vert 6resize ' . ((&columns * 50 + 96) / 192)
exe '7resize ' . ((&lines * 20 + 37) / 74)
exe 'vert 7resize ' . ((&columns * 50 + 96) / 192)
exe '8resize ' . ((&lines * 23 + 37) / 74)
exe 'vert 8resize ' . ((&columns * 50 + 96) / 192)
exe '9resize ' . ((&lines * 7 + 37) / 74)
exe 'vert 9resize ' . ((&columns * 50 + 96) / 192)
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
let s:l = 2874 - ((10 * winheight(0) + 7) / 14)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
2874
let s:c = 100 - ((95 * winwidth(0) + 54) / 109)
if s:c > 0
  exe 'normal! 0' . s:c . 'lzs' . (100 - s:c) . 'l'
else
  normal! 0100l
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
let s:l = 1822 - ((8 * winheight(0) + 6) / 12)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
1822
normal! 04l
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
let s:l = 3171 - ((14 * winheight(0) + 11) / 23)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
3171
let s:c = 46 - ((16 * winwidth(0) + 54) / 109)
if s:c > 0
  exe 'normal! 0' . s:c . 'lzs' . (46 - s:c) . 'l'
else
  normal! 046l
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
let s:l = 795 - ((13 * winheight(0) + 10) / 20)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
795
normal! 011l
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
let s:l = 13 - ((12 * winheight(0) + 9) / 19)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
13
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
let s:l = 37 - ((19 * winheight(0) + 10) / 20)
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
let s:l = 162 - ((12 * winheight(0) + 11) / 23)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
162
normal! 03l
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
let s:l = 1 - ((0 * winheight(0) + 3) / 7)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
1
normal! 08l
wincmd w
4wincmd w
exe 'vert 1resize ' . ((&columns * 31 + 96) / 192)
exe '2resize ' . ((&lines * 14 + 37) / 74)
exe 'vert 2resize ' . ((&columns * 109 + 96) / 192)
exe '3resize ' . ((&lines * 12 + 37) / 74)
exe 'vert 3resize ' . ((&columns * 109 + 96) / 192)
exe '4resize ' . ((&lines * 23 + 37) / 74)
exe 'vert 4resize ' . ((&columns * 109 + 96) / 192)
exe '5resize ' . ((&lines * 20 + 37) / 74)
exe 'vert 5resize ' . ((&columns * 109 + 96) / 192)
exe '6resize ' . ((&lines * 19 + 37) / 74)
exe 'vert 6resize ' . ((&columns * 50 + 96) / 192)
exe '7resize ' . ((&lines * 20 + 37) / 74)
exe 'vert 7resize ' . ((&columns * 50 + 96) / 192)
exe '8resize ' . ((&lines * 23 + 37) / 74)
exe 'vert 8resize ' . ((&columns * 50 + 96) / 192)
exe '9resize ' . ((&lines * 7 + 37) / 74)
exe 'vert 9resize ' . ((&columns * 50 + 96) / 192)
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
