#!/bin/bash
set -u
set -e

CURRENT_HOST_IP="$(dig +short myip.opendns.com @resolver1.opendns.com 2>/dev/null || curl -s --retry 2 icanhazip.com)"

echo "Optional use for a clean start: start clean"

if ( [ ! $# -ne 1 ] && [ "clean" == "$1" ]); then 
    
    echo "Cleaning your node ..."
    #Backup directory tree
    rm -rf ~/blockcheq/logs/*
    rm -rf ~/blockcheq/data/geth/chainData
    rm -rf ~/blockcheq/data/geth/nodes
    # Optional in case you start with process locked
    # rm ~/blockcheq/data/geth/LOCK
    rm -f ~/blockcheq/data/geth/transactions.rlp
    rm -f ~/blockcheq/data/geth.ipc
    #rm -f ~/blockcheq/data/quorum-raft-state
    #rm -f ~/blockcheq/data/raft-snap
    #rm -f ~/blockcheq/data/raft-wal
    rm -rf ~/blockcheq/data/constellation/data
    rm -f ~/blockcheq/data/constellation/constellation.ipc
    rm -rf ~/blockcheq/data/geth/lightchaindata
    rm -rf ~/blockcheq/data/geth/chaindata
fi

NETID=953575359
mapfile -t IDENTITY <~/blockcheq/data/IDENTITY
GLOBAL_ARGS="--networkid $NETID --identity $IDENTITY --permissioned --rpc --rpcaddr 0.0.0.0 --rpcapi admin,db,eth,debug,miner,net,shh,txpool,personal,web3,quorum,istanbul --rpcport 22000 --port 21000 --istanbul.requesttimeout 30000 "

_TIME=$(date +%Y%m%d%H%M%S)

mapfile -t NODE_TYPE <~/blockcheq/data/NODE_TYPE

if [[ "$NODE_TYPE" == "general" ]]; then
    echo "[*] Starting Constellation node"
    nohup constellation-node ~/blockcheq/data/constellation/constellation.conf 2>> ~/blockcheq/logs/constellation_"${_TIME}".log &
    sleep 20
fi

if [[ ! -f "permissioned-nodes.json" ]]; then
    # Esto es necesario por un bug de Quorum https://github.com/jpmorganchase/quorum/issues/225
    ln -s ~/blockcheq/data/permissioned-nodes.json permissioned-nodes.json
fi

echo "[*] Starting quorum node"
if [[ "$NODE_TYPE" == "general" ]]; then
    PRIVATE_CONFIG=~/blockcheq/data/constellation/constellation.conf nohup geth --datadir ~/blockcheq/data $GLOBAL_ARGS 2>> ~/blockcheq/logs/quorum_"${_TIME}".log &
else
    if [[ "$NODE_TYPE" == "validator" ]]; then
        if [[ "$CURRENT_HOST_IP" == "192.168.1.43" ]]; then
            nohup geth --datadir ~/blockcheq/data $GLOBAL_ARGS --mine --minerthreads 1 --syncmode "full" --unlock 0 --password ~/blockcheq/data/passwords.txt 2>> ~/blockcheq/logs/quorum_"${_TIME}".log &
        else
            nohup geth --datadir ~/blockcheq/data $GLOBAL_ARGS --mine --minerthreads 1 --syncmode "full" 2>> ~/blockcheq/logs/quorum_"${_TIME}".log &
        fi
    fi
fi

if ([ ! $# -ne 1 ] && [ "dockerfile" == "$1" ]); then 
    
    echo "Running your node ..."
    while true; do
        sleep 1000000
    done;
fi

set +u
set +e
