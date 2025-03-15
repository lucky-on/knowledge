# CRUX
## To CR
# Reviews just the latest commit
% cr --parent HEAD^
# Updates a review with this range of commits
% cr -r CR-21354 --range efb4b3e:d6a7800
# Reviews specific commit ranges for two packages
% cr --include "MyService[7f07509:a261b4a],MyServiceModel[HEAD^]"
# Any tree-ish can be used, including branch names for defining ranges
% cr --include "MyService[baseBranch:myBranch]"
# review multiple packages
% cr --include "<Package Name>" --include "<Package Name>" ...
# Alternatively, if you don't like typing "--include" for each Package...
% cr -i "<Package Name>" -i "<Package Name>" ...
# Updates a review with multiple packages
% cr -r CR-12345 -i "MyService[7f07509:a261b4a],MyServiceModel[HEAD^]"
# Reviews just the latest commit and append it to existing CR
% cr -r CR-12345 --parent HEAD^
# If the old CR is deleted/closed and command cr still tries to attach to the old one but fails, use:
% cr --new-review


## To cherry-pick
git fetch ssh://git.amazon.com/pkg/${PACKAGE}/snapshot/${CR_USER}/${TIMESTAMP} head && git cherry-pick FETCH_HEAD

## To checkout
git fetch ssh://git.amazon.com/pkg/${PACKAGE}/snapshot/${CR_USER}/${TIMESTAMP} head && git checkout FETCH_HEAD
