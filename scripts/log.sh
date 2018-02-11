#!/bin/bash
set -u
set -e

_TIME=$(date +%Y%m%d%H%M%S)

echo `lsof -i | grep *:21000 | awk '{print $8 $9 $10}'` >> ~/blockcheq/logs/monitor__"${_TIME}".log
echo `lsof -i | grep *:22000 | awk '{print $8 $9 $10}'` >> ~/blockcheq/logs/monitor__"${_TIME}".log
echo `lsof -i | grep *:9000 | awk '{print $8 $9 $10}'` >> ~/blockcheq/logs/monitor__"${_TIME}".log

echo `geth -exec 'admin.nodeInfo' attach ~/blockcheq/data/geth.ipc` >> ~/blockcheq/logs/monitor__"${_TIME}".log
echo `geth -exec 'admin.peers' attach ~/blockcheq/data/geth.ipc` >> ~/blockcheq/logs/monitor__"${_TIME}".log
echo `geth -exec 'eth.blockNumber' attach ~/blockcheq/data/geth.ipc` >> ~/blockcheq/logs/monitor__"${_TIME}".log
echo `geth -exec 'eth.mining' attach ~/blockcheq/data/geth.ipc` >> ~/blockcheq/logs/monitor__"${_TIME}".log
echo `geth -exec 'eth.syncing' attach ~/blockcheq/data/geth.ipc` >> ~/blockcheq/logs/monitor__"${_TIME}".log
echo `geth -exec 'eth.pendingTransactions' attach ~/blockcheq/data/geth.ipc` >> ~/blockcheq/logs/monitor__"${_TIME}".log
echo `geth -exec 'istanbul.candidates' attach ~/blockcheq/data/geth.ipc` >> ~/blockcheq/logs/monitor__"${_TIME}".log
echo `geth -exec 'istanbul.getValidators()' attach ~/blockcheq/data/geth.ipc` >> ~/blockcheq/logs/monitor__"${_TIME}".log
echo `geth -exec 'net.peerCount' attach ~/blockcheq/data/geth.ipc` >> ~/blockcheq/logs/monitor__"${_TIME}".log
echo `geth -exec 'net.version' attach ~/blockcheq/data/geth.ipc` >> ~/blockcheq/logs/monitor__"${_TIME}".log
echo `geth -exec 'txpool.content' attach ~/blockcheq/data/geth.ipc` >> ~/blockcheq/logs/monitor__"${_TIME}".log

set +u
set +e
