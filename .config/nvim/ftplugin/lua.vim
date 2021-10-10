" Lua filetype settings

setlocal tabstop=2 shiftwidth=2

" Make it easy to look up Neovim API functions
setlocal keywordprg=:help

map <buffer> <LocalLeader>x <Plug>(Luadev-Run)
nmap <buffer> <LocalLeader>xx <Plug>(Luadev-RunLine)
