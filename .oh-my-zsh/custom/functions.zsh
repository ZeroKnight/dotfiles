###
### Shortcuts
###

psg() {
    ps -fp $(pgrep $@)
}

reboot() {
    local lin=0
    local win=2
    # TODO: Check privileges. Check for things like sudo groups where this
    # command is allowed to be used without root
    if [ $# -gt 0 ]; then
        case $1 in
            lin )
                sudo grub-reboot $lin
            ;;
            win )
                sudo grub-reboot $win
            ;;
            * )
                echo "Unknown boot target $1"
                exit 1
            ;;
        esac
    fi
    sudo reboot
}

vman() {
    vim -c "Man $* | only"

    if [ "$?" != 0 ]; then
        echo "No manual entry for $*"
    fi
}
