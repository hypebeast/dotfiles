function ggl -d "Git pull from origin"
  if test (count $argv) -le 1
    if test (count $argv) -eq 0
      set -l branch (git_current_branch)
    else
      set -l branch $argv[1]
    end

    git pull origin $branch
  else
    git pull origin $argv
  end
end