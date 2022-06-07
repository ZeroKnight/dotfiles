-- Man filetype settings

local format = string.format

-- These maps should be recursive so that it actually performs the rhs mapping
-- set by man.vim
vim.keymap.set('n', '<CR>', '<C-]>', { buffer = true, remap = true })
vim.keymap.set('n', '<BS>', '<C-T>', { buffer = true, remap = true })

-- From bruno-/vim-man, with some edits
local sid = vim.api.nvim_exec(
  [[
  function! s:move_to_section(direction, mode, count) abort
    norm! m'
    if a:mode ==# 'v'
      norm! gv
    endif
    let l:i = 0
    while l:i < a:count
      let l:i += 1
      call search('^\%( \{3\}\)\=\S.*$', 'W'.a:direction)
    endwhile
  endfunction
  echo expand('<SID>')
]],
  true
)

-- Jump between sections
vim.keymap.set(
  'n',
  '[[',
  format([[<Cmd>call %smove_to_section('b', 'n', v:count1)<CR>]], sid),
  { buffer = true, silent = true }
)
vim.keymap.set(
  'n',
  ']]',
  format([[<Cmd>call %smove_to_section('' , 'n', v:count1)<CR>]], sid),
  { buffer = true, silent = true }
)
vim.keymap.set(
  'x',
  '[[',
  format([[<Cmd>call %smove_to_section('b', 'v', v:count1)<CR>]], sid),
  { buffer = true, silent = true }
)
vim.keymap.set(
  'x',
  ']]',
  format([[<Cmd>call %smove_to_section('' , 'v', v:count1)<CR>]], sid),
  { buffer = true, silent = true }
)

-- Search that matches at the first non-whitespace character of a line. Useful
-- for searching for options or sub-command names
vim.keymap.set('n', 'g/', [[/^\s*\zs]], { buffer = true, silent = true })
