function mkt --wraps=mktemp --description 'Create a temporary directory and cd into it'
    cd (mktemp -d $argv)
end
