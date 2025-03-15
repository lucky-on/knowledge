#!/usr/bin/env bash

packages:

apt-cache search string
#  - search for packages

apt-get install [-y] package
#  - installs, [-y] answer Y for all questions

apt-get remove package
#  - remove pacakge, leave config info

apt-get purge package
#  - remove with configuration data

apt-cache show package
#  - info about package

dpkg -l
#  - list installed packages

dpkg -S /path/to/file
#  - shows packages file belongs to

dpkg -L package
#  - list all files in packages

dpkg -i package.deb
#  - installs the package

day-by-day skills:

diff, sdiff, vimdiff
file
strings
grep -i
cut -d' ' (-d:) -f1,5 (columns)
tr 'A' 'B' - translate A to B

job scheduler
cron
crontab (see shortcuts)
crontab file - install new crontab from file
crontab -l - list
crontab -e - edit
crontab -r - remove all jobs

process:
ps -e (everything) -f (full format) -u (user) -p (pid) --forest
pstree

command &,
Ctrl-Z,
fg,
bg,
kill -l
jobs

disks:

mkfs -t TYPE DEVICE
mkfs.ext4 /dev/sdb3
ls -1 /sbin/mkfs*

mkswap /dev/sdb1
swapon
lsblk -f
#  - tree of disks

blkid
#  - UUIDs of disks

less /etc/fstab - to persis mounts between reboots

e2lable /dev/sdb3 opt - labeling a file

users & groups:

/etc/passwd - information about users
/ets/shadow - passwords (only readable by root)
ps -fu USER
newgrp - change to new group
/etc/shells - list of acceptable shells
useradpasswd USER - create/modify user password
/etc/skel - user shell configuration data
userdel [-r] USER - delete user [including account home directory ]
usermod [-c, -g, -G, -s] - modify user, [c]omment, [g]roup, additional [G]roups, [s]hell

network:

hostname -f
host WWW
dig WWW - resolve name
/etc/hosts - local DNS
/etc/nsswitch.conf - Name Service Switch (name lookup table)

ports 1- 1023 well known ports, system, previlige ports (root previlige required to open these ports)
22 - SSH
25 - SMTP
80 - HTTP
143 - IMAP
389 - LDAP
443 - HTTPS
/etc/services
ifconfig -a (or $ ip link)
/etc/sysconfig/network-scripts/ifcfg-*
ifup/ifdown NETWORK_DEVICE

#Network troubleshooting:

traceoute #- resolves DNS names (requires root for better use)
traceoute -n # - uses IP addresses (requires root for better use)
tracepath (-n) # - one line output per hub

netstat #- collect wide rage of network information
-n displays numerical addresses and ports
-i displays a list of network interfaces
-r displays the route table (netstat -rn)
-p displays thr PID and program used
-l displays listening sockets (netstat -nlp)
-t limit the output to TCP information (netstat -ntlp)
-u limit the output to UDP information (netstat -nulp)

tcpdump #- packet sniffing tool (requires root)
(-n (numerical addresses), -A (human readable format), -v, -vvv)

setuid #- Set User ID upon execution
setgid
chmod u+s, u-s, ug+s, ug-s ...
chsh #- change shell

#File integrety checkers: Tripwire, AIDE, OSSEC, Samhain, Package Managers

stickybit #- stick to make sure only onwer/dir owner/root can rename or delete the file
typicly make sence with 777 permissions
chmod o+s, o-t #- set/remove stickybit

!!
!c where c - first letter of the command from the history
!* - all arguments of last command
!$ - last item of the previous command
$? - last command execution code
$# - number of commnad line arguments


