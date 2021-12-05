#!/usr/bin/env bash
# This file:
#
#  - Setup script that bootstraps a dev machine for use with these dotfiles.
#  - Installs additional configs and tools.
#
# Usage:
#
#  ./setup.sh [command]
#
# The MIT License (MIT)
# Copyright (c) 2016 Sebastian Ruml, <sebastian@sebastianruml.name>


# Source some util functions
source ./utils.sh


# Dotfiles to link

declare -a DOTFILES

COMMON_DOTFILES=(
  ack
  bin
  ctags
  git
  tmux
  vim
  zsh
  fzf
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
)

MACOS_DOTFILES=(
  hammerspoon
)

if is_macos; then
    DOTFILES=("${COMMON_DOTFILES}" "${MACOS_DOTFILES}")
else
    DOTFILES=("${COMMON_DOTFILES}" "${MACOS_DOTFILES}")
fi


###########################################################
# Usage and help text
###########################################################

read -r -d '' __usage <<-'EOF' || true
  link             Link all dotfiles to its places (default command)
  bootstrap         Boostrap and prepare the dev machine
  -h --help        Show this help
EOF

read -r -d '' __helptext <<-'EOF' || true
  This script bootstraps a dev machine and installs required applications and tools.
  It provides commands to install various tools and configs which can't be installed
  through stow.
EOF


###########################################################
# Setup/Install functions
###########################################################

# Boostrap the machine
function bootstrap () {
  info "Welcome."
  info "Installing all required programs, tools and frameworks."
  info "Please, be patient. This could take several minutes."

  # Install required packages
  if is_macos; then
    install_homebrew
  else
    install_apt_packages
  fi

  install_ohmyzsh
  install_spf13vim
  install_zshplugins

  is_macos && macos

  # Link all dotfiles
  info "Linking all dotfiles..."

  link

  info "Done!"

  exit 0
}


# Hook our dotfiles into system standard positions.
function link () {
  info "Hook our dotfiles into system standard positions..."

  stow "${DOTFILES[@]}"

  info "Done!"
}

# Install brew and cask packages
function install_homebrew () {
  info "Installing Homebrew... If it's already installed, this will do nothing."

  if ! which brew; then
    curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install | ruby
  fi

  info "Installing brew packages..."

  ./homebrew/brew.sh

  info "Installing cask packages..."

  ./homebrew/brew-cask.sh
}

# TODO: Implement it!
function install_apt_packages () {
  info "Installing packages with apt..."
}

# Install oh-my-zsh
function install_ohmyzsh () {
  info "Installing oh-my-zsh, the open source, community-driven"
  info "framework for managing your ZSH configuration..."
  info "If it's already installed, this will do nothing."

  if [[ ! -d ~/.oh-my-zsh ]]; then
    info "It looks like that oh-my-zsh is already installed."
  else
    curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
  fi
}

# Install spf13-vim
function install_spf13vim () {
    info "Installing spf13-vim, the ultimate vim distribution..."
    info "If it's already installed, this will do nothing."

    if [[ ! -d ~/.spf13-vim ]]; then
      info "It looks like that spf13-vim is already installed."
    else
      curl http://j.mp/spf13-vim3 -L -o - | sh
    fi
}

# Install additional zsh plugins
function install_zshplugins () {
    info "Installing some more zsh plugins..."

    local ZSH_PLUGINS=(
      https://github.com/zsh-users/zsh-syntax-highlighting.git
      https://github.com/zsh-users/zsh-autosuggestions.git
    )

    if [[ ! -d ~/.oh-my-zsh ]]; then
      info "It looks like that oh-my-zsh is not installed."
    else
      cd ~/.oh-my-zsh/custom/plugins

      for plugin in ${ZSH_PLUGINS[@]}; do
        plugin_name=$(basename ${plugin} | sed 's/.git//')
        info "Installing/Updating zsh plugin ${plugin_name}..."

        if [[ ! -d ${plugin_name} ]]; then
          git clone ${plugin}
        else
          cd ${plugin_name}; git pull origin master; cd ..
        fi
      done
    fi
}

# Run all installer scripts
function run_installers () {
  for installer in $(find . -type f -name 'install.sh'); do
    bash ${installer}
  done
}

# Run the given installer
function run_installer () {
   if [[ $# -ne 1 ]]; then
     error "You must specify the name of the folder where the installer script is located!"
     exit 1
   fi

   local folder=${1}

   if [[ ! -d ${folder} ]]; then
     error "Specified installer does not exist!"
     exit 1
   fi

   info "Running installer \"${folder}\\install.sh\"..."

   cd ${folder}; bash install.sh
}

# Set sensible macOS defaults
function macos () {
  ./macOS/macos.sh
}


# Process command line arguments
##########################################################

# default is the link command
if [[ "$#" -eq 0 ]]; then
  cmd="link"
else
  cmd="${1}"
fi

case "${cmd}" in
  bootstrap )
    bootstrap
    ;;
  link )
    link
    ;;
  zshplugins )
    install_zshplugins
    ;;
  install_all )
    run_installers
    ;;
  install )
    run_installer ${2:-}
    ;;
  macos )
    macos
    ;;
  brew )
    install_homebrew
    ;;
  apt )
    install_apt_packages
    ;;
  *)
    help "Help using ${0}"
    ;;
esac

exit 0
