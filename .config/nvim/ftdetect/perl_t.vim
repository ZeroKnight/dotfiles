" Read new *.t files as Perl5 test files
augroup filetypedetect
  autocmd BufRead,BufNewFile *.t set filetype=perl 
augroup END
