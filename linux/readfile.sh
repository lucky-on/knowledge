#!/usr/bin/env bash

filename="file.txt"
N=1
while IFS= read -r line
do
    if [ $N -eq 10 ]
    then
        echo $line
        exit
    fi

    N=$(($N+1))
done <"$filename"
