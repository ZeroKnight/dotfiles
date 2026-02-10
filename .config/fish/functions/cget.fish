function cget --wraps='curl -fJOL --compressed' --description 'alias cget curl -fJOL --compressed'
    curl -fJOL --compressed $argv
end
