#!/usr/bin/env bash

set -ex

# Clone cumulus
DIRECTORY='generic-parachain'
if [ ! -d "$DIRECTORY" ]; then
    git clone https://github.com/subdarkdex/subdex_parachains.git generic-parachain
fi

# build generic parachain
cd generic-parachain
git checkout generic-parachain
git pull origin generic-parachain
cargo build --release
cd ..

DIRECTORY='dex-parachain'
if [ ! -d "$DIRECTORY" ]; then
    cp -r generic-parachain subdex-parachain
fi
cd dex-parachain
rm -rf target/release/wbuild*
rm -rf target/release/generic-parachain*
git reset HEAD
git checkout subdex
git pull origin subdex
cargo build --release
