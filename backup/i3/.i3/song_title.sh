#!/usr/bin/env bash

STATUS=$(playerctl status)
if [[ "$STATUS" == 'Playing' ]]; then
  ARTIST=$(playerctl metadata artist)
  TITLE=$(playerctl metadata title)
  echo "𝅘𝅥𝅮 $ARTIST - $TITLE"
fi

# vim: ft=sh
