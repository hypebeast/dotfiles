#! /usr/bin/env sh

# Need: Write script that installs all application packages, like pipx, npm, Visual Studio Code, etc.

# DIR=$(dirname "$0")
# cd "$DIR"

# . ../scripts/functions.sh

# COMMENT=\#*

# sudo -v

# info "Installing Brewfile packages..."
# brew bundle
# success "Finished installing Brewfile packages."

# eval "$(fnm env --use-on-cd)"
# fnm use 16
# success "Switched to Node v16"

# find * -name "*.list" | while read fn; do
#     cmd="${fn%.*}"
#     set -- $cmd
#     info "Installing $1 packages..."
#     while read package; do
#         if [[ $package == $COMMENT ]]; then continue; fi
#         substep_info "Installing $package..."
#         $cmd $package
#     done < "$fn"
#     success "Finished installing $1 packages."
# done