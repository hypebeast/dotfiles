default: link

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

installers:
	./setup.sh run_installers
