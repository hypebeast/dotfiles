######
# Functions to work with https://github.com/xwmx/nb
#
# Last Modified: 2021-11-16
######

nb-list() {
  nb list -t note --no-color | grep -E '^\[[0-9]+\]' | sed -r 's/\[//' | sed -r 's/\]//' | fzf --height 50% --preview "nb show -p {1} | head -n 200 | bat -l md" --preview-window=right:70% | cut -d$' ' -f1
}

nb-edit() {
  local note_id

  note_id=$(nb list -t note --no-color | grep -E '^\[[0-9]+\]' | sed -r 's/\[//' | sed -r 's/\]//' | fzf --height 50% --preview "nb show -p {1} | head -n 200 | bat -l md" --preview-window=right:70% | cut -d$' ' -f1)

  nb edit ${note_id}
}
