function vhelp --description 'Open a vim help page'
    $vim_flavor -c ":h $argv[1] | only"
end
