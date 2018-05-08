#!/bin/bash
if [ $# -ne 1 ]; then
    echo $0: usage: ./container_backup.sh containerId
    exit 1
fi 

time=$(date +"%m-%d-%Y-%H:%M:%S")
backupServerUser="backup"
backupServer="backup01.giraf.cs.aau.dk"
name=$(docker inspect -f '{{.Name}}' $1)
backupName="$name.$time"
 
ssh ${backupServerUser}@${backupServer} 'mkdir /srv/backup/images/git'"$name"'';
docker export $1 | ssh ${backupServerUser}@${backupServer} 'cat -> /srv/backup/images/git'"$name"''"$backupName"''
