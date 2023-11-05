#!/usr/bin/env fish

if test -e "~/.config/nvim"
  and test -e "~/.config/nvim.bak"
  echo "LazyVim installation is canceld, because there is already an backup folder for the nvim config."
  exit
end

if test -e "~/.config/nvim"
  mv ~/.config/nvim{,.bak}
end

git clone https://github.com/LazyVim/starter ~/.config/nvim