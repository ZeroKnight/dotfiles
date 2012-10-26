function chom() {
    # chown and chmod in one step

    args=("$@")

    if [ $# -eq 0 ]; then
        echo 'Usage: chom <user[:group]> <attr> <dir> ...'
        return 1
    fi

    for ((i=2; i<=($#-1); i++)); do
        echo "Changing attributes of: ${args[$i]}"
        chown $1 ${args[$i]}
        chmod $2 ${args[$i]}
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
    if [ -d $1 ]; then
        md -p patches/$1
    fi
    for ((i=1; i<=($#-1); i++)); do
        echo "Patching '${args[$i]}' in 'patches/$1'"
        diff -u /games/scrumbleship/src/${args[$i]} src/${args[$i]} > \
            patches/$1/${args[$i]}.patch
    done

    return 0
}

function winep() {
    # Shortcut for starting Wine with a custom Winebottle

    # Use regular `wine` call if no prefix specified
    if [ $# -gt 1 ]; then
        wine $1
    else
        env WINEPREFIX=~/.winebottles/$1 wine $2
    fi
}

function findREcmd() {
    # Shortcut for finding out what a Red Eclipse command does via grep

    grep -rnC10 ".\?COMMAND.\?(.*, $1," /games/redeclipse/src
}
