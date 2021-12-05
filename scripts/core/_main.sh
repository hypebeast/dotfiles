#!/usr/bin/env bash

####
## Based on CodelyTV/dotfiles
####

# Exit on error. Append "|| true" if you expect an error.
set -o errexit
# Exit on error inside any functions or subshells.
set -o errtrace
# Do not allow use of undefined vars. Use ${VAR:-} to use an undefined VAR
set -o nounset
# Catch the error in case mysqldump fails (but gzip succeeds) in `mysqldump |gzip`
set -o pipefail

if ! ${DOT_MAIN_SOURCED:-false}; then
  source "$DOTFILES/scripts/core/utils.sh"
  source "$DOTFILES/scripts/core/log.sh"

  readonly DOT_MAIN_SOURCED=true
fi