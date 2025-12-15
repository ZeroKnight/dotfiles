#!/usr/bin/env -S just --justfile

src_dir := x'~/src'

default:
    @just --list

nvim_btype := 'RelWithDebInfo'

_nvim-clone:
    #!/bin/bash
    dir="{{ src_dir / 'neovim' }}"
    [ -d "$dir" ] || git clone --branch 'stable' 'https://github.com/neovim/neovim'

[group('nvim')]
[working-directory('../src/neovim')]
nvim-fetch: _nvim-clone
    git fetch --prune --force origin

[group('nvim')]
[working-directory('../src/neovim')]
nvim-build ref='nightly': nvim-fetch
    git checkout {{ ref }}
    [ -d '.deps' ] && make distclean
    make CMAKE_BUILD_TYPE={{ nvim_btype }}
    sudo make install

[group('nvim')]
[working-directory('../src/neovim')]
nvim-rebuild:
    make clean
    make
    sudo make install
