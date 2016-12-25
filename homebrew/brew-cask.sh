#!/usr/bin/env bash

# Install Caskroom
brew tap caskroom/cask

# Install packages
apps=(
    alfred
    dropbox
    firefox
    firefoxnightly
    google-chrome
    google-chrome-canary
    google-drive
    iterm2
    keka
    opera
    sublime-text
    virtualbox
    vlc
    atom
    keepassx
    spotify
    docker
)

brew cask install "${apps[@]}"

# Quick Look Plugins (https://github.com/sindresorhus/quick-look-plugins)
brew cask install qlcolorcode qlstephen qlmarkdown quicklook-json qlprettypatch quicklook-csv betterzipql webpquicklook suspicious-package && qlmanage -r
