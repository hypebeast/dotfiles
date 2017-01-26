#!/usr/bin/env bash

###################################################################
# Install fzf from https://github.com/junegunn/fz://github.com/junegunn/fzf
###################################################################


INSTALL_DIR=./fzf

if [ ! -d ~/.dotfiles/libs ]; then
  mkdir -p ~/.dotfiles/libs
fi

cd ~/.dotfiles/libs

if [ ! -d "$INSTALL_DIR" ]; then
    git clone --depth 1 https://github.com/junegunn/fzf.git "$INSTALL_DIR"
  cd "$INSTALL_DIR"
else
	cd "$INSTALL_DIR"
	git pull origin master
fi

# run the installer
./install

exit 0
