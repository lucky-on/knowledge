#!/usr/bin/env bash

# Check the speed of CPU cores
grep -E '^model name|^cpu MHz' /proc/cpuinfo

# get list of installed compilers
dpkg --list | grep compiler

# get list of compilers available to install
apt-cache search Compiler | grep -i --color C++

# get list of installed libs
/sbin/ldconfig -p | grep blas

dpkg -l | grep blas

# search for function name in *.a
nm libatlas.a --demangle or -C | grep 'T ATL_dsyrk'

#
vim ~/.ssh/config

#list available disks
lsblk

# Enable Scroll Up/Down keys on Microsoft Keyboard
## 1) edit file
sudo vim /etc/udev/hwdb.d/70-keyboard.hwdb

## 2) put content
# Microsoft Natural Ergonomic Keyboard 4000 - remap zoom in/out to page up/down
keyboard:usb:v045Ep00DB*
 KEYBOARD_KEY_c022d=pageup
 KEYBOARD_KEY_c022e=pagedown

## 3) run
sudo udevadm hwdb --update
sudo udevadm control --reload

##4) unplug and plug keyboard again

# install python libs
# #python 3
sudo pip3 install 'lib_name' // for instance msgpack-python
# #python - default
sudo pip install 'lib_name' // for instance msgpack-python

# get file/folder size
for each in $(ls) ; do du -hs "$each" ; done

# rename files
ls | while read entry; do mv "$entry" `echo $entry | sed -e "s/replace_this/with_this/g"`; done

# go over folders in current directory and tar them
find . -type d -exec bash -c "tar cvzf {}.tar.gz {}" \;

# get path from full name
full_path_without_filename=${path%/*}

# get file name from path
file_name=${path##*/}

# replace slashes with dashes
$ new_var=$(echo $orig_var | sed -e 's/\//-/g')

#get file name from path for each line in text file
for each in $(cat list.txt) ; do echo "${each##*/}" ; done

# gtar them all
for each in $(cat list.txt) ; do echo "gtar cvzf "${each##*/}".tar.gz $each"; done

for i in {1..10}  ; do

# find file by pattern and push them to S3
find lib -name *.tar.gz -exec bash -c "brazil-build-tool-exec s3-safe-upload {}" \;

ls *waittime* | while read entry; do cat $entry | awk {'print($2)'} > table-$entry; done

# find all files "data.wav" in nested fodlers and move them to root with "full-path-as-name"
#/bin/bash
for file in $(find DCT:1.0 -name data.wav); do
   file_name=$(echo $file | sed -e 's/\//-/g')
   file_name=$(echo $file_name | sed -e 's/-data//g')
   cp $file $file_name
done

# find all executables and show all information
find . -executable -type f -exec ls -lh {} \;

# find "text2" in files that include "text1"
for each in $(grep -Irl "text1" .); do echo; echo $each; grep "text2" --color=always $each; done

# create symbol links with the same names to files found in some folder
find "./fst" -name "*.so" -print0 | xargs -0 -i% ln -f -s %

# compare files like in git
diff -burp file1 file2 | vim -R -

#tmux
tmux set-option -g history-limit 15000 \; new -s new_name

for p in $(cat ~/dev-shared/arnold_packages_sid.txt) ; do arnold ws add --from-package "${p}" ; done
