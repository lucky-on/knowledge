# Explore the code and changes
git config --global alias.dag 'log --graph --format="format:%C(yellow)%h%C(reset) %C(blue)'%an' <%ae>%C(reset) %C(magenta)%cr%C(reset)%C(auto)%d%C(reset)%n%s" --date-order'
git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --"
git config --global alias.ignored '!git ls-files -v | grep ^[[:lower:]]'
git config --global alias.la '!git config -l | grep alias | cut -c 7-'
git config --global alias.last 'log -1 HEAD'
git config --global alias.ll 'log --pretty=format:"%C(yellow)%h%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate --numstat'  # List files for each commit with some statistics
git config --global alias.ls 'log --pretty=format:"%C(yellow)%h%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate' # List commits in format "SHA COMMIT_MESSAGE AUTHOR"
git config --global alias.lf 'diff-tree --name-only -r'  # List files in commit (usage: git lf HEAD/SHA)
 
git config --global alias.d 'diff'
git config --global alias.dc 'diff --cached'
 
 
git config --global alias.file-history 'log --follow -p --'
 
# Search through the code (analog of 'git grep'), inspired by https://beyondgrep.com/ (original author @mkiedrow)
git config --global alias.ask 'grep -C 3 --show-function --perl-regexp --break --heading --line-number'
 
# Status
git config --global alias.s 'status'
 
# Branch
git config --global alias.b 'branch'
 
# Stage modified tracked-only files. Useful when you have some new files in repository that you don’t .gitignore and don’t want to commit either. (thanks to @chmielar)
git config --global alias.au 'add -u'
 
# Cherry-pick
git config --global alias.cp 'cherry-pick'
git config --global alias.cpa 'cherry-pick --abort'
git config --global alias.cpc 'cherry-pick --continue'
 
# Commit
git config --global alias.c 'commit'
git config --global alias.ca 'commit --amend'
# Rebase
git config --global alias.r 'rebase'
git config --global alias.ra 'rebase --abort'
git config --global alias.rc 'rebase --continue'
git config --global alias.ri 'rebase -i'
git config --global alias.rs 'rebase --skip'
 
# Undo
git config --global alias.co 'checkout'
git config --global alias.unstage 'reset HEAD --'
 
 
# Redo
git config --global alias.uc 'reset --soft HEAD^' # undo last commit, move files to staged area
git config --global alias.cb 'commit -c ORIG_HEAD' # commit back changes with original commit message