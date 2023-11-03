#!/bin/bash

# Inspired from https://www.reddit.com/r/i3wm/comments/a0mgqn/how_can_i_make_my_volume_keys_work_for_both_the/eaisoit/

SINK=$(pactl list short sinks | grep RUNNING | cut -f1)

if [ "$SINK" == "" ]; then
  SINK="0"
fi

if [ "$1" != "M" ]; then
  pactl set-sink-volume "$SINK" "$1"
else
  pactl set-sink-mute "$SINK" toggle
fi
