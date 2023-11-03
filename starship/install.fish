#!/usr/bin/env fish

if not command -qs starship
    curl -sS https://starship.rs/install.sh | sh
end

set -Ux STARSHIP_CONFIG $DOTFILES/starship/config.toml
