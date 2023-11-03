#!/usr/bin/env bash

####
## Based on CodelyTV/dotfiles and denisidoro/dotfiles
####

platform::command_exists() {
  type "$1" &>/dev/null
}

platform::is_macos() {
  [[ $(uname -s) == "Darwin" ]]
}

platform::is_linux() {
  [[ $(uname -s) == "Linux" ]]
}