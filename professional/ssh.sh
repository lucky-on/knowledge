#!/usr/bin/env bash

# scp after proken connection
rsync --partial --progress --rsh=ssh FILE_TO_COPY HOSTNAME:PATH_TO_FILE

