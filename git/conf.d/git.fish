#!/usr/bin/env fish

abbr -a g git
abbr -a gf 'git fetch'
abbr -a gs 'git status -sb'
abbr -a gm 'git pull --ff-only'
abbr -a gl 'git pull --prune'
abbr -a gr 'git rb FETCH_HEAD'
abbr -a glg "git log --graph --decorate --oneline --abbrev-commit"
abbr -a glga "git log --graph --decorate --oneline --abbrev-commit --all"
abbr -a gp 'git push origin HEAD'
abbr -a gpa 'git push origin --all'
abbr -a gpl 'git pull'
abbr -a gd 'git diff'
abbr -a gc 'git commit -s'
abbr -a gca 'git commit -sa'
abbr -a gco 'git checkout'
abbr -a gnb 'git checkout -b'
abbr -a gb 'git branch -v'
abbr -a gbr 'git branch -r'
abbr -a ga 'git add'
abbr -a gaa 'git add -A'
abbr -a gau 'git add -u'
abbr -a gcm 'git commit -sm'
abbr -a gcam 'git commit -sam'
abbr -a grv 'git remote -v'
abbr -a glnext 'git log --oneline (git describe --tags --abbrev=0 @^)..@'
abbr -a gw 'git switch'
abbr -a gm 'git switch (git main-branch)'
abbr -a gms 'git switch (git main-branch); and git sync'
abbr -a egms 'e; git switch (git main-branch); and git sync'
abbr -a gwc 'git switch -c'

