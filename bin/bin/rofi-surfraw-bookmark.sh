#!/bin/bash

HELP_MSG=">>> Edit to add new bookmarks at ~/.config/surfraw/bookmarks"
LAUNCHER="rofi -fullscreen -padding 200 -dmenu -mesg $HELP_MSG -columns 1 -i -p bookmarks: "
BOOKMARKS_FILE=~/.config/surfraw/bookmarks

cleaned_bookmarks=$(cat ${BOOKMARKS_FILE} | sed '/^$/d' | sed '/^#/d' | sed '/^\//d')

bookmarks=$(echo -e "$cleaned_bookmarks" | awk -F' ' '{$1=substr($1, 0, 49); $1=sprintf("%-55s", $1);print}' | sort)

surfraw "$(echo -e "${bookmarks}" | ${LAUNCHER} | awk -F' ' '{print $2}')"
