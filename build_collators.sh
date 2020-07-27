#!/usr/bin/env bash

set -ex

# Clone cumulus
DIRECTORY='ddex_cumulus'
if [ ! -d "$DIRECTORY" ]; then
    git clone https://github.com/subdarkdex/subdarkdex_cumulus.git ddex_cumulus
fi

# build generic parachain
cd ddex_cumulus
git checkout generic-parachain
cargo build --release -p generic-parachain-collator
