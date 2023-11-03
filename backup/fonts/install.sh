#!/usr/bin/env bash

###############################################################################
## Install fonts
###############################################################################

source "$DOTFILES/scripts/core/_main.sh"

ensure_libs_dir() {
    if [ ! -d ~/.dotfiles/libs ]; then
        mkdir -p ~/.dotfiles/libs
    fi
}

# Install fonts for powerline from https://github.com/powerline/fonts
install_powerline_fonts() {
    local install_dir="powerline-fonts"

    if platform::is_macos; then
      exit 0
    fi

    if [ ! -d "${install_dir}" ]; then
        git clone "https://github.com/powerline/fonts" "${install_dir}"
    fi

    pushd "${install_dir}"

    git pull origin master
    ./install.sh

    popd
}

main() {
    pushd ~/.dotfiles/libs

    ensure_libs_dir
    install_powerline_fonts

    popd

    exit 0
}

main

# vim: set ts=4 sw=4 tw=0 et :
