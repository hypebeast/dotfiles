#!/usr/bin/env bash
#
# Install powerline from https://github.com/powerline/powerline
#

if [ ! -d ~/.dotfiles/libs ]; then
  mkdir -p ~/.dotfiles/libs
fi

cd ~/.dotfiles/libs

if [ ! -d "./powerline" ]; then
    git clone "https://github.com/powerline/powerline.git" "./powerline"
    cd "powerline"
else
	cd "powerline"
	git pull origin master
fi

pip install --user --editable="$(pwd)"
ln -s "$(pwd)"/scripts/powerline ~/bin
ln -s "$(pwd)"/scripts/powerline-daemon ~/bin
ln -s "$(pwd)"/scripts/powerline-config ~/bin

exit 0
