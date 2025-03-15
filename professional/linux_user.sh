#!/usr/bin/env bash

#To list all local users you can use:
cut -d: -f1 /etc/passwd

#To list all users capable of authenticating (in some way), including non-local, see this reply: https://askubuntu.com/a/414561/571941

#Some more useful user-management commands (also limited to local users):

#To add a new user you can use:
sudo adduser new_username

#or:
sudo useradd new_username

#See also: What is the difference between adduser and useradd?

#To remove/delete a user, first you can use:
sudo userdel username

#Then you may want to delete the home directory for the deleted user account :
sudo rm -r /home/username

#(Please use with caution the above command!)

#To modify the username of a user:
usermod -l new_username old_username

#To change the password for a user:
sudo passwd username

#To change the shell for a user:
sudo chsh username

#To change the details for a user (for example real name):
sudo chfn username

#And, of course, see also: man adduser, man useradd, man userdel... and so on.

#Give sudo access to user
sudo usermod -a -G sudo user

# get list of sudo users
grep -Po '^sudo.+:\K.*$' /etc/group
grep '^sudo:.*$' /etc/group | cut -d: -f4
getent group sudo | cut -d: -f4

# get list of groups of user
getent group |  grep user

# list all users and the groups they are members of:
getent passwd | cut -d : -f 1 | xargs groups

# who could have root access.
less /etc/sudoers
