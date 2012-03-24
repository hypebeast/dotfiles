#######################################
# Functions
# Last edit: 2012.03.24
#######################################


# (f)ind by (n)ame
# usage: fn foo 
# to find all files containing 'foo' in the name
function fn() { ls **/*$1* }
