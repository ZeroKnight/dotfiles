-- ZeroKnight's Plugin Mappings

local key = require('zeroknight.util.key')

-- moll/vim-bbye

key.nnoremap('<Leader>d', '<Cmd>Bdelete<CR>')

-- tpope/vim-commentary

key.nmap('gcy', 'yyPgccj')

-- tpope/vim-fugitive

key.nnoremap('<Leader>gs', '<Cmd>Git<CR>')

-- Yggdroot/indentLine

key.nnoremap('<Leader>ig', '<Cmd>IndentLinesToggle<CR>')

-- majutsushi/tagbar

key.nnoremap('<F4>', '<Cmd>TagbarToggle<CR>')
key.inoremap('<F4>', '<Cmd>TagbarToggle<CR>')

-- folke/trouble.nvim

key.nnoremap('<Leader>xx', '<Cmd>TroubleToggle<CR>')
key.nnoremap('<Leader>xw', '<Cmd>Trouble lsp_workspace_diagnostics<CR>')
key.nnoremap('<Leader>xd', '<Cmd>Trouble lsp_document_diagnostics<CR>')
key.nnoremap('<Leader>xq', '<Cmd>Trouble quickfix<CR>')
key.nnoremap('<Leader>xl', '<Cmd>Trouble loclist<CR>')
key.nnoremap('<Leader>xt', '<Cmd>TodoTrouble<CR>')

-- SirVer/ultisnips

-- Quick edit UltiSnips for current filetype
key.nnoremap('<Leader>ue', ':UltiSnipsEdit<CR>')

-- mbbill/undotree

key.nnoremap('<F5>', '<Cmd>UndotreeToggle<CR>')
key.inoremap('<F5>', '<Cmd>UndotreeToggle<CR>')
