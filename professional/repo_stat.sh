#git repo statistics, by sourse code, languages, comments
cloc .

# one more, including file sizes
sloccount .

# unique contributors
git rev-list --all --count

#number of commits per contributor
git log --since=2009-01-01 --until=2020-01-01 --format='%aE' | cut -d@ -f1 | sort | uniq -c | sort | awk '{print $1}' | uniq -c
In total by 2019.02 there are 145 unique contributors, 72 of them did less then 10 commits, 24 - 1 commit, 11 - 2 commits, 8 - 3 commits and so on.

# get commit number for YEAR
git rev-list --all --count --since=YEAR-01-01 --before=YEAR-12-31

# get number of unique contributors
git log --since=YEAR-01-01 --until=YEAR-12-31 --format='%aE' | cut -d@ -f1 | sort | uniq | wc -l
