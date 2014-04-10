#######################################
# Functions
# Last edit: 2012.03.24
#######################################


# (f)ind by (n)ame
# usage: fn foo 
# to find all files containing 'foo' in the name
function fn() { ls **/*$1* }

function fnd() { ls **/*$1*(/) }

# directory LS
function dls() {
 echo `ls -l | grep "^d" | awk '{ print $9 }' | tr -d "/"`
}

# A ecursive, case-insensitive grep that excludes binary files
function dgrep() {
    grep -iR "$@" * | grep -v "Binary"
}

# A recursive, case-insensitive grep that excludes binary files
# and returns only unique filenames
function dfgrep() {
    grep -iR "$@" * | grep -v "Binary" | sed 's/:/ /g' | awk '{ print $1 }' | sort | uniq
}

function psgrep() {
    if [ ! -z $1 ] ; then
        echo "Grepping for processes matching $2..."
        ps aux | grep $1 | grep -v grep
    else
        echo "!! Need name to grep for"
    fi
}

# Kills any process that matches a regexp passed to it
function killit() {
    ps aux | grep -v "grep" | grep "$@" | awk '{print $2}' | xargs sudo kill
}
