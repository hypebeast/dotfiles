#!/bin/user/env bash

####
## Based on CodelyTV/dotfiles
####

COMMON_DOTFILES=(
  ack
  ctags
  git
  tmux
  vim
  zsh
  fzf
  nnn
  nb
  mc
  jrnl
  ranger
  ripgrep
  pt
  pyenv
)

LINUX_DOTFILES=(
  i3
  i3status
  gtk
  X
  xfce-terminal
  dunst
  conky
  compton
  fonts
  polybar
)

MACOS_DOTFILES=(
  hammerspoon
)

self_update() {
  cd "$DOTFILES" || exit

  git fetch
  if [[ $(project_status) == "behind" ]]; then
    log::note "Needs to pull!"
    git pull && exit 0 || log::error "Failed"
  fi
}

update_submodules() {
  cd "$DOTFILES" || exit
  git pull
  git submodule init
  git submodule update
  git submodule status

  for submodule in "$DOTFILES/modules/"*; do git submodule update --init --recursive --remote --merge "$submodule"; done
}

apply_common_symlinks() {
  log::note "Hook our common dotfiles into system standard positions..."

  stow "${COMMON_DOTFILES[@]}"
}

apply_macos_symlinks() {
  log::note "Hook our MacOS dotfiles into system standard positions..."

  stow "${MACOS_DOTFILES[@]}"

  sudo ln -sf "$DOTFILES/mac/plist/limit.maxfiles.plist" "/Library/LaunchDaemons/limit.maxfiles.plist"
  sudo ln -sf "$DOTFILES/mac/plist/limit.maxproc.plist" "/Library/LaunchDaemons/limit.maxproc.plist"
  sudo chmod 644 "/Library/LaunchDaemons/limit.maxfiles.plist"
  sudo chmod 644 "/Library/LaunchDaemons/limit.maxproc.plist"
  sudo chown root:wheel /Library/LaunchDaemons/limit.maxfiles.plist
  sudo chown root:wheel /Library/LaunchDaemons/limit.maxproc.plist
  sudo launchctl load -w "/Library/LaunchDaemons/limit.maxfiles.plist"
  sudo launchctl load -w "/Library/LaunchDaemons/limit.maxproc.plist"
}

apply_linux_symlinks() {
  log::note "Hook our Linux dotfiles into system standard positions..."

  stow "${LINUX_DOTFILES[@]}"
}

project_status() {
  cd "$DOTFILES" || exit

  local -r UPSTREAM="master"
  local -r LOCAL=$(git rev-parse @)
  local -r REMOTE=$(git rev-parse "$UPSTREAM")
  local -r BASE=$(git merge-base @ "$UPSTREAM")

  if [[ "$LOCAL" == "$REMOTE" ]]; then
    echo "synced"
  elif [[ "$LOCAL" == "$BASE" ]]; then
    echo "behind"
  elif [[ "$REMOTE" == "$BASE" ]]; then
    echo "ahead"
  else
    echo "diverged"
  fi
}