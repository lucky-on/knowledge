#!/usr/bin/env bash
tmux set-option -g history-limit 15000 \; new -s modularization
brazil ws --create --root pryon_modularization  --versionset Pryon/Pipe-mini-live
cd pryon_modularization
for each in $(cat packages.txt) ; do brazil ws --use -p $each ; done
