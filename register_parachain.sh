#!/usr/bin/env bash

set -e

generic-parachain/target/release/generic-parachain-collator export-genesis-state --parachain-id=100 gc_gs
subdex-parachain/target/release/subdex-parachain-collator export-genesis-state --parachain-id=200 dc_gs

polkadot-js-api \
    --ws ws://127.0.0.1:6644 \
    --sudo \
    --seed "//Alice" \
    tx.registrar.registerPara \
        100 \
        '{"scheduling":"Always"}' \
        @./generic-parachain/target/release/wbuild/parachain-runtime/parachain_runtime.compact.wasm \
        "$(cat gc_gs)"

polkadot-js-api \
    --ws ws://127.0.0.1:6644 \
    --sudo \
    --seed "//Alice" \
    tx.registrar.registerPara \
        200 \
        '{"scheduling":"Always"}' \
        @./subdex-parachain/target/release/wbuild/parachain-runtime/parachain_runtime.compact.wasm \
        "$(cat dc_gs)"
