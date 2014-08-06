#!/bin/sh

# This script installs some of the common dependencies needed (or at least desired)
# using Homebrew.

# Check for Homebrew
if test ! $(which brew)
then
  echo "  x You should probably install Homebrew first:"
  echo "    https://github.com/mxcl/homebrew/wiki/installation"
  exit
fi

# Install homebrew packages
brew install grc coreutils spark fasd curl ctags tmux unrar the_silver_searcher ack tree htop ack
brew install macvim --custom-icons --override-system-vim --with-lua --with-luajit

exit 0
