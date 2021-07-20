" folke/trouble.nvim

lua << EOF
if not packer_loaded('lsp-trouble.nvim') then
  return
end
EOF

nnoremap <Leader>xx <Cmd>TroubleToggle<CR>
nnoremap <Leader>xw <Cmd>Trouble lsp_workspace_diagnostics<CR>
nnoremap <Leader>xd <Cmd>Trouble lsp_document_diagnostics<CR>
nnoremap <Leader>xq <Cmd>Trouble quickfix<CR>
nnoremap <Leader>xl <Cmd>Trouble loclist<CR>

