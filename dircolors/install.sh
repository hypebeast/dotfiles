#!/usr/bin/env bash
#
# Get the dircolors-solarized from https://github.com/seebi/dircolors-solarized
# to support colors for GNU ls when the Solarized color scheme is used with iTerm2.

if [ ! -d "$DOTFILES/libs" ]; then
  # Control will enter here if $DIRECTORY doesn't exist.
  mkdir "$DOTFILES/libs"
fi

git clone https://github.com/seebi/dircolors-solarized "$DOTFILES/libs/dircolors-solarized"