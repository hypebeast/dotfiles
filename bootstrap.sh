#!/bin/sh

####
# Bootstrap script for dotfiles. This script performs the first time
# installation of dotfiles on a new machine.
#
# To manage your dotfile repo use rake and make changes to the Rakefile if
# necessary.
####

if [ ! -d "$HOME/.dotfiles" ]; then
    echo "Installing dotfiles for the first time..."
    git clone https://github.com/hypebeast/dotfiles.git "$HOME/.dotfiles"
    cd "$HOME/.dotfiles"
    rake install
else
    echo "dotfiles is already installed"
fi
