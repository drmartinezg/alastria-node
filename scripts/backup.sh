#!/bin/bash
# Makes a node backup

MESSAGE="Usage: backup keys | full"
if ( [ $# -ne 1 ] ); then
    echo "$MESSAGE"
    exit
fi

CURRENT_DATE=`date +%Y%m%d%H%M%S`


if ( [ "keys" == "$1" ]); then
    echo "Making a backup of your current node keys ..."

    #Backup directory tree
    mkdir ~/blockcheq-keysBackup-$CURRENT_DATE
    mkdir ~/blockcheq-keysBackup-$CURRENT_DATE/data
    mkdir ~/blockcheq-keysBackup-$CURRENT_DATE/data/geth
    mkdir ~/blockcheq-keysBackup-$CURRENT_DATE/data/constellation
    echo "Saving constellation keys ..."
    cp -r ~/blockcheq/data/constellation/keystore ~/blockcheq-keysBackup-$CURRENT_DATE/data/constellation
    echo "Saving node keys ..."
    cp -r ~/blockcheq/data/keystore ~/blockcheq-keysBackup-$CURRENT_DATE/data
    echo "Saving enode ID ..."
    cp ~/blockcheq/data/geth/nodekey ~/blockcheq-keysBackup-$CURRENT_DATE/data/geth/nodekey
fi

if ( [ "full" == "$1" ]); then
    echo "Making a complete backup of your current node..."
    cp -r ~/blockcheq  ~/blockcheq-backup-$CURRENT_DATE
    echo "Cleaning unnecessary files..."
    rm -Rf ~/blockcheq-backup-$CURRENT_DATE/logs/*
    rm -Rf ~/blockcheq-backup-$CURRENT_DATE/data/geth/chainData
    rm -Rf ~/blockcheq-backup-$CURRENT_DATE/data/geth/nodes
    rm ~/blockcheq-backup-$CURRENT_DATE/data/geth/LOCK
    rm ~/blockcheq-backup-$CURRENT_DATE/data/geth/transactions.rpl
    rm ~/blockcheq-backup-$CURRENT_DATE/data/geth.ipc
    rm -Rf ~/blockcheq-backup-$CURRENT_DATE/data/quorum-raft-state
    rm -Rf ~/blockcheq-backup-$CURRENT_DATE/data/raft-snap
    rm -Rf ~/blockcheq-backup-$CURRENT_DATE/data/raft-wal
    rm -Rf ~/blockcheq-backup-$CURRENT_DATE/data/constellation/data
    rm ~/blockcheq-backup-$CURRENT_DATE/data/constellation/constellation.ipc

fi