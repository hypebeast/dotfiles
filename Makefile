all: help

help:
	@echo ""
	@echo "-- Help Menu"
	@echo ""
	@echo "   1. make bootstrap        - bootsrap your dev machine"
	@echo "   2. make link             - link all dotfiles"
	@echo "   3. make brew             - install brew packages"
	@echo "   4. make cask             - install cask packages"
	@echo "   5. make install_all      - run all installer scripts"
	@echo "   6. make zshplugins       - install zsh plugins"

bootstrap:
	./bootstrap.sh

link:
	./setup.sh link

macos:
	./setup.sh macos

brew:
	./homebrew/brew.sh

cask:
	./homebrew/brew-cask.sh

install_all:
	./setup.sh install_all

zshplugins:
	./setup.sh zshplugins
