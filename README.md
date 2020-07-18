# DDEX XC network

## Pre-requisits
Docker version 19.03.8, build afacb8b

## Setup for dev

*NOTE:* - we are not using the script provided in cumulus because we want 2 parachains, also, need to be able to build and rebuild the parachain binaries as we experiment. But when we get more familiar / more stable versions of the parachains, we can build a similar script to do all steps. 

Steps required are:-
1. set up relay chain validators
1. set up default cumulus parachain 
1. run paraA and paraB
1. register parachains

For development of parachains:-
1. 


### validators
`docker-compose up` will set up alice and bob

### get parachain repo
```
git clone https://github.com/paritytech/cumulus/tree/https://github.com/paritytech/cumulus cumulus
git checkout 516ad523c1d376262894b396a4e11544548c6708
git reset --hard
git checkout -b ddex
```
TODO our fork and branch https://github.com/subdarkdex/cumulus

### parachain build
In the root of /cumulus

TODO figure out how to get para_id or does it matter?
```
cargo build --release --package cumulus-test-parachain-collator
```

### run the parachains

TODO
<!-- cargo run --release -p cumulus-test-parachain-collator -- \
--base-path paraA -- \
--chain=ddex_raw.json \
--bootnodes=/ip4/127.0.0.1/tcp/30333/p2p/12D3KooWBNfNrYAyjK9G6yXoLDwBHyNFhHxJ874Vf6h9kXdogkNR
--bootnodes=/ip4/127.0.0.1/tcp/30335/p2p/12D3KooWFZqnxrhBSgfd8mFjzetYektSqpwHgHnNq9b2VLTuUMwD -->

<!-- cargo run --release -p cumulus-test-parachain-collator -- \
--base-path paraB -- \
--chain=ddex_raw.json \
--bootnodes=/ip4/127.0.0.1/tcp/30333/p2p/12D3KooWBNfNrYAyjK9G6yXoLDwBHyNFhHxJ874Vf6h9kXdogkNR
--bootnodes=/ip4/127.0.0.1/tcp/30335/p2p/12D3KooWFZqnxrhBSgfd8mFjzetYektSqpwHgHnNq9b2VLTuUMwD -->


## Setup config details
#### Chain specs
The DarkDex chain spec is a duplication of the westend-local chain, you can generate it with the following script. 

```
./target/release/polkadot build-spec --disable-default-bootnode --chain westend-local > westend_local.json

if [[ "$OSTYPE" == "darwin"* ]]; then
	sed -i '' 's/Westend Local Testnet/DarkDex Local Testnet/' westend_local.json
elif [[ "$OSTYPE" == "linux-gnu" ]]; then
	sed -i 's/Westend Local Testnet/DarkDex Local Testnet/' westend_local.json
fi

./target/release/polkadot build-spec --chain=westend_local.json --raw --disable-default-bootnode > ddex_raw.json
```

#### Genesis state of parachains
Currently, there is an issue with getting the genesis state in step 3 of the [instruction](https://github.com/paritytech/cumulus#running-a-collator), discussed in riot. Here are the genesis states used for registration. 

TODO: update genesis states

genesis state parachain
0x000000000000000000000000000000000000000000000000000000000000000000b548c13343eca33ba013648dfb48121
84264e0405e90ee8c80c659ddb60a294103170a2e7597b7b7e3d84c05391d139a62b157e78786d8c082f29dcf4c11131400

