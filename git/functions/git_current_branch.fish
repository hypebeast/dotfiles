function git_current_branch -d "Shows the current Git branch"
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
end