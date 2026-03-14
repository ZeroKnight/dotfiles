#!/usr/bin/env -S just --justfile

mod ansible
mod nvim

@default:
    just --list
    just --list ansible --list-heading '{{ "ansible recipes:\n" }}'
    just --list nvim --list-heading '{{ "nvim recipes:\n" }}'

dotfiles: (ansible::bootstrap '' 'dotfiles')
