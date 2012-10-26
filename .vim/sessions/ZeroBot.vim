let SessionLoad = 1
if &cp | set nocp | endif
let s:so_save = &so | let s:siso_save = &siso | set so=0 siso=0
let v:this_session=expand("<sfile>:p")
silent only
cd ~/Documents/Coding/Projects/ZeroBot/src
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +34 zerobot.cpp
badd +1 config.cpp
badd +21 config.hpp
badd +8 zerobot.hpp
badd +131 ~/.vimrc
badd +17 ~/Documents/Coding/Projects/ZeroBot/data/chat.xml
badd +10 ~/Documents/Coding/Projects/ZeroBot/data/music.xml
badd +1 ~/Documents/Coding/Projects/ziblib/ziblib.h
badd +23 ~/Documents/Coding/Projects/ZeroBot/data/config.xml
badd +40 ../data/quotes.xml
silent! argdel *
winpos 0 31
edit ~/.vimprojects
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
set nosplitbelow
set nosplitright
wincmd t
set winheight=1 winwidth=1
exe 'vert 1resize ' . ((&columns * 24 + 135) / 271)
exe '2resize ' . ((&lines * 6 + 38) / 76)
exe 'vert 2resize ' . ((&columns * 185 + 135) / 271)
exe '3resize ' . ((&lines * 18 + 38) / 76)
exe 'vert 3resize ' . ((&columns * 185 + 135) / 271)
exe '4resize ' . ((&lines * 36 + 38) / 76)
exe 'vert 4resize ' . ((&columns * 185 + 135) / 271)
exe '5resize ' . ((&lines * 11 + 38) / 76)
exe 'vert 5resize ' . ((&columns * 185 + 135) / 271)
exe 'vert 6resize ' . ((&columns * 60 + 135) / 271)
argglobal
setlocal fdm=marker
setlocal fde=0
setlocal fmr={,}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
1
normal! zo
let s:l = 1 - ((0 * winheight(0) + 37) / 74)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
1
normal! 0
wincmd w
argglobal
edit zerobot.hpp
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 24 - ((1 * winheight(0) + 3) / 6)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
24
normal! 048l
wincmd w
argglobal
edit ~/Documents/Coding/Projects/ziblib/ziblib.h
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 241 - ((6 * winheight(0) + 9) / 18)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
241
normal! 034l
wincmd w
argglobal
edit config.cpp
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
92,138fold
143,159fold
161,171fold
173,186fold
let s:l = 140 - ((63 * winheight(0) + 18) / 36)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
140
normal! 065l
wincmd w
argglobal
edit config.hpp
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 30 - ((3 * winheight(0) + 5) / 11)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
30
normal! 011l
wincmd w
argglobal
edit ../data/quotes.xml
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 75 - ((54 * winheight(0) + 37) / 74)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
75
normal! 012l
wincmd w
6wincmd w
exe 'vert 1resize ' . ((&columns * 24 + 135) / 271)
exe '2resize ' . ((&lines * 6 + 38) / 76)
exe 'vert 2resize ' . ((&columns * 185 + 135) / 271)
exe '3resize ' . ((&lines * 18 + 38) / 76)
exe 'vert 3resize ' . ((&columns * 185 + 135) / 271)
exe '4resize ' . ((&lines * 36 + 38) / 76)
exe 'vert 4resize ' . ((&columns * 185 + 135) / 271)
exe '5resize ' . ((&lines * 11 + 38) / 76)
exe 'vert 5resize ' . ((&columns * 185 + 135) / 271)
exe 'vert 6resize ' . ((&columns * 60 + 135) / 271)
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
