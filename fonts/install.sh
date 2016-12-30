#!/usr/bin/env bash
#
# Install fonts for powerline from https://github.com/powerline/fonts
#

if [ ! -d ~/.dotfiles/libs ]; then
  mkdir -p ~/.dotfiles/libs
fi

cd ~/.dotfiles/libs

if [ ! -d "./powerline-fonts" ]; then
	git clone "https://github.com/powerline/fonts" "./powerline-fonts"
  cd "powerline-fonts"
else
	cd "powerline-fonts"
	git pull origin master
fi

./install.sh

exit 0
