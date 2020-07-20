#!/usr/bin/env bash

set -ex

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
        "0x000000000000000000000000000000000000000000000000000000000000000000a6239dc05a4013dddbb51d786fdf3153c3ca0f20295adf64e3ad48abb229cbe103170a2e7597b7b7e3d84c05391d139a62b157e78786d8c082f29dcf4c11131400"
