nvim_src := x'~/src/neovim'
nvim_btype := 'RelWithDebInfo'

set working-directory := nvim_src

_clone:
    [ -d '{{ nvim_src }}' ] || git clone --branch 'stable' 'https://github.com/neovim/neovim' '{{ nvim_src }}'

fetch: _clone
    git fetch --prune --force origin

build ref='nightly': fetch
    git checkout {{ ref }}
    [ -d '.deps' ] && make distclean
    make CMAKE_BUILD_TYPE={{ nvim_btype }}
    sudo make install

rebuild:
    make clean
    make
    sudo make install
