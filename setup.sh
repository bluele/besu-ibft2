#!/bin/bash
besu operator generate-blockchain-config --config-file=ibftConfigFile.json --to=networkFiles --private-key-file-name=key

count=1
for f in ./networkFiles/keys/*
do
    echo $(basename $f) $count
    cp ${f}/{key,key.pub} ./IBFT-Network/Node-${count}/data/
    count=$(expr $count + 1)
done

cp ./networkFiles/genesis.json ./IBFT-Network/
