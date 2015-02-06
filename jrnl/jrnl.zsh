####
# JRNL - https://maebert.github.io/jrnl/
#
# Last Update: 02/06/2015
####


##
# Aliases
##

alias jw='jrnl work'


##
# Functions
##

function jrnl_week_report () {
 jrnl $1 -from `date -v -Mon +%Y-%m-%d` -until `date -v +Sun +%Y-%m-%d` | tr -d '|'
}
alias jwr=jrnl_week_report

