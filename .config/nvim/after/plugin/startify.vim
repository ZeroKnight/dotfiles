" mhinz/vim-startify

if !exists('g:loaded_startify')
  finish
endif

let g:startify_change_to_vcs_root = 1
let g:startify_restore_position = 1
let g:startify_session_dir = $VIMSESSIONS

lua <<EOF
vim.g.startify_list_order = {
  {'=== Recent files:'}, 'files',
  {'=== Last modified files in: ' .. vim.fn.getcwd()}, 'dir',
  {'=== Sessions:'}, 'sessions',
  {'=== Bookmarks:'}, 'bookmarks',
}

vim.g.startify_bookmarks = {
  as_stdpath('config', 'init.lua'), 
  as_stdpath('config', 'lua/zeroknight/plugins.lua'),
  as_stdpath('config', 'lua/zeroknight/lsp/init.lua')
}

vim.g.startify_skiplist = {
  'COMMIT_EDITMSG',
  vim.env.VIMRUNTIME .. '/doc',
  as_stdpath('data', 'site/pack/packer/.*/doc')
}
EOF

if v:lua.packer_loaded('nvim-web-devicons')
  function! StartifyEntryFormat()
    let chunks = [
      \ "luaeval(\"",
      \   "string.format('%s  %s', require('nvim-web-devicons').get_icon(_A[1]), _A[2])",
      \ "\", [fnamemodify(absolute_path, ':e'), entry_path])",
      \ ]
    return join(chunks, '')
  endfunction
endif

function! s:PrettyVersion()
  let l:major = v:version / 100
  let l:minor = v:version - (l:major * 100)
  return l:major . '.' . l:minor
endfunction

let g:startify_custom_header = [
  \ '  ____   ____.__         ',
  \ '  \   \ /   /|__| _____  ',
  \ '   \   Y   / |  |/     \ ',
  \ '    \     /  |  |  Y Y  \',
  \ '     \___/   |__|__|_|  /  ' . s:PrettyVersion(),
  \ '                      \/ ',
  \ '',
  \ ] + map(split(system('fortune'), '\n'), '"   ". v:val') + ['']

hi! link StartifySpecial Comment
hi! link StartifyFile Constant
hi! link StartifyHeader Statement
hi! link StartifyFooter Statement

