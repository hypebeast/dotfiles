#!/usr/bin/env bash

###############################################################################
## Install fonts
###############################################################################

ensure_libs_dir() {
    if [ ! -d ~/.dotfiles/libs ]; then
        mkdir -p ~/.dotfiles/libs
    fi
}

# Install fonts for powerline from https://github.com/powerline/fonts
install_powerline_fonts() {
    install_dir="powerline-fonts"

    if [ ! -d "${install_dir}" ]; then
        git clone "https://github.com/powerline/fonts" "${install_dir}"
    fi

    pushd "${install_dir}"

    git pull origin master
    ./install.sh

    popd
}

# Install siji fonts from https://github.com/stark/siji.git
install_siji_font() {
    install_dir="siji"

    if [[ $(uname) == "Linux" ]]; then
        if [ ! -d "${install_dir}" ]; then
            git clone "https://github.com/stark/siji.git" "${install_dir}"
        fi
    
        pushd "${install_dir}"
        
        git pull origin master
        ./install.sh

        popd
    fi
}

main() {
    pushd ~/.dotfiles/libs

    ensure_libs_dir
    install_powerline_fonts
    install_siji_font

    popd

    exit 0
}

main

# vim: set ts=4 sw=4 tw=0 et :
