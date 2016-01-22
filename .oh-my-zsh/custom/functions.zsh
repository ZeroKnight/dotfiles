###
### Shortcuts
###

psg() {
    ps -fp $(pgrep $@)
}

# Shortcut to select which image to boot while rebooting
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

# Use Vim as our man page viewer with the help of a couple plugins and settings
vman() {
    vim -c "Man $* | only"

    if [ "$?" != 0 ]; then
        echo "No manual entry for $*"
    fi
}

# ptpb pastebin client shortcut
pb() { curl -F "c=@${1:--}" https://ptpb.pw/ }

# ptpb pastebin client shortcut with automatic url copy
pbx() {
    curl -sF "c=@${1:--}" -w "%{redirect_url}" 'https://ptpb.pw/?r=1' -o /dev/stderr | xsel -l /dev/null -b
}

pbdel() {
    curl -X DELETE "https://ptpb.pw/$1"
}

cget() {
    curl -fJOL --compressed "$@"
}

mkcd() {
    [[ -n $1 ]] || return 0
    [[ -d $1 ]] || mkdir -vp "$1"
    [[ -d $1 ]] && cd "$1"
}

mkcdt() {
    cd $(mktemp -d $@)
}

# Qucikly clone from Github
github() {
    for r in $@; do
        git clone https://github.com/$r
    done
}

