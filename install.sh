#!/bin/bash

# "Installer" for ZeroKnight's dotfiles
# Intended to be run via:
#   curl -L https://raw.github.com/ZeroKnight/dotfiles/master/install.sh | bash

DOTDIRS="\
.config/openbox
.config/tint2
.config/.oh-my-zsh/custom
.ssh
.vim
scripts"

DOTFILES="\
.config/compton.conf
.conkyrc
.gvimrc
.screenrc
.vimrc
.xinitrc
.zshrc
.zprofile"

# Splash
echo
echo "*=================================*"
echo "| ZeroKnight's Dotfiles Installer |"
echo "*=================================*"
echo
sleep 1

# Clone dotfiles repo
if [[ -d $HOME/dotfiles && -d $HOME/dotfiles/.git ]]; then
    echo "[!!] Dotfiles already cloned! Skipping..."
elif [[ -d $HOME/dotfiles && ! -d $HOME/dotfiles/.git ]]; then
    echo "[**] 'dotfiles' directory exists, but is not a git repository. Aborting."
    exit 1
else
    git clone git://github.com/ZeroKnight/dotfiles.git dotfiles
fi

# Initialize submodules
echo "[--] Initializing submodules..."
git --git-dir="dotfiles" submodule init
git --git-dir="dotfiles" submodule update

# Install oh-my-zsh!
echo "[--] Installing oh-my-zsh!..."
curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh

# Create symlinks in HOME, backing up existing files
echo "[--] Symlinking directories..."
for d in $DOTDIRS; do
    if [ -d $d ]; then
        mv $d ${d}.nongit
        echo "[!!] $d backed up as ${d}.nongit"
    fi
    ln -s $HOME/dotfiles/$d $HOME/$d
done

echo "[--] Symlinking files..."
for f in $DOTFILES; do
    if [ -e $f ]; then
        mv $f ${f}.nongit
        echo "[!!] $f backed up as ${f}.nongit"
    fi
    ln -s $HOME/dotfiles/$f $HOME/$f
done

### Farewell! #####################
echo "[--] Dotfiles installation done!"
echo "[--] Don't forget to grab the private keys!"
exit 0

