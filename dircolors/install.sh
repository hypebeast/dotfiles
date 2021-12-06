#!/usr/bin/env bash
#
# Get the dircolors-solarized from https://github.com/seebi/dircolors-solarized
# to support colors for GNU ls when the Solarized color scheme is used with iTerm2.
#

if [ ! -d ~/.dotfiles/libs ]; then
  mkdir -p ~/.dotfiles/libs
fi

pushd ~/.dotfiles/libs

if [ ! -d "./dircolors-solarized" ]; then
	git clone "https://github.com/seebi/dircolors-solarized" "./dircolors-solarized"
else
	pushd "dircolors-solarized"
	git pull origin master
	popd
fi

if [ ! -d "./dir_colors" ]; then
	git clone https://github.com/arcticicestudio/nord-dircolors.git "./dir_colors"
	ln -sr "$HOME/.dotfiles/libs/dir_colors/src/dir_colors" ~/.dir_colors
else
	pushd "dir_colors"
	git pull origin master
	popd
fi

popd

exit 0