#!/usr/bin/env fish

# If it's already installed, do nothing
if command -qs fzf
    exit
end

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install