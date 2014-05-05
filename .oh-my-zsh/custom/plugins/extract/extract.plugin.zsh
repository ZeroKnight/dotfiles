# Quick shortcut for extracting various archive types
# Original credit unknown, found here:
# http://justinlilly.com/dotfiles/zsh.html
# Modified by Alex "ZeroKnight" George for his dotfiles:
# http://github.com/ZeroKnight/dotfiles

extract () {
    if [[ $# < 1 ]]; then
        echo "Usage: $0 <files...>"
        return 2
    fi

    for f in $@; do
        if [ -f $1 ] ; then
            case $1 in
                *.tar.bz2)  tar xjf $1      ;;
                *.tar.gz)   tar xzf $1      ;;
                *.bz2)      bunzip2 $1      ;;
                *.rar)      unrar x $1      ;;
                *.gz)       gunzip $1       ;;
                *.tar)      tar xf $1       ;;
                *.tbz2)     tar xjf $1      ;;
                *.tgz)      tar xzf $1      ;;
                *.zip)      unzip $1        ;;
                *.Z)        uncompress $1   ;;
                *) # Fallback
                    case $(file -bi $1 | grep -Eo '(x-\w+(-\w+)?|zip)') in
                        x-bzip2)            tar xjf $1 || bunzip2 $1 ;;
                        x-gzip)             tar xzf $1 || gunzip $1 ;;
                        x-tar)              tar xf $1 ;;
                        x-rar-compressed)   unrar x $1 ;;
                        zip)                unzip $1 ;;
                        *)
                            echo "'$1' cannot be extracted via $0"
                            return 1
                        ;;
                    esac
            esac
        else
            echo "'$1' is not a valid file"
            return 3
        fi
    done
}

