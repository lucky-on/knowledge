#!/usr/bin/env bash

# Copy git hook to add ChangeID automatically.
scp -P 29418 gerrit-blizzard.aka.amazon.com:hooks/commit-msg .git/hooks/

export GIT_AUTHOR_NAME="Sergey Didenko" && export GIT_COMMITTER_NAME="Sergey Didenko" && export GIT_AUTHOR_EMAIL=reset --soft HEAD~2
    git commit

# another way of merging seveal last commits in one

    # Reset the current branch to the commit just before the last 12:
    git reset --hard HEAD~12

    # HEAD@{1} is where the branch was just before the previous command.
    # This command sets the state of the index to be as it would just
    # after a merge from that commit:
    git merge --squash HEAD@{1}

    # Commit those squashed changes.  The commit message will be helpfully
    # prepopulated with the commit messages of all the squashed commits:
    git commit

# rebase your change on tag
git rebase -i e4f18a4 - commit with latest tag
 pick the commit to rebase
git rebase sdk-1.6.84 - tag name
 push changes from HEAD to master (no matter which branch you are)
git push origin HEAD:refs/for/master
# after you go +2
git push origin BRANCH

# How to revert a faulty merge (link from Adam)
https://www.kernel.org/pub/software/scm/git/docs/howto/revert-a-faulty-merge.txt

# find-replace
on Linux: git grep -l 'original_text' | xargs sed -i 's/original_text/new_text/g'
on   Mac: git grep -l 'original_text' | xargs sed -i '' -e 's/original_text/new_text/g'

# pull from origin/master ignoring local commits
git fetch --all; git reset --hard origin/master; git pull

# git grep in files by pattern
git grep isf_dnn -- '*.c'

# move tag
git tag -a sdk-1.6.90 10312eb --force -m 'IVONA SDK 1.6.90' # move tag to commit 10312eb
git push origin :sdk-1.6.90 # remove tag from remote
git push --dry-run origin sdk-1.6.90
git push origin sdk-1.6.90

# push to branch
- create branch from web interface
- create local branch
- commit change
git push origin HEAD:refs/for/[new branch]
# after you go +2
git push origin BRANCH

--- CR ----

1. make commit
2. run "post-review" command
3. go to your review by link
4. add reviewers
5. Publish


git shortlog --summary | sort

# get current branch name

git rev-parse --abbrev-ref HEAD

# compare file between branches

git diff branch1..brach2 FILE_PATH

# list files in commit
git diff-tree --name-only -r HEAD

# remove file from commit (added by mistake)
git reset --soft HEAD^
git reset HEAD path/to/unwanted_file
git commit -c ORIG_HEAD #use original commit message


Initial version of client-facing APIs for (Pipe and PipeBuilder and their implementations)


# bring changes form another BRANCH wihtout commiting them
git merge --no-commit --squash BRANCH

git reset --soft HEAD^
git commit --amend

# get list of people touched the file
git shortlog -n -s --since=2017-01-01 --before=2018-01-01 -- FILE

======================

HowTo - Git + Beyong Compare

Diff
git config --global diff.tool bc3
To launch a diff using Beyond Compare, use the command:  git difftool file.ext

Merge
git config --global merge.tool bc3
git config --global mergetool.bc3 trustExitCode true
To launch a 3-way merge using Beyond Compare, use the command:
git mergetool file.ext

======================

git log —oneline
git log --oneline --graph —decorate
git log —stat
git log -p -- src/render.cpp

# backup the files you want to keep from your working space
git status
git clean -fdx

Would be helpful to read - https://git-scm.com/book/en/v2/Git-Basics-Getting-a-Git-Repository

//^ - second commit
//^^ next one - third commit

======================

git config --global alias.f "fetch origin"
git config --global alias.pm "fetch origin mainline"
git config --global alias.p "fetch origin"
git config --global alias.fall "fetch --all"
git config --global alias.reset-mainline "reset --hard origin/mainline"


git config --global alias.au 'add -u'
git config --global alias.br 'branch'
git config --global alias.ci-a 'commit --amend'
git config --global alias.ci 'commit'
git config --global alias.co 'checkout'
git config --global alias.cp 'cherry-pick'
git config --global alias.cpa 'cherry-pick --abort'
git config --global alias.cpc 'cherry-pick --continue'
git config --global alias.dag 'log --graph --format="format:%C(yellow)%h%C(reset) %C(blue)'%an' <%ae>%C(reset) %C(magenta)%cr%C(reset)%C(auto)%d%C(reset)%n%s" --date-order'
git config --global alias.ignored '!git ls-files -v | grep ^[[:lower:]]'
git config --global alias.la '!git config -l | grep alias | cut -c 7-'
git config --global alias.last 'log -1 HEAD'
git config --global alias.ll 'log --pretty=format:"%C(yellow)%h%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate --numstat'
git config --global alias.ls 'log --pretty=format:"%C(yellow)%h%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate'
git config --global alias.r 'rebase'
git config --global alias.ra 'rebase --abort'
git config --global alias.rc 'rebase --continue'
git config --global alias.ri 'rebase -i'
git config --global alias.rs 'rebase --skip'
git config --global alias.st 'status'
git config --global alias.unstage 'reset HEAD --'
git config --global alias.ask 'grep -C 3 --show-function --perl-regexp --break --heading --line-number'
git config --global alias.uncomit = 'reset --soft HEAD^'
git config --global alias.commit_back 'commit -c ORIG_HEAD'

========================
# stash with comment
git stash save “Your stash message”

# stash including untracked files
git stash save -u
or
git stash save --include-untracked

git stash list

git stash apply stash@{1}

git stash pop stash@{1}

# show full diff
git stash show -p
git stash show stash@{1}

# create branch out of stash (This command creates a new branch with the latest stash, and then deletes the latest stash ( like stash pop).)
git stash branch <name>
or
git stash branch <name> stash@{1}

# clear shtash
git stash clear

# delete latest stash
git stash drop
or
git stash drop stash@{1}
