#!/usr/bin/env bash

getconf -a | grep CACHE

# dump list of symbols library exports
objdump –TC libpryon.so (Same as) nm -D libpryon.so
