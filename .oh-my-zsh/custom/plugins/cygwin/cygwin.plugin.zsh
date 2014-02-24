#
# Adds useful commands for working in my Cygwin environment
#

# Create truly Windows/Cygwin agnostic symlinks
# For more detail and explanation, see the following gist:
# https://gist.github.com/ZeroKnight/8975735
cyglink() {
    local switch target link
    if [[ $# < 2 ]]; then
        echo "Usage: cyglink [-hj] TARGET LINK"
        echo
        echo "--help\tDisplay this message"
        echo "-h\tCreate hard link instead of symbolic link"
        echo "-j\tCreate a directory junction"
        return 1
    elif [[ $# > 2 ]]; then
        switch="$1"
        switch[1]='/' # Convert to DOS-style switch
    fi
    target="$(cygpath -w ${@[-2]})"
    link="$(cygpath -w ${@[-1]})"

    # Eliminate the need to explicitly specify directory
    [ -d $target ] && switch+=' /d'

    # Payload with captured output
    # NOTE: --directory is ignored when used with --action=runas :(
    cygstart --action=runas \
    cmd.exe /c "cd /d $(cygpath -wa $PWD) & \
    mklink $switch $link $target \
    >$(cygpath -wa /tmp/out)"

    # Echo output of mklink
    cat /tmp/out
    rm /tmp/out
}
