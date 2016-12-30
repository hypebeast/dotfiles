#!/usr/bin/env bash
#
# Install tmux-powerline from https://github.com/erikw/tmux-powerline
#

if [ ! -d ~/.dotfiles/libs ]; then
  mkdir -p ~/.dotfiles/libs
fi

cd ~/.dotfiles/libs

if [ ! -d "./tmux-powerline" ]; then
	git clone "https://github.com/erikw/tmux-powerline" "./tmux-powerline"
  cd "tmux-powerline"
else
	cd "tmux-powerline"
	git pull origin master
fi

exit 0
