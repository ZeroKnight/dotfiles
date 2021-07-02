" nvim-telescope/telescope.nvim

if !exists('g:loaded_telescope')
  finish
endif

" Telescope Mappings
nnoremap <silent> <C-p>      <Cmd>Telescope buffers<CR>
nnoremap <silent> <Leader>ff <Cmd>Telescope find_files<CR>
nnoremap <silent> <Leader>fo <Cmd>Telescope oldfiles<CR>
nnoremap <silent> <Leader>fG <Cmd>Telescope live_grep<CR>
nnoremap <silent> <Leader>fh <Cmd>Telescope help_tags<CR>
nnoremap <silent> <Leader>fm <Cmd>Telescope man_pages<CR>
nnoremap <silent> <Leader>f: <Cmd>Telescope command_history<CR>
nnoremap <silent> <Leader>f/ <Cmd>Telescope search_history<CR>
nnoremap <silent> <Leader>ft <Cmd>Telescope treesitter<CR>

nnoremap <silent> <Leader>fgf <Cmd>Telescope git_files<CR>
nnoremap <silent> <Leader>fgc <Cmd>Telescope git_commits<CR>
nnoremap <silent> <Leader>fgC <Cmd>Telescope git_bcommits<CR>
nnoremap <silent> <Leader>fgb <Cmd>Telescope git_branches<CR>
nnoremap <silent> <Leader>fgs <Cmd>Telescope git_status<CR>
nnoremap <silent> <Leader>fgt <Cmd>Telescope git_stash<CR>

" Fuzzy search command history
cmap <expr> <C-t> getcmdtype() == ':' ? '<Plug>(TelescopeFuzzyCommandSearch)' : '<C-t>'

lua << EOF
require('telescope').setup {
  defaults = {
    prompt_prefix = '🔍 ',
    winblend = 13,
    mappings = {
      i = {
        ['<C-j>'] = 'move_selection_next',
        ['<C-k>'] = 'move_selection_previous'
      }
    }
  },
  pickers = {
    buffers = {
      sort_lastused = true,
      mappings = {
        i = {
          ['<M-d>'] = 'delete_buffer'
        },
        n = {
          ['<M-d>'] = 'delete_buffer'
        }
      }
    },
    search_history = {theme = 'dropdown'},
    colorscheme = {theme = 'dropdown'},
    vim_options = {theme = 'dropdown'}
  }
}
EOF

