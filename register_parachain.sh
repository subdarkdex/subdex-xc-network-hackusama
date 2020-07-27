#!/usr/bin/env bash

set -ex


ddex_cumulus/target/release/generic-parachain export-genesis-state gs

# parachain ID 
# path to the wasm file
# genesis state goes here
polkadot-js-api \
    --ws ws://127.0.0.1:9944 \
    --sudo \
    --seed "//Alice" \
    tx.registrar.registerPara \
        100 \
        '{"scheduling":"Always"}' \
        @./ddex_cumulus/target/release/wbuild/generic-parachain-runtime/generic_parachain_runtime.compact.wasm \
        "$(cat gs)"

