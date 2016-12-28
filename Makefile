default: setup

bootstrap:
	./bootstrap.sh

setup:
	stow ack bin ctags git gpg hammerspoon tmux vim zsh

macos:
	./macOS/macos.sh

brew:
	./homebrew/brew.sh

cask:
	./homebrew/brew-cask.sh
