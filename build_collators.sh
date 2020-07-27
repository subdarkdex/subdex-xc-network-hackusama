#!/usr/bin/env bash

set -ex

# Clone cumulus
DIRECTORY='generic-parachain'
if [ ! -d "$DIRECTORY" ]; then
    git clone https://github.com/subdarkdex/subdarkdex_cumulus.git generic-parachain
fi

# build generic parachain
cd generic-parachain
git checkout generic-parachain
cargo build --release -p generic-parachain-collator
cd ..

DIRECTORY='dex-parachain'
if [ ! -d "$DIRECTORY" ]; then
    cp -r generic-parachain dex-parachain
fi
cd dex-parachain
rm -rf target/release/wbuild*
rm -rf target/release/generic-parachain*
git checkout dex_chain
cargo build --release -p dex-chain-collator
