#!/usr/bin/env bash
#1. Create tar-ball
    tar -cvf *.tar myFolderFile
#2. Create tar.gz / tgz Archive File
    tar cvzf *.tar.gz/*.tgz myFolderFile
#3. Create tar.bz2 Archive File
    tar cvjf Phpfiles-org.tar.bz2 (tbz, tb2) myFolderFile

#4. List Content of tar Archive File
    tar -tvf uploadprogress.tar (*.tar.gz, *.tar.bz2)
    tar -tvf staging.tecmint.com.tar.gz

#5. Untar tar Archive File
    tar -xvf public_html-14-09-12.tar (*.tar.gz, *.bz2)
    tar -xvf public_html-14-09-12.tar -C /whereToUntar

#6. Untar Single file from tar File
    tar -xvf cleanfiles.sh.tar cleanfiles.sh
    tar -zxvf tecmintbackup.tar.gz tecmintbackup.xml
    tar -jxvf Phpfiles-org.tar.bz2 home/php/index.php
    tar --extract --file=cleanfiles.sh.tar (*.tar.gz, *.tar.bz2) cleanfiles.sh

#7. Untar Multiple files from tar, tar.gz and tar.bz2 File
#    To extract or untar multiple files from the tar, tar.gz and tar.bz2 archive file. For example the below command will extract “file 1” “file 2” from the archive files.
    tar -xvf tecmint-14-09-12.tar "file 1" "file 2"
    tar -zxvf MyImages-14-09-12.tar.gz "file 1" "file 2"
    tar -jxvf Phpfiles-org.tar.bz2 "file 1" "file 2"

#8. Extract Group of Files using Wildcard
    tar -xvf Phpfiles-org.tar --wildcards '*.fst'
    tar -zxvf Phpfiles-org.tar.gz --wildcards '*.php'
    tar -jxvf Phpfiles-org.tar.bz2 --wildcards '*.php'

#9. Add Files or Directories to tar Archive File
    tar -rvf tecmint-14-09-12.tar (*.tar.gz, *.tar.bz2) myFolderFile

#10. How To Verify tar, tar.gz and tar.bz2 Archive File
    tar tvfW tecmint-14-09-12.tar (*.tar.gz, *.tar.bz2)
