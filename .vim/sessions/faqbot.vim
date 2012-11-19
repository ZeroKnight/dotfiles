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
badd +19 faq.xml
badd +120 ~/Documents/Coding/Projects/IRCBots/ZeroBot/src/config.cpp
badd +28 src/faqbot.cpp
badd +55 src/faqbot.hpp
badd +5 config.xml
badd +6 ~/.vim/snippets/_.snippets
badd +0 ~/.vim/snippets/c.snippets
badd +183 src/faqbot-irc.cpp
badd +1 Makefile
badd +44 Makefile.
silent! argdel *
winpos 0 183
edit src/faqbot.cpp
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
2wincmd k
wincmd w
wincmd w
wincmd w
set nosplitbelow
set nosplitright
wincmd t
set winheight=1 winwidth=1
exe 'vert 1resize ' . ((&columns * 31 + 85) / 171)
exe '2resize ' . ((&lines * 15 + 25) / 50)
exe 'vert 2resize ' . ((&columns * 95 + 85) / 171)
exe '3resize ' . ((&lines * 16 + 25) / 50)
exe 'vert 3resize ' . ((&columns * 95 + 85) / 171)
exe '4resize ' . ((&lines * 15 + 25) / 50)
exe 'vert 4resize ' . ((&columns * 95 + 85) / 171)
exe 'vert 5resize ' . ((&columns * 43 + 85) / 171)
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
setlocal fdl=1
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
36,43fold
54,60fold
81,106fold
70,107fold
66,108fold
115,122fold
54
normal! zc
66
normal! zo
70
normal! zo
let s:l = 108 - ((34 * winheight(0) + 7) / 15)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
108
normal! 04l
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
let s:l = 106 - ((15 * winheight(0) + 8) / 16)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
106
normal! 01l
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
let s:l = 34 - ((5 * winheight(0) + 7) / 15)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
34
normal! 0
wincmd w
argglobal
edit faq.xml
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 12 - ((10 * winheight(0) + 24) / 48)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
12
normal! 012l
wincmd w
4wincmd w
exe 'vert 1resize ' . ((&columns * 31 + 85) / 171)
exe '2resize ' . ((&lines * 15 + 25) / 50)
exe 'vert 2resize ' . ((&columns * 95 + 85) / 171)
exe '3resize ' . ((&lines * 16 + 25) / 50)
exe 'vert 3resize ' . ((&columns * 95 + 85) / 171)
exe '4resize ' . ((&lines * 15 + 25) / 50)
exe 'vert 4resize ' . ((&columns * 95 + 85) / 171)
exe 'vert 5resize ' . ((&columns * 43 + 85) / 171)
tabedit ~/.vim/snippets/c.snippets
set splitbelow splitright
set nosplitbelow
set nosplitright
wincmd t
set winheight=1 winwidth=1
argglobal
setlocal fdm=indent
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
3
normal! zo
38
normal! zo
50
normal! zo
50
normal! zc
56
normal! zo
57
normal! zo
59
normal! zo
64
normal! zo
65
normal! zo
68
normal! zo
71
normal! zo
72
normal! zo
76
normal! zo
78
normal! zo
82
normal! zo
84
normal! zo
88
normal! zo
90
normal! zo
94
normal! zo
96
normal! zo
97
normal! zo
102
normal! zo
105
normal! zo
108
normal! zo
110
normal! zo
108
normal! zc
117
normal! zo
123
normal! zo
125
normal! zo
129
normal! zo
131
normal! zo
137
normal! zo
146
normal! zo
149
normal! zo
let s:l = 97 - ((21 * winheight(0) + 24) / 48)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
97
normal! 04l
4wincmd w
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
