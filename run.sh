#!/bin/bash

for f in ./networkFiles/keys/*
do
    pub=$(cat ${f}/key.pub)
    break
done

ENCODE_URL=enode://${pub:2}@127.0.0.1:30303
echo ${ENCODE_URL}

# Node1
pushd IBFT-Network/Node-1
besu --data-path=data --genesis-file=../genesis.json --rpc-http-enabled --rpc-http-api=ETH,NET,IBFT --host-allowlist="*" --rpc-http-cors-origins="all" --revert-reason-enabled &
popd

# Node2
pushd IBFT-Network/Node-2
besu --data-path=data --genesis-file=../genesis.json --bootnodes=${ENCODE_URL} --p2p-port=30304 --rpc-http-enabled --rpc-http-api=ETH,NET,IBFT --host-allowlist="*" --rpc-http-cors-origins="all" --rpc-http-port=8546 --revert-reason-enabled &
popd

# Node3
pushd IBFT-Network/Node-3
besu --data-path=data --genesis-file=../genesis.json --bootnodes=${ENCODE_URL} --p2p-port=30305 --rpc-http-enabled --rpc-http-api=ETH,NET,IBFT --host-allowlist="*" --rpc-http-cors-origins="all" --rpc-http-port=8547 --revert-reason-enabled &
popd

# Node4
pushd IBFT-Network/Node-4
besu --data-path=data --genesis-file=../genesis.json --bootnodes=${ENCODE_URL} --p2p-port=30306 --rpc-http-enabled --rpc-http-api=ETH,NET,IBFT --host-allowlist="*" --rpc-http-cors-origins="all" --rpc-http-port=8548 --revert-reason-enabled 
popd