#!/usr/bin/env bash

getconf -a | grep CACHE

# dump list of symbols library exports
objdump –TC libpryon.so (Same as) nm -D libpryon.so


# find-replace
on Linux: git grep -l 'original_text' | xargs sed -i 's/original_text/new_text/g'
on   Mac: git grep -l 'original_text' | xargs sed -i '' -e 's/original_text/new_text/g'

