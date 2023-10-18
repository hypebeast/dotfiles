#!/usr/bin/env bash

####
## Based on CodelyTV/dotfiles and denisidoro/dotfiles
####

# auto parse the header above, See: docopt_get_help_string
#source "${DOTFILES}/scripts/core/utils/docopts.sh" --auto "$@"

extract_help() {
  local -r file="$1"
  grep "^##?" "$file" | cut -c 5-
}

extract_version() {
  local -r file="$1"
  grep "^#?"  "$file" | cut -c 4-
}

# _compose_version() {
#   local -r file="$1"
#   local -r version_code=$(grep "^#??" "$file" | cut -c 5- || echo "unversioned")
#   local -r git_info=$(cd "$(dirname "$file")" && git log -n 1 --pretty=format:'%h%n%ad%n%an%n%s' --date=format:'%Y-%m-%d %Hh%M' -- "$(basename "$file")")
#   echo -e "${version_code}\n${git_info}"
# }

docs::eval() {
  local -r file="$0"
  local -r help="$(extract_help "$file")"
  local -r version="$(extract_version "$file")"

  if [[ ${1:-} == "--version" ]]; then
    eval "$(docopts -h "${help}" -V "${version}" : "${@:1}")"
  else
    eval "$(docopts -h "${help}" : "${@:1}")"
  fi
}

docs::eval_help() {
  local -r file="$0"

  case "${!#:-}" in
     -h|--help) extract_help "$file"; exit 0 ;;
     --version) extract_version "$file"; exit 0 ;;
  esac
}

# docs::eval_zsh() {
#   local -r file=$1

#   case "${2:-}" in
#   -h | --help)
#     extract_help "$file"
#     exit 0
#     ;;
#   --version)
#     extract_version "$file"
#     exit 0
#     ;;
#   esac
# }

# docs::eval_help_first_arg() {
#   local -r file="$0"

#   case "${1:-}" in
#   -h | --help)
#     extract_help "$file"
#     exit 0
#     ;;
#   --version)
#     extract_version "$file"
#     exit 0
#     ;;
#   esac
# }