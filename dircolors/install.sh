#!/usr/bin/env bash
#
# Get the dircolors-solarized from https://github.com/seebi/dircolors-solarized
# to support colors for GNU ls when the Solarized color scheme is used with iTerm2.
#

if [ ! -d ~/.dotfiles/libs ]; then
  mkdir -p ~/.dotfiles/libs
fi

cd ~/.dotfiles/libs

if [ ! -d "./dircolors-solarized" ]; then
	git clone "https://github.com/seebi/dircolors-solarized" "./dircolors-solarized"
else
	cd "dircolors-solarized"
	git pull origin master
fi
