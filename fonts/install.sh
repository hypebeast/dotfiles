#!/usr/bin/env bash
#
# Install various fonts
#

if [ ! -d ~/.dotfiles/libs ]; then
  mkdir -p ~/.dotfiles/libs
fi

cd ~/.dotfiles/libs

# Install fonts for powerline from https://github.com/powerline/fonts
if [ ! -d "./powerline-fonts" ]; then
	git clone "https://github.com/powerline/fonts" "./powerline-fonts"
    cd "powerline-fonts"
else
	cd "powerline-fonts"
	git pull origin master
fi

./install.sh

if [[ $(uname) == "Linux" ]]; then
    cd ~/.dotfiles/libs

    # Install siji fonts from https://github.com/stark/siji.git
    if [ ! -d "./siji" ]; then
        git clone "https://github.com/stark/siji.git" "./siji"
        cd "siji"
    else
        cd "siji"
        git pull origin master
    fi

    ./install.sh
fi

exit 0
