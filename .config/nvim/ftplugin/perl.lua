-- Perl filetype settings

-- :Tabularize the fat-commas within a has declaration
vim.keymap.set('n', '<LocalLeader>th', [[<Cmd>Tabularize /=>( ()@!<CR>]], { buffer = true })
