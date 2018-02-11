#!/bin/bash
# Prepare the node for a clean restart

echo "Preparing the node for a clean restart ..."
rm -Rf ~/blockcheq/logs/quorum*
rm -Rf ~/blockcheq/data/geth/chainData
rm -Rf ~/blockcheq/data/geth/nodes
rm ~/blockcheq/data/geth/LOCK
rm ~/blockcheq/data/geth/transactions.rpl
rm ~/blockcheq/data/geth.ipc
rm -Rf ~/blockcheq/data/quorum-raft-state
rm -Rf ~/blockcheq/data/raft-snap
rm -Rf ~/blockcheq/data/raft-wal
rm -Rf ~/blockcheq/data/constellation/data
rm ~/blockcheq/data/constellation/constellation.ipc
