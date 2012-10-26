function chom() {
    # chown and chmod in one step
    args=("$@")

    if [ $# -eq 0 ]; then
        echo 'Usage: chom <user[:group]> <attr> <dir> ...'
        return 1
    fi

    for ((i=2; i<=($#-1); i++)); do
        echo "Changing attributes of: ${args[$i]}"
        chown ${args[0]} ${args[$i]}
        chmod ${args[1]} ${args[$i]}
    done

    return 0
}

function iplookup() {
    # grep through ~/.irssi/irclogs and return IP results

    grep -r $1 $HOME/.irssi/irclogs
}

function scrumpatch() {
    # Create a patch file(s) for each specified file
    # Diffs the dev src with the vanilla src

    args=("$@")

    if [ $# -lt 2 ]; then
        echo 'Usage: scrumpatch <patchdir> <file|dir> [ ... ]'
        return 1
    fi

    DIR='/home/zeroknight/Documents/Coding/scrumbleship'
    cd $DIR

    # Create patch dir if it doesn't exist
    if [ -d ${args[0]} ]; then
        md -p patches/${args[0]}
    fi
    for ((i=1; i<=($#-1); i++)); do
        echo "Patching '${args[$i]}' in 'patches/${args[0]}'"
        diff -u /games/scrumbleship/src/${args[$i]} src/${args[$i]} > \
            patches/${args[0]}/${args[$i]}.patch
    done

    return 0
}

function winep() {
    # Shortcut for starting Wine with a custom Winebottle

    args=("$@")

    # Use regular `wine` call if no prefix specified
    if [ $# -gt 1 ]; then
        wine ${args[0]}
    else
        env WINEPREFIX=~/.winebottles/${args[0]} wine ${args[1]}
    fi
}
