###
### Shortcuts
###

psg() {
    ps -fp $(pgrep $@)
}

vman() {
    vim -c "Man $* | only"

    if [ "$?" != 0 ]; then
        echo "No manual entry for $*"
    fi
}
