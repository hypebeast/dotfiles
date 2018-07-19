###########################################################
### cnotes
###
### Command line tool to work with a git based wiki.
###########################################################

CNOTES_WIKI_DIR=${CNOTES_WIKI_DIR:-}
CNOTES_EDITOR=${EDITOR:-vim}

# cnotes-new creates a new note and saves it.
function cnotes-new() {
    local cmd="command find -L ${CNOTES_WIKI_DIR} -mindepth 1 \\( -path '*/\\.*' -o -fstype 'sysfs' -o -fstype 'devfs' -o -fstype 'devtmpfs' -o -fstype 'proc' \\) -prune \
        -o -type d -print 2> /dev/null"

	local dir="$(eval "$cmd" | FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} --reverse $FZF_DEFAULT_OPTS $FZF_ALT_C_OPTS" fzf-tmux +m)"

	echo "Selected folder \"${dir}\"\n"

	read "file?Enter title for new note: "

	file=${dir}/${file}

	if [[ -z ${file} ]]
	then
		touch ${file}
	fi

	${CNOTES_EDITOR} "${file}"
}

function cnotes-open() {

}

function cnotes-search() {

}
