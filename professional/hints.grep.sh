#!/bin/bash

# 7 Linux Grep OR, Grep AND, Grep NOT Operator

# Grep OR Using \|
grep 'pattern1\|pattern2' filename

# Grep OR Using -E
grep -E 'pattern1|pattern2' filename

# Grep OR Using egrep
egrep 'pattern1|pattern2' filename

#Grep OR Using grep -e
grep -e pattern1 -e pattern2 filename

# Grep AND using -E ‘pattern1.*pattern2’
grep -E 'pattern1.*pattern2' filename
grep -E 'pattern1.*pattern2|pattern2.*pattern1' filename

# Grep AND using Multiple grep command
grep -E 'pattern1' filename | grep -E 'pattern2'

# Grep reverse (does not include pattern)
grep -v 'pattern1' filename

#grep text in files
grep --exclude=*.{so,a} -rnw 'path' -e 'text to search'
grep --include=*.{h,c,cpp,cc,hpp} -rnw 'path' -e 'text to search'

# -strip all blank lines and comments
grep -E "^#|^$"

# find all files which contain text
grep -iRl "text" .

# Find and replace text for all files recursevily
grep -rli 'old-word' * | xargs -i@ sed -i 's/old-word/new-word/g' @

# grep last word in search results
git grep SEARCH_FOR | awk 'NF{ print $NF }' | sort | uniq

# grep all modified and new files in git
git status | grep -E '(modified|new file):' | awk 'NF{ print $NF }'

for each in $(find . -name Config -type f) ; do echo $each; grep 'PryonNode' $each; done
