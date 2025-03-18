#!/usr/bin/env fish

###############################################################################
## This script bootstraps the Fish installation. It's called from the
## install.fish script during the installation process.
###############################################################################

set -Ux EDITOR nvim
# set -Ux VISUAL $EDITOR
set -gx FILE nnn

set -Ux DOTFILES ~/.dotfiles
set -Ux PROJECTS ~/Coding

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

