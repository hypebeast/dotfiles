function ggp -d "Git push to origin"
    if test (count $argv) -le 1
        if test (count $argv) -eq 0
            set -l branch (git_current_branch)
        else
            set -l branch $argv[1]
        end

        git push -u origin $branch
    else
        git push origin $argv
    end
end

