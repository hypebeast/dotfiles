#!/usr/bin/env fish

set -Ux EDITOR nvim
# set -Ux VISUAL $EDITOR

set -Ux DOTFILES ~/.dotfiles
set -Ux PROJECTS ~/Coding

# Set PATH
fish_add_path -a $DOTFILES/bin $HOME/.bin $HOME/.local/bin

# Setup all fish functions
for f in $DOTFILES/*/functions
	if not contains $f $fish_function_path
		set -Up fish_function_path $f
	end
end

# Link all fish configs
for f in $DOTFILES/*/conf.d/*.fish
	ln -sf $f $__fish_config_dir/conf.d/(basename $f)
end

# Link local fish config for local only config, which is not part of the dotfiles repo (e.g. for private things and secrets)
if test -f ~/.localrc.fish
	ln -sf ~/.localrc.fish $__fish_config_dir/conf.d/localrc.fish
end