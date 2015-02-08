####
# JRNL - https://maebert.github.io/jrnl/
#
# Last Update: 02/06/2015
####

# Add entry to default journal
alias j='jrnl'

# Add entry to work journal
alias jw='jrnl work'

# Shows the entries for the current week
function jrnl_week_report () {
 jrnl $1 -from `date -v -Mon +%Y-%m-%d` -until `date -v +Sun +%Y-%m-%d` | tr -d '|'
}
alias jwr=jrnl_week_report

# Calculates the total working hours for the current week
function jrnl_total_week_work_hours () {
 jrnl $1 @workhours -from `date -v -Mon +%Y-%m-%d` -until `date -v +Sun +%Y-%m-%d` | grep -E 'Hours' | sed 's/^| Hours: //' | awk '{total += $1}END{print total}'
}
alias jth=jrnl_total_week_work_hours

# Prints a work hours report for the current week
function jrnl_week_work_hours_report () {
    local from=$(date -v -Mon +%Y-%m-%d)
    local until=$(date -v +Sun +%Y-%m-%d)
    local jrnl="$(jrnl $1 @workhours -from $from -until $until | sed '/^$/d' | sed 's/^| //')"

    python ~/.dotfiles/scripts/jrnl_week_work_hours_report.py $jrnl

}
alias jhr=jrnl_week_work_hours_report
