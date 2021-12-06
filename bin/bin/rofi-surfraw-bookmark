#!/bin/bash

BOOKMARKS_FILE=~/.config/surfraw/bookmarks


function main () {
	bookmarks=$(cat ${BOOKMARKS_FILE} | sed '/^$/d' | sed '/^#/d' | sed '/^\//d')
	bookmarks=$(echo -e "$bookmarks" | awk -F' ' '{$1=substr($1, 0, 49); $1=sprintf("%-55s", $1);print}' | sort)

	link=$(echo -e "${bookmarks}" | rofi -fullscreen -padding 200 -dmenu -mesg ">>> Edit to add new bookmarks at ~/.config/surfraw/bookmarks" -columns 1 -i -p "bookmarks:" | awk -F' ' '{print $2}')

	xdg-open "${link}"
}

main
