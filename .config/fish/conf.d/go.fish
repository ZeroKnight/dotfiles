#
# Golang stuff
#

set -gx GOPATH $HOME/.local/opt/go

if test -d $GOPATH/bin
    # NOTE: appends to fish_user_paths, not PATH because --path isn't specified
    fish_add_path --global --append $GOPATH/bin
end
