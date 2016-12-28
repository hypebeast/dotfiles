# Dotfiles

My personal dotfiles managed with [stow](https://www.gnu.org/software/stow/).


## Features

  * oh-my-zsh for zsh config.
  * spf13-vim for vim config.
  * Every config file/folder gets linked to its place in the system. No copy of files.
  * Clear structure of config files: every application has its their own folder.
  * Every config file is linked with stow. No other tool is used.
  * Bootstrap script to setup a dev machine with all required packages and tools.
  * Scripts to install required packages with _brew_ and _cask_.
  * Support for macOS and Linux (Ubuntu).


## Setup

First, make sure you have _stow_ installed. Then, clone this repository to `~/dotfiles`.


### Bootstrap your Development Machine

Bootstrap the dotfiles with

  $ make bootstrap

### Link the dotfiles

Link all dotfiles with

  $ make link

If you want to link individual config files you can use stow directly. For example,

  $ stow git

This will link all git config files to your home directory.


## Structure

TODO


## Credits

TODO


## License
