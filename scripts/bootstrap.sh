#!/usr/bin/env bash

####
## This script bootstraps a new system. It installs all necessary packages
## required for the dotfiles.
##
## Note: Currently, only Mac OS is supported! Support for Linux will follow.
####

set -euo pipefail

DOTFILES="$HOME/.dotfiles"

source "$DOTFILES/scripts/functions.sh"

cd "$DOTFILES"

info "Prompting for sudo password..."
if sudo -v; then
    # Keep-alive: update existing `sudo` time stamp until `setup.sh` has finished
    while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
    success "Sudo credentials updated."
else
    error "Failed to obtain sudo credentials."
fi

info "Installing XCode command line tools..."
if xcode-select --print-path &>/dev/null; then
    success "XCode command line tools already installed."
elif xcode-select --install &>/dev/null; then
    success "Finished installing XCode command line tools."
else
    error "Failed to install XCode command line tools."
fi

info "Installing Rosetta..."
sudo softwareupdate --install-rosetta

# Package control must be executed first in order for the rest to work
info "Installing Brew..."
if ! which brew; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  success "Finished installing Brew"
fi

info "Installing Brew packages..."
brew bundle --file="$DOTFILES/packages/Brewfile"
success "Finished installing Brew packages"

# find * -name "setup.sh" -not -wholename "packages*" | while read setup; do
#     ./$setup
# done

success "Finished bootstraping your system."
info "Now go to your $DOTFILES and run ./scripts/install.fish"

# cd $DOTFILES

# # Install dotfiles
# fish ./scripts/install.fish

# success "Finished installing Dotfiles"