#!/usr/bin/env bash

# Install Caskroom

echo "Installing Caskroom"

brew tap caskroom/cask

# Install packages
apps=(
    alfred
    dropbox
    firefox
    firefox-nightly
    google-chrome
    google-chrome-canary
    google-drive
    iterm2
    keka
    opera
    sublime-text3
    virtualbox
    vlc
    atom
    keepass-x
    spotify
)

echo "Installing Cask packages"

brew cask install "${apps[@]}"

# Quick Look Plugins (https://github.com/sindresorhus/quick-look-plugins)
brew cask install qlcolorcode qlstephen qlmarkdown quicklook-json qlprettypatch quicklook-csv betterzipql webpquicklook suspicious-package && qlmanage -r
