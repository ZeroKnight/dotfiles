" Vim color scheme
"
" Original theme: zerocasts
" Personal color modifications by ZeroKnight

set background=dark
hi clear
if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "zerocasts"

hi link htmlTag                     xmlTag
hi link htmlTagName                 xmlTagName
hi link htmlEndTag                  xmlEndTag

highlight Normal                    guifg=#E6E1DC guibg=#111111 

highlight Comment                   guifg=#00FF00 ctermfg=180 gui=italic
highlight Constant                  guifg=#E65C00 ctermfg=73
highlight Define                    guifg=#CC7833 ctermfg=173
highlight Error                     guifg=#FFC66D ctermfg=221 guibg=#990000 ctermbg=88
highlight Function                  guifg=#FFC66D ctermfg=221 gui=NONE cterm=NONE
highlight Identifier                guifg=#6D9CBE ctermfg=73 gui=NONE cterm=NONE
highlight Include                   guifg=#CC7833 ctermfg=173 gui=NONE cterm=NONE
highlight PreCondit                 guifg=#CC7833 ctermfg=173 gui=NONE cterm=NONE
highlight Keyword                   guifg=#A347FF ctermfg=173 cterm=NONE
highlight LineNr                    guifg=#767676 ctermfg=159 guibg=#1A1A1A
highlight Number                    guifg=#CCCC00 ctermfg=107
highlight PreProc                   guifg=#CC7833 ctermfg=103
highlight Search                    guifg=NONE ctermfg=NONE guibg=#2b2b2b ctermbg=235 gui=italic cterm=underline
highlight Statement                 guifg=#A347FF ctermfg=173 gui=NONE cterm=NONE
highlight String                    guifg=#00CC66 ctermfg=107
highlight Title                     guifg=#FFFFFF ctermfg=15
highlight Type                      guifg=#4069E6 ctermfg=167 gui=NONE cterm=NONE
highlight Visual                    guibg=#5A647E ctermbg=60
highlight Macro                     guifg=#CC7833

highlight DiffAdd                   guifg=#E6E1DC ctermfg=7 guibg=#519F50 ctermbg=71
highlight DiffDelete                guifg=#E6E1DC ctermfg=7 guibg=#660000 ctermbg=52
highlight Special                   guifg=#DA4939 ctermfg=167 

highlight pythonBuiltin             guifg=#6D9CBE ctermfg=73 gui=NONE cterm=NONE
highlight rubyBlockParameter        guifg=#FFFFFF ctermfg=15
highlight rubyClass                 guifg=#FFFFFF ctermfg=15
highlight rubyConstant              guifg=#DA4939 ctermfg=167
highlight rubyInstanceVariable      guifg=#D0D0FF ctermfg=189
highlight rubyInterpolation         guifg=#519F50 ctermfg=107
highlight rubyLocalVariableOrMethod guifg=#D0D0FF ctermfg=189
highlight rubyPredefinedConstant    guifg=#DA4939 ctermfg=167
highlight rubyPseudoVariable        guifg=#FFC66D ctermfg=221
highlight rubyStringDelimiter       guifg=#A5C261 ctermfg=143

highlight xmlTag                    guifg=#E8BF6A ctermfg=179
highlight xmlTagName                guifg=#E8BF6A ctermfg=179
highlight xmlEndTag                 guifg=#E8BF6A ctermfg=179

highlight mailSubject               guifg=#A5C261 ctermfg=107
highlight mailHeaderKey             guifg=#FFC66D ctermfg=221
highlight mailEmail                 guifg=#A5C261 ctermfg=107 gui=italic cterm=underline

highlight SpellBad                  guifg=#D70000 ctermfg=160 ctermbg=NONE cterm=underline
highlight SpellRare                 guifg=#D75F87 ctermfg=168 guibg=NONE ctermbg=NONE gui=underline cterm=underline
highlight SpellCap                  guifg=#D0D0FF ctermfg=189 guibg=NONE ctermbg=NONE gui=underline cterm=underline
highlight MatchParen                guifg=#FFFFFF ctermfg=15 guibg=#005f5f ctermbg=23
