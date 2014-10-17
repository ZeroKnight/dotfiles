#!/bin/bash

# "Installer" for ZeroKnight's dotfiles
# Intended to be run via:
#   curl -L https://raw.github.com/ZeroKnight/dotfiles/master/install.sh | bash

dotfiles='dotfiles'

#files=$(git --git-dir="$dotfiles" ls-files | egrep -o '^[^/]+/?' | uniq)
DOTDIRS="\
.config
.oh-my-zsh/custom
.ssh
.vim"

DOTFILES="\
.conkyrc
.gvimrc
.tmux.conf
.vimrc
.xinitrc
.zlogin
.zprofile
.zshenv
.zshrc"

say() {
    echo "[--] $1"
}

warn() {
    echo "[!!] $1"
}

err() {
    echo "[**] $1"
}

cd $HOME

# Splash
echo
echo "*=================================*"
echo "| ZeroKnight's Dotfiles Installer |"
echo "*=================================*"
echo
sleep 1

# Clone dotfiles repo
if [[ -d $dotfiles && -d $dotfiles/.git ]]; then
    warn "$dotfiles already cloned! Skipping..."
elif [[ -d $dotfiles && ! -d $dotfiles/.git ]]; then
    err "'$dotfiles' directory exists, but is not a git repository. Aborting."
    exit 1
else
    say "Cloning ${dotfiles}..."
    hash git &>/dev/null && git clone git://github.com/ZeroKnight/dotfiles.git $dotfiles || {
        err 'git is not installed!'
        exit
    }
fi

# Install oh-my-zsh!
say "Installing oh-my-zsh!..."
git clone git://github.com/robbyrussell/oh-my-zsh.git .oh-my-zsh
rm -r .oh-my-zsh/custom

# Create symlinks, merging existing directories and backing up existing files
say "Symlinking files..."
for d in $DOTDIRS; do
    if [ -d $d ]; then
        warn "Merging '$d'"
        mv $d ${d}~
        ln -s $dotfiles/$d $d
        mv ${d}~/* $d
        rmdir ${d}~
    else
        ln -s $dotfiles/$d $d
    fi
done
for f in $DOTFILES; do
    if [ -e $f ]; then
        mv $f ${f}.nongit
        warn "$f backed up as ${f}.nongit"
    fi
    ln -s $dotfiles/$f $f
done

### Farewell! #####################
say "Dotfiles installation done!"
say "Don't forget to grab any required ssh keypairs!"
exit 0

