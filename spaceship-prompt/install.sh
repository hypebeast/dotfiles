#!/bin/bash
#
# Install spaceship-prompt from https://github.com/denysdovhan/spaceship-prompt
#

if [ ! -d "$ZSH_CUSTOM/themes/spaceship-prompt" ]; then
	echo $ZSH_CUSTOM
	git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt"
else
    cd "$ZSH_CUSTOM/themes/spaceship-prompt" || exit
    git pull origin master
fi

ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"

exit 0

