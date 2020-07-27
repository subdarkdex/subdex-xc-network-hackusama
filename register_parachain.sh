#!/usr/bin/env bash

set -ex

generic-parachain/target/release/generic-parachain export-genesis-state --parachain-id=100 gc_gs
dex-parachain/target/release/dex-chain export-genesis-state --parachain-id=200 dc_gs

polkadot-js-api \
    --ws ws://127.0.0.1:9944 \
    --sudo \
    --seed "//Alice" \
    tx.registrar.registerPara \
        100 \
        '{"scheduling":"Always"}' \
        @./generic-parachain/target/release/wbuild/generic-parachain-runtime/generic_parachain_runtime.compact.wasm \
        "$(cat gc_gs)"

polkadot-js-api \
    --ws ws://127.0.0.1:9944 \
    --sudo \
    --seed "//Alice" \
    tx.registrar.registerPara \
        200 \
        '{"scheduling":"Always"}' \
        @./dex-parachain/target/release/wbuild/dex-chain-runtime/dex_chain_runtime.compact.wasm \
        "$(cat dc_gs)"
