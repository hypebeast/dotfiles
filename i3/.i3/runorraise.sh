#!/bin/bash

###########################################################
# Starts or focus a program with i3
#
# Example: bindsym Control+3 exec runorraise.sh firefox
#
# Sebastian Ruml, <sebastian@sebastianruml.name>
###########################################################


if [[ $# -ne 1 ]]; then
	echo "Usage: ${0} program_name"
	exit 0
fi

prog_name=$1
count=$(ps aux | grep -c ${prog_name})

if [ $count -eq 1 ]; then
    $1
else
    i3-msg "[class=${prog_name}] focus"
fi
