#!/bin/bash

default_search_engine="google"
help_color="#0C73C2"

list_search_engines=$(surfraw -elvi | awk '{if (NR != 1) print "?"$1}')


function main() {
	HELP_MSG="<span color=\"$help_color\">Hit Tab to complete search engine name
Searches without prepended engine use "$default_search_engine"</span>"
	elvi=$(echo -e "${list_search_engines}" | rofi -padding 400 -fullscreen -kb-row-select "Tab" -kb-row-tab "Control+space" -dmenu -mesg "${HELP_MSG}" -i -p "websearch: ")

	if [[ $elvi == "" ]]; then exit 1
	elif [[ $elvi == "?"* ]]; then
		name=$(echo "${elvi}" | awk '{ print $1 }' | cut -c 2-)
		search=$(echo "${elvi}" | awk '{ $1=""; print $0 }' | cut -c 2-)
		surfraw ${name} ${search}
	else
		name="${default_search_engine}"
		search="${elvi}"

		surfraw ${name} ${search}
	fi
}

main
