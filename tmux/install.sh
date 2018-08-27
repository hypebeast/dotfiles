#!/usr/bin/env bash

###############################################################################
## Install tmux config from https://github.com/gpakosz/.tmux
###############################################################################

LIBS_DIR=~/.dotfiles/libs
INSTALL_DIR=./tmux

if [ ! -d $LIBS_DIR ]; then
  mkdir -p $LIBS_DIR
fi

cd $LIBS_DIR || exit 1

# Install fonts for powerline from https://github.com/powerline/fonts
if [ ! -d "${INSTALL_DIR}" ]; then
	git clone "https://github.com/gpakosz/.tmux" "${INSTALL_DIR}"
    cd "${INSTALL_DIR}" || exit 1
else
    cd "${INSTALL_DIR}" || exit 1
	git pull origin master
fi


ln -s -f "$(pwd)/.tmux.conf" ~/.tmux.conf

exit 0

# vim: set ts=4 sw=4 tw=0 et :
