#!/bin/user/env bash

####
## Based on CodelyTV/dotfiles
####

# Install spf13-vim
install_spf13vim() {
    if [[ ! -d ~/.spf13-vim ]]; then
      log::note "It looks like that spf13-vim is already installed."
    else
      curl http://j.mp/spf13-vim3 -L -o - | sh
    fi
}

# Install additional zsh plugins
install_zshplugins() {
    local ZSH_PLUGINS=(
      https://github.com/zsh-users/zsh-syntax-highlighting.git
      https://github.com/zsh-users/zsh-autosuggestions.git
    )

    if [[ ! -d ~/.oh-my-zsh ]]; then
      log::note "It looks like that oh-my-zsh is not installed."
    else
      cd ~/.oh-my-zsh/custom/plugins

      for plugin in ${ZSH_PLUGINS[@]}; do
        plugin_name=$(basename ${plugin} | sed 's/.git//')
        log::note "Installing/Updating zsh plugin ${plugin_name}..."

        if [[ ! -d ${plugin_name} ]]; then
          git clone ${plugin}
        else
          cd ${plugin_name}; git pull origin master; cd ..
        fi
      done
    fi
}

install_macos_custom() {
  echo "Installing Rosetta 2"
  /usr/sbin/softwareupdate --install-rosetta --agree-to-license

  echo "Installing Command Line Developer Tools if not installed"
  if ! [ -d /Library/Developer/CommandLineTools ]; then
    echo "🙏 Please, click on Install & Agree to accept the Command Line Developer Tools License Agreement"
    sleep 1
    xcode-select --install
    read -rp "👀 Press enter once the installation finishes" not_needed_param
  else
    echo "✅ Command Line Developer Tools are already installed!"
  fi

  echo "⚡️ Installing brew if not installed"
  if ! [ -x "$(command -v brew)" ]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  fi

  echo "📦 Installing brew apps"
  # All apps (This line is repeated because there are dependencies between brew cask and brew)
  brew bundle --file="$DOTFILES/mac/brew/Brewfile" || true

  echo "😅 Installing brew apps again because it might fail the first time because of dependencies."
  echo "☝️ Check in MacOS Security & Privacy settings if MacOS is not allowing to install any third party software"
  brew bundle --file="$DOTFILES/mac/brew/Brewfile"

  # Switch to using brew-installed bash as default shell
  if ! fgrep -q '/usr/local/bin/bash' /etc/shells; then
    echo '/usr/local/bin/bash' | sudo tee -a /etc/shells;
    chsh -s /usr/local/bin/bash;
  fi;

  echo "🧐 Fixing paths in order to handle all with \$PATH"
  sudo truncate -s 0 /etc/paths

  echo "🍎 Applying custom MacOS defaults"
  sh "$DOTFILES/mac/macos.sh"
}

install_linux_custom() {
  echo "Linux support not added yet."
}