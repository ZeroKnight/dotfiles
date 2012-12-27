let SessionLoad = 1
if &cp | set nocp | endif
let s:so_save = &so | let s:siso_save = &siso | set so=0 siso=0
let v:this_session=expand("<sfile>:p")
silent only
cd ~/Documents/Coding/Projects/IRCBots/faqbot
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +120 ~/Documents/Coding/Projects/IRCBots/ZeroBot/src/config.cpp
badd +292 src/faqbot.cpp
badd +30 src/faqbot.hpp
badd +27 config.xml
badd +210 src/faqbot-irc.cpp
badd +35 Makefile
badd +44 Makefile.
badd +1 TODO
badd +2 data/help/help
badd +1 data/help/quit
badd +1 data/help/faq
badd +34 src/faqbot-util.hpp
silent! argdel *
winpos 0 292
edit -MiniBufExplorer-
set splitbelow splitright
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
1wincmd k
wincmd w
set nosplitbelow
set nosplitright
wincmd t
set winheight=1 winwidth=1
exe '1resize ' . ((&lines * 2 + 24) / 49)
exe '2resize ' . ((&lines * 6 + 24) / 49)
exe 'vert 2resize ' . ((&columns * 121 + 79) / 158)
exe '3resize ' . ((&lines * 18 + 24) / 49)
exe 'vert 3resize ' . ((&columns * 121 + 79) / 158)
exe '4resize ' . ((&lines * 16 + 24) / 49)
exe 'vert 4resize ' . ((&columns * 121 + 79) / 158)
exe '5resize ' . ((&lines * 1 + 24) / 49)
exe 'vert 5resize ' . ((&columns * 121 + 79) / 158)
exe '6resize ' . ((&lines * 22 + 24) / 49)
exe 'vert 6resize ' . ((&columns * 36 + 79) / 158)
exe '7resize ' . ((&lines * 21 + 24) / 49)
exe 'vert 7resize ' . ((&columns * 36 + 79) / 158)
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
let s:l = 1 - ((0 * winheight(0) + 1) / 2)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
1
normal! 058l
wincmd w
argglobal
edit data/help/faq
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 3 - ((2 * winheight(0) + 3) / 6)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
3
normal! 040l
wincmd w
argglobal
edit src/faqbot.hpp
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 84 - ((15 * winheight(0) + 9) / 18)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
84
normal! 014l
wincmd w
argglobal
edit src/faqbot-irc.cpp
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
67,86fold
56,89fold
173,204fold
245,250fold
252,263fold
56
normal! zo
67
normal! zo
56
normal! zc
let s:l = 212 - ((7 * winheight(0) + 8) / 16)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
212
normal! 043l
wincmd w
argglobal
edit Makefile
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 49 - ((0 * winheight(0) + 0) / 1)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
49
normal! 0
wincmd w
argglobal
edit TODO
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 11 - ((10 * winheight(0) + 11) / 22)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
11
normal! 0
wincmd w
argglobal
edit config.xml
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 10 - ((1 * winheight(0) + 10) / 21)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
10
let s:c = 22 - ((8 * winwidth(0) + 18) / 36)
if s:c > 0
  exe 'normal! 0' . s:c . 'lzs' . (22 - s:c) . 'l'
else
  normal! 022l
endif
wincmd w
4wincmd w
exe '1resize ' . ((&lines * 2 + 24) / 49)
exe '2resize ' . ((&lines * 6 + 24) / 49)
exe 'vert 2resize ' . ((&columns * 121 + 79) / 158)
exe '3resize ' . ((&lines * 18 + 24) / 49)
exe 'vert 3resize ' . ((&columns * 121 + 79) / 158)
exe '4resize ' . ((&lines * 16 + 24) / 49)
exe 'vert 4resize ' . ((&columns * 121 + 79) / 158)
exe '5resize ' . ((&lines * 1 + 24) / 49)
exe 'vert 5resize ' . ((&columns * 121 + 79) / 158)
exe '6resize ' . ((&lines * 22 + 24) / 49)
exe 'vert 6resize ' . ((&columns * 36 + 79) / 158)
exe '7resize ' . ((&lines * 21 + 24) / 49)
exe 'vert 7resize ' . ((&columns * 36 + 79) / 158)
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
