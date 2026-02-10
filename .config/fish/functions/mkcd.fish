function mkcd --wraps=mkdir --description 'Create a directory (if needed) and cd into it'
    argparse -N 1 -X 1 --unknown-arguments required -- $argv
    or return 1
    test -d $argv[1]; or command mkdir -vp $argv_opts $argv[1]
    test -d $argv[1]; and cd $argv[1]
end
